module Expressir
  module Express
    module RemarkFormatter
      private

      def format_remark(node, remark)
        # Handle embedded remarks
        if remark.include?("\n")
          [
            [
              "(*\"",
              node.path || node.id,
              "\"",
            ].join,
            remark,
            "*)",
          ].join("\n")
        elsif node.path.nil? && node.id.include?("IP")
          # Handle immediate informal propositions
          [
            "--",
            node.id,
            " ",
            remark,
          ].join
        else
          # Handle tail remarks
          [
            "--\"",
            node.path || node.id,
            "\" ",
            remark,
          ].join
        end
      end

      def format_untagged_remark(remark)
        if remark.is_a?(Model::RemarkInfo)
          text = remark.text
          return "" if text.nil? || text.empty?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text

          if remark.tail?
            "-- #{formatted_text}"
          elsif text.include?("\n")
            ["(*", formatted_text, "*)"].join("\n")
          else
            "(* #{formatted_text} *)"
          end
        else
          return "" if remark.nil? || remark.empty?

          if remark.include?("\n")
            ["(*", remark, "*)"].join("\n")
          else
            "-- #{remark}"
          end
        end
      end

      def format_inline_tail_remark(node)
        return "" if @no_remarks
        return "" unless node.respond_to?(:untagged_remarks)
        return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

        remark = node.untagged_remarks.first
        return "" if remark.nil?

        if remark.is_a?(Model::RemarkInfo)
          text = remark.text
          return "" if text.nil? || text.empty?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
          remark.tail? ? " -- #{formatted_text}" : " (* #{formatted_text} *)"
        else
          return "" if remark.empty?
          " -- #{remark}"
        end
      end

      def format_end_scope_remark(node)
        return "" if @no_remarks
        return "" unless node.respond_to?(:untagged_remarks)
        return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

        remark = node.untagged_remarks.last
        return "" if remark.nil?

        if remark.is_a?(Model::RemarkInfo)
          text = remark.text
          return "" if text.nil? || text.empty?

          # Only output if it's a tail remark (END_* scope remarks are always tail)
          return "" unless remark.tail?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
          " -- #{formatted_text}"
        else
          return "" if remark.empty?
          # Legacy string format - assume it's a tail remark
          " -- #{remark}"
        end
      end

      def format_preamble_remark(remark, indent_str = "")
        if remark.is_a?(Model::RemarkInfo)
          text = remark.text
          text = "\"#{remark.tag}\" #{text}" if remark.tagged?

          if remark.tail?
            "#{indent_str}-- #{text}"
          elsif text.include?("\n")
            lines = text.split("\n")
            [
              "#{indent_str}(*",
              *lines.map { |line| "#{indent_str}  #{line.strip}" },
              "#{indent_str}*)",
            ].join("\n")
          else
            "#{indent_str}(* #{text} *)"
          end
        else
          if remark.include?("\n")
            lines = remark.split("\n")
            [
              "#{indent_str}(*",
              *lines.map { |line| "#{indent_str}  #{line.strip}" },
              "#{indent_str}*)",
            ].join("\n")
          else
            "#{indent_str}-- #{remark}"
          end
        end
      end

      def format_preamble_remarks(node, indent_str = "")
        return nil if @no_remarks
        return nil unless node.respond_to?(:untagged_remarks)
        return nil if node.untagged_remarks.nil? || node.untagged_remarks.empty?

        # For scope containers, exclude the last tail remark as it's the END_* remark
        # but keep all embedded remarks
        is_scope_container = node.is_a?(Model::Declarations::Schema) ||
                             node.is_a?(Model::Declarations::Entity) ||
                             node.is_a?(Model::Declarations::Type) ||
                             node.is_a?(Model::Declarations::Function) ||
                             node.is_a?(Model::Declarations::Procedure) ||
                             node.is_a?(Model::Declarations::Rule)

        preamble_remarks = node.untagged_remarks.select do |remark|
          if remark.is_a?(Model::RemarkInfo)
            !remark.text.nil? && !remark.text.empty?
          else
            !remark.nil? && !remark.empty?
          end
        end

        # For scope containers: exclude last remark ONLY if it's a tail remark (END_* remark)
        # Keep all embedded remarks
        if is_scope_container && preamble_remarks.length > 1
          last_remark = preamble_remarks.last
          if last_remark.is_a?(Model::RemarkInfo)
            # Only exclude if it's a tail remark
            preamble_remarks = preamble_remarks[0..-2] if last_remark.tail?
          else
            # Legacy string format - assume it's a tail remark
            preamble_remarks = preamble_remarks[0..-2]
          end
        end

        return nil if preamble_remarks.empty?

        preamble_remarks.map { |remark| format_preamble_remark(remark, indent_str) }.join("\n")
      end

      def format_remarks(node)
        remarks = []

        # Add tagged remarks
        if node.class.method_defined?(:remarks) && !@no_remarks &&
            !node.remarks.nil?
          remarks.concat(node.remarks.compact.map do |remark|
            format_remark(node, remark)
          end)
        end

        # Skip untagged remarks for nodes that handle them separately
        skip_untagged = node.is_a?(Model::Declarations::Attribute) ||
                       node.is_a?(Model::DataTypes::EnumerationItem) ||
                       node.is_a?(Model::Declarations::Schema) ||
                       node.is_a?(Model::Declarations::Entity) ||
                       node.is_a?(Model::Declarations::Type) ||
                       node.is_a?(Model::Declarations::Function) ||
                       node.is_a?(Model::Declarations::Procedure) ||
                       node.is_a?(Model::Declarations::Rule)

        # Add untagged remarks only for nodes that don't handle them specially
        if !skip_untagged && node.respond_to?(:untagged_remarks) && !@no_remarks &&
            !node.untagged_remarks.nil?
          remarks.concat(node.untagged_remarks.map do |remark|
            format_untagged_remark(remark)
          end)
        end

        remarks
      end

      def format_scope_remarks(node)
        remarks = []

        # Collect tagged remarks using the standard format_remarks
        remarks.concat(format_remarks(node))

        # Special handling for Schema to get proper remark ordering
        if node.is_a?(Model::Declarations::Schema)
          # Schema's own remarks that need to be in specific positions
          schema_remarks = {}
          if !@no_remarks && node.respond_to?(:untagged_remarks) && !node.untagged_remarks.nil?
            node.untagged_remarks.compact.each do |remark|
              text = remark.is_a?(Model::RemarkInfo) ? remark.text : remark
              schema_remarks[text] = remark unless text == "interfaces"  # Skip "interfaces"
            end
          end

          # Add Schema remarks in the proper order relative to children
          # Declaration order: constants, types, entities, subtype_constraints, functions, rules, procedures
          remarks.concat(schema_remarks["constants"] ? [format_untagged_remark(schema_remarks["constants"])] : [])

          # Collect from children grouped by type
          if node.respond_to?(:children) && node.children
            types_done = false
            entities_done = false

            node.children.select do |child|
              !child.is_a?(Model::DataTypes::EnumerationItem) || node.is_a?(Model::Declarations::Type)
            end.each do |child|
              # Add types section remarks
              if !types_done && child.is_a?(Model::Declarations::Type)
                types_done = true
              end

              # Add entities section remarks
              if !entities_done && child.is_a?(Model::Declarations::Entity)
                entities_done = true
              end

              # Add subtype constraints Schema remark after last entity, before first subtype constraint
              if entities_done && child.is_a?(Model::Declarations::SubtypeConstraint) && schema_remarks["subtype constraints"]
                remarks.concat([format_untagged_remark(schema_remarks["subtype constraints"])])
                schema_remarks.delete("subtype constraints")  # Only add once
              end

              # Recursively collect from child
              remarks.concat(format_scope_remarks(child))
            end
          end
        else
          # For non-Schema nodes, use standard logic
          skip_untagged_types = [
            Model::Declarations::Entity,
            Model::Declarations::Type,
            Model::Declarations::Function,
            Model::Declarations::Procedure,
            Model::Declarations::Rule,
            Model::Declarations::SubtypeConstraint
          ]

          if !@no_remarks &&
             node.respond_to?(:untagged_remarks) &&
             !node.untagged_remarks.nil? &&
             skip_untagged_types.any? { |type| node.is_a?(type) }

            remarks.concat(node.untagged_remarks.compact.map do |remark|
              format_untagged_remark(remark)
            end)
          end

          # Then recursively collect from children
          if node.respond_to?(:children) && node.children
            node.children.select do |child|
              !child.is_a?(Model::DataTypes::EnumerationItem) || node.is_a?(Model::Declarations::Type)
            end.each do |child|
              # Recursively collect remarks from child and its descendants
              remarks.concat(format_scope_remarks(child))
            end
          end
        end

        remarks
      end
    end
  end
end
