module Expressir
  module Model
    module Types
      class Select < ModelElement
        model_attr_accessor :extensible
        model_attr_accessor :generic_entity
        model_attr_accessor :items
        model_attr_accessor :extension_type
        model_attr_accessor :extension_items

        def initialize(options = {})
          @extensible = options[:extensible]
          @generic_entity = options[:generic_entity]
          @items = options[:items] || []
          @extension_type = options[:extension_type]
          @extension_items = options[:extension_items] || []

          super
        end
      end
    end
  end
end