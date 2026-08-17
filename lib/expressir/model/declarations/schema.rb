module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class Schema < ModelElement
        include Identifier
        include ScopeContainer

        # Tree-walker collection attributes (TODO.bugs/12 — single source
        # of truth; NodePositionIndex derives COLLECTION_REGISTRY from this).
        collection_attributes :interfaces, :constants, :types, :entities,
                              :subtype_constraints, :functions, :rules,
                              :procedures, :remark_items

        # Subset of this schema's collection attributes that hold named
        # scope declarations (Function, Procedure, Rule, Entity, Type).
        # Used by ScopeResolver to enumerate scope-capable children without
        # duplicating the list. Single source of truth: this is the subset
        # of NodePositionIndex::COLLECTION_REGISTRY[Schema] that holds
        # scopes rather than remark_items / constants / subtype_constraints.
        SCOPE_DECL_COLLECTIONS = %i[
          functions procedures rules entities types
        ].freeze

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
        attribute :header, :string
        attribute :_class, :string, default: -> { self.class.name }
        attribute :selected, :boolean, default: false
        attribute :file_basename, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "id", to: :id
          map "file", to: :file
          map "header", to: :header
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

        liquid do
          map :header, to: :header
          map :formatted, to: :formatted
          map :source, to: :source
          map :full_source, to: :full_source
          map :children, to: :children
          map :safe_children, to: :safe_children
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
          @full_source ||= Expressir::Express::Formatter.format(self)
        end

        def formatted
          @formatted ||= format(no_remarks: false)
        end

        def source
          @source ||= Expressir::Express::SchemaSourceFormatter.format(self)
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

          visited_schemas = {}
          interfaces.flat_map do |interface|
            items_for_interface(interface, visited_schemas)
          end.compact
        end

        private

        # Direct items of one interface plus the items visible through
        # the foreign schema's own USE interfaces (transitive USE
        # visibility, eeng :use-only → :use-from recursion).
        def items_for_interface(interface, visited_schemas)
          schema = foreign_schema(interface.schema.id.safe_downcase)
          return [] unless schema
          return [] if visited_schemas.key?(schema.id.safe_downcase) &&
                       interface.items.empty?

          visited_schemas[schema.id.safe_downcase] = true

          safe_children = schema.safe_children
          children_by_id = safe_children.each_with_object({}) do |child, hash|
            hash[child.id.safe_downcase] = child if child.id
          end

          own = if interface.items.empty?
                  safe_children.map do |base_item|
                    create_interfaced_item(base_item.id, base_item)
                  end
                else
                  interface.items.filter_map do |item|
                    base_item = children_by_id[item.ref.id.safe_downcase]
                    if base_item
                      create_interfaced_item(item.id || base_item.id,
                                             base_item)
                    end
                  end
                end

          # Transitive items are not restricted by this interface's
          # item list: implicit interfacing through USE is unfiltered
          # (eeng :use-only → :use-from recursion finds any id in the
          # foreign schema's use scope).
          own + schema.interfaces.filter_map do |foreign_iface|
            next nil unless foreign_iface.kind == Interface::USE

            foreign_items = items_for_interface(foreign_iface,
                                                visited_schemas)
            foreign_items.empty? ? nil : foreign_items
          end.flatten
        end

        # Find a foreign schema by name: same file first, then the
        # enclosing repository (expressir's compiled/batch repository).
        def foreign_schema(name)
          current = parent
          while current
            return current.children_by_id[name] if current.respond_to?(:children_by_id) &&
                                                   current.children_by_id[name]

            current = current.is_a?(ModelElement) ? current.parent : nil
          end
          nil
        end
      end
    end
  end
end
