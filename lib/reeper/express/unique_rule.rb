require "reeper/express/model_element"

module Reeper
  module Express
    class UniqueRule < ModelElement
      attr_accessor :name, :attributes

      def initialize(options)
        @name = nil
        @attributes = []
        @options = options
      end

      def parse
        document = @options.fetch(:document, nil)
        extract_unique_attributes(document)

        self
      end

      def self.parse(document)
        new(document: document).parse
      end

      private

      def extract_unique_attributes(document)
        @name = document.attributes["label"].to_s
        @attributes = document.xpath("unique.attribute").map do |attribute|
          attribute.attributes["attribute"]
        end
      end
    end
  end
end
