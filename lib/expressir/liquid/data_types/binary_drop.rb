# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class BinaryDrop < ::Expressir::Liquid::DataTypeDrop
        def initialize(model)
          @model = model
          super
        end

        def width
          drop_klass_by_model(@model.width)
        end

        def fixed
          @model.fixed
        end
      end
    end
  end
end
