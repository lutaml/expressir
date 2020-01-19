require "spec_helper"

RSpec.describe "Reeper" do
  describe "version" do
    it "displays the current verison" do
      command = %w(version)
      output = capture_stdout { Reeper::Cli.start(command) }

      expect(output).to include("Version #{Reeper::VERSION}")
    end
  end
end
