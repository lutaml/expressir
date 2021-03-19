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
      attr_accessor :rules
      attr_accessor :procedures

      def initialize(options = {})
        @file = options[:file]

        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @version = options[:version]
        @interfaces = options.fetch(:interfaces, [])
        @constants = options.fetch(:constants, [])
        @types = options.fetch(:types, [])
        @entities = options.fetch(:entities, [])
        @subtype_constraints = options.fetch(:subtype_constraints, [])
        @functions = options.fetch(:functions, [])
        @rules = options.fetch(:rules, [])
        @procedures = options.fetch(:procedures, [])

        super
      end

      def create_interfaced_item(id, base_item)
        interfaced_item = InterfacedItem.new({
          id: id
        })
        interfaced_item.base_item = base_item # skip overriding parent
        interfaced_item.parent = self
        interfaced_item
      end

      def interfaced_items
        interfaces.flat_map do |interface|
          schema = parent.children_by_id[interface.schema.id.downcase]
          if schema
            schema_safe_children = schema.safe_children
            schema_safe_children_by_id = schema_safe_children.select{|x| x.id}.map{|x| [x.id.downcase, x]}.to_h
            if interface.items.length > 0
              interface.items.map do |interface_item|
                base_item = schema_safe_children_by_id[interface_item.ref.id.downcase]
                if base_item
                  id = interface_item.id || base_item.id
                  create_interfaced_item(id, base_item)
                end
              end
            else
              schema_safe_children.map do |base_item|
                id = base_item.id
                create_interfaced_item(id, base_item)
              end
            end
          end
        end.select{|x| x}
      end

      def enumeration_items
        types.flat_map{|x| x.enumeration_items}
      end

      def safe_children
        [
          *constants,
          *types,
          *enumeration_items,
          *entities,
          *subtype_constraints,
          *functions,
          *rules,
          *procedures,
          *remark_items
        ]
      end

      def children
        [
          *interfaced_items,
          *safe_children
        ]
      end
    end
  end
end