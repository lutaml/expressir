# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ModelElement collection_attributes macro (TODO.bugs/12)" do
  it "each model class registers its collections in ModelElement.collection_registry" do
    registry = Expressir::Model::ModelElement.collection_registry

    expect(registry[Expressir::Model::Declarations::Schema]).to include(
      :constants, :types, :entities, :functions, :rules, :procedures, :remark_items
    )
    expect(registry[Expressir::Model::Declarations::Entity]).to include(
      :attributes, :derived_attributes, :inverse_attributes, :where_rules, :remark_items
    )
    expect(registry[Expressir::Model::Declarations::Function]).to include(
      :parameters, :types, :constants, :variables, :statements, :remark_items
    )
    expect(registry[Expressir::Model::Declarations::Procedure]).to include(
      :parameters, :types, :constants, :variables, :statements, :remark_items
    )
    expect(registry[Expressir::Model::Declarations::Rule]).to include(
      :applies_to, :types, :constants, :variables, :statements, :where_rules, :remark_items
    )
    expect(registry[Expressir::Model::Declarations::Type]).to include(
      :where_rules, :informal_propositions, :remark_items
    )
    expect(registry[Expressir::Model::ExpFile]).to eq(%i[schemas])
    expect(registry[Expressir::Model::Statements::Compound]).to eq(%i[statements])
    expect(registry[Expressir::Model::Statements::If]).to eq(%i[statements])
    expect(registry[Expressir::Model::Statements::Alias]).to eq(%i[statements])
    expect(registry[Expressir::Model::Statements::Repeat]).to eq(%i[statements])
  end

  it "NodePositionIndex::COLLECTION_REGISTRY references the same hash" do
    expect(Expressir::Express::NodePositionIndex::COLLECTION_REGISTRY).to be(
      Expressir::Model::ModelElement.collection_registry
    )
  end

  it "adding a new collection_attributes declaration updates the registry live" do
    klass = Class.new(Expressir::Model::ModelElement) do
      collection_attributes :foo, :bar
    end

    expect(Expressir::Model::ModelElement.collection_registry[klass]).to eq(%i[foo bar])
    expect(klass.collection_attributes_list).to eq(%i[foo bar])
  end

  it "unregistered classes return empty list" do
    klass = Class.new(Expressir::Model::ModelElement)
    expect(klass.collection_attributes_list).to eq([])
  end
end
