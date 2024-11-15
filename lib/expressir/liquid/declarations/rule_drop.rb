# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class RuleDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def applies_to
          return [] unless @model.applies_to

          @model.applies_to.map do |item|
            drop_klass_by_model(item)
          end
        end

        def types
          return [] unless @model.types

          @model.types.map do |item|
            ::Expressir::Liquid::Declarations::TypeDrop.new(item)
          end
        end

        def entities
          return [] unless @model.entities

          @model.entities.map do |item|
            ::Expressir::Liquid::Declarations::EntityDrop.new(item)
          end
        end

        def subtype_constraints
          return [] unless @model.subtype_constraints

          @model.subtype_constraints.map do |item|
            ::Expressir::Liquid::Declarations::SubtypeConstraintDrop.new(item)
          end
        end

        def functions
          return [] unless @model.functions

          @model.functions.map do |item|
            ::Expressir::Liquid::Declarations::FunctionDrop.new(item)
          end
        end

        def procedures
          return [] unless @model.procedures

          @model.procedures.map do |item|
            ::Expressir::Liquid::Declarations::ProcedureDrop.new(item)
          end
        end

        def constants
          return [] unless @model.constants

          @model.constants.map do |item|
            ::Expressir::Liquid::Declarations::ConstantDrop.new(item)
          end
        end

        def variables
          return [] unless @model.variables

          @model.variables.map do |item|
            ::Expressir::Liquid::Declarations::VariableDrop.new(item)
          end
        end

        def statements
          return [] unless @model.statements

          @model.statements.map do |item|
            ::Expressir::Liquid::StatementDrop.new(item)
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
