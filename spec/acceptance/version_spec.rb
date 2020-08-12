require "spec_helper"

RSpec.describe "Expressr" do
  describe "version" do
    it "displays the current verison" do
      command = %w(version)
      output = capture_stdout { Expressr::Cli.start(command) }

      expect(output).to include("Version #{Expressr::VERSION}")
    end
  end
end
