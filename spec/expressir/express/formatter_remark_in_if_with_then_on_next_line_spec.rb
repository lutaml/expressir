# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own before ELSE or END_IF stays after the
# statement it followed when the THEN of the IF stands on a later line than
# the IF. The opener table asked for THEN on the line of IF, so such an IF
# never opened and the closing keyword found no IF to close; the remark was
# held by no region and no formatter wrote it.
RSpec.describe Expressir::Express::Formatter do
  describe "remarks in an IF whose THEN is on a later line" do
    let(:source) do
      <<~EXP
        SCHEMA else_probe;
        FUNCTION f (x : INTEGER) : INTEGER;
          IF x > 0
            THEN RETURN (1);
            -- G1 on its own line before ELSE with a statement
            ELSE RETURN (2);
          END_IF;
          IF x > 1 THEN
            RETURN (3);
            (* G2 a block on its own line before ELSE with a statement *)
          ELSE RETURN (4);
          END_IF;
          IF x > 2 THEN
            RETURN (5);
            -- G3 on its own line before a bare ELSE
          ELSE
            RETURN (6);
          END_IF;
          RETURN (0);
        END_FUNCTION;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA else_probe;

        FUNCTION f(x : INTEGER) : INTEGER;
          IF x > 0 THEN
            RETURN (1);
            -- G1 on its own line before ELSE with a statement
          ELSE
            RETURN (2);
          END_IF;
          IF x > 1 THEN
            RETURN (3);
            (* G2 a block on its own line before ELSE with a statement *)
          ELSE
            RETURN (4);
          END_IF;
          IF x > 2 THEN
            RETURN (5);
            -- G3 on its own line before a bare ELSE
          ELSE
            RETURN (6);
          END_IF;
          RETURN (0);
        END_FUNCTION;

        END_SCHEMA;
      EXP
    end

    def wrap(body)
      "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n#{body}  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n"
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["if_then_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    shapes = [
      ["then on next line, bare else", "  IF x > 0\n    THEN RETURN (1);\n    -- C1\n  ELSE\n    RETURN (2);\n  END_IF;\n", "ELSE"],
      ["then on next line, before end_if", "  IF x > 0\n    THEN RETURN (1);\n    -- C1\n  END_IF;\n", "END_IF;"],
      ["then on next line, after else", "  IF x > 0\n    THEN RETURN (1);\n  ELSE RETURN (2);\n    -- C1\n  END_IF;\n", "END_IF;"],
      ["multi-line condition", "  IF (x > 0)\n    AND (x < 5)\n    THEN RETURN (1);\n    -- C1\n    ELSE RETURN (2);\n  END_IF;\n", "ELSE"],
      ["outer then on next line", "  IF x > 0\n    THEN\n    IF x > 1 THEN RETURN (1); END_IF;\n    -- C1\n    ELSE RETURN (2);\n  END_IF;\n", "ELSE"],
      ["inner then on next line", "  IF x > 0 THEN\n    IF x > 1\n      THEN RETURN (1);\n      -- C1\n      ELSE RETURN (2);\n    END_IF;\n  ELSE RETURN (3);\n  END_IF;\n", "ELSE"],
      ["in a CASE action", "  CASE x OF\n    1 : IF x > 0\n      THEN RETURN (1);\n      -- C1\n      ELSE RETURN (2);\n      END_IF;\n    OTHERWISE : RETURN (3);\n  END_CASE;\n", "ELSE"],
      ["in a REPEAT", "  REPEAT i := 1 TO 3;\n    IF x > 0\n      THEN RETURN (1);\n      -- C1\n      ELSE RETURN (2);\n    END_IF;\n  END_REPEAT;\n", "ELSE"],
      ["lower case", "  if x > 0\n    then return (1);\n    -- C1\n    else return (2);\n  end_if;\n", "ELSE"],
    ].freeze

    unchanged = [
      ["  IF x > 0 THEN\n    RETURN (1);\n    -- C1\n  ELSE\n    RETURN (2);\n  END_IF;\n",
       "  IF x > 0 THEN\n    RETURN (1);\n    -- C1\n  ELSE\n    RETURN (2);\n  END_IF;\n"],
      ["  IF x > 0 THEN\n    RETURN (1);\n    -- C1\n  END_IF;\n",
       "  IF x > 0 THEN\n    RETURN (1);\n    -- C1\n  END_IF;\n"],
      ["  IF x > 0 THEN\n    RETURN (1);\n  ELSE -- C1\n    RETURN (2);\n  END_IF;\n",
       "  IF x > 0 THEN\n    RETURN (1);\n  ELSE -- C1\n    RETURN (2);\n  END_IF;\n"],
      ["  IF x > 0 THEN -- C1\n    RETURN (1);\n  END_IF;\n",
       "  IF x > 0 THEN -- C1\n    RETURN (1);\n  END_IF;\n"],
      ["  IF x > 0 THEN\n    RETURN (1);\n  END_IF; -- C1\n",
       "  IF x > 0 THEN\n    RETURN (1);\n  END_IF; -- C1\n"],
      ["  IF x > 0\n    THEN RETURN (1); -- C1\n  ELSE RETURN (2);\n  END_IF;\n",
       "  IF x > 0 THEN\n    RETURN (1); -- C1\n  ELSE\n    RETURN (2);\n  END_IF;\n"],
      ["  IF x > 0 THEN\n    x := LENGTH('IF a THEN');\n    -- IF THEN ELSE in a comment\n  ELSE RETURN (2);\n  END_IF;\n",
       "  IF x > 0 THEN\n    x := LENGTH('IF a THEN');\n    -- IF THEN ELSE in a comment\n  ELSE\n    RETURN (2);\n  END_IF;\n"],
      ["  LOCAL gift : INTEGER; then_x : INTEGER; else_value : INTEGER; END_LOCAL;\n  gift := 1;\n  -- C1\n  then_x := 2;\n  -- C2\n  else_value := 3;\n",
       "  LOCAL\n    gift : INTEGER;\n    then_x : INTEGER;\n    else_value : INTEGER;\n  END_LOCAL;\n  gift := 1;\n  -- C1\n  then_x := 2;\n  -- C2\n  else_value := 3;\n"],
    ].freeze

    # A comment inside a `(* ... *)` remark is not code for the scope map,
    # and of several IFs that start on one line the one still open is closed.
    # Each case: the source, then each `--` comment with the line before it.
    scope_cases = [
      ["block_with_if_prose",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    RETURN (1);\n    (* note:\n IF this happens\n *)\n    -- c\n  ELSE\n    RETURN (2);\n    -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["RETURN (1);", "-- c"], ["RETURN (2);", "-- e"]]],
      ["block_with_lower_if",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    RETURN (1);\n    (* if\n       if this\n    *)\n    -- c\n  ELSE\n    RETURN (2);\n  -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["RETURN (1);", "-- c"], ["RETURN (2);", "-- e"]]],
      ["block_after_statement_one_line",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    y := 2; (* if big *)\n    -- c\n  ELSE\n    y := 3;\n    -- d\n  END_IF;\n  -- e\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["(* if big *)", "-- c"], ["y := 3;", "-- d"], ["END_IF;", "-- e"]]],
      ["block_opened_after_statement",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    RETURN (1); (* IF\n    still *)\n    -- c\n  ELSE\n    RETURN (2);\n  -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["RETURN (1);", "-- c"], ["RETURN (2);", "-- e"]]],
      ["two_ifs_in_one_block",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    y := 1;\n    (*\n    IF a IF b\n    IF c\n    *)\n  -- d\n  ELSE\n    y := 2;\n  -- e\n  END_IF;\n  -- f\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := 1;", "-- d"], ["y := 2;", "-- e"], ["END_IF;", "-- f"]]],
      ["prose_in_case",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  CASE x OF\n    1 : y := 1;\n    (* positive\n       if big *)\n    -- c\n    2 : y := 2;\n    -- d\n    OTHERWISE : y := 3;\n    -- e\n  END_CASE;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["*)", "-- c"], ["y := 2;", "-- d"], ["y := 3;", "-- e"]]],
      ["prose_before_end_function",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  y := 1;\n  RETURN (0);\n  (* positive\n     if big *)\n  -- tail\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["RETURN (0);", "-- tail"]]],
      ["prose_in_procedure",
       "SCHEMA s;\nPROCEDURE p (VAR x : INTEGER);\n  x := 1;\n  (* positive\n     if big *)\n  -- c\n  x := 2;\n  -- d\nEND_PROCEDURE;\nEND_SCHEMA;\n",
       [["*)", "-- c"], ["x := 2;", "-- d"]]],
      ["prose_in_rule",
       "SCHEMA s;\nENTITY e; a : INTEGER; END_ENTITY;\nRULE r FOR (e);\n  LOCAL z : INTEGER; END_LOCAL;\n  z := 1;\n  (* positive\n     if big *)\n  -- c\nWHERE\n  -- w\n  w1 : z > 0;\n  -- w2\nEND_RULE;\nEND_SCHEMA;\n",
       [["z := 1;", "-- c"], ["w1: z > 0;", "-- w2"]]],
      ["nested_block_remark",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    y := 1;\n    (* a (* IF b *) IF c -- not an end\n       IF d *)\n    -- c\n  ELSE\n    y := 2;\n    -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := 1;", "-- c"], ["y := 2;", "-- e"]]],
      ["block_and_dashes_in_text",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    y := LENGTH('(* IF');\n    -- c (* IF\n  ELSE\n    y := 2;\n    -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := LENGTH('(* IF');", "-- c (* IF"], ["y := 2;", "-- e"]]],
      ["prose_with_then_and_end_if",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN\n    y := 1;\n    (* IF a THEN b END_IF; REPEAT BEGIN ALIAS CASE y OF *)\n    -- c\n  ELSE\n    y := 2;\n    -- e\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["(* IF a THEN b END_IF; REPEAT BEGIN ALIAS CASE y OF *)", "-- c"], ["y := 2;", "-- e"]]],
      ["two_ifs_on_a_line_second_then_next",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN y := 1; END_IF; IF y > 0\n  THEN y := 2;\n  -- c\n  ELSE y := 3;\n  -- d\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := 2;", "-- c"], ["y := 3;", "-- d"]]],
      ["two_ifs_on_a_line_then_on_if_line",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN y := 1; END_IF; IF y > 0 THEN y := 2;\n  -- c\n  ELSE y := 3;\n  -- d\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := 2;", "-- c"], ["y := 3;", "-- d"]]],
      ["two_ifs_on_a_line_no_else",
       "SCHEMA s;\nFUNCTION f (x : INTEGER; y : INTEGER) : INTEGER;\n  IF x > 0 THEN y := 1; END_IF; IF y > 0\n  THEN y := 2;\n  -- c\n  END_IF;\n  RETURN (0);\nEND_FUNCTION;\nEND_SCHEMA;\n",
       [["y := 2;", "-- c"]]],
    ].freeze

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes each comment after the statement it followed" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "writes none of the comments in the stripped form" do
          expect(file.schemas.first.format(no_remarks: true)).not_to match(/--|\(\*/)
        end

        it "holds the remarks as trailing remarks of the THEN body of their IF" do
          placed = file.schemas.first.functions.first.statements.first(3).map do |statement|
            statement.untagged_remarks.map { |r| [r.placement, r.region] }
          end
          expect(placed).to eq(Array.new(3) { [%w[trailing statements]] })
        end

        shapes.each do |name, body, following|
          it "keeps the comment of an IF: #{name}" do
            text = parse.call(wrap(body)).format
            lines = text.lines.map(&:strip)
            at = lines.index("-- C1")
            expect(at).not_to be_nil, text
            expect(lines[at - 1]).to end_with(";")
            expect(lines[at + 1].upcase).to start_with(following)
            expect(parse.call(text).format).to eq(text)
          end
        end

        scope_cases.each do |name, source, comments|
          it "keeps each comment after its statement: #{name}" do
            found = lambda do |text|
              lines = text.lines.map(&:strip)
              lines.each_index.select { |i| lines[i].start_with?("--") }.map { |i| [lines[i - 1], lines[i]] }
            end
            text = parse.call(source).format
            expect(found.call(text)).to eq(comments), text
            # The indentation of the lines of a block remark may change.
            expect(found.call(parse.call(text).format)).to eq(comments)
          end
        end

        unchanged.each_with_index do |(body, expected_body), index|
          it "writes an IF that worked before as before (case #{index + 1})" do
            expect(parse.call(wrap(body)).format).to eq(
              wrap(expected_body)
                .sub("SCHEMA s;\n", "SCHEMA s;\n\n")
                .sub("END_FUNCTION;\nEND_SCHEMA;\n", "END_FUNCTION;\n\nEND_SCHEMA;\n")
                .sub("FUNCTION f (x", "FUNCTION f(x"),
            )
          end
        end
      end
    end
  end
end
