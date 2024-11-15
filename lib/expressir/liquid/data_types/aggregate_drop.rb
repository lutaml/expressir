# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class AggregateDrop < ::Expressir::Liquid::DataTypeDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def base_type
          drop_klass_by_model(@model.base_type)
        end
      end
    end
  end
end
