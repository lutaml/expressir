# frozen_string_literal: true

require "spec_helper"
require_relative "../../support/shared_command_examples"
require "fileutils"

RSpec.describe Expressir::Commands::Coverage do
  # Include shared examples for common file processing
  it_behaves_like "command file processing", described_class

  # Command-specific tests for coverage functionality
  describe "#coverage specific functionality" do
    include Expressir::ConsoleHelper

    # Create a test subclass that won't exit on errors
    let(:test_command_class) do
      Class.new(described_class) do
        # Override exit_with_error to raise an error instead of exiting
        def exit_with_error(message)
          raise StandardError, message
        end
      end
    end

    let(:express_file) { "spec/syntax/remark.exp" }

    it "generates report with documentation coverage information" do
      output = capture_stdout do
        test_command_class.new.run([express_file])
      rescue SystemExit, StandardError
        # Ignore any errors or exits
      end

      # Check for coverage information
      expect(output).to include("Documentation Coverage")
    end

    it "creates a yaml report when format is yaml" do
      output = capture_stdout do
        test_command_class.new(format: "yaml").run([express_file])
      rescue SystemExit, StandardError
        # Ignore any errors or exits
      end

      # Check for YAML output
      expect(output).to include("---")
      expect(output).to include("overall:")
    end

    it "creates a json report when format is json" do
      output = capture_stdout do
        test_command_class.new(format: "json").run([express_file])
      rescue SystemExit, StandardError
        # Ignore any errors or exits
      end

      # Check for JSON output
      expect(output).to include("{")
      expect(output).to include("\"overall\":")
    end
  end
end
