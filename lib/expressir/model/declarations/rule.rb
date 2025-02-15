module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.6 Rule
      class Rule < ::Expressir::Model::Declaration
        include Identifier

        attribute :applies_to, ::Expressir::Model::Reference, collection: true
        attribute :types, Type, collection: true
        attribute :entities, Entity, collection: true
        attribute :subtype_constraints, SubtypeConstraint, collection: true
        attribute :functions, Function, collection: true
        attribute :procedures, Procedure, collection: true
        attribute :constants, Constant, collection: true
        attribute :variables, Variable, collection: true
        attribute :statements, Statement, collection: true
        attribute :where_rules, WhereRule, collection: true
        attribute :informal_propositions, RemarkItem, collection: true

        # @return [Array<Declaration>]
        def children
          [
            *types,
            *types.flat_map(&:enumeration_items),
            *entities,
            *subtype_constraints,
            *functions,
            *procedures,
            *constants,
            *variables,
            *where_rules,
            *informal_propositions,
            *remark_items,
          ]
        end
      end
    end
  end
end
