module Expressir
  module Model
    class Schema < ModelElement
      attr_accessor :file

      include Identifier

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
        @file = options[:file]

        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

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

      def children(skip_references = false)
        items = []
        unless skip_references
          items.push(*@interfaces.flat_map do |interface|
            schema_id = interface.schema.id.downcase
            schema = parent.schemas.find{|x| x.id.downcase == schema_id}
            if schema
              schema_children = schema.children(true) # prevent infinite recursion
              if interface.items.length > 0
                interface.items.map do |item|
                  ref_id = item.ref.id.downcase
                  id = item.id || ref_id
                  base_item = schema_children.find{|x| x.id and x.id.downcase == ref_id}

                  interfaced_item = InterfacedItem.new({
                    id: id
                  })
                  interfaced_item.base_item = base_item # skip overriding parent
                  interfaced_item.parent = self
                  interfaced_item
                end
              else
                schema_children.map do |item|
                  id = item.id
                  base_item = item

                  interfaced_item = InterfacedItem.new({
                    id: id
                  })
                  interfaced_item.base_item = base_item # skip overriding parent
                  interfaced_item.parent = self
                  interfaced_item
                end
              end
            else
              []
            end
          end)
        end
        items.push(*@constants)
        items.push(*@types)
        items.push(*@types.flat_map{|x| x.type.is_a?(Types::Enumeration) ? x.type.items : []})
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