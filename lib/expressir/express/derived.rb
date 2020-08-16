module Expressir
  module Express
    class Derived < ExplicitOrDerived
      attr_accessor :expression

      def initialize(options = {})
        @options = options
        @entity = options.fetch(:entity, nil)
      end

      def parse
        document = @options.fetch(:document, nil)
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
        @expression = document.attributes["expression"].to_s
        @domain = extract_domain_name(document.xpath("typename"))

        extract_builtintype_attributes(document)
        extract_redeclaration_attributes(document)
      end

      def extract_domain_name(typename)
        unless typename.empty?
          typename.first.attributes["name"].to_s
        end
      end

      def extract_redeclaration_attributes(document)
        redeclaration = document.xpath("redeclaration").first

        if redeclaration
          @redeclare_entity = redeclaration.attributes["entity-ref"].to_s
          old_name = redeclaration.attributes["old_name"]
          @redeclare_oldname = old_name.to_s if old_name
        end
      end

      def extract_builtintype_attributes(document)
        builtin_type = document.xpath("builtintype").first

        if builtin_type
          @isBuiltin = true
          @domain = builtin_type.attributes["type"].to_s
          @width = builtin_type.attributes["width"].to_s
          @fixed = builtin_type.attributes["fixed"] == "YES"
          @precision = builtin_type.attributes["precision"].to_s
        end
      end
    end
  end
end
