# frozen_string_literal: true

require "spec_helper"
require "expressir/changes"

RSpec.describe Expressir::Changes::SchemaChange do
  let(:simple_fixture) do
    File.join(__dir__, "../../fixtures/changes/simple_change.yaml")
  end

  let(:complete_fixture) do
    File.join(__dir__, "../../fixtures/changes/complete_change.yaml")
  end

  let(:mapping_fixture) do
    File.join(__dir__, "../../fixtures/changes/mapping_change.yaml")
  end

  describe ".from_file" do
    it "loads a simple change file" do
      schema = described_class.from_file(simple_fixture)

      expect(schema.schema).to eq("test_schema")
      expect(schema.edition_change.size).to eq(1)
      expect(schema.edition_change[0].version).to eq("2")
      expect(schema.edition_change[0].modifications.size).to eq(1)
      expect(schema.edition_change[0].modifications[0].type).to eq("TYPE")
      expect(schema.edition_change[0].modifications[0].name).to eq("text")
    end

    it "loads a complete change file with multiple editions" do
      schema = described_class.from_file(complete_fixture)

      expect(schema.schema).to eq("topology_schema")
      expect(schema.edition_change.size).to eq(2)

      # Check first edition
      ed1 = schema.edition_change[0]
      expect(ed1.version).to eq("2")
      expect(ed1.additions.size).to eq(2)
      expect(ed1.modifications.size).to eq(2)

      # Check second edition with deletions
      ed2 = schema.edition_change[1]
      expect(ed2.version).to eq("7")
      expect(ed2.deletions.size).to eq(2)
      expect(ed2.deletions[0].interfaced_items).to eq("length_measure")
    end

    it "loads a mapping change file" do
      schema = described_class.from_file(mapping_fixture)

      expect(schema.schema).to eq("advanced_boundary_representation")
      expect(schema.edition_change.size).to eq(1)
      expect(schema.edition_change[0].changes.size).to eq(2)
      expect(schema.edition_change[0].changes[0].change).to include("mapping")
    end

    it "handles empty files" do
      require "tempfile"
      Tempfile.create(["empty", ".yaml"]) do |f|
        f.write("---\n")
        f.rewind

        schema = described_class.from_file(f.path)
        expect(schema.schema).to be_nil
        expect(schema.edition_change).to be_nil
      end
    end
  end

  describe "#add_or_update_edition" do
    let(:schema) { described_class.new(schema: "test_schema") }

    it "adds a new edition" do
      changes = {
        additions: [
          Expressir::Changes::ItemChange.new(type: "ENTITY",
                                             name: "new_entity"),
        ],
        modifications: [],
        removals: [],
      }

      schema.add_or_update_edition("2", "Added new entity", changes)

      expect(schema.edition_change.size).to eq(1)
      expect(schema.edition_change[0].version).to eq("2")
      expect(schema.edition_change[0].additions.size).to eq(1)
    end

    it "replaces an existing edition with same version" do
      changes1 = {
        additions: [
          Expressir::Changes::ItemChange.new(type: "ENTITY", name: "entity1"),
        ],
        modifications: [],
        removals: [],
      }
      schema.add_or_update_edition("2", "First description", changes1)

      changes2 = {
        additions: [
          Expressir::Changes::ItemChange.new(type: "ENTITY", name: "entity2"),
        ],
        modifications: [],
        removals: [],
      }
      schema.add_or_update_edition("2", "Second description", changes2)

      expect(schema.edition_change.size).to eq(1)
      expect(schema.edition_change[0].description).to eq("Second description")
      expect(schema.edition_change[0].additions[0].name).to eq("entity2")
    end

    it "adds new edition when version is different" do
      changes1 = {
        additions: [
          Expressir::Changes::ItemChange.new(type: "ENTITY", name: "entity1"),
        ],
        modifications: [],
        removals: [],
      }
      schema.add_or_update_edition("2", "Version 2", changes1)

      changes2 = {
        additions: [
          Expressir::Changes::ItemChange.new(type: "ENTITY", name: "entity2"),
        ],
        modifications: [],
        removals: [],
      }
      schema.add_or_update_edition("3", "Version 3", changes2)

      expect(schema.edition_change.size).to eq(2)
      expect(schema.edition_change[0].version).to eq("2")
      expect(schema.edition_change[1].version).to eq("3")
    end
  end

  describe "#to_file" do
    it "saves the change schema to a file" do
      require "tempfile"
      schema = described_class.from_file(simple_fixture)

      Tempfile.create(["output", ".yaml"]) do |f|
        schema.to_file(f.path)

        # Verify file was written
        content = File.read(f.path)
        expect(content).to include("schema: test_schema")
        expect(content).to include("version: '2'")

        # Verify it can be read back
        reloaded = described_class.from_file(f.path)
        expect(reloaded.schema).to eq(schema.schema)
        expect(reloaded.edition_change.size).to eq(schema.edition_change.size)
      end
    end
  end

  describe "round-trip" do
    it "maintains data integrity for simple change" do
      schema = described_class.from_file(simple_fixture)
      yaml_output = schema.to_yaml
      reloaded = described_class.from_yaml(yaml_output)

      expect(reloaded.schema).to eq(schema.schema)
      expect(reloaded.edition_change.size).to eq(schema.edition_change.size)
      expect(reloaded.edition_change[0].version).to eq(schema.edition_change[0].version)
    end

    it "maintains data integrity for complete change" do
      schema = described_class.from_file(complete_fixture)
      yaml_output = schema.to_yaml
      reloaded = described_class.from_yaml(yaml_output)

      expect(reloaded.schema).to eq(schema.schema)
      expect(reloaded.edition_change.size).to eq(schema.edition_change.size)

      # Verify deletions field
      ed2 = reloaded.edition_change[1]
      expect(ed2.deletions.size).to eq(schema.edition_change[1].deletions.size)
    end
  end
end
