# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class BinaryExpressionDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def operator
          @model.operator
        end

        def operand1
          drop_klass_by_model(@model.operand1)
        end

        def operand2
          drop_klass_by_model(@model.operand2)
        end
      end
    end
  end
end
