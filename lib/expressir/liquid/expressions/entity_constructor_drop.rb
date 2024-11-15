# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class EntityConstructorDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def entity
          drop_klass_by_model(@model.entity)
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
