# frozen_string_literal: true

module Expressir
  module Liquid
    module DataTypes
      class GenericDrop < ::Expressir::Liquid::DataTypeDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end
      end
    end
  end
end
