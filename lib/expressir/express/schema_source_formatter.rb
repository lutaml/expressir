# frozen_string_literal: true

module Expressir
  module Express
    # Pre-built Formatter subclass for Schema#source.
    #
    # Combines SchemaHeadFormatter (renders the SCHEMA header block) with
    # HyperlinkFormatter (renders cross-references as hyperlinks). Allocated
    # once at load time rather than per #source call.
    class SchemaSourceFormatter < Formatter
      include SchemaHeadFormatter
      include HyperlinkFormatter
    end
  end
end
