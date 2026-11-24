# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own in the declaration part of a FUNCTION,
# PROCEDURE or RULE: before LOCAL, inside the LOCAL block, or before a
# nested FUNCTION, PROCEDURE, CONSTANT block or other declaration. Before,
# the lookup of the statement region made it the leading remark of the first
# statement that follows (for a RULE without statements: of the first WHERE
# rule), and every such comment was written after all the declarations.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  lanes = {
    "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
    "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    "from_file" => lambda do |text|
      Tempfile.create(["head_probe", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end,
  }

  def schema_of(source)
    "SCHEMA head_probe;\n#{source}ENTITY e;\nEND_ENTITY;\nEND_SCHEMA;\n"
  end

  let(:probe) do
    <<~EXP
      SCHEMA function_probe;
      FUNCTION f1 (x : INTEGER) : INTEGER;
        -- F01 on its own line before LOCAL
        LOCAL
          -- F02 on its own line before the first variable
          y : INTEGER;
          -- F03 on its own line before END_LOCAL
        END_LOCAL;
        -- F04 on its own line before the first statement
        y := x;
        RETURN (y);
      END_FUNCTION;
      FUNCTION f2 (x : INTEGER) : INTEGER;
        -- F05 on its own line before a nested function
        FUNCTION g (z : INTEGER) : INTEGER;
          RETURN (z);
        END_FUNCTION;
        -- F06 on its own line before a nested procedure
        PROCEDURE p (z : INTEGER);
        END_PROCEDURE;
        -- F07 on its own line before a constant block
        CONSTANT
          k : INTEGER := 1;
        END_CONSTANT;
        RETURN (g(x) + k);
      END_FUNCTION;
      PROCEDURE p1 (x : INTEGER);
        -- F08 on its own line before LOCAL of a procedure
        LOCAL
          y : INTEGER;
        END_LOCAL;
        y := x;
      END_PROCEDURE;
      RULE r1 FOR (e);
        -- F09 on its own line before LOCAL of a rule
        LOCAL
          y : INTEGER := 0;
        END_LOCAL;
      WHERE
        wr1 : y = 0;
      END_RULE;
      ENTITY e;
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  let(:probe_expected) do
    <<~EXP
      SCHEMA function_probe;

      FUNCTION f1(x : INTEGER) : INTEGER;
        -- F01 on its own line before LOCAL
        LOCAL
          -- F02 on its own line before the first variable
          y : INTEGER;
          -- F03 on its own line before END_LOCAL
        END_LOCAL;
        -- F04 on its own line before the first statement
        y := x;
        RETURN (y);
      END_FUNCTION;

      FUNCTION f2(x : INTEGER) : INTEGER;
        -- F05 on its own line before a nested function
        FUNCTION g(z : INTEGER) : INTEGER;
          RETURN (z);
        END_FUNCTION;
        -- F06 on its own line before a nested procedure
        PROCEDURE p(z : INTEGER);
        END_PROCEDURE;
        CONSTANT
          -- F07 on its own line before a constant block
          k : INTEGER := 1;
        END_CONSTANT;
        RETURN (g(x) + k);
      END_FUNCTION;

      PROCEDURE p1(x : INTEGER);
        -- F08 on its own line before LOCAL of a procedure
        LOCAL
          y : INTEGER;
        END_LOCAL;
        y := x;
      END_PROCEDURE;

      RULE r1 FOR (e);
        -- F09 on its own line before LOCAL of a rule
        LOCAL
          y : INTEGER := 0;
        END_LOCAL;
      WHERE
        wr1: y = 0;
      END_RULE;

      ENTITY e;
      END_ENTITY;

      END_SCHEMA;
    EXP
  end

  let(:pretty_expected) do
    <<~EXP
      SCHEMA function_probe;

      ENTITY e;
      END_ENTITY;

      FUNCTION f1(x : INTEGER) : INTEGER;
        -- F01 on its own line before LOCAL
        LOCAL
          -- F02 on its own line before the first variable
          y : INTEGER;
          -- F03 on its own line before END_LOCAL
        END_LOCAL;
        -- F04 on its own line before the first statement
        y := x;
        RETURN (y);
      END_FUNCTION;

      FUNCTION f2(x : INTEGER) : INTEGER;
        -- F05 on its own line before a nested function
        FUNCTION g(z : INTEGER) : INTEGER;
          RETURN (z);
        END_FUNCTION;
        -- F06 on its own line before a nested procedure
        PROCEDURE p(z : INTEGER);
        END_PROCEDURE;
        CONSTANT
          -- F07 on its own line before a constant block
          k : INTEGER := 1;
        END_CONSTANT;
        RETURN (g(x) + k);
      END_FUNCTION;

      RULE r1 FOR (e);
        -- F09 on its own line before LOCAL of a rule
        LOCAL
          y : INTEGER := 0;
        END_LOCAL;
      WHERE
        wr1: y = 0;
      END_RULE;

      PROCEDURE p1(x : INTEGER);
        -- F08 on its own line before LOCAL of a procedure
        LOCAL
          y : INTEGER;
        END_LOCAL;
        y := x;
      END_PROCEDURE;

      END_SCHEMA;
    EXP
  end

  lanes.each do |lane, parse|
    context "with a file read by #{lane}" do
      def round(parse, source)
        once = parse.call(source).format
        [once, parse.call(once).format]
      end

      it "writes the nine comments of the probe where they stood" do
        expect(parse.call(probe).format).to eq(probe_expected)
      end

      it "writes the same text from the schema" do
        expect(parse.call(probe).schemas.first.format).to eq(probe_expected.chomp)
      end

      it "writes the same text again from its own output" do
        once = parse.call(probe).format
        expect(parse.call(once).format).to eq(once)
      end

      it "writes no comment in the stripped form" do
        stripped = parse.call(probe).format(no_remarks: true)
        expect(stripped).not_to include("--")
        expect(stripped).to include("FUNCTION f1(x : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n")
      end

      it "holds each comment where it stood" do
        schema = parse.call(probe).schemas.first
        f1, f2 = schema.functions
        held = lambda do |node|
          node.untagged_remarks.map { |r| [r.text.split.first, r.placement, r.region] }
        end

        expect(held.(f1)).to eq([%w[F01 trailing declarations], %w[F03 trailing variables]])
        expect(held.(f1.variables.first)).to eq([["F02", "leading", nil]])
        expect(held.(f1.statements.first)).to eq([["F04", "leading", nil]])
        expect(held.(f2.functions.first)).to eq([["F05", "leading", nil]])
        expect(held.(f2.procedures.first)).to eq([["F06", "leading", nil]])
        expect(held.(f2.constants.first)).to eq([["F07", "leading", nil]])
        expect(held.(schema.procedures.first)).to eq([%w[F08 trailing declarations]])
        expect(held.(schema.rules.first)).to eq([%w[F09 trailing declarations]])
        expect(held.(schema.rules.first.where_rules.first)).to eq([])
      end

      it "writes them where they stood in the pretty form" do
        pretty = Expressir::Express::PrettyFormatter.new(indent: 2, provenance: false)
          .format(parse.call(probe))
        expect(pretty).to eq(pretty_expected)
      end

      it "writes a comment before LOCAL of a procedure with no statement after the block" do
        source = schema_of(<<~EXP)
          PROCEDURE p(x : INTEGER);
            -- before LOCAL
            LOCAL
              y : INTEGER;
            END_LOCAL;
          END_PROCEDURE;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("PROCEDURE p(x : INTEGER);\n  -- before LOCAL\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\nEND_PROCEDURE;")
        expect(twice).to eq(once)
      end

      it "writes a comment before LOCAL of a nested function inside the nested function" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            FUNCTION g(z : INTEGER) : INTEGER;
              -- inside g, before LOCAL
              LOCAL
                w : INTEGER;
              END_LOCAL;
              RETURN (z);
            END_FUNCTION;
            -- inside f, before LOCAL
            LOCAL
              y : INTEGER;
            END_LOCAL;
            RETURN (g(x));
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include(<<~OUT.chomp)
          FUNCTION f(x : INTEGER) : INTEGER;
            FUNCTION g(z : INTEGER) : INTEGER;
              -- inside g, before LOCAL
              LOCAL
                w : INTEGER;
              END_LOCAL;
              RETURN (z);
            END_FUNCTION;
            -- inside f, before LOCAL
            LOCAL
              y : INTEGER;
            END_LOCAL;
            RETURN (g(x));
          END_FUNCTION;
        OUT
        expect(twice).to eq(once)
      end

      it "keeps two comments in a row before LOCAL in their order" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            -- first
            -- second
            LOCAL
              y : INTEGER;
            END_LOCAL;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("  -- first\n  -- second\n  LOCAL\n")
        expect(twice).to eq(once)
      end

      it "writes a block comment on its own line before LOCAL before it" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            (* a block *)
            LOCAL
              y : INTEGER;
            END_LOCAL;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("  (* a block *)\n  LOCAL\n")
        expect(twice).to eq(once)
      end

      it "is not confused by the words LOCAL and END_LOCAL in a comment" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            -- LOCAL starts here
            LOCAL
              y : INTEGER;
              -- END_LOCAL follows
            END_LOCAL;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("  -- LOCAL starts here\n  LOCAL\n    y : INTEGER;\n    -- END_LOCAL follows\n  END_LOCAL;\n")
        expect(twice).to eq(once)
      end

      it "reads a lower-case local" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            -- before local
            local
              y : INTEGER;
            end_local;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("  -- before local\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n")
        expect(twice).to eq(once)
      end

      it "writes a comment between two variables above the second" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            LOCAL
              y : INTEGER;
              -- between
              z : INTEGER;
            END_LOCAL;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("    y : INTEGER;\n    -- between\n    z : INTEGER;\n")
        expect(twice).to eq(once)
      end

      it "writes a comment above a group of variables declared on one line" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            LOCAL
              -- above the group
              a, b : INTEGER;
            END_LOCAL;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("    -- above the group\n    a, b : INTEGER;\n")
        expect(twice).to eq(once)
      end

      it "writes a comment before a nested type or entity above it" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER;
            -- before a nested type
            TYPE t = INTEGER;
            END_TYPE;
            RETURN (x);
          END_FUNCTION;
        EXP
        once, twice = round(parse, source)
        expect(once).to include("FUNCTION f(x : INTEGER) : INTEGER;\n  -- before a nested type\n  TYPE t = INTEGER;\n")
        expect(twice).to eq(once)
      end

      it "keeps the comment at the end of a line after the keyword" do
        source = schema_of(<<~EXP)
          FUNCTION f(x : INTEGER) : INTEGER; -- after the head
            LOCAL -- after LOCAL
              y : INTEGER; -- after a variable
            END_LOCAL; -- after END_LOCAL
            RETURN (x);
          END_FUNCTION;
        EXP
        expect(parse.call(source).format).to eq(
          parse.call(parse.call(source).format).format,
        )
        expect(parse.call(source).format).to include("y : INTEGER; -- after a variable")
      end
    end
  end

  # A comment on its own line before the first statement, between
  # statements and before END_FUNCTION are written as before.
  describe "the neighbouring positions" do
    it "keeps the comments among the statements" do
      source = schema_of(<<~EXP)
        FUNCTION f(x : INTEGER) : INTEGER;
          LOCAL
            y : INTEGER;
          END_LOCAL;
          -- before the first statement
          y := x;
          -- between statements
          RETURN (y);
          -- after the last statement
        END_FUNCTION;
      EXP
      expect(Expressir::Express::Parser.from_exp(source).format).to include(<<~OUT.gsub(/^/, "").chomp)
        FUNCTION f(x : INTEGER) : INTEGER;
          LOCAL
            y : INTEGER;
          END_LOCAL;
          -- before the first statement
          y := x;
          -- between statements
          RETURN (y);
          -- after the last statement
        END_FUNCTION;
      OUT
    end
  end

  # A comment inside a declaration or a statement body is not one of the
  # head positions: it is written as it was without them.
  describe "the comments that are not in a position of the declaration part" do
    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        def with_col(body)
          "SCHEMA s;\nTYPE col = ENUMERATION OF (red, green);\nEND_TYPE;\n#{body}ENTITY e;\nEND_ENTITY;\nEND_SCHEMA;\n"
        end

        def self.shapes
          [
            ["FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    (* c *) a : INTEGER;\n    b : INTEGER;\n  END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a : INTEGER;\n    b : INTEGER;\n  END_LOCAL;\n  (* c *)\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    (* c *) a : INTEGER;\n  END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a : INTEGER;\n  END_LOCAL;\n  (* c *)\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["FUNCTION f(p : INTEGER) : INTEGER;\n  (* c *) FUNCTION g(z : INTEGER) : INTEGER;\n    RETURN (z);\n  END_FUNCTION;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  FUNCTION g(z : INTEGER) : INTEGER;\n    (* c *)\n    RETURN (z);\n  END_FUNCTION;\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["FUNCTION f(p : INTEGER) : INTEGER;\n  (* c *) LOCAL\n    a : INTEGER;\n  END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a : INTEGER;\n  END_LOCAL;\n  (* c *)\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a : INTEGER;\n    (* c *) END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a : INTEGER;\n  END_LOCAL;\n  (* c *)\n  RETURN (1);\nEND_FUNCTION;\n"],
          ]
        end

        # A block comment with code after it on its own line is not a comment
        # of its own line: it is left where the base writes it.
        shapes.each_with_index do |(body, expected), n|
          it "leaves a block comment followed by code on its line as it was (#{n + 1})" do
            once = parse.call(schema_of(body)).format
            expect(once).to include(expected)
            expect(parse.call(once).format).to eq(once)
          end
        end

        it "places a comment after non-ASCII text in the LOCAL block" do
          source = schema_of("FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    -- Příliš žluťoučký\n    y : STRING := 'ůě';\n    -- c\n    z : INTEGER;\n  END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n")
          once = parse.call(source).format
          expect(once).to include("    -- Příliš žluťoučký\n    y : STRING := 'ůě';\n    -- c\n    z : INTEGER;\n  END_LOCAL;")
          expect(parse.call(once).format).to eq(once)
        end

        it "keeps a comment between the names of one declaration before the first statement" do
          source = with_col("FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    a,\n    -- cb\n    b : INTEGER;\n  END_LOCAL;\n  RETURN (1);\nEND_FUNCTION;\n")
          once = parse.call(source).format
          expect(once).to include("  LOCAL\n    a, b : INTEGER;\n  END_LOCAL;\n  -- cb\n  RETURN (1);\nEND_FUNCTION;")
          expect(parse.call(once).format).to eq(once)
        end

        case_bodies = {
          "in the middle of a CASE whose label is a variable name" =>
            "FUNCTION f(p : col) : INTEGER;\n  LOCAL\n    red : INTEGER := 0;\n  END_LOCAL;\n  CASE p OF\n    green : red := 1;\n    -- cc\n    red : red := 2;\n  END_CASE;\n  RETURN (red);\nEND_FUNCTION;\n",
          "as the first line of a CASE" =>
            "FUNCTION f(p : col) : INTEGER;\n  LOCAL\n    red : INTEGER := 0;\n  END_LOCAL;\n  CASE p OF\n    -- cc\n    red : red := 2;\n  END_CASE;\n  RETURN (red);\nEND_FUNCTION;\n",
          "in a CASE of a procedure without RETURN" =>
            "PROCEDURE q(p : col);\n  LOCAL\n    red : INTEGER := 0;\n  END_LOCAL;\n  CASE p OF\n    green : red := 1;\n    -- cc\n    red : red := 2;\n  END_CASE;\nEND_PROCEDURE;\n",
        }.freeze
        case_bodies.each do |name, body|
          it "keeps a comment #{name} inside the CASE" do
            once = parse.call(with_col(body)).format
            # Where the CASE writes it is not the subject here: it is not
            # written into the LOCAL block.
            expect(once.index("-- cc")).to be > once.index("END_LOCAL;")
            expect(once).to include("  LOCAL\n    red : INTEGER := 0;\n  END_LOCAL;")
            expect(once).not_to include("    -- cc\n    red : INTEGER")
            expect(parse.call(once).format).to eq(once)
          end
        end

        it "keeps the comments before a BEGIN, an IF and in a THEN body in the statements" do
          source = with_col("FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER := 0;\n  END_LOCAL;\n  y := 1;\n  -- before begin\n  BEGIN\n    y := 2;\n  END;\n  -- before if\n  IF y = 2 THEN\n    -- in then\n    y := 3;\n  END_IF;\n  RETURN (y);\nEND_FUNCTION;\n")
          once = parse.call(source).format
          expect(once).to include("  y := 1;\n  -- before begin\n  BEGIN\n    y := 2;\n  END;\n  -- before if\n  IF y = 2 THEN\n    -- in then\n    y := 3;\n  END_IF;\n  RETURN (y);")
          expect(parse.call(once).format).to eq(once)
        end

        # The inner lines of a block drift in the indentation; only the
        # order of the three comments and their place are asserted.
        # A comment of several lines, and the neighbouring closing keywords,
        # are written as before this change.
        def self.main_texts
          [
            ["a block before LOCAL", "FUNCTION f(p : INTEGER) : INTEGER;\n  (* first line\n     second line *)\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  first line\n       second line\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a block before a variable", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    (* first line\n     second line *)\n    y : INTEGER;\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  first line\n       second line\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a block before END_LOCAL", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n    (* first line\n     second line *)\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  first line\n       second line\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a block before a nested function", "FUNCTION f(p : INTEGER) : INTEGER;\n  (* first line\n     second line *)\n  FUNCTION g(z : INTEGER) : INTEGER;\n    RETURN (z);\n  END_FUNCTION;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  FUNCTION g(z : INTEGER) : INTEGER;\n    RETURN (z);\n  END_FUNCTION;\n  (*\n  first line\n       second line\n  *)\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["a nested block before LOCAL", "FUNCTION f(p : INTEGER) : INTEGER;\n  (* a (* b *)\n     c *)\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  a (* b *)\n       c\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a nested block before a variable", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    (* a (* b *)\n     c *)\n    y : INTEGER;\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  a (* b *)\n       c\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a nested block before END_LOCAL", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n    (* a (* b *)\n     c *)\n  END_LOCAL;\n  RETURN (y);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  (*\n  a (* b *)\n       c\n  *)\n  RETURN (y);\nEND_FUNCTION;\n"],
            ["a nested block before a nested function", "FUNCTION f(p : INTEGER) : INTEGER;\n  (* a (* b *)\n     c *)\n  FUNCTION g(z : INTEGER) : INTEGER;\n    RETURN (z);\n  END_FUNCTION;\n  RETURN (1);\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  FUNCTION g(z : INTEGER) : INTEGER;\n    RETURN (z);\n  END_FUNCTION;\n  (*\n  a (* b *)\n       c\n  *)\n  RETURN (1);\nEND_FUNCTION;\n"],
            ["closing keywords with comment 0", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER := 0;\n  END_LOCAL;\n  IF y = 0 THEN\n    y := 1;\n    -- c\n  ELSE\n    y := 2;\n    -- c\n  END_IF;\n  REPEAT i := 1 TO 2;\n    y := 3;\n    -- c\n  END_REPEAT;\n  RETURN (y);\n  -- c\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER := 0;\n  END_LOCAL;\n  IF y = 0 THEN\n    y := 1;\n    -- c\n  ELSE\n    y := 2;\n    -- c\n  END_IF;\n  REPEAT i := 1 TO 2;\n    y := 3;\n    -- c\n  END_REPEAT;\n  RETURN (y);\n  -- c\nEND_FUNCTION;\n"],
            ["closing keywords with comment 1", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER := 0;\n  END_LOCAL;\n  IF y = 0 THEN\n    y := 1;\n    (* c *)\n  ELSE\n    y := 2;\n    (* c *)\n  END_IF;\n  REPEAT i := 1 TO 2;\n    y := 3;\n    (* c *)\n  END_REPEAT;\n  RETURN (y);\n  (* c *)\nEND_FUNCTION;\n", "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER := 0;\n  END_LOCAL;\n  IF y = 0 THEN\n    y := 1;\n    (* c *)\n  ELSE\n    y := 2;\n    (* c *)\n  END_IF;\n  REPEAT i := 1 TO 2;\n    y := 3;\n    (* c *)\n  END_REPEAT;\n  RETURN (y);\n  (* c *)\nEND_FUNCTION;\n"],
          ]
        end

        main_texts.each do |name, body, expected|
          it "writes #{name} as it was" do
            once = parse.call(schema_of(body)).format
            expect(once).to include(expected)
          end
        end
      end
    end
  end
end
