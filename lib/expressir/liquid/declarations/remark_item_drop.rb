# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class RemarkItemDrop < ::Expressir::Liquid::DeclarationDrop
        def initialize(model)
          @model = model
          super
        end

        def id
          @model.id
        end

        def remarks
          @model.remarks || []
        end
      end
    end
  end
end
