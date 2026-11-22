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

          # The tag form follows the owner: items in rule contexts
          # (WHERE/UNIQUE/IP) historically carry bare tags
          # (`--"unusual_placement" text`), WG12-style items carry the
          # schema-relative path. A referable `__note:id` has no rule to
          # anchor it in a bare tail tag (it would reattach to the
          # schema), so it carries the path too (annotated-express#103).
          rule_context = node.parent.is_a?(Model::Declarations::WhereRule) ||
            node.parent.is_a?(Model::Declarations::UniqueRule) ||
            node.parent.is_a?(Model::Declarations::InformalPropositionRule)
          tag = if rule_context && !node.id.to_s.start_with?("__")
                  node.id.to_s
                else
                  schema_relative_path(node)
                end

          # Remark items are WG12 annotation blocks: the embedded form,
          # a block per remark, matching the source convention of the
          # annotated corpora (the conservation pairs are embedded, so
          # tail-form emission reads as phantom gains). Rule-context
          # owners keep the historic tail form.
          if rule_context
            return node.remarks.map do |remark|
              remark = remark.to_s
              if remark.include?("\n")
                # A multi-line remark cannot ride the `--` tail form:
                # its continuation lines would leak as bare source text
                # the parser rejects (#691).
                "(*\"#{tag}\"\n#{remark}\n*)"
              else
                "--\"#{tag}\" #{remark}"
              end
            end.join("\n")
          end
          node.remarks.map do |remark|
            remark = remark.to_s
            if remark.include?("\n")
              "(*\"#{tag}\"\n#{remark}\n*)"
            else
              "(*\"#{tag}\" #{remark} *)"
            end
          end.join("\n")
        end

        private

        # node.path is rooted at the ExpFile, whose id is the file path
        # or nil; drop that leading segment (expressir#603).
        def schema_relative_path(node)
          root = node
          root = root.parent while root.respond_to?(:parent) && root.parent
          prefix_id = root.respond_to?(:id) ? root.id : nil
          # A from_files tree roots at the (id-less) Repository; the
          # ExpFile under it carries the file path the paths are built
          # from (#708). A nil id keeps the historical "." prefix: the
          # string-file paths carry the empty root segment.
          if prefix_id.nil? || prefix_id.to_s.empty?
            file = root.respond_to?(:files) && root.files&.first
            prefix_id = file.respond_to?(:id) ? file.id : nil
          end
          prefix = "#{prefix_id}."
          node.path.to_s.delete_prefix(prefix)
        end
      end
    end
  end
end
