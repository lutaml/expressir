# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A `(* *)` comment that stands at the start of a line, before the USE FROM
# or REFERENCE FROM clause that begins on the same line, leads that clause,
# as an own-line comment above the clause already does. Before, a clause
# with a `--` comment at the end of its line made the remark read as a
# trailing one, and the clause on its own line it shares made the scope
# lookup see that clause as the scope of the remark: the remark kept no
# placement and was written after the last clause.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "a block comment at the start of a line of an interface clause" do
    let(:source) do
      <<~EXP
        SCHEMA clause_block_probe;
        (* a *) USE FROM first_schema; -- one
        USE FROM second_schema; -- two
        (* b *) REFERENCE FROM third_schema (c); -- three
        (* d *) USE FROM fourth_schema;
        (* e *) (* f *) USE FROM fifth_schema;
        (* g *)
        USE FROM sixth_schema;
        -- h
        USE FROM seventh_schema;
        ENTITY part;
          size : INTEGER;
        END_ENTITY;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA clause_block_probe;

        (* a *)
        USE FROM first_schema; -- one

        USE FROM second_schema; -- two

        (* b *)
        REFERENCE FROM third_schema
          (c); -- three

        (* d *)
        USE FROM fourth_schema;

        (* e *)
        (* f *)
        USE FROM fifth_schema;

        (* g *)
        USE FROM sixth_schema;

        -- h
        USE FROM seventh_schema;

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
        Tempfile.create(["clause_block_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes each comment before the clause it led" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "holds the comment on the clause with the leading placement" do
          held = file.schemas.first.interfaces.map do |interface|
            interface.untagged_remarks.map { |r| [r.text.strip, r.placement] }
          end
          expect(held.first(7)).to eq(
            [
              [["a", "leading"], ["one", "inline"]],
              [["two", "inline"]],
              [["b", "leading"], ["three", "inline"]],
              [["d", "leading"]],
              [["e", "leading"], ["f", "leading"]],
              [["g", "leading"]],
              [["h", "leading"]],
            ],
          )
          expect(file.schemas.first.untagged_remarks).to be_empty
        end

        # `(* c *)` follows the schema name, so it does not start the line.
        it "leaves a block comment inside the clause as it was" do
          text = "SCHEMA s;\nUSE FROM x (* c *) ( -- d\n  a);\nEND_SCHEMA;\n"
          expect(parse.call(text).format).to eq("SCHEMA s;\n\nUSE FROM x (* c *) -- d\n  (a);\nEND_SCHEMA;\n")
        end

        it "writes no comment in the stripped form" do
          stripped = file.schemas.first.format(no_remarks: true)
          expect(stripped).not_to include("(*")
          expect(stripped).not_to include("--")
          expect(stripped).to include("USE FROM first_schema;\n\nUSE FROM second_schema;")
        end
      end
    end
  end
end
