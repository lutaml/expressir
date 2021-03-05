require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/formatter"
require "expressir/express_exp/schema_head_formatter"

RSpec.describe Expressir::ExpressExp::SchemaHeadFormatter do
  describe ".format" do
    it "formats schema head" do
      repo = Expressir::ExpressExp::Parser.from_file(sample_file)

      class CustomFormatter < Expressir::ExpressExp::Formatter
        include Expressir::ExpressExp::SchemaHeadFormatter
      end
      result = CustomFormatter.format(repo)

      expect(result).to eq(<<~EXP.strip
        SCHEMA syntax_schema 'version';
        USE FROM contract_schema;
        USE FROM contract_schema
          (contract);
        USE FROM contract_schema
          (contract, contract2);
        USE FROM contract_schema
          (contract AS contract2);
        REFERENCE FROM contract_schema;
        REFERENCE FROM contract_schema
          (contract);
        REFERENCE FROM contract_schema
          (contract, contract2);
        REFERENCE FROM contract_schema
          (contract AS contract2);
      EXP
      )
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join("original", "examples", "syntax", "syntax.exp")
  end
end
