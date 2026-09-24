# frozen_string_literal: true

module Expressir
  module Mapping
    # Formalization, parser, and validator for MIM reference paths
    # (expressir#88): the "Reference path" sections of module
    # mapping.yaml files, written in the ISO 10303 module mapping
    # notation. Until now the notation was prose for humans only; this
    # makes it machine-readable and checks it against real schemas.
    #
    # Grammar (corpus-verified over all module mapping.yaml refpaths):
    #   path       := step+
    #   step       := [link] node [index] [constraint]
    #               | MARKER
    #   link       := "->" | "<=" | "=>"     (relation to the previous node)
    #   node       := NAME ["." ATTRIBUTE]
    #   index      := "[" ("i" | DIGITS) "]"
    #   MARKER     := "{" | "}" | "[" | "]"  (grouping; no node semantics)
    #   constraint := "=" STRING
    #
    # Operator semantics per the module conventions:
    #   ->   the attribute named before -> references the entity or
    #        select type named after ->
    #   <=   the entity named before <= is a subtype of the entity after
    #   =>   the entity named before => is a supertype of the entity after
    #   [i]  the attribute named before [i] is an aggregate; any element
    #        of that aggregate is referred to
    module RefPath
      # Wire-name mapping is declared here so a parsed path can itself
      # be serialized with lutaml-model.
      class Step < Lutaml::Model::Serializable
        attribute :operator, :string
        attribute :name, :string
        attribute :attribute, :string
        attribute :index, :string
        attribute :literal, :string

        key_value do
          map "operator", to: :operator
          map "name", to: :name
          map "attribute", to: :attribute
          map "index", to: :index
          map "literal", to: :literal
        end
      end

      class Path < Lutaml::Model::Serializable
        attribute :steps, Step, collection: true
        attribute :parse_errors, :string, collection: true

        key_value do
          map "steps", to: :steps
          map "parse_errors", to: :parse_errors
        end
      end

      TOKEN = /->|<=|=>|[{}\[\]=]|'(?:''|[^'])*'|\w+(?:\.\w+)?/
      MARKERS = ["{", "}", "[", "]"].freeze
      LINKS = ["->", "<=", "=>"].freeze
      DECLARATION_COLLECTIONS = %i[types entities].freeze
      private_constant :TOKEN, :MARKERS, :LINKS, :DECLARATION_COLLECTIONS

      Issue = Struct.new(:step, :message, keyword_init: true)

      module_function

      # @param content [String] the mapping.yaml refpath content block
      # @return [Path]
      def parse(content)
        tokens = content.to_s.scan(TOKEN)
        steps = []
        errors = []
        pending_link = nil
        i = 0
        while i < tokens.length
          token = tokens[i]
          case token
          when *LINKS
            pending_link = token
          when "="
            literal = tokens[i + 1]
            if literal&.start_with?("'")
              attach(steps, errors, :literal, literal)
              i += 1
            else
              errors << "constraint '=' without a string literal"
            end
          when "["
            if index_token?(tokens[i + 1])
              attach(steps, errors, :index, tokens[i + 1])
              i += 2 # the index token and the closing "]"
            else
              steps << Step.new(operator: "[")
            end
          when *MARKERS
            steps << Step.new(operator: token)
          else
            name, _, attribute = token.partition(".")
            steps << Step.new(operator: pending_link, name: name,
                              attribute: attribute.empty? ? nil : attribute)
            pending_link = nil
          end
          i += 1
        end
        Path.new(steps: steps, parse_errors: errors)
      end

      def index_token?(token)
        token == "i" || token&.match?(/\A\d+\z/)
      end

      # Attach an index or constraint literal to the most recent node
      # step that does not carry one yet.
      def attach(steps, errors, field, value)
        step = steps.reverse.each.find { |s| s.name && !s.public_send(field) }
        if step
          step.public_send("#{field}=", value)
        else
          case field
          when :index then errors << "aggregate index [#{value}] has no node"
          when :literal then errors << "constraint #{value} has no node"
          end
        end
      end

      # Validate a parsed path against a repository. Issues reference
      # the step index they attach to.
      # @return [Array<Issue>]
      def validate(path, repository)
        by_name = name_index(repository)
        issues = []
        prev = nil
        path.steps.each_with_index do |step, pos|
          if MARKERS.include?(step.operator)
            prev = nil
            next
          end

          issues.concat(check_step(step, pos, prev, by_name))
          prev = step if step.name
        end
        issues
      end

      def name_index(repository)
        repository.schemas.flat_map do |schema|
          DECLARATION_COLLECTIONS.flat_map do |coll|
            Array(schema.public_send(coll))
              .select { |d| d.respond_to?(:id) && d.id }
              .map { |d| [d.id.safe_downcase, [schema, d]] }
          end
        end.to_h
      end

      def check_step(step, pos, prev, by_name)
        found = by_name[step.name&.safe_downcase]
        return [Issue.new(step: pos, message: "unknown type '#{step.name}'")] unless found

        issues = attribute_issues(step, pos, found[1], by_name)
        issues.concat(link_issues(step, pos, prev, by_name))
        issues
      end

      def attribute_issues(step, pos, decl, by_name)
        return [] unless step.attribute

        unless decl.is_a?(Model::Declarations::Entity)
          return [Issue.new(step: pos,
                            message: "'#{step.name}' is not an entity, " \
                                     "cannot carry '#{step.name}.#{step.attribute}'")]
        end

        attribute = find_attribute(decl, step.attribute, by_name)
        unless attribute
          return [Issue.new(step: pos,
                            message: "entity '#{step.name}' has no attribute " \
                                     "'#{step.attribute}'")]
        end

        aggregate_issue(step, pos, attribute)
      end

      # Direct or inherited attribute: inheritance follows the
      # subtype_of chain, resolved through the repository-wide index.
      def find_attribute(entity, attribute_id, by_name)
        key = attribute_id.safe_downcase
        supertype_chain(entity, by_name).lazy.flat_map do |candidate|
          Array(candidate.attributes)
        end.find { |a| a.id&.safe_downcase == key }
      end

      def supertype_chain(entity, by_name)
        seen = {}.compare_by_identity
        queue = [entity]
        result = []
        until queue.empty?
          current = queue.shift
          next if seen[current]

          seen[current] = true
          result << current
          current.subtype_of.to_a.each do |ref|
            sup = by_name[ref.respond_to?(:id) ? ref.id&.safe_downcase : nil]&.last
            queue << sup if sup.is_a?(Model::Declarations::Entity)
          end
        end
        result
      end

      def aggregate_issue(step, pos, attribute)
        return [] unless step.index
        return [] if attribute.type.respond_to?(:bound1)

        [Issue.new(step: pos,
                   message: "'#{step.name}.#{step.attribute}' is not an " \
                            "aggregate but carries [#{step.index}]")]
      end

      def link_issues(step, pos, prev, by_name)
        return [] unless LINKS.include?(step.operator)
        unless prev && step.name
          return [Issue.new(step: pos,
                            message: "#{step.operator} with no preceding node")]
        end

        case step.operator
        when "->" then attribute_link_issues(step, pos, prev)
        when "<=" then subtype_link_issues(step, pos, prev, by_name)
        when "=>" then supertype_link_issues(step, pos, prev, by_name)
        end
      end

      def attribute_link_issues(_step, pos, prev)
        unless prev.attribute
          return [Issue.new(step: pos,
                            message: "'->' requires an attribute-qualified " \
                                     "node before it, got '#{prev.name}'")]
        end

        []
      end

      # `a <= b`: a is a subtype of b.
      def subtype_link_issues(step, pos, prev, by_name)
        source = by_name[prev.name&.safe_downcase]&.last
        target = by_name[step.name&.safe_downcase]&.last
        return [] unless source.is_a?(Model::Declarations::Entity) &&
          target.is_a?(Model::Declarations::Entity)

        return [] if supertype_ids(source, by_name)
          .any? { |id| id&.safe_downcase == step.name&.safe_downcase }

        [Issue.new(step: pos,
                   message: "'#{prev.name}' is not a subtype of '#{step.name}'")]
      end

      # `a => b`: a is a supertype of b.
      def supertype_link_issues(step, pos, prev, by_name)
        source = by_name[step.name&.safe_downcase]&.last
        target = by_name[prev.name&.safe_downcase]&.last
        return [] unless source.is_a?(Model::Declarations::Entity) &&
          target.is_a?(Model::Declarations::Entity)

        return [] if supertype_ids(source, by_name)
          .any? { |id| id&.safe_downcase == prev.name&.safe_downcase }

        [Issue.new(step: pos,
                   message: "'#{prev.name}' is not a supertype of '#{step.name}'")]
      end

      # Supertype entity names of +entity+: the subtype_of references
      # plus the leaves of the supertype expression tree, resolved
      # through the repository-wide name index so inherited chains
      # (including cross-schema USE FROM) walk correctly.
      def supertype_ids(entity, by_name)
        seen = {}.compare_by_identity
        queue = [entity]
        names = []
        until queue.empty?
          current = queue.shift
          next if seen[current]

          seen[current] = true
          direct = current.subtype_of.to_a.filter_map do |ref|
            ref.respond_to?(:id) ? ref.id : nil
          end
          leaves = expression_leaves(current.supertype_expression)
            .filter_map { |leaf| leaf.respond_to?(:id) ? leaf.id : nil }
          names.concat(direct)
          names.concat(leaves)
          direct.concat(leaves).each do |id|
            sup = by_name[id&.safe_downcase]&.last
            queue << sup if sup.is_a?(Model::Declarations::Entity)
          end
        end
        names.uniq
      end

      # Leaf reference nodes of a supertype expression tree.
      def expression_leaves(expr)
        return [] unless expr

        if expr.respond_to?(:operands)
          Array(expr.operands).flat_map { |o| expression_leaves(o) }
        elsif expr.respond_to?(:operand1)
          expression_leaves(expr.operand1) + expression_leaves(expr.operand2)
        elsif expr.respond_to?(:id) && expr.id
          [expr]
        else
          []
        end
      end
    end
  end
end
