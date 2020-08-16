require "expressir/express/model_element"

module Expressir
  module Express
    class InterfaceSpecification < ModelElement
      attr_accessor :kind, :current_schema, :explicit_items,
        :current_schema_id, :foreign_schema_id, :foreign_schema

      def initialize(attributes = {}) 
        @explicit_items = []
        @attributes = attributes
      end

      def parse
        extract_attributes(@attributes)
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      # Note:
      #
      # The the old version was passing around the whole instance
      # of the schema, and that might be one of the reason why the
      # parsing was super slow.
      #
      # So, we are not passing around an instnace anymore, but the
      # name of the schema, and later if we find out there is actually
      # a reason to do that then we wil add it back.
      #
      def extract_attributes(document, options)
        @foreign_schema = options.fetch("schema")
        @foreign_schema_id = foreign_schema&.name&.to_s
        @current_schema = foreign_schema
        @foreign_schema_id = foreign_schema_id

        @kind = document.attributes["kind"].to_s
        @explicit_items = extract_items(document, foreign_schema)
      end

      def extract_items(document, schema)
        document.xpath("interfaced.item").map do |item|
          InterfacedItem.parse(document, schema)
        end
      end
    end
  end
end
