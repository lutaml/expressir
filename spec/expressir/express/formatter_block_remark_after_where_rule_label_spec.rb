# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A `(* block *)` comment right after the label of a WHERE rule is written
# back after the label, with the expression on the next line, as the `--`
# comment of the same place is. The attacher decided "the comment follows
# code on its line" from the text `--` alone, so a block comment was held by
# no node that writes it.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "a block comment after the label of a WHERE rule" do
    let(:sources) do
      {
        probe: <<~EXP,
          SCHEMA label_probe;
          ENTITY part;
            size : INTEGER;
          WHERE
            wr1 : (* H1 a block after the label *) size > 0;
            wr2 : (* H2 a block of two lines
                     after the label *)
                  size < 100;
            wr3 : size <> 50 (* H3 a block before the semicolon *);
            wr4 : -- H4 a line comment after the label
                  size <> 60;
          END_ENTITY;
          TYPE positive = INTEGER;
          WHERE
            wr1 : (* H5 a block after the label of a type rule *) SELF > 0;
          END_TYPE;
          RULE r FOR (part);
          WHERE
            wr1 : (* H6 a block after the label of a rule *) TRUE;
          END_RULE;
          END_SCHEMA;
        EXP
        one_line: <<~EXP,
          SCHEMA one;
          ENTITY part;
            size : INTEGER;
          WHERE
            wr1 : (* H1 *) size > 0;
            wr4 : -- H4
                  size <> 60;
          END_ENTITY;
          TYPE positive = INTEGER;
          WHERE
            wr1 : (* H5 *) SELF > 0;
          END_TYPE;
          RULE r FOR (part);
          WHERE
            wr1 : (* H6 *) TRUE;
          END_RULE;
          END_SCHEMA;
        EXP
        more: <<~EXP,
          SCHEMA more_probe;
          ENTITY part;
            size : INTEGER;
          WHERE
            wr1 : (* a1 *) (* a2 *) size > 0;
            wr2 : (* b1 *) -- b2
                  size > 1;
            wr3 : (* c1 : ; -- (* nested *) tail *) size > 2;
            wr6 : (* e1 *) size > 6; -- e2
          END_ENTITY;
          END_SCHEMA;
        EXP
        pinned: <<~EXP,
          SCHEMA pinned_probe;
          ENTITY part;
            size : INTEGER;
            ur : INTEGER;
          DERIVE
            d : INTEGER := (* d1 *) 1;
          UNIQUE
            ur1 : size;
          WHERE
            wr4 :
              (* n1 next line *)
              size > 3;
            wr5 : (size > 4) (* m1 *) AND (size < 9);
          END_ENTITY;
          TYPE unl = INTEGER;
          WHERE
            SELF > 5;
          END_TYPE;
          END_SCHEMA;
        EXP
      }
    end

    let(:expected) do
      {
        probe: <<~EXP,
          SCHEMA label_probe;

          ENTITY part;
            size : INTEGER;
          WHERE
            wr1: (* H1 a block after the label *)
              size > 0;
            wr2: (*
            H2 a block of two lines
                       after the label
            *)
              size < 100;
            wr3: size <> 50;
            wr4: -- H4 a line comment after the label
              size <> 60;
          END_ENTITY;

          TYPE positive = INTEGER;
          WHERE
            wr1: (* H5 a block after the label of a type rule *)
              SELF > 0;
          END_TYPE;

          RULE r FOR (part);
          WHERE
            wr1: (* H6 a block after the label of a rule *)
              TRUE;
          END_RULE;

          END_SCHEMA;
        EXP
        more: <<~EXP,
          SCHEMA more_probe;

          ENTITY part;
            size : INTEGER;
          WHERE
            wr1: (* a1 *) (* a2 *)
              size > 0;
            wr2: (* b1 *) -- b2
              size > 1;
            wr3: (* c1 : ; -- (* nested *) tail *)
              size > 2;
            wr6: (* e1 *)
              size > 6; -- e2
          END_ENTITY;

          END_SCHEMA;
        EXP
        pinned: <<~EXP,
          SCHEMA pinned_probe;

          ENTITY part;
            size : INTEGER;
            ur : INTEGER;
          DERIVE
            d : INTEGER := 1; (* d1 *)
          UNIQUE
            ur1: size;
          WHERE
            wr4: size > 3;
            wr5: (size > 4) AND (size < 9);
          END_ENTITY;

          TYPE unl = INTEGER;
          WHERE
            SELF > 5;
          END_TYPE;

          END_SCHEMA;
        EXP
      }
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["where_label_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        it "writes each comment after the label of its rule" do
          expect(parse.call(sources[:probe]).format).to eq(expected[:probe])
        end

        it "writes the same text again from its own output" do
          once = parse.call(sources[:one_line]).format
          expect(parse.call(once).format).to eq(once)
          expect(once).to include("wr1: (* H1 *)\n    size > 0;")
          expect(once).to include("wr1: (* H6 *)\n    TRUE;")
        end

        it "writes none of them in the stripped form" do
          stripped = parse.call(sources[:probe]).schemas.first.format(no_remarks: true)
          expect(stripped).not_to include("(*")
          expect(stripped).not_to include("--")
        end

        it "holds each of them on its rule, inline, with the opener region" do
          schema = parse.call(sources[:probe]).schemas.first
          rules = [
            schema.entities.first.where_rules[0],
            schema.entities.first.where_rules[1],
            schema.entities.first.where_rules[3],
            schema.types.first.where_rules[0],
            schema.rules.first.where_rules[0],
          ]
          expect(rules.map { |r| r.untagged_remarks.map { |x| [x.placement, x.region] } })
            .to eq(Array.new(5) { [%w[inline opener]] })
        end

        it "keeps several comments, a block and a line comment, and odd text after the label" do
          expect(parse.call(sources[:more]).format).to eq(expected[:more])
        end

        # Offsets are bytes: text with accents before the comment does not
        # move it.
        it "finds the comment after text with accents" do
          text = "SCHEMA u;\n(* é ü schéma *)\nENTITY part;\n  size : INTEGER;\nWHERE\n  " \
                 "wr1 : (* é why ü *) size > 0;\nEND_ENTITY;\nEND_SCHEMA;\n"
          expect(parse.call(text).format).to include("wr1: (* é why ü *)\n    size > 0;")
        end

        # H3 (a block between the expression and the `;`), a block on the
        # line after the label, in the middle of an expression, and on a
        # DERIVE line are not part of this change.
        it "writes the neighbouring places as before" do
          expect(parse.call(sources[:pinned]).format).to eq(expected[:pinned])
        end
      end
    end
  end
end
