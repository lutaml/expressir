module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class Schema < ::Expressir::Model::Declaration
        attribute :file, :string

        include Identifier

        attribute :version, SchemaVersion
        attribute :interfaces, Interface, collection: true
        attribute :constants, Constant, collection: true
        attribute :types, Type, collection: true
        attribute :entities, Entity, collection: true
        attribute :subtype_constraints, SubtypeConstraint, collection: true
        attribute :functions, Function, collection: true
        attribute :rules, Rule, collection: true
        attribute :procedures, Procedure, collection: true

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
