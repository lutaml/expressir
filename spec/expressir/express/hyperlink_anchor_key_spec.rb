# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/expressir/express/parser"
require_relative "../../../lib/expressir/express/formatter"
require_relative "../../../lib/expressir/express/hyperlink_formatter"

RSpec.describe Expressir::Express::Formatter do
  # issue #786: the express: link key carried the file-path prefix
  # (`a_schema.exp.a_schema.thing`) while the anchor namespace on the
  # document pages keys on schema.item (`a_schema.thing`) — no listing
  # link found its target. The link sheds the file part: the `.exp.`
  # boundary splits the file id (the path rides as the file's id,
  # model/exp_file) from the anchor key, matching the WG 12 template
  # strip (`replace_regex: "<<express:[^,>]+\.exp\.", "<<express:"`)
  # and handling nested items (schema.entity.attr) and absolute paths.
  describe "express: link anchor key (#786)" do
    let(:repo) do
      Expressir::Express::Parser.from_files(
        [
          Expressir.root_path.join("spec", "syntax", "issue_786_a.exp"),
          Expressir.root_path.join("spec", "syntax", "issue_786_b.exp"),
        ],
      )
    end

    let(:formatter) do
      Class.new(Expressir::Express::Formatter) do
        include Expressir::Express::HyperlinkFormatter
      end
    end

    it "writes the interface item's source without the file prefix" do
      schema_b = repo.schemas.find { |s| s.id == "b_schema" }

      expect(formatter.format(schema_b.interfaces.first))
        .to include("{{{<<express:a_schema.thing,thing>>}}}")
      expect(formatter.format(schema_b.interfaces.first))
        .not_to include(".exp.")
    end

    it "writes the subtype source without the file prefix" do
      schema_b = repo.schemas.find { |s| s.id == "b_schema" }
      entity = schema_b.entities.find { |e| e.id == "special_thing" }

      expect(formatter.format(entity))
        .to include("{{{<<express:a_schema.thing,thing>>}}}")
      expect(formatter.format(entity))
        .not_to include(".exp.")
    end

    it "keeps the same-schema reference unlinked" do
      schema_a = repo.schemas.find { |s| s.id == "a_schema" }

      expect(formatter.format(schema_a.entities.first))
        .not_to include("{{{<<express:")
    end
  end
end
