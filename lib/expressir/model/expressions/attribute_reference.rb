module Expressir
  module Model
    module Expressions
      class AttributeReference < ModelElement
        attr_accessor :ref
        attr_accessor :attribute

        def initialize(options = {})
          @ref = options[:ref]
          @attribute = options[:attribute]

          super
        end
      end
    end
  end
end