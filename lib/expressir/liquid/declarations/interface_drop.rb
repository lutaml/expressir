# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class InterfaceDrop < ::Expressir::Liquid::DeclarationDrop
        def initialize(model)
          @model = model
          super
        end

        def kind
          @model.kind
        end

        def schema
          drop_klass_by_model(@model.schema)
        end

        def items
          return [] unless @model.items

          @model.items.map do |item|
            ::Expressir::Liquid::Declarations::InterfaceItemDrop.new(item)
          end
        end
      end
    end
  end
end
