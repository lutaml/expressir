require "spec_helper"
require_relative "../../../lib/expressir/express/parser"
require_relative "../../../lib/expressir/express/formatter"
require_relative "../../../lib/expressir/express/cache"

RSpec.describe Expressir::Model::ModelElement do
  describe ".from_yaml/.to_yaml round trip" do
    it "round-trips single schema YAML correctly" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "single.yaml")
      expected_result = File.read(yaml_file)
      result = Expressir::Model::Repository.from_yaml(File.read(yaml_file))
      expect(result.to_yaml).to be_yaml_equivalent(expected_result)
    end

    it "round-trips multiple schema YAML correctly" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "multiple.yaml")
      expected_result = File.read(yaml_file)
      result = Expressir::Model::Repository.from_yaml(File.read(yaml_file))
      expect(result.to_yaml).to be_yaml_equivalent(expected_result)
    end

    it "round-trips syntax schema YAML correctly" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "syntax.yaml")
      expected_result = File.read(yaml_file)
      result = Expressir::Model::Repository.from_yaml(File.read(yaml_file))
      expect(result.to_yaml).to be_yaml_equivalent(expected_result)
    end

    it "round-trips remark schema YAML correctly" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "remark.yaml")
      expected_result = File.read(yaml_file)
      result = Expressir::Model::Repository.from_yaml(File.read(yaml_file))
      expect(result.to_yaml).to be_yaml_equivalent(expected_result)
    end
  end

  describe ".find" do
    it "finds an object (single.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "single.exp")

      repo = Expressir::Express::Parser.from_file(exp_file,
                                                  root_path: Expressir.root_path)

      # universal scope
      expect(repo.find("single_schema")).to be_instance_of(Expressir::Model::Declarations::Schema)
      expect(repo.find("single_schema.empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # check schema file
      expect(schema.file).to eq("spec/syntax/single.exp")

      # check schema formatted
      formatted_text = <<~TEXT
        SCHEMA single_schema 'version';

        ENTITY empty_entity;
        END_ENTITY;

        ENTITY subtype_empty_entity
          SUBTYPE OF (empty_entity);
        END_ENTITY;

        END_SCHEMA;
      TEXT

      expect(schema.formatted).to eq(formatted_text.strip)
      expect(schema.full_source).to eq(formatted_text.strip)

      # check children
      first_child = schema.children.first
      formatted_child_text = <<~TEXT
        ENTITY empty_entity;
        END_ENTITY;
      TEXT

      expect(first_child.source).to eq(formatted_child_text.strip)
    end

    it "finds an object (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find("multiple_schema")).to be_instance_of(Expressir::Model::Declarations::Schema)
      expect(repo.find("multiple_schema.empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("multiple_schema.attribute_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("multiple_schema.attribute_entity2")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("multiple_schema.attribute_entity3")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("multiple_schema.attribute_entity4")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("attribute_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("attribute_entity2")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("attribute_entity3")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("attribute_entity4")).to be_instance_of(Expressir::Model::Declarations::Entity)
    end

    it "finds an object (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find("syntax_schema")).to be_instance_of(Expressir::Model::Declarations::Schema)
      expect(repo.find("syntax_schema.empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      formatted_schema_head = <<~TEXT
        SCHEMA syntax_schema '{ISO standard 10303 part(41) object(1) version(8)}';

        USE FROM contract_schema;
        USE FROM contract_schema
          (contract);
        USE FROM contract_schema
          (contract,
           contract2);
        USE FROM contract_schema
          (contract AS contract2);
        REFERENCE FROM contract_schema;
        REFERENCE FROM contract_schema
          (contract);
        REFERENCE FROM contract_schema
          (contract,
           contract2);
        REFERENCE FROM contract_schema
          (contract AS contract2);
      TEXT
      expect(schema.source).to eq(formatted_schema_head.strip)
    end

    it "finds an object (remark.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "remark.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find("remark_schema")).to be_instance_of(Expressir::Model::Declarations::Schema)
      expect(repo.find("remark_schema.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(repo.find("remark_schema.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(repo.find("remark_schema.remark_type.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_type.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(repo.find("remark_schema.remark_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("remark_schema.remark_entity.remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(repo.find("remark_schema.remark_entity.remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::DerivedAttribute)
      expect(repo.find("remark_schema.remark_entity.remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::InverseAttribute)
      expect(repo.find("remark_schema.remark_entity.UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(repo.find("remark_schema.remark_entity.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_entity.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_entity.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_entity.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_subtype_constraint")).to be_instance_of(Expressir::Model::Declarations::SubtypeConstraint)
      expect(repo.find("remark_schema.remark_function")).to be_instance_of(Expressir::Model::Declarations::Function)
      expect(repo.find("remark_schema.remark_function.remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(repo.find("remark_schema.remark_function.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(repo.find("remark_schema.remark_function.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(repo.find("remark_schema.remark_function.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(repo.find("remark_schema.remark_function.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(repo.find("remark_schema.remark_procedure")).to be_instance_of(Expressir::Model::Declarations::Procedure)
      expect(repo.find("remark_schema.remark_procedure.remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(repo.find("remark_schema.remark_procedure.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(repo.find("remark_schema.remark_procedure.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(repo.find("remark_schema.remark_procedure.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(repo.find("remark_schema.remark_procedure.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(repo.find("remark_schema.remark_rule")).to be_instance_of(Expressir::Model::Declarations::Rule)
      expect(repo.find("remark_schema.remark_rule.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(repo.find("remark_schema.remark_rule.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(repo.find("remark_schema.remark_rule.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(repo.find("remark_schema.remark_rule.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(repo.find("remark_schema.remark_rule.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_rule.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_rule.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_rule.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(repo.find("remark_schema.remark_item")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(schema.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(schema.find("remark_type.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_type.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(schema.find("remark_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("remark_entity.remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(schema.find("remark_entity.remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::DerivedAttribute)
      expect(schema.find("remark_entity.remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::InverseAttribute)
      expect(schema.find("remark_entity.UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(schema.find("remark_entity.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_entity.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_entity.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_entity.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_subtype_constraint")).to be_instance_of(Expressir::Model::Declarations::SubtypeConstraint)
      expect(schema.find("remark_function")).to be_instance_of(Expressir::Model::Declarations::Function)
      expect(schema.find("remark_function.remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(schema.find("remark_function.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(schema.find("remark_function.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(schema.find("remark_function.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(schema.find("remark_function.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(schema.find("remark_procedure")).to be_instance_of(Expressir::Model::Declarations::Procedure)
      expect(schema.find("remark_procedure.remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(schema.find("remark_procedure.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(schema.find("remark_procedure.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(schema.find("remark_procedure.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(schema.find("remark_procedure.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(schema.find("remark_rule")).to be_instance_of(Expressir::Model::Declarations::Rule)
      expect(schema.find("remark_rule.remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(schema.find("remark_rule.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(schema.find("remark_rule.remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(schema.find("remark_rule.remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(schema.find("remark_rule.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_rule.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_rule.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_rule.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(schema.find("remark_item")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # type scope
      type = schema.types.first
      expect(type.find("WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(type.find("wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(type.find("IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(type.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)

      # entity scope
      entity = schema.entities.first
      expect(entity.find("remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(entity.find("remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::DerivedAttribute)
      expect(entity.find("remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::InverseAttribute)
      expect(entity.find("UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(entity.find("WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(entity.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)

      # function scope
      function = schema.functions.first
      expect(function.find("remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(function.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(function.find("remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(function.find("remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(function.find("remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)

      # procedure scope
      procedure = schema.procedures.first
      expect(procedure.find("remark_parameter")).to be_instance_of(Expressir::Model::Declarations::Parameter)
      expect(procedure.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(procedure.find("remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(procedure.find("remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(procedure.find("remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)

      # rule scope
      rule = schema.rules.first
      expect(rule.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(rule.find("remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(rule.find("remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(rule.find("remark_variable")).to be_instance_of(Expressir::Model::Declarations::Variable)
      expect(rule.find("WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(rule.find("wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(rule.find("IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(rule.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)

      # retry search in parent scope
      expect(entity.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(entity.find("remark_type.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("remark_type.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
      expect(entity.find("remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::InformalPropositionRule)
    end
  end

  describe ".to_liquid" do
    exp_file = Expressir.root_path.join("spec", "syntax", "test-generic.exp")
    repo = Expressir::Express::Parser.from_file(exp_file)
    repo_drop = repo.to_liquid
    result = []

    it "compares Expressir::Liquid with Expressir::Model" do
      check_nested_model_to_liquid(repo, repo_drop, result)

      result.each do |r|
        expect(r[:value]).to eq(r[:drop_value]),
                             "Expecting #{r[:model]} model_attr: #{r[:attr]} " \
                             "value: #{r[:value]} equals to " \
                             "#{r[:drop_model]} model_attr: #{r[:attr]} " \
                             "value: #{r[:drop_value]}"
      end
    end
  end
end
