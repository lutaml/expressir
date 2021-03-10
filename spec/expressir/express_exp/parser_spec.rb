require "yaml"
require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "parses a file (single.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "single.exp")
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "single.yaml")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(skip_empty: true))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      
      expect(result).to eq(expected_result)
    end

    it "parses a file (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.yaml")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(skip_empty: true))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      
      expect(result).to eq(expected_result)
    end

    it "parses a file (syntax.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.exp")
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.yaml")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(skip_empty: true))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      
      expect(result).to eq(expected_result)
    end

    it "parses a file (remark.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "remark.exp")
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "remark.yaml")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(skip_empty: true))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      
      expect(result).to eq(expected_result)
    end

    it "parses a file including original source (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")

      input = File.read(exp_file)
      repo = Expressir::ExpressExp::Parser.from_file(exp_file, include_source: true)

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

  describe ".from_files" do
    it "parses multiple files (single.exp, multiple.exp)" do
      exp_files = [
        Expressir.root_path.join("original", "examples", "syntax", "single.exp"),
        Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      ]

      repo = Expressir::ExpressExp::Parser.from_files(exp_files)

      schemas = repo.schemas
      expect(schemas.count).to eq(5)
      expect(schemas[0].file).to eq(exp_files[0].basename.to_s)
      expect(schemas[0].id).to eq("single_schema")
      expect(schemas[1].file).to eq(exp_files[1].basename.to_s)
      expect(schemas[1].id).to eq("multiple_schema1")
      expect(schemas[2].file).to eq(exp_files[1].basename.to_s)
      expect(schemas[2].id).to eq("multiple_schema2")
      expect(schemas[3].file).to eq(exp_files[1].basename.to_s)
      expect(schemas[3].id).to eq("multiple_schema3")
      expect(schemas[4].file).to eq(exp_files[1].basename.to_s)
      expect(schemas[4].id).to eq("multiple_schema4")
    end

    it "parses multiple files with a root path (single.exp, multiple.exp)" do
      exp_files = [
        Expressir.root_path.join("original", "examples", "syntax", "single.exp"),
        Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      ]
      root_path = Expressir.root_path

      repo = Expressir::ExpressExp::Parser.from_files(exp_files, root_path: root_path)

      schemas = repo.schemas
      expect(schemas.count).to eq(5)
      expect(schemas[0].file).to eq(exp_files[0].relative_path_from(root_path).to_s)
      expect(schemas[0].id).to eq("single_schema")
      expect(schemas[1].file).to eq(exp_files[1].relative_path_from(root_path).to_s)
      expect(schemas[1].id).to eq("multiple_schema1")
      expect(schemas[2].file).to eq(exp_files[1].relative_path_from(root_path).to_s)
      expect(schemas[2].id).to eq("multiple_schema2")
      expect(schemas[3].file).to eq(exp_files[1].relative_path_from(root_path).to_s)
      expect(schemas[3].id).to eq("multiple_schema3")
      expect(schemas[4].file).to eq(exp_files[1].relative_path_from(root_path).to_s)
      expect(schemas[4].id).to eq("multiple_schema4")
    end
  end
end
