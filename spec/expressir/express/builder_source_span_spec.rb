# frozen_string_literal: true

require "spec_helper"

# Source spans are computed from BYTE offsets (parser slice offsets),
# so the builder must extract the span window with byteslice. Indexing
# the UTF-8 source with String#[] uses CHARACTER positions: past the
# document's first multibyte character the window drifts backwards and
# .strip shaves the shifted tail off, dropping END tokens from
# late-file construct spans.
RSpec.describe Expressir::Express::Builder do
  describe "source spans use byte windows" do
    let(:source) do
      # The comment carries a multibyte character BEFORE the entity, so
      # every byte offset past it differs from the character offset.
      <<~EXP
        SCHEMA span_byte_window;
        (* drift éééééééééé *)
        ENTITY late_entity;
          a : STRING;
        WHERE
          WR1: a <> '';
        END_ENTITY;
        END_SCHEMA;
      EXP
    end

    def parse_model
      Expressir::Express::Parser.from_exp(source, include_source: true)
    end

    it "keeps the entity span byte-exact past multibyte content" do
      model = parse_model
      entity = model.schemas.first.entities.first

      start_b = source.b.index("ENTITY late_entity;")
      expected = source.b.index("END_ENTITY;", start_b) +
        "END_ENTITY;".length - start_b

      expect(entity.source_length).to eq(expected)
    end

    it "keeps the schema span byte-exact past multibyte content" do
      model = parse_model
      schema = model.schemas.first

      start_b = source.b.index("SCHEMA span_byte_window;")
      expected = source.b.index("END_SCHEMA;", start_b) +
        "END_SCHEMA;".length - start_b

      expect(schema.source_length).to eq(expected)
    end
  end
end
