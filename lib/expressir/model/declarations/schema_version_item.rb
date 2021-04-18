module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class SchemaVersionItem < ModelElement
        model_attr_accessor :name, 'String'
        model_attr_accessor :value, 'String'

        # @param [Hash] options
        # @option options [String] :name
        # @option options [String] :value
        def initialize(options = {})
          @name = options[:name]
          @value = options[:value]

          super
        end
      end
    end
  end
end