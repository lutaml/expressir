# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class SchemaVersionDrop < ::Expressir::Liquid::ModelElementDrop
        def initialize(model)
          @model = model
          super
        end

        def value
          @model.value
        end

        def items
          return [] unless @model.items

          @model.items.map do |item|
            ::Expressir::Liquid::Declarations::SchemaVersionItemDrop.new(item)
          end
        end
      end
    end
  end
end
