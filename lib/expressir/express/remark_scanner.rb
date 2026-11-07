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
      # `position` is the byte offset of the opener (`--` or `(*`).
      # `end_position` is the byte offset one past the closer (the newline
      # byte for tail remarks, the byte after `*)` for embedded remarks).
      # `[position, end_position)` is the full byte range the remark
      # occupied in the original source.
      Remark = Struct.new(:position, :end_position, :line, :text, :tag,
                          :format, keyword_init: true) do
        # Tail annotations sit where tails sit; the renderer asks
        # #tail_annotation? for the marker.
        def tail?
          [Model::RemarkFormat::TAIL, Model::RemarkFormat::TAIL_ANNOTATION].include?(format)
        end

        def embedded?
          [Model::RemarkFormat::EMBEDDED, Model::RemarkFormat::EMBEDDED_ANNOTATION].include?(format)
        end

        def tail_annotation?
          format == Model::RemarkFormat::TAIL_ANNOTATION
        end

        def embedded_annotation?
          format == Model::RemarkFormat::EMBEDDED_ANNOTATION
        end

        def tagged?
          !tag.nil? && !tag.empty?
        end

        # Byte length of the full remark (opener + content + closer).
        def bytesize
          end_position - position
        end
      end

      # Lexical markers recognised by EXPRESS.
      TAIL_MARKER = "--"
      EMBEDDED_OPEN = "(*"
      EMBEDDED_CLOSE = "*)"
      STRING_QUOTE = "'"

      # EXPRESSdoc annotation markers (metanorma/annotated-express#94):
      # a `---` tail annotation takes exactly three dashes, and a `(**`
      # embedded annotation closes with the plain remark closer.
      TAIL_ANNOTATION_MARKER = "---"
      EMBEDDED_ANNOTATION_OPEN = "(**"

      # Byte value of `)` — used to detect the `(*)` overlap pattern where
      # the embedded-remark opener `(*` and closer `*)` share the `*`.
      RPAREN_BYTE = ")".ord

      # Tag forms (see ISO 10303-11 §7.1.6.3 Remark tag).
      # IP-style informal-proposition tags are recognised only in tail remarks
      # (matching historic behaviour); embedded remarks use the quoted form.
      INFORMAL_PROPOSITION_TAG = /\A(IP\d+):\s*(.*)\z/m
      QUOTED_TAG = /\A"([^"]*)"\s*(.*)\z/m

      # @param source [String] EXPRESS source text (any encoding).
      # @param annotations [Boolean] recognize the EXPRESSdoc annotation
      #   forms (`--- note`, `(** note *)`) in addition to remarks.
      def initialize(source, annotations: false)
        @source = source
        @annotations = annotations
        @source_bytes = source.b
        @line_map = LineMap.new(@source_bytes)
      end

      # Returns an Array of {Remark}, in source order (by byte position).
      # Runs on the Rust core's scanner when the native extension is
      # loaded; the pure-Ruby state machine below stays as the fallback.
      # @return [Array<Remark>]
      def scan
        return native_scan if native_available?

        run_state_machine
      end

      alias call scan

      private

      def native_available?
        defined?(Core) && Core::NATIVE_AVAILABLE
      end

      def native_scan
        Core.scan_remarks(@source, annotations: @annotations).map do |unit|
          Remark.new(
            position: unit[:position],
            end_position: unit[:end_position],
            line: unit[:line],
            text: unit[:text],
            tag: unit[:tag],
            format: unit[:format],
          )
        end
      end

      # Detects the `(*)` overlap pattern: opener `(*` (positions pos, pos+1)
      # and closer `*)` (positions pos+1, pos+2) share the `*` character.
      # Per strict ISO 10303-11 §7.1.6 grammar the opener and closer are
      # distinct tokens that cannot share characters, so `(*)` is technically
      # invalid; we accept it as a 3-character empty embedded remark for
      # robustness (issue #126).
      def empty_overlap_remark?(pos)
        pos + 2 < @source_bytes.bytesize &&
          @source_bytes.getbyte(pos + 2) == RPAREN_BYTE
      end

      def run_state_machine
        remarks = []
        src = @source_bytes
        pos = 0

        state = :top
        embedded_depth = 0
        tail_start = nil      # byte position of first content char after "--"
        tail_line = nil
        tail_annotation = false
        embedded_start = nil  # byte position of first content char after "(*"
        embedded_line = nil
        embedded_annotation = false

        # A `---` tail annotation takes exactly three dashes, the fourth
        # byte (if any) not a dash — dash runs of four or more stay remarks.
        tail_annotation_at = lambda do |at|
          return false unless @annotations

          src[at, TAIL_ANNOTATION_MARKER.bytesize] == TAIL_ANNOTATION_MARKER &&
            src.getbyte(at + TAIL_ANNOTATION_MARKER.bytesize) != "-".ord
        end

        embedded_annotation_at = lambda do |at|
          @annotations && src[at, EMBEDDED_ANNOTATION_OPEN.bytesize] == EMBEDDED_ANNOTATION_OPEN
        end

        while pos < src.bytesize
          case state
          when :in_tail
            nl = src.index("\n", pos)
            if nl
              emit_tail(remarks, tail_start, nl, tail_line, tail_annotation)
              pos = nl + 1
              state = :top
            else
              emit_tail(remarks, tail_start, src.bytesize, tail_line, tail_annotation)
              return remarks
            end
          when :in_embedded
            closing = src.index(EMBEDDED_CLOSE, pos)
            nesting = src.index(EMBEDDED_OPEN, pos)
            if nesting && (!closing || nesting < closing)
              if empty_overlap_remark?(nesting)
                # `(*)` opens and closes immediately; depth unchanged.
                pos = nesting + 3
              else
                embedded_depth += 1
                pos = nesting + EMBEDDED_OPEN.bytesize
              end
            elsif closing
              embedded_depth -= 1
              pos = closing + EMBEDDED_CLOSE.bytesize
              if embedded_depth.zero?
                emit_embedded(remarks, embedded_start, closing, embedded_line, embedded_annotation)
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
              if empty_overlap_remark?(next_embed)
                # Standalone `(*)`: empty embedded remark, opener and closer
                # share the `*`. Emit with empty content and continue.
                emit_embedded(remarks, next_embed + EMBEDDED_OPEN.bytesize,
                              next_embed + EMBEDDED_OPEN.bytesize,
                              @line_map.line_number(next_embed), false)
                pos = next_embed + 3
                state = :top
              else
                # `(**` opens an annotation when annotations mode is on;
                # the byte after `(*` is a `*`, so the `(*)` overlap can
                # never collide with it.
                embedded_annotation = embedded_annotation_at.call(next_embed)
                open_len = if embedded_annotation
                             EMBEDDED_ANNOTATION_OPEN.bytesize
                           else
                             EMBEDDED_OPEN.bytesize
                           end
                embedded_start = next_embed + open_len
                embedded_line = @line_map.line_number(next_embed)
                embedded_depth = 1
                state = :in_embedded
                pos = embedded_start
              end
            else
              tail_annotation = tail_annotation_at.call(next_tail)
              marker_len = if tail_annotation
                             TAIL_ANNOTATION_MARKER.bytesize
                           else
                             TAIL_MARKER.bytesize
                           end
              tail_start = next_tail + marker_len
              tail_line = @line_map.line_number(next_tail)
              state = :in_tail
              pos = tail_start
            end
          end
        end

        remarks
      end

      def emit_tail(remarks, content_start, content_end, line, annotation)
        # Slice content from the original (UTF-8) source so the returned text
        # preserves the source encoding. Byte offsets come from the BINARY copy.
        raw = @source.byteslice(content_start...content_end)
        tag, content = parse_tail(raw.strip)
        remarks << Remark.new(
          position: content_start - (if annotation
                                       TAIL_ANNOTATION_MARKER.bytesize
                                     else
                                       TAIL_MARKER.bytesize
                                     end),
          end_position: content_end,
          line: line,
          text: content,
          tag: tag,
          format: if annotation
                    Model::RemarkFormat::TAIL_ANNOTATION
                  else
                    Model::RemarkFormat::TAIL
                  end,
        )
      end

      def emit_embedded(remarks, content_start, content_end, line, annotation)
        raw = @source.byteslice(content_start...content_end)
        tag, content = parse_embedded(raw)
        remarks << Remark.new(
          position: content_start - (if annotation
                                       EMBEDDED_ANNOTATION_OPEN.bytesize
                                     else
                                       EMBEDDED_OPEN.bytesize
                                     end),
          end_position: content_end + EMBEDDED_CLOSE.bytesize,
          line: line,
          text: content,
          tag: tag,
          format: if annotation
                    Model::RemarkFormat::EMBEDDED_ANNOTATION
                  else
                    Model::RemarkFormat::EMBEDDED
                  end,
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
