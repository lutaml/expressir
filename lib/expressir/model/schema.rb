module Expressir
  module Model
    class Schema < ModelElement
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

        super
      end

      def children
        items = []
        # TODO: select interface items
        items.push(*@interfaces.flat_map{|x| parent.schemas.find{|y| x.schema.id == y.id}&.children || []})
        items.push(*@constants)
        items.push(*@types)
        items.push(*@types.flat_map{|x| x.type.is_a?(Expressir::Model::Types::Enumeration) ? x.type.items : []})
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