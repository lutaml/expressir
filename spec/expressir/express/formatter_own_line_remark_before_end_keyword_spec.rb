# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own before END_ENTITY or END_TYPE is written
# back before that keyword. Before, the closing-keyword table had no entry
# for the two keywords: the declaration held such a remark unplaced, and it
# was written after the keyword.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "a comment on its own line before END_ENTITY or END_TYPE" do
    let(:source) do
      <<~EXP
        SCHEMA before_end;
        ENTITY attrs;
          a : INTEGER;
          b : INTEGER;
          -- after the last attribute
        END_ENTITY;
        ENTITY two;
          a : INTEGER;
          -- first of two
          -- second of two
        END_ENTITY;
        ENTITY derived;
          a : INTEGER;
        DERIVE
          d : INTEGER := a + 1;
          -- after the last derived attribute
        END_ENTITY;
        ENTITY uniq;
          a : INTEGER;
        UNIQUE
          ur1 : a;
          -- after the last unique rule
        END_ENTITY;
        ENTITY rules;
          a : INTEGER;
        WHERE
          wr1 : a > 0;
          -- after the last rule
        END_ENTITY;
        ENTITY block;
          a : INTEGER;
          (* a block comment *)
        END_ENTITY;
        ENTITY empty;
          -- nothing declared yet
        END_ENTITY;
        TYPE colour = ENUMERATION OF
          (red,
           green);
          -- after the list of items
        END_TYPE;
        TYPE positive = REAL;
        WHERE
          wr1 : SELF > 0;
          -- after the last rule of a type
        END_TYPE;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA before_end;

        ENTITY attrs;
          a : INTEGER;
          b : INTEGER;
          -- after the last attribute
        END_ENTITY;

        ENTITY two;
          a : INTEGER;
          -- first of two
          -- second of two
        END_ENTITY;

        ENTITY derived;
          a : INTEGER;
        DERIVE
          d : INTEGER := a + 1;
          -- after the last derived attribute
        END_ENTITY;

        ENTITY uniq;
          a : INTEGER;
        UNIQUE
          ur1: a;
          -- after the last unique rule
        END_ENTITY;

        ENTITY rules;
          a : INTEGER;
        WHERE
          wr1: a > 0;
          -- after the last rule
        END_ENTITY;

        ENTITY block;
          a : INTEGER;
          (* a block comment *)
        END_ENTITY;

        ENTITY empty;
          -- nothing declared yet
        END_ENTITY;

        TYPE colour = ENUMERATION OF
          (red,
           green);
          -- after the list of items
        END_TYPE;

        TYPE positive = REAL;
        WHERE
          wr1: SELF > 0;
          -- after the last rule of a type
        END_TYPE;

        END_SCHEMA;
      EXP
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["before_end", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes each comment before the keyword it precedes" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "places the comments as trailing, in the last body of the declaration" do
          schema = file.schemas.first
          closing_attributes = %w[trailing attributes]
          placed = ->(node) { node.untagged_remarks.map { |r| [r.placement, r.region] } }
          expect(placed.call(schema.entities[0])).to eq([closing_attributes])
          expect(placed.call(schema.entities[1])).to eq([closing_attributes, closing_attributes])
          expect(placed.call(schema.entities[4])).to eq([%w[trailing where_rules]])
          expect(placed.call(schema.types[0])).to eq([%w[trailing underlying_type]])
          expect(placed.call(schema.types[1])).to eq([%w[trailing where_rules]])
        end

        it "leaves a comment at the end of a code line with its holder" do
          text = <<~EXP
            SCHEMA s;
            ENTITY e;
              a : INTEGER; -- of the attribute
            WHERE
              wr1 : a > 0; -- of the rule
            END_ENTITY; -- of the entity
            ENTITY f;
              a : INTEGER;
            WHERE
              wr1 : a > 0; (* of the rule *)
            END_ENTITY;
            END_SCHEMA;
          EXP
          entities = parse.call(text).schemas.first.entities
          expect(entities[0].untagged_remarks.map(&:text)).to eq(["of the entity"])
          expect(entities[0].untagged_remarks.first.placement).to be_nil
          expect(entities[0].where_rules.first.untagged_remarks.map(&:text)).to eq(["of the rule"])
          expect(Array(entities[1].untagged_remarks).map(&:placement)).not_to include("trailing")
        end

        it "writes none of them in the stripped form" do
          stripped = file.schemas.first.format(no_remarks: true)
          expect(stripped).not_to include("--")
          expect(stripped).not_to include("(*")
        end

        it "writes them in the plain form" do
          plain = file.schemas.first.format(no_remarks: true, keep_untagged_remarks: true)
          expect(plain).to eq(expected.chomp)
        end
      end
    end

    it "writes them before END_ENTITY in the pretty form" do
      text = <<~EXP
        SCHEMA s;
        ENTITY e;
          a : INTEGER;
          -- after the last attribute
        END_ENTITY;
        END_SCHEMA;
      EXP
      pretty = Expressir::Express::PrettyFormatter.new.format(Expressir::Express::Parser.from_exp(text))
      expect(pretty).to match(/a : INTEGER;\n\s+-- after the last attribute\n\s*END_ENTITY;\n/)
    end
  end
end
