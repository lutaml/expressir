module Expressir
  module Express
    module Formatters
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
          return "" unless remark.is_a?(Model::RemarkInfo)

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
        end

        def format_inline_tail_remark(node)
          return "" if @no_remarks
          return "" unless node.is_a?(Model::ModelElement)
          return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

          remark = node.untagged_remarks.first
          return "" unless remark.is_a?(Model::RemarkInfo)

          text = remark.text
          return "" if text.nil? || text.empty?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
          remark.tail? ? " -- #{formatted_text}" : " (* #{formatted_text} *)"
        end

        def format_end_scope_remark(node)
          return "" if @no_remarks
          return "" unless node.is_a?(Model::ModelElement)
          return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

          remark = node.untagged_remarks.last
          return "" unless remark.is_a?(Model::RemarkInfo)

          text = remark.text
          return "" if text.nil? || text.empty?

          # Only output if it's a tail remark (END_* scope remarks are always tail)
          return "" unless remark.tail?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
          " -- #{formatted_text}"
        end

        def format_preamble_remark(remark, indent_str = "")
          return "" unless remark.is_a?(Model::RemarkInfo)

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
        end

        def format_preamble_remarks(node, indent_str = "")
          return nil if @no_remarks
          return nil unless node.is_a?(Model::ModelElement)
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
            remark.is_a?(Model::RemarkInfo) && !remark.text.nil? && !remark.text.empty?
          end

          # For scope containers: exclude last remark ONLY if it's a tail remark (END_* remark)
          # Keep all embedded remarks
          if is_scope_container && preamble_remarks.length > 1
            last_remark = preamble_remarks.last
            # Only exclude if it's a tail remark
            preamble_remarks = preamble_remarks[0..-2] if last_remark.tail?
          end

          return nil if preamble_remarks.empty?

          preamble_remarks.map do |remark|
            format_preamble_remark(remark, indent_str)
          end.join("\n")
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
          if !skip_untagged && node.is_a?(Model::ModelElement) && !@no_remarks &&
              !node.untagged_remarks.nil?
            remarks.concat(node.untagged_remarks.map do |remark|
              format_untagged_remark(remark)
            end)
          end

          remarks
        end
      end
    end
  end
end
