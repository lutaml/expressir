module Expressir
  module Model
    module Expressions
      class AttributeQualifier
        attr_accessor :attribute

        def initialize(options = {})
          @attribute = options[:attribute]
        end
      end
    end
  end
end