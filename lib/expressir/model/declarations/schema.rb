module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class Schema < ModelElement
        include Identifier

        attribute :file, :string
        attribute :version, SchemaVersion
        attribute :interfaces, Interface, collection: true
        attribute :constants, Constant, collection: true
        attribute :types, ModelElement, collection: true
        attribute :entities, Entity, collection: true
        attribute :subtype_constraints, SubtypeConstraint, collection: true
        attribute :functions, Function, collection: true
        attribute :rules, Rule, collection: true
        attribute :procedures, Procedure, collection: true
        attribute :_class, :string, default: -> { send(:name) }
        attribute :selected, :boolean, default: false
        attribute :formatted, :string
        attribute :file_basename, :string
        attribute :full_source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "id", to: :id
          map "file", to: :file
          map "remarks", to: :remarks
          map "remark_items", to: :remark_items
          map "version", to: :version
          map "interfaces", to: :interfaces
          map "constants", to: :constants
          map "types", to: :types
          map "entities", to: :entities
          map "subtype_constraints", to: :subtype_constraints
          map "functions", to: :functions
          map "rules", to: :rules
          map "procedures", to: :procedures
        end

        # @return [Array<Declaration>]
        def safe_children
          [
            *constants,
            *types,
            *types&.flat_map(&:enumeration_items),
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

        def full_source
          Expressir::Express::Formatter.format(self)
        end

        def source
          formatter = Class.new(Expressir::Express::Formatter) do
            include Expressir::Express::SchemaHeadFormatter
          end
          formatter.format(self)
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
            next [] unless schema

            safe_children = schema.safe_children
            children_by_id = safe_children.each_with_object({}) do |child, hash|
              hash[child.id.safe_downcase] = child if child.id
            end

            if interface.items.empty?
              safe_children.map do |base_item|
                create_interfaced_item(base_item.id, base_item)
              end
            else
              interface.items.filter_map do |item|
                base_item = children_by_id[item.ref.id.safe_downcase]
                create_interfaced_item(item.id || base_item.id, base_item) if base_item
              end
            end
          end.compact
        end
      end
    end
  end
end
