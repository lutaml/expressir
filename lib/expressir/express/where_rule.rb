require "expressir/express/model_element"

module Expressir
  module Express
    class WhereRule < ModelElement
      attr_accessor :name, :expression

      def initialize(options = {})
        @name = nil
        @options = options
      end

      def parse
        document = @options.fetch(:where, nil)
        extract_where_attributes(document) if document

        self
      end

      def self.parse(document)
        new(document: document).parse
      end

      private

      def extract_where_attributes(document)
        @name = document.attributes["label"].to_s
        @expression = document.attributes["expression"]
      end
    end
  end
end
