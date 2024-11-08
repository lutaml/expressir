# frozen_string_literal: true

module Expressir
  module Liquid
    module References
      class AttributeReferenceDrop < ::Expressir::Liquid::ReferenceDrop
        def initialize(model)
          @model = model
          super
        end

        def ref
          drop_klass_by_model(@model.ref)
        end

        def attribute
          drop_klass_by_model(@model.attribute)
        end
      end
    end
  end
end
