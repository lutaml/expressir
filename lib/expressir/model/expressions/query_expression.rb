module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.6.7 Query expression
      class QueryExpression < Expression
        include Identifier

        attribute :aggregate_source, ::Expressir::Model::Reference
        attribute :expression, Expressir::Model::Expression

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items,
          ]
        end
      end
    end
  end
end
