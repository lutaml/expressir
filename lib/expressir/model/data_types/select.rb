module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.2 Select data type
      class Select < DataType
        model_attr_accessor :extensible, '::Boolean'
        model_attr_accessor :generic_entity, '::Boolean'
        model_attr_accessor :based_on, 'Reference'
        model_attr_accessor :items, '::Array<Reference>'

        # @param [Hash] options
        # @option options [::Boolean] :extensible
        # @option options [::Boolean] :generic_entity
        # @option options [Reference] :based_on
        # @option options [::Array<Reference>] :items
        def initialize(options = {})
          @extensible = options[:extensible]
          @generic_entity = options[:generic_entity]
          @based_on = options[:based_on]
          @items = options[:items] || []

          super
        end
      end
    end
  end
end