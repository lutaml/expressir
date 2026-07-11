# frozen_string_literal: true

module Expressir
  module Express
    # Handles attaching remarks (comments) to model elements after parsing.
    #
    # Two collaborators sit behind the `attach` interface:
    # - {ScopeResolver} answers "which scope contains line N?"
    # - {NodePositionIndex} answers "which model node is nearest line N?"
    #
    # Remark scanning itself lives in {RemarkScanner}; line→byte lookup lives
    # in {LineMap}. This class is the orchestrator: it walks the remarks, asks
    # the collaborators for targets, and writes the remarks onto the model.
    #
    # NOTE: Post-processing remark attachment has inherent limitations for scope-based
    # matching. Remarks with simple tags (like "WR1") inside scopes (TYPE, ENTITY, etc.)
    # cannot be perfectly matched without parsing context. This implementation prioritizes:
    # 1. Exact path matches (e.g., "schema.entity.WR1")
    # 2. Proximity-based matching for simple tags
    # 3. NOT creating spurious schema-level items for ambiguous tags
    class RemarkAttacher
      # Type-driven registry: maps each model class to its collection attributes.
      # Shared with {NodePositionIndex} via that class's own copy of the table.
      # Two declarations rather than a cross-reference so each module is loadable
      # on its own without forcing the other to load.
      COLLECTION_REGISTRY = NodePositionIndex::COLLECTION_REGISTRY

      # Expression and statement child attributes for QueryExpression search.
      # Targeted traversal prevents over-matching on unrelated model attributes.
      EXPRESSION_CHILDREN = {
        Model::Expressions::BinaryExpression => %i[operand1 operand2],
        Model::Expressions::UnaryExpression => %i[operand],
        Model::Expressions::QueryExpression => %i[expression aggregate_source],
        Model::Expressions::AggregateInitializerItem => %i[expression
                                                           repetition],
        Model::Expressions::Interval => %i[low item high],
        Model::Expressions::FunctionCall => %i[parameters],
        Model::Expressions::EntityConstructor => %i[parameters],
        Model::Expressions::AggregateInitializer => %i[items],
        Model::Statements::Assignment => %i[expression],
        Model::Statements::If => %i[expression],
        Model::Statements::Case => %i[expression],
        Model::Statements::CaseAction => %i[expression],
        Model::Statements::Repeat => %i[while_expression until_expression],
      }.freeze

      def initialize(source)
        @source = source
        @attached_spans = Set.new
        @line_map = LineMap.new(source.b)
        @model = nil
        @scope_resolver = nil
        @node_index = nil
      end

      def attach(model)
        @model = model
        remarks = RemarkScanner.new(@source).scan

        @node_index = NodePositionIndex.new(model, @line_map)
        @scope_resolver = ScopeResolver.new(
          source: @source,
          model: model,
          nodes_with_positions: @node_index.nodes,
        )

        attach_tagged_remarks(remarks)
        attach_untagged_remarks(remarks)

        # Free expensive data structures after attachment is complete.
        @source = nil
        @scope_resolver = nil
        @node_index = nil
        @line_map = nil

        model
      end

      private

      # ----- Tagged remark attachment -----

      def attach_tagged_remarks(remarks)
        tagged = remarks.select(&:tag)
        return if tagged.empty?

        tagged.each do |remark|
          next if @attached_spans.include?(remark.position)

          tag = remark.tag
          target = nil

          containing_scope = @scope_resolver.containing_scope_for(remark.line)

          # Check if this is an informal proposition tag (IP\d+)
          if tag.match?(/^IP\d+$/)
            scope = containing_scope || @scope_resolver.find_by_source_text(remark.line)
            if scope && supports_informal_propositions?(scope)
              target = create_or_find_informal_proposition(scope, tag)
            end
          end

          # Standard path-based lookup
          if target.nil?
            # Handle prefixed tags like wr:WR1, ip:IP1, ur:UR1
            if tag.include?(":") && !tag.include?(".")
              target = handle_prefixed_tag(tag, containing_scope, @model,
                                           get_schema_ids(@model))
            end

            # Strategy 1: Try exact path lookup
            if target.nil?
              target = find_by_exact_path(@model, tag)
            end

            # Strategy 1b: For paths with dots, try with scope path prefix first
            if target.nil? && tag.include?(".")
              if containing_scope && function_rule_procedure?(containing_scope)
                scope_path = build_scope_path(containing_scope)
                if scope_path
                  target = find_by_exact_path(@model, "#{scope_path}.#{tag}")
                end
              end

              if target.nil?
                schema_ids = get_schema_ids(@model)
                schema_ids.each do |schema_id|
                  target = find_by_exact_path(@model, "#{schema_id}.#{tag}")
                  break if target
                end
              end
            end

            # Strategy 2: For simple tags, find in containing scope first
            if target.nil? && !tag.include?(".")
              if containing_scope
                target = find_node_in_scope(containing_scope, tag)

                if target.nil? && supports_where_rules?(containing_scope)
                  target = find_target_in_where_clause(containing_scope, tag,
                                                       remark.line)
                end

                if target.nil? && !function_rule_procedure?(containing_scope)
                  schema_ids = get_schema_ids(@model)
                  schema_ids.each do |schema_id|
                    target = find_by_exact_path(@model, "#{schema_id}.#{tag}")
                    break if target
                  end
                end
              else
                schema_ids = get_schema_ids(@model)
                schema_ids.each do |schema_id|
                  target = find_by_exact_path(@model, "#{schema_id}.#{tag}")
                  break if target
                end
              end
            end

            # Strategy 3: Create implicit item for qualified paths only
            if target.nil? && tag.include?(".")
              if containing_scope && function_rule_procedure?(containing_scope)
                scope_path = build_scope_path(containing_scope)
                if scope_path
                  target = create_implicit_remark_item(@model, "#{scope_path}.#{tag}",
                                                       get_schema_ids(@model))
                end
              end
              if target.nil?
                target = create_implicit_remark_item(@model, tag,
                                                     get_schema_ids(@model))
              end
            end

            # Strategy 4: For simple tags at schema level, create implicit item
            if target.nil? && !tag.include?(".")
              schema_ids = get_schema_ids(@model)
              if schema_ids.any?
                target = create_implicit_remark_item_at_schema(@model, tag,
                                                               schema_ids.first)
              end
            end
          end

          if target
            add_remark(target, remark.text, format: remark.format, tag: remark.tag)
            @attached_spans << remark.position
          end
        end
      end

      # ----- Untagged remark attachment -----

      def attach_untagged_remarks(remarks)
        untagged = remarks.reject(&:tag)
        return unless untagged.any?

        untagged.each do |remark|
          next if @attached_spans.include?(remark.position)

          line_content = line_content_for(remark.line)
          if end_scope_line?(line_content)
            matched_node = @node_index.node_for_end_scope_at(remark.line, line_content)
            if matched_node
              add_remark(matched_node, remark.text, format: remark.format, tag: nil)
              @attached_spans << remark.position
              next
            end
          end

          matched_node = @node_index.nearest_node_to(remark.line)
          if matched_node
            add_remark(matched_node, remark.text, format: remark.format, tag: nil)
            @attached_spans << remark.position
          end
        end
      end

      def end_scope_line?(line_content)
        line_content =~ /END_(SCHEMA|ENTITY|TYPE|FUNCTION|PROCEDURE|RULE)/i
      end

      # ----- Tag resolution (within a scope) -----

      def find_node_in_scope(scope, tag)
        return nil unless scope

        collections_on(scope).each do |collection|
          collection.each do |item|
            next unless item.is_a?(Model::HasRemarks)
            return item if item.id == tag
          end
        end

        types = get_collection(scope, :types)
        types&.each do |type|
          result = find_enumeration_item_in_type(type, tag)
          return result if result
        end

        statements = get_collection(scope, :statements)
        statements&.each do |stmt|
          result = find_node_in_statement(stmt, tag)
          return result if result

          result = find_query_in_expression(stmt, tag)
          return result if result
        end

        nil
      end

      def find_enumeration_item_in_type(type, tag)
        return nil unless type
        return nil unless type.is_a?(Model::Declarations::Type)

        type.enumeration_items&.each do |item|
          return item if item.id == tag
        end

        ut = type.underlying_type
        return nil unless ut.is_a?(Model::DataTypes::Enumeration) && ut.items

        ut.items.each { |item| return item if item.id == tag }
        nil
      end

      def find_query_in_expression(node, tag, visited = Set.new)
        return nil unless node
        return nil unless node.is_a?(Model::ModelElement)
        return nil if visited.include?(node.object_id)

        visited.add(node.object_id)

        return node if node.is_a?(Model::Expressions::QueryExpression) && node.id == tag

        attrs = EXPRESSION_CHILDREN[node.class]
        return nil unless attrs

        attrs.each do |attr|
          value = node.public_send(attr)
          case value
          when Array
            value.each do |val|
              next unless val.is_a?(Model::ModelElement)

              result = find_query_in_expression(val, tag, visited)
              return result if result
            end
          when Model::ModelElement
            result = find_query_in_expression(value, tag, visited)
            return result if result
          end
        end

        nil
      end

      def function_rule_procedure?(node)
        return false unless node

        node.is_a?(Model::Declarations::Function) ||
          node.is_a?(Model::Declarations::Rule) ||
          node.is_a?(Model::Declarations::Procedure)
      end

      # Handle prefixed tags like wr:WR1, ip:IP1, ur:UR1
      def handle_prefixed_tag(tag, containing_scope, model, schema_ids)
        prefix, id = tag.split(":")
        return nil unless id

        collection_attr = case prefix.downcase
                          when "wr" then :where_rules
                          when "ip" then :informal_propositions
                          when "ur" then :unique_rules
                          end
        return nil unless collection_attr

        collection = get_collection(containing_scope, collection_attr)
        if collection
          found = collection.find { |item| item.is_a?(Model::ModelElement) && item.id == id }
          return found if found
        end

        schema_ids.each do |schema_id|
          full_path = "#{schema_id}.#{tag.tr(':', '.')}"
          found = safe_find(model, full_path)
          return found if found
        end

        nil
      end

      # Find target for remarks inside WHERE clauses by scanning source lines
      # for `WHERE <id>:` patterns. Lives here (not in ScopeResolver) because
      # it's about WHERE-rule membership, not scope membership.
      def find_target_in_where_clause(scope, tag, remark_line)
        return nil unless supports_where_rules?(scope)

        where_rules = get_collection(scope, :where_rules)
        return nil unless where_rules&.any?

        lines = source_lines_for_where_clause

        where_rules.each do |wr|
          next unless wr.id

          lines.each_with_index do |line, idx|
            line_num = idx + 1
            next unless line_num < remark_line

            if (line =~ /^\s*WHERE\s+#{Regexp.escape(wr.id)}\s*:/i) && remark_line.between?(line_num, line_num + 5)
              return create_remark_item(wr, tag)
            end
          end
        end

        nil
      end

      def source_lines_for_where_clause
        # @source is set for the duration of `attach`; freed at the end.
        @source.lines
      end

      def find_node_in_statement(stmt, tag)
        case stmt
        when Model::Statements::Alias
          return stmt if stmt.id == tag
        when Model::Statements::Repeat
          return stmt if stmt.id == tag
        when Model::Expressions::QueryExpression
          return stmt if stmt.id == tag
        end
        nil
      end

      def build_scope_path(node)
        return nil unless node

        parts = []
        current = node

        while current
          if current.is_a?(Model::ModelElement) && current.id
            parts.unshift(current.id)
          end

          break if current.is_a?(Model::Declarations::Schema)

          current = current.parent
        end

        parts.empty? ? nil : parts.join(".")
      end

      # ----- Path-based lookup -----

      def find_by_exact_path(model, path)
        return nil unless path
        return nil unless repository?(model) || exp_file?(model)

        result = safe_find(model, path)
        return result if result

        normalized = path.tr(":", ".")
        normalized == path ? nil : safe_find(model, normalized)
      end

      # ----- Target creation -----

      def create_implicit_remark_item_at_schema(model, item_id, schema_id)
        return nil unless repository?(model) || exp_file?(model)

        schema = safe_find(model, schema_id)
        return nil unless schema.is_a?(Model::Declarations::Schema)

        if item_id.match?(/^IP\d+$/) && supports_informal_propositions?(schema)
          return create_or_find_informal_proposition(schema, item_id)
        end

        return nil unless supports_remark_items?(schema)

        existing = schema.remark_items&.find { |ri| ri.id == item_id }
        return existing if existing

        create_remark_item(schema, item_id)
      end

      def create_implicit_remark_item(model, path, schema_ids = [])
        return nil unless repository?(model) || exp_file?(model)

        clean_path = normalize_path(path)
        parts = clean_path.split(".")
        return nil if parts.length < 2

        (parts.length - 1).downto(1) do |i|
          parent_path = parts[0...i].join(".")
          item_id = parts[i]

          parent = safe_find(model, parent_path)

          if parent.nil? && schema_ids.any?
            schema_ids.each do |schema_id|
              parent = safe_find(model, "#{schema_id}.#{parent_path}")
              break if parent
            end
          end

          next unless parent

          return create_item_at_parent(parent, item_id)
        end

        nil
      end

      def normalize_path(path)
        return path unless path.include?(":")

        path_part, _, item_suffix = path.rpartition(":")
        "#{path_part}.#{item_suffix}"
      end

      def create_item_at_parent(parent, item_id)
        if item_id.match?(/^IP\d+$/) && supports_informal_propositions?(parent)
          return create_or_find_informal_proposition(parent, item_id)
        end

        return nil unless supports_remark_items?(parent)

        existing = parent.remark_items&.find { |ri| ri.id == item_id }
        return existing if existing

        create_remark_item(parent, item_id)
      end

      def create_or_find_informal_proposition(parent, id)
        return nil unless supports_informal_propositions?(parent)

        existing = parent.informal_propositions&.find { |ip| ip.id == id }
        return existing if existing

        ip = Model::Declarations::InformalPropositionRule.new(id: id)
        ip.parent = parent
        parent.informal_propositions ||= []
        parent.informal_propositions << ip
        safe_reset_children_by_id(parent)

        remark_item = Model::Declarations::RemarkItem.new(id: id)
        remark_item.parent = ip
        ip.remark_items ||= []
        ip.remark_items << remark_item
        safe_reset_children_by_id(ip)

        remark_item
      end

      def create_remark_item(parent, id)
        item = Model::Declarations::RemarkItem.new(id: id)
        item.parent = parent
        parent.remark_items ||= []
        parent.remark_items << item
        safe_reset_children_by_id(parent)
        item
      end

      # ----- Remark storage -----

      def add_remark(node, text, format: Model::RemarkFormat::TAIL, tag: nil)
        return unless node
        return unless node.is_a?(Model::ModelElement)

        if supports_remarks?(node)
          if node_has_remarks?(node)
            node.remarks ||= []
            node.remarks << text
          end

          if tag.nil?
            remark_info = Model::RemarkInfo.new(text: text, format: format)
            node.untagged_remarks ||= []
            node.untagged_remarks << remark_info
          end
        end
      end

      # ----- Type predicates -----

      def supports_remarks?(obj)
        obj.is_a?(Model::ModelElement)
      end

      def node_has_remarks?(obj)
        obj.is_a?(Model::HasRemarks)
      end

      def supports_remark_items?(obj)
        obj.is_a?(Model::HasRemarkItems)
      end

      def supports_informal_propositions?(obj)
        obj.is_a?(Model::HasInformalPropositions)
      end

      def supports_where_rules?(obj)
        obj.is_a?(Model::HasWhereRules)
      end

      def repository?(obj)
        obj.is_a?(Model::Repository)
      end

      def exp_file?(obj)
        obj.is_a?(Model::ExpFile)
      end

      def cache?(obj)
        obj.is_a?(Model::Cache)
      end

      def get_schema_ids(model)
        if repository?(model) || exp_file?(model)
          model.schemas.filter_map(&:id)
        else
          []
        end
      end

      # ----- Collection access -----

      # Type-driven collection access — returns all collections for a node's type.
      def collections_on(node)
        attrs = COLLECTION_REGISTRY[node.class]
        return [] unless attrs

        attrs.filter_map do |attr|
          col = node.public_send(attr)
          col if col.is_a?(Array)
        end
      end

      # Type-driven single collection access — returns one named collection if the type has it.
      def get_collection(node, attr_name)
        return nil unless COLLECTION_REGISTRY[node.class]&.include?(attr_name)

        collection = node.public_send(attr_name)
        collection if collection.is_a?(Array)
      end

      # ----- Helpers -----

      def safe_find(model, path)
        return nil unless model

        model.find(path)
      rescue StandardError
        nil
      end

      def safe_reset_children_by_id(obj)
        return unless obj
        return unless obj.is_a?(Model::ScopeContainer)

        obj.reset_children_by_id
      end

      def line_content_for(line_num)
        lines = source_lines_for_where_clause
        return "" if line_num < 1 || line_num > lines.length

        lines[line_num - 1]
      end
    end
  end
end
