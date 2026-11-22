# frozen_string_literal: true

module Expressir
  module Express
    # Pre-built Formatter subclass rendering the FULL schema with
    # cross-references as AsciiDoc xref macros — the document-page
    # counterpart of SourceFormatter (Schema#formatted_hyperlinked_adoc).
    class AdocSourceFormatter < Formatter
      include AdocHyperlinkFormatter

      def owner_tagged_blocks?
        false
      end
    end
  end
end
