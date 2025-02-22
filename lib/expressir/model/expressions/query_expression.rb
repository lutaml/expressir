module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.6.7 Query expression
      class QueryExpression < Expression
        include Identifier

        attribute :aggregate_source, ::Expressir::Model::Reference
        attribute :expression, Expressir::Model::Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "aggregate_source", to: :aggregate_source
          map "expression", to: :expression
        end

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
