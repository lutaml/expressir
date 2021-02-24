module Expressir
  module Model
    module Types
      class Enumeration < ModelElement
        attr_accessor :extensible
        attr_accessor :items
        attr_accessor :extension_type
        attr_accessor :extension_items

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