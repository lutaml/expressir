# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class FunctionCallDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def function
          drop_klass_by_model(@model.function)
        end

        def parameters
          return [] unless @model.parameters

          @model.parameters.map do |item|
            drop_klass_by_model(item)
          end
        end
      end
    end
  end
end
