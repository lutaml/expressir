module Reeper
  module Express
    class AggregateDimension
      attr_accessor :aggrtype, :lower, :upper, :isUnique, :isOptionalArray

      def initialize(options = {})
        @aggrtype = "SET"
        @lower = "0"
        @upper = "?"
        @isUnique = false
        @isOptionalArray = false

        @options = options
      end

      def parse
        document = @options.fetch(:document, nil)
        extract_attributes(document) if document

        self
      end

      def self.parse(document)
        new(document: document).parse
      end

      private

      def extract_attributes(document)
        @aggrtype = document.attributes["type"]
        @lower = document.attributes["lower"]
        @upper = document.attributes["upper"]
        @isUnique = document.attributes["unique"] == "YES"
        @isOptionalArray = document.attributes["optional"] == "YES"
      end
    end
  end
end
