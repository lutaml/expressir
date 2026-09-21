# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Model::Indexes::ItemGraph do
  let(:files) do
    %w[syntax multiple].map { |stem| File.expand_path("../../../syntax/#{stem}.exp", __dir__) }
  end

  let(:repository) { Expressir::Express::Parser.from_files(files) }
  let(:graph) { described_class.new(repository) }

  it "indexes entities and types from every schema" do
    expect(graph.nodes.size).to be > 10
    expect(graph.nodes.keys).to all(match(/\A[^.]+\.[^.]+\z/))
  end

  it "records subtype edges and computes transitive closures" do
    expect(graph.subtype_edges.size).to be > 1
    any_child = graph.subtype_edges.sample.first
    closure = graph.supertypes(any_child)
    closure.each { |p| expect(graph.include?(p)).to be(true) }
  end

  it "records interface dependencies between schemas" do
    deps = graph.dependencies.flatten(1).uniq
    expect(deps.size).to be >= 1
  end
end
