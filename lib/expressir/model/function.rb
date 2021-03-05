module Expressir
  module Model
    class Function < ModelElement
      include Identifier

      attr_accessor :parameters
      attr_accessor :return_type
      attr_accessor :types
      attr_accessor :entities
      attr_accessor :subtype_constraints
      attr_accessor :functions
      attr_accessor :procedures
      attr_accessor :constants
      attr_accessor :variables
      attr_accessor :statements

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @parameters = options.fetch(:parameters, [])
        @return_type = options[:return_type]
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
          *variables
        ]
      end
    end
  end
end