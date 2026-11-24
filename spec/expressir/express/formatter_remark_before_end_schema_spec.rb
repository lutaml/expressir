# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own after the last declaration of a schema and
# before END_SCHEMA is written back before END_SCHEMA. Before, the schema
# held it without a placement: a `--` comment was written after END_SCHEMA
# and a block comment at the top of the schema.
RSpec.describe Expressir::Express::Formatter do
  lanes = {
    "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
    "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    "from_file" => lambda do |text|
      Tempfile.create(["end_probe", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end,
  }

  last_declarations = {
    "a FUNCTION" => "FUNCTION f : INTEGER;\n  RETURN (1);\nEND_FUNCTION;\n",
    "an ENTITY" => "ENTITY e;\n  x : INTEGER;\nEND_ENTITY;\n",
    "a RULE" => "ENTITY e;\nEND_ENTITY;\nRULE r FOR (e);\nWHERE\n  wr1 : TRUE;\nEND_RULE;\n",
    "a TYPE" => "TYPE t = INTEGER;\nEND_TYPE;\n",
    "a CONSTANT block" => "CONSTANT\n  c : INTEGER := 1;\nEND_CONSTANT;\n",
    "a USE FROM clause" => "USE FROM other_schema;\n",
  }.freeze

  lanes.each do |lane, parse|
    context "with a file read by #{lane}" do
      let(:source) do
        <<~EXP
          SCHEMA end_probe;
          ENTITY a;
          END_ENTITY;
          -- D1 on its own line before the end of the schema
          (* D2 a block on its own line before the end of the schema *)
          END_SCHEMA; -- D3 after the end of the schema on its line
        EXP
      end

      let(:expected) do
        <<~EXP
          SCHEMA end_probe;

          ENTITY a;
          END_ENTITY;

          -- D1 on its own line before the end of the schema
          (* D2 a block on its own line before the end of the schema *)
          END_SCHEMA; -- D3 after the end of the schema on its line
        EXP
      end

      let(:file) { parse.call(source) }
      let(:schema) { file.schemas.first }

      it "writes both comments directly before END_SCHEMA, in source order" do
        expect(file.format).to eq(expected)
      end

      it "writes the same text from the schema" do
        expect(schema.format).to eq(expected.chomp)
      end

      it "writes the same text again from its own output" do
        once = file.format
        expect(parse.call(once).format).to eq(once)
      end

      it "writes no comment in the stripped form" do
        expect(schema.format(no_remarks: true)).to eq("SCHEMA end_probe;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA;")
      end

      it "writes both comments in the plain form" do
        expect(schema.format(no_remarks: true, keep_untagged_remarks: true)).to eq(expected.chomp)
      end

      it "holds D1 and D2 on the schema as trailing remarks of its declarations" do
        held = schema.untagged_remarks.map { |r| [r.text[0, 2], r.placement, r.region] }
        expect(held).to eq(
          [["D1", "trailing", "declarations"], ["D2", "trailing", "declarations"], ["D3", nil, nil]],
        )
      end

      it "writes them in the pretty form, the hyperlink form and not in the schema head" do
        pretty = Expressir::Express::PrettyFormatter.new.format(schema)
        expect(pretty).to eq(expected.chomp)
        hyperlink = Class.new(Expressir::Express::Formatter) { include Expressir::Express::HyperlinkFormatter }
        expect(hyperlink.new.format(schema)).to eq(expected.chomp)
        head = Class.new(Expressir::Express::Formatter) { include Expressir::Express::SchemaHeadFormatter }
        expect(head.new.format(schema)).to eq("SCHEMA end_probe;")
      end
    end

    context "with other placements, read by #{lane}" do
      def format_of(parse, text)
        parse.call(text).format
      end

      it "leaves a comment after END_SCHEMA on its line where it was" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\nEND_SCHEMA; -- D3 inline\n"
        file = parse.call(text)
        expect(file.format).to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA; -- D3 inline\n")
        expect(file.schemas.first.format(no_remarks: true, keep_untagged_remarks: true))
          .to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA; -- D3 inline")
        expect(file.schemas.first.untagged_remarks.map { |r| [r.placement, r.region] }).to eq([[nil, nil]])
      end

      it "leaves a comment on a line after END_SCHEMA where it was" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\nEND_SCHEMA;\n-- D3 own line\n"
        file = parse.call(text)
        expect(file.format).to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA;\n")
        expect(file.schemas.first.format(no_remarks: true, keep_untagged_remarks: true))
          .to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA;")
      end

      it "leaves a comment right after the SCHEMA line where it was" do
        text = "SCHEMA s;\n-- after head\nENTITY a;\nEND_ENTITY;\nEND_SCHEMA;\n"
        expect(format_of(parse, text))
          .to eq("SCHEMA s;\n\n-- after head\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA;\n")
      end

      it "leaves a comment between two declarations where it was" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\n-- between\nENTITY b;\nEND_ENTITY;\nEND_SCHEMA;\n"
        expect(format_of(parse, text))
          .to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\n-- between\nENTITY b;\nEND_ENTITY;\n\nEND_SCHEMA;\n")
      end

      it "writes a comment of an empty schema before END_SCHEMA" do
        text = "SCHEMA s;\n-- nothing yet\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(file.format).to eq("SCHEMA s;\n\n-- nothing yet\nEND_SCHEMA;\n")
        expect(file.schemas.first.untagged_remarks.map { |r| [r.placement, r.region] })
          .to eq([%w[trailing declarations]])
      end

      last_declarations.each do |what, last|
        it "writes the comment before END_SCHEMA when the last declaration is #{what}" do
          text = "SCHEMA s;\n#{last}-- closing note\nEND_SCHEMA;\n"
          out = format_of(parse, text)
          expect(out).to end_with("\n-- closing note\nEND_SCHEMA;\n")
          expect(out.scan("closing note").length).to eq(1)
          expect(format_of(parse, out)).to eq(out)
        end
      end

      it "gives each of two schemas in one file its own comment" do
        text = "SCHEMA one;\nENTITY a;\nEND_ENTITY;\n-- of one\nEND_SCHEMA;\n" \
               "SCHEMA two;\nENTITY b;\nEND_ENTITY;\n-- of two\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(file.schemas.map { |s| s.untagged_remarks.map(&:text) }).to eq([["of one"], ["of two"]])
        expect(file.schemas.map(&:format)).to eq(
          ["SCHEMA one;\n\nENTITY a;\nEND_ENTITY;\n\n-- of one\nEND_SCHEMA;",
           "SCHEMA two;\n\nENTITY b;\nEND_ENTITY;\n\n-- of two\nEND_SCHEMA;"],
        )
      end

      it "keeps several comments in a row, blank lines between them and the keyword included" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\n-- one\n\n  -- two\n(* three *)\n\nEND_SCHEMA;\n"
        expect(format_of(parse, text))
          .to eq("SCHEMA s;\n\nENTITY a;\nEND_ENTITY;\n\n-- one\n-- two\n(* three *)\nEND_SCHEMA;\n")
      end

      it "reads a lower-case end_schema" do
        # A line comes first: the native reader drops a lower-case `schema`
        # that starts at byte 0 (not part of this change).
        text = "\nschema s;\nentity a;\nend_entity;\n-- note\nend_schema;\n"
        expect(format_of(parse, text)).to include("-- note\nEND_SCHEMA;")
      end

      it "reads a block comment of several lines that names END_SCHEMA" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\n(* first line\nEND_SCHEMA is the next line\n*)\nEND_SCHEMA;\n"
        out = format_of(parse, text)
        expect(out).to end_with("\nEND_SCHEMA;\n")
        expect(out.index("first line")).to be < out.rindex("END_SCHEMA;")
        expect(out.scan("first line").length).to eq(1)
      end

      it "does not take a tagged remark" do
        text = "SCHEMA s;\nENTITY a;\nEND_ENTITY;\n(*\"s.a\" A description. *)\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(file.schemas.first.untagged_remarks.to_a).to be_empty
      end
    end
  end
end
