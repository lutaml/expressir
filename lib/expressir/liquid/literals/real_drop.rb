# frozen_string_literal: true

module Expressir
  module Liquid
    module Literals
      class RealDrop < ::Expressir::Liquid::LiteralDrop
        def initialize(model)
          @model = model
          super
        end

        def value
          @model.value
        end
      end
    end
  end
end
