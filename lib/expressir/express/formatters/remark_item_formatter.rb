module Expressir
  module Express
    # Formatter for RemarkItem declarations
    module RemarkItemFormatter
      # Format a RemarkItem as an EXPRESS remark
      # @param node [Model::Declarations::RemarkItem] The remark item to format
      # @return [String] Formatted remark
      def format_remark_item(node)
        return "" unless node.remarks&.any?

        # Check if any remark contains newlines
        has_newlines = node.remarks.any? { |r| r.to_s.include?("\n") }

        if has_newlines
          # Multi-line format: (*"path" remarks *)
          remarks_text = node.remarks.join("\n")
          "(*\"#{node.path}\"\n#{remarks_text}\n*)"
        else
          # Single-line format: --"path"
          "--\"#{node.path}\""
        end
      end
    end
  end
end
