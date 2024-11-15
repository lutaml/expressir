# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class UnaryExpressionDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def operator
          @model.operator
        end

        def operand
          drop_klass_by_model(@model.operand)
        end
      end
    end
  end
end
