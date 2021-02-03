require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_files" do
    it "build an instance from multiple files file" do
      repo = Expressir::ExpressExp::Parser.from_files(sample_files)

      schemas = repo.schemas
      expect(schemas.count).to eq(5)
      expect(schemas[0].id).to eq("syntax_schema")
      expect(schemas[1].id).to eq("remark_schema")
      expect(schemas[2].id).to eq("entity_schema")
      expect(schemas[3].id).to eq("version_entity_schema")
      expect(schemas[4].id).to eq("version_interface_entity_schema")
    end
  end

  def sample_files
    @sample_files ||= [
      Expressir.root_path.join(
        "original", "examples", "syntax", "syntax.exp"
      ),
      Expressir.root_path.join(
        "original", "examples", "syntax", "remark.exp"
      ),
      Expressir.root_path.join(
        "original", "examples", "syntax", "source.exp"
      )
    ]
  end
end
