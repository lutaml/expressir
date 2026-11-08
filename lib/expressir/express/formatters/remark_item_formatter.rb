module Expressir
  module Express
    module Formatters
      module RemarkItemFormatter
        def self.included(base)
          base.register_formatter Model::Declarations::RemarkItem,
                                  :format_remark_item
        end

        def format_remark_item(node)
          return "" unless node.remarks&.any?

          # Check if any remark contains newlines
          has_newlines = node.remarks.any? { |r| r.to_s.include?("\n") }
          remarks_text = node.remarks.join("\n")

          # The tag is the schema-relative EXPRESS path: node.path is
          # rooted at the ExpFile, whose id is the file path — drop that
          # leading segment so the tag reads like the source form
          # (expressir#603).
          tag = node.path.to_s
          root = node
          root = root.parent while root.respond_to?(:parent) && root.parent
          prefix = "#{root.id}." if root.respond_to?(:id) && root.id
          tag = tag.delete_prefix(prefix) if prefix && tag.start_with?(prefix)

          if has_newlines || node.remarks.length > 1
            # Multi-line format: (*"path" remarks *)
            "(*\"#{tag}\"\n#{remarks_text}\n*)"
          else
            # Single-line format: --"path" text
            "--\"#{tag}\" #{remarks_text}"
          end
        end
      end
    end
  end
end
