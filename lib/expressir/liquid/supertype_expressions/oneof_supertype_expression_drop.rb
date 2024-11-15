# frozen_string_literal: true

module Expressir
  module Liquid
    module SupertypeExpressions
      class OneofSupertypeExpressionDrop < ::Expressir::Liquid::SupertypeExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def operands
          return [] unless @model.operands

          @model.operands.map do |item|
            drop_klass_by_model(item)
          end
        end
      end
    end
  end
end
