module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class Schema < Declaration
        model_attr_accessor :file, "String"

        include Identifier

        model_attr_accessor :version, "SchemaVersion"
        model_attr_accessor :interfaces, "Array<Interface>"
        model_attr_accessor :constants, "Array<Constant>"
        model_attr_accessor :types, "Array<Type>"
        model_attr_accessor :entities, "Array<Entity>"
        model_attr_accessor :subtype_constraints, "Array<SubtypeConstraint>"
        model_attr_accessor :functions, "Array<Function>"
        model_attr_accessor :rules, "Array<Rule>"
        model_attr_accessor :procedures, "Array<Procedure>"

        # @param [Hash] options
        # @option options [String] :file
        # @option (see Identifier#initialize_identifier)
        # @option options [SchemaVersion] :version
        # @option options [Array<Interface>] :interfaces
        # @option options [Array<Constant>] :constants
        # @option options [Array<Type>] :types
        # @option options [Array<Entity>] :entities
        # @option options [Array<SubtypeConstraint>] :subtype_constraints
        # @option options [Array<Function>] :functions
        # @option options [Array<Rule>] :rules
        # @option options [Array<Procedure>] :procedures
        def initialize(options = {})
          @file = options[:file]

          initialize_identifier(options)

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

        # @return [Array<Declaration>]
        def safe_children
          [
            *constants,
            *types,
            *types.flat_map(&:enumeration_items),
            *entities,
            *subtype_constraints,
            *functions,
            *rules,
            *procedures,
            *remark_items,
          ]
        end

        # @return [Array<Declaration>]
        def children
          [
            *interfaced_items,
            *safe_children,
          ]
        end

        private

        # @param [String] id
        # @param [ModelElement] base_item
        # @return [InterfacedItem]
        def create_interfaced_item(id, base_item)
          interfaced_item = InterfacedItem.new(
            id: id,
          )
          interfaced_item.base_item = base_item # skip overriding parent
          interfaced_item.parent = self
          interfaced_item
        end

        # @return [Array<InterfacedItem>]
        def interfaced_items
          return [] unless parent

          interfaces.flat_map do |interface|
            schema = parent.children_by_id[interface.schema.id.safe_downcase]
            if schema
              schema_safe_children = schema.safe_children
              schema_safe_children_by_id = schema_safe_children.select(&:id).map { |x| [x.id.safe_downcase, x] }.to_h
              if interface.items.length.positive?
                interface.items.map do |interface_item|
                  base_item = schema_safe_children_by_id[interface_item.ref.id.safe_downcase]
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
          end.select { |x| x }
        end
      end
    end
  end
end
