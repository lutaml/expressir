require "set"

module Expressir
  module Express
    class Visitor
      # Handles attaching remarks (comments) to model elements during parsing.
      # Supports both tagged remarks (with explicit targets) and untagged remarks
      # (attached based on line proximity).
      class RemarkAttacher
        REMARK_CHANNEL = 2

        # @param source [String] The source code being parsed
        # @param attached_remark_tokens [Set] Set tracking which remark tokens have been attached
        # @param get_source_pos_proc [Proc] Proc to get source position from context
        def initialize(source, attached_remark_tokens, get_source_pos_proc)
          @source = source
          @attached_remark_tokens = attached_remark_tokens
          @get_source_pos_proc = get_source_pos_proc
          @line_cache = {}
        end

        # Get line number for a source position
        # @param position [Integer] Character position in source
        # @return [Integer] Line number (1-indexed)
        def get_line_number(position)
          return 1 if position.nil? || position.zero?

          # Use cache to avoid repeated calculations
          @line_cache[position] ||= @source[0...position].count("\n") + 1
        end

        # Find a node by path within the node tree
        # @param node [Model::ModelElement] Node to search within
        # @param path [String] Path to search for
        # @return [Model::ModelElement, nil] Found node or nil
        def node_find(node, path)
          return nil if node.is_a?(String)

          if node.is_a?(Enumerable)
            node.find { |item| item.find(path) }
          else
            node.find(path)
          end
        end

        # Find the target node for a remark based on path
        # @param node [Model::ModelElement] Node to search within
        # @param path [String] Path identifying the remark target
        # @return [Model::ModelElement, nil] Target node or newly created remark item
        def find_remark_target(node, path)
          target_node = node_find(node, path)

          return target_node if target_node

          # check if path can create implicit remark item
          # see https://github.com/lutaml/expressir/issues/78
          rest, _, current_path = path.rpartition(".") # get last path part
          path_prefix, _, current_path = current_path.rpartition(":")
          parent_node = node_find(node, rest)
          if parent_node&.class&.method_defined?(:remark_items)
            remark_item = Model::Declarations::RemarkItem.new(
              id: current_path,
            )

            if parent_node.class.method_defined?(:informal_propositions) && (
              current_path.match(/^IP\d+$/) || path_prefix.match(/^IP\d+$/)
            )
              id = /^IP\d+$/ =~ current_path ? current_path : path_prefix
              parent_node.informal_propositions ||= []
              informal_proposition = Model::Declarations::InformalPropositionRule.new(id: id)
              informal_proposition.parent = parent_node
              parent_node.informal_propositions << informal_proposition

              # Reassign the informal proposition id to the remark item
              remark_item.id = id
              remark_item.parent = informal_proposition

              informal_proposition.remark_items ||= []
              informal_proposition.remark_items << remark_item
            else
              parent_node.remark_items ||= []
              parent_node.remark_items << remark_item
              remark_item.parent = parent_node
            end
            parent_node.reset_children_by_id
            remark_item
          end
        end

        # Get remark spans from context tree
        # @param ctx [Ctx] Context to extract remarks from
        # @param indent [String] Indentation for debugging (unused)
        # @return [Array<Array<Integer>>] Array of [start, end] position pairs
        def get_remarks(ctx, indent = "")
          case ctx
          when Visitor::Ctx
            ctx.values.sum([]) { |item| get_remarks(item, "#{indent}  ") }
          when Array
            ctx.sum([]) { |item| get_remarks(item, "#{indent}  ") }
          else
            if %i[tailRemark embeddedRemark].include?(ctx.name)
              [@get_source_pos_proc.call(ctx)]
            else
              []
            end
          end
        end

        # Get remarks with line number information for precise association
        # @param ctx [Ctx] Context to extract remarks from
        # @return [Array<Hash>] Array of {span:, line:, type:} hashes
        def get_remarks_with_lines(ctx)
          spans = get_remarks(ctx)

          spans.map do |span|
            line = get_line_number(span[0])
            text = @source[span[0]..(span[1] - 1)]
            type = text.start_with?("--") ? :tail : :embedded

            { span: span, line: line, type: type }
          end
        end

        # Extract tag from remark text if present
        # @param text [String] Remark text
        # @return [Array<String, String>] Tuple of [tag, content] where tag may be nil
        def extract_tag(text)
          # Check for remark tag: "reference" at start
          if text =~ /\A"([^"]+)"\s*(.*)\z/m
            tag = $1
            content = $2
            [tag, content]
          else
            [nil, text]
          end
        end

        # Create a RemarkInfo object from remark text and format
        # @param text [String] Remark text content
        # @param format [String] Format type: 'tail' or 'embedded'
        # @param tag [String, nil] Optional tag
        # @return [Model::RemarkInfo] RemarkInfo object
        def create_remark_info(text, format, tag = nil)
          Model::RemarkInfo.new(text: text, format: format, tag: tag)
        end

        # Attach remarks from context to a node
        # @param ctx [Ctx] Context containing remarks
        # @param node [Model::ModelElement] Node to attach remarks to
        def attach_remarks(ctx, node)
          # Track remarks distributed from parent to children (so we don't move them back)
          distributed_remarks = Set.new

          remark_infos = get_remarks_with_lines(ctx)

          # Skip already attached remarks
          remark_infos = remark_infos.reject do |info|
            @attached_remark_tokens.include?(info[:span])
          end

          # Parse remarks, find remark targets
          tagged_remark_tokens = []
          untagged_tail_remarks = []
          untagged_embedded_remarks = []

          remark_infos.each do |info|
            span = info[:span]
            line = info[:line]
            remark_type = info[:type]
            text = @source[span[0]..(span[1] - 1)]

            if text.start_with?("--\"") && text.include?("\"")
              # Tagged tail remark: --"tag" content
              quote_end = text.index("\"", 3)
              if quote_end
                remark_target_path = text[3...quote_end]
                remark_text = text[(quote_end + 1)..].strip.force_encoding("UTF-8")
                remark_target = find_remark_target(node, remark_target_path)
                if remark_target
                  tagged_remark_tokens << [span, remark_target, remark_text, 'tail', remark_target_path]
                end
              end
            elsif text.start_with?("(*\"") && text.include?("\"")
              # Tagged embedded remark: (*"tag" content *)
              quote_end = text.index("\"", 3)
              if quote_end
                remark_target_path = text[3...quote_end]
                remark_text = text[(quote_end + 1)...-2].strip.force_encoding("UTF-8")
                remark_target = find_remark_target(node, remark_target_path)
                if remark_target
                  tagged_remark_tokens << [span, remark_target, remark_text, 'embedded', remark_target_path]
                end
              end
            elsif text.match?(/^--IP\d+:/)
              # Unquoted tagged tail remark: --IP1: content
              remark_target_path = text[2..].strip
              colon_end = text.index(":", 5)
              remark_text = text[(colon_end + 1)...-2].strip.force_encoding("UTF-8")
              remark_target = find_remark_target(node, remark_target_path)
              if remark_target
                tagged_remark_tokens << [span, remark_target, remark_text, 'tail', nil]
              end
            elsif text.start_with?("--")
              # Untagged tail remark: -- content
              untagged_text = text[2..].strip.force_encoding("UTF-8")
              untagged_tail_remarks << { span: span, line: line, text: untagged_text, format: 'tail' }
            else
              # Untagged embedded remark: (* content *)
              untagged_text = text[2...-2].strip.force_encoding("UTF-8")
              untagged_embedded_remarks << { span: span, line: line, text: untagged_text, format: 'embedded' }
            end
          end

          # Attach tagged remarks (existing behavior)
          tagged_remark_tokens.each do |span, remark_target, remark_text, format, tag|
            remark_target.remarks ||= []
            remark_target.remarks << remark_text
            @attached_remark_tokens << span
          end

          # Determine node position for END_* line detection
          node_source_pos = get_source_pos_for_node(ctx, node)
          node_start_line = node_source_pos ? get_line_number(node_source_pos[0]) : nil
          node_end_line = node_source_pos ? get_line_number(node_source_pos[1]) : nil

          # Categorize END_* tail remarks first
          end_scope_remarks = []
          remaining_tail_remarks = []

          untagged_tail_remarks.each do |remark_info|
            line = remark_info[:line]

            # Check if this is an END_* line tail remark
            if is_end_scope_remark?(line, node_end_line, node)
              end_scope_remarks << remark_info
            else
              remaining_tail_remarks << remark_info
            end
          end

          # Attach END_* scope remarks to this node
          if end_scope_remarks.any? && node.respond_to?(:untagged_remarks)
            node.untagged_remarks ||= []
            end_scope_remarks.each do |remark_info|
              remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
              node.untagged_remarks << remark_obj
              @attached_remark_tokens << remark_info[:span]
            end
          end

          # For parent nodes: distribute END_* remarks to child declarations
          # This handles cases where child contexts don't include their own END_* remarks
          if node.respond_to?(:children) && node.children&.any? && remaining_tail_remarks.any?
            # Use keyword-based matching instead of context matching
            # Scan backwards from each remark to find which END_* keyword it follows
            remaining_tail_remarks_copy = remaining_tail_remarks.dup

            remaining_tail_remarks_copy.each do |remark_info|
              remark_start_pos = remark_info[:span][0]

              # Scan backwards from remark position to find END_* keyword
              # Look for up to 100 characters or to the previous newline
              scan_start = [@source.rindex("\n", remark_start_pos - 1) || 0, remark_start_pos - 100].max
              scan_text = @source[scan_start...remark_start_pos]

              matched_child = nil

              # Match END_* keywords to child types
              if scan_text =~ /END_TYPE/i
                matched_child = node.children.find { |c| c.is_a?(Model::Declarations::Type) }
              elsif scan_text =~ /END_ENTITY/i
                matched_child = node.children.find { |c| c.is_a?(Model::Declarations::Entity) }
              elsif scan_text =~ /END_FUNCTION/i
                matched_child = node.children.find { |c| c.is_a?(Model::Declarations::Function) }
              elsif scan_text =~ /END_PROCEDURE/i
                matched_child = node.children.find { |c| c.is_a?(Model::Declarations::Procedure) }
              elsif scan_text =~ /END_RULE/i
                matched_child = node.children.find { |c| c.is_a?(Model::Declarations::Rule) }
              end

              # If we found a matching child, attach the remark to it
              if matched_child && matched_child.respond_to?(:untagged_remarks)
                matched_child.untagged_remarks ||= []
                remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                matched_child.untagged_remarks << remark_obj
                distributed_remarks.add(remark_obj)  # Track that we distributed this
                @attached_remark_tokens << remark_info[:span]
                remaining_tail_remarks.delete(remark_info)
              end
            end
          end

          # For Repository nodes: distribute END_SCHEMA remarks to Schema children
          # Repository context includes END_SCHEMA remarks, but they should go on Schema nodes
          if node.is_a?(Model::Repository) && node.schemas&.any? && remaining_tail_remarks.any?
            remaining_tail_remarks_copy = remaining_tail_remarks.dup

            remaining_tail_remarks_copy.each do |remark_info|
              remark_start_pos = remark_info[:span][0]

              # Scan backwards from remark position to find END_SCHEMA keyword
              scan_start = [@source.rindex("\n", remark_start_pos - 1) || 0, remark_start_pos - 100].max
              scan_text = @source[scan_start...remark_start_pos]

              # Match END_SCHEMA keyword to Schema child
              if scan_text =~ /END_SCHEMA/i
                # Find the Schema that ends on this line
                # Since we may have multiple schemas, find the one whose END line matches
                remark_line = remark_info[:line]

                # Try to find which schema this belongs to by scanning backward for SCHEMA keyword
                # and matching it to our schemas
                matched_schema = node.schemas.find do |schema|
                  # Check if this schema ends near this remark
                  # We can use the schema's id from the END_SCHEMA line
                  schema_pattern = /END_SCHEMA;\s*--\s*#{Regexp.escape(schema.id)}/
                  scan_text =~ schema_pattern || scan_text =~ /END_SCHEMA/
                end

                # Default to first (and usually only) schema if pattern matching fails
                matched_schema ||= node.schemas.first

                if matched_schema && matched_schema.respond_to?(:untagged_remarks)
                  matched_schema.untagged_remarks ||= []
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  matched_schema.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                  remaining_tail_remarks.delete(remark_info)
                end
              end
            end
          end

          # Skip tail remark attachment for nodes that are children of containers
          # These will be handled by the parent container's attach_remarks
          skip_tail_remarks = node.is_a?(Model::Declarations::Attribute) ||
                               node.is_a?(Model::Declarations::DerivedAttribute) ||
                               node.is_a?(Model::Declarations::InverseAttribute) ||
                               node.is_a?(Model::DataTypes::EnumerationItem)

          # Try to attach inline tail remarks to children
          unattached_tail_remarks = []

          if !skip_tail_remarks && node.respond_to?(:children) && node.children&.any?
            # Extract child contexts for precise position matching
            child_contexts = extract_child_contexts(ctx, node)

            # Get first child line to determine if remarks are preambles
            first_child_line = get_first_child_line(node, ctx)

            remaining_tail_remarks.each do |remark_info|
              # If remark is before first child, it's a preamble - save for later attachment
              if first_child_line && remark_info[:line] < first_child_line
                unattached_tail_remarks << remark_info
              else
                # Try to find specific child on the same line, passing contexts
                child = find_child_on_line(node, remark_info[:line], child_contexts)

                if child && child.respond_to?(:untagged_remarks)
                  # Attach to specific child
                  child.untagged_remarks ||= []
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  child.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                else
                  # Couldn't attach to child, save for potential preamble
                  unattached_tail_remarks << remark_info
                end
              end
            end
          elsif !skip_tail_remarks && remaining_tail_remarks.any?
            # No children - these might be inline remarks or preamble
            # Only save as unattached if this is a scope container
            is_scope_container = node.is_a?(Model::Declarations::Schema) ||
                                 node.is_a?(Model::Declarations::Entity) ||
                                 node.is_a?(Model::Declarations::Function) ||
                                 node.is_a?(Model::Declarations::Procedure) ||
                                 node.is_a?(Model::Declarations::Type) ||
                                 node.is_a?(Model::Declarations::Rule)

            if is_scope_container
              unattached_tail_remarks = remaining_tail_remarks
            else
              # Not a scope container and no children - attach inline if on same line
              node.untagged_remarks ||= [] if node.respond_to?(:untagged_remarks)
              remaining_tail_remarks.each do |remark_info|
                if node.respond_to?(:untagged_remarks) && node_end_line && remark_info[:line] == node_end_line
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  node.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                end
              end
            end
          end

          # Attach remaining unattached tail remarks as preamble to scope containers only
          if node.respond_to?(:untagged_remarks) && unattached_tail_remarks.any? &&
             (node.is_a?(Model::Declarations::Schema) ||
              node.is_a?(Model::Declarations::Entity) ||
              node.is_a?(Model::Declarations::Function) ||
              node.is_a?(Model::Declarations::Procedure) ||
              node.is_a?(Model::Declarations::Type) ||
              node.is_a?(Model::Declarations::Rule))
            node.untagged_remarks ||= []
            unattached_tail_remarks.each do |remark_info|
              remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
              node.untagged_remarks << remark_obj
              @attached_remark_tokens << remark_info[:span]
            end
          end

          # For scope containers: check if children have preamble remarks that belong to this node
          # This handles the case where child contexts include parent preamble remarks
          if node.respond_to?(:children) && node.children&.any? &&
             (node.is_a?(Model::Declarations::Schema) ||
              node.is_a?(Model::Declarations::Entity) ||
              node.is_a?(Model::Declarations::Function) ||
              node.is_a?(Model::Declarations::Procedure))

            # Find the first actual child line
            child_contexts = extract_child_contexts(ctx, node)
            first_actual_child_line = nil

            if child_contexts && child_contexts.any?
              # Look for first non-remark token in first child context
              first_child_ctx = child_contexts.first
              source_pos = @get_source_pos_proc.call(first_child_ctx)
              if source_pos
                # Scan forward from context start to find first actual code (not remark)
                scan_start = source_pos[0]
                scan_text = @source[scan_start..(source_pos[1])]

                # Skip over remarks to find actual code
                lines = scan_text.split("\n")
                lines.each_with_index do |line, idx|
                  # Check if line has actual code (not just remarks/whitespace)
                  trimmed = line.strip
                  next if trimmed.empty?
                  next if trimmed.start_with?("--")
                  next if trimmed.start_with?("(*")

                  # Found first actual code line
                  first_actual_child_line = node_start_line + idx if node_start_line
                  break
                end
              end
            end

            # Move remarks from children to parent if they appear before first child line
            if first_actual_child_line && node.respond_to?(:untagged_remarks)
              node.children.each_with_index do |child, idx|
                next unless child.respond_to?(:untagged_remarks)
                next unless child.untagged_remarks&.any?

                # Skip enumeration items - they're not declaration-level children
                next if child.is_a?(Model::DataTypes::EnumerationItem)

                # For Schema: move preamble remarks from children (TYPE, ENTITY, etc.)
                # Only if there are no interfaces (which could own the remarks)
                # END_* remarks stay with their children
                if node.is_a?(Model::Declarations::Schema)
                  # Only move if schema has no interfaces/constants that could own the remarks
                  if (node.interfaces.nil? || node.interfaces.empty?) &&
                     (node.constants.nil? || node.constants.empty?)

                    # Move remarks that are preambles (not distributed END_* remarks)
                    node.untagged_remarks ||= []
                    remarks_to_move = child.untagged_remarks.reject { |r| distributed_remarks.include?(r) }
                    remarks_to_move.each do |remark|
                      node.untagged_remarks << remark
                    end
                    child.untagged_remarks -= remarks_to_move
                  end
                elsif node.is_a?(Model::Declarations::Entity) &&
                      child.untagged_remarks.length > 1
                  # For entities with multiple remarks, move surplus to parent
                  node.untagged_remarks ||= []
                  remarks_to_move = child.untagged_remarks[0..-1]
                  remarks_to_move.each do |remark|
                    node.untagged_remarks << remark
                  end
                  child.untagged_remarks = []
                end
              end
            end
          end

          # Attach untagged embedded remarks
          untagged_embedded_remarks.each do |remark_info|
            # Check if embedded remark is on a child's line
            if node.respond_to?(:children) && node.children&.any?
              child_contexts = extract_child_contexts(ctx, node)

              # Get first child line to determine if this is a preamble remark
              first_child_line = get_first_child_line(node, ctx)

              # If remark is before first child, it's a preamble - attach to parent
              if first_child_line && remark_info[:line] < first_child_line
                if node.respond_to?(:untagged_remarks)
                  node.untagged_remarks ||= []
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  node.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                end
              else
                # Try to find child on this line
                child = find_child_on_line(node, remark_info[:line], child_contexts)

                if child && child.respond_to?(:untagged_remarks)
                  # Attach to specific child
                  child.untagged_remarks ||= []
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  child.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                elsif node.respond_to?(:untagged_remarks)
                  # Preamble embedded remark or node-level remark
                  node.untagged_remarks ||= []
                  remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
                  node.untagged_remarks << remark_obj
                  @attached_remark_tokens << remark_info[:span]
                end
              end
            elsif node.respond_to?(:untagged_remarks)
              # Attach embedded remark to node
              node.untagged_remarks ||= []
              remark_obj = create_remark_info(remark_info[:text], remark_info[:format])
              node.untagged_remarks << remark_obj
              @attached_remark_tokens << remark_info[:span]
            end
          end
        end

        # Get source position for a node from its context
        # @param ctx [Ctx] Context
        # @param node [Model::ModelElement] Node
        # @return [Array<Integer>, nil] [start, end] position or nil
        def get_source_pos_for_node(ctx, node)
          return nil unless ctx.is_a?(Visitor::Ctx)
          @get_source_pos_proc.call(ctx)
        end

        # Check if a remark line is on an END_* scope line
        # @param line [Integer] Remark line number
        # @param node_end_line [Integer, nil] Node's ending line
        # @param node [Model::ModelElement] Node
        # @return [Boolean] True if this is an END_* line remark
        def is_end_scope_remark?(line, node_end_line, node)
          return false unless node_end_line
          return false unless line == node_end_line

          # Only for scope-defining nodes (have END_* keywords)
          node.is_a?(Model::Declarations::Schema) ||
            node.is_a?(Model::Declarations::Entity) ||
            node.is_a?(Model::Declarations::Type) ||
            node.is_a?(Model::Declarations::Function) ||
            node.is_a?(Model::Declarations::Procedure) ||
            node.is_a?(Model::Declarations::Rule)
        end

        # Get the line number of the first child in a node
        # @param node [Model::ModelElement] Node
        # @param ctx [Ctx] Context
        # @return [Integer, nil] Line number of first child or nil
        def get_first_child_line(node, ctx)
          return nil unless node.respond_to?(:children)
          return nil if node.children.nil? || node.children.empty?

          children = node.children.compact
          return nil if children.empty?

          # Try to get line from child contexts
          child_contexts = extract_child_contexts(ctx, node)
          if child_contexts && !child_contexts.empty?
            # Sort contexts by their start position to find the true first child in source order
            contexts_with_pos = child_contexts.map do |child_ctx|
              pos = @get_source_pos_proc.call(child_ctx)
              pos ? [child_ctx, pos[0]] : nil
            end.compact

            if contexts_with_pos.any?
              # Find the context with the minimum start position
              first_ctx, _first_pos = contexts_with_pos.min_by { |_ctx, pos| pos }
              source_pos = @get_source_pos_proc.call(first_ctx)
              return get_line_number(source_pos[0]) if source_pos
            end
          end

          # Fallback: try to get line from first child's source (less reliable)
          first_child = children.first
          if first_child.respond_to?(:source) && first_child.source
            child_source_start = @source.index(first_child.source)
            return get_line_number(child_source_start) if child_source_start
          end

          nil
        end

        # Find child declaration on a specific line
        # @param node [Model::ModelElement] Parent node
        # @param line_number [Integer] Line number to match
        # @param child_contexts [Array<Ctx>, nil] Optional child contexts for precise positioning
        # @return [Model::ModelElement, nil] Child on that line or nil
        def find_child_on_line(node, line_number, child_contexts = nil)
          return nil unless node.respond_to?(:children)
          return nil if node.children.nil? || node.children.empty?

          children = node.children.compact

          # Try to match using contexts first if available
          if child_contexts && !child_contexts.empty?
            children.each_with_index do |child, idx|
              next unless child.respond_to?(:untagged_remarks)

              # Get corresponding context if available
              child_ctx = child_contexts[idx] if idx < child_contexts.length
              next unless child_ctx

              # Get source position from context
              source_pos = @get_source_pos_proc.call(child_ctx)
              next unless source_pos

              # Calculate ending line number from source position
              ending_line = get_line_number(source_pos[1])

              return child if ending_line == line_number
            end
          end

          # Fallback to source-based matching
          children.find do |child|
            next false unless child.respond_to?(:source)
            next false if child.source.nil? || child.source.empty?

            # Calculate which line this child's declaration ends on
            # Tail remarks appear on the same line as the semicolon
            child_source_lines = child.source.split("\n")
            next false if child_source_lines.empty?

            # Find the line with the semicolon (end of declaration)
            declaration_end_line = nil

            child_source_lines.each_with_index do |source_line, idx|
              if source_line.include?(";")
                # This line has a semicolon - potential match
                # Calculate actual line number in source file
                child_start_pos = @source.index(child.source)
                if child_start_pos
                  lines_before_child = @source[0...child_start_pos].count("\n")
                  declaration_end_line = lines_before_child + idx + 1
                  break
                end
              end
            end

            declaration_end_line == line_number
          end
        end

        # Extract child contexts from a parent context based on node type
        # @param ctx [Ctx] Parent context
        # @param node [Model::ModelElement] Parent node
        # @return [Array<Ctx>, nil] Array of child contexts or nil
        def extract_child_contexts(ctx, node)
          return nil unless ctx.is_a?(Visitor::Ctx)

          # Schema declarations - navigate through schemaBody
          if node.is_a?(Model::Declarations::Schema)
            schema_body = ctx.data[:schemaBody]
            return nil unless schema_body

            # Get all declaration contexts
            declarations = schema_body.data[:schemaBodyDeclaration] || []
            declarations = [declarations] unless declarations.is_a?(Array)
            return declarations if declarations.any?
          end

          # Type declarations - check for enumeration or select items
          if node.is_a?(Model::Declarations::Type)
            underlying_type = ctx.data[:underlyingType]
            return nil unless underlying_type

            # Check if it's an enumeration type
            if underlying_type.data && underlying_type.data[:enumerationType]
              enum_type = underlying_type.data[:enumerationType]
              items = enum_type.data[:enumerationItems]
              if items
                items = items.data[:enumerationItem] if items.respond_to?(:data)
                items = [items] unless items.is_a?(Array)
                return items if items.any?
              end
            end

            # Check if it's a select type
            if underlying_type.data && underlying_type.data[:selectType]
              # Select types don't have child contexts we need to track
              return nil
            end
          end

          # Entity attributes - need to navigate through entityBody
          if node.is_a?(Model::Declarations::Entity)
            # Entity contexts have entityBody sub-context (note camelCase)
            entity_body = ctx.data[:entityBody]
            return nil unless entity_body

            explicit = entity_body.data[:explicitAttr] || []
            derived = entity_body.data[:derivedAttr] || []
            inverse = entity_body.data[:inverseAttr] || []

            # Flatten arrays of contexts
            explicit = [explicit] unless explicit.is_a?(Array)
            derived = [derived] unless derived.is_a?(Array)
            inverse = [inverse] unless inverse.is_a?(Array)

            # Flatten nested arrays from explicitAttr (which contains arrays of attributes)
            explicit_flattened = explicit.flat_map do |attr_group|
              attr_group.is_a?(Array) ? attr_group : [attr_group]
            end

            all_attrs = explicit_flattened + derived + inverse
            return all_attrs if all_attrs.any?
          end

          # Enumeration items
          if node.is_a?(Model::DataTypes::Enumeration)
            items = ctx.data[:enumerationItems]
            return nil unless items

            items = items.data[:enumerationItem] if items.respond_to?(:data)
            items = [items] unless items.is_a?(Array)
            return items if items.any?
          end

          # Type where rules, entity where rules, etc.
          # Can be extended for other node types as needed

          nil
        end
      end
    end
  end
end
