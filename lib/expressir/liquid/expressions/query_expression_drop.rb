# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class QueryExpressionDrop < ::Expressir::Liquid::ExpressionDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def aggregate_source
          drop_klass_by_model(@model.aggregate_source)
        end

        def expression
          drop_klass_by_model(@model.expression)
        end
      end
    end
  end
end
