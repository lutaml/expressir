# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Model::Indexes::EntityIndex do
  let(:schema1) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "schema1"),
      entities: entities1,
    )
  end

  let(:schema2) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "schema2"),
      entities: entities2,
    )
  end

  let(:entity1) do
    instance_double(
      Expressir::Model::Declarations::Entity,
      id: double(safe_downcase: "entity1"),
    )
  end

  let(:entity2) do
    instance_double(
      Expressir::Model::Declarations::Entity,
      id: double(safe_downcase: "entity2"),
    )
  end

  let(:entity3) do
    instance_double(
      Expressir::Model::Declarations::Entity,
      id: double(safe_downcase: "entity3"),
    )
  end

  let(:entities1) { [entity1, entity2] }
  let(:entities2) { [entity3] }

  describe "#initialize" do
    it "creates an empty index when no schemas provided" do
      index = described_class.new

      expect(index.by_schema).to eq({})
      expect(index.by_qualified_name).to eq({})
    end

    it "builds indexes when schemas provided" do
      index = described_class.new([schema1])

      expect(index.by_schema).to have_key("schema1")
      expect(index.by_qualified_name).to have_key("schema1.entity1")
    end

    it "handles empty array" do
      index = described_class.new([])

      expect(index.by_schema).to eq({})
      expect(index.by_qualified_name).to eq({})
    end
  end

  describe "#build" do
    let(:index) { described_class.new }

    it "builds indexes from schemas" do
      index.build([schema1, schema2])

      expect(index.by_schema.keys).to contain_exactly("schema1", "schema2")
      expect(index.by_qualified_name.keys).to contain_exactly(
        "schema1.entity1",
        "schema1.entity2",
        "schema2.entity3",
      )
    end

    it "indexes entities by schema" do
      index.build([schema1])

      expect(index.by_schema["schema1"]).to include(
        "entity1" => entity1,
        "entity2" => entity2,
      )
    end

    it "indexes entities by qualified name" do
      index.build([schema1])

      expect(index.by_qualified_name["schema1.entity1"]).to eq(entity1)
      expect(index.by_qualified_name["schema1.entity2"]).to eq(entity2)
    end

    it "handles schemas with nil entities" do
      schema_no_entities = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "empty_schema"),
        entities: nil,
      )

      expect { index.build([schema_no_entities]) }.not_to raise_error
      expect(index.by_schema["empty_schema"]).to eq({})
    end

    it "handles empty entities collection" do
      schema_empty_entities = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "empty_schema"),
        entities: [],
      )

      index.build([schema_empty_entities])

      expect(index.by_schema["empty_schema"]).to eq({})
    end

    it "clears previous indexes on rebuild" do
      index.build([schema1])
      initial_count = index.count

      index.build([schema2])

      expect(index.count).not_to eq(initial_count)
      expect(index.by_qualified_name).not_to have_key("schema1.entity1")
      expect(index.by_qualified_name).to have_key("schema2.entity3")
    end
  end

  describe "#find" do
    let(:index) { described_class.new([schema1, schema2]) }

    context "with qualified name" do
      it "finds entity by qualified name" do
        result = index.find("schema1.entity1")

        expect(result).to eq(entity1)
      end

      it "handles case-insensitive qualified names" do
        # String already has safe_downcase method via extension
        result = index.find("schema1.entity1")

        expect(result).to eq(entity1)
      end

      it "returns nil for non-existent qualified name" do
        result = index.find("schema1.nonexistent")

        expect(result).to be_nil
      end
    end

    context "with simple name" do
      it "finds entity by simple name across all schemas" do
        result = index.find("entity1")

        expect(result).to eq(entity1)
      end

      it "returns first match when simple name exists in multiple schemas" do
        duplicate_entity = instance_double(
          Expressir::Model::Declarations::Entity,
          id: double(safe_downcase: "entity1"),
        )
        schema_with_duplicate = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "schema3"),
          entities: [duplicate_entity],
        )
        index.build([schema1, schema_with_duplicate])

        result = index.find("entity1")

        expect(result).not_to be_nil
        expect([entity1, duplicate_entity]).to include(result)
      end
    end

    context "with non-existent schema" do
      it "returns nil when schema does not exist" do
        result = index.find("nonexistent.entity1")

        expect(result).to be_nil
      end
    end

    it "returns nil for empty string" do
      result = index.find("")

      expect(result).to be_nil
    end
  end

  describe "#list" do
    let(:index) { described_class.new([schema1, schema2]) }

    context "without schema filter" do
      it "lists all entities" do
        result = index.list

        expect(result).to contain_exactly(entity1, entity2, entity3)
      end
    end

    context "with schema filter" do
      it "lists entities from specific schema" do
        result = index.list(schema: "schema1")

        expect(result).to contain_exactly(entity1, entity2)
      end

      it "returns empty array for non-existent schema" do
        result = index.list(schema: "nonexistent")

        expect(result).to eq([])
      end

      it "handles case-insensitive schema names" do
        result = index.list(schema: "schema1")

        expect(result).to contain_exactly(entity1, entity2)
      end
    end
  end

  describe "#empty?" do
    it "returns true for empty index" do
      index = described_class.new

      expect(index).to be_empty
    end

    it "returns false for non-empty index" do
      index = described_class.new([schema1])

      expect(index).not_to be_empty
    end

    it "returns true after building with empty schemas" do
      schema_no_entities = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "empty"),
        entities: nil,
      )
      index = described_class.new([schema_no_entities])

      expect(index).to be_empty
    end
  end

  describe "#count" do
    it "returns zero for empty index" do
      index = described_class.new

      expect(index.count).to eq(0)
    end

    it "counts total entities across all schemas" do
      index = described_class.new([schema1, schema2])

      expect(index.count).to eq(3)
    end

    it "returns correct count after rebuild" do
      index = described_class.new([schema1])
      expect(index.count).to eq(2)

      index.build([schema2])

      expect(index.count).to eq(1)
    end
  end

  describe "#schema_entities" do
    let(:index) { described_class.new([schema1, schema2]) }

    it "returns entities hash for existing schema" do
      result = index.schema_entities("schema1")

      expect(result).to be_a(Hash)
      expect(result.values).to contain_exactly(entity1, entity2)
    end

    it "returns empty hash for non-existent schema" do
      result = index.schema_entities("nonexistent")

      expect(result).to eq({})
    end

    it "handles case-insensitive schema names" do
      result = index.schema_entities("schema1")

      expect(result).to be_a(Hash)
      expect(result.keys).to contain_exactly("entity1", "entity2")
    end
  end

  describe "single responsibility principle" do
    it "focuses solely on entity indexing" do
      index = described_class.new([schema1])

      expect(index).to respond_to(:find)
      expect(index).to respond_to(:list)
      expect(index).to respond_to(:build)
      expect(index).not_to respond_to(:validate)
      expect(index).not_to respond_to(:resolve_references)
    end
  end

  describe "extensibility" do
    it "allows rebuilding indexes with different schemas" do
      index = described_class.new([schema1])
      expect(index.count).to eq(2)

      index.build([schema2])
      expect(index.count).to eq(1)

      index.build([schema1, schema2])
      expect(index.count).to eq(3)
    end
  end
end
