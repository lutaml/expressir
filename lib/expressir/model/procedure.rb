module Expressir
  module Model
    class Procedure < ModelElement
      include Scope
      include Identifier

      attr_accessor :parameters
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
        @types = options.fetch(:types, [])
        @entities = options.fetch(:entities, [])
        @subtype_constraints = options.fetch(:subtype_constraints, [])
        @functions = options.fetch(:functions, [])
        @procedures = options.fetch(:procedures, [])
        @constants = options.fetch(:constants, [])
        @variables = options.fetch(:variables, [])
        @statements = options.fetch(:statements, [])
      end

      def children
        items = []
        items.push(*@parameters)
        items.push(*@types)
        items.push(*@types.flat_map do |x|
          if x.type.instance_of? Expressir::Model::Types::Enumeration
            x.type.items
          else
            []
          end
        end)
        items.push(*@entities)
        items.push(*@subtype_constraints)
        items.push(*@functions)
        items.push(*@procedures)
        items.push(*@constants)
        items.push(*@variables)
        items
      end
    end
  end
end