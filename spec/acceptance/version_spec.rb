require "spec_helper"

RSpec.describe "Expressir" do
  describe "version" do
    it "has a version number" do |example|
      GC.stress = ENV["GC_STRESS"] == "true"
      puts "Running tests in GC stress mode. It may take a couple of hours ..." if GC.stress

      print "\n[#{example.description}] "
      expect(Expressir::VERSION).not_to be nil
    end

    it "displays the current version" do |example|
      print "\n[#{example.description}] "
      command = %w(version)
      output = capture_stdout { Expressir::Cli.start(command) }
      expect(output).to include(Expressir::VERSION)
    end
  end
end
