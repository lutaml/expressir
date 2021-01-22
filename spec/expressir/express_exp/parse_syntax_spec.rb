require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "build an instance from a file" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schemas = repo.schemas

      schema = schemas.find{|x| x.id == "syntax_schema"}
      expect(schema.version).to be_instance_of(Expressir::Model::Literals::String)
      expect(schema.version.value).to eq("version")

      use_interfaces = schema.use_interfaces
      reference_interfaces = schema.reference_interfaces
      constants = schema.constants
      types = schema.types
      entities = schema.entities
      subtype_constraints = schema.subtype_constraints
      functions = schema.functions
      procedures = schema.procedures
      rules = schema.rules

      # intefaces
      use_interfaces[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
      end

      use_interfaces[1].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("contract")
      end

      use_interfaces[2].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].ref.id).to eq("contract")
        expect(x.items[0].id).to eq("contract2")
      end

      reference_interfaces[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
      end

      reference_interfaces[1].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("contract")
      end

      reference_interfaces[2].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
        expect(x.schema).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.schema.id).to eq("contract_schema")
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].ref.id).to eq("contract")
        expect(x.items[0].id).to eq("contract2")
      end

      # constants
      constants.find{|x| x.id == "empty_constant"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # types
      types.find{|x| x.id == "empty_type"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      types.find{|x| x.id == "where_type"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      types.find{|x| x.id == "where_label_type"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # entities
      entities.find{|x| x.id == "empty_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
      end

      entities.find{|x| x.id == "abstract_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract).to eq(true)
      end

      entities.find{|x| x.id == "abstract_supertype_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract).to eq(true)
      end

      entities.find{|x| x.id == "abstract_supertype_constraint_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract).to eq(true)
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.id).to eq("empty_entity")
      end

      entities.find{|x| x.id == "supertype_constraint_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.id).to eq("empty_entity")
      end

      entities.find{|x| x.id == "subtype_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.subtype_of).to be_instance_of(Array)
        expect(x.subtype_of.count).to eq(1)
        expect(x.subtype_of[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_of[0].id).to eq("empty_entity")
      end

      entities.find{|x| x.id == "supertype_constraint_subtype_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.id).to eq("empty_entity")
        expect(x.subtype_of).to be_instance_of(Array)
        expect(x.subtype_of.count).to eq(1)
        expect(x.subtype_of[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_of[0].id).to eq("empty_entity")
      end

      entities.find{|x| x.id == "attribute_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "attribute_optional_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].optional).to eq(true)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "attribute_multiple_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(2)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.attributes[1]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[1].id).to eq("test2")
        expect(x.attributes[1].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "attribute_multiple_shorthand_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(2)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.attributes[1]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[1].id).to eq("test2")
        expect(x.attributes[1].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "attribute_redeclared_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "attribute_redeclared_renamed_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test2")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "derived_attribute_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::DERIVED)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.attributes[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "derived_attribute_redeclared_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::DERIVED)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.attributes[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "derived_attribute_redeclared_renamed_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test2")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::DERIVED)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.attributes[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "inverse_attribute_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_entity_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.ref.id).to eq("attribute_entity")
        expect(x.attributes[0].expression.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_set_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.attributes[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.base_type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_set_bound_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.attributes[0].type.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.attributes[0].type.bound1.value).to eq("1")
        expect(x.attributes[0].type.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.attributes[0].type.bound2.value).to eq("9")
        expect(x.attributes[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.base_type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_bag_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.attributes[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.base_type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_bag_bound_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.attributes[0].type.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.attributes[0].type.bound1.value).to eq("1")
        expect(x.attributes[0].type.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.attributes[0].type.bound2.value).to eq("9")
        expect(x.attributes[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.base_type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_redeclared_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "inverse_attribute_redeclared_renamed_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test2")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.attributes[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.attributes[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.attributes[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.attributes[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.ref.entity.id).to eq("attribute_entity")
        expect(x.attributes[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].type.id).to eq("attribute_entity")
        expect(x.attributes[0].expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attributes[0].expression.id).to eq("test")
      end

      entities.find{|x| x.id == "unique_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "unique_label_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.attributes).to be_instance_of(Array)
        expect(x.attributes.count).to eq(1)
        expect(x.attributes[0]).to be_instance_of(Expressir::Model::Attribute)
        expect(x.attributes[0].id).to eq("test")
        expect(x.attributes[0].kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.attributes[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "unique_qualified_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.unique[0].attributes[0].ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.entity.id).to eq("attribute_entity")
        expect(x.unique[0].attributes[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "unique_label_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "unique_label_qualified_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.unique[0].attributes[0].ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.entity.id).to eq("attribute_entity")
        expect(x.unique[0].attributes[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "where_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "where_label_entity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # subtype constraints
      subtype_constraints.find{|x| x.id == "empty_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
      end

      subtype_constraints.find{|x| x.id == "abstract_supertype_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.abstract).to eq(true)
      end

      subtype_constraints.find{|x| x.id == "total_over_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.total_over).to be_instance_of(Array)
        expect(x.total_over.count).to eq(1)
        expect(x.total_over[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.total_over[0].id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_andor_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_and_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_andor_and_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand2.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.operand1.id).to eq("b")
        expect(x.supertype_expression.operand2.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_and_andor_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.operand1.id).to eq("a")
        expect(x.supertype_expression.operand1.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.operand2.id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_parenthesis_andor_and_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.operand1.id).to eq("a")
        expect(x.supertype_expression.operand1.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.operand2.id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_and_parenthesis_andor_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand2.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.operand1.id).to eq("b")
        expect(x.supertype_expression.operand2.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_oneof_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.parameters.count).to eq(2)
        expect(x.supertype_expression.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.parameters[0].id).to eq("a")
        expect(x.supertype_expression.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.parameters[1].id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_and_oneof_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand2.parameters.count).to eq(2)
        expect(x.supertype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[0].id).to eq("b")
        expect(x.supertype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_andor_oneof_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.id).to eq("a")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand2.parameters.count).to eq(2)
        expect(x.supertype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[0].id).to eq("b")
        expect(x.supertype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_oneof_and_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand1.parameters.count).to eq(2)
        expect(x.supertype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.supertype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_oneof_andor_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand1.parameters.count).to eq(2)
        expect(x.supertype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.supertype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_oneof_and_oneof_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand1.parameters.count).to eq(2)
        expect(x.supertype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.supertype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand2.parameters.count).to eq(2)
        expect(x.supertype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[0].id).to eq("c")
        expect(x.supertype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[1].id).to eq("d")
      end

      subtype_constraints.find{|x| x.id == "supertype_expression_oneof_andor_oneof_subtype_constraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("empty_entity")
        expect(x.supertype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.supertype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.supertype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand1.parameters.count).to eq(2)
        expect(x.supertype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.supertype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.supertype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.supertype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.supertype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.supertype_expression.operand2.parameters.count).to eq(2)
        expect(x.supertype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[0].id).to eq("c")
        expect(x.supertype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertype_expression.operand2.parameters[1].id).to eq("d")
      end

      # functions
      functions.find{|x| x.id == "empty_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "parameter_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_parameter_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_shorthand_parameter_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "type_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("test")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "constant_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_constant_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "variable_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_variable_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_shorthand_variable_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "variable_expression_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_variable_expression_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multiple_shorthand_variable_expression_function"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      # procedures
      procedures.find{|x| x.id == "empty_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
      end

      procedures.find{|x| x.id == "parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_shorthand_parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "variable_parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_variable_parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_variable_parameter2_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].var).to eq(true)
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_shorthand_variable_parameter_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].var).to eq(true)
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "type_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("test")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "constant_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      procedures.find{|x| x.id == "multiple_constant_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      procedures.find{|x| x.id == "variable_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_variable_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multiple_shorthand_variable_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "variable_expression_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      procedures.find{|x| x.id == "multiple_variable_expression_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      procedures.find{|x| x.id == "multiple_shorthand_variable_expression_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      procedures.find{|x| x.id == "statement_procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      # rules
      rules.find{|x| x.id == "empty_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "type_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("test")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "constant_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multiple_constant_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.constants[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "variable_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multiple_variable_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multiple_shorthand_variable_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "variable_expression_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(1)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multiple_variable_expression_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multiple_shorthand_variable_expression_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.variables).to be_instance_of(Array)
        expect(x.variables.count).to eq(2)
        expect(x.variables[0]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[0].id).to eq("test")
        expect(x.variables[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.variables[1]).to be_instance_of(Expressir::Model::Variable)
        expect(x.variables[1].id).to eq("test2")
        expect(x.variables[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.variables[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.variables[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "statement_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "where_label_rule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("empty_entity")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # simple types
      types.find{|x| x.id == "binary_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
      end

      types.find{|x| x.id == "binary_width_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
      end

      types.find{|x| x.id == "binary_width_fixed_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
        expect(x.fixed).to eq(true)
      end

      types.find{|x| x.id == "boolean_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      types.find{|x| x.id == "integer_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Integer)
      end

      types.find{|x| x.id == "logical_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Logical)
      end

      types.find{|x| x.id == "number_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Number)
      end

      types.find{|x| x.id == "real_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Real)
      end

      types.find{|x| x.id == "real_precision_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Real)
        expect(x.precision).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.precision.value).to eq("3")
      end

      types.find{|x| x.id == "string_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "string_width_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
      end

      types.find{|x| x.id == "string_width_fixed_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
        expect(x.fixed).to eq(true)
      end

      # aggregation types
      types.find{|x| x.id == "array_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "array_optional_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.optional).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "array_unique_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "array_optional_unique_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.optional).to eq(true)
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "bag_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "bag_bound_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "list_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "list_bound_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "list_unique_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "list_bound_unique_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "set_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "set_bound_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      # constructed types
      types.find{|x| x.id == "select_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
      end

      types.find{|x| x.id == "select_extensible_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extensible).to eq(true)
      end

      types.find{|x| x.id == "select_extensible_generic_entity_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extensible).to eq(true)
        expect(x.generic_entity).to eq(true)
      end

      types.find{|x| x.id == "select_list_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("empty_type")
      end

      types.find{|x| x.id == "select_extension_type_ref_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("select_type")
      end

      types.find{|x| x.id == "select_extension_type_ref_list_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("select_type")
        expect(x.extension_items).to be_instance_of(Array)
        expect(x.extension_items.count).to eq(1)
        expect(x.extension_items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_items[0].id).to eq("empty_type")
      end

      types.find{|x| x.id == "enumeration_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
      end

      types.find{|x| x.id == "enumeration_extensible_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extensible).to eq(true)
      end

      types.find{|x| x.id == "enumeration_list_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::EnumerationItem)
        expect(x.items[0].id).to eq("test")
      end

      types.find{|x| x.id == "enumeration_extension_type_ref_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("enumeration_type")
      end

      types.find{|x| x.id == "enumeration_extension_type_ref_list_type"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("enumeration_type")
        expect(x.extension_items).to be_instance_of(Array)
        expect(x.extension_items[0]).to be_instance_of(Expressir::Model::EnumerationItem)
        expect(x.extension_items[0].id).to eq("test")
      end

      # statements
      functions.find{|x| x.id == "alias_simple_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "alias_attribute_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.attribute.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "alias_group_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.entity.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "alias_index_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index1.value).to eq("1")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "alias_index2_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index1.value).to eq("1")
        expect(x.expression.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index2.value).to eq("9")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "assignment_simple_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignment_attribute_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.attribute.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignment_group_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.entity.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignment_index_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index1.value).to eq("1")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignment_index2_reference_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index1.value).to eq("1")
        expect(x.ref.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index2.value).to eq("9")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "case_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].labels).to be_instance_of(Array)
        expect(x.actions[0].labels.count).to eq(1)
        expect(x.actions[0].labels[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].labels[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "case_multiple_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(2)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].labels).to be_instance_of(Array)
        expect(x.actions[0].labels.count).to eq(1)
        expect(x.actions[0].labels[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].labels[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.actions[1]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[1].labels).to be_instance_of(Array)
        expect(x.actions[1].labels.count).to eq(1)
        expect(x.actions[1].labels[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[1].labels[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[1].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "case_multiple_shorthand_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].labels).to be_instance_of(Array)
        expect(x.actions[0].labels.count).to eq(2)
        expect(x.actions[0].labels[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].labels[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].labels[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].labels[1].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "case_otherwise_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].labels).to be_instance_of(Array)
        expect(x.actions[0].labels.count).to eq(1)
        expect(x.actions[0].labels[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].labels[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.otherwise_statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "compound_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Compound)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "escape_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Escape)
      end

      functions.find{|x| x.id == "if_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if_else_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(1)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2_else_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(1)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if_else2_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(2)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2_else2_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(2)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "null_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "call_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("empty_procedure")
      end

      functions.find{|x| x.id == "call_parameter_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("empty_procedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "call_parameter2_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("empty_procedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[1].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "call_insert_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("INSERT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "call_remove_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("REMOVE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "repeat_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeat_variable_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.id).to eq("test")
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeat_variable_increment_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.id).to eq("test")
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.increment).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.increment.value).to eq("2")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeat_while_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.while_expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.while_expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeat_until_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.until_expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.until_expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "return_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Return)
      end

      functions.find{|x| x.id == "return_expression_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Return)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "skip_statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Skip)
      end

      # literal expressions
      functions.find{|x| x.id == "binary_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Binary)
        expect(x.value).to eq("011110000111100001111000")
      end

      functions.find{|x| x.id == "integer_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.value).to eq("999")
      end

      functions.find{|x| x.id == "true_logical_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end
      
      functions.find{|x| x.id == "false_logical_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      functions.find{|x| x.id == "unknown_logical_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::UNKNOWN)
      end

      functions.find{|x| x.id == "real_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Real)
        expect(x.value).to eq("999.999")
      end

      functions.find{|x| x.id == "simple_string_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.value).to eq("xxx")
      end

      functions.find{|x| x.id == "utf8_simple_string_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.value).to eq("UTF8 test: Příliš žluťoučký kůň úpěl ďábelské ódy.")
      end

      functions.find{|x| x.id == "encoded_string_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.value).to eq("000000780000007800000078")
        expect(x.encoded).to eq(true)
      end

      # constant expressions
      functions.find{|x| x.id == "const_e_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("CONST_E")
      end

      functions.find{|x| x.id == "indeterminate_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("?")
      end

      functions.find{|x| x.id == "pi_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("PI")
      end

      functions.find{|x| x.id == "self_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("SELF")
      end

      # function expressions
      functions.find{|x| x.id == "abs_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ABS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "acos_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ACOS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "asin_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ASIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "atan_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ATAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "blength_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("BLENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "cos_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("COS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "exists_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("EXISTS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "exp_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("EXP")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "format_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("FORMAT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "hibound_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("HIBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "hiindex_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("HIINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "length_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "lobound_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "loindex_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "log_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "log2_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG2")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "log10_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG10")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "nvl_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("NVL")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "odd_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ODD")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "rolesof_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ROLESOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "sin_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "sizeof_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SIZEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "sqrt_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SQRT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "tan_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("TAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "typeof_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("TYPEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "usedin_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("USEDIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "value_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "value_in_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE_IN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "value_unique_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE_UNIQUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # operator expressions
      functions.find{|x| x.id == "plus_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::PLUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.value).to eq("4")
      end

      functions.find{|x| x.id == "plus_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::PLUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand1.value).to eq("4")
        expect(x.operand.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "minus_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::MINUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.value).to eq("4")
      end

      functions.find{|x| x.id == "minus_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::MINUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand1.value).to eq("4")
        expect(x.operand.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "subtraction_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "multiplication_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "real_division_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::REAL_DIVISION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "integer_division_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INTEGER_DIVISION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "modulo_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MODULO)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "exponentiation_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::EXPONENTIATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "addition_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      functions.find{|x| x.id == "subtraction_subtraction_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      functions.find{|x| x.id == "addition_subtraction_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      functions.find{|x| x.id == "subtraction_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      functions.find{|x| x.id == "addition_multiplication_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("8")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand1.value).to eq("4")
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "multiplication_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("8")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "parenthesis_addition_multiplication_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("8")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "multiplication_parenthesis_addition_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("8")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand1.value).to eq("4")
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "equal_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "not_equal_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::NOT_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "instance_equal_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INSTANCE_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "instance_not_equal_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "lt_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "gt_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::GREATER_THAN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "lte_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "gte_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "not_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::NOT)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "not_or_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::NOT)
        expect(x.operand).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      functions.find{|x| x.id == "or_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      functions.find{|x| x.id == "and_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      functions.find{|x| x.id == "or_or_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "and_and_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "or_and_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand1.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "and_or_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "parenthesis_or_and_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "and_parenthesis_or_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand1.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # aggregate initializer expressions
      functions.find{|x| x.id == "aggregate_initializer_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].value).to eq("4")
      end

      functions.find{|x| x.id == "repeated_aggregate_initializer_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateItem)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.value).to eq("4")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.value).to eq("2")
      end

      functions.find{|x| x.id == "complex_aggregate_initializer_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operand1.value).to eq("4")
        expect(x.items[0].operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operand2.value).to eq("2")
      end

      functions.find{|x| x.id == "complex_repeated_aggregate_initializer_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateItem)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].expression.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operand1.value).to eq("4")
        expect(x.items[0].expression.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operand2.value).to eq("2")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].repetition.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].repetition.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operand1.value).to eq("4")
        expect(x.items[0].repetition.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operand2.value).to eq("2")
      end

      # function call or entity constructor expressions
      functions.find{|x| x.id == "call_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("parameter_function")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # reference expressions
      functions.find{|x| x.id == "simple_reference_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("simple_string_expression")
      end

      functions.find{|x| x.id == "attribute_reference_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("simple_string_expression")
        expect(x.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attribute.id).to eq("test")
      end

      functions.find{|x| x.id == "group_reference_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("simple_string_expression")
        expect(x.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.entity.id).to eq("test")
      end

      functions.find{|x| x.id == "index_reference_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("simple_string_expression")
        expect(x.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index1.value).to eq("1")
      end

      functions.find{|x| x.id == "index2_reference_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("simple_string_expression")
        expect(x.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index1.value).to eq("1")
        expect(x.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index2.value).to eq("9")
      end

      # interval expressions
      functions.find{|x| x.id == "lt_lt_interval_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      functions.find{|x| x.id == "lte_lt_interval_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      functions.find{|x| x.id == "lt_lte_interval_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      functions.find{|x| x.id == "lte_lte_interval_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      functions.find{|x| x.id == "combine_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::COMBINE)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.operand1.id).to eq("test")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.operand2.id).to eq("test")
      end

      functions.find{|x| x.id == "in_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::IN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.operand2.items).to be_instance_of(Array)
        expect(x.operand2.items.count).to eq(1)
        expect(x.operand2.items[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.items[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "like_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LIKE)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operand1.value).to eq("xxx")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operand2.value).to eq("xxx")
      end

      # query expressions
      functions.find{|x| x.id == "query_expression"}.statements[0].expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::QueryExpression)
        expect(x.id).to eq("test")
        expect(x.aggregate_source).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.aggregate_source.id).to eq("test2")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "syntax.exp"
    )
  end
end
