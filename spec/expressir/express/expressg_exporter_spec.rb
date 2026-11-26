# frozen_string_literal: true

require "spec_helper"
require "json"
require "tmpdir"

RSpec.describe Expressir::Express::ExpressgExporter do
  let(:repo) do
    Expressir::Express::Parser.from_exp(<<~EXP)
      SCHEMA demo;
      TYPE status_select = SELECT (base, person); END_TYPE;
      TYPE color = ENUMERATION OF (red, green); END_TYPE;
      ENTITY base;
        id : STRING;
      END_ENTITY;
      ENTITY person
        SUBTYPE OF (base);
        name : OPTIONAL STRING;
        roles : SET [1:?] OF status_select;
        DERIVE
          age : INTEGER := 21;
        INVERSE
          org : base FOR person;
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  let(:schema) { repo.schemas.first }
  let(:document) { described_class.new(schema).export }
  let(:graph) { document["graph"] }
  let(:node_ids) { graph["children"].map { |n| n["id"] } }

  it "emits a DIM 0.1 document in the express-g notation" do
    expect(document["dim"]).to eq("0.1")
    expect(document["notation"]).to eq("express-g")
    expect(graph["id"]).to eq("schema-demo")
    expect(graph["layoutOptions"]).to include("elk.algorithm" => "layered")
  end

  it "draws entities and select types as nodes, not enumerations" do
    expect(node_ids).to contain_exactly(
      "entity-base", "entity-person", "type-status_select"
    )
  end

  it "carries every attribute as a member block with the OPTIONAL suffix" do
    person = graph["children"].find { |n| n["id"] == "entity-person" }
    members = person["content"].select { |c| c["role"] == "member" }.map { |c| c["text"] }

    expect(members).to contain_exactly(
      "name?: STRING",
      "roles: SET [1:?] OF status_select",
      "DERIVE age: INTEGER",
      "INVERSE org: base",
    )
  end

  it "marks entity and select nodes with their stereotypes" do
    graph["children"].each do |node|
      stereotype = node["content"].find { |c| c["role"] == "stereotype" }
      expected = node["id"].start_with?("entity-") ? "ENTITY" : "SELECT"
      expect(stereotype["text"]).to eq(expected)
    end
  end

  it "draws SUBTYPE OF as a generalization edge" do
    edge = graph["edges"].find { |e| e["style"] == "generalization" }
    expect(edge["sources"]).to eq(["entity-person"])
    expect(edge["targets"]).to eq(["entity-base"])
  end

  it "draws DERIVE as association and INVERSE as reference edges" do
    # age is INTEGER — no node targets it, so only the member carries it
    expect(graph["edges"].find { |e| e["id"].start_with?("derive-") }).to be_nil

    inverse = graph["edges"].find { |e| e["style"] == "reference" }
    expect(inverse["sources"]).to eq(["entity-person"])
    expect(inverse["targets"]).to eq(["entity-base"])
  end

  it "draws select membership as association edges to graph nodes" do
    edges = graph["edges"].select { |e| e["id"].start_with?("select-status_select-") }
    expect(edges.map { |e| e["targets"] }).to contain_exactly(
      ["entity-base"], ["entity-person"]
    )
    expect(edges.map { |e| e["style"] }.uniq).to eq(["association"])
  end

  it "never draws an edge to a missing node" do
    graph["edges"].each do |edge|
      edge["sources"].each { |s| expect(node_ids).to include(s) }
      edge["targets"].each { |t| expect(node_ids).to include(t) }
    end
  end

  it "pins the golden document" do
    expected = {
      "dim" => "0.1",
      "notation" => "express-g",
      "graph" => {
        "id" => "schema-demo",
        "layoutOptions" => { "elk.algorithm" => "layered", "elk.direction" => "DOWN" },
        "children" => [
          {
            "id" => "entity-base", "width" => 220, "height" => 24 + (22 * 3),
            "content" => [
              { "kind" => "label", "text" => "base", "role" => "title" },
              { "kind" => "label", "text" => "ENTITY", "role" => "stereotype" },
              { "kind" => "label", "text" => "id: STRING", "role" => "member" },
            ]
          },
          {
            "id" => "entity-person", "width" => 220, "height" => 24 + (22 * 6),
            "content" => [
              { "kind" => "label", "text" => "person", "role" => "title" },
              { "kind" => "label", "text" => "ENTITY", "role" => "stereotype" },
              { "kind" => "label", "text" => "name?: STRING", "role" => "member" },
              { "kind" => "label", "text" => "roles: SET [1:?] OF status_select", "role" => "member" },
              { "kind" => "label", "text" => "DERIVE age: INTEGER", "role" => "member" },
              { "kind" => "label", "text" => "INVERSE org: base", "role" => "member" },
            ]
          },
          {
            "id" => "type-status_select", "width" => 220, "height" => 24 + (22 * 4),
            "content" => [
              { "kind" => "label", "text" => "status_select", "role" => "title" },
              { "kind" => "label", "text" => "SELECT", "role" => "stereotype" },
              { "kind" => "label", "text" => "base", "role" => "member" },
              { "kind" => "label", "text" => "person", "role" => "member" },
            ]
          },
        ],
        "edges" => [
          { "id" => "subtype-person-0", "sources" => ["entity-person"],
            "targets" => ["entity-base"], "style" => "generalization" },
          { "id" => "inverse-person-org", "sources" => ["entity-person"],
            "targets" => ["entity-base"], "style" => "reference" },
          { "id" => "select-status_select-base", "sources" => ["type-status_select"],
            "targets" => ["entity-base"], "style" => "association" },
          { "id" => "select-status_select-person", "sources" => ["type-status_select"],
            "targets" => ["entity-person"], "style" => "association" },
        ],
      },
    }
    expect(document).to eq(expected)
  end

  it "conforms to dim-0.1.schema.json" do
    begin
      require "json_schemer"
    rescue LoadError
      skip "json_schemer not available"
    end
    schema_path = ENV["DIM_SCHEMA"] ||
      File.expand_path("../../../../../etassia/docs/dim/dim-0.1.schema.json", __dir__)
    skip "dim-0.1.schema.json not available" unless File.exist?(schema_path)

    schemer = JSONSchemer.schema(File.read(schema_path))
    errors = schemer.validate(document).to_a
    expect(errors).to be_empty, errors.map { |e| e["error"] }.join("\n")
  end

  it "renders through Etassia::Native.render_dim" do
    begin
      require "etassia"
    rescue LoadError
      skip "etassia not available"
    end
    skip "etassia not available" unless defined?(Etassia::Native)

    Dir.mktmpdir("expressg-dim") do |dir|
      path = File.join(dir, "demo-dim.json")
      File.write(path, described_class.new(schema).export_json)
      output = Etassia::Native.render_dim(File.read(path))
      expect(output).to be_present
    end
  end
end
