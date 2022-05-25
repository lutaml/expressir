require "spec_helper"

RSpec.describe "Expressir" do
  describe "version" do
    it "has a version number" do |example|
      print "\n[#{example.description}] "
      expect(Expressir::VERSION).not_to be nil

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "displays the current verison" do |example|
      print "\n[#{example.description}] "
      command = %w(version)
      output = capture_stdout { Expressir::Cli.start(command) }
      expect(output).to include("Version #{Expressir::VERSION}")

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end
  end
end
