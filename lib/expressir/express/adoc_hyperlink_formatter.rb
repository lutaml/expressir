# frozen_string_literal: true

module Expressir
  module Express
    # HyperlinkFormatter variant emitting AsciiDoc xref macros instead
    # of the legacy stepmod +{{{<<express:...>>}}}+ markup: a reference
    # to schema.item renders as +<<schema.item,item>>+, the anchor
    # namespace schema document pages emit (expressir #255 / iso-10303
    # #41). With +subs="+macros"+ source blocks the links go live.
    module AdocHyperlinkFormatter
      # @!visibility private
      def self.included(mod)
        unless mod.superclass <= Expressir::Express::Formatter
          raise Error::FormatterMethodMissingError.new("AdocHyperlinkFormatter",
                                                       "format_references_simple_reference")
        end
      end

      def format_references_simple_reference(node)
        return node.id unless node.base_path
        return node.id if group_reference_entity?(node)

        parts = node.base_path.split(".")
        return node.id if parts.size < 2

        anchor = parts[-2, 2].join(".")
        "<<#{anchor},#{node.id}>>"
      end

      # The entity of a group reference (`SELF\entity`) is written right
      # after a backslash. A link there is not a link: AsciiDoc reads
      # `\<<` as an escaped cross reference, prints the markup as text
      # and drops the backslash. The name is written plain (expressir#709).
      def group_reference_entity?(node)
        group = node.parent
        group.is_a?(Model::References::GroupReference) && group.entity.equal?(node)
      end

      OPENING_PARENTHESES = /\({2,}/
      OPENING_PLUS_SIGN = /\+(?=\S)/

      # The listing feeds a `subs="+macros"` source block, where AsciiDoc
      # also reads the EXPRESS text itself: a run of two or more opening
      # parentheses opens an index term that eats the parentheses, and a
      # plus sign followed by text opens an inline passthrough that runs
      # to a later plus sign. Every second parenthesis of a run and every
      # text-following plus sign are written as passthrough so AsciiDoc
      # prints the character (expressir#710).
      def self.keep_opening_parentheses(text)
        text.gsub(OPENING_PARENTHESES) do |run|
          run.each_char.with_index.map { |char, i| i.odd? ? "+++#{char}+++" : char }.join
        end
      end

      def self.keep_plus_signs(text)
        text.gsub(OPENING_PLUS_SIGN, "pass:[+]")
      end
    end
  end
end
