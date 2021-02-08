require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::Model::ModelElement do
  describe ".from_hash" do
    it "parses an object from hash" do
      input = {
        "_class" => "Expressir::Model::Repository",
        "schemas" => [{
          "_class" => "Expressir::Model::Schema",
          "id" => "simple_schema",
          "entities" => [{
            "_class" => "Expressir::Model::Entity",
            "id" => "empty_entity"
          }]
        }]
      }

      repo = Expressir::Model::ModelElement.from_hash(input)

      expect(repo).to be_instance_of(Expressir::Model::Repository)
      expect(repo.schemas).to be_instance_of(Array)
      expect(repo.schemas.count).to eq(1)
      expect(repo.schemas[0]).to be_instance_of(Expressir::Model::Schema)
      expect(repo.schemas[0].id).to eq("simple_schema")
      expect(repo.schemas[0].entities).to be_instance_of(Array)
      expect(repo.schemas[0].entities.count).to eq(1)
      expect(repo.schemas[0].entities[0]).to be_instance_of(Expressir::Model::Entity)
      expect(repo.schemas[0].entities[0].id).to eq("empty_entity")
    end
  end

  describe ".to_hash" do
    it "exports an object to hash" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      result = repo.to_hash
      
      expect(result).to be_instance_of(Hash)
      expect(result["_class"]).to eq("Expressir::Model::Repository")
      expect(result["schemas"]).to be_instance_of(Array)
      expect(result["schemas"].count).to eq(1)
      expect(result["schemas"][0]).to be_instance_of(Hash)
      expect(result["schemas"][0]["_class"]).to eq("Expressir::Model::Schema")
      expect(result["schemas"][0]["id"]).to eq("simple_schema")
      expect(result["schemas"][0]["entities"]).to be_instance_of(Array)
      expect(result["schemas"][0]["entities"].count).to eq(1)
      expect(result["schemas"][0]["entities"][0]).to be_instance_of(Hash)
      expect(result["schemas"][0]["entities"][0]["_class"]).to eq("Expressir::Model::Entity")
      expect(result["schemas"][0]["entities"][0]["id"]).to eq("empty_entity")
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "simple.exp"
    )
  end
end
