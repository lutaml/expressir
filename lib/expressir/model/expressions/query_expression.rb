module Expressir
  module Model
    module Expressions
      class QueryExpression < ModelElement
        include Identifier

        attr_accessor :aggregate_source
        attr_accessor :expression

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @source = options[:source]

          @aggregate_source = options[:aggregate_source]
          @expression = options[:expression]

          super
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