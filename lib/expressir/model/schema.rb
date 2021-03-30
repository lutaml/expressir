module Expressir
  module Model
    class Schema < ModelElement
      model_attr_accessor :file

      include Identifier

      model_attr_accessor :version
      model_attr_accessor :interfaces
      model_attr_accessor :constants
      model_attr_accessor :types
      model_attr_accessor :entities
      model_attr_accessor :subtype_constraints
      model_attr_accessor :functions
      model_attr_accessor :rules
      model_attr_accessor :procedures

      def initialize(options = {})
        @file = options[:file]

        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @version = options[:version]
        @interfaces = options[:interfaces] || []
        @constants = options[:constants] || []
        @types = options[:types] || []
        @entities = options[:entities] || []
        @subtype_constraints = options[:subtype_constraints] || []
        @functions = options[:functions] || []
        @rules = options[:rules] || []
        @procedures = options[:procedures] || []

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
        return [] unless parent

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