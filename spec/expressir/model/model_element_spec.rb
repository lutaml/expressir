require "yaml"
require "spec_helper"
require "expressir/express/parser"
require "expressir/express/formatter"

RSpec.describe Expressir::Model::ModelElement do
  describe ".to_hash" do
    it "exports an object with a formatter (single.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "single.exp")
      yaml_file = Expressir.root_path.join("spec", "syntax", "single_formatted.yaml")

      repo = Expressir::Express::Parser.from_file(exp_file)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path, formatter: Expressir::Express::Formatter))
      # File.write(yaml_file, result)
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports objects filtered by select_proc (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      filtered_schemas = ["multiple_schema2", "multiple_schema3"]
      select_proc = Proc.new do |value|
        if value.is_a?(Expressir::Model::Declarations::Schema)
          filtered_schemas.include?(value.id)
        else
          true
        end
      end

      result = repo.to_hash(select_proc: select_proc)

      expect(result["schemas"].map { |s| s["id"] }.sort).to eq(filtered_schemas)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end
  end

  describe ".from_hash" do
    it "parses an object (single.yaml)" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "single.yaml")

      input = YAML.safe_load(File.read(yaml_file))
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "parses an object (multiple.yaml)" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "multiple.yaml")

      input = YAML.safe_load(File.read(yaml_file), permitted_classes: [Symbol]) # For UTF8 symbols
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "parses an object (syntax.yaml)" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "syntax.yaml")

      input = YAML.safe_load(File.read(yaml_file), permitted_classes: [Symbol]) # For UTF8 symbols
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)

      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "parses an object (remark.yaml)" do |example|
      print "\n[#{example.description}] "
      yaml_file = Expressir.root_path.join("spec", "syntax", "remark.yaml")

      input = YAML.safe_load(File.read(yaml_file), permitted_classes: [Symbol]) # For UTF8 symbols
      repo = Expressir::Model::ModelElement.from_hash(input, root_path: Expressir.root_path)

      result = YAML.dump(repo.to_hash(root_path: Expressir.root_path))
      expected_result = File.read(yaml_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end
  end

  describe ".find" do
    it "finds an object (single.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "single.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      # universal scope
      expect(repo.find("single_schema")).to be_instance_of(Expressir::Model::Declarations::Schema)
      expect(repo.find("single_schema.empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("empty_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
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

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
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

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
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
      expect(repo.find("remark_schema.remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(repo.find("remark_schema.remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(repo.find("remark_schema.remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(repo.find("remark_schema.remark_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(repo.find("remark_schema.remark_entity.remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(repo.find("remark_schema.remark_entity.remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(repo.find("remark_schema.remark_entity.remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(repo.find("remark_schema.remark_entity.UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(repo.find("remark_schema.remark_entity.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_entity.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(repo.find("remark_schema.remark_entity.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(repo.find("remark_schema.remark_entity.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
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
      expect(repo.find("remark_schema.remark_rule.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(repo.find("remark_schema.remark_rule.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(repo.find("remark_schema.remark_item")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # schema scope
      schema = repo.schemas.first
      expect(schema.find("remark_constant")).to be_instance_of(Expressir::Model::Declarations::Constant)
      expect(schema.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(schema.find("remark_type.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_type.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(schema.find("remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(schema.find("remark_enumeration_item")).to be_instance_of(Expressir::Model::DataTypes::EnumerationItem)
      expect(schema.find("remark_entity")).to be_instance_of(Expressir::Model::Declarations::Entity)
      expect(schema.find("remark_entity.remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(schema.find("remark_entity.remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(schema.find("remark_entity.remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(schema.find("remark_entity.UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(schema.find("remark_entity.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_entity.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(schema.find("remark_entity.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(schema.find("remark_entity.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
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
      expect(schema.find("remark_rule.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(schema.find("remark_rule.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(schema.find("remark_item")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # type scope
      type = schema.types.first
      expect(type.find("WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(type.find("wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(type.find("IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(type.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # entity scope
      entity = schema.entities.first
      expect(entity.find("remark_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(entity.find("remark_derived_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(entity.find("remark_inverse_attribute")).to be_instance_of(Expressir::Model::Declarations::Attribute)
      expect(entity.find("UR1")).to be_instance_of(Expressir::Model::Declarations::UniqueRule)
      expect(entity.find("WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(entity.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

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
      expect(rule.find("IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(rule.find("ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # retry search in parent scope
      expect(entity.find("remark_type")).to be_instance_of(Expressir::Model::Declarations::Type)
      expect(entity.find("remark_type.WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("remark_type.wr:WR1")).to be_instance_of(Expressir::Model::Declarations::WhereRule)
      expect(entity.find("remark_type.IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)
      expect(entity.find("remark_type.ip:IP1")).to be_instance_of(Expressir::Model::Declarations::RemarkItem)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end
  end

  describe ".to_liquid" do
    exp_file = Expressir.root_path.join("spec", "syntax", "test-generic.exp")
    repo = Expressir::Express::Parser.from_file(exp_file)
    repo_drop = repo.to_liquid
    result = []

    it "compares Expressir::Liquid with Expressir::Model" do
      loop_model_attrs(repo, repo_drop, result)

      result.each do |r|
        expect(r[:value]).to eq(r[:drop_value]),
          "Expecting #{r[:model]} model_attr: #{r[:attr]} " \
          "value: #{r[:value]} equals to #{r[:drop_model]} " \
          "model_attr: #{r[:attr]} value: #{r[:drop_value]}"
      end
    end
  end
end
