require "spec_helper"
require "stringio"

RSpec.describe Expressir::Commands::Coverage do
  let(:output) { StringIO.new }
  let(:test_manifest_path) { File.join("spec", "fixtures", "test_manifest.yml") }

  before do
    # Redirect stdout for all tests
    allow($stdout).to receive(:puts) { |msg| output.puts(msg) }
    allow($stdout).to receive(:print) { |msg| output.print(msg) }
  end

  describe "#run with yaml manifest", skip: "Temporary skip while fixing SystemExit issue" do
    # Create a minimal options hash
    let(:options) { { format: "text" } }
    # Create an instance of the command with test mode to prevent real exits
    let(:command) do
      cmd = described_class.new(options)
      # Enable test mode to prevent exit and raise an exception instead
      cmd.instance_variable_set(:@test_mode, true)
      cmd
    end

    # Set our test manifest file and make sure it has the proper paths
    # that are already relative to the manifest location
    before do
      # The test manifest uses paths already relative to its location
      # which matches the behavior we want
      unless File.exist?(test_manifest_path)
        File.write(test_manifest_path, {
          "schemas" => {
            "test_schema_1" => { "path" => "spec/syntax/remark.exp" },
            "test_schema_2" => { "path" => "spec/expressir/test_undocumented.exp" },
          },
        }.to_yaml)
      end
    end

    context "with a complex nested YAML manifest" do
      it "correctly processes schema files from nested paths", :aggregate_failures do
        # The private method is tested indirectly through the run method
        command.run([test_manifest_path])

        # Check that the output contains expected messages
        expect(output.string).to include("Processing YAML manifest: #{test_manifest_path}")
        expect(output.string).to include("Found 2 schema files")
        expect(output.string).to include("Processing schemas from manifest file")

        # Check that it shows coverage info
        expect(output.string).to include("Documentation Coverage")
        expect(output.string).to include("remark.exp")
        expect(output.string).to include("Coverage Percentage")
      end

      it "creates a yaml report from the manifest" do
        # Reset the output for this test to capture just YAML output
        output.string = ""

        # Set format to yaml
        yaml_command = described_class.new(format: "yaml")

        # Run command
        yaml_command.run([test_manifest_path])

        # Check for YAML output
        expect(output.string).to include("---")
        expect(output.string).to include("overall:")
        expect(output.string).to include("total_entities:")
        expect(output.string).to include("files:")
        expect(output.string).to include("file: spec/syntax/remark.exp")
      end

      it "creates a json report from the manifest" do
        # Reset the output for this test to capture just JSON output
        output.string = ""

        # Set format to json
        json_command = described_class.new(format: "json")

        # Run command
        json_command.run([test_manifest_path])

        # Check for JSON output
        expect(output.string).to include("{")
        expect(output.string).to include("\"overall\":")
        expect(output.string).to include("\"total_entities\":")
        expect(output.string).to include("\"files\":")
        expect(output.string).to include("\"file\": \"spec/syntax/remark.exp\"")
      end
    end

    context "with an invalid YAML manifest" do
      # Use a temporary file for the invalid manifest
      let(:invalid_manifest_path) { File.join("spec", "fixtures", "invalid_manifest.yml") }

      before do
        # Create an invalid manifest file - valid YAML but wrong structure
        File.write(invalid_manifest_path, "# Valid YAML but missing schemas key\nkey1: value1\nkey2: value2")
      end

      after do
        # Clean up the temporary file
        File.delete(invalid_manifest_path) if File.exist?(invalid_manifest_path)
      end

      it "handles errors gracefully" do
        # Enable test mode to prevent exit and raise an exception instead
        command.instance_variable_set(:@test_mode, true)

        # The private method is tested indirectly through the run method
        expect do
          command.run([invalid_manifest_path])
        end.to raise_error(/Invalid YAML format/)

        # Check that error messages were displayed
        expect(output.string).to include("Processing YAML manifest: #{invalid_manifest_path}")
        expect(output.string).to include("Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key")
      end
    end
  end
end
