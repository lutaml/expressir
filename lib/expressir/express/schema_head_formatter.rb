module Expressir
  module Express
    # Formatter module - format schema as schema head only
    # @example Include into Formatter subclass
    #   formatter = Class.new(Expressir::Express::Formatter) do
    #     include Expressir::Express::SchemaHeadFormatter
    #   end
    module SchemaHeadFormatter
      # @!visibility private
      def self.included(mod)
        if !mod.superclass.private_method_defined?(:format_declarations_schema) || !mod.superclass.private_method_defined?(:format_declarations_schema_head)
          raise Error::FormatterMethodMissingError.new("SchemaHeadFormatter", "format_declarations_schema/format_declarations_schema_head")
        end
      end

      private

      def format_declarations_schema(node)
        format_declarations_schema_head(node)
      end
    end
  end
end
