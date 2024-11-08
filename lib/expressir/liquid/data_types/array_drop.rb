# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class ArrayDrop < ::Expressir::Liquid::DataTypeDrop
        def initialize(model)
          @model = model
          super
        end

        def bound1
          drop_klass_by_model(@model.bound1)
        end

        def bound2
          drop_klass_by_model(@model.bound2)
        end

        def optional
          @model.optional
        end

        def unique
          @model.unique
        end

        def base_type
          drop_klass_by_model(@model.base_type)
        end
      end
    end
  end
end
