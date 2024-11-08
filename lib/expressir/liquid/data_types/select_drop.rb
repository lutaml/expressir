# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class SelectDrop < ::Expressir::Liquid::DataTypeDrop
        def initialize(model)
          @model = model
          super
        end

        def extensible
          @model.extensible
        end

        def generic_entity
          @model.generic_entity
        end

        def based_on
          drop_klass_by_model(@model.based_on)
        end

        def items
          return [] unless @model.items

          @model.items.map do |item|
            drop_klass_by_model(item)
          end
        end
      end
    end
  end
end
