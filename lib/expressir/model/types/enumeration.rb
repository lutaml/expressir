module Expressir
  module Model
    module Types
      class Enumeration < ModelElement
        model_attr_accessor :extensible
        model_attr_accessor :items
        model_attr_accessor :extension_type
        model_attr_accessor :extension_items

        def initialize(options = {})
          @extensible = options[:extensible]
          @items = options.fetch(:items, [])
          @extension_type = options[:extension_type]
          @extension_items = options.fetch(:extension_items, [])

          super
        end
      end
    end
  end
end