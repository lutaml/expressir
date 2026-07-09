# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Express::RemarkAttacher do
  describe "integration tests with real parsing" do
    let(:exp_file) do
      Expressir.root_path.join("spec", "fixtures", "validate_ascii",
                               "non_ascii_in_remarks_only.exp")
    end
    let(:repo) { Expressir::Express::Parser.from_file(exp_file) }
    let(:schema) { repo.schemas.first }
    let(:entity) { schema.entities.first }

    it "preserves tail remarks on entity attributes" do
      expect(entity.id).to eq("person")

      name_attr = entity.attributes.find { |a| a.id == "name" }
      expect(name_attr).not_to be_nil

      name_remark_texts = name_attr.untagged_remarks.map do |r|
        r.is_a?(Expressir::Model::RemarkInfo) ? r.text : r
      end
      expect(name_remark_texts).to include("Name in Japanese: 名前")

      entity_remarks = entity.untagged_remarks || []
      entity_remark_texts = entity_remarks.map do |r|
        r.is_a?(Expressir::Model::RemarkInfo) ? r.text : r
      end
      expect(entity_remark_texts).not_to include("Name in Japanese: 名前")
    end
  end

  describe "attach" do
    it "attaches file-level preamble remarks to ExpFile" do
      source = <<~EXP
        SCHEMA test_schema;
        -- Schema level remark
        ENTITY test_entity;
        END_ENTITY;
        END_SCHEMA;
      EXP

      exp_file = Expressir::Express::Parser.from_exp(source)

      expect(exp_file).to be_a(Expressir::Model::ExpFile)
      expect(exp_file.untagged_remarks).not_to be_empty
    end

    it "does not attach spurious tail remarks from inside documentation blocks" do
      # Regression guard for issue #308: an inline `--` inside an embedded
      # remark must not be split off as a tail remark.
      source = <<~EXP
        SCHEMA mini_schema;
        (*
        This schema provides representations for items a) -- d). that are mandatory in any application.

        [NOTE]
        --
        Scenarios of the expected use are described in the introduction.
        --
        *)
        END_SCHEMA;
      EXP

      exp_file = Expressir::Express::Parser.from_exp(source)
      schema = exp_file.schemas.first

      attached_texts = [exp_file, schema].flat_map do |node|
        (node.untagged_remarks || []).map(&:text)
      end + (schema.remarks || [])

      # No spurious tail remark was split off after the inline `--`.
      expect(attached_texts).not_to include(
        a_string_starting_with("d). that are mandatory"),
      )
      expect(attached_texts).not_to include("")
    end
  end

  describe "scanner integration" do
    # These specs cover the scanner↔attacher contract via the public
    # RemarkScanner interface, replacing the previous private-method probes
    # (send(:extract_all_remarks), instance_variable_get(:@line_cache)) which
    # violated encapsulation.

    it "extracts tail, embedded, and tagged remarks in source order" do
      source = <<~EXP
        SCHEMA test;
        -- plain tail remark
        --"WR1" tagged tail remark
        -- IP1: informal proposition tail
        (* embedded remark *)
        ENTITY foo;
        END_ENTITY;
        END_SCHEMA;
      EXP

      remarks = Expressir::Express::RemarkScanner.new(source).scan

      expect(remarks.map(&:format)).to eq(%w[tail tail tail embedded])
      expect(remarks[0].text).to eq("plain tail remark")
      expect(remarks[1].tag).to eq("WR1")
      expect(remarks[2].tag).to eq("IP1")
      expect(remarks[2].text).to eq("informal proposition tail")
      expect(remarks[3].text).to eq("embedded remark")
    end
  end
end
