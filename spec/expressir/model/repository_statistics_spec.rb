# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Model::Repository, "statistics methods" do
  let(:entity1) { double(id: "entity1") }
  let(:entity2) { double(id: "entity2") }
  let(:type1) { double(id: "type1") }
  let(:type2) { double(id: "type2") }
  let(:function1) { double(id: "function1") }
  let(:rule1) { double(id: "rule1") }
  let(:procedure1) { double(id: "procedure1") }
  let(:constant1) { double(id: "constant1") }

  let(:interface_use) do
    instance_double(
      Expressir::Model::Declarations::Interface,
      kind: Expressir::Model::Declarations::Interface::USE,
      schema: double(id: "referenced_schema"),
    )
  end

  let(:interface_reference) do
    instance_double(
      Expressir::Model::Declarations::Interface,
      kind: Expressir::Model::Declarations::Interface::REFERENCE,
      schema: double(id: "target_schema"),
    )
  end

  let(:schema_with_entities) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_entities",
      entities: [entity1, entity2],
      types: nil,
      functions: nil,
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: nil,
    )
  end

  let(:schema_with_types) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_types",
      entities: nil,
      types: [type1, type2],
      functions: nil,
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: nil,
    )
  end

  let(:schema_with_functions) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_functions",
      entities: nil,
      types: nil,
      functions: [function1],
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: nil,
    )
  end

  let(:schema_with_rules) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_rules",
      entities: nil,
      types: nil,
      functions: nil,
      rules: [rule1],
      procedures: nil,
      constants: nil,
      interfaces: nil,
    )
  end

  let(:schema_interface_only) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_interfaces",
      entities: nil,
      types: nil,
      functions: nil,
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: [interface_use],
    )
  end

  let(:empty_schema) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "empty_schema",
      entities: nil,
      types: nil,
      functions: nil,
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: nil,
    )
  end

  let(:complex_schema) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "complex_schema",
      entities: [entity1, entity2],
      types: [type1, type2],
      functions: [function1],
      rules: [rule1],
      procedures: [procedure1],
      constants: [constant1],
      interfaces: [interface_use, interface_reference],
    )
  end

  let(:schema_with_interfaces) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: "schema_deps",
      entities: nil,
      types: nil,
      functions: nil,
      rules: nil,
      procedures: nil,
      constants: nil,
      interfaces: [interface_use, interface_reference],
    )
  end

  describe "#schemas_by_category" do
    it "categorizes schemas with entities" do
      repo = described_class.new(schemas: [schema_with_entities, empty_schema])

      result = repo.schemas_by_category

      expect(result[:with_entities]).to include(schema_with_entities)
      expect(result[:with_entities]).not_to include(empty_schema)
    end

    it "categorizes schemas with types" do
      repo = described_class.new(schemas: [schema_with_types, empty_schema])

      result = repo.schemas_by_category

      expect(result[:with_types]).to include(schema_with_types)
      expect(result[:with_types]).not_to include(empty_schema)
    end

    it "categorizes schemas with functions" do
      repo = described_class.new(schemas: [schema_with_functions, empty_schema])

      result = repo.schemas_by_category

      expect(result[:with_functions]).to include(schema_with_functions)
      expect(result[:with_functions]).not_to include(empty_schema)
    end

    it "categorizes schemas with rules" do
      repo = described_class.new(schemas: [schema_with_rules, empty_schema])

      result = repo.schemas_by_category

      expect(result[:with_rules]).to include(schema_with_rules)
      expect(result[:with_rules]).not_to include(empty_schema)
    end

    it "categorizes interface-only schemas" do
      repo = described_class.new(schemas: [schema_interface_only, empty_schema])

      result = repo.schemas_by_category

      expect(result[:interface_only]).to include(schema_interface_only)
      expect(result[:interface_only]).not_to include(empty_schema)
    end

    it "categorizes empty schemas" do
      repo = described_class.new(schemas: [empty_schema, schema_with_entities])

      result = repo.schemas_by_category

      expect(result[:empty]).to include(empty_schema)
      expect(result[:empty]).not_to include(schema_with_entities)
    end

    it "returns all category keys" do
      repo = described_class.new(schemas: [])

      result = repo.schemas_by_category

      expect(result.keys).to contain_exactly(
        :with_entities, :with_types, :with_functions,
        :with_rules, :interface_only, :empty
      )
    end

    it "handles schemas in multiple categories" do
      repo = described_class.new(schemas: [complex_schema])

      result = repo.schemas_by_category

      expect(result[:with_entities]).to include(complex_schema)
      expect(result[:with_types]).to include(complex_schema)
      expect(result[:with_functions]).to include(complex_schema)
      expect(result[:with_rules]).to include(complex_schema)
    end
  end

  describe "#largest_schemas" do
    it "returns schemas sorted by element count" do
      repo = described_class.new(schemas: [schema_with_entities, empty_schema,
                                           complex_schema])

      result = repo.largest_schemas(10)

      expect(result.first[:schema]).to eq(complex_schema)
      expect(result.first[:total_elements]).to be > result.last[:total_elements]
    end

    it "limits results to specified number" do
      schemas = Array.new(15) do |i|
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: "schema#{i}",
          entities: [entity1],
          types: nil,
          functions: nil,
          rules: nil,
          procedures: nil,
          constants: nil,
        )
      end
      repo = described_class.new(schemas: schemas)

      result = repo.largest_schemas(5)

      expect(result.size).to eq(5)
    end

    it "returns all schemas when limit exceeds count" do
      repo = described_class.new(schemas: [schema_with_entities, empty_schema])

      result = repo.largest_schemas(10)

      expect(result.size).to eq(2)
    end

    it "includes schema and total_elements in results" do
      repo = described_class.new(schemas: [schema_with_entities])

      result = repo.largest_schemas(10)

      expect(result.first).to have_key(:schema)
      expect(result.first).to have_key(:total_elements)
      expect(result.first[:total_elements]).to eq(2)
    end

    it "handles empty repository" do
      repo = described_class.new(schemas: [])

      result = repo.largest_schemas(10)

      expect(result).to be_empty
    end
  end

  describe "#schema_complexity" do
    it "calculates complexity for schema with entities" do
      repo = described_class.new

      complexity = repo.schema_complexity(schema_with_entities)

      expect(complexity).to eq(4)  # 2 entities * 2
    end

    it "calculates complexity for schema with types" do
      repo = described_class.new

      complexity = repo.schema_complexity(schema_with_types)

      expect(complexity).to eq(2)  # 2 types * 1
    end

    it "calculates complexity for schema with functions" do
      repo = described_class.new

      complexity = repo.schema_complexity(schema_with_functions)

      expect(complexity).to eq(3)  # 1 function * 3
    end

    it "calculates complexity for schema with rules" do
      repo = described_class.new

      complexity = repo.schema_complexity(schema_with_rules)

      expect(complexity).to eq(4)  # 1 rule * 4
    end

    it "calculates complexity for complex schema" do
      repo = described_class.new

      complexity = repo.schema_complexity(complex_schema)

      # 2 entities * 2 + 2 types * 1 + 1 function * 3 + 1 rule * 4 + 1 procedure * 3 + 2 interfaces * 2
      expect(complexity).to eq(20)
    end

    it "returns zero for empty schema" do
      repo = described_class.new

      complexity = repo.schema_complexity(empty_schema)

      expect(complexity).to eq(0)
    end
  end

  describe "#schemas_by_complexity" do
    it "returns schemas sorted by complexity" do
      repo = described_class.new(schemas: [empty_schema, complex_schema,
                                           schema_with_entities])

      result = repo.schemas_by_complexity(10)

      expect(result.first[:schema]).to eq(complex_schema)
      expect(result.first[:complexity]).to be > result.last[:complexity]
    end

    it "limits results to specified number" do
      schemas = Array.new(15) do |i|
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: "schema#{i}",
          entities: [entity1],
          types: nil,
          functions: nil,
          rules: nil,
          procedures: nil,
          constants: nil,
          interfaces: nil,
        )
      end
      repo = described_class.new(schemas: schemas)

      result = repo.schemas_by_complexity(5)

      expect(result.size).to eq(5)
    end

    it "includes schema and complexity in results" do
      repo = described_class.new(schemas: [schema_with_entities])

      result = repo.schemas_by_complexity(10)

      expect(result.first).to have_key(:schema)
      expect(result.first).to have_key(:complexity)
      expect(result.first[:complexity]).to eq(4)
    end

    it "handles empty repository" do
      repo = described_class.new(schemas: [])

      result = repo.schemas_by_complexity(10)

      expect(result).to be_empty
    end
  end

  describe "#dependency_statistics" do
    it "counts total interfaces" do
      repo = described_class.new(schemas: [schema_with_interfaces])

      stats = repo.dependency_statistics

      expect(stats[:total_interfaces]).to eq(2)
    end

    it "counts USE interfaces" do
      repo = described_class.new(schemas: [schema_with_interfaces])

      stats = repo.dependency_statistics

      expect(stats[:use_from_count]).to eq(1)
    end

    it "counts REFERENCE interfaces" do
      repo = described_class.new(schemas: [schema_with_interfaces])

      stats = repo.dependency_statistics

      expect(stats[:reference_from_count]).to eq(1)
    end

    it "identifies most referenced schemas" do
      repo = described_class.new(schemas: [schema_with_interfaces])

      stats = repo.dependency_statistics

      expect(stats[:most_referenced]).to be_a(Hash)
      expect(stats[:most_referenced]).to have_key("referenced_schema")
      expect(stats[:most_referenced]["referenced_schema"]).to eq(1)
    end

    it "identifies most dependent schemas" do
      repo = described_class.new(schemas: [schema_with_interfaces])

      stats = repo.dependency_statistics

      expect(stats[:most_dependent]).to be_a(Hash)
      expect(stats[:most_dependent]).to have_key("schema_deps")
      expect(stats[:most_dependent]["schema_deps"]).to eq(2)
    end

    it "limits most_referenced to top 10" do
      # Create 15 schemas that reference 15 different schemas
      schemas = Array.new(15) do |i|
        interface = instance_double(
          Expressir::Model::Declarations::Interface,
          kind: Expressir::Model::Declarations::Interface::USE,
          schema: double(id: "ref_schema#{i}"),
        )
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: "schema#{i}",
          entities: nil,
          types: nil,
          functions: nil,
          rules: nil,
          procedures: nil,
          constants: nil,
          interfaces: [interface],
        )
      end
      repo = described_class.new(schemas: schemas)

      stats = repo.dependency_statistics

      expect(stats[:most_referenced].size).to be <= 10
    end

    it "limits most_dependent to top 10" do
      # Create 15 schemas with interfaces
      schemas = Array.new(15) do |i|
        interface = instance_double(
          Expressir::Model::Declarations::Interface,
          kind: Expressir::Model::Declarations::Interface::USE,
          schema: double(id: "ref_schema"),
        )
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: "schema#{i}",
          entities: nil,
          types: nil,
          functions: nil,
          rules: nil,
          procedures: nil,
          constants: nil,
          interfaces: [interface],
        )
      end
      repo = described_class.new(schemas: schemas)

      stats = repo.dependency_statistics

      expect(stats[:most_dependent].size).to be <= 10
    end

    it "handles schemas without interfaces" do
      repo = described_class.new(schemas: [empty_schema])

      stats = repo.dependency_statistics

      expect(stats[:total_interfaces]).to eq(0)
      expect(stats[:use_from_count]).to eq(0)
      expect(stats[:reference_from_count]).to eq(0)
    end

    it "handles empty repository" do
      repo = described_class.new(schemas: [])

      stats = repo.dependency_statistics

      expect(stats[:total_interfaces]).to eq(0)
      expect(stats[:most_referenced]).to be_empty
      expect(stats[:most_dependent]).to be_empty
    end

    it "handles interfaces with nil schema" do
      nil_schema_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: nil,
      )
      schema = instance_double(
        Expressir::Model::Declarations::Schema,
        id: "test_schema",
        entities: nil,
        types: nil,
        functions: nil,
        rules: nil,
        procedures: nil,
        constants: nil,
        interfaces: [nil_schema_interface],
      )
      repo = described_class.new(schemas: [schema])

      stats = repo.dependency_statistics

      expect(stats[:total_interfaces]).to eq(1)
      expect(stats[:most_referenced]).to be_empty
    end
  end

  describe "integration with existing statistics" do
    it "complements existing statistics method" do
      repo = described_class.new(schemas: [complex_schema])

      categories = repo.schemas_by_category
      largest = repo.largest_schemas(1)
      complexity = repo.schema_complexity(complex_schema)

      expect(categories[:with_entities]).to include(complex_schema)
      expect(largest.first[:schema]).to eq(complex_schema)
      expect(complexity).to eq(20)
    end

    it "works without building indexes" do
      repo = described_class.new(schemas: [schema_with_entities])

      # Should not require indexes
      expect { repo.schemas_by_category }.not_to raise_error
      expect { repo.largest_schemas(10) }.not_to raise_error
      expect { repo.schema_complexity(schema_with_entities) }.not_to raise_error
    end
  end
end
