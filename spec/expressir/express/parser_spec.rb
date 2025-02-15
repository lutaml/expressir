require "spec_helper"
require_relative "../../../lib/expressir/express/parser"

RSpec.describe Expressir::Express::Parser do
  describe ".from_file" do
    it "throws an exception if the file to parse does not exist" do |example|
      print "\n[#{example.description}] "
      expect do
        Expressir::Express::Parser.from_file("non-existing-file")
      end.to raise_error(Errno::ENOENT)
    end

    it "parses a file (single.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "single.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "single.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "multiple.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (mathematical_functions_schema.exp) with remark_items" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "mathematical_functions_schema.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "mathematical_functions_schema.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)
      result = repo.to_hash(root_path: Expressir.root_path)
      # File.write(yaml_file, result)
      expected_result = YAML.load(File.read(yaml_file)) # rubocop:disable Security/YAMLLoad

      # compare the result by hash as the yaml output varies with ruby version
      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "parses a file (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "syntax.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (remark.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "remark.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "remark.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)
      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file including original source (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")

      input = File.read(exp_file)
      repo = Expressir::Express::Parser.from_file(exp_file, include_source: true)

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
    it "parses multiple files (single.exp, multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_files = [
        Expressir.root_path.join("spec", "syntax", "single.exp"),
        Expressir.root_path.join("spec", "syntax", "multiple.exp"),
      ]

      repo = Expressir::Express::Parser.from_files(exp_files)

      schemas = repo.schemas
      expect(schemas.count).to eq(5)
      expect(schemas[0].file).to eq(exp_files[0].to_s)
      expect(schemas[0].id).to eq("single_schema")
      expect(schemas[1].file).to eq(exp_files[1].to_s)
      expect(schemas[1].id).to eq("multiple_schema")
      expect(schemas[2].file).to eq(exp_files[1].to_s)
      expect(schemas[2].id).to eq("multiple_schema2")
      expect(schemas[3].file).to eq(exp_files[1].to_s)
      expect(schemas[3].id).to eq("multiple_schema3")
      expect(schemas[4].file).to eq(exp_files[1].to_s)
      expect(schemas[4].id).to eq("multiple_schema4")
    end
  end
end
