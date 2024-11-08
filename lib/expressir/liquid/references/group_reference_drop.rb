# frozen_string_literal: true

module Expressir
  module Liquid
    module References
      class GroupReferenceDrop < ::Expressir::Liquid::ReferenceDrop
        def initialize(model)
          @model = model
          super
        end

        def ref
          drop_klass_by_model(@model.ref)
        end

        def entity
          drop_klass_by_model(@model.entity)
        end
      end
    end
  end
end
