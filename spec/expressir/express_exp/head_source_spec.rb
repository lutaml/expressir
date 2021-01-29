require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::Model::Scope do
  describe ".head_source" do
    it "contains original head source" do
      input = File.read(sample_file)
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      expected_result = input
      expect(repo.source).to eq(expected_result)

      repo.schemas[0].tap do |x|
        start_index = x.source.index("SCHEMA")
        stop_index = x.source.index(";") + ";".length - 1
        expected_result = x.source[start_index..stop_index]
        expect(x.head_source).to eq(expected_result)
      end

      repo.schemas[1].tap do |x|
        start_index = x.source.index("SCHEMA")
        stop_index = x.source.index(";") + ";".length - 1
        expected_result = x.source[start_index..stop_index]
        expect(x.head_source).to eq(expected_result)
      end

      repo.schemas[2].tap do |x|
        start_index = x.source.index("SCHEMA")
        stop_index = x.source.index("REFERENCE FROM contract_schema;") + "REFERENCE FROM contract_schema;".length - 1
        expected_result = x.source[start_index..stop_index]
        expect(x.head_source).to eq(expected_result)
      end
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "source.exp"
    )
  end
end
