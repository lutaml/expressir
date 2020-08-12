require "expressr/express/type_enum"
require "expressr/express/type_select"
require "expressr/express/type_aggregate"

module Expressr
  module Express
    class TypeParser
      def initialize(options = {})
        @options = options
        @schema = options.fetch(:schema, nil)
      end

      def parse
        document = @options.fetch(:document, nil)
        extract_attributes(document) if document
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      def extract_attributes(document)
        document_with_klass = document_with_klass(document)
        document_with_klass[:cls].parse(document_with_klass[:document], @schema)
      end

      def document_with_klass(document)
        if !document.xpath("select").empty?
          { document: document.xpath("select"), cls: Express::TypeSelect }

        elsif !document.xpath("enumeration").empty?
          { document: document.xpath("enumeration"), cls: Express::TypeEnum }

        elsif !document.xpath("aggregate").empty?
          { document: document.xpath("aggregate"), cls: Express::TypeAggregate }

        else
          { document: document, cls: Express::Type }
        end
      end
    end
  end
end
