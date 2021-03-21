module Expressir
  module Model
    module Expressions
      class AttributeReference < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :attribute

        def initialize(options = {})
          @ref = options[:ref]
          @attribute = options[:attribute]

          super
        end
      end
    end
  end
end