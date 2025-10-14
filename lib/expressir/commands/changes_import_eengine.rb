# frozen_string_literal: true

require_relative "base"
require_relative "../eengine/compare_report"

module Expressir
  module Commands
    # Command to import eengine comparison XML to EXPRESS Changes YAML
    class ChangesImportEengine < Base
      # Parse XML string and convert to SchemaChange
      #
      # @param xml_content [String] Eengine XML content
      # @param schema_name [String] Schema name
      # @param version [String] Version identifier
      # @param options [Hash] Additional options
      # @return [Expressir::Changes::SchemaChange]
      def self.from_xml(xml_content, schema_name, version, **options)
        require "expressir/changes"

        # Parse into CompareReport using Lutaml::Model
        compare_report = Expressir::Eengine::CompareReport.from_xml(xml_content)

        # Convert to SchemaChange
        convert_to_schema_change(compare_report, schema_name, version,
                                 **options)
      end

      # File-based workflow (backward compatible)
      def self.call(input_file, output_file, schema_name, version, **options)
        require "expressir/changes"

        xml_content = File.read(input_file)

        # Load existing schema if output file exists
        existing_schema = if output_file && File.exist?(output_file) && File.size(output_file).positive?
                            Expressir::Changes::SchemaChange.from_file(output_file)
                          end

        change_schema = from_xml(xml_content, schema_name, version,
                                 existing_schema: existing_schema, **options)

        if output_file
          change_schema.to_file(output_file)
          puts "Change YAML file written to: #{output_file}" if options[:verbose]
        else
          puts change_schema.to_yaml
        end

        change_schema
      end

      class << self
        private

        def convert_to_schema_change(compare_report, schema_name, version,
**options)
          require "expressir/changes"

          # Extract changes from CompareReport
          changes = {
            additions: extract_items(compare_report.additions),
            modifications: extract_items(compare_report.modifications),
            deletions: extract_items(compare_report.deletions),
          }

          description = extract_description(compare_report)

          # Use existing schema or create new one
          change_schema = options[:existing_schema] ||
            Expressir::Changes::SchemaChange.new(schema: schema_name)
          change_schema.add_or_update_edition(version, description, changes)

          change_schema
        end

        def extract_items(changes_section)
          return [] unless changes_section&.modified_objects

          changes_section.modified_objects.map do |obj|
            item_change = Expressir::Changes::ItemChange.new(
              type: obj.type,
              name: obj.name,
            )
            item_change.interfaced_items = obj.interfaced_items if obj.interfaced_items
            item_change
          end
        end

        def extract_description(compare_report)
          parts = []

          [compare_report.modifications, compare_report.additions,
           compare_report.deletions].each do |section|
            next unless section&.modified_objects

            section.modified_objects.each do |obj|
              if obj.description && !obj.description.strip.empty?
                parts << obj.description.strip
              end
            end
          end

          parts.join("\n\n")
        end
      end
    end
  end
end
