# frozen_string_literal: true

require "spec_helper"
require "parsanol"
require "expressir"

# The P21 compile-parity gate (issue #625): the shipped PARG artifact
# (lib/expressir/p21/iso-10303-21.artifact.json — the checksummed
# single source of truth shared with expressir-rs) must replay the
# ruby compiler's trees byte-identically on the ISO 10303-21 annex
# corpus. The oracle is the BAKED DSL trees (*.tree.json, captured
# from the ruby DSL grammar before its retirement) — the rust suite
# replays the same files. Drift here is a release blocker for both
# compilers.
RSpec.describe "Expressir::P21 PARG artifact parity" do # rubocop:disable RSpec/DescribeClass
  let(:artifact) do
    Parsanol::PARG::Artifact.load(
      Expressir.root_path.join("lib/expressir/p21/iso-10303-21.artifact.json").to_s,
    )
  end

  def fixture(name)
    Expressir.root_path.join("spec/fixtures/p21/conformance", name).read
  end

  def baked_tree(stem)
    JSON.parse(
      Expressir.root_path.join("spec/fixtures/p21/conformance/#{stem}.tree.json").read,
    )
  end

  def artifact_tree(source)
    artifact.parse("exchange_structure", source).to_h
  end

  %w[
    annex-e-0 annex-e-1 annex-h-0
    annex-i-0 annex-i-1 annex-j-0
  ].each do |stem|
    it "replays the baked DSL tree byte-identically for #{stem}" do
      expect(JSON.parse(artifact_tree(fixture("#{stem}.p21")).to_json))
        .to eq(baked_tree(stem))
    end
  end

  it "drives the public parser through the artifact lane" do
    population = Expressir::P21::Parser.parse(fixture("annex-i-0.p21"))
    expect(population.anchors).to include("POINT_1" => "#1")
    expect(population.header).to have_key("SCHEMA_POPULATION")
  end

  it "rejects a truncated exchange structure on the artifact lane" do
    truncated = "ISO-10303-21;\nHEADER;\nFILE_NAME('n');\nENDSEC;\nDATA;\n#1=E('v');\n"
    # The artifact is the only lane: malformed input fails loudly.
    expect { artifact_tree(truncated) }.to raise_error(Parsanol::ParseFailed)
    expect { Expressir::P21::Parser.parse(truncated) }
      .to raise_error(Parsanol::ParseFailed)
  end
end
