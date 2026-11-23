module Expressir
  module Express
    module Formatters
      module RemarkFormatter
        def format_remark(node, remark)
          # Handle embedded remarks
          if remark.include?("\n")
            [
              [
                "(*\"",
                node.path || node.id,
                "\"",
              ].join,
              remark,
              "*)",
            ].join("\n")
          elsif node.path.nil? && node.id.include?("IP")
            # Handle immediate informal propositions
            [
              "--",
              node.id,
              " ",
              remark,
            ].join
          else
            # Handle tail remarks
            [
              "--\"",
              node.path || node.id,
              "\" ",
              remark,
            ].join
          end
        end

        def format_untagged_remark(remark)
          return "" unless remark.is_a?(Model::RemarkInfo)

          text = remark.text
          return "" if text.nil? || text.empty?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text

          # A multi-line remark always renders as a block: the `--` /
          # `---` tail forms would leak its continuation lines into the
          # source as bare text the parser rejects (#691).
          if text.include?("\n")
            if remark.embedded_annotation?
              ["(**", formatted_text, "**)"].join("\n")
            else
              ["(*", formatted_text, "*)"].join("\n")
            end
          elsif remark.tail_annotation?
            "--- #{formatted_text}"
          elsif remark.tail?
            "-- #{formatted_text}"
          elsif remark.embedded_annotation?
            "(** #{formatted_text} *)"
          else
            "(* #{formatted_text} *)"
          end
        end

        def format_inline_tail_remark(node)
          return "" if @no_remarks && !@keep_untagged_remarks
          return "" unless node.is_a?(Model::ModelElement)
          return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

          remark = node.untagged_remarks.first
          return "" unless remark.is_a?(Model::RemarkInfo)
          # Placement-carrying remarks render through their own paths
          # (leading above the node, inline after the statement text);
          # this appends the legacy tail.
          return "" if remark.placement

          text = remark.text
          return "" if text.nil? || text.empty?

          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
          if text.include?("\n")
            # A multi-line remark cannot ride the `--` tail forms: its
            # continuation lines would leak as bare source text (#691).
            # The block form keeps them inside a remark opener.
            if remark.embedded_annotation?
              " (**\n#{formatted_text}\n**)"
            else
              " (*\n#{formatted_text}\n*)"
            end
          elsif remark.tail_annotation?
            " --- #{formatted_text}"
          elsif remark.tail?
            " -- #{formatted_text}"
          elsif remark.embedded_annotation?
            " (** #{formatted_text} *)"
          else
            " (* #{formatted_text} *)"
          end
        end

        def format_end_scope_remark(node)
          return "" if @no_remarks && !@keep_untagged_remarks
          return "" unless node.is_a?(Model::ModelElement)

          # Every legacy (unplaced) tail remark belongs after the END_*
          # keyword — writing only the last dropped the others (the WG12
          # `-- IP1:` markers). Remarks carrying an explicit placement
          # render through their placement-aware emitters.
          remarks = Array(node.untagged_remarks).reject(&:placement).select do |remark|
            remark.is_a?(Model::RemarkInfo) && remark.tail? &&
              !remark.text.nil? && !remark.text.empty?
          end
          return "" if remarks.empty?

          lines = remarks.map do |remark|
            text = remark.text
            # A multi-line text cannot ride the tail forms (#691).
            next "" if text.include?("\n")

            formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text
            remark.tail_annotation? ? "--- #{formatted_text}" : "-- #{formatted_text}"
          end.reject(&:empty?)
          return "" if lines.empty?

          # The first remark rides the END_ line; the rest follow below it.
          " #{lines.join("\n")}"
        end

        # The entity's informal propositions, in the ISO remark-tag form
        # so the source convention survives the round trip: `--IP1 text`,
        # or the bare declaration marker `--IP1` when the proposition
        # carries no text (the WG12 `-- IP1:` markers).
        def format_informal_propositions(node)
          # The propositions' TAGGED descriptions are annotation (#723);
          # the plain form (keep_untagged_remarks) re-renders only the
          # source's own shorthand lines, which attach as the items'
          # untagged remarks.
          return [] if @no_remarks && !@keep_untagged_remarks
          return [] unless node.is_a?(Model::ModelElement)
          return [] unless node.respond_to?(:informal_propositions)

          Array(node.informal_propositions).filter_map do |ip|
            # The attach stores the proposition's texts on its remark
            # item (create_or_find_informal_proposition returns it); the
            # ISO shorthand re-parses only with the colon. A multi-line
            # text cannot ride the shorthand (#691) — it renders as the
            # path-tagged block the source corpora write.
            item_texts = Array(ip.remark_items).flat_map do |ri|
              Array(ri.remarks) +
                Array(ri.untagged_remarks)
                  .grep(Model::RemarkInfo).map(&:text)
            end
            texts = if @no_remarks
                      Array(ip.remark_items).flat_map do |ri|
                        Array(ri.untagged_remarks)
                          .grep(Model::RemarkInfo).map(&:text)
                      end
                    else
                      (Array(ip.remarks) + item_texts)
                    end
            texts = texts.reject { |t| t.nil? || t.to_s.strip.empty? }
            # The bare WG12 marker (`--IP1:`) is the no-text declaration
            # form; the plain form skips propositions it has no source
            # line for (#723 — no invented lines).
            next "--#{ip.id}:" if texts.empty? && !@no_remarks
            next if texts.empty?

            if texts.any? { |t| t.include?("\n") }
              texts.map do |t|
                if t.include?("\n")
                  "(*\"#{schema_relative_path(ip)}.wr:#{ip.id}\"
#{t}
*)"
                else
                  "--#{ip.id}: #{t}"
                end
              end.join("\n")
            else
              texts.map do |t|
                "--#{ip.id}: #{t}"
              end.join("\n")
            end
          end
        end

        def format_preamble_remark(remark, indent_str = "")
          return "" unless remark.is_a?(Model::RemarkInfo)

          text = remark.text
          text = "\"#{remark.tag}\" #{text}" if remark.tagged?

          if remark.tail_annotation?
            "#{indent_str}--- #{text}"
          elsif remark.tail?
            "#{indent_str}-- #{text}"
          elsif remark.embedded_annotation? && text.include?("\n")
            lines = text.split("\n")
            [
              "#{indent_str}(**",
              *lines.map { |line| "#{indent_str}  #{line.strip}" },
              "#{indent_str}**)",
            ].join("\n")
          elsif remark.embedded_annotation?
            "#{indent_str}(** #{text} *)"
          elsif text.include?("\n")
            lines = text.split("\n")
            [
              "#{indent_str}(*",
              *lines.map { |line| "#{indent_str}  #{line.strip}" },
              "#{indent_str}*)",
            ].join("\n")
          else
            "#{indent_str}(* #{text} *)"
          end
        end

        def format_preamble_remarks(node, indent_str = "")
          return nil if @no_remarks && !@keep_untagged_remarks
          return nil unless node.is_a?(Model::ModelElement)
          return nil if node.untagged_remarks.nil? || node.untagged_remarks.empty?

          preamble_remarks = node.untagged_remarks.select do |remark|
            # Leading remarks render above the node (place_remarks) and
            # every legacy tail remark renders after the END_ keyword;
            # emitting either in the preamble would write them twice.
            # TRAILING remarks render before their body's closing keyword
            # (#726) — the preamble would write them twice too.
            remark.is_a?(Model::RemarkInfo) && !remark.leading? &&
              remark.placement != Model::RemarkPlacement::TRAILING &&
              !(remark.placement.nil? && remark.tail?) &&
              !remark.text.nil? && !remark.text.empty?
          end

          return nil if preamble_remarks.empty?

          preamble_remarks.map do |remark|
            format_preamble_remark(remark, indent_str)
          end.join("\n")
        end

        # Remarks that close one body of `node`, emitted just before that
        # body's closing keyword. Only explicit TRAILING remarks for the named
        # region qualify: legacy (nil) remarks keep their historical emission
        # path so old caches render exactly as they did before.
        def format_trailing_region_remarks(node, region)
          return [] if @no_remarks && !@keep_untagged_remarks
          return [] unless node.is_a?(Model::ModelElement)

          Array(node.untagged_remarks).filter_map do |remark|
            next unless remark.trailing_region?(region)

            formatted = format_untagged_remark(remark)
            formatted unless formatted.empty?
          end
        end

        # Remarks written after their statement on the same line, which for a
        # single-line statement is where appending puts them back. Opener
        # remarks are excluded: those belong on the first line rather than
        # after the closing keyword, and {#format_opener_remarks} emits them.
        # Mid-keyword remarks (ELSE / OTHERWISE regions) are excluded too:
        # {#format_mid_keyword_remarks} emits them after their keyword.
        def format_inline_statement_remarks(node)
          formatted_inline_remarks(node) { |remark| remark.region.nil? }
        end

        # Remarks that trailed the opening line of a statement spanning
        # several lines, as in `IF x THEN -- why`. Where they are written back
        # is Formatter#format's business, not this method's.
        def format_opener_remarks(node)
          formatted_inline_remarks(node, &:opener?)
        end

        # Remarks that trailed a mid-construct keyword of `node` — the ELSE
        # line of an IF, the OTHERWISE line of a CASE — emitted after that
        # keyword, where they were written.
        def format_mid_keyword_remarks(node, region)
          formatted_inline_remarks(node) { |remark| remark.inline_region?(region) }
        end

        # The inline remarks of a node that the given block accepts, formatted
        # and joined. The callers partition the same collection, so every
        # inline remark is emitted by exactly one of them.
        def formatted_inline_remarks(node, &)
          # The plain form (no_remarks + keep_untagged_remarks) keeps the
          # source's own comments; only the annotated channels stop
          # (#721 — every other placement channel honors the pair).
          return "" if @no_remarks && !@keep_untagged_remarks
          return "" unless node.is_a?(Model::TakesInlineRemark)

          Array(node.untagged_remarks).filter_map do |remark|
            next unless remark.inline? && yield(remark)

            formatted = format_untagged_remark(remark)
            formatted unless formatted.empty?
          end.map { |text| " #{text}" }.join
        end

        def format_leading_statement_remarks(node)
          return [] if @no_remarks && !@keep_untagged_remarks
          return [] unless node.is_a?(Model::ModelElement)

          # Leading remarks ride above their node — statements between
          # the lines of a body, and declarations after a whole-line
          # `--` comment (#696).
          Array(node.untagged_remarks).filter_map do |remark|
            next unless remark.leading?

            formatted = format_untagged_remark(remark)
            formatted unless formatted.empty?
          end
        end

        # Block-end emission for ALIAS/REPEAT bodies. Tagged remarks are
        # stored as bare text in node.remarks alongside a mirror of every
        # untagged text (add_remark dual-store), so "genuinely tagged" is
        # derivable only by multiset-subtracting the untagged texts.
        def format_block_end_remarks(node)
          return [] if @no_remarks && !@keep_untagged_remarks

          untagged = Array(node.untagged_remarks)
          remaining = untagged.map(&:text).tally
          tagged = Array(node.remarks).compact.reject do |text|
            next false unless remaining[text]&.positive?

            remaining[text] -= 1
            true
          end

          [
            *tagged.map { |text| format_remark(node, text) },
            # Leading and inline remarks are emitted by their own paths;
            # including them here would render them a second time.
            *untagged.reject { |r| r.leading? || r.inline? }
              .filter_map do |remark|
                formatted = format_untagged_remark(remark)
                formatted unless formatted.empty?
              end,
          ]
        end

        def format_remarks(node)
          remarks = []

          # Add tagged remarks
          if node.is_a?(Model::HasRemarks) && !@no_remarks &&
              !node.remarks.nil?
            remarks.concat(node.remarks.compact.map do |remark|
              format_remark(node, remark)
            end)
          end

          # Skip untagged remarks for nodes that handle them separately
          skip_untagged = node.is_a?(Model::Declarations::Attribute) ||
            node.is_a?(Model::DataTypes::EnumerationItem) ||
            node.is_a?(Model::Declarations::Schema) ||
            node.is_a?(Model::Declarations::Entity) ||
            node.is_a?(Model::Declarations::Type) ||
            node.is_a?(Model::Declarations::Function) ||
            node.is_a?(Model::Declarations::Procedure) ||
            node.is_a?(Model::Declarations::Rule)

          # Add untagged remarks only for nodes that don't handle them specially
          if !skip_untagged && node.is_a?(Model::ModelElement) && !@no_remarks &&
              !node.untagged_remarks.nil?
            remarks.concat(node.untagged_remarks.map do |remark|
              format_untagged_remark(remark)
            end)
          end

          remarks
        end

        # The tagged remark-item blocks attached to this node
        # (expressir#603: RemarkItem children render with their owners).
        def format_remark_items(node)
          return [] if @no_remarks
          return [] unless node.respond_to?(:remark_items)

          Array(node.remark_items).map { |item| format(item) }.reject(&:empty?)
        end

        # The schema's own tagged description (`(*"schema_id" ... *)`)
        # as a remark block, so a schema-level tagged description
        # survives a source round trip (it re-attaches to the schema).
        def format_schema_remarks(node)
          return [] if @no_remarks

          tagged_remark_blocks(node) do |remark|
            remark_block(node.id, remark)
          end
        end

        # The owner's own tagged descriptions (`(*"path" text *)`) as
        # remark blocks after its declaration (#694): the #679 storage
        # contract puts renderable tagged texts on owner.remarks, and
        # every owner class renders them. The SCHEMA renders its own in
        # its body ({#format_schema_remarks}); enumeration items render
        # with their TYPE (their owners never reach the dispatch).
        def format_owner_tagged_remarks(node)
          return [] if @no_remarks
          return [] unless node.is_a?(Model::ModelElement)
          return [] if node.is_a?(Model::Declarations::Schema)
          # Enumeration items render inline inside ENUMERATION OF (...);
          # their remarks belong after the TYPE, emitted by
          # {#format_enumeration_item_remarks} — never appended here.
          return [] if node.is_a?(Model::DataTypes::EnumerationItem)
          # Remark items render themselves ({#format_remark_items});
          # their own remarks carry the same text.
          return [] if node.is_a?(Model::Declarations::RemarkItem)
          return [] unless node.respond_to?(:remarks)

          # A node whose schema-relative path does not resolve (a
          # statement in a parentless walk) renders its texts through
          # the remark-item channel instead — an empty tag would write
          # a `(*""` block.
          tag = schema_relative_path(node)
          return [] if tag.nil? || tag.to_s.empty?

          tagged_remark_blocks(node) do |remark|
            remark_block(tag, remark)
          end
        end

        # The enumeration items' tagged descriptions, rendered with their
        # TYPE (the items render inline inside ENUMERATION OF (...) and
        # never reach the dispatch themselves).
        def format_enumeration_item_remarks(node)
          return [] if @no_remarks
          return [] unless node.is_a?(Model::Declarations::Type)

          Array(node.enumeration_items).flat_map do |item|
            tagged_remark_blocks(item) do |remark|
              remark_block(schema_relative_path(item), remark)
            end
          end
        end

        private

        # Yields each of the node's tagged remark texts through the block
        # and collects the non-empty results.
        def tagged_remark_blocks(node)
          Array(node.remarks).reject do |text|
            text.nil? || text.to_s.empty?
          end.filter_map do |text|
            yield text.to_s
          end
        end

        # A tagged remark block in the source convention: the multi-line
        # form when the text spans lines, the inline form otherwise.
        def remark_block(tag, text)
          if text.include?("\n")
            "(*\"#{tag}\"\n#{text}\n*)"
          else
            "(*\"#{tag}\" #{text} *)"
          end
        end
      end
    end
  end
end
