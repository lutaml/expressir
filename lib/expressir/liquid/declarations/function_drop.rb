# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class FunctionDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def parameters
          return [] unless @model.parameters

          @model.parameters.map do |item|
            ::Expressir::Liquid::Declarations::ParameterDrop.new(item)
          end
        end

        def return_type
          drop_klass_by_model(@model.return_type)
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
      end
    end
  end
end
