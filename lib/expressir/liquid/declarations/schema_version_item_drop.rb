# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class SchemaVersionItemDrop < ::Expressir::Liquid::ModelElementDrop
        def initialize(model)
          @model = model
          super
        end

        def name
          @model.name
        end

        def value
          @model.value
        end
      end
    end
  end
end
