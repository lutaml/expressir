require "spec_helper"

RSpec.describe Reeper::Express::Repository do
  describe ".from_file" do
    it "build an instance from a file" do
      name = "Ap233_systems_engineering_arm_LF"

      repo = Reeper::Express::Repository.from_xml(sample_file)
      schema = repo.schemas.first

      expect(repo.name).to eq(name)
      expect(repo.schemas.count).to eq(1)
      expect(schema.name).to eq(name)
      expect(schema.contents.count).to eq(795)
      expect(schema.contents.first.schema).to eq(name)
      expect(schema.contents.first.name).to eq("Abs_function")
    end
  end

  def sample_file
    @sample_file ||= Reeper.root_path.join(
      "original", "examples", "ap233", "ap233e1_arm_lf_stepmod-2010-11-12.xml"
    )
  end
end
