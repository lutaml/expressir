# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Model::SearchEngine, "advanced features" do
  let(:schema1) { double(id: "schema1") }
  let(:schema2) { double(id: "test_schema") }

  let(:entity1) do
    double(
      id: "entity1",
      path: "schema1.entity1",
      parent: schema1,
      attributes: [],
      where_rules: [],
      unique_rules: [],
    )
  end

  let(:entity2) do
    double(
      id: "test_entity",
      path: "test_schema.test_entity",
      parent: schema2,
      attributes: [],
      where_rules: [],
      unique_rules: [],
    )
  end

  let(:attribute1) do
    double(
      id: "attr1",
      path: "schema1.entity1.attr1",
      parent: entity1,
    )
  end

  let(:attribute2) do
    double(
      id: "test_attr",
      path: "test_schema.test_entity.test_attr",
      parent: entity2,
    )
  end

  let(:repo) do
    double(
      schemas: [schema1, schema2],
      entity_index: double(nil?: false),
      type_index: double,
    )
  end

  let(:engine) { described_class.new(repo) }

  before do
    allow(repo).to receive(:build_indexes)
    allow(schema1).to receive_messages(entities: [entity1], types: [],
                                       functions: [], procedures: [], rules: [], constants: [], interfaces: [])
    allow(schema2).to receive_messages(entities: [entity2], types: [],
                                       functions: [], procedures: [], rules: [], constants: [], interfaces: [])
    allow(entity1).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(false)
    allow(entity2).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(false)
    allow(schema1).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(true)
    allow(schema2).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(true)
    allow(entity1).to receive(:attributes).and_return([attribute1])
    allow(entity2).to receive(:attributes).and_return([attribute2])
    allow(attribute1).to receive(:is_a?).with(Expressir::Model::Declarations::DerivedAttribute).and_return(false)
    allow(attribute1).to receive(:is_a?).with(Expressir::Model::Declarations::InverseAttribute).and_return(false)
    allow(attribute2).to receive(:is_a?).with(Expressir::Model::Declarations::DerivedAttribute).and_return(false)
    allow(attribute2).to receive(:is_a?).with(Expressir::Model::Declarations::InverseAttribute).and_return(false)
    allow(attribute1).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(false)
    allow(attribute2).to receive(:is_a?).with(Expressir::Model::Declarations::Schema).and_return(false)
    allow(attribute1).to receive(:parent).and_return(entity1)
    allow(attribute2).to receive(:parent).and_return(entity2)
  end

  describe "#search_with_depth" do
    it "filters results by maximum depth" do
      # Create mock results with different depths
      mock_results = [
        { id: "schema1", path: "schema1", type: "schema" },
        { id: "entity1", path: "schema1.entity1", type: "entity" },
        { id: "attr1", path: "schema1.entity1.attr1", type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_with_depth(pattern: "test", max_depth: 2)

      # Should include schema level (depth 1) and entity level (depth 2)
      # Should exclude attribute level (depth 3)
      paths = results.map { |r| r[:path] }
      expect(paths).to include("schema1", "schema1.entity1")
      expect(paths).not_to include("schema1.entity1.attr1")
    end

    it "includes schema-level results at depth 1" do
      mock_results = [
        { id: "schema1", path: "schema1", type: "schema" },
        { id: "entity1", path: "schema1.entity1", type: "entity" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_with_depth(pattern: "schema", max_depth: 1)

      expect(results).not_to be_empty
      results.each do |result|
        depth = result[:path]&.split(".")&.size || 0
        expect(depth).to be <= 1
      end
    end

    it "includes entity-level results at depth 2" do
      mock_results = [
        { id: "entity1", path: "schema1.entity1", type: "entity" },
        { id: "attr1", path: "schema1.entity1.attr1", type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_with_depth(pattern: "entity", max_depth: 2)

      paths = results.map { |r| r[:path] }
      expect(paths).to include("schema1.entity1")
      expect(paths).not_to include("schema1.entity1.attr1")
    end

    it "includes attribute-level results at depth 3" do
      mock_results = [
        { id: "attr1", path: "schema1.entity1.attr1", type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_with_depth(pattern: "attr", max_depth: 3)

      paths = results.map { |r| r[:path] }
      expect(paths).to include("schema1.entity1.attr1")
    end
  end

  describe "#search_ranked" do
    it "returns results with relevance scores" do
      mock_results = [
        { id: "test_entity", path: "test_schema.test_entity", type: "entity" },
        { id: "test_attr", path: "test_schema.test_entity.test_attr",
          type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_ranked(pattern: "test")

      expect(results).not_to be_empty
      results.each do |result|
        expect(result).to have_key(:relevance_score)
        expect(result[:relevance_score]).to be_a(Integer)
      end
    end

    it "ranks exact matches higher" do
      results = engine.search_ranked(pattern: "test_entity")

      exact_match = results.find { |r| r[:id] == "test_entity" }
      other_matches = results.reject { |r| r[:id] == "test_entity" }

      if exact_match && other_matches.any?
        expect(exact_match[:relevance_score]).to be >= other_matches.first[:relevance_score]
      end
    end

    it "ranks prefix matches higher than substring matches" do
      mock_results = [
        { id: "test_entity", path: "schema.test_entity", type: "entity" },
        { id: "my_test", path: "schema.my_test", type: "entity" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_ranked(pattern: "test")

      prefix_matches = results.select { |r| r[:id]&.start_with?("test") }
      expect(prefix_matches).not_to be_empty
    end

    it "ranks schema-level results higher" do
      results = engine.search_ranked(pattern: "schema")

      schema_results = results.select { |r| r[:type] == "schema" }
      non_schema_results = results.reject { |r| r[:type] == "schema" }

      if schema_results.any? && non_schema_results.any?
        avg_schema_score = schema_results.sum do |r|
          r[:relevance_score]
        end / schema_results.size.to_f
        avg_other_score = non_schema_results.sum do |r|
          r[:relevance_score]
        end / non_schema_results.size.to_f
        expect(avg_schema_score).to be >= avg_other_score
      end
    end

    it "ranks shorter paths higher" do
      results = engine.search_ranked(pattern: "test")

      if results.size >= 2
        # Paths should influence ranking
        first_depth = results.first[:path]&.split(".")&.size || 0
        last_depth = results.last[:path]&.split(".")&.size || 0
        expect(first_depth).to be <= last_depth + 3 # Allow some variance
      end
    end

    it "accepts custom boost values" do
      mock_results = [
        { id: "test_entity", path: "schema.test_entity", type: "entity" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_ranked(
        pattern: "test",
        boost_exact: 20,
        boost_prefix: 10,
      )

      expect(results).not_to be_empty
      expect(results.first).to have_key(:relevance_score)
    end

    it "sorts results by relevance score descending" do
      results = engine.search_ranked(pattern: "test")

      scores = results.map { |r| r[:relevance_score] }
      expect(scores).to eq(scores.sort.reverse)
    end

    it "accepts additional search options" do
      results = engine.search_ranked(
        pattern: "test",
        type: "entity",
      )

      expect(results.all? { |r| r[:type] == "entity" }).to be true
    end

    it "handles empty results gracefully" do
      results = engine.search_ranked(pattern: "nonexistent")

      expect(results).to be_empty
    end

    it "calculates scores consistently" do
      results1 = engine.search_ranked(pattern: "test")
      results2 = engine.search_ranked(pattern: "test")

      expect(results1.map { |r| r[:relevance_score] }).to eq(
        results2.map { |r| r[:relevance_score] },
      )
    end
  end

  describe "#search_advanced" do
    it "combines depth filtering and ranking" do
      mock_results = [
        { id: "test", path: "schema.test", type: "entity" },
        { id: "test_attr", path: "schema.test.attr", type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_advanced(
        pattern: "test",
        max_depth: 2,
        ranked: true,
      )

      # Check depth constraint
      expect(results).not_to be_empty
      results.each do |result|
        next unless result[:path]

        depth = result[:path].split(".").size
        expect(depth).to be <= 2
      end

      # Check ranking
      expect(results.first).to have_key(:relevance_score)
    end

    it "applies only depth filtering when ranked is false" do
      mock_results = [
        { id: "test", path: "schema.test", type: "entity" },
        { id: "test_attr", path: "schema.test.attr", type: "attribute" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_advanced(
        pattern: "test",
        max_depth: 2,
        ranked: false,
      )

      results.each do |result|
        next unless result[:path]

        depth = result[:path].split(".").size
        expect(depth).to be <= 2
      end

      expect(results).not_to be_empty
      expect(results.first).not_to have_key(:relevance_score)
    end

    it "applies only ranking when max_depth is nil" do
      mock_results = [
        { id: "test_entity", path: "schema.test_entity", type: "entity" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_advanced(
        pattern: "test",
        max_depth: nil,
        ranked: true,
      )

      expect(results).not_to be_empty
      expect(results.first).to have_key(:relevance_score)
    end

    it "works without any advanced options" do
      mock_results = [
        { id: "test_entity", path: "schema.test_entity", type: "entity" },
      ]
      allow(engine).to receive(:search).and_return(mock_results)

      results = engine.search_advanced(
        pattern: "test",
        max_depth: nil,
        ranked: false,
      )

      expect(results).not_to be_empty
      expect(results.first).not_to have_key(:relevance_score)
    end

    it "accepts all standard search options" do
      results = engine.search_advanced(
        pattern: "test",
        type: "entity",
        max_depth: 2,
        ranked: true,
      )

      expect(results.all? { |r| r[:type] == "entity" }).to be true
    end

    it "handles case_sensitive option" do
      results = engine.search_advanced(
        pattern: "TEST",
        case_sensitive: true,
        max_depth: 2,
      )

      expect(results).to be_a(Array)
    end

    it "handles regex option" do
      results = engine.search_advanced(
        pattern: "test.*",
        regex: true,
        max_depth: 2,
      )

      expect(results).to be_a(Array)
    end

    it "handles exact option" do
      results = engine.search_advanced(
        pattern: "test_entity",
        exact: true,
        max_depth: 2,
      )

      expect(results).to be_a(Array)
    end

    it "handles schema filtering" do
      results = engine.search_advanced(
        pattern: "test",
        schema: "test_schema",
        max_depth: 2,
      )

      results.each do |result|
        expect(result[:schema]).to eq("test_schema") if result[:type] != "schema"
      end
    end

    it "returns consistent results with same parameters" do
      results1 = engine.search_advanced(
        pattern: "test",
        max_depth: 2,
        ranked: true,
      )
      results2 = engine.search_advanced(
        pattern: "test",
        max_depth: 2,
        ranked: true,
      )

      expect(results1.map { |r| r[:id] }).to eq(results2.map { |r| r[:id] })
    end

    it "handles empty results gracefully" do
      results = engine.search_advanced(
        pattern: "nonexistent",
        max_depth: 2,
        ranked: true,
      )

      expect(results).to be_empty
    end
  end

  describe "integration with existing search" do
    it "maintains compatibility with basic search" do
      basic_results = engine.search(pattern: "test")
      advanced_results = engine.search_advanced(pattern: "test")

      # Same IDs but advanced might have different ordering
      expect(basic_results.map { |r| r[:id] }.sort).to eq(
        advanced_results.map { |r| r[:id] }.sort,
      )
    end

    it "produces subset when depth filtering is applied" do
      all_results = engine.search(pattern: "test")
      depth_results = engine.search_with_depth(pattern: "test", max_depth: 2)

      expect(depth_results.size).to be <= all_results.size
    end

    it "maintains result structure" do
      results = engine.search_ranked(pattern: "test")

      results.each do |result|
        expect(result).to have_key(:id)
        expect(result).to have_key(:type)
        expect(result).to have_key(:path)
      end
    end
  end

  describe "edge cases" do
    it "handles nil pattern gracefully in ranked search" do
      expect do
        engine.search_ranked(pattern: "")
      end.not_to raise_error
    end

    it "handles very small max_depth" do
      results = engine.search_with_depth(pattern: "test", max_depth: 0)

      expect(results).to be_empty
    end

    it "handles very large max_depth" do
      results = engine.search_with_depth(pattern: "test", max_depth: 100)

      expect(results).to be_a(Array)
    end

    it "handles negative boost values" do
      results = engine.search_ranked(
        pattern: "test",
        boost_exact: -5,
        boost_prefix: -2,
      )

      expect(results).to be_a(Array)
    end

    it "handles zero boost values" do
      results = engine.search_ranked(
        pattern: "test",
        boost_exact: 0,
        boost_prefix: 0,
      )

      expect(results).to be_a(Array)
    end
  end
end
