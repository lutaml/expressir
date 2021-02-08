module Expressir
  module Model
    class Rule < ModelElement
      include Scope
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

        @applies_to = options[:applies_to]
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
      end

      def children
        items = []
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
        items.push(*@where)
        items.push(*@informal_propositions)
        items
      end
    end
  end
end