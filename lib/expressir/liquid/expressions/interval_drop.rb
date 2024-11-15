# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class IntervalDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def low
          drop_klass_by_model(@model.low)
        end

        def operator1
          @model.operator1
        end

        def item
          drop_klass_by_model(@model.item)
        end

        def operator2
          @model.operator2
        end

        def high
          drop_klass_by_model(@model.high)
        end
      end
    end
  end
end
