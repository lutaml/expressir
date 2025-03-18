module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.6 Rule
      class Rule < ModelElement
        include Identifier

        attribute :applies_to, ModelElement, collection: true
        attribute :types, ModelElement, collection: true
        attribute :entities, Entity, collection: true
        attribute :subtype_constraints, SubtypeConstraint, collection: true
        attribute :functions, Function, collection: true
        attribute :procedures, Procedure, collection: true
        attribute :constants, Constant, collection: true
        attribute :variables, Variable, collection: true
        attribute :statements, ModelElement, collection: true
        attribute :where_rules, WhereRule, collection: true
        attribute :informal_propositions, RemarkItem, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "applies_to", to: :applies_to
          map "types", to: :types
          map "entities", to: :entities
          map "subtype_constraints", to: :subtype_constraints
          map "functions", to: :functions
          map "procedures", to: :procedures
          map "constants", to: :constants
          map "variables", to: :variables
          map "statements", to: :statements
          map "where_rules", to: :where_rules
          map "informal_propositions", to: :informal_propositions
        end

        # @return [Array<Declaration>]
        def children
          [
            *types,
            *types&.flat_map(&:enumeration_items),
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
