module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.1 Enumeration data type
      class Enumeration < DataType
        model_attr_accessor :extensible, "::Boolean"
        model_attr_accessor :based_on, "Reference"
        model_attr_accessor :items, "::Array<EnumerationItem>"

        # @param [Hash] options
        # @option options [::Boolean] :extensible
        # @option options [Reference] :based_on
        # @option options [::Array<EnumerationItem>] :items
        def initialize(options = {})
          @extensible = options[:extensible]
          @based_on = options[:based_on]
          @items = options[:items] || []

          super
        end
      end
    end
  end
end
