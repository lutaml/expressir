# frozen_string_literal: true

module Expressir
  module Liquid
    module Expressions
      class AggregateInitializerDrop < ::Expressir::Liquid::ExpressionDrop
        def initialize(model)
          @model = model
          super
        end

        def items
          return [] unless @model.items

          @model.items.map do |item|
            ::Expressir::Liquid::Expressions::AggregateInitializerItemDrop.new(
              item,
            )
          end
        end
      end
    end
  end
end
