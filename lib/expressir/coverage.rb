require "pathname"

module Expressir
  # Coverage module for calculating documentation coverage of EXPRESS entities
  module Coverage
    # Mapping of EXPRESS entity type names to their corresponding class names
    ENTITY_TYPE_MAP = {
      "TYPE" => "Expressir::Model::Declarations::Type",
      "ENTITY" => "Expressir::Model::Declarations::Entity",
      "CONSTANT" => "Expressir::Model::Declarations::Constant",
      "FUNCTION" => "Expressir::Model::Declarations::Function",
      "RULE" => "Expressir::Model::Declarations::Rule",
      "PROCEDURE" => "Expressir::Model::Declarations::Procedure",
      "SUBTYPE_CONSTRAINT" => "Expressir::Model::Declarations::SubtypeConstraint",
      "PARAMETER" => "Expressir::Model::Declarations::Parameter",
      "VARIABLE" => "Expressir::Model::Declarations::Variable",
      "ATTRIBUTE" => "Expressir::Model::Declarations::Attribute",
      "DERIVED_ATTRIBUTE" => "Expressir::Model::Declarations::DerivedAttribute",
      "INVERSE_ATTRIBUTE" => "Expressir::Model::Declarations::InverseAttribute",
      "UNIQUE_RULE" => "Expressir::Model::Declarations::UniqueRule",
      "WHERE_RULE" => "Expressir::Model::Declarations::WhereRule",
      "ENUMERATION_ITEM" => "Expressir::Model::DataTypes::EnumerationItem",
      "INTERFACE" => "Expressir::Model::Declarations::Interface",
      "INTERFACE_ITEM" => "Expressir::Model::Declarations::InterfaceItem",
      "INTERFACED_ITEM" => "Expressir::Model::Declarations::InterfacedItem",
      "SCHEMA_VERSION" => "Expressir::Model::Declarations::SchemaVersion",
      "SCHEMA_VERSION_ITEM" => "Expressir::Model::Declarations::SchemaVersionItem",
    }.freeze

    # Mapping of class names to EXPRESS entity type names (for proper formatting)
    CLASS_TO_EXPRESS_TYPE_MAP = {
      "Type" => "TYPE",
      "Entity" => "ENTITY",
      "Constant" => "CONSTANT",
      "Function" => "FUNCTION",
      "Rule" => "RULE",
      "Procedure" => "PROCEDURE",
      "SubtypeConstraint" => "SUBTYPE_CONSTRAINT",
      "Parameter" => "PARAMETER",
      "Variable" => "VARIABLE",
      "Attribute" => "ATTRIBUTE",
      "DerivedAttribute" => "DERIVED_ATTRIBUTE",
      "InverseAttribute" => "INVERSE_ATTRIBUTE",
      "UniqueRule" => "UNIQUE_RULE",
      "WhereRule" => "WHERE_RULE",
      "EnumerationItem" => "ENUMERATION_ITEM",
      "Interface" => "INTERFACE",
      "InterfaceItem" => "INTERFACE_ITEM",
      "InterfacedItem" => "INTERFACED_ITEM",
      "SchemaVersion" => "SCHEMA_VERSION",
      "SchemaVersionItem" => "SCHEMA_VERSION_ITEM",
    }.freeze

    # Available TYPE subtypes based on data types
    TYPE_SUBTYPES = %w[
      AGGREGATE ARRAY BAG BINARY BOOLEAN ENUMERATION GENERIC GENERIC_ENTITY
      INTEGER LIST LOGICAL NUMBER REAL SELECT SET STRING
    ].freeze
    # Represents a documentation coverage report for EXPRESS schemas
    class Report
      attr_reader :repository, :schema_reports, :total_entities, :documented_entities,
                  :undocumented_entities

      # Initialize a coverage report
      # @param repository [Expressir::Model::Repository] The repository to analyze
      # @param skip_types [Array<String>] Array of entity type names to skip from coverage
      def initialize(repository, skip_types = [])
        @repository = repository
        @skip_types = skip_types
        @schema_reports = []
        @total_entities = []
        @documented_entities = []
        @undocumented_entities = []

        process_repository
      end

      # Create a report from a repository
      # @param repository [Expressir::Model::Repository] The repository to analyze
      # @param skip_types [Array<String>] Array of entity type names to skip from coverage
      # @return [Report] The coverage report
      def self.from_repository(repository, skip_types = [])
        new(repository, skip_types)
      end

      # Create a report from a schema file
      # @param path [String] Path to the schema file
      # @param skip_types [Array<String>] Array of entity type names to skip from coverage
      # @return [Report] The coverage report
      def self.from_file(path, skip_types = [])
        repository = Expressir::Express::Parser.from_file(path)
        new(repository, skip_types)
      end

      # Calculate the overall coverage percentage
      # @return [Float] The coverage percentage
      def coverage_percentage
        return 100.0 if @total_entities.empty?

        (@documented_entities.size.to_f / @total_entities.size) * 100
      end

      # Get file-level reports
      # @return [Array<Hash>] Array of file report hashes
      def file_reports
        @schema_reports.map do |report|
          absolute_path = report[:schema].file
          relative_path = begin
            Pathname.new(absolute_path).relative_path_from(Pathname.pwd).to_s
          rescue ArgumentError
            # If paths are on different drives or otherwise incompatible,
            # fall back to the absolute path
            absolute_path
          end

          {
            "file" => relative_path,
            "file_basename" => File.basename(absolute_path),
            "directory" => File.dirname(absolute_path),
            "total" => report[:total].size,
            "documented" => report[:documented].size,
            "undocumented" => report[:undocumented],
            "coverage" => report[:coverage],
          }
        end
      end

      # Get directory-level reports
      # @return [Array<Hash>] Array of directory report hashes
      def directory_reports
        # Group by directory (absolute path)
        by_directory = file_reports.group_by { |r| r["directory"] }

        # Aggregate stats for each directory
        by_directory.map do |directory, reports|
          # Convert directory to relative path
          relative_directory = begin
            Pathname.new(directory).relative_path_from(Pathname.pwd).to_s
          rescue ArgumentError
            # If paths are on different drives or otherwise incompatible,
            # fall back to the absolute path
            directory
          end

          total = reports.sum { |r| r["total"] }
          documented = reports.sum { |r| r["documented"] }
          coverage = total.positive? ? (documented.to_f / total) * 100 : 100.0

          {
            "directory" => relative_directory,
            "total" => total,
            "documented" => documented,
            "undocumented" => total - documented,
            "coverage" => coverage,
            "files" => reports.size,
          }
        end
      end

      # Convert report to a hash representation
      # @return [Hash] The report as a hash
      def to_h
        {
          "overall" => {
            "total" => @total_entities.size,
            "documented" => @documented_entities.size,
            "undocumented" => @undocumented_entities.size,
            "coverage" => coverage_percentage,
          },
          "directories" => directory_reports,
          "files" => file_reports,
        }
      end

      private

      # Process the repository and collect coverage information
      def process_repository
        return unless @repository

        @repository.schemas.each do |schema|
          schema_report = process_schema(schema)
          @schema_reports << schema_report

          @total_entities.concat(schema_report[:total])
          @documented_entities.concat(schema_report[:documented])
          @undocumented_entities.concat(schema_report[:undocumented].map do |entity|
            { schema: schema.id, entity: entity }
          end)
        end
      end

      # Process a schema and collect coverage information
      # @param schema [Expressir::Model::Declarations::Schema] The schema to analyze
      # @return [Hash] A hash with coverage information
      def process_schema(schema)
        entities = Expressir::Coverage.find_entities(schema, @skip_types)
        documented = entities.select { |e| Expressir::Coverage.entity_documented?(e) }
        undocumented = entities - documented

        coverage = entities.empty? ? 100.0 : (documented.size.to_f / entities.size) * 100

        {
          schema: schema,
          total: entities,
          documented: documented,
          undocumented: undocumented.map { |e| format_entity(e) },
          coverage: coverage,
        }
      end

      # Format an entity for display
      # @param entity [Expressir::Model::ModelElement] The entity to format
      # @return [Hash] A hash with type and name of the entity
      def format_entity(entity)
        # Get class name (e.g., "Type" from "Expressir::Model::Declarations::Type")
        type_name = entity.class.name.split("::").last

        # Use proper mapping to EXPRESS convention
        express_type = CLASS_TO_EXPRESS_TYPE_MAP[type_name] || type_name.upcase

        # Return structured format
        {
          "type" => express_type,
          "name" => entity.id.to_s,
        }
      end
    end

    # Check if an entity has documentation (remarks)
    # @param entity [Expressir::Model::ModelElement] The entity to check
    # @return [Boolean] True if the entity has documentation
    def self.entity_documented?(entity)
      # Check for direct remarks
      if entity.respond_to?(:remarks) && entity.remarks && !entity.remarks.empty?
        return true
      end

      # Check for remark_items
      if entity.respond_to?(:remark_items) && entity.remark_items && !entity.remark_items.empty?
        return true
      end

      # For schema entities, check if there's a remark_item with their ID
      if entity.parent.respond_to?(:remark_items) && entity.parent.remark_items
        entity_id = entity.id.to_s.downcase
        entity.parent.remark_items.any? do |item|
          item.id.to_s.downcase == entity_id || item.id.to_s.downcase.include?("#{entity_id}.")
        end
      else
        false
      end
    end

    # Find all entities in a schema or repository
    # @param schema_or_repo [Expressir::Model::Declarations::Schema, Expressir::Model::Repository] The schema or repository to analyze
    # @param skip_types [Array<String>] Array of entity type names to skip from coverage
    # @return [Array<Expressir::Model::ModelElement>] Array of entities
    def self.find_entities(schema_or_repo, skip_types = [])
      entities = []

      # Handle both repository and schema inputs
      if schema_or_repo.is_a?(Expressir::Model::Repository)
        # If it's a repository, process all schemas
        schema_or_repo.schemas.each do |schema|
          entities.concat(find_entities_in_schema(schema))
        end
      else
        # If it's a schema, process it directly
        entities.concat(find_entities_in_schema(schema_or_repo))
      end

      # Filter out any nil elements and ensure all have IDs
      entities = entities.compact.select { |e| e.respond_to?(:id) && e.id }

      # Filter out skipped entity types
      apply_exclusions(entities, skip_types)
    end

    # Find all entities in a single schema
    # @param schema [Expressir::Model::Declarations::Schema] The schema to analyze
    # @return [Array<Expressir::Model::ModelElement>] Array of entities
    def self.find_entities_in_schema(schema)
      entities = []

      # Add all schema-level entities
      entities.concat(schema.constants) if schema.constants
      entities.concat(schema.types) if schema.types
      entities.concat(schema.entities) if schema.entities
      entities.concat(schema.functions) if schema.functions
      entities.concat(schema.rules) if schema.rules
      entities.concat(schema.procedures) if schema.procedures
      entities.concat(schema.subtype_constraints) if schema.subtype_constraints
      entities.concat(schema.interfaces) if schema.interfaces

      # Add nested entities recursively
      entities.concat(find_nested_entities(schema))

      entities
    end

    # Find all nested entities within a container (schema, entity, function, etc.)
    # @param container [Expressir::Model::ModelElement] The container to search
    # @return [Array<Expressir::Model::ModelElement>] Array of nested entities
    def self.find_nested_entities(container)
      entities = []

      # Handle different container types
      case container
      when Expressir::Model::Declarations::Schema
        # Schema-level nested entities
        container.types&.each do |type|
          entities.concat(find_nested_entities(type))
        end
        container.entities&.each do |entity|
          entities.concat(find_nested_entities(entity))
        end
        container.functions&.each do |function|
          entities.concat(find_nested_entities(function))
        end
        container.rules&.each do |rule|
          entities.concat(find_nested_entities(rule))
        end
        container.procedures&.each do |procedure|
          entities.concat(find_nested_entities(procedure))
        end
        container.interfaces&.each do |interface|
          entities.concat(find_nested_entities(interface))
        end

      when Expressir::Model::Declarations::Type
        # Type nested entities
        if container.respond_to?(:enumeration_items) && container.enumeration_items
          entities.concat(container.enumeration_items)
        end

      when Expressir::Model::Declarations::Entity
        # Entity nested entities
        entities.concat(container.attributes) if container.attributes
        entities.concat(container.unique_rules) if container.unique_rules
        entities.concat(container.where_rules) if container.where_rules

      when Expressir::Model::Declarations::Function
        # Function nested entities
        entities.concat(container.parameters) if container.parameters
        entities.concat(container.variables) if container.variables
        entities.concat(container.constants) if container.constants
        entities.concat(container.types) if container.types
        entities.concat(container.entities) if container.entities
        entities.concat(container.functions) if container.functions
        entities.concat(container.procedures) if container.procedures
        entities.concat(container.subtype_constraints) if container.subtype_constraints

        # Recursively find nested entities in nested containers
        container.types&.each { |type| entities.concat(find_nested_entities(type)) }
        container.entities&.each { |entity| entities.concat(find_nested_entities(entity)) }
        container.functions&.each { |function| entities.concat(find_nested_entities(function)) }
        container.procedures&.each { |procedure| entities.concat(find_nested_entities(procedure)) }

      when Expressir::Model::Declarations::Rule
        # Rule nested entities
        entities.concat(container.variables) if container.variables
        entities.concat(container.constants) if container.constants
        entities.concat(container.types) if container.types
        entities.concat(container.entities) if container.entities
        entities.concat(container.functions) if container.functions
        entities.concat(container.procedures) if container.procedures
        entities.concat(container.subtype_constraints) if container.subtype_constraints

        # Recursively find nested entities in nested containers
        container.types&.each { |type| entities.concat(find_nested_entities(type)) }
        container.entities&.each { |entity| entities.concat(find_nested_entities(entity)) }
        container.functions&.each { |function| entities.concat(find_nested_entities(function)) }
        container.procedures&.each { |procedure| entities.concat(find_nested_entities(procedure)) }

      when Expressir::Model::Declarations::Procedure
        # Procedure nested entities
        entities.concat(container.parameters) if container.parameters
        entities.concat(container.variables) if container.variables
        entities.concat(container.constants) if container.constants
        entities.concat(container.types) if container.types
        entities.concat(container.entities) if container.entities
        entities.concat(container.functions) if container.functions
        entities.concat(container.procedures) if container.procedures
        entities.concat(container.subtype_constraints) if container.subtype_constraints

        # Recursively find nested entities in nested containers
        container.types&.each { |type| entities.concat(find_nested_entities(type)) }
        container.entities&.each { |entity| entities.concat(find_nested_entities(entity)) }
        container.functions&.each { |function| entities.concat(find_nested_entities(function)) }
        container.procedures&.each { |procedure| entities.concat(find_nested_entities(procedure)) }

      when Expressir::Model::Declarations::Interface
        # Interface nested entities
        entities.concat(container.items) if container.items
      end

      entities
    end

    # Apply exclusions to filter out entities based on skip_types (supports both simple and TYPE:SUBTYPE syntax)
    # @param entities [Array<Expressir::Model::ModelElement>] The entities to filter
    # @param exclusions [Array<String>] Array of entity type names to exclude from coverage
    # @return [Array<Expressir::Model::ModelElement>] Filtered entities
    def self.apply_exclusions(entities, exclusions)
      filter_skipped_entities(entities, exclusions)
    end

    # Filter out entities based on skip_types (supports both simple and TYPE:SUBTYPE syntax)
    # @param entities [Array<Expressir::Model::ModelElement>] The entities to filter
    # @param skip_types [Array<String>] Array of entity type names to skip from coverage
    # @return [Array<Expressir::Model::ModelElement>] Filtered entities
    def self.filter_skipped_entities(entities, skip_types)
      return entities if skip_types.empty?

      # Parse skip_types into simple types and TYPE subtypes
      simple_skips = []
      type_subtype_skips = []

      skip_types.each do |skip_type|
        if skip_type.include?(":")
          # Handle TYPE:SUBTYPE format
          main_type, subtype = skip_type.split(":", 2)
          if main_type == "TYPE" && TYPE_SUBTYPES.include?(subtype)
            type_subtype_skips << subtype
          end
        else
          # Handle simple type format
          simple_skips << skip_type
        end
      end

      # Filter entities
      entities.reject do |entity|
        entity_class = entity.class.name

        # Check simple type exclusions
        # Convert entity class to EXPRESS type name for comparison
        class_name = entity_class.split("::").last
        express_type = CLASS_TO_EXPRESS_TYPE_MAP[class_name] || class_name.upcase

        if simple_skips.include?(express_type)
          true
        # Check TYPE subtype exclusions
        elsif entity_class == "Expressir::Model::Declarations::Type" && type_subtype_skips.any?
          entity_subtype = get_type_subtype(entity)
          type_subtype_skips.include?(entity_subtype)
        else
          false
        end
      end
    end

    # Get the subtype of a TYPE entity based on its underlying_type
    # @param type_entity [Expressir::Model::Declarations::Type] The TYPE entity
    # @return [String] The subtype name (e.g., "SELECT", "ENUMERATION")
    def self.get_type_subtype(type_entity)
      return nil unless type_entity.respond_to?(:underlying_type) && type_entity.underlying_type

      # Get the class name of the underlying type
      underlying_class = type_entity.underlying_type.class.name

      # Extract the data type name (e.g., "Select" from "Expressir::Model::DataTypes::Select")
      if underlying_class.start_with?("Expressir::Model::DataTypes::")
        data_type_name = underlying_class.split("::").last
        # Convert to uppercase (e.g., "Select" -> "SELECT")
        data_type_name.upcase
      else
        # For other types, try to extract the last part of the class name
        underlying_class.split("::").last&.upcase
      end
    end
  end
end
