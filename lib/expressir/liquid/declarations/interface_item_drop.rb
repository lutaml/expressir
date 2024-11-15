# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class InterfaceItemDrop < ::Expressir::Liquid::ModelElementDrop
        def initialize(model)
          @model = model
          super
        end

        def ref
          drop_klass_by_model(@model.ref)
        end

        def id
          @model.id
        end
      end
    end
  end
end
