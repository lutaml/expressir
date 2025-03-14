module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class Schema < ModelElement
        # TODO: MIGRATE: Set `file` path
        # def file
        #   node_options[FILE_KEY.to_sym] = root_path ? File.expand_path("#{root_path}/#{hash[FILE_KEY]}") : hash[FILE_KEY]
        # end

        # TODO: MIGRATE: Implement formatting of `source`
        # def source
        #   if self.class.method_defined?(:source) && formatter
        #     hash[SOURCE_KEY] = formatter.format(self)
        #   end
        # end

        # TODO: MIGRATE: These were from the SchemaDrop object, we need to make
        # these available in Liquid.
        #
        # def file_basename
        #   File.basename(@model.file, ".exp")
        # end
        #
        # def selected
        #   @selected_schemas&.include?(@model.id) ||
        #     @selected_schemas&.include?(file_basename)
        # end
        #
        # def relative_path_prefix
        #   return nil if @options.nil? || @options["document"].nil?
        #
        #   document = @options["document"]
        #   file_path = File.dirname(@model.file)
        #   docfile_directory = File.dirname(
        #     document.attributes["docfile"] || ".",
        #   )
        #   document
        #     .path_resolver
        #     .system_path(file_path, docfile_directory)
        # end
        #
        # def remarks
        #   return [] unless @model.remarks
        #
        #   options = @options || {}
        #   options["relative_path_prefix"] = relative_path_prefix
        #
        #   @model.remarks.map do |remark|
        #     ::Expressir::Express::ExpressRemarksDecorator
        #       .call(remark, options)
        #   end
        # end
        #
        # def formatted
        #   @model.to_s(no_remarks: true)
        # end

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
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
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
