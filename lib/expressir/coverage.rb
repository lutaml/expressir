module Expressir
  # Coverage module for calculating documentation coverage of EXPRESS entities
  module Coverage
    # Represents a documentation coverage report for EXPRESS schemas
    class Report
      attr_reader :repository, :schema_reports, :total_entities, :documented_entities,
                  :undocumented_entities

      # Initialize a coverage report
      # @param repository [Expressir::Model::Repository] The repository to analyze
      def initialize(repository)
        @repository = repository
        @schema_reports = []
        @total_entities = []
        @documented_entities = []
        @undocumented_entities = []

        process_repository
      end

      # Create a report from a repository
      # @param repository [Expressir::Model::Repository] The repository to analyze
      # @return [Report] The coverage report
      def self.from_repository(repository)
        new(repository)
      end

      # Create a report from a schema file
      # @param path [String] Path to the schema file
      # @return [Report] The coverage report
      def self.from_file(path)
        repository = Expressir::Express::Parser.from_file(path)
        new(repository)
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
          {
            "file" => report[:schema].file,
            "file_basename" => File.basename(report[:schema].file),
            "directory" => File.dirname(report[:schema].file),
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
        # Group by directory
        by_directory = file_reports.group_by { |r| r["directory"] }

        # Aggregate stats for each directory
        by_directory.map do |directory, reports|
          total = reports.sum { |r| r["total"] }
          documented = reports.sum { |r| r["documented"] }
          coverage = total > 0 ? (documented.to_f / total) * 100 : 100.0

          {
            "directory" => directory,
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
        entities = Expressir::Coverage.find_entities(schema)
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

        # Convert to EXPRESS convention (e.g., "TYPE")
        express_type = type_name.upcase

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
      if entity.parent && entity.parent.respond_to?(:remark_items) && entity.parent.remark_items
        entity_id = entity.id.to_s.downcase
        entity.parent.remark_items.any? do |item|
          item.id.to_s.downcase == entity_id || item.id.to_s.downcase.include?("#{entity_id}.")
        end
      else
        false
      end
    end

    # Find all entities in a schema
    # @param schema [Expressir::Model::Declarations::Schema] The schema to analyze
    # @return [Array<Expressir::Model::ModelElement>] Array of entities
    def self.find_entities(schema)
      entities = []

      # Add all schema-level entities
      entities.concat(schema.constants) if schema.constants
      entities.concat(schema.types) if schema.types
      entities.concat(schema.entities) if schema.entities
      entities.concat(schema.functions) if schema.functions
      entities.concat(schema.rules) if schema.rules
      entities.concat(schema.procedures) if schema.procedures
      entities.concat(schema.subtype_constraints) if schema.subtype_constraints

      # Add enumeration items from types
      if schema.types
        schema.types.each do |type|
          if type.respond_to?(:enumeration_items) && type.enumeration_items
            entities.concat(type.enumeration_items)
          end
        end
      end

      # Filter out any nil elements and ensure all have IDs
      entities.compact.select { |e| e.respond_to?(:id) && e.id }
    end
  end
end
