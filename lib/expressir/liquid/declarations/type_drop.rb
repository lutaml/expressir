# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class TypeDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def underlying_type
          drop_klass_by_model(@model.underlying_type)
        end

        def where_rules
          return [] unless @model.where_rules

          @model.where_rules.map do |item|
            ::Expressir::Liquid::Declarations::WhereRuleDrop.new(item)
          end
        end

        def informal_propositions
          return [] unless @model.informal_propositions

          @model.informal_propositions.map do |item|
            ::Expressir::Liquid::Declarations::RemarkItemDrop.new(item)
          end
        end
      end
    end
  end
end
