# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Express::ScopeResolver do
  let(:source) do
    <<~EXP
      SCHEMA demo;
      ENTITY outer;
      END_ENTITY;
      TYPE color = ENUMERATION OF (red);
      END_TYPE;
      FUNCTION inner(name : STRING) : BOOLEAN;
        RETURN(TRUE);
      END_FUNCTION;
      END_SCHEMA;
    EXP
  end

  let(:exp_file) { Expressir::Express::Parser.from_exp(source) }
  let(:line_map) { Expressir::Express::LineMap.new(source.b) }
  let(:node_index) { Expressir::Express::NodePositionIndex.new(exp_file, line_map) }

  def resolver
    described_class.new(
      source: source,
      model: exp_file,
      nodes_with_positions: node_index.nodes,
    )
  end

  it "resolves a line inside an ENTITY to the entity" do
    line = source.lines.index { |l| l.include?("ENTITY outer") } + 1
    expect(resolver.containing_scope_for(line)).to be_a(Expressir::Model::Declarations::Entity)
  end

  it "resolves a line inside a FUNCTION to the function" do
    line = source.lines.index { |l| l.include?("RETURN(TRUE)") } + 1
    scope = resolver.containing_scope_for(line)
    expect(scope).to be_a(Expressir::Model::Declarations::Function)
    expect(scope.id).to eq("inner")
  end

  it "resolves a line before the SCHEMA to nil" do
    expect(resolver.containing_scope_for(0)).to be_nil
  end

  it "find_by_source_text locates an entity by END_ENTITY boundary" do
    end_line = source.lines.index { |l| l.include?("END_ENTITY") } + 1
    scope = resolver.find_by_source_text(end_line)
    expect(scope).to be_a(Expressir::Model::Declarations::Entity)
    expect(scope.id).to eq("outer")
  end

  it "does not trip on a TYPE END when the open was an ENTITY" do
    # Robustness against interleaved scopes (illegal in EXPRESS but the
    # stack should not pop the wrong type).
    end_type_line = source.lines.index { |l| l.include?("END_TYPE") } + 1
    scope = resolver.find_by_source_text(end_type_line)
    expect(scope).to be_a(Expressir::Model::Declarations::Type)
  end

  it "SCOPE_DECL_COLLECTIONS is a subset of COLLECTION_REGISTRY[Schema]" do
    schema_collections = Expressir::Express::NodePositionIndex::COLLECTION_REGISTRY[Expressir::Model::Declarations::Schema]
    scope_collections = Expressir::Model::Declarations::Schema::SCOPE_DECL_COLLECTIONS
    expect(scope_collections).to all(satisfy { |c| schema_collections.include?(c) })
  end
end
