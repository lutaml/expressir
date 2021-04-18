module Expressir
  module Model
    module Types
      class Select < ModelElement
        model_attr_accessor :extensible
        model_attr_accessor :generic_entity
        model_attr_accessor :based_on
        model_attr_accessor :items

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