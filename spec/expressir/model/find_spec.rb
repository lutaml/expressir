require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::Model do
  describe ".find" do
    it "finds an object" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      # universal scope
      expect(repo.find('remark_schema')).to be_instance_of(Expressir::Model::Schema)
      expect(repo.find('remark_schema.remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(repo.find('remark_schema.remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(repo.find('remark_schema.remark_type.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_type.wr:WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(repo.find('remark_schema.remark_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(repo.find('remark_schema.remark_entity.remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(repo.find('remark_schema.remark_entity.remark_unique')).to be_instance_of(Expressir::Model::Unique)
      expect(repo.find('remark_schema.remark_entity.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(repo.find('remark_schema.remark_entity.wr:WR1')).to be_instance_of(Expressir::Model::Where)
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

      # schema scope
      schema = repo.schemas.first
      expect(schema.find('remark_constant')).to be_instance_of(Expressir::Model::Constant)
      expect(schema.find('remark_type')).to be_instance_of(Expressir::Model::Type)
      expect(schema.find('remark_enumeration_item')).to be_instance_of(Expressir::Model::EnumerationItem)
      expect(schema.find('remark_entity')).to be_instance_of(Expressir::Model::Entity)
      expect(schema.find('remark_entity.remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(schema.find('remark_entity.remark_unique')).to be_instance_of(Expressir::Model::Unique)
      expect(schema.find('remark_entity.WR1')).to be_instance_of(Expressir::Model::Where)
      expect(schema.find('remark_entity.wr:WR1')).to be_instance_of(Expressir::Model::Where)
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

      # type scope
      type = schema.types.first
      expect(type.find('WR1')).to be_instance_of(Expressir::Model::Where)
      expect(type.find('wr:WR1')).to be_instance_of(Expressir::Model::Where)

      # entity scope
      entity = schema.entities.first
      expect(entity.find('remark_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('remark_derived_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('remark_inverse_attribute')).to be_instance_of(Expressir::Model::Attribute)
      expect(entity.find('remark_unique')).to be_instance_of(Expressir::Model::Unique)
      expect(entity.find('WR1')).to be_instance_of(Expressir::Model::Where)
      expect(entity.find('wr:WR1')).to be_instance_of(Expressir::Model::Where)

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
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "remark.exp"
    )
  end
end
