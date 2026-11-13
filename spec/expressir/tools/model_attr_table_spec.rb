# frozen_string_literal: true

require "spec_helper"
require "expressir/tools/model_attr_table"
require "json"

# expressir#634: the generated class→attrs table is the inventory of the
# shared wire contract. This spec pins its freshness — a model change
# without `rake model_attrs:generate` fails here, and the expressir-rs
# no-drift sync carries the same file, so both repos fail together until
# the rs mirror catches up.
RSpec.describe Expressir::Tools::ModelAttrTable do
  let(:fixture_path) do
    Expressir.root_path.join("spec", "fixtures", "model_attr_table.json")
  end

  it "matches a fresh generation of the model tree" do
    committed = JSON.parse(File.read(fixture_path))
    fresh = described_class.generate

    expect(fresh).to eq(committed)
  end

  it "covers every wire class (ModelElement tree + serializable helpers)" do
    table = JSON.parse(File.read(fixture_path))
    serializable = Lutaml::Model::Serializable
    wire_classes = described_class.model_classes.select do |k|
      k <= Expressir::Model::ModelElement || k <= serializable
    end

    expect(table.keys.sort).to eq(wire_classes.map(&:name).sort)
  end

  it "keys every class by its full name with sorted attrs" do
    table = JSON.parse(File.read(fixture_path))

    table.each do |klass, attrs|
      expect(klass).to start_with("Expressir::Model::")
      expect(attrs.keys).to eq(attrs.keys.sort)
    end
  end
end
