# frozen_string_literal: true

module Expressir
  module Express
    # Semantic checks modeled on eeng kernel/check.lisp + check-notes.lisp
    # (expressir parity-ee stage 07). Each note preserves the eeng note id
    # so oracle differentials stay cross-referenceable.
    #
    # Coverage is a deliberate subset of eeng's check-p11 catalog:
    #   check-schema-interface-redundant
    #   check-schema-iface-resource-duplicate
    #   check-subtype-ref
    #   check-where-name-pattern
    #   check-unique-name-pattern
    #   check-unresolved-ref   (aggregate of eeng type/entity unparsed notes)
    #   check-select-extended-type
    #   check-enumeration-extended-type
    #
    # Severity: :error stops a clean SHTOLO run; :warning is advisory.
    class Checker
      Note = Struct.new(:id, :severity, :schema, :message, :node, keyword_init: true)

      WHERE_LABEL = /\AWR\d+\z/i
      UNIQUE_LABEL = /\AUR\d+\z/i

      attr_reader :notes

      def initialize(repository)
        @repository = repository
        @notes = []
        @by_name = repository.schemas.compact.to_h { |s| [s.id.safe_downcase, s] }
      end

      def check
        @notes = []
        @repository.schemas.compact.each { |schema| check_schema(schema) }
        self
      end

      def errors
        notes.select { |n| n.severity == :error }
      end

      def warnings
        notes.select { |n| n.severity == :warning }
      end

      def valid?
        errors.empty?
      end

      def write_report(io = $stdout)
        notes.each do |n|
          io.puts "[#{n.severity}] #{n.id}: #{n.message}"
        end
        io.puts "#{errors.size} error(s), #{warnings.size} warning(s)"
        io
      end

      BUILTINS = %w[
        integer real number string binary boolean logical generic
        generic_entity aggregate array bag list set
        true false unknown self const_e pi
        abs acos asin atan cos exp format hibound hiindex length
        log log2 log10 lobound loindex nvl odd rolesof sin sizeof
        sqrt tan typeof usedin value value_in value_unique exists
      ].freeze

      private

      def note!(id, severity, schema, message, node = nil)
        @notes << Note.new(id: id, severity: severity, schema: schema&.id,
                           message: message, node: node)
      end

      def check_schema(schema)
        check_interfaces(schema)
        schema.entities.each { |e| check_entity(schema, e) }
        schema.types.each { |t| check_type(schema, t) }
        schema.rules.each { |r| check_where_rules(schema, r, r.where_rules) }
        schema.functions.each { |f| check_where_rules(schema, f, f.where_rules) if f.respond_to?(:where_rules) }
        schema.procedures.each { |p| check_where_rules(schema, p, p.where_rules) if p.respond_to?(:where_rules) }
        check_unresolved_refs(schema)
      end

      # eeng: check-schema-interface-redundant +
      #       check-schema-iface-resource-duplicate
      def check_interfaces(schema)
        ifaces = Array(schema.interfaces)
        ifaces.each_with_index do |iface, i|
          target = iface_schema_name(iface)
          next unless target

          later = ifaces[(i + 1)..] || []
          later.each do |other|
            next unless iface_schema_name(other)&.safe_downcase == target.safe_downcase

            a = resource_names(iface)
            b = resource_names(other)
            if a.empty? || b.empty? || (b - a).empty?
              note!(:check_schema_interface_redundant, :warning, schema,
                    "redundant interface to #{target}", other)
            else
              dup = a & b
              next if dup.empty?

              note!(:check_schema_iface_resource_duplicate, :warning, schema,
                    "duplicate resources #{dup.join(', ')} on interface to #{target}",
                    other)
            end
          end

          foreign = @by_name[target.safe_downcase]
          unless foreign
            note!(:check_unresolved_ref, :error, schema,
                  "interface schema '#{target}' not found", iface)
            next
          end

          resource_names(iface).each do |name|
            next if foreign_decl?(foreign, name)

            note!(:check_unresolved_ref, :error, schema,
                  "interface resource '#{name}' not in schema '#{target}'", iface)
          end
        end
      end

      def iface_schema_name(iface)
        iface.schema.is_a?(String) ? iface.schema : iface.schema&.id
      end

      def resource_names(iface)
        Array(iface.items).filter_map do |item|
          ref = item.ref.is_a?(String) ? item.ref : item.ref&.id
          ref || item.id
        end.map(&:safe_downcase)
      end

      def foreign_decl?(schema, name)
        key = name.safe_downcase
        %i[types entities functions procedures constants rules
           subtype_constraints].any? do |coll|
          Array(schema.public_send(coll)).any? { |d| d.id&.safe_downcase == key }
        end
      end

      def check_entity(schema, entity)
        Array(entity.subtype_of).each do |ref|
          id = ref.is_a?(String) ? ref : ref.id
          next if id.nil? || find_entity(schema, id)

          note!(:check_subtype_ref, :error, schema,
                "ENTITY #{entity.id}: subtype '#{id}' not found", entity)
        end

        check_where_rules(schema, entity, entity.where_rules)
        Array(entity.unique_rules).each do |ur|
          next if ur.id.nil? || ur.id.match?(UNIQUE_LABEL)

          note!(:check_unique_name_pattern, :warning, schema,
                "ENTITY #{entity.id}: UNIQUE label '#{ur.id}' is not UR<n>", ur)
        end
      end

      def check_where_rules(schema, owner, rules)
        Array(rules).each do |wr|
          next if wr.id.nil? || wr.id.match?(WHERE_LABEL)

          note!(:check_where_name_pattern, :warning, schema,
                "#{owner.class.name.split('::').last} #{owner.id}: " \
                "WHERE label '#{wr.id}' is not WR<n>", wr)
        end
      end

      def check_type(schema, type)
        ut = type.underlying_type
        case ut
        when Model::DataTypes::Select
          if ut.based_on && !resolve_type(schema, ut.based_on)
            note!(:check_select_extended_type, :error, schema,
                  "TYPE #{type.id}: BASED_ON '#{ref_id(ut.based_on)}' not found", type)
          end
        when Model::DataTypes::Enumeration
          if ut.based_on && !resolve_type(schema, ut.based_on)
            note!(:check_enumeration_extended_type, :error, schema,
                  "TYPE #{type.id}: BASED_ON '#{ref_id(ut.based_on)}' not found", type)
          end
        end
      end

      # Walk SimpleReferences whose base_path was never filled in by the
      # resolver — the expressir equivalent of eeng's unparsed-type notes.
      def check_unresolved_refs(schema)
        each_node(schema) do |node|
          next unless node.is_a?(Model::References::SimpleReference)
          next if node.base_path
          next if node.parent.is_a?(Model::Declarations::InterfaceItem)
          next if node.parent.is_a?(Model::References::AttributeReference)
          next if node.id.nil? || builtin?(node.id)

          # Skip self-ids of declarations (entity/type names as the decl itself)
          next if declaration_id?(schema, node)

          note!(:check_unresolved_ref, :error, schema,
                "unresolved reference '#{node.id}'", node)
        end
      end

      def declaration_id?(_schema, node)
        parent = node.parent
        parent.respond_to?(:id) && parent.id&.safe_downcase == node.id.safe_downcase
      end

      def builtin?(id)
        BUILTINS.include?(id.safe_downcase)
      end

      def find_entity(schema, id)
        key = id.safe_downcase
        schema.entities.find { |e| e.id.safe_downcase == key } ||
          visible_entities(schema).find { |e| e.id.safe_downcase == key }
      end

      def resolve_type(schema, ref)
        id = ref_id(ref)
        return false unless id

        key = id.safe_downcase
        schema.types.any? { |t| t.id.safe_downcase == key } ||
          visible_types(schema).any? { |t| t.id.safe_downcase == key }
      end

      def ref_id(ref)
        ref.is_a?(String) ? ref : ref&.id
      end

      def visible_entities(schema)
        Array(schema.interfaces).flat_map do |iface|
          foreign = @by_name[iface_schema_name(iface)&.safe_downcase]
          next [] unless foreign

          names = resource_names(iface)
          ents = foreign.entities
          names.empty? ? ents : ents.select { |e| names.include?(e.id.safe_downcase) }
        end
      end

      def visible_types(schema)
        Array(schema.interfaces).flat_map do |iface|
          foreign = @by_name[iface_schema_name(iface)&.safe_downcase]
          next [] unless foreign

          names = resource_names(iface)
          types = foreign.types
          names.empty? ? types : types.select { |t| names.include?(t.id.safe_downcase) }
        end
      end

      def each_node(root)
        stack = [root]
        until stack.empty?
          node = stack.pop
          yield node
          next unless node.is_a?(Model::ModelElement)

          node.class.attributes.each_key do |attr|
            next if Model::ModelElement::SKIP_ATTRIBUTES.include?(attr)

            value = node.public_send(attr)
            case value
            when Array then value.each { |item| stack << item if item.is_a?(Model::ModelElement) }
            when Model::ModelElement then stack << value
            end
          end
        end
      end
    end
  end
end
