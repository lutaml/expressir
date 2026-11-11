# frozen_string_literal: true

require "spec_helper"
require "parsanol"
require "expressir"

# The P21 compile-parity gate (issue #625): the shipped PARG artifact
# (lib/expressir/p21/iso-10303-21.artifact.json — the checksummed
# single source of truth shared with expressir-rs) must parse the ISO
# 10303-21 annex corpus byte-identically to the ruby DSL grammar.
# Drift here is a release blocker for both lanes.
RSpec.describe "Expressir::P21 PARG artifact parity" do # rubocop:disable RSpec/DescribeClass
  let(:artifact) do
    Parsanol::PARG::Artifact.load(
      Expressir.root_path.join("lib/expressir/p21/iso-10303-21.artifact.json").to_s,
    )
  end

  def fixture(name)
    Expressir.root_path.join("spec/fixtures/p21/conformance", name).read
  end

  def dsl_tree(source)
    Expressir::P21::Grammar.new.parse(source).to_h
  end

  def artifact_tree(source)
    artifact.parse("exchange_structure", source).to_h
  end

  %w[
    annex-e-0.p21 annex-e-1.p21 annex-h-0.p21
    annex-i-0.p21 annex-i-1.p21 annex-j-0.p21
  ].each do |name|
    it "replays the DSL tree byte-identically for #{name}" do
      source = fixture(name)
      expect(JSON.parse(artifact_tree(source).to_json))
        .to eq(JSON.parse(dsl_tree(source).to_json))
    end
  end

  it "drives the public parser through the artifact lane" do
    population = Expressir::P21::Parser.parse(fixture("annex-i-0.p21"))
    expect(population.anchors).to include("POINT_1" => "#1")
    expect(population.header).to have_key("SCHEMA_POPULATION")
  end

  it "rejects a truncated exchange structure on the artifact lane" do
    truncated = "ISO-10303-21;\nHEADER;\nFILE_NAME('n');\nENDSEC;\nDATA;\n#1=E('v');\n"
    # A valid artifact propagates the parse failure (malformed input
    # fails loudly, on both lanes) rather than silently falling back.
    expect { artifact_tree(truncated) }.to raise_error(Parsanol::ParseFailed)
    expect { Expressir::P21::Parser.parse(truncated) }
      .to raise_error(Parsanol::ParseFailed)
  end
end
