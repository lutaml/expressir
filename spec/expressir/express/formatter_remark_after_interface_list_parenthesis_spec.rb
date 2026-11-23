# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A `--` comment after the opening parenthesis of the item list of a
# USE FROM / REFERENCE FROM clause is written back after that parenthesis.
# Before, it had the opener region, the same as a comment before the
# parenthesis, and both were written before the parenthesis.
RSpec.describe Expressir::Express::Formatter do
  describe "a comment after the opening parenthesis of an interface item list" do
    let(:source) do
      <<~EXP
        SCHEMA interface_probe;
        REFERENCE FROM first_schema ( -- after the parenthesis
          a,
          b);
        USE FROM second_schema ( -- after the parenthesis of USE
          c AS d);
        REFERENCE FROM third_schema -- before the parenthesis
          (e,
           f);
        USE FROM fourth_schema; -- after the clause
        REFERENCE FROM fifth_schema
          (g,
           h); -- after the list
        REFERENCE FROM sixth_schema (i); -- one line
        ENTITY part;
          size : INTEGER;
        END_ENTITY;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA interface_probe;

        REFERENCE FROM first_schema ( -- after the parenthesis
           a,
           b);

        USE FROM second_schema ( -- after the parenthesis of USE
           c AS d);

        REFERENCE FROM third_schema -- before the parenthesis
          (e,
           f);

        USE FROM fourth_schema; -- after the clause

        REFERENCE FROM fifth_schema
          (g,
           h); -- after the list

        REFERENCE FROM sixth_schema
          (i); -- one line

        ENTITY part;
          size : INTEGER;
        END_ENTITY;

        END_SCHEMA;
      EXP
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["interface_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes each comment on the side of the parenthesis it had" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "tells the two sides apart by the region" do
          placed = file.schemas.first.interfaces.map do |interface|
            interface.untagged_remarks.map { |r| [r.placement, r.region] }
          end
          expect(placed).to eq(
            [
              [%w[inline items]], [%w[inline items]], [%w[inline opener]],
              [["inline", nil]], [["inline", nil]], [["inline", nil]]
            ],
          )
        end

        it "keeps the opener region for a comment after an item on the first line" do
          text = "SCHEMA s;\nREFERENCE FROM t (a, -- after an item\n  b);\nEND_SCHEMA;\n"
          remark = parse.call(text).schemas.first.interfaces.first.untagged_remarks.first
          expect([remark.placement, remark.region]).to eq(%w[inline opener])
        end

        # `(* c *)` stands before the parenthesis and `-- d` after it. The
        # region is decided per line, so neither is moved.
        it "leaves a line with a block comment as well as it was" do
          text = "SCHEMA s;\nUSE FROM x (* c *) ( -- d\n  a);\nEND_SCHEMA;\n"
          parsed = parse.call(text)
          expect(parsed.schemas.first.interfaces.first.untagged_remarks.map(&:region)).to eq(%w[opener opener])
          once = parsed.format
          expect(once).to eq("SCHEMA s;\n\nUSE FROM x (* c *) -- d\n  (a);\nEND_SCHEMA;\n")
          expect(parse.call(once).format).to eq(once)
        end

        it "keeps the list on its own line in the stripped form" do
          stripped = file.schemas.first.format(no_remarks: true)
          expect(stripped).not_to include("--")
          expect(stripped).to include("REFERENCE FROM first_schema\n  (a,\n   b);")
        end
      end
    end
  end
end
