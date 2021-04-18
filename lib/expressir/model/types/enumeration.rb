module Expressir
  module Model
    module Types
      class Enumeration < ModelElement
        model_attr_accessor :extensible
        model_attr_accessor :based_on
        model_attr_accessor :items

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