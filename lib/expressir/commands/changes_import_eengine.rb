# frozen_string_literal: true

require_relative "base"
require "moxml"

module Expressir
  module Commands
    # Command to import eengine comparison XML to EXPRESS Changes YAML
    class ChangesImportEengine < Base
      def self.call(input_file, output_file, schema_name, version, **options)
        new.call(input_file, output_file, schema_name, version, **options)
      end

      def call(input_file, output_file, schema_name, version, **options)
        require "expressir/changes"

        # Parse the eengine XML using Moxml
        xml_content = File.read(input_file)
        xml_doc = Moxml.new.parse(xml_content)

        # Detect XML mode from root element
        xml_mode = detect_xml_mode(xml_doc)

        # Extract changes from XML
        changes = extract_changes(xml_doc, xml_mode)
        description = generate_description(xml_doc, xml_mode)

        # Load or create change schema
        change_schema = if output_file && File.exist?(output_file) && File.size(output_file).positive?
                          Expressir::Changes::SchemaChange.from_file(output_file)
                        else
                          Expressir::Changes::SchemaChange.new(schema: schema_name)
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

      # Detect XML mode from root element (arm, mim, or schema)
      def detect_xml_mode(xml_doc)
        root = xml_doc.root
        return nil unless root

        case root.name
        when "arm.changes"
          "arm"
        when "mim.changes"
          "mim"
        when "schema.changes"
          "schema"
        else
          # Default to schema mode if unrecognized
          "schema"
        end
      end

      def extract_changes(xml_doc, xml_mode)
        {
          additions: extract_added_objects(xml_doc, xml_mode),
          modifications: extract_modified_objects(xml_doc, xml_mode),
          deletions: extract_deleted_objects(xml_doc, xml_mode),
        }
      end

      def extract_modified_objects(xml_doc, xml_mode)
        xpath = "//#{xml_mode}.modifications/modified.object"
        xml_doc.xpath(xpath).map do |node|
          extract_item_change(node)
        end
      end

      def extract_added_objects(xml_doc, xml_mode)
        xpath = "//#{xml_mode}.additions/modified.object"
        xml_doc.xpath(xpath).map do |node|
          extract_item_change(node)
        end
      end

      def extract_deleted_objects(xml_doc, xml_mode)
        xpath = "//#{xml_mode}.deletions/modified.object"
        xml_doc.xpath(xpath).map do |node|
          extract_item_change(node)
        end
      end

      def extract_item_change(node)
        item_change = Expressir::Changes::ItemChange.new(
          type: node["type"],
          name: node["name"],
        )

        # Extract interfaced.items attribute if present (for interface changes)
        if node["interfaced.items"]
          item_change.interfaced_items = node["interfaced.items"]
        end

        item_change
      end

      def generate_description(xml_doc, xml_mode)
        parts = []

        # Get descriptions from modifications
        xml_doc.xpath("//#{xml_mode}.modifications/modified.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        # Get descriptions from additions
        xml_doc.xpath("//#{xml_mode}.additions/modified.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        # Get descriptions from deletions
        xml_doc.xpath("//#{xml_mode}.deletions/modified.object/description").each do |desc|
          text = desc.text.strip
          parts << text unless text.empty?
        end

        parts.join("\n\n")
      end
    end
  end
end
