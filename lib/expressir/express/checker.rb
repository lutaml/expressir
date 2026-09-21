# frozen_string_literal: true

require "set"

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
    #   check-subtype-cycle
    #   check-duplicate-declaration
    #   check-where-name-pattern   (entity, type, rule)
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
      DECL_COLLECTIONS = %i[types entities functions procedures constants rules
                            subtype_constraints].freeze

      attr_reader :notes

      def initialize(repository)
        @repository = repository
        @notes = []
        # Case-folded index to LISTS of schemas: EXPRESS schema ids are
        # case-insensitive, and two schemas differing only in case are
        # distinct declarations that must not silently overwrite each other.
        @by_name = {}
        repository.schemas.compact.each do |schema|
          next unless schema.id

          (@by_name[schema.id.safe_downcase] ||= []) << schema
        end
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

      def report(io = $stdout)
        notes.each do |n|
          io.puts "[#{n.severity}] #{n.id}: #{n.message}"
        end
        io.puts "#{errors.size} error(s), #{warnings.size} warning(s)"
        valid?
      end

      private

      def note!(id, severity, schema, message, node = nil)
        @notes << Note.new(id: id, severity: severity, schema: schema&.id,
                           message: message, node: node)
      end

      def check_schema(schema)
        check_duplicates(schema)
        check_interfaces(schema)
        schema.entities.each { |e| check_entity(schema, e) }
        schema.types.each { |t| check_type(schema, t) }
        schema.types.each { |t| check_where_rules(schema, t, t.where_rules) }
        schema.rules.each { |r| check_where_rules(schema, r, r.where_rules) }
        check_unresolved_refs(schema)
      end

      # Two declarations in one schema sharing a (case-insensitive) name is
      # invalid EXPRESS — the second can never be referenced.
      def check_duplicates(schema)
        seen = {}
        DECL_COLLECTIONS.each do |coll|
          Array(schema.public_send(coll)).each do |decl|
            next unless decl.respond_to?(:id) && decl.id

            key = decl.id.safe_downcase
            if seen.key?(key)
              note!(:check_duplicate_declaration, :error, schema,
                    "duplicate declaration '#{decl.id}' (also declared in " \
                    "#{seen[key]})", decl)
            else
              seen[key] = coll.to_s
            end
          end
        end
      end

      # eeng: check-schema-interface-redundant +
      #       check-schema-iface-resource-duplicate.
      # USE FROM and REFERENCE FROM are different clauses with different
      # semantics; only interfaces of the SAME kind are compared.
      def check_interfaces(schema)
        ifaces = Array(schema.interfaces)
        ifaces.each_with_index do |iface, i|
          target = iface_schema_name(iface)
          next unless target

          later = ifaces[(i + 1)..] || []
          later.each do |other|
            next unless iface_schema_name(other)&.safe_downcase == target.safe_downcase
            next unless other.kind == iface.kind

            a = resource_names(iface)
            b = resource_names(other)
            if a.empty? || b.empty? || (b - a).empty?
              note!(:check_schema_interface_redundant, :warning, schema,
                    "redundant #{iface.kind} interface to #{target}", other)
            else
              dup = a & b
              next if dup.empty?

              note!(:check_schema_iface_resource_duplicate, :warning, schema,
                    "duplicate resources #{dup.join(', ')} on #{iface.kind} " \
                    "interface to #{target}", other)
            end
          end

          foreign = resolve_schema(target)
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
        DECL_COLLECTIONS.any? do |coll|
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
        check_subtype_cycles(schema, entity)

        check_where_rules(schema, entity, entity.where_rules)
        Array(entity.unique_rules).each do |ur|
          next if ur.id.nil? || ur.id.match?(UNIQUE_LABEL)

          note!(:check_unique_name_pattern, :warning, schema,
                "ENTITY #{entity.id}: UNIQUE label '#{ur.id}' is not UR<n>", ur)
        end
      end

      # Follow SUBTYPE OF edges from +entity+; re-reaching a node already on
      # the path is a cycle (self-subtyping included).
      def check_subtype_cycles(schema, entity)
        path = [entity]
        seen_on_path = { entity.id.safe_downcase => true }
        frontier = Array(entity.subtype_of).filter_map do |ref|
          id = ref.is_a?(String) ? ref : ref.id
          find_entity(schema, id) if id
        end
        until frontier.empty?
          current = frontier.pop
          key = current.id.safe_downcase
          if seen_on_path[key]
            note!(:check_subtype_cycle, :error, schema,
                  "ENTITY #{entity.id}: subtype inheritance cycle through " \
                  "'#{current.id}'", entity)
            return
          end
          seen_on_path[key] = true
          path << current
          Array(current.subtype_of).each do |ref|
            id = ref.is_a?(String) ? ref : ref.id
            next unless id

            nxt = find_entity(schema, id)
            frontier << nxt if nxt
          end
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
      # Locally bound identifiers are not unresolved: QUERY variables,
      # REPEAT control variables, attribute names visible in the schema,
      # and the `?` of aggregate bounds (#396).
      def check_unresolved_refs(schema)
        aliases = alias_map(schema)
        bound = bound_identifiers(schema)
        each_node(schema) do |node|
          next unless node.is_a?(Model::References::SimpleReference)
          next if node.base_path
          next if node.parent.is_a?(Model::Declarations::InterfaceItem)
          next if node.parent.is_a?(Model::References::AttributeReference)
          next if node.id.nil? || builtin?(node.id)
          next if aliases.key?(node.id.safe_downcase)
          next if bound.include?(node.id.safe_downcase)

          # Skip self-ids of declarations (entity/type names as the decl itself)
          next if declaration_id?(schema, node)

          note!(:check_unresolved_ref, :error, schema,
                "unresolved reference '#{node.id}'", node)
        end
      end

      # Names the schema's own constructs bind: QUERY variables, REPEAT
      # control variables, attribute names of every entity (including the
      # inherited ones visible through SUBTYPE OF — an over-approximation on
      # purpose, so the error-severity walk never flags a legal identifier).
      def bound_identifiers(schema)
        @bound_identifiers ||= {}.compare_by_identity
        @bound_identifiers[schema] ||= begin
          bound = Set.new(["?"])
          each_node(schema) do |node|
            case node
            when Model::Expressions::QueryExpression, Model::Statements::Repeat
              bound << node.id.safe_downcase if node.respond_to?(:id) && node.id
            end
          end
          schema.entities.each { |e| collect_attribute_names(e, bound) }
          visible_entities(schema).each { |e| collect_attribute_names(e, bound) }
          bound
        end
      end

      def collect_attribute_names(entity, bound)
        Array(entity.attributes).each do |attr|
          bound << attr.id.safe_downcase if attr.respond_to?(:id) && attr.id
        end
      end

      # `USE FROM s (orig AS alias)` makes `alias` the locally visible name;
      # references written with the alias are resolved, not unresolved.
      # Maps alias downcase => [foreign schema, original downcase].
      def alias_map(schema)
        @alias_maps ||= {}.compare_by_identity
        @alias_maps[schema] ||= begin
          map = {}
          Array(schema.interfaces).each do |iface|
            foreign = resolve_schema(iface_schema_name(iface))
            next unless foreign

            Array(iface.items).each do |item|
              original = item.ref.is_a?(String) ? item.ref : item.ref&.id
              next unless original && item.id

              map[item.id.safe_downcase] = [foreign, original.safe_downcase]
            end
          end
          map
        end
      end

      def declaration_id?(schema, node)
        parent = node.parent
        parent.respond_to?(:id) && parent.id&.safe_downcase == node.id.safe_downcase
      end

      BUILTINS = %w[
        integer real number string binary boolean logical generic
        generic_entity aggregate array bag list set
        true false unknown self const_e pi
        abs acos asin atan cos exp format hibound hiindex length
        log log2 log10 lobound loindex nvl odd rolesof sin sizeof
        sqrt tan typeof usedin value value_in value_unique exists
      ].freeze

      def builtin?(id)
        BUILTINS.include?(id.safe_downcase)
      end

      # Resolve a schema id case-insensitively, preferring the exact-case
      # match when several folded ids collide (they are distinct schemas).
      def resolve_schema(name)
        return nil unless name

        group = @by_name[name.safe_downcase]
        return nil unless group

        group.find { |s| s.id == name } || group.first
      end

      def find_entity(schema, id)
        key = id.safe_downcase
        own = schema.entities.find { |e| e.id.safe_downcase == key }
        return own if own

        # interface AS-renames: the alias names a foreign declaration.
        if (aliased = alias_map(schema)[key])
          foreign, original = aliased
          return foreign.entities.find { |e| e.id.safe_downcase == original }
        end

        visible_entities(schema).find { |e| e.id.safe_downcase == key }
      end

      def resolve_type(schema, ref)
        id = ref_id(ref)
        return false unless id

        key = id.safe_downcase
        own = schema.types.find { |t| t.id.safe_downcase == key }
        return true if own

        if (aliased = alias_map(schema)[key])
          foreign, original = aliased
          return foreign.types.any? { |t| t.id.safe_downcase == original }
        end

        visible_types(schema).any? { |t| t.id.safe_downcase == key }
      end

      def ref_id(ref)
        ref.is_a?(String) ? ref : ref&.id
      end

      # Foreign declarations visible through +schema+'s interfaces. With an
      # item list, the LISTED names are AS-imported: match the originals.
      def visible_from(schema, collection)
        Array(schema.interfaces).flat_map do |iface|
          foreign = resolve_schema(iface_schema_name(iface))
          next [] unless foreign

          names = resource_names(iface)
          decls = Array(foreign.public_send(collection))
          names.empty? ? decls : decls.select { |d| names.include?(d.id.safe_downcase) }
        end
      end

      def visible_entities(schema)
        visible_from(schema, :entities)
      end

      def visible_types(schema)
        visible_from(schema, :types)
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
