module Expressir
  module Model
    module Expressions
      class AttributeReference
        attr_accessor :ref
        attr_accessor :attribute

        def initialize(options = {})
          @ref = options[:ref]
          @attribute = options[:attribute]
        end
      end
    end
  end
end