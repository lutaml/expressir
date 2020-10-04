require "expressir/express/defined_type"

module Expressir
  module Express
    class Type < DefinedType
      attr_accessor :isBuiltin, :domain, :isFixed, :width, :precision

      def initialize(options = {})
        @isBuiltin = false
        @isFixed = false
        @width = nil
        @precision = nil
        @wheres = []
        @selectedBy = []

        super(options)
      end

      private

      def extract_type_attributes(document)
        extract_builtintype_attributes(document)
        super(document)
      end

      # Custom - Experimental
      def extract_builtintype_attributes(document)
        builtin_type = document.xpath("builtintype").first

        if builtin_type
          @isBuiltin = true
          @domain = builtin_type.attributes["type"].to_s
        end
      end
    end
  end
end
