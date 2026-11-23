# frozen_string_literal: true

require "spec_helper"

# WG12 informal-proposition markers (issue #693 family): a bare
# `-- IP1:` line inside an entity declares the proposition; the
# pipeline turns it into an InformalPropositionRule, and the formatter
# must write it back in the ISO shorthand (`--IP1:`, with the text when
# the proposition carries one) so the round trip holds.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA sample_schema;
      ENTITY sample_entity;
        mirror_placement : axis2_placement;
        -- IP1:
        -- IP2: the mirror axis text
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  def round_trip
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
  end

  it "writes the proposition markers with the ISO shorthand" do
    output = round_trip

    expect(output.scan("--IP1:").size).to eq(1)
    expect(output).to include("--IP2: the mirror axis text")
    expect(output.scan("--IP2:").size).to eq(1)
  end

  it "keeps the propositions in the model after the round trip" do
    reparsed = Expressir::Express::Parser.from_exp(round_trip)
    ips = reparsed.schemas.first.entities.first.informal_propositions

    expect(ips.map(&:id)).to eq(%w[IP1 IP2])
    # The shorthand line stores on the item's UNTAGGED lane (#723 — the
    # plain form keeps it, the tagged description blocks stay
    # annotation); descriptions themselves ride `remarks`.
    expect(Array(ips[1].remark_items).flat_map do |ri|
      Array(ri.remarks) + Array(ri.untagged_remarks).map(&:text)
    end.join).to include("the mirror axis text")
  end

  it "formats to a fixed point" do
    once = round_trip
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once),
    )

    expect(twice).to eq(once)
  end
end
