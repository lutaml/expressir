# frozen_string_literal: true

module Expressir
  module Express
    # Pre-built Formatter subclass that mixes in HyperlinkFormatter.
    #
    # Used by ModelElement#source to format an element back into EXPRESS
    # source text with hyperlinks. Allocated once at load time rather than
    # per #source call (which was the previous behaviour — wasteful and
    # rebuilt the format_registry on every call).
    class SourceFormatter < Formatter
      include HyperlinkFormatter

      # The hyperlinked listing face omits the owner's tagged
      # descriptions (expressir#704): they feed source blocks.
      def owner_tagged_blocks?
        false
      end
    end
  end
end
