# frozen_string_literal: true

require "spec_helper"

# WG12 annotated-EXPRESS round trips (issue #691): remark items in rule
# contexts (WHERE/UNIQUE/IP) render multiline markup through the `--`
# tail form, whose continuation lines leak as bare source text the
# parser rejects. The multiline remark must render as a block so the
# formatter's own output re-parses.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA sample_schema;
      ENTITY sample_entity;
      WHERE
        WR1: TRUE;
      END_ENTITY;
      END_SCHEMA;

      (*"sample_schema.sample_entity.WR1.__figure"
      [[figure-x-6]]
      .Pattern offset required instances
      ====
      image::pattern.png[]
      ====
      *)

      (*"sample_schema.sample_entity.WR1.__note" A single-line note. *)
    EXP
  end

  def round_trip
    formatted = Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
    reparsed = Expressir::Express::Parser.from_exp(formatted)
    [formatted, reparsed]
  end

  it "emits multiline rule-context remarks as blocks" do
    formatted, = round_trip

    expect(formatted).to include('(*"sample_schema.sample_entity.WR1.__figure"')
    expect(formatted).not_to include('--"sample_schema.sample_entity.WR1.__figure"')
  end

  it "produces output the parser accepts again" do
    _, reparsed = round_trip

    wr = reparsed.schemas.first.entities.first.where_rules.first
    expect(wr.id).to eq("WR1")
    texts = Array(wr.remark_items).flat_map(&:remarks).map(&:to_s)
    expect(texts.join("\n")).to include("image::pattern.png[]")
    expect(texts.join("\n")).to include(".Pattern offset required instances")
  end

  it "keeps single-line rule-context remarks in the tail form" do
    formatted, = round_trip

    expect(formatted)
      .to include('--"sample_schema.sample_entity.WR1.__note" A single-line note.')
  end
end
