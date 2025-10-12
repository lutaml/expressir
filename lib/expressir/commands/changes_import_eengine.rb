# frozen_string_literal: true

require_relative "base"
require "nokogiri"

module Expressir
  module Commands
    # Command to import eengine comparison XML to EXPRESS Changes YAML
    class ChangesImportEengine < Base
      def self.call(input_file, output_file, schema_name, version, **options)
        new.call(input_file, output_file, schema_name, version, **options)
      end

      def call(input_file, output_file, schema_name, version, **options)
        require "expressir/changes"

        # Parse the eengine XML
        xml_doc = File.open(input_file) { |f| Nokogiri::XML(f) }

        # Extract changes from XML
        changes = extract_changes(xml_doc)
        description = generate_description(xml_doc)

        # Load or create change schema
        change_schema = if output_file && File.exist?(output_file) && File.size(output_file).positive?
                          Expressir::Changes::SchemaChange.from_file(output_file)
                        else
                          Expressir::Changes::SchemaChange.create_new(schema_name)
                        end

        # Add or update edition
        change_schema.add_or_update_edition(version, description, changes)

        # Save to file
        if output_file
          change_schema.to_file(output_file)
          puts "Change YAML file written to: #{output_file}" if options[:verbose]
        else
          puts change_schema.to_yaml
        end

        change_schema
      end

      private

      def extract_changes(xml_doc)
        {
          additions: extract_added_objects(xml_doc),
          modifications: extract_modified_objects(xml_doc),
          removals: extract_removed_objects(xml_doc),
        }
      end

      def extract_modified_objects(xml_doc)
        xml_doc.xpath("//schema.modifications/modified.object").map do |node|
          Expressir::Changes::ItemChange.new(
            type: node["type"],
            name: node["name"],
          )
        end
      end

      def extract_added_objects(xml_doc)
        xml_doc.xpath("//schema.additions/added.object").map do |node|
          Expressir::Changes::ItemChange.new(
            type: node["type"],
            name: node["name"],
          )
        end
      end

      def extract_removed_objects(xml_doc)
        xml_doc.xpath("//schema.removals/removed.object").map do |node|
          Expressir::Changes::ItemChange.new(
            type: node["type"],
            name: node["name"],
          )
        end
      end

      def generate_description(xml_doc)
        parts = []

        # Get descriptions from modifications
        xml_doc.xpath("//schema.modifications/modified.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        # Get descriptions from additions
        xml_doc.xpath("//schema.additions/added.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        # Get descriptions from removals
        xml_doc.xpath("//schema.removals/removed.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        parts.join("\n\n")
      end
    end
  end
end
