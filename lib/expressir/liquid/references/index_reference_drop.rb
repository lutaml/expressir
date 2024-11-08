# frozen_string_literal: true

module Expressir
  module Liquid
    module References
      class IndexReferenceDrop < ::Expressir::Liquid::ReferenceDrop
        def initialize(model)
          @model = model
          super
        end

        def ref
          drop_klass_by_model(@model.ref)
        end

        def index1
          drop_klass_by_model(@model.index1)
        end

        def index2
          drop_klass_by_model(@model.index2)
        end
      end
    end
  end
end
