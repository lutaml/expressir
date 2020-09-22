require "spec_helper"
require_relative "../../../lib/expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "build an instance from a file" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schemas = repo.schemas
      expect(schemas.count).to eq(1)

      schema = schemas.first
      expect(schema.id).to eq("Ap233_systems_engineering_arm_LF")
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "ap233", "ap233e1_arm_lf_stepmod-2010-11-12.exp"
    )
  end
end
