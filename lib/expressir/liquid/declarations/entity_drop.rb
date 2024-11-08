# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class EntityDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def abstract
          @model.abstract
        end

        def supertype_expression
          drop_klass_by_model(@model.supertype_expression)
        end

        def subtype_of
          return [] unless @model.subtype_of

          @model.subtype_of.map do |item|
            drop_klass_by_model(item)
          end
        end

        def attributes
          return [] unless @model.attributes

          @model.attributes.map do |item|
            ::Expressir::Liquid::Declarations::AttributeDrop.new(item)
          end
        end

        def unique_rules
          return [] unless @model.unique_rules

          @model.unique_rules.map do |item|
            ::Expressir::Liquid::Declarations::UniqueRuleDrop.new(item)
          end
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
