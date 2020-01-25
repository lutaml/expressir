require "reeper/express/entity"
require "reeper/express/type_parser"
require "reeper/express/global_rule"

module Reeper
  module Express
    class SchemaDefinition < ModelElement
      attr_accessor :contents, :name, :identification, :all_schema_array

      def initialize(document = {})
        @document = document
        @all_schema_array = []

        extract_attributes(@document)
      end

      # @todo Existing Code
      #
      # Please revisit this soon, and check if this is necessary
      # after our recent restrucutre, if not then delegate this
      # behavior to the respective instanace.
      #
      def find_namedtype_by_name(typename)
        ## search current schema and interfaced item aliases
        nt = contents.detect do |t|
          t.is_a?(Express::NamedType) && t.name == typename
        end

        if nt != nil
          return nt
        end

        for schema in self.all_schema_array
          ## search all interfaced schemas
          nt = schema.contents.detect do |t|
            t.is_a?(Express::NamedType) && t.name == typename
          end

          if nt != nil
            return nt
          end
        end

        Reeper.ui.info("*** NOT HERE " + typename + " IN " + self.name)
        Reeper.ui.info("*** SEARCHED " + all_schema_array.size.to_s + " SCHEMAS:")

        all_schema_array.each do |schema|
          Reeper.ui.info("  - " + schema.name)
        end

        nil
      end

      private

      def extract_attributes(document)
        @name = document.attributes["name"].to_s

        contents = extract_interfaces(document)
        contents += extract_entities(document)
        contents += extract_types(document)
        contents += extract_rules(document)

        @contents = contents.flatten
      end

      # todo: current version does not contain any interface, so we need
      # a solid example to test out this funcitonaality. But keeping it
      # pending for now, let's revisit soon.
      #
      def extract_interfaces(document)
        document.xpath("interface").map do |interface|
          InterfaceSpecification.parse(interface, name)
        end
      end

      def extract_entities(document)
        document.xpath("//entity").map do |entity|
          Express::Entity.parse(entity, name)
        end
      end

      def extract_types(document)
        document.xpath("type").map do |type_document|
          Express::TypeParser.parse(type_document, name)
        end
      end

      def extract_rules(document)
        document.xpath("rule").map do |rule|
          Express::GlobalRule.parse(rule, name)
        end
      end
    end
  end
end
