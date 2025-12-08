# frozen_string_literal: true

require_relative "../schema_manifest"
require_relative "../schema_manifest_entry"

module Expressir
  module Model
    # Multi-schema global scope with enhanced repository features
    # Focuses on schema management and delegates indexing/validation to specialized classes
    class Repository < ModelElement
      attribute :schemas, Expressir::Model::Declarations::Schema,
                collection: true,
                initialize_empty: true
      attribute :_class, :string, default: -> { send(:name) }

      # Base directory for schema files
      attr_accessor :base_dir

      # Index instances (lazy-loaded)
      attr_reader :entity_index, :type_index, :reference_index

      key_value do
        map "_class", to: :_class, render_default: true
        map "schemas", to: :schemas
      end

      def initialize(*args, base_dir: nil, **kwargs)
        super(*args, **kwargs)
        @base_dir = base_dir
        @entity_index = nil
        @type_index = nil
        @reference_index = nil
      end

      # @return [Array<Declaration>]
      def children
        schemas
      end

      # Build indexes for entities, types, and references
      # @return [void]
      def build_indexes
        @entity_index = Indexes::EntityIndex.new(schemas)
        @type_index = Indexes::TypeIndex.new(schemas)
        @reference_index = Indexes::ReferenceIndex.new(schemas)
      end

      # Find entity by qualified name
      # @param qualified_name [String] Entity qualified name (e.g., "action_schema.action")
      # @return [Declarations::Entity, nil] Found entity or nil
      def find_entity(qualified_name:)
        ensure_indexes_built
        @entity_index.find(qualified_name)
      end

      # Find type by qualified name
      # @param qualified_name [String] Type qualified name
      # @return [Declarations::Type, nil] Found type or nil
      def find_type(qualified_name:)
        ensure_indexes_built
        @type_index.find(qualified_name)
      end

      # List all entities
      # @param schema [String, nil] Filter by schema name
      # @param format [Symbol] Output format (:object, :hash, :json, :yaml)
      # @return [Array] List of entities
      def list_entities(schema: nil, format: :object)
        ensure_indexes_built

        entities = @entity_index.list(schema: schema)

        format_output(entities, format) do |entity|
          { id: entity.id, schema: entity.parent.id, path: entity.path }
        end
      end

      # List all types
      # @param schema [String, nil] Filter by schema name
      # @param category [String, nil] Filter by type category (select, enumeration, etc.)
      # @param format [Symbol] Output format (:object, :hash, :json, :yaml)
      # @return [Array] List of types
      def list_types(schema: nil, category: nil, format: :object)
        ensure_indexes_built

        types = @type_index.list(schema: schema, category: category)

        format_output(types, format) do |type|
          { id: type.id, schema: type.parent.id, path: type.path,
            category: @type_index.categorize(type) }
        end
      end

      # Resolve all references across schemas
      # Uses the existing ResolveReferencesModelVisitor
      # @return [void]
      def resolve_all_references
        visitor = Expressir::Express::ResolveReferencesModelVisitor.new
        visitor.visit(self)
      end

      # Validate repository consistency
      # @param strict [Boolean] Enable strict validation
      # @return [Hash] Validation results with :valid?, :errors, :warnings
      def validate(strict: false)
        ensure_indexes_built
        validator = RepositoryValidator.new(schemas, @reference_index)
        validator.validate(strict: strict)
      end

      # Get statistics
      # @param format [Symbol] Output format (:hash, :json, :yaml)
      # @return [Hash, String] Repository statistics
      def statistics(format: :hash)
        ensure_indexes_built

        stats = {
          total_schemas: schemas.size,
          total_entities: count_entities,
          total_types: count_types,
          total_functions: count_functions,
          total_rules: count_rules,
          total_procedures: count_procedures,
          entities_by_schema: entities_by_schema_counts,
          types_by_category: types_by_category_counts,
          interfaces: interface_counts,
        }

        case format
        when :json
          require "json"
          stats.to_json
        when :yaml
          require "yaml"
          stats.to_yaml
        else
          stats
        end
      end

      # Group schemas by category based on their contents
      # @return [Hash] Hash with category keys and schema arrays
      def schemas_by_category
        {
          with_entities: schemas.select { |s| s.entities&.any? },
          with_types: schemas.select { |s| s.types&.any? },
          with_functions: schemas.select { |s| s.functions&.any? },
          with_rules: schemas.select { |s| s.rules&.any? },
          interface_only: schemas.select do |s|
            s.interfaces&.any? && !s.entities&.any? && !s.types&.any?
          end,
          empty: schemas.select do |s|
            !s.entities&.any? && !s.types&.any? && !s.functions&.any?
          end,
        }
      end

      # Get largest schemas by total element count
      # @param limit [Integer] Maximum number of schemas to return
      # @return [Array<Hash>] Array of hashes with :schema and :total_elements
      def largest_schemas(limit = 10)
        schemas.map do |s|
          {
            schema: s,
            total_elements: count_schema_elements(s),
          }
        end.sort_by { |item| -item[:total_elements] }.take(limit)
      end

      # Calculate schema complexity score
      # Entities=2, Types=1, Functions=3, Procedures=3, Rules=4, Interfaces=2
      # @param schema [Declarations::Schema] Schema to analyze
      # @return [Integer] Complexity score
      def schema_complexity(schema)
        score = 0
        score += (schema.entities&.size || 0) * 2
        score += (schema.types&.size || 0) * 1
        score += (schema.functions&.size || 0) * 3
        score += (schema.procedures&.size || 0) * 3
        score += (schema.rules&.size || 0) * 4
        score += (schema.interfaces&.size || 0) * 2
        score
      end

      # Get schemas sorted by complexity
      # @param limit [Integer] Maximum number of schemas to return
      # @return [Array<Hash>] Array of hashes with :schema and :complexity
      def schemas_by_complexity(limit = 10)
        schemas.map { |s| { schema: s, complexity: schema_complexity(s) } }
          .sort_by { |item| -item[:complexity] }
          .take(limit)
      end

      # Get dependency statistics
      # @return [Hash] Statistics about interface dependencies
      def dependency_statistics
        stats = {
          total_interfaces: 0,
          use_from_count: 0,
          reference_from_count: 0,
          most_referenced: [],
          most_dependent: [],
        }

        reference_counts = Hash.new(0)
        dependency_counts = Hash.new(0)

        schemas.each do |schema|
          next unless schema.interfaces&.any?

          stats[:total_interfaces] += schema.interfaces.size
          dependency_counts[schema.id] = schema.interfaces.size

          schema.interfaces.each do |interface|
            stats[:use_from_count] += 1 if interface.kind == Declarations::Interface::USE
            stats[:reference_from_count] += 1 if interface.kind == Declarations::Interface::REFERENCE
            reference_counts[interface.schema.id] += 1 if interface.schema
          end
        end

        stats[:most_referenced] = reference_counts.sort_by do |_, v|
          -v
        end.take(10).to_h
        stats[:most_dependent] = dependency_counts.sort_by do |_, v|
          -v
        end.take(10).to_h

        stats
      end

      # Generate SchemaManifest from repository
      # @return [SchemaManifest] Manifest describing all schemas
      def to_manifest
        manifest = Expressir::SchemaManifest.new
        schemas.each do |schema|
          manifest.schemas << Expressir::SchemaManifestEntry.new(
            id: schema.id,
            path: schema.file || "#{schema.id}.exp",
          )
        end
        manifest
      end

      # Build repository from list of schema files
      # @param file_paths [Array<String>] Schema file paths
      # @param base_dir [String, nil] Base directory for path resolution
      # @return [Repository] Built repository with all schemas
      def self.from_files(file_paths, base_dir: nil)
        repo = new(base_dir: base_dir)

        file_paths.each do |path|
          parsed = Expressir::Express::Parser.from_file(path)
          parsed&.schemas&.each { |schema| repo.schemas << schema }
        end

        repo.resolve_all_references
        repo
      end

      # Load repository from LER package
      # @param package_path [String] Path to .ler package file
      # @return [Repository] Loaded repository
      def self.from_package(package_path)
        require_relative "../package/reader"
        Package::Reader.load(package_path)
      end

      # Export repository to LER package
      # @param output_path [String] Path for output .ler file
      # @param options [Hash] Package options
      # @option options [String] :name Package name
      # @option options [String] :version Package version
      # @option options [String] :description Package description
      # @option options [String] :express_mode ('include_all') Bundling mode
      # @option options [String] :resolution_mode ('resolved') Resolution mode
      # @option options [String] :serialization_format ('marshal') Serialization format
      # @return [String] Path to created package
      def export_to_package(output_path, options = {})
        require_relative "../package/builder"
        builder = Package::Builder.new
        builder.build(self, output_path, options)
      end

      private

      # Count total elements in schema
      # @param schema [Declarations::Schema] Schema to count elements from
      # @return [Integer] Total count of all elements
      def count_schema_elements(schema)
        (schema.entities&.size || 0) +
          (schema.types&.size || 0) +
          (schema.functions&.size || 0) +
          (schema.procedures&.size || 0) +
          (schema.rules&.size || 0) +
          (schema.constants&.size || 0)
      end

      # Ensure indexes are built before use
      # @return [void]
      def ensure_indexes_built
        build_indexes if @entity_index.nil? || @entity_index.empty?
      end

      # Format output based on requested format
      # @param items [Array] Items to format
      # @param format [Symbol] Output format
      # @yield [item] Block to convert item to hash
      # @return [Array, String] Formatted output
      def format_output(items, format, &block)
        case format
        when :hash
          items.map(&block)
        when :json
          require "json"
          items.map(&block).to_json
        when :yaml
          require "yaml"
          items.map(&block).to_yaml
        else
          items
        end
      end

      # Count entities by schema
      # @return [Hash<String, Integer>] Entity counts per schema
      def entities_by_schema_counts
        counts = {}
        schemas.each do |schema|
          counts[schema.id] = schema.entities&.size || 0
        end
        counts
      end

      # Count types by category
      # @return [Hash<Symbol, Integer>] Type counts per category
      def types_by_category_counts
        counts = {
          select: 0,
          enumeration: 0,
          aggregate: 0,
          defined: 0,
        }

        schemas.each do |schema|
          next unless schema.types

          schema.types.each do |type|
            category = @type_index.categorize(type).to_sym
            counts[category] ||= 0
            counts[category] += 1
          end
        end

        counts
      end

      # Count interfaces by type
      # @return [Hash<Symbol, Integer>] Interface counts
      def interface_counts
        counts = {
          use_from: 0,
          reference_from: 0,
        }

        schemas.each do |schema|
          next unless schema.interfaces

          schema.interfaces.each do |interface|
            if interface.kind == Declarations::Interface::USE
              counts[:use_from] += 1
            elsif interface.kind == Declarations::Interface::REFERENCE
              counts[:reference_from] += 1
            end
          end
        end

        counts
      end

      # Count total entities across all schemas
      # Uses indexes if available, falls back to schemas collection
      # @return [Integer] Total entity count
      def count_entities
        return @entity_index.count if @entity_index && !@entity_index.empty?

        schemas.sum { |schema| schema.entities&.size || 0 }
      end

      # Count total types across all schemas
      # Uses indexes if available, falls back to schemas collection
      # @return [Integer] Total type count
      def count_types
        return @type_index.count if @type_index && !@type_index.empty?

        schemas.sum { |schema| schema.types&.size || 0 }
      end

      # Count total functions across all schemas
      # @return [Integer] Total function count
      def count_functions
        schemas.sum { |schema| schema.functions&.size || 0 }
      end

      # Count total rules across all schemas
      # @return [Integer] Total rule count
      def count_rules
        schemas.sum { |schema| schema.rules&.size || 0 }
      end

      # Count total procedures across all schemas
      # @return [Integer] Total procedure count
      def count_procedures
        schemas.sum { |schema| schema.procedures&.size || 0 }
      end
    end
  end
end
