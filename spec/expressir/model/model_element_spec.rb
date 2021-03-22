
require "yaml"
require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/formatter"

RSpec.describe Expressir::Model::ModelElement do
  describe ".to_hash" do
    it "exports an object with a formatter (single.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "single.exp")
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "single_formatted.yaml")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, formatter: Expressir::ExpressExp::Formatter, skip_empty: true))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)
      
      expect(result).to eq(expected_result)
    end
  end

  describe ".from_hash" do
    it "parses an object (single.yaml)" do
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "single.yaml")

      input = YAML.load(File.read(yaml_file))
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, skip_empty: true))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses an object (multiple.yaml)" do
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.yaml")

      input = YAML.load(File.read(yaml_file))
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, skip_empty: true))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses an object (syntax.yaml)" do
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.yaml")

      input = YAML.load(File.read(yaml_file))
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, skip_empty: true))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end

    it "parses an object (remark.yaml)" do
      yaml_file = Expressir.root_path.join("original", "examples", "syntax", "remark.yaml")

      input = YAML.load(File.read(yaml_file))
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, skip_empty: true))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)
    end
  end

  describe ".find" do
    it "finds an object (single.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "single.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find('single_schema')).to be_instance_of(Expressir::Model::Schema)
      expect(repo.find('single_schema.empty_entity')).to be_instance_of(Expressir::Model::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find('empty_entity')).to be_instance_of(Expressir::Model::Entity)
    end

    it "finds an object (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find('multiple_schema')).to be_instance_of(Expressir::Model::Schema)
      expect(repo.find('multiple_schema.empty_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('multiple_schema.attribute_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('multiple_schema.attribute_entity2')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('multiple_schema.attribute_entity3')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('multiple_schema.attribute_entity4')).to be_instance_of(Expressir::Model::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find('empty_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('attribute_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('attribute_entity2')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('attribute_entity3')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('attribute_entity4')).to be_instance_of(Expressir::Model::Entity)
    end

    it "finds an object (syntax.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find('syntax_schema')).to be_instance_of(Expressir::Model::Schema)
      expect(repo.find('syntax_schema.empty_entity')).to be_instance_of(Expressir::Model::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find('empty_entity')).to be_instance_of(Expressir::Model::Entity)
    end

    it "finds an object (remark.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "remark.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find('remark_schema')).to be_instance_of(Expressir::Model::Schema)
      expect(repo.find('remark_schema.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(repo.find('remark_schema.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(repo.find('remark_schema.remark_type.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_type.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_type.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_type.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(repo.find('remark_schema.remark_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('remark_schema.remark_entity.remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.UR1')).to be_instance_of(Expressir::Model::Unique)
      expect(repo.find('remark_schema.remark_entity.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_entity.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_entity.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_entity.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_subtype_constraint')).to be_instance_of(Expressir::Model::SubtypeConstraint)
      expect(repo.find('remark_schema.remark_function')).to be_instance_of(Expressir::Model::Function)
      expect(repo.find('remark_schema.remark_function.remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(repo.find('remark_schema.remark_function.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(repo.find('remark_schema.remark_function.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(repo.find('remark_schema.remark_function.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(repo.find('remark_schema.remark_function.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(repo.find('remark_schema.remark_procedure')).to be_instance_of(Expressir::Model::Procedure)
      expect(repo.find('remark_schema.remark_procedure.remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(repo.find('remark_schema.remark_procedure.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(repo.find('remark_schema.remark_procedure.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(repo.find('remark_schema.remark_procedure.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(repo.find('remark_schema.remark_procedure.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(repo.find('remark_schema.remark_rule')).to be_instance_of(Expressir::Model::Rule)
      expect(repo.find('remark_schema.remark_rule.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(repo.find('remark_schema.remark_rule.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(repo.find('remark_schema.remark_rule.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(repo.find('remark_schema.remark_rule.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(repo.find('remark_schema.remark_rule.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_rule.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_rule.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_rule.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(repo.find('remark_schema.remark_item')).to be_instance_of(Expressir::Model::RemarkItem)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find('remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(schema.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(schema.find('remark_type.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_type.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_type.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_type.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(schema.find('remark_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('remark_entity.remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.UR1')).to be_instance_of(Expressir::Model::Unique)
      expect(schema.find('remark_entity.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_entity.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_entity.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_entity.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_subtype_constraint')).to be_instance_of(Expressir::Model::SubtypeConstraint)
      expect(schema.find('remark_function')).to be_instance_of(Expressir::Model::Function)
      expect(schema.find('remark_function.remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(schema.find('remark_function.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(schema.find('remark_function.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(schema.find('remark_function.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(schema.find('remark_function.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(schema.find('remark_procedure')).to be_instance_of(Expressir::Model::Procedure)
      expect(schema.find('remark_procedure.remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(schema.find('remark_procedure.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(schema.find('remark_procedure.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(schema.find('remark_procedure.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(schema.find('remark_procedure.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(schema.find('remark_rule')).to be_instance_of(Expressir::Model::Rule)
      expect(schema.find('remark_rule.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(schema.find('remark_rule.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(schema.find('remark_rule.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(schema.find('remark_rule.remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(schema.find('remark_rule.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_rule.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_rule.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_rule.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(schema.find('remark_item')).to be_instance_of(Expressir::Model::RemarkItem)

      # type scope
      type = schema.types.first
      expect(type.find('WR1')).to be_instance_of(Expressir::Model::Where)
      expect(type.find('wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(type.find('IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(type.find('ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)

      # entity scope
      entity = schema.entities.first
      expect(entity.find('remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('UR1')).to be_instance_of(Expressir::Model::Unique)
      expect(entity.find('WR1')).to be_instance_of(Expressir::Model::Where)
      expect(entity.find('wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(entity.find('IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(entity.find('ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)

      # function scope
      function = schema.functions.first
      expect(function.find('remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(function.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(function.find('remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(function.find('remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(function.find('remark_variable')).to be_instance_of(Expressir::Model::Variable)

      # procedure scope
      procedure = schema.procedures.first
      expect(procedure.find('remark_parameter')).to be_instance_of(Expressir::Model::Parameter)
      expect(procedure.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(procedure.find('remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(procedure.find('remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(procedure.find('remark_variable')).to be_instance_of(Expressir::Model::Variable)

      # rule scope
      rule = schema.rules.first
      expect(rule.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(rule.find('remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(rule.find('remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(rule.find('remark_variable')).to be_instance_of(Expressir::Model::Variable)
      expect(rule.find('WR1')).to be_instance_of(Expressir::Model::Where)
      expect(rule.find('wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(rule.find('IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(rule.find('ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)

      # retry search in parent scope
      expect(entity.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(entity.find('remark_type.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(entity.find('remark_type.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(entity.find('remark_type.IP1')).to be_instance_of(Expressir::Model::RemarkItem)
      expect(entity.find('remark_type.ip:IP1')).to be_instance_of(Expressir::Model::RemarkItem)
    end
  end
end
