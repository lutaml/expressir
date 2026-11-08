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
          # schema-relative path. node.path is rooted at the ExpFile,
          # whose id is the file path — drop that leading segment
          # (expressir#603).
          rule_context = node.parent.is_a?(Model::Declarations::WhereRule) ||
            node.parent.is_a?(Model::Declarations::UniqueRule) ||
            node.parent.is_a?(Model::Declarations::InformalPropositionRule)
          if rule_context
            tag = node.id.to_s
          else
            tag = node.path.to_s
            root = node
            root = root.parent while root.respond_to?(:parent) && root.parent
            prefix = "#{root.id}." if root.respond_to?(:id) && root.id
            tag = tag.delete_prefix(prefix) if prefix && tag.start_with?(prefix)
          end

          # Remark items are WG12 annotation blocks: the embedded form,
          # a block per remark, matching the source convention of the
          # annotated corpora (the conservation pairs are embedded, so
          # tail-form emission reads as phantom gains). Rule-context
          # owners keep the historic bare-tag tail form.
          if rule_context
            return node.remarks
                .map { |remark| "--\"#{tag}\" #{remark}" }
                .join("\n")
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
      end
    end
  end
end
