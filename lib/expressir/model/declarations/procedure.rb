module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.5.2 Procedure
      class Procedure < ::Expressir::Model::Declaration
        include Identifier

        attribute :parameters, ::Expressir::Model::Declarations::Parameter, collection: true
        attribute :types, ::Expressir::Model::Declarations::Type, collection: true
        attribute :entities, ::Expressir::Model::Declarations::Entity, collection: true
        attribute :subtype_constraints, ::Expressir::Model::Declarations::SubtypeConstraint, collection: true
        attribute :functions, ::Expressir::Model::Declarations::Function, collection: true
        attribute :procedures, ::Expressir::Model::Declarations::Procedure, collection: true
        attribute :constants, ::Expressir::Model::Declarations::Constant, collection: true
        attribute :variables, ::Expressir::Model::Declarations::Variable, collection: true
        attribute :statements, ::Expressir::Model::Statement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "parameters", to: :parameters
          map "types", to: :types
          map "entities", to: :entities
          map "subtype_constraints", to: :subtype_constraints
          map "functions", to: :functions
          map "procedures", to: :procedures
          map "constants", to: :constants
          map "variables", to: :variables
          map "statements", to: :statements
        end

        # @return [Array<Declaration>]
        def children
          [
            *parameters,
            *types,
            *types&.flat_map(&:enumeration_items),
            *entities,
            *subtype_constraints,
            *functions,
            *procedures,
            *constants,
            *variables,
            *remark_items,
          ]
        end
      end
    end
  end
end
