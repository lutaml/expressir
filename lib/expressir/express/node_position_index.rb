# frozen_string_literal: true

module Expressir
  module Express
    # Builds and queries an index of model nodes by source position.
    #
    # One interface (`nearest_node_to`, `node_for_end_scope_at`, `each_node`),
    # one implementation. Extracted from RemarkAttacher so the tree-walk +
    # byte→line translation + nearest-node heuristics live in one place,
    # tested independently of any remark logic.
    #
    # Reference: ISO 10303-11 — the parser yields source spans on ModelElement
    # instances; this module turns those spans into a line-keyed index that
    # remark attachment can query.
    class NodePositionIndex
      # Single source of truth for "what collections does this node have"
      # lives on the model — each class declares its own via the
      # `collection_attributes` macro. Referenced by both RemarkAttacher
      # and NodePositionIndex via this alias for backward compatibility.
      COLLECTION_REGISTRY = Model::ModelElement.collection_registry

      attr_reader :nodes

      def initialize(model, line_map)
        @model = model
        @line_map = line_map
        @nodes = build_sorted_nodes
      end

      # Returns the most-specific node whose span contains `remark_line`,
      # preferring same-line starts/ends, then smallest containing span.
      # Excludes Repository and Cache (not semantic scopes for remarks).
      def nearest_node_to(remark_line)
        same_start = nodes.select do |n|
          n[:line] == remark_line && semantic?(n[:node])
        end
        return same_start.last[:node] if same_start.any?

        same_end = nodes.select do |n|
          n[:end_line] == remark_line && semantic?(n[:node])
        end
        return same_end.last[:node] if same_end.any?

        containing = nodes.select do |n|
          n[:line] && n[:end_line] &&
            n[:line] <= remark_line && n[:end_line] >= remark_line &&
            semantic?(n[:node])
        end

        if containing.any?
          exp_file_node = containing.find { |n| n[:node].is_a?(Model::ExpFile) }
          if exp_file_node
            first_schema_offset = exp_file_node[:node].schemas&.first&.source_offset
            if first_schema_offset && remark_line < @line_map.line_number(first_schema_offset)
              return exp_file_node[:node]
            end
          end
          containing.min_by { |n| n[:end_line] - n[:line] }[:node]
        else
          before = nodes.select do |n|
            n[:end_line] && n[:end_line] < remark_line && semantic?(n[:node])
          end
          before.max_by { |n| n[:end_line] }[:node] if before.any?
        end
      end

      # Returns the node whose END_XXX declaration is on `remark_line`, when
      # the line text matches one of the END_XXX keywords. Used to attach
      # remarks that appear immediately after a scope closes.
      def node_for_end_scope_at(remark_line, line_content)
        node_type = case line_content
                    when /END_SCHEMA/i then Model::Declarations::Schema
                    when /END_ENTITY/i then Model::Declarations::Entity
                    when /END_TYPE/i then Model::Declarations::Type
                    when /END_FUNCTION/i then Model::Declarations::Function
                    when /END_PROCEDURE/i then Model::Declarations::Procedure
                    when /END_RULE/i then Model::Declarations::Rule
                    end
        return nil unless node_type

        matching = nodes.select do |n|
          n[:node].is_a?(node_type) &&
            (n[:end_line] == remark_line ||
             (n[:end_line] && n[:end_line] <= remark_line && n[:end_line] >= remark_line - 2))
        end

        matching.first&.dig(:node) || nodes.find { |n| n[:node].is_a?(node_type) }&.dig(:node)
      end

      private

      def semantic?(node)
        !node.is_a?(Model::Repository) && !node.is_a?(Model::Cache)
      end

      def build_sorted_nodes
        result = []
        collect_nodes(@model, result, Set.new)
        result.sort_by!.with_index { |n, i| [n[:position] || Float::INFINITY, i] }
        result
      end

      def collect_nodes(node, result, visited)
        return unless node
        return if visited.include?(node.object_id)

        visited.add(node.object_id)

        if node.is_a?(Model::ModelElement) && node.source && node.source_offset
          record_node_position(node, result)
        else
          result << { node: node, position: nil, line: nil, end_line: nil }
        end

        collect_children(node, result, visited)
      end

      def record_node_position(node, result)
        pos = node.source_offset
        valid = position_valid?(pos, node)
        unless valid
          result << { node: node, position: nil, line: nil, end_line: nil }
          return
        end

        line = @line_map.line_number(pos)
        source_end_line = @line_map.line_number(pos + node.source.length)
        children_end_line = children_end_line_for(node)
        end_line = [source_end_line, children_end_line].compact.max || source_end_line

        result << { node: node, position: pos, line: line, end_line: end_line }
      end

      # The parser returns source_offset=0 for leaf nodes (WhereRule) where
      # it cannot determine the actual position. Accept position=0 only when
      # the source is a declaration keyword line — those legitimately start
      # at the beginning of the file.
      def position_valid?(pos, node)
        return true if pos.positive?
        return false unless pos.zero? && node.source

        node.source.to_s.start_with?(
          "SCHEMA", "ENTITY", "TYPE", "FUNCTION",
          "PROCEDURE", "RULE", "CONSTANT", "VARIABLE",
          "USE", "REFERENCE", "END_SCHEMA", "END_ENTITY",
          "END_TYPE", "END_FUNCTION", "END_PROCEDURE",
          "END_RULE", "END_CONSTANT", "END_VARIABLE"
        )
      end

      def children_end_line_for(node)
        end_lines = []

        if node.is_a?(Model::Declarations::Schema)
          Array(node.children).each do |child|
            next unless child.is_a?(Model::ModelElement) && child.source_offset && child.source

            end_lines << @line_map.line_number(child.source_offset + child.source.length)
          end
        end

        each_collection_on(node) do |item|
          next unless item.is_a?(Model::ModelElement) && item.source_offset && item.source

          end_lines << @line_map.line_number(item.source_offset + item.source.length)
        end

        end_lines.max
      end

      def collect_children(node, result, visited)
        if node.is_a?(Model::Declarations::Schema)
          Array(node.children).each { |c| collect_nodes(c, result, visited) }
        end

        each_collection_on(node) do |item|
          collect_nodes(item, result, visited)
        end
      end

      # Yields each child in any declared collection on the node, based on
      # the type-driven COLLECTION_REGISTRY. Returns nothing for nodes whose
      # class is not registered.
      def each_collection_on(node, &block)
        attrs = COLLECTION_REGISTRY[node.class]
        return unless attrs

        attrs.each do |attr|
          collection = node.public_send(attr)
          next unless collection.is_a?(Array)

          collection.each(&block)
        end
      end
    end
  end
end
