module Expressir
  module Model
    class Rule < ModelElement
      include Identifier

      model_attr_accessor :applies_to
      model_attr_accessor :types
      model_attr_accessor :entities
      model_attr_accessor :subtype_constraints
      model_attr_accessor :functions
      model_attr_accessor :procedures
      model_attr_accessor :constants
      model_attr_accessor :variables
      model_attr_accessor :statements
      model_attr_accessor :where
      model_attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
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
          *informal_propositions,
          *remark_items
        ]
      end
    end
  end
end