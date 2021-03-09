module Expressir
  module Model
    class Rule < ModelElement
      include Identifier

      attr_accessor :applies_to
      attr_accessor :types
      attr_accessor :entities
      attr_accessor :subtype_constraints
      attr_accessor :functions
      attr_accessor :procedures
      attr_accessor :constants
      attr_accessor :variables
      attr_accessor :statements
      attr_accessor :where
      attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @applies_to = options.fetch(:applies_to, [])
        @types = options.fetch(:types, [])
        @entities = options.fetch(:entities, [])
        @subtype_constraints = options.fetch(:subtype_constraints, [])
        @functions = options.fetch(:functions, [])
        @procedures = options.fetch(:procedures, [])
        @constants = options.fetch(:constants, [])
        @variables = options.fetch(:variables, [])
        @statements = options.fetch(:statements, [])
        @where = options.fetch(:where, [])
        @informal_propositions = options.fetch(:informal_propositions, [])

        super
      end

      def enumeration_items
        types.flat_map{|x| x.enumeration_items}
      end

      def children
        [
          *types,
          *enumeration_items,
          *entities,
          *subtype_constraints,
          *functions,
          *procedures,
          *constants,
          *variables,
          *where,
          *informal_propositions
        ]
      end
    end
  end
end