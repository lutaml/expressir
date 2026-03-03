# frozen_string_literal: true

require "set"

module Expressir
  module Express
    # Handles attaching remarks (comments) to model elements after parsing.
    #
    # NOTE: Post-processing remark attachment has inherent limitations for scope-based
    # matching. Remarks with simple tags (like "WR1") inside scopes (TYPE, ENTITY, etc.)
    # cannot be perfectly matched without parsing context. This implementation prioritizes:
    # 1. Exact path matches (e.g., "schema.entity.WR1")
    # 2. Proximity-based matching for simple tags
    # 3. NOT creating spurious schema-level items for ambiguous tags
    class RemarkAttacher
      def initialize(source)
        @source = source
        @attached_spans = Set.new
        @line_cache = {}
        @model = nil
      end

      def attach(model)
        @model = model
        remarks = extract_all_remarks
        attach_tagged_remarks(model, remarks)
        attach_untagged_remarks(model, remarks)
        model
      end

      private

      def extract_all_remarks
        remarks = []
        position = 0

        @source.each_line.with_index do |line, line_idx|
          if (dash_idx = line.index("--"))
            remark_text = line[(dash_idx + 2)..].strip

            # Check for special patterns like --IP1: content (informal proposition)
            if remark_text.match?(/^IP\d+:\s*(.*)$/)
              tag = remark_text[/^(IP\d+):/, 1]
              content = remark_text[/^IP\d+:\s*(.*)$/, 1]
              remarks << {
                position: position + dash_idx,
                line: line_idx + 1,
                text: content,
                tag: tag,
                format: "tail",
              }
            else
              tag, content = parse_tagged_remark(remark_text)
              remarks << {
                position: position + dash_idx,
                line: line_idx + 1,
                text: content || remark_text,
                tag: tag,
                format: "tail",
              }
            end
          end
          position += line.length
        end

        extract_embedded_remarks(remarks)
        # Sort by position to ensure remarks are processed in source order
        remarks.sort_by! { |r| r[:position] }
        remarks
      end

      def extract_embedded_remarks(remarks)
        start_pos = 0
        while (start_idx = @source.index("(*", start_pos))
          end_idx = @source.index("*)", start_idx + 2)
          break unless end_idx

          content = @source[(start_idx + 2)...end_idx]
          line_num = get_line_number(start_idx)

          tag, text = parse_tagged_embedded_remark(content)

          remarks << {
            position: start_idx,
            line: line_num,
            text: text,
            tag: tag,
            format: "embedded",
          }

          start_pos = end_idx + 2
        end
      end

      def parse_tagged_remark(text)
        if text.start_with?('"') && (end_quote = text.index('"', 1))
          [text[1...end_quote], text[(end_quote + 1)..].strip]
        else
          [nil, text]
        end
      end

      def parse_tagged_embedded_remark(content)
        stripped = content.strip
        if stripped.start_with?('"') && (end_quote = stripped.index('"', 1))
          [stripped[1...end_quote], stripped[(end_quote + 1)..].strip]
        else
          [nil, stripped]
        end
      end

      def get_line_number(position)
        return 1 if position.nil? || position.zero?

        @line_cache[position] ||= @source[0...position].count("\n") + 1
      end

      def attach_tagged_remarks(model, remarks)
        schema_ids = model.respond_to?(:schemas) ? model.schemas.filter_map(&:id) : []

        # Collect nodes with positions for finding containing scopes
        nodes_with_positions = []
        collect_nodes_with_positions(model, nodes_with_positions)
        nodes_with_positions.sort_by! { |n| n[:position] || Float::INFINITY }

        remarks.select do |r|
          r[:tag]
        end.sort_by { |r| r[:position] }.each do |remark|
          next if @attached_spans.include?(remark[:position])

          tag = remark[:tag]
          target = nil

          # Check if this is an informal proposition tag (IP\d+)
          if tag.match?(/^IP\d+$/)
            # Find the containing scope (entity, type, rule) that supports informal propositions
            target = find_containing_scope_for_ip(remark[:line],
                                                  nodes_with_positions)
            if target
              # Create or find the informal proposition
              target = create_or_find_informal_proposition(target, tag)
            end
          end

          # Standard path-based lookup
          if target.nil?
            # Find containing scope for scope-aware path resolution
            containing_scope = find_containing_scope(remark[:line],
                                                     nodes_with_positions)

            # Handle prefixed tags like wr:WR1, ip:IP1, ur:UR1
            if tag.include?(":") && !tag.include?(".")
              target = handle_prefixed_tag(tag, containing_scope, model,
                                           schema_ids)
            end

            # Strategy 1: Try exact path lookup
            if target.nil?
              target = find_by_exact_path(model, tag)
            end

            # Strategy 1b: For paths with dots, try with scope path prefix first
            if target.nil? && tag.include?(".")
              # First, try building full path from containing scope
              if containing_scope && is_function_rule_procedure?(containing_scope)
                scope_path = build_scope_path(containing_scope)
                if scope_path
                  full_path = "#{scope_path}.#{tag}"
                  target = find_by_exact_path(model, full_path)
                end
              end

              # Then try schema prefix
              if target.nil?
                schema_ids.each do |schema_id|
                  target = find_by_exact_path(model, "#{schema_id}.#{tag}")
                  break if target
                end
              end
            end

            # Strategy 2: For simple tags, find in containing scope first
            if target.nil? && !tag.include?(".")
              if containing_scope
                # Search within the containing scope
                target = find_node_in_scope(containing_scope, tag)

                # Special handling for remarks inside WHERE clauses
                if target.nil? && containing_scope.respond_to?(:where_rules)
                  target = find_target_in_where_clause(containing_scope, tag,
                                                       remark[:line])
                end

                # Only fall back to schema prefix if NOT inside a function/rule/procedure
                # This prevents remarks inside scopes from attaching to schema-level items
                if target.nil? && !is_function_rule_procedure?(containing_scope)
                  schema_ids.each do |schema_id|
                    target = find_by_exact_path(model, "#{schema_id}.#{tag}")
                    break if target
                  end
                end
              else
                # No containing scope, try with schema prefix
                schema_ids.each do |schema_id|
                  target = find_by_exact_path(model, "#{schema_id}.#{tag}")
                  break if target
                end
              end
            end

            # Strategy 3: Create implicit item for qualified paths only
            if target.nil? && tag.include?(".")
              # Try with scope path first
              if containing_scope && is_function_rule_procedure?(containing_scope)
                scope_path = build_scope_path(containing_scope)
                if scope_path
                  full_path = "#{scope_path}.#{tag}"
                  target = create_implicit_remark_item(model, full_path,
                                                       schema_ids)
                end
              end
              # Fall back to schema prefix
              if target.nil?
                target = create_implicit_remark_item(model, tag, schema_ids)
              end
            end

            # Strategy 4: For simple tags at schema level, create implicit item
            if target.nil? && !tag.include?(".") && schema_ids.any?
              target = create_implicit_remark_item_at_schema(model, tag,
                                                             schema_ids.first)
            end
          end

          if target
            add_remark(target, remark[:text], format: remark[:format],
                                              tag: remark[:tag])
            @attached_spans << remark[:position]
          end
        end
      end

      def find_node_in_scope(scope, tag)
        return nil unless scope

        # Search within the scope for a node with the given tag/id
        # Check all collections that might contain nodes with ids
        %i[constants types variables parameters statements
           attributes derived_attributes inverse_attributes
           where_rules unique_rules informal_propositions].each do |attr|
          next unless scope.respond_to?(attr)

          collection = scope.send(attr)
          next unless collection

          collection.each do |item|
            next unless item.respond_to?(:id)
            return item if item.id == tag
          end
        end

        # Search inside types for enumeration items
        if scope.respond_to?(:types)
          scope.types&.each do |type|
            result = find_enumeration_item_in_type(type, tag)
            return result if result
          end
        end

        # Search inside statements for nested items (alias, repeat, query)
        if scope.respond_to?(:statements)
          scope.statements&.each do |stmt|
            result = find_node_in_statement(stmt, tag)
            return result if result
          end
        end

        # Search inside expressions for QueryExpression (nested in assignments, etc.)
        if scope.respond_to?(:statements)
          scope.statements&.each do |stmt|
            result = find_query_in_expression(stmt, tag)
            return result if result
          end
        end

        nil
      end

      def find_enumeration_item_in_type(type, tag)
        return nil unless type

        # Check if type has enumeration_items method
        if type.respond_to?(:enumeration_items)
          type.enumeration_items&.each do |item|
            return item if item.id == tag
          end
        end

        # Also check underlying_type if it's an enumeration
        if type.respond_to?(:underlying_type) && type.underlying_type
          ut = type.underlying_type
          if ut.is_a?(Model::DataTypes::Enumeration) && ut.items
            ut.items.each do |item|
              return item if item.id == tag
            end
          end
        end

        nil
      end

      def find_query_in_expression(node, tag, visited = Set.new)
        return nil unless node
        return nil if visited.include?(node.object_id)

        visited.add(node.object_id)

        # Check if this node is a QueryExpression with matching id
        if node.is_a?(Model::Expressions::QueryExpression) && node.id == tag
          return node
        end

        # Recursively search expression attributes
        %i[expression operand left right condition aggregate
           query_expression repeat_control].each do |attr|
          next unless node.respond_to?(attr)

          child = node.send(attr)
          next unless child

          result = find_query_in_expression(child, tag, visited)
          return result if result
        end

        # Search in arrays
        %i[expressions operands parameters arguments].each do |attr|
          next unless node.respond_to?(attr)

          children = node.send(attr)
          next unless children.is_a?(Array)

          children.each do |child|
            result = find_query_in_expression(child, tag, visited)
            return result if result
          end
        end

        nil
      end

      def is_function_rule_procedure?(node)
        return false unless node

        node.is_a?(Model::Declarations::Function) ||
          node.is_a?(Model::Declarations::Rule) ||
          node.is_a?(Model::Declarations::Procedure)
      end

      # Handle prefixed tags like wr:WR1, ip:IP1, ur:UR1
      def handle_prefixed_tag(tag, containing_scope, model, schema_ids)
        prefix, id = tag.split(":")
        return nil unless id

        # Determine collection based on prefix
        collection_attr = case prefix.downcase
                          when "wr" then :where_rules
                          when "ip" then :informal_propositions
                          when "ur" then :unique_rules
                          end
        return nil unless collection_attr

        # First try to find in containing scope
        if containing_scope.respond_to?(collection_attr)
          collection = containing_scope.send(collection_attr)
          if collection
            found = collection.find { |item| item.id == id }
            return found if found
          end
        end

        # Fallback: try to find by full path
        schema_ids.each do |schema_id|
          full_path = "#{schema_id}.#{tag.tr(':', '.')}"
          found = begin
            model.find(full_path)
          rescue StandardError
            nil
          end
          return found if found
        end

        nil
      end

      # Find target for remarks inside WHERE clauses
      def find_target_in_where_clause(scope, tag, remark_line)
        return nil unless scope.respond_to?(:where_rules)

        where_rules = scope.where_rules
        return nil unless where_rules&.any?

        # Search source text for WHERE clause containing this remark
        lines = @source.lines

        where_rules.each do |wr|
          next unless wr.id

          # Find the WHERE rule declaration
          lines.each_with_index do |line, idx|
            line_num = idx + 1
            next unless line_num < remark_line

            # Look for "WHERE {id}:" pattern
            # Check if remark is within a few lines after this WHERE declaration
            if (line =~ /^\s*WHERE\s+#{Regexp.escape(wr.id)}\s*:/i) && remark_line.between?(
              line_num, line_num + 5
            )
              # Found the WHERE rule - create remark item inside it
              return create_remark_item(wr, tag)
            end
          end
        end

        nil
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

      def find_containing_scope(remark_line, nodes_with_positions)
        # First try text-based detection (more reliable when source tracking is broken)
        text_based_scope = find_scope_by_text_search(remark_line)
        return text_based_scope if text_based_scope

        # Fallback to position-based detection
        containing_nodes = nodes_with_positions.select do |n|
          n[:line] && n[:end_line] && remark_line >= n[:line] && remark_line <= n[:end_line]
        end

        # Return the innermost scope container (function, procedure, rule, entity, type)
        scope_classes = [
          Model::Declarations::Function,
          Model::Declarations::Procedure,
          Model::Declarations::Rule,
          Model::Declarations::Entity,
          Model::Declarations::Type,
          Model::Declarations::Schema,
        ]

        containing_nodes.reverse_each do |n|
          node = n[:node]
          scope_classes.each do |scope_class|
            return node if node.is_a?(scope_class)
          end
        end

        nil
      end

      def find_scope_by_text_search(remark_line)
        lines = @source.lines
        return nil if remark_line < 1 || remark_line > lines.length

        # Track nested scopes by searching backwards from remark_line
        scope_stack = []

        lines.each_with_index do |line, idx|
          line_num = idx + 1
          break if line_num > remark_line

          # Check for START keywords first
          if line =~ /^\s*SCHEMA\s+(\w+)/i
            scope_stack << { type: :schema, name: $1, line: line_num }
          end

          if line =~ /^\s*FUNCTION\s+(\w+)/i
            scope_stack << { type: :function, name: $1, line: line_num }
          end

          if line =~ /^\s*PROCEDURE\s+(\w+)/i
            scope_stack << { type: :procedure, name: $1, line: line_num }
          end

          if line =~ /^\s*RULE\s+(\w+)/i
            scope_stack << { type: :rule, name: $1, line: line_num }
          end

          if line =~ /^\s*ENTITY\s+(\w+)/i
            scope_stack << { type: :entity, name: $1, line: line_num }
          end

          if line =~ /^\s*TYPE\s+(\w+)/i
            scope_stack << { type: :type, name: $1, line: line_num }
          end

          # Then check for END keywords (to handle inline closures on same line)
          if (line =~ /END_TYPE/i) && (scope_stack.last&.dig(:type) == :type)
            scope_stack.pop
          end
          if (line =~ /END_FUNCTION/i) && (scope_stack.last&.dig(:type) == :function)
            scope_stack.pop
          end
          if (line =~ /END_PROCEDURE/i) && (scope_stack.last&.dig(:type) == :procedure)
            scope_stack.pop
          end
          if (line =~ /END_RULE/i) && (scope_stack.last&.dig(:type) == :rule)
            scope_stack.pop
          end
          if (line =~ /END_ENTITY/i) && (scope_stack.last&.dig(:type) == :entity)
            scope_stack.pop
          end
          if (line =~ /END_SCHEMA/i) && (scope_stack.last&.dig(:type) == :schema)
            scope_stack.pop
          end
        end

        # Find the innermost scope and get the corresponding model node
        return nil if scope_stack.empty?

        innermost = scope_stack.last
        find_scope_node(innermost[:type], innermost[:name])
      end

      def find_scope_node(type, name)
        return nil unless @model && name

        @model.schemas.each do |schema|
          # Check schema itself
          if type == :schema && schema.id == name
            return schema
          end

          # Check schema-level declarations
          case type
          when :function
            found = schema.functions&.find { |f| f.id == name }
            return found if found
          when :procedure
            found = schema.procedures&.find { |p| p.id == name }
            return found if found
          when :rule
            found = schema.rules&.find { |r| r.id == name }
            return found if found
          when :entity
            found = schema.entities&.find { |e| e.id == name }
            return found if found
          when :type
            found = schema.types&.find { |t| t.id == name }
            return found if found
          end
        end

        nil
      end

      def build_scope_path(node)
        return nil unless node

        parts = []
        current = node

        while current
          if current.respond_to?(:id) && current.id
            parts.unshift(current.id)
          end

          # Stop at schema level
          break if current.is_a?(Model::Declarations::Schema)

          current = current.respond_to?(:parent) ? current.parent : nil
        end

        parts.empty? ? nil : parts.join(".")
      end

      def find_containing_scope_for_ip(remark_line, nodes_with_positions)
        # Find nodes that contain this remark line
        containing_nodes = nodes_with_positions.select do |n|
          n[:line] && n[:end_line] && remark_line >= n[:line] && remark_line <= n[:end_line]
        end

        # Find the innermost node that supports informal propositions
        # Priority: Entity, Rule, Type, Schema
        if containing_nodes.any?
          containing_nodes.reverse_each do |n|
            node = n[:node]
            if (node.is_a?(Model::Declarations::Entity) ||
                node.is_a?(Model::Declarations::Rule) ||
                node.is_a?(Model::Declarations::Type)) && node.class.method_defined?(:informal_propositions)
              return node
            end

            # Fallback to schema
            node = n[:node]
            return node if node.is_a?(Model::Declarations::Schema)
          end
        end

        # Fallback: search for containing entity/type/rule by source text
        find_scope_by_source_text(remark_line)
      end

      def find_scope_by_source_text(remark_line)
        # Search backwards from remark_line for containing scope
        lines = @source.lines

        # Find the entity/type/rule that contains this line
        entity_start = nil
        type_start = nil
        rule_start = nil
        current_entity = nil
        current_type = nil
        current_rule = nil

        lines.each_with_index do |line, idx|
          line_num = idx + 1

          case line
          when /^\s*ENTITY\s+(\w+)/i
            entity_start = line_num
            current_entity = $1
          when /^\s*END_ENTITY/i
            if entity_start && remark_line >= entity_start && remark_line <= line_num
              # Found containing entity
              return find_node_by_type_and_name(Model::Declarations::Entity,
                                                current_entity)
            end

            entity_start = nil
            current_entity = nil
          when /^\s*TYPE\s+(\w+)/i
            type_start = line_num
            current_type = $1
          when /^\s*END_TYPE/i
            if type_start && remark_line >= type_start && remark_line <= line_num
              # Found containing type
              return find_node_by_type_and_name(Model::Declarations::Type,
                                                current_type)
            end

            type_start = nil
            current_type = nil
          when /^\s*RULE\s+(\w+)/i
            rule_start = line_num
            current_rule = $1
          when /^\s*END_RULE/i
            if rule_start && remark_line >= rule_start && remark_line <= line_num
              # Found containing rule
              return find_node_by_type_and_name(Model::Declarations::Rule,
                                                current_rule)
            end

            rule_start = nil
            current_rule = nil
          end
        end

        nil
      end

      def find_node_by_type_and_name(node_class, name)
        return nil unless @model && name

        # Search through all schemas
        @model.schemas.each do |schema|
          collection = case node_class.name
                       when "Expressir::Model::Declarations::Entity"
                         schema.entities
                       when "Expressir::Model::Declarations::Type"
                         schema.types
                       when "Expressir::Model::Declarations::Rule"
                         schema.rules
                       end

          if collection
            found = collection.find { |n| n.id == name }
            return found if found
          end
        end

        nil
      end

      def find_by_exact_path(model, path)
        return nil unless path && model.respond_to?(:find)

        # Try original path
        result = model.find(path)
        return result if result

        # Try with colon converted to dot
        normalized = path.tr(":", ".")
        normalized == path ? nil : model.find(normalized)
      rescue StandardError
        nil
      end

      def create_implicit_remark_item_at_schema(model, item_id, schema_id)
        return nil unless model.respond_to?(:find)

        schema = model.find(schema_id)
        return nil unless schema

        # Handle informal propositions (IP\d+ pattern) - only if schema supports it
        # Note: Schema doesn't have informal_propositions, so this will create a remark_item instead
        if item_id.match?(/^IP\d+$/) && schema.respond_to?(:informal_propositions)
          return create_or_find_informal_proposition(schema, item_id)
        end

        # Handle remark items
        return nil unless schema.respond_to?(:remark_items)

        existing = schema.remark_items&.find { |ri| ri.id == item_id }
        return existing if existing

        create_remark_item(schema, item_id)
      end

      def create_implicit_remark_item(model, path, schema_ids = [])
        return nil unless model.respond_to?(:find)

        # Normalize path (handle "ip:IP1" format)
        clean_path = normalize_path(path)
        parts = clean_path.split(".")
        return nil if parts.length < 2

        # Find the deepest existing parent and create item there
        (parts.length - 1).downto(1) do |i|
          parent_path = parts[0...i].join(".")
          item_id = parts[i]

          parent = begin
            model.find(parent_path)
          rescue StandardError
            nil
          end

          # Try with schema prefix if not found
          if parent.nil? && schema_ids.any?
            schema_ids.each do |schema_id|
              parent = begin
                model.find("#{schema_id}.#{parent_path}")
              rescue StandardError
                nil
              end
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
        if path_part.include?(".")
        end
        "#{path_part}.#{item_suffix}"
      end

      def create_item_at_parent(parent, item_id)
        # Handle informal propositions
        if item_id.match?(/^IP\d+$/) && parent.respond_to?(:informal_propositions)
          return create_or_find_informal_proposition(parent, item_id)
        end

        # Handle remark items
        return nil unless parent.respond_to?(:remark_items)

        existing = parent.remark_items&.find { |ri| ri.id == item_id }
        return existing if existing

        create_remark_item(parent, item_id)
      end

      def create_or_find_informal_proposition(parent, id)
        existing = parent.informal_propositions&.find { |ip| ip.id == id }
        return existing if existing

        ip = Model::Declarations::InformalPropositionRule.new(id: id)
        ip.parent = parent
        parent.informal_propositions ||= []
        parent.informal_propositions << ip
        parent.reset_children_by_id if parent.respond_to?(:reset_children_by_id)

        # Also create a RemarkItem inside the InformalPropositionRule
        # This is the expected structure for informal proposition remarks
        remark_item = Model::Declarations::RemarkItem.new(id: id)
        remark_item.parent = ip
        ip.remark_items ||= []
        ip.remark_items << remark_item
        ip.reset_children_by_id if ip.respond_to?(:reset_children_by_id)

        # Return the remark_item so remarks are added to it
        remark_item
      end

      def create_remark_item(parent, id)
        item = Model::Declarations::RemarkItem.new(id: id)
        item.parent = parent
        parent.remark_items ||= []
        parent.remark_items << item
        parent.reset_children_by_id if parent.respond_to?(:reset_children_by_id)
        item
      end

      def attach_untagged_remarks(model, remarks)
        untagged = remarks.reject { |r| r[:tag] }
        return unless untagged.any?

        nodes_with_positions = []
        collect_nodes_with_positions(model, nodes_with_positions)
        nodes_with_positions.sort_by! { |n| n[:position] || Float::INFINITY }

        untagged.each do |remark|
          next if @attached_spans.include?(remark[:position])

          if is_end_scope_line?(remark[:line])
            matched_node = find_node_for_end_scope_remark(remark,
                                                          nodes_with_positions)
            if matched_node
              add_remark(matched_node, remark[:text], format: remark[:format],
                                                      tag: nil)
              @attached_spans << remark[:position]
              next
            end
          end

          matched_node = find_nearest_node(remark, nodes_with_positions)
          if matched_node
            add_remark(matched_node, remark[:text], format: remark[:format],
                                                    tag: nil)
            @attached_spans << remark[:position]
          end
        end
      end

      def is_end_scope_line?(line_num)
        line = get_line_content(line_num)
        line =~ /END_(SCHEMA|ENTITY|TYPE|FUNCTION|PROCEDURE|RULE)/i
      end

      def get_line_content(line_num)
        lines = @source.lines
        return "" if line_num < 1 || line_num > lines.length

        lines[line_num - 1]
      end

      def find_node_for_end_scope_remark(remark, nodes)
        line_content = get_line_content(remark[:line])

        node_type = case line_content
                    when /END_SCHEMA/i then Model::Declarations::Schema
                    when /END_ENTITY/i then Model::Declarations::Entity
                    when /END_TYPE/i then Model::Declarations::Type
                    when /END_FUNCTION/i then Model::Declarations::Function
                    when /END_PROCEDURE/i then Model::Declarations::Procedure
                    when /END_RULE/i then Model::Declarations::Rule
                    end

        return nil unless node_type

        matching_nodes = nodes.select do |n|
          n[:node].is_a?(node_type) &&
            (n[:end_line] == remark[:line] ||
             (n[:end_line] && n[:end_line] <= remark[:line] && n[:end_line] >= remark[:line] - 2))
        end

        matching_nodes.first&.dig(:node) || find_node_by_type(nodes, node_type)
      end

      def find_node_by_type(nodes, node_type)
        nodes.find { |n| n[:node].is_a?(node_type) }&.dig(:node)
      end

      def add_remark(node, text, format: "tail", tag: nil)
        return unless node

        if node.respond_to?(:remarks)
          node.remarks ||= []
          node.remarks << text
        end

        if tag.nil? && node.respond_to?(:untagged_remarks)
          remark_info = Model::RemarkInfo.new(text: text, format: format,
                                              tag: tag)
          node.untagged_remarks ||= []
          node.untagged_remarks << remark_info
        end
      end

      def collect_nodes_with_positions(node, result, visited = Set.new)
        return unless node
        return if visited.include?(node.object_id)

        visited.add(node.object_id)

        if node.respond_to?(:source) && node.source
          pos = @source.index(node.source)
          if pos
            line = get_line_number(pos)
            result << {
              node: node,
              position: pos,
              line: line,
              end_line: get_line_number(pos + node.source.length),
            }
          else
            result << { node: node, position: nil, line: nil, end_line: nil }
          end
        else
          result << { node: node, position: nil, line: nil, end_line: nil }
        end

        collect_children(node, result, visited)
      end

      def collect_children(node, result, visited)
        if node.respond_to?(:children)
          node.children&.each do |child|
            collect_nodes_with_positions(child, result, visited)
          end
        end

        %i[schemas types entities functions procedures rules constants
           attributes derived_attributes inverse_attributes
           where_rules unique_rules informal_propositions
           parameters variables statements items remark_items].each do |attr|
          if node.respond_to?(attr)
            node.send(attr)&.each do |item|
              collect_nodes_with_positions(item, result, visited)
            end
          end
        end
      end

      def find_nearest_node(remark, nodes)
        remark_line = remark[:line]

        same_line = nodes.select do |n|
          n[:line] == remark_line || n[:end_line] == remark_line
        end
        return same_line.first[:node] if same_line.any?

        before = nodes.select { |n| n[:end_line] && n[:end_line] < remark_line }
        before.max_by { |n| n[:end_line] }[:node] if before.any?
      end
    end
  end
end
