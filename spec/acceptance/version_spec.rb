require "spec_helper"

RSpec.describe "Expressir" do
  describe "version" do
    it "displays the current verison" do
      command = %w(version)
      output = capture_stdout { Expressir::Cli.start(command) }

      expect(output).to include("Version #{Expressir::VERSION}")
    end
  end
end
