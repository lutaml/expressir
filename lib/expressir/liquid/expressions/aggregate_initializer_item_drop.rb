# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class AggregateInitializerItemDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def expression
          drop_klass_by_model(@model.expression)
        end

        def repetition
          drop_klass_by_model(@model.repetition)
        end
      end
    end
  end
end
