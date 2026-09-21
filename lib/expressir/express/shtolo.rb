# frozen_string_literal: true

module Expressir
  module Express
    # SHTOLO — short-to-long conversion per ISO 10303-11:2004 Annex G
    # (expressir#32): flattens a multi-schema specification into a
    # single ISO 10303-11:1994 longform schema.
    #
    # Two stages (annex-g-rules.md):
    #  G.1  multi-schema → intermediate `artifact` schema: interface
    #       closure copied as local declarations, renames resolved to
    #       original names, name clashes munged (G.NM.1), REFERENCE
    #       entities kept with the dependent-instantiability rule
    #       (G.1.6), select/rules/supertype expressions pruned (G.1.9).
    #  G.2  artifact → `longform`: extensible enums/selects resolved
    #       (G.2.3/G.2.4), subtype constraints eliminated (supertype
    #       expression → SUPERTYPE, total_over → rule, G.2.5), abstract
    #       entity → ABSTRACT SUPERTYPE, GENERIC_ENTITY → GENERIC,
    #       RENAMED → DERIVE (G.2.7), qualified strings rewritten.
    #
    # The output is a Model::Declarations::Schema named per the root
    # schema; format it with the Formatter to obtain the longform file.
    class Shtolo
      DEPENDENT_RULE_NAME = "validate_dependently_instantiable_entity_data_types"
      DEPENDENT_FN_NAME = "dependently_instantiated"

      attr_reader :longform, :renames, :schema

      # `root_schema` — the resolved root schema node.
      # `repository`  — must hold the full interface closure.
      def initialize(root_schema, repository, longform_name: nil)
        @root = root_schema
        @repository = repository
        @longform_name = longform_name || @root.id
        @renames = {}          # munged/alias name => original name
        @reference_entities = [] # G.1.6 entities
      end

      def flatten
        @schema = build_longform
        self
      end

      private

      # ---- interface closure (same semantics as Concatenator) ----

      def closure
        @closure ||= begin
          by_name = @repository.schemas.to_h { |s| [s.id.safe_downcase, s] }
          visited = {}
          queue = [@root]
          until queue.empty?
            schema = queue.shift
            key = schema.id.safe_downcase
            next if visited.key?(key)

            visited[key] = schema
            Array(schema.interfaces).each do |iface|
              name = iface.schema.is_a?(String) ? iface.schema : iface.schema&.id
              next unless name

              target = by_name[name.safe_downcase]
              queue << target if target && !visited.key?(name.safe_downcase)
            end
          end
          visited
        end
      end

      # ---- G.1 stage 1 ----

      def build_artifact
        declarations = []
        seen = {}

        # Root first (primary schema), then supporting schemas.
        [@root, *closure.values.reject { |s| s.equal?(@root) }].each do |schema|
          rename_map = renames_for(schema)

          schema.constants.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.types.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.entities.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.subtype_constraints.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.functions.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.procedures.each { |d| declarations << copy_decl(d, rename_map, seen) }
          schema.rules.each { |d| declarations << copy_decl(d, rename_map, seen) }

          # G.1.2: interfaces themselves dissolve; REFERENCE entities
          # keep dependent-instantiability semantics (G.1.6).
          schema.interfaces.each do |iface|
            next unless iface.kind == Model::Declarations::Interface::REFERENCE

            iface.items.each do |item|
              original = original_name(item, schema)
              next unless (decl = closure[original]&.entities&.find { |e| e.id == original })

              @reference_entities << original.safe_downcase
            end
          end
        end

        declarations << build_dependent_rule if @reference_entities.any?

        Model::Declarations::Schema.new(
          id: @longform_name,
          version: nil,
          interfaces: [],
          constants: declarations.grep(Model::Declarations::Constant).compact,
          types: declarations.grep(Model::Declarations::Type).compact,
          entities: declarations.grep(Model::Declarations::Entity).compact,
          subtype_constraints: declarations.grep(Model::Declarations::SubtypeConstraint).compact,
          functions: declarations.grep(Model::Declarations::Function).compact,
          procedures: declarations.grep(Model::Declarations::Procedure).compact,
          rules: declarations.grep(Model::Declarations::Rule).compact
        )
      end

      # Alias → original map applied when copying `schema`'s
      # declarations: the aliases are declared by the schema's own
      # interface items (`USE FROM s (orig AS alias)`, G.1.3).
      def renames_for(schema)
        map = {}
        Array(schema.interfaces).each do |iface|
          iface.items.each do |item|
            original = item.ref.is_a?(String) ? item.ref : item.ref&.id
            next unless original

            map[item.id.safe_downcase] = original if item.id &&
                                                    item.id.safe_downcase != original.safe_downcase
          end
        end
        map
      end

      def original_name(item, schema)
        original = item.ref.is_a?(String) ? item.ref : item.ref&.id
        return schema.id unless original

        original
      end

      def copy_decl(decl, rename_map, seen)
        copy = deep_copy(decl)
        @renames.each_key { |from| rewrite_references(copy, from, @renames[from]) }
        rename_map.each do |alias_name, original|
          rewrite_references(copy, alias_name, original)
        end
        if copy.respond_to?(:id) && copy.id
          munged = munge(copy.id, seen)
          if munged != copy.id
            @renames[copy.id.safe_downcase] = munged
            rewrite_references(copy, copy.id, munged)
            copy.id = munged
          end
          seen[copy.id.safe_downcase] = true
        end
        copy
      end

      # G.NM.1: clash ⇒ `<schema>_dot_<name>`.
      def munge(id, seen)
        return id unless seen.key?(id.safe_downcase)

        owner = owner_schema_of(id) || "longform"
        "#{owner.safe_downcase}_dot_#{id}"
      end

      def owner_schema_of(id)
        closure.each_value do |schema|
          return schema.id if schema.safe_children.any? { |c| c.id&.safe_downcase == id.safe_downcase }
        end
        nil
      end

      def deep_copy(obj)
        Marshal.load(Marshal.dump(obj))
      rescue StandardError
        obj.dup
      end

      # Rewrite SimpleReference ids per the rename map, expressions and
      # types included.
      def rewrite_references(node, from, to)
        return unless node.is_a?(Model::ModelElement)

        if node.is_a?(Model::References::SimpleReference) && node.id&.safe_downcase == from
          node.id = preserve_case(node.id, to)
        end
        node.class.attributes.each_key do |attr|
          next if Model::ModelElement::SKIP_ATTRIBUTES.include?(attr) || attr == :parent

          value = node.public_send(attr)
          case value
          when Array then value.each { |item| rewrite_references(item, from, to) }
          when Model::ModelElement then rewrite_references(value, from, to)
          end
        end
      end

      def preserve_case(current, new)
        current == current.upcase ? new.upcase : new
      end

      # G.1.6: parse-templates keep the annex rule/function verbatim.
      def build_dependent_rule
        list = @reference_entities.map(&:upcase).join(", ")
        union = @reference_entities.join("+")
        src = <<~EXP
          SCHEMA __dependent__;
          RULE #{DEPENDENT_RULE_NAME} FOR (#{list});
          LOCAL
            number_of_input_instances : INTEGER;
            previous_in_chain : LIST OF GENERIC := [];
            set_of_input_types : SET OF STRING := [];
            all_instances : SET OF GENERIC := [];
          END_LOCAL;
          all_instances := #{union};
          WHERE
            wr1: dependently_instantiated(all_instances, set_of_input_types, previous_in_chain);
          END_RULE;
          END_SCHEMA;
        EXP
        parse_schema_snippet(src).schemas.first.rules.first
      end

      def parse_schema_snippet(src)
        Expressir::Express::Parser.from_exp(src)
      end

      # ---- G.2 stage 2 ----

      def build_longform
        artifact = build_artifact

        resolve_extensible_enumerations!(artifact)
        resolve_extensible_selects!(artifact)
        eliminate_subtype_constraints!(artifact)
        convert_abstract_entities!(artifact)
        convert_generic_entities!(artifact)
        convert_renamed_attributes!(artifact)
        rewrite_qualified_strings!(artifact)

        artifact
      end

      def resolve_extensible_enumerations!(schema)
        schema.types.select do |t|
          t.underlying_type.is_a?(Model::DataTypes::Enumeration) && t.underlying_type.extensible
        end.each do |base|
          enum = base.underlying_type
          extensions = schema.types.select do |t|
            t.underlying_type.is_a?(Model::DataTypes::Enumeration) &&
              !t.underlying_type.extensible &&
              t.underlying_type.based_on&.id&.safe_downcase == base.id.safe_downcase
          end
          merged = enum.items.map(&:id) +
                   extensions.flat_map { |x| x.underlying_type.items.map(&:id) }
          enum.items = merged.uniq.map { |id| Model::DataTypes::EnumerationItem.new(id: id) }
          enum.extensible = false
          enum.based_on = nil

          extensions.each do |ext|
            ext_items = ext.underlying_type.items.map(&:id)
            exclusions = merged - ext_items
            ext.underlying_type = Model::DataTypes::Enumeration.new(
              items: enum.items
            )
            ext.where_rules = exclusions.each_with_index.map do |item, i|
              Model::Declarations::WhereRule.new(
                id: "wr#{i + 1}",
                expression: parse_expression("SELF <> #{item};")
              )
            end
          end
        end
      end

      def resolve_extensible_selects!(schema)
        schema.types.select do |t|
          t.underlying_type.is_a?(Model::DataTypes::Select) && t.underlying_type.extensible
        end.each do |base|
          sel = base.underlying_type
          extensions = schema.types.select do |t|
            t.underlying_type.is_a?(Model::DataTypes::Select) &&
              !t.underlying_type.extensible &&
              t.underlying_type.based_on&.id&.safe_downcase == base.id.safe_downcase
          end
          merged_items = sel.items +
                         extensions.flat_map { |x| x.underlying_type.items }
          seen_ids = {}
          uniq = merged_items.select do |item|
            key = item.id.safe_downcase
            next false if seen_ids.key?(key) || key.empty?

            seen_ids[key] = true
          end
          sel.items = uniq
          sel.extensible = false
          sel.based_on = nil

          extensions.each do |ext|
            keep = ext.underlying_type.items.map { |i| i.id.upcase }
            exclusions = uniq.reject { |i| keep.include?(i.id.upcase) }
            base_ref = "#{@longform_name.upcase}.#{base.id.upcase}"
            ext.underlying_type = Model::DataTypes::Select.new(
              items: sel.items.map { |i| Model::References::SimpleReference.new(id: i.id) }
            )
            ext.where_rules = exclusions.each_with_index.map do |item, i|
              Model::Declarations::WhereRule.new(
                id: "wr#{i + 1}",
                expression: parse_expression("NOT ('#{base_ref}.#{item.id.upcase}' IN TYPEOF(SELF));")
              )
            end
          end
        end
      end

      def eliminate_subtype_constraints!(schema)
        schema.subtype_constraints.each do |sc|
          entity = schema.entities.find do |e|
            e.id.safe_downcase == sc.applies_to&.id&.safe_downcase
          end
          next unless entity

          if sc.supertype_expression
            expr = sc.supertype_expression
            entity.supertype_expression =
              entity.supertype_expression ? combine_andor(entity.supertype_expression, expr) : expr
          end
          if entity.abstract
            # G.2.6: abstract entity ⇒ ABSTRACT SUPERTYPE (formatter
            # renders from abstract + supertype status).
          end
          next if Array(sc.total_over).empty?

          rule_name = "total_over_#{sc.id}"
          targets = Array(sc.total_over).map { |r| r.id.upcase }
          supertype = sc.applies_to&.id
          rule = parse_schema_snippet(<<~EXP).schemas.first.rules.first
            SCHEMA __to__;
            RULE #{rule_name} FOR (#{supertype.upcase});
            WHERE
              wr1: SIZEOF(QUERY(#{supertype.downcase}_i <* #{supertype} |
                SIZEOF(['#{@longform_name.upcase}.#{targets.first}'] * TYPEOF(#{supertype.downcase}_i)) = 0)) = 0;
            END_RULE;
            END_SCHEMA;
          EXP
          rule.id = rule_name
          schema.rules = Array(schema.rules) + [rule]
        end
        schema.subtype_constraints = []
      end

      def combine_andor(left, right)
        Expressir::Model::Expressions::BinaryExpression.new(
          operator: "ANDOR", operand1: left, operand2: right
        )
      rescue StandardError
        left
      end

      def convert_abstract_entities!(schema)
        schema.entities.each do |entity|
          next unless entity.abstract

          entity.abstract = true # formatter renders ABSTRACT SUPERTYPE when supertype present
        end
      end

      def convert_generic_entities!(schema)
        each_node(schema) do |node|
          replace_in_parent(node, Model::DataTypes::Generic.new) if node.is_a?(Model::DataTypes::GenericEntity)
        end
      end

      def replace_in_parent(node, replacement)
        parent = node.parent
        return unless parent

        parent.class.attributes.each_key do |attr|
          next if Model::ModelElement::SKIP_ATTRIBUTES.include?(attr)

          value = parent.public_send(attr)
          case value
          when Array
            value.each_with_index do |item, index|
              parent.public_send(attr)[index] = replacement if item.equal?(node)
            end
          else
            parent.public_send(:"#{attr}=", replacement) if value.equal?(node) && parent.respond_to?(:"#{attr}=")
          end
        end
      end

      def convert_renamed_attributes!(schema)
        schema.entities.each do |entity|
          entity.attributes.each_with_index do |attr, i|
            next unless attr.supertype_attribute

            old_name, supertype = supertype_target(attr.supertype_attribute)
            entity.attributes[i] = Model::Declarations::DerivedAttribute.new(
              id: attr.id || old_name,
              type: attr.type,
              expression: parse_expression("SELF\\#{supertype}.#{old_name}")
            )
          end
        end
      end

      # `SELF\ENTITY.attr` parses as AttributeReference(ref: GroupReference
      # (SELF, entity), attribute: attr); a bare qualified attribute has
      # only the attribute name.
      def supertype_target(ref)
        return [ref.id, nil] unless ref.is_a?(Model::References::AttributeReference)

        group = ref.ref
        [ref.attribute&.id,
         group.is_a?(Model::References::GroupReference) ? group.entity&.id : nil]
      end

      # G.NM.2: string literals carrying schema-qualified names (e.g.
      # TYPEOF arguments 'SCHEMA.TYPE') move to the longform name.
      # Structurally these appear as DataTypes::String; path references
      # in expressions are already renamed by the copy pass.
      def rewrite_qualified_strings!(schema)
        prefixes = closure.keys.map(&:upcase)
        each_node(schema) do |node|
          next unless node.is_a?(Model::Literals::String) && node.value

          node.value = node.value.sub(/\A(#{prefixes.join('|')})\./i,
                                      "#{@longform_name.upcase}.")
        end
      end

      # Attribute-driven structural traversal over the whole subtree.
      def each_node(root, &block)
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

      def parse_expression(src)
        snippet = "SCHEMA __x__; ENTITY __e__; WHERE w1 : #{src.chomp(';')}; END_ENTITY; END_SCHEMA;"
        parsed = parse_schema_snippet(snippet)
        parsed.schemas.first.entities.first.where_rules.first.expression
      end
    end
  end
end
