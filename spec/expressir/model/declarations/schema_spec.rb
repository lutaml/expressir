require "spec_helper"

RSpec.describe Expressir::Model::Declarations::Schema do
  let(:interface) do
    Expressir::Model::Declarations::Interface.new(
      kind: Expressir::Model::Declarations::Interface::USE,
      schema: Expressir::Model::References::SimpleReference.new(id: "source_schema"),
      items: [
        Expressir::Model::Declarations::InterfaceItem.new(
          ref: Expressir::Model::References::SimpleReference.new(id: "source_type"),
          id: "renamed_type",
        ),
      ],
    )
  end

  let(:constant) do
    Expressir::Model::Declarations::Constant.new(
      id: "test_constant",
      type: Expressir::Model::DataTypes::Integer.new,
      expression: Expressir::Model::Literals::Integer.new(value: "42"),
    )
  end

  let(:type) do
    Expressir::Model::Declarations::Type.new(
      id: "test_type",
      underlying_type: Expressir::Model::DataTypes::String.new,
    )
  end

  let(:entity) do
    Expressir::Model::Declarations::Entity.new(
      id: "test_entity",
      attributes: [
        Expressir::Model::Declarations::Attribute.new(
          id: "test_attr",
          type: Expressir::Model::DataTypes::Integer.new,
        ),
      ],
    )
  end

  let(:subtype_constraint) do
    Expressir::Model::Declarations::SubtypeConstraint.new(
      id: "test_constraint",
      applies_to: Expressir::Model::References::SimpleReference.new(id: "test_entity"),
    )
  end

  let(:function) do
    Expressir::Model::Declarations::Function.new(
      id: "test_function",
      return_type: Expressir::Model::DataTypes::Integer.new,
    )
  end

  let(:rule) do
    Expressir::Model::Declarations::Rule.new(
      id: "test_rule",
      applies_to: [Expressir::Model::References::SimpleReference.new(id: "test_entity")],
    )
  end

  let(:procedure) do
    Expressir::Model::Declarations::Procedure.new(
      id: "test_procedure",
    )
  end

  let(:schema) do
    described_class.new(
      id: "test_schema",
      file: "test_schema.exp",
      version: Expressir::Model::Declarations::SchemaVersion.new(value: "{1}"),
      interfaces: [interface],
      constants: [constant],
      types: [type],
      entities: [entity],
      subtype_constraints: [subtype_constraint],
      functions: [function],
      rules: [rule],
      procedures: [procedure],
      remarks: ["Schema remark"],
      remark_items: [
        Expressir::Model::Declarations::RemarkItem.new(id: "remark1"),
      ],
    )
  end

  let(:repository) do
    Expressir::Model::Repository.new(
      schemas: [schema],
    )
  end

  describe ".new" do
    it "creates a schema with all attributes" do
      expect(schema).to be_a described_class
      expect(schema.id).to eq "test_schema"
      expect(schema.file).to eq "test_schema.exp"
      expect(schema.version).to be_a Expressir::Model::Declarations::SchemaVersion
      expect(schema.version.value).to eq "{1}"
      expect(schema.interfaces).to contain_exactly(interface)
      expect(schema.constants).to contain_exactly(constant)
      expect(schema.types).to contain_exactly(type)
      expect(schema.entities).to contain_exactly(entity)
      expect(schema.subtype_constraints).to contain_exactly(subtype_constraint)
      expect(schema.functions).to contain_exactly(function)
      expect(schema.rules).to contain_exactly(rule)
      expect(schema.procedures).to contain_exactly(procedure)
      expect(schema.remarks).to eq ["Schema remark"]
      expect(schema.remark_items.size).to eq 1
      expect(schema.remark_items.first.id).to eq "remark1"
    end

    it "creates a schema with minimal attributes" do
      schema = described_class.new(id: "minimal_schema")
      expect(schema.id).to eq "minimal_schema"
      expect(schema.file).to be_nil
      expect(schema.version).to be_nil
      expect(schema.interfaces).to be_nil
      expect(schema.constants).to be_nil
      expect(schema.types).to be_nil
      expect(schema.entities).to be_nil
      expect(schema.subtype_constraints).to be_nil
      expect(schema.functions).to be_nil
      expect(schema.rules).to be_nil
      expect(schema.procedures).to be_nil
      expect(schema.remarks).to be_nil
      expect(schema.remark_items).to be_nil
    end
  end

  describe "inheritance" do
    it "inherits from ModelElement" do
      expect(schema).to be_a Expressir::Model::ModelElement
    end

    it "includes Identifier module" do
      expect(described_class.included_modules).to include(Expressir::Model::Identifier)
    end
  end

  describe "#children" do
    before do
      schema.parent = repository
    end

    xit "returns all child elements including interfaced items" do
      children = schema.children
      expect(children).to include(interface)
      expect(children).to include(constant)
      expect(children).to include(type)
      expect(children).to include(entity)
      expect(children).to include(subtype_constraint)
      expect(children).to include(function)
      expect(children).to include(rule)
      expect(children).to include(procedure)
      expect(children).to include(schema.remark_items.first)
    end

    it "returns safe children without interfaced items" do
      safe_children = schema.safe_children
      expect(safe_children).not_to include(interface)
      expect(safe_children).to include(constant)
      expect(safe_children).to include(type)
      expect(safe_children).to include(entity)
      expect(safe_children).to include(subtype_constraint)
      expect(safe_children).to include(function)
      expect(safe_children).to include(rule)
      expect(safe_children).to include(procedure)
      expect(safe_children).to include(schema.remark_items.first)
    end
  end

  describe "path resolution" do
    before do
      schema.parent = repository
    end

    it "provides path for itself" do
      expect(schema.path).to eq "test_schema"
    end

    it "provides path for children" do
      expect(entity.path).to eq "test_schema.test_entity"
      expect(type.path).to eq "test_schema.test_type"
      expect(function.path).to eq "test_schema.test_function"
    end
  end

  describe "interfaced items" do
    let(:source_schema) do
      described_class.new(
        id: "source_schema",
        types: [
          Expressir::Model::Declarations::Type.new(
            id: "source_type",
            underlying_type: Expressir::Model::DataTypes::Integer.new,
          ),
        ],
      )
    end

    before do
      repository.schemas << source_schema
      schema.parent = repository
      source_schema.parent = repository
    end

    it "creates interfaced items from referenced schema" do
      interfaced_items = schema.send(:interfaced_items)
      expect(interfaced_items.size).to eq 1
      expect(interfaced_items.first).to be_a Expressir::Model::Declarations::InterfacedItem
      expect(interfaced_items.first.id).to eq "renamed_type"
      expect(interfaced_items.first.base_item.id).to eq "source_type"
    end

    it "includes interfaced items in children" do
      children = schema.children
      interfaced_items = children.select do |c|
        c.is_a?(Expressir::Model::Declarations::InterfacedItem)
      end
      expect(interfaced_items.size).to eq 1
      expect(interfaced_items.first.id).to eq "renamed_type"
    end
  end
end
