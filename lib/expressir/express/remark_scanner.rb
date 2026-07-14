# frozen_string_literal: true

module Expressir
  module Express
    # Scans EXPRESS source text and extracts all remarks (tail and embedded),
    # correctly tracking embedded-remark nesting so that inline `--` inside
    # a `(* ... *)` documentation block is NOT mistaken for a tail remark.
    #
    # Single responsibility: source string -> Array<Remark>. The scanner has
    # no knowledge of the model; attaching remarks to model elements is the
    # job of {RemarkAttacher}.
    #
    # Reference: ISO 10303-11 §7.1.6.
    #   tail_remark     = '--' [ remark_tag ] { <any char except newline> } '\n'
    #   embedded_remark = '(*' [ remark_tag ]
    #                       { <any char> | nested embedded_remark } '*)'
    #
    # The scanner is a single-pass state machine with four states:
    #   :top          — outside any remark/string; look for `--`, `(*`, or `'`.
    #   :in_tail       — inside a tail remark; look only for the next newline.
    #   :in_embedded   — inside one or more nested embedded remarks; look
    #                    for the matching `*)` or a nested `(*`, ignoring `--`.
    #   :in_string     — inside a simple string literal; look for the closing
    #                    `'`, treating `''` as an escaped quote (ISO 10303-11
    #                    §7.1.6.5). `--` and `(*` inside a string are content.
    class RemarkScanner
      # Immutable value object describing a single extracted remark.
      Remark = Struct.new(:position, :line, :text, :tag, :format, keyword_init: true) do
        def tail?
          format == Model::RemarkFormat::TAIL
        end

        def embedded?
          format == Model::RemarkFormat::EMBEDDED
        end

        def tagged?
          !tag.nil? && !tag.empty?
        end
      end

      # Lexical markers recognised by EXPRESS.
      TAIL_MARKER = "--"
      EMBEDDED_OPEN = "(*"
      EMBEDDED_CLOSE = "*)"
      STRING_QUOTE = "'"

      # Tag forms (see ISO 10303-11 §7.1.6.3 Remark tag).
      # IP-style informal-proposition tags are recognised only in tail remarks
      # (matching historic behaviour); embedded remarks use the quoted form.
      INFORMAL_PROPOSITION_TAG = /\A(IP\d+):\s*(.*)\z/m
      QUOTED_TAG = /\A"([^"]*)"\s*(.*)\z/m

      # @param source [String] EXPRESS source text (any encoding).
      def initialize(source)
        @source = source
        @source_bytes = source.b
        @line_map = LineMap.new(@source_bytes)
      end

      # Returns an Array of {Remark}, in source order (by byte position).
      # @return [Array<Remark>]
      def scan
        run_state_machine
      end

      alias call scan

      private

      def run_state_machine
        remarks = []
        src = @source_bytes
        pos = 0

        state = :top
        embedded_depth = 0
        tail_start = nil      # byte position of first content char after "--"
        tail_line = nil
        embedded_start = nil  # byte position of first content char after "(*"
        embedded_line = nil

        while pos < src.bytesize
          case state
          when :in_tail
            nl = src.index("\n", pos)
            if nl
              emit_tail(remarks, tail_start, nl, tail_line)
              pos = nl + 1
              state = :top
            else
              emit_tail(remarks, tail_start, src.bytesize, tail_line)
              return remarks
            end
          when :in_embedded
            closing = src.index(EMBEDDED_CLOSE, pos)
            nesting = src.index(EMBEDDED_OPEN, pos)
            if nesting && (!closing || nesting < closing)
              embedded_depth += 1
              pos = nesting + EMBEDDED_OPEN.bytesize
            elsif closing
              embedded_depth -= 1
              pos = closing + EMBEDDED_CLOSE.bytesize
              if embedded_depth.zero?
                emit_embedded(remarks, embedded_start, closing, embedded_line)
                state = :top
              end
            else
              # Unclosed embedded remark — terminate scan gracefully.
              return remarks
            end
          when :in_string
            # ISO 10303-11 §7.1.6.5: `''` inside a string is an escaped quote.
            # Find the next `'`; if followed by another `'`, skip both; else
            # the string closes.
            quote_pos = src.index(STRING_QUOTE, pos)
            if quote_pos.nil?
              # Unclosed string — malformed EXPRESS; terminate scan gracefully.
              return remarks
            end

            if quote_pos + 1 < src.bytesize && src.getbyte(quote_pos + 1) == STRING_QUOTE.ord
              pos = quote_pos + 2
            else
              pos = quote_pos + 1
              state = :top
            end
          else # :top
            next_embed = src.index(EMBEDDED_OPEN, pos)
            next_tail = src.index(TAIL_MARKER, pos)
            next_quote = src.index(STRING_QUOTE, pos)
            if next_embed.nil? && next_tail.nil? && next_quote.nil?
              return remarks
            elsif next_quote && (next_embed.nil? || next_quote < next_embed) &&
                (next_tail.nil? || next_quote < next_tail)
              # String opener wins — enter :in_string and skip the quote.
              pos = next_quote + STRING_QUOTE.bytesize
              state = :in_string
            elsif next_embed && (next_tail.nil? || next_embed <= next_tail)
              embedded_start = next_embed + EMBEDDED_OPEN.bytesize
              embedded_line = @line_map.line_number(next_embed)
              embedded_depth = 1
              state = :in_embedded
              pos = next_embed + EMBEDDED_OPEN.bytesize
            else
              tail_start = next_tail + TAIL_MARKER.bytesize
              tail_line = @line_map.line_number(next_tail)
              state = :in_tail
              pos = next_tail + TAIL_MARKER.bytesize
            end
          end
        end

        remarks
      end

      def emit_tail(remarks, content_start, content_end, line)
        # Slice content from the original (UTF-8) source so the returned text
        # preserves the source encoding. Byte offsets come from the BINARY copy.
        raw = @source.byteslice(content_start...content_end)
        tag, content = parse_tail(raw.strip)
        remarks << Remark.new(
          position: content_start - TAIL_MARKER.bytesize,
          line: line,
          text: content,
          tag: tag,
          format: Model::RemarkFormat::TAIL,
        )
      end

      def emit_embedded(remarks, content_start, content_end, line)
        raw = @source.byteslice(content_start...content_end)
        tag, content = parse_embedded(raw)
        remarks << Remark.new(
          position: content_start - EMBEDDED_OPEN.bytesize,
          line: line,
          text: content,
          tag: tag,
          format: Model::RemarkFormat::EMBEDDED,
        )
      end

      # Tail remarks support both quoted tags ("schema.entity" ...) and the
      # shorthand IP-tag form (IP1: ...). Returns [tag, content]; for untagged
      # remarks tag is nil and content is the stripped text.
      def parse_tail(text)
        match = text.match(INFORMAL_PROPOSITION_TAG) || text.match(QUOTED_TAG)
        match ? match.captures : [nil, text]
      end

      # Embedded remarks only use the quoted tag form.
      def parse_embedded(content)
        stripped = content.strip
        if (m = stripped.match(QUOTED_TAG))
          [m[1], m[2]]
        else
          [nil, stripped]
        end
      end
    end
  end
end
