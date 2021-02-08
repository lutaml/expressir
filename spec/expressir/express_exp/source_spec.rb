require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".source" do
    it "contains original source" do
      input = File.read(sample_file)
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schema = repo.schemas.first
      start_index = input.index("SCHEMA")
      stop_index = input.index("END_SCHEMA;") + "END_SCHEMA;".length - 1
      expected_result = input[start_index..stop_index]
      expect(schema.source).to eq(expected_result)

      entity = schema.entities.first
      start_index = input.index("ENTITY")
      stop_index = input.index("END_ENTITY;") + "END_ENTITY;".length - 1
      expected_result = input[start_index..stop_index]
      expect(entity.source).to eq(expected_result)
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "source.exp"
    )
  end
end
