# frozen_string_literal: true

require "spec_helper"
require "expressir/tools/model_attr_table"
require "json"

# expressir#634 PR-2: the corpus must EXERCISE every wire class — the
# wire round-trip gates (both lanes + the rs corpus differential) can
# only prove classes they reach. The exceptions (STRUCTURAL_EXEMPTIONS
# below) are hydrate-only, attach-time, computed-on-demand, or
# grammar-ambiguity classes that a parsed tree cannot contain by design.
STRUCTURAL_EXEMPTIONS = [
  # Hydrate-only containers: never nodes in a parsed tree.
  "Expressir::Model::Cache",
  "Expressir::Model::ModelElement",
  "Expressir::Model::Repository",
  # Attach-time only: built by RemarkAttacher, not the parse.
  "Expressir::Model::RemarkInfo",
  # Computed on demand: Schema#interfaced_items derives InterfacedItem
  # from the interfaces during resolution; the tree stores InterfaceItem.
  "Expressir::Model::Declarations::InterfacedItem",
  # Grammar-ambiguity loser: `ref(params)` always matches functionCall
  # (ordered choice), so the parse never emits EntityConstructor; the
  # builder + formatter serve programmatic model construction.
  "Expressir::Model::Expressions::EntityConstructor",
].freeze

RSpec.describe Expressir::Tools::ModelAttrTable do
  let(:table) do
    JSON.parse(
      File.read(Expressir.root_path.join("spec/fixtures/model_attr_table.json")),
    )
  end

  def corpus_files
    Dir[Expressir.root_path.join("spec/fixtures/**/*.exp")] +
      Dir[Expressir.root_path.join("spec/syntax/*.exp")]
  end

  def exercised_classes
    seen = {}
    registry = Expressir::Model::ModelElement.collection_registry
    walk = lambda do |node, visited|
      return unless node.is_a?(Expressir::Model::ModelElement)
      return if visited.include?(node.object_id)

      visited << node.object_id
      seen[node.class.name] = true
      (table[node.class.name] || {}).each do |attr_name, meta|
        next unless meta["type"].to_s.start_with?("Expressir::Model::")

        value = begin
          node.public_send(attr_name)
        rescue StandardError
          next
        end
        Array(value).each { |c| walk.call(c, visited) }
      end
      (registry[node.class] || []).each do |attr|
        Array(node.public_send(attr)).each { |c| walk.call(c, visited) }
      end
    end
    corpus_files.each do |file|
      begin
        # Resolution ON: InterfacedItem and EntityConstructor are
        # resolution products (a USE-item rename fills Schema#interfaced_items;
        # a call whose target resolves to an entity becomes EntityConstructor).
        repo = Expressir::Express::Parser.from_file(
          file, root_path: Expressir.root_path
        )
      rescue Expressir::Express::Error::SchemaParseFailure
        # Unparseable-on-this-lane fixtures (e.g. the non-ASCII corpus)
        # belong to their own suites; coverage counts parsed files only.
        next
      end
      walk.call(repo, Set.new)
    end
    seen.keys
  end

  it "exercises every wire class except the structural four" do
    exercised = exercised_classes
    missing = (table.keys - STRUCTURAL_EXEMPTIONS) - exercised

    expect(missing).to eq([]),
                       "the corpus stopped exercising: #{missing.join(', ')}"
  end

  it "parses the coverage fixtures identically on both engines" do
    files = Dir[Expressir.root_path.join("spec/fixtures/class_coverage/*.exp")]
    files.each do |file|
      source = File.read(file)
      native = Expressir::Express::Parser.from_exp(source, use_native: true)
      fallback = Expressir::Express::Parser.from_exp(source, use_native: false)
      expect(native.to_hash).to eq(fallback.to_hash), file
    end
  end
end
