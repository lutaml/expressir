# frozen_string_literal: true

module Expressir
  module Express
    # Pre-built Formatter subclass rendering the FULL schema with
    # cross-references as AsciiDoc xref macros — the document-page
    # counterpart of SourceFormatter (Schema#formatted_hyperlinked_adoc).
    class AdocSourceFormatter < Formatter
      include AdocHyperlinkFormatter

      # The document listing prints the schema's code, not the WG12
      # description blocks (#704): a stem:[...] formula inside a
      # description breaks the document's MathML build. The annotated
      # pages carry the description blocks; the listing suppresses
      # them.
      def format_owner_tagged_remarks(_node)
        []
      end

      def format_enumeration_item_remarks(_node)
        []
      end

      def format_schema_remarks(_node)
        []
      end

      # The name after SELF's backslash is written plain (#709):
      # AsciiDoc reads `\<<` as an escaped cross-reference and prints
      # the markup as text, dropping the backslash.
      def format_references_group_reference(node)
        entity = node.entity
        plain = if entity.is_a?(Model::References::SimpleReference) &&
            entity.id
                  entity.id
                else
                  format(entity)
                end
        [format(node.ref), "\\", plain].join
      end

      def format(node)
        escape_adoc_literal_tokens(super)
      end

      private

      # With `subs="+macros"` source blocks AsciiDoc reads two things in
      # the EXPRESS text itself (#710): a `((` pair opens an index term
      # (losing everything up to a `))`), and a `+` opens an inline
      # passthrough that swallows the following text. Both spellings
      # leave the listing. The escapes print the characters literally.
      def escape_adoc_literal_tokens(text)
        return text unless text.is_a?(String)

        text.gsub("+", "pass:[+]").gsub("((", "+++(+++")
      end
    end
  end
end
