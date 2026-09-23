# frozen_string_literal: true

module Expressir
  module Express
    # SMRL index XML writer — the shape eengine's wo-smrl-xml.lisp
    # emits (the data layer of the STEP Module Resource Library
    # document set, expressir #276 / TODO.parity-ee 15).
    #
    # Per schema, in eeng's exact layout:
    #   <schema>downcased_name</schema>
    #      <schema_version>...</schema_version>      (when present)
    #     <!-- TYPE n --> ... count comments
    #     <use-from>schema(...)</use-from>           (per interface)
    #     <constant>name</constant>                  (sorted)
    #     <type>SCHEMA.name</type> ... declarations in kind order
    #     (types, entities, subtype_constraints, functions, rules,
    #     procedures), alphabetical inside each kind. In ARM mode
    #     entity names keep their declared case upcased, matching
    #     eeng's ARM rendering.
    module SmrlXml
      module_function

      # @param repository [Model::Repository, #schemas]
      # @param mode [Symbol] :resource (default), :arm, :mim — the
      #   eeng -mode whose case conventions apply to entity names
      # @return [String] the concatenated schema blocks
      def format(repository, mode: :resource)
        schemas = repository.respond_to?(:schemas) ? repository.schemas : Array(repository)
        schemas.map { |schema| format_schema(schema, mode: mode) }.join
      end

      def format_schema(schema, mode: :resource)
        out = +""
        out << "<schema>#{schema.id.downcase}</schema>\n"
        if schema.version&.value
          out << "   <schema_version>#{schema.version.value}</schema_version>\n"
        end
        counts = declaration_counts(schema)
        %i[type entity function procedure rule subtype_constraint].each do |kind|
          label = kind.to_s.split("_").map(&:upcase).join("_")
          out << Kernel.format("  <!-- %-19s %4d -->\n", label, counts[kind])
        end

        interfaces(schema).each do |iface|
          item_list = iface.items.to_a.empty? ? "" : "(...)"
          out << "    <use-from>#{iface.schema.id.downcase}#{item_list}</use-from>\n"
        end

        constants(schema).each do |decl|
          out << "  <constant>#{decl.id.downcase}</constant>\n"
        end

        declarations(schema).each do |kind, decls|
          tag = kind.to_s.tr("_", "-")
          decls.each do |decl|
            out << "  <#{tag}>#{schema.id}.#{name_for(kind, decl.id, mode)}</#{tag}>\n"
          end
        end
        out
      end

      # eeng's entity casing: ARM mode upcases entity names; every
      # other kind and mode is downcased.
      def name_for(kind, id, mode)
        kind == :entity && mode == :arm ? id.upcase : id.downcase
      end

      def declaration_counts(schema)
        {
          type: schema.types.to_a.size,
          entity: schema.entities.to_a.size,
          function: schema.functions.to_a.size,
          procedure: schema.procedures.to_a.size,
          rule: schema.rules.to_a.size,
          subtype_constraint: schema.subtype_constraints.to_a.size,
        }
      end

      def interfaces(schema)
        Array(schema.interfaces)
      end

      def constants(schema)
        schema.constants.to_a.sort_by(&:id)
      end

      # eeng order: types, entities, subtype_constraints, functions,
      # rules, procedures — alphabetical (byte order) inside each.
      COLL_BY_KIND = {
        types: :type,
        entities: :entity,
        subtype_constraints: :subtype_constraint,
        functions: :function,
        rules: :rule,
        procedures: :procedure,
      }.freeze
      private_constant :COLL_BY_KIND

      def declarations(schema)
        COLL_BY_KIND.filter_map do |coll, kind|
          decls = schema.public_send(coll).to_a.sort_by(&:id)
          next if decls.empty?

          [kind, decls]
        end
      end
    end
  end
end
