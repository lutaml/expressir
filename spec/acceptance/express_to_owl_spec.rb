require "spec_helper"

RSpec.describe "Expressr" do
  describe "express-to-owl" do
    pending "Still needs implementation"

    it "convert express to owl system" do
      command = %W(express-to-owl #{sample_file})
      capture_stdout { Expressr::Cli.start(command) }
    end
  end

  def sample_file
    @sample_file ||= Expressr.root_path.join(
      "original", "examples", "ap233", "ap233e1_arm_lf_stepmod-2010-11-12.xml"
    )
  end
end
