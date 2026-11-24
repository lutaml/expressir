# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own before DERIVE, INVERSE, UNIQUE or WHERE of
# an ENTITY (or the WHERE of a TYPE) is written back before that keyword.
# Before, the next member of the section held it, and it was written after
# the keyword.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  # The text the formatter writes for a source already in its style: the
  # source itself, with a blank line before each declaration and the end.
  def formatted(source)
    source.lines.each_with_object(+"") do |line, out|
      out << "\n" if line.match?(/\A(ENTITY|TYPE|RULE|FUNCTION) /) && !out.empty?
      out << "\n" if line.start_with?("END_SCHEMA;")
      out << line
    end
  end

  lanes = {
    "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
    "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    "from_file" => lambda do |text|
      Tempfile.create(["sections", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end,
  }

  def section_source
    <<~EXP
      SCHEMA sections;
      ENTITY part;
        size : INTEGER;
        -- before DERIVE
      DERIVE
        twice : INTEGER := size * 2;
        -- before INVERSE
      INVERSE
        used : SET OF holder FOR held;
        -- before UNIQUE
      UNIQUE
        ur1: size;
        -- before WHERE
      WHERE
        wr1: size > 0;
        -- before the end
      END_ENTITY;
      ENTITY holder;
        held : part;
      END_ENTITY;
      TYPE positive = REAL;
        -- before WHERE of a type
      WHERE
        wr1: SELF > 0;
        -- before the end of the type
      END_TYPE;
      END_SCHEMA;
    EXP
  end

  def closing_regions
    %w[attributes derived_attributes inverse_attributes unique_rules where_rules].map { |r| ["trailing", r] }
  end

  lanes.each do |lane, parse|
    context "with a file read by #{lane}" do
      let(:file) { parse.call(section_source) }

      it "writes each comment before the keyword it precedes" do
        expect(file.format).to eq(formatted(section_source))
      end

      it "writes the same text from the schema" do
        expect(file.schemas.first.format).to eq(formatted(section_source).chomp)
      end

      it "writes the same text again from its own output" do
        once = file.format
        expect(parse.call(once).format).to eq(once)
      end

      it "holds each comment as trailing, in the section before its keyword" do
        placed = ->(node) { node.untagged_remarks.map { |r| [r.placement, r.region] } }
        schema = file.schemas.first
        expect(placed.call(schema.entities[0])).to eq(closing_regions)
        expect(placed.call(schema.types[0])).to eq([%w[trailing underlying_type], %w[trailing where_rules]])
      end

      it "writes none of them in the stripped form" do
        stripped = file.schemas.first.format(no_remarks: true)
        expect(stripped).not_to include("--")
        expect(stripped).not_to include("(*")
      end

      it "writes them in the plain form" do
        plain = file.schemas.first.format(no_remarks: true, keep_untagged_remarks: true)
        expect(plain).to eq(formatted(section_source).chomp)
      end
    end

    context "with other sources, read by #{lane}" do
      def written(parse, text)
        parse.call(text).format
      end

      it "keeps each comment before its keyword for every combination of sections" do
        (0...16).each do |mask|
          has = ->(bit) { mask[bit] == 1 }
          count = -1
          note = -> { "  -- c#{count += 1}\n" }
          body = +"ENTITY e;\n  a : INTEGER;\n"
          body << note.call << "DERIVE\n  d : INTEGER := a;\n" if has.call(0)
          body << note.call << "INVERSE\n  i : SET OF h FOR hh;\n" if has.call(1)
          body << note.call << "UNIQUE\n  ur1: a;\n" if has.call(2)
          body << note.call << "WHERE\n  wr1: a > 0;\n" if has.call(3)
          body << note.call << "END_ENTITY;\nENTITY h;\n  hh : e;\nEND_ENTITY;\n"
          text = "SCHEMA s;\n#{body}END_SCHEMA;\n"
          once = written(parse, text)
          expect(once).to eq(formatted(text)), "mask #{mask}"
          expect(written(parse, once)).to eq(once), "second pass, mask #{mask}"
        end
      end

      it "writes two comments in a row and a block comment" do
        text = "SCHEMA s;\nENTITY e;\n  a : INTEGER;\n  -- one\n  (* two *)\n  -- three\nWHERE\n  wr1: a > 0;\nEND_ENTITY;\nEND_SCHEMA;\n"
        expect(written(parse, text)).to eq(formatted(text))
      end

      it "reads a comment that names a keyword and attributes that look like one" do
        text = <<~EXP
          SCHEMA s;
          ENTITY e;
            where_x : INTEGER;
            derive_y : INTEGER;
            -- the WHERE rules and the DERIVE section follow
          DERIVE
            d : INTEGER := where_x;
            -- unique and inverse are not here
          WHERE
            wr1: where_x > 0;
          END_ENTITY;
          END_SCHEMA;
        EXP
        expect(written(parse, text)).to eq(formatted(text))
      end

      it "writes lower-case keywords in the formatter's case" do
        text = "SCHEMA s;\nENTITY e;\n  a : INTEGER;\n  -- c0\nderive\n  d : INTEGER := a;\n  -- c1\nunique\n  ur1: a;\n  -- c2\nwhere\n  wr1: a > 0;\nEND_ENTITY;\nEND_SCHEMA;\n"
        upper = text.sub("derive", "DERIVE").sub("unique", "UNIQUE").sub("where\n", "WHERE\n")
        expect(written(parse, text)).to eq(formatted(upper))
      end

      it "writes a comment before the WHERE of an entity declared in a function" do
        text = "SCHEMA s;\nFUNCTION f : INTEGER;\n  ENTITY e;\n    a : INTEGER;\n    -- c0\n  WHERE\n    wr1: a > 0;\n  END_ENTITY;\n  RETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n"
        out = written(parse, text)
        expect(out.index("a : INTEGER;")).to be < out.index("-- c0")
        expect(out.index("-- c0")).to be < out.index("WHERE")
        expect(written(parse, out)).to eq(out)
      end

      it "leaves the comment before the WHERE of a rule as it was" do
        text = <<~EXP
          SCHEMA s;
          ENTITY e;
            a : INTEGER;
          END_ENTITY;
          RULE r FOR (e);
            LOCAL
              x : INTEGER := 1;
            END_LOCAL;
            -- before the WHERE of the rule
          WHERE
            wr1: TRUE;
          END_RULE;
          END_SCHEMA;
        EXP
        schema = parse.call(text).schemas.first
        expect(schema.rules.first.untagged_remarks.map { |r| [r.placement, r.region] }).to eq([%w[trailing statements]])
        expect(Array(schema.entities.first.untagged_remarks)).to be_empty
        expect(schema.format).to include("END_LOCAL;\n  -- before the WHERE of the rule\nWHERE\n")
      end

      it "leaves a comment at the end of a code line with its holder" do
        text = "SCHEMA s;\nENTITY e;\n  a : INTEGER; -- of a\nDERIVE\n  d : INTEGER := a; -- of d\nWHERE\n  wr1: a > 0;\nEND_ENTITY;\nEND_SCHEMA;\n"
        entity = parse.call(text).schemas.first.entities.first
        expect(Array(entity.untagged_remarks)).to be_empty
        expect(written(parse, text)).to eq(formatted(text))
      end
    end
  end

  it "writes them before the section keywords in the pretty form" do
    text = <<~EXP
      SCHEMA s;
      ENTITY e;
        a : INTEGER;
        -- before DERIVE
      DERIVE
        d : INTEGER := a;
        -- before WHERE
      WHERE
        wr1: a > 0;
      END_ENTITY;
      END_SCHEMA;
    EXP
    pretty = Expressir::Express::PrettyFormatter.new.format(Expressir::Express::Parser.from_exp(text))
    expect(pretty).to match(/a : INTEGER;\n\s+-- before DERIVE\nDERIVE\n/)
    expect(pretty).to match(/d : INTEGER := a;\n\s+-- before WHERE\nWHERE\n/)
  end
end
