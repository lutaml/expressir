require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/formatter"

RSpec.describe Expressir::Model::ModelElement do
  describe ".from_hash" do
    it "parses an object from a hash" do
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
      expect(repo.schemas.first).to be_instance_of(Expressir::Model::Schema)
      expect(repo.schemas.first.id).to eq("simple_schema")
      expect(repo.schemas.first.entities).to be_instance_of(Array)
      expect(repo.schemas.first.entities.count).to eq(1)
      expect(repo.schemas.first.entities.first).to be_instance_of(Expressir::Model::Entity)
      expect(repo.schemas.first.entities.first.id).to eq("empty_entity")
    end
  end

  describe ".to_hash" do
    it "exports an object to a hash" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      result = repo.to_hash
      
      expect(result).to be_instance_of(Hash)
      expect(result["_class"]).to eq("Expressir::Model::Repository")
      expect(result["schemas"]).to be_instance_of(Array)
      expect(result["schemas"].count).to eq(1)
      expect(result["schemas"].first).to be_instance_of(Hash)
      expect(result["schemas"].first["_class"]).to eq("Expressir::Model::Schema")
      expect(result["schemas"].first["id"]).to eq("simple_schema")
      expect(result["schemas"].first["entities"]).to be_instance_of(Array)
      expect(result["schemas"].first["entities"].count).to eq(1)
      expect(result["schemas"].first["entities"].first).to be_instance_of(Hash)
      expect(result["schemas"].first["entities"].first["_class"]).to eq("Expressir::Model::Entity")
      expect(result["schemas"].first["entities"].first["id"]).to eq("empty_entity")
    end

    it "exports an object to a hash with a custom formatter" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      class CustomFormatter < Expressir::ExpressExp::Formatter
        def format_schema(node)
          "Oook."
        end
      end
      result = repo.to_hash({ formatter: CustomFormatter })

      expect(result).to be_instance_of(Hash)
      expect(result["_class"]).to eq("Expressir::Model::Repository")
      expect(result["schemas"]).to be_instance_of(Array)
      expect(result["schemas"].count).to eq(1)
      expect(result["schemas"].first["source"]).to eq("Oook.")
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "simple.exp"
    )
  end
end
