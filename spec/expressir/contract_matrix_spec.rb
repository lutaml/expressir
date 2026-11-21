# frozen_string_literal: true

require "spec_helper"
require "json"
require "yaml"
require "digest"
require "expressir"

# The contract matrix (issue #624): what the canonical lane seals,
# every lane loads and verifies byte-identically. Drift here is a
# release blocker — canonicalization changes are invisible to
# parse-level differentials (the parsanol rs#397 lesson). The P21
# artifact has its own gate (spec/expressir/p21/parg_parity_spec.rb).
ARTIFACT_PATHS = {
  "model-hash wire" => "wire.json",
  "attached wire" => "attached.json",
  "formatted text" => "formatted.exp",
  "formatted-wire text" => "formatted-wire.exp",
  "stripped text" => "stripped.exp",
}.freeze

RSpec.describe "contract matrix" do # rubocop:disable RSpec/DescribeClass
  let(:matrix) { Expressir.root_path.join("spec/fixtures/contract-matrix") }
  let(:manifest) { YAML.load_file(matrix.join("manifest.yml")) }

  def artifact(name)
    matrix.join(name).read
  end

  it "seals every artifact with its manifest checksum" do
    manifest["artifacts"].each do |shape, sha|
      path = ARTIFACT_PATHS.fetch(shape)
      expect("sha256:#{Digest::SHA256.hexdigest(artifact(path))}")
        .to eq(sha), "#{shape}: manifest checksum mismatch"
    end
  end

  it "re-derives the canonical wire byte-identically" do
    unless Expressir::Express::Core::NATIVE_AVAILABLE
      skip "the canonical lane is the native extension (EXPRESSIR_DISABLE_NATIVE=1)"
    end
    resealed = "#{JSON.pretty_generate(
      Expressir::Express::Core.parse_to_model_hash(artifact('source.exp'), 'source.exp'),
    )}\n"
    expect(resealed).to eq(artifact("wire.json"))
  end

  %w[wire.json attached.json].each do |shape|
    it "loads and re-renders #{shape} byte-identically" do
      model = Expressir::Model::ExpFile.from_hash(JSON.parse(artifact(shape)))
      # The product rehydrates the parent chain on load; the rendered
      # schema-relative tags need it.
      model.wire_parents if model.respond_to?(:wire_parents)
      # The raw core wire (pre-attach) carries no owner remarks, so its
      # render has no owner blocks (#694); the attached shape is the
      # canonical pipeline's product.
      formatted_artifact = shape == "wire.json" ? "formatted-wire.exp" : "formatted.exp"
      formatted = Expressir::Express::Formatter.new.format(model)
      expect(formatted).to eq(artifact(formatted_artifact))

      stripped = Expressir::Express::Formatter.new(no_remarks: true).format(model)
      expect(stripped).to eq(artifact("stripped.exp"))
    end
  end

  it "round-trips the formatted text back into the wire shape" do
    parsed = Expressir::Express::Parser.from_exp(artifact("formatted.exp"))
    reformatted = Expressir::Express::Formatter.format(parsed)
    expect(reformatted).to eq(artifact("formatted.exp"))
  end
end
