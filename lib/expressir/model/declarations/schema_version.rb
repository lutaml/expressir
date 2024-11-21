module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class SchemaVersion < ModelElement
        model_attr_accessor :value, "String"
        model_attr_accessor :items, "Array<SchemaVersionItem>"

        # @param [Hash] options
        # @option options [String] :value
        # @option options [Array<SchemaVersionItem>] :items
        def initialize(options = {})
          @value = options[:value]
          @items = options[:items] || []

          super
        end
      end
    end
  end
end
