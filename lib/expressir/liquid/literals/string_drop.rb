# frozen_string_literal: true

module Expressir
  module Liquid
    module Literals
      class StringDrop < ::Expressir::Liquid::LiteralDrop
        def initialize(model)
          @model = model
          super
        end

        def value
          @model.value
        end

        def encoded
          @model.encoded
        end
      end
    end
  end
end
