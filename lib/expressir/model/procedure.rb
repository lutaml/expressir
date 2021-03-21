module Expressir
  module Model
    class Procedure < ModelElement
      include Identifier

      model_attr_accessor :parameters
      model_attr_accessor :types
      model_attr_accessor :entities
      model_attr_accessor :subtype_constraints
      model_attr_accessor :functions
      model_attr_accessor :procedures
      model_attr_accessor :constants
      model_attr_accessor :variables
      model_attr_accessor :statements

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @parameters = options.fetch(:parameters, [])
        @types = options.fetch(:types, [])
        @entities = options.fetch(:entities, [])
        @subtype_constraints = options.fetch(:subtype_constraints, [])
        @functions = options.fetch(:functions, [])
        @procedures = options.fetch(:procedures, [])
        @constants = options.fetch(:constants, [])
        @variables = options.fetch(:variables, [])
        @statements = options.fetch(:statements, [])

        super
      end

      def enumeration_items
        types.flat_map{|x| x.enumeration_items}
      end

      def children
        [
          *parameters,
          *types,
          *enumeration_items,
          *entities,
          *subtype_constraints,
          *functions,
          *procedures,
          *constants,
          *variables,
          *remark_items
        ]
      end
    end
  end
end