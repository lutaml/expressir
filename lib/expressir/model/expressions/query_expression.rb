module Expressir
  module Model
    module Expressions
      class QueryExpression
        include Scope
        include Identifier

        attr_accessor :source
        attr_accessor :expression

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