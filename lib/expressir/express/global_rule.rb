require "expressir/express/model_element"

module Expressir
  module Express
    class GlobalRule < ModelElement
      attr_accessor :name, :entities, :algorithm, :wheres,
        :schema, :entities_array

      def initialize(options = {})
        @entities_array = []
        @wheres = []

        @options = options
        @schema = options.fetch(:schema, nil)
      end

      def parse
        document = @options.fetch(:document)
        extract_rule_attributes(document)

        self
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      def extract_rule_attributes(document)
        @wheres = extract_where_rules(document)
        @name = document.attributes["name"].to_s
        @entities = document.attributes["appliesto"].to_s
        @algorithm = document.attributes["algorithm"]
      end

      def extract_where_rules(document)
        document.xpath("where").map do |where|
          Express::WhereRule.parse(where)
        end
      end
    end
  end
end
