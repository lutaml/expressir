module Expressir
  module Model
    module Expressions
      class QueryExpression
        attr_accessor :id
        attr_accessor :source
        attr_accessor :expression
        attr_accessor :remarks

        def initialize(options = {})
          @id = options[:id]
          @source = options[:source]
          @expression = options[:expression]
          @remarks = options[:remarks]
        end

        def scope_items
          items = []
          items.push(self)
          items
        end
      end
    end
  end
end