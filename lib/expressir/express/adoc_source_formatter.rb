# frozen_string_literal: true

module Expressir
  module Express
    # Pre-built Formatter subclass rendering the FULL schema with
    # cross-references as AsciiDoc xref macros — the document-page
    # counterpart of SourceFormatter (Schema#formatted_hyperlinked_adoc).
    class AdocSourceFormatter < Formatter
      include AdocHyperlinkFormatter

      # Same plain form as SourceFormatter: the document-page listing
      # omits every tagged description block, keyed ones included
      # (metanorma-cli#522), and keeps the source's untagged comments.
      def initialize(*)
        super(no_remarks: true, keep_untagged_remarks: true)
      end

      def owner_tagged_blocks?
        false
      end
    end
  end
end
