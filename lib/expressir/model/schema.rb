module Expressir
  module Model
    class Schema < ModelElement
      include Scope
      include Identifier

      attr_accessor :head_source

      attr_accessor :version
      attr_accessor :interfaces
      attr_accessor :constants
      attr_accessor :types
      attr_accessor :entities
      attr_accessor :subtype_constraints
      attr_accessor :functions
      attr_accessor :procedures
      attr_accessor :rules

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]
        @head_source = options[:head_source]

        @version = options[:version]
        @interfaces = options.fetch(:interfaces, [])
        @constants = options.fetch(:constants, [])
        @types = options.fetch(:types, [])
        @entities = options.fetch(:entities, [])
        @subtype_constraints = options.fetch(:subtype_constraints, [])
        @functions = options.fetch(:functions, [])
        @procedures = options.fetch(:procedures, [])
        @rules = options.fetch(:rules, [])
      end

      def children
        items = []
        items.push(*@constants)
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
        items.push(*@rules)
        items
      end
    end
  end
end