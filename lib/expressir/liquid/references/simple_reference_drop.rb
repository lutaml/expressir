# frozen_string_literal: true

module Expressir
  module Liquid
    module References
      class SimpleReferenceDrop < ::Expressir::Liquid::ReferenceDrop
        def initialize(model)
          @model = model
          super
        end

        def id
          @model.id
        end

        def base_path
          @model.base_path
        end
      end
    end
  end
end
