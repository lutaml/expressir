# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class RealDrop < ::Expressir::Liquid::DataTypeDrop
        def initialize(model)
          @model = model
          super
        end

        def precision
          drop_klass_by_model(@model.precision)
        end
      end
    end
  end
end
