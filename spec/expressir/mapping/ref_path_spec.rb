# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Mapping::RefPath do
  def parse(content)
    described_class.parse(content)
  end

  def repo(source)
    Expressir::Express::Parser.from_exp(source)
  end

  def issues(content, repository)
    described_class.validate(parse(content), repository)
  end

  describe ".parse" do
    it "parses links, nodes, attributes, and repeats from a corpus path" do
      path = parse(<<~PATH)
        executed_action
        executed_action <= action
        action.chosen_method -> action_method
        action_method
      PATH

      aggregate_failures do
        expect(path.parse_errors).to be_empty
        expect(path.steps.map(&:operator)).to eq(
          [nil, nil, "<=", nil, "->", nil],
        )
        expect(path.steps.map(&:name)).to eq(
          %w[executed_action executed_action action action action_method
             action_method],
        )
        expect(path.steps[3].attribute).to eq("chosen_method")
      end
    end

    it "attaches aggregate indexes to the qualified node" do
      path = parse("action_resource.usage[1] -> x")
      node = path.steps[0]
      aggregate_failures do
        expect(node.name).to eq("action_resource")
        expect(node.attribute).to eq("usage")
        expect(node.index).to eq("1")
      end
    end

    it "attaches constraint literals to the preceding node" do
      path = parse("attribute_classification_assignment.attribute_name = 'name'")
      node = path.steps[0]
      aggregate_failures do
        expect(node.attribute).to eq("attribute_name")
        expect(node.literal).to eq("'name'")
      end
    end

    it "keeps brace and bracket markers as steps" do
      path = parse("{identification_assignment.role ->\nassigned_object}")
      aggregate_failures do
        expect(path.steps.map(&:operator)).to eq(["{", nil, "->", "}"])
        expect(path.steps[1].attribute).to eq("role")
      end
    end

    it "records a parse error for a constraint with nothing after it" do
      path = parse("entity.attr = ")
      expect(path.parse_errors).to include(/nothing after it/)
    end

    it "parses the parenthesized type-alternative form from the corpus" do
      path = parse(<<~PATH)
        global_unit_assigned_context.units[i] ->
        unit
        (unit = named_unit
        named_unit)
      PATH
      aggregate_failures do
        expect(path.parse_errors).to be_empty
        expect(path.steps.map(&:operator)).to include("=")
        expect(path.steps.find { |s| s.operator == "=" }.name).to eq("named_unit")
      end
    end

    it "keeps a pending link across /MAPPING_OF(X)/ wrappers" do
      path = parse("inspected_equivalence_element_select =\n/MAPPING_OF(geometric_model)/")
      aggregate_failures do
        expect(path.parse_errors).to be_empty
        target = path.steps.find { |s| s.operator == "=" }
        expect(target.name).to eq("geometric_model")
      end
    end

    it "parses the <- reverse reference link" do
      path = parse("! {<- name_attribute.named_item}")
      aggregate_failures do
        expect(path.parse_errors).to be_empty
        expect(path.steps.map(&:operator)).to eq(["!", "{", "<-", "}"])
        expect(path.steps[2].name).to eq("name_attribute")
      end
    end

    it "round-trips through the lutaml-model wire face" do
      path = parse("action.chosen_method -> action_method")
      json = path.to_json
      expect(described_class::Path.from_json(json).steps.map(&:name))
        .to eq(%w[action action_method])
    end
  end

  describe ".validate" do
    let(:repository) do
      repo(<<~EXP)
        SCHEMA test;
          ENTITY base;
            name : STRING;
          END_ENTITY;
          ENTITY sub
            SUBTYPE OF (base);
            ref : target;
          END_ENTITY;
          ENTITY target;
          END_ENTITY;
          ENTITY holder;
            items : ARRAY [1:3] OF target;
          END_ENTITY;
        END_SCHEMA;
      EXP
    end

    it "accepts a path whose nodes, attributes, and subtype links resolve" do
      expect(issues(<<~PATH, repository)).to be_empty
        sub
        sub <= base
        sub.ref -> target
      PATH
    end

    it "accepts an inherited attribute reference" do
      # `name` lives on base; sub inherits it through the subtype chain
      expect(issues("sub.name = 'x'", repository)).to be_empty
    end

    it "accepts an aggregate index over an aggregation attribute" do
      expect(issues("holder.items[i] -> target", repository)).to be_empty
    end

    it "flags an unknown node" do
      expect(issues("ghost <= base", repository).first.message)
        .to include("unknown type 'ghost'")
    end

    it "flags a false subtype link" do
      expect(issues("base <= sub", repository).first.message)
        .to include("'base' is not a subtype of 'sub'")
    end

    it "flags a false supertype link" do
      expect(issues("sub => base", repository).first.message)
        .to include("'sub' is not a supertype of 'base'")
    end

    it "flags a missing attribute" do
      expect(issues("sub.nothere -> target", repository).first.message)
        .to include("has no attribute 'nothere'")
    end

    it "flags an index over a non-aggregate attribute" do
      expect(issues("base.name[i] -> target", repository).first.message)
        .to include("is not an aggregate")
    end

    it "flags a link with no preceding node" do
      expect(issues("-> target", repository).first.message)
        .to include("no preceding node")
    end
  end

  describe "against the real corpus" do
    it "parses every refpath in the activity module without errors" do
      mapping = File.expand_path("~/src/mn/iso-10303/schemas/modules/activity/mapping.yaml",
                                 __dir__)
      skip "iso-10303 checkout not present" unless File.exist?(mapping)

      document = Expressir::Mapping.load_file(mapping)
      paths = Expressir::Mapping.refpaths(document)
      expect(paths).not_to be_empty
      bad = paths.filter_map do |location, content|
        parsed = parse(content)
        location if parsed.parse_errors.any?
      end
      expect(bad).to be_empty
    end
  end
end
