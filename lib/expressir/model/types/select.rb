module Expressir
  module Model
    module Types
      class Select
        attr_accessor :extensible
        attr_accessor :generic_entity
        attr_accessor :items
        attr_accessor :extension_type
        attr_accessor :extension_items

        def initialize(options = {})
          @extensible = options[:extensible]
          @generic_entity = options[:generic_entity]
          @items = options[:items]
          @extension_type = options[:extension_type]
          @extension_items = options[:extension_items]
        end
      end
    end
  end
end