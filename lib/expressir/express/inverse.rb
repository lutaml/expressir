module Expressir
  module Express
    class Inverse < Attribute
      attr_accessor :reverseAttr_id, :reverseAttr, :reverseEntity

      def initialize(options = {})
        @options = options
        @entity = options.fetch(:entity, nil)
      end

      def parse
        document = @options.fetch(:document)
        extract_common_attributes(document)
        extract_type_specific_attributes(document)

        self
      end

      def self.parse(document, entity)
        new(document: document, entity: entity).parse
      end

      private

      def extract_type_specific_attributes(document); end

      def extract_common_attributes(document)
        @name = document.attributes["name"].to_s
        @reverseAttr_id = document.attributes["attribute"]
        @domain = document.attributes["entity"].to_s

        extract_redeclaration_attributes(document)
      end

      def extract_redeclaration_attributes(document)
        redeclaration = document.xpath("redeclaration").first

        if redeclaration
          @redeclare_entity = redeclaration.attributes["entity-ref"].to_s
          old_name = redeclaration.attributes["old_name"]
          @redeclare_oldname = old_name.to_s if old_name
        end
      end
    end
  end
end
