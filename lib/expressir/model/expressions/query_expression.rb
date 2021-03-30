module Expressir
  module Model
    module Expressions
      class QueryExpression < ModelElement
        include Identifier

        model_attr_accessor :aggregate_source
        model_attr_accessor :expression

        def initialize(options = {})
          @id = options[:id]
          @remarks = options[:remarks] || []
          @remark_items = options[:remark_items] || []
          @source = options[:source]

          @aggregate_source = options[:aggregate_source]
          @expression = options[:expression]

          super
        end

        def children
          [
            self,
            *remark_items
          ]
        end
      end
    end
  end
end