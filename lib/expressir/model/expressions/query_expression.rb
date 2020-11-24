module Expressir
  module Model
    module Expressions
      class QueryExpression
        attr_accessor :id
        attr_accessor :source
        attr_accessor :expression

        attr_accessor :parent
        attr_accessor :remarks

        def initialize(options = {})
          @id = options[:id]
          @source = options[:source]
          @expression = options[:expression]
        end

        def children
          items = []
          items.push(self)
          items
        end
      end
    end
  end
end