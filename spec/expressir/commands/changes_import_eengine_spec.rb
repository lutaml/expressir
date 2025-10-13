# frozen_string_literal: true

require "spec_helper"
require "expressir/commands/changes_import_eengine"

RSpec.describe Expressir::Commands::ChangesImportEengine do
  let(:xml_fixture) do
    File.join(__dir__, "../../fixtures/changes/sample_eengine.xml")
  end

  let(:schema_name) { "support_resource_schema" }
  let(:version) { "2" }

  describe ".call" do
    it "converts eengine XML to change YAML to stdout" do
      expect do
        described_class.call(xml_fixture, nil, schema_name, version)
      end.to output(/schema: support_resource_schema/).to_stdout
    end

    it "converts eengine XML and saves to file" do
      require "tempfile"
      Tempfile.create(["output", ".yaml"]) do |f|
        described_class.call(xml_fixture, f.path, schema_name, version)

        # Verify file was written
        content = File.read(f.path)
        expect(content).to include("schema: support_resource_schema")
        expect(content).to include("version: '2'")
        expect(content).to include("TYPE text")

        # Verify it can be loaded back
        require "expressir/changes"
        change_schema = Expressir::Changes::SchemaChange.from_file(f.path)
        expect(change_schema.schema).to eq(schema_name)
        expect(change_schema.editions.size).to eq(1)
        expect(change_schema.editions[0].version).to eq(version)
      end
    end

    it "extracts modifications from XML" do
      require "tempfile"
      Tempfile.create(["output", ".yaml"]) do |f|
        result = described_class.call(xml_fixture, f.path, schema_name, version)

        expect(result.editions[0].modifications.size).to eq(1)
        expect(result.editions[0].modifications[0].type).to eq("TYPE")
        expect(result.editions[0].modifications[0].name).to eq("text")
      end
    end

    it "strips whitespace from descriptions" do
      require "tempfile"
      Tempfile.create(["output", ".yaml"]) do |f|
        result = described_class.call(xml_fixture, f.path, schema_name, version)

        description = result.editions[0].description
        expect(description).not_to start_with("\n")
        expect(description).not_to end_with("\n")
        expect(description).to include("Underlying Type changed")
      end
    end

    it "appends to existing change schema" do
      require "tempfile"
      require "expressir/changes"

      Tempfile.create(["output", ".yaml"]) do |f|
        # Create initial file
        initial = Expressir::Changes::SchemaChange.new(schema: schema_name)
        initial.add_or_update_edition("1", "Version 1",
                                      { additions: [], modifications: [], deletions: [] })
        initial.to_file(f.path)

        # Convert and append
        result = described_class.call(xml_fixture, f.path, schema_name, "2")

        expect(result.editions.size).to eq(2)
        expect(result.editions[0].version).to eq("1")
        expect(result.editions[1].version).to eq("2")
      end
    end

    it "replaces existing edition with same version" do
      require "tempfile"
      require "expressir/changes"

      Tempfile.create(["output", ".yaml"]) do |f|
        # Create initial file
        initial = Expressir::Changes::SchemaChange.new(schema: schema_name)
        initial.add_or_update_edition("2", "Old description",
                                      { additions: [], modifications: [], deletions: [] })
        initial.to_file(f.path)

        # Convert and replace
        result = described_class.call(xml_fixture, f.path, schema_name, "2")

        expect(result.editions.size).to eq(1)
        expect(result.editions[0].description).to include("TYPE text")
      end
    end
  end
end
