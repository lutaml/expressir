# frozen_string_literal: true

module Expressir
  module Express
    # Extracts remarks from EXPRESS source text in a single left-to-right scan.
    #
    # Tail remarks (`-- ...`) and embedded remarks (`(* ... *)`) share one
    # cursor: whichever opener comes first claims the text it encloses, so a
    # `--` inside a documentation block is part of that block — never a
    # spurious tail remark — and a `(*` inside a tail remark stays part of
    # the tail line (https://github.com/lutaml/expressir/issues/308).
    class RemarkScanner
      TAIL_OPENER = "--"
      BLOCK_OPENER = "(*"
      BLOCK_CLOSER = "*)"

      INFORMAL_PROPOSITION_PATTERN = /\A(IP\d+):\s*(.*)\z/

      def initialize(source)
        @source = source
        @bytes = source.b
        @position = 0
        @line = 1
        # Memoized next-occurrence indexes; -1 means "not searched yet".
        # A nil is final: the cursor only advances, so a pattern absent
        # ahead of it stays absent. Without this cache, every remark would
        # rescan to EOF for the missing opener kind — O(remarks * bytes).
        @next_tail = -1
        @next_block = -1
      end

      # Returns remark hashes ({position:, line:, text:, tag:, format:})
      # ordered by byte position. Positions are byte offsets of the opener.
      def scan
        remarks = []
        while (opener = next_opener)
          kind, index = opener
          consume_to(index)
          remark = kind == :tail ? scan_tail : scan_embedded
          remarks << remark if remark
        end
        remarks
      end

      private

      def next_opener
        tail = next_tail
        block = next_block
        return nil unless tail || block
        return [:embedded, block] if tail.nil? || (block && block < tail)

        [:tail, tail]
      end

      def next_tail
        @next_tail = @bytes.index(TAIL_OPENER, @position) if stale?(@next_tail)
        @next_tail
      end

      def next_block
        @next_block = @bytes.index(BLOCK_OPENER, @position) if stale?(@next_block)
        @next_block
      end

      def stale?(cached)
        cached && cached < @position
      end

      def consume_to(index)
        @line += @bytes.byteslice(@position...index).count("\n")
        @position = index
      end

      def scan_tail
        start = @position
        line = @line
        line_end = @bytes.index("\n", start) || @bytes.bytesize
        text = @source.byteslice((start + 2)...line_end).strip
        consume_to(line_end)

        tag, content = parse_tail_tag(text)
        { position: start, line: line, text: content, tag: tag,
          format: "tail" }
      end

      def scan_embedded
        start = @position
        line = @line
        closer = @bytes.index(BLOCK_CLOSER, start + 2)

        # An unterminated block is malformed EXPRESS; consume the rest of the
        # source silently so no tail remarks are invented inside it.
        unless closer
          consume_to(@bytes.bytesize)
          return nil
        end

        content = @source.byteslice((start + 2)...closer)
        consume_to(closer + 2)

        tag, text = parse_tag(content.strip)
        { position: start, line: line, text: text, tag: tag,
          format: "embedded" }
      end

      def parse_tail_tag(text)
        if (match = text.match(INFORMAL_PROPOSITION_PATTERN))
          match.captures
        else
          parse_tag(text)
        end
      end

      def parse_tag(text)
        if text.start_with?('"') && (end_quote = text.index('"', 1))
          [text[1...end_quote], text[(end_quote + 1)..].strip]
        else
          [nil, text]
        end
      end
    end
  end
end
