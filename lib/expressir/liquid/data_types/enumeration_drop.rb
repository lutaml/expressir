# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class EnumerationDrop < ::Expressir::Liquid::DataTypeDrop
        def initialize(model)
          @model = model
          super
        end

        def extensible
          @model.extensible
        end

        def based_on
          drop_klass_by_model(@model.based_on)
        end

        def items
          return [] unless @model.items

          @model.items.map do |item|
            ::Expressir::Liquid::DataTypes::EnumerationItemDrop.new(item)
          end
        end
      end
    end
  end
end
