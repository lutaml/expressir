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
      yaml_file = Expressir.root_path.join("spec", "syntax", "single_parser.yaml")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      expect(result).to eq(expected_result)
    end

    it "parses a file (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "multiple_parser.yaml")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (mathematical_functions_schema.exp) with remark_items" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join(
        "spec", "syntax", "mathematical_functions_schema",
        "mathematical_functions_schema.exp"
      )
      yaml_file = Expressir.root_path.join(
        "spec", "syntax", "mathematical_functions_schema",
        "mathematical_functions_schema.yaml"
      )

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      expect(result).to eq(expected_result)
    end

    it "parses a file (structural_response_definition_schema.exp) with remark_items" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join(
        "spec", "syntax",
        "structural_response_definition_schema",
        "structural_response_definition_schema.exp"
      )
      yaml_file = Expressir.root_path.join(
        "spec", "syntax",
        "structural_response_definition_schema",
        "structural_response_definition_schema.yaml"
      )

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "syntax_parser.yaml")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file (remark.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "remark.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "remark_parser.yaml")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses a file including original source (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")

      repo = Expressir::Express::Parser.from_file(exp_file, include_source: true)

      schema = repo.schemas.first
      expected_result = <<~TEXT
        SCHEMA multiple_schema;

        REFERENCE FROM multiple_schema2;
        REFERENCE FROM multiple_schema3
          (attribute_entity3);
        REFERENCE FROM multiple_schema4
          (attribute_entity AS attribute_entity4);

        ENTITY test;
        END_ENTITY;

        ENTITY empty_entity;
        END_ENTITY;

        ENTITY attribute_entity;
          test : BOOLEAN;
        END_ENTITY;

        ENTITY subtype_empty_entity
          SUBTYPE OF (empty_entity);
        END_ENTITY;

        ENTITY subtype_attribute_entity
          SUBTYPE OF (attribute_entity);
          SELF\\attribute_entity.test : BOOLEAN;
        END_ENTITY;

        ENTITY subtype_attribute_entity2
          SUBTYPE OF (attribute_entity2);
          SELF\\attribute_entity2.test : BOOLEAN;
        END_ENTITY;

        ENTITY subtype_attribute_entity3
          SUBTYPE OF (attribute_entity3);
          SELF\\attribute_entity3.test : BOOLEAN;
        END_ENTITY;

        ENTITY subtype_attribute_entity4
          SUBTYPE OF (attribute_entity4);
          SELF\\attribute_entity4.test : BOOLEAN;
        END_ENTITY;

        ENTITY subtype_missing_entity
          SUBTYPE OF (missing_entity);
        END_ENTITY;

        END_SCHEMA;
      TEXT
      expect(schema.full_source).to eq(expected_result.strip)

      entity = schema.entities.first
      expected_entity = <<~TEXT
        ENTITY test;
        END_ENTITY;
      TEXT
      expect(entity.source).to eq(expected_entity.strip)
    end

    it "parses a file (without_ending_newline.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "without_ending_newline.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "without_ending_newline.yaml")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )
      result = repo.to_yaml

      expected_result = File.read(yaml_file)
      expect(result).to eq(expected_result)
    end

    it "parses a file and assigns derived attributes (derived_attribute.exp)" do |_example|
      exp_file = Expressir.root_path.join("spec", "syntax", "derived_attribute.exp")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )

      entity = repo.schemas.first.entities[2]
      expect(entity.attributes.map(&:id)).to include("coordinates")
      attribute = entity.attributes[3]
      expect(attribute.remarks).to eq(["the rectangular cartesian coordinates of this point;"])
      expect(attribute.remark_items.map(&:remarks)).to eq(
        [["[[figure-geometry_schema-Geomfig2]]\n.Spherical point attributes\n====\nimage::Geomfig2.gif[]\n===="]],
      )
    end

    it "parses a file and assigns derived attributes (derived_attribute_deep.exp)" do |_example|
      exp_file = Expressir.root_path.join("spec", "syntax", "derived_attribute_deep.exp")

      repo = Expressir::Express::Parser.from_file(
        exp_file,
        root_path: Expressir.root_path,
      )

      entity = repo.schemas.first.entities[4]
      expect(entity.attributes.map(&:id)).to include("country_population")
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
