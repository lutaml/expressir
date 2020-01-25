module Reeper
  module Express
    class InterfacedItem
      attr_accessor :name, :original_name, :foreign_schema, :foreign_type

      def initialize(attributes = {})
        @original_name = nil
        @attributes = attributes
      end

      def parse
        schema = attributes.extract(:schema, nil)
        document = attributes.extract(:document, nil)

        extract_attributes(document, schema)
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      attr_reader :attributes

      def extract_attributes(document, schema)
        @foreign_schema = schema
        @name = document.attributes["name"].to_s

        if document.attributes["alias"] != nil
          @name = document.attributes["alias"].to_s
          @original_name = document.attributes["name"].to_s
        end
      end
    end
  end
end

