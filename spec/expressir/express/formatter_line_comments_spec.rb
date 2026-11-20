# frozen_string_literal: true

require "spec_helper"

# Bare `--` line comments (issue #696): a whole-line comment between
# declarations leads the next declaration. They must survive a
# parse-format round trip, once each, above the construct they
# introduce — not as tails of the preceding one, and not dropped.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA sample_schema;
      -- schema-level comment A
      CONSTANT c : INTEGER := 1;
      END_CONSTANT;
      ---------- separator dashes
      -- comment before entity
      ENTITY sample_entity;
        -- comment inside entity
        a : INTEGER;
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  def round_trip
    formatted = Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
    [formatted, Expressir::Express::Parser.from_exp(formatted)]
  end

  it "conserves every bare comment" do
    formatted, = round_trip

    ["schema-level comment A", "separator dashes",
     "comment before entity", "comment inside entity"].each do |text|
      expect(formatted.scan(text).size).to eq(1), "#{text.inspect} is not written exactly once"
    end
  end

  it "renders comments above the construct they introduce" do
    formatted, = round_trip
    lines = formatted.lines.map(&:strip)

    a_index = lines.index("-- schema-level comment A")
    expect(a_index).to be > lines.index("CONSTANT")
    expect(a_index).to be < lines.index("c : INTEGER := 1;")

    before_entity = lines.index("-- comment before entity")
    expect(before_entity).to be < lines.index("ENTITY sample_entity;")

    inside = lines.index("-- comment inside entity")
    expect(inside).to be < lines.index("a : INTEGER;")
  end

  it "does not attach comments as tails of the preceding construct" do
    formatted, = round_trip

    expect(formatted).not_to include("END_CONSTANT; --")
    expect(formatted).not_to include("END_ENTITY; --")
  end

  it "formats to a fixed point" do
    formatted, reparsed = round_trip
    twice = Expressir::Express::Formatter.format(reparsed)

    expect(twice).to eq(formatted)
  end
end
