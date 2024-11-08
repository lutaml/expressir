# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class UniqueRuleDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def attributes
          drop_klass_by_model(@model.attributes)
        end
      end
    end
  end
end
