# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment on a line of its own between two actions of a CASE is written
# back above the label of the action it precedes. The statement of that
# action holds it as a leading remark, and the formatter wrote it between
# the label and the statement.
RSpec.describe Expressir::Express::Formatter do
  describe "a comment on its own line between two actions of a CASE" do
    def wrap(body)
      <<~EXP.sub("%BODY%", body.chomp)
        SCHEMA case_probe;
        FUNCTION f(x : INTEGER; y : INTEGER) : INTEGER;
          LOCAL r : INTEGER := 0; END_LOCAL;
        %BODY%
          RETURN (r);
        END_FUNCTION;
        END_SCHEMA;
      EXP
    end

    def expected_for(body)
      <<~EXP.sub("%BODY%", body.chomp)
        SCHEMA case_probe;

        FUNCTION f(x : INTEGER;
                   y : INTEGER) : INTEGER;
          LOCAL
            r : INTEGER := 0;
          END_LOCAL;
        %BODY%
          RETURN (r);
        END_FUNCTION;

        END_SCHEMA;
      EXP
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["case_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    cases = {
      "one comment" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            -- own line between two case actions
            2 : r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          -- own line between two case actions
          2 :
            r := 4;
          END_CASE;
        OUT
      ],
      "a comment before the first action and two in a row" => [
        <<~SRC, <<~OUT
          CASE x OF
            -- before the first action
            1 : r := 3;
            -- first of two
            -- second of two
            2 : r := 4;
          END_CASE;
        SRC
          CASE x OF
          -- before the first action
          1 :
            r := 3;
          -- first of two
          -- second of two
          2 :
            r := 4;
          END_CASE;
        OUT
      ],
      "a block comment and every shape of label" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 1;
            (* a block comment *)
            2, 3 : r := 2;
            -- a negative number
            -5 : r := 3;
            -- a parenthesised expression
            (6 + 1) : r := 4;
            -- an identifier
            abc : r := 5;
            -- a label on its own line
            7, 8 :
              r := 6;
            -- before a label that is followed by a comment
            9 :
              -- a comment after the label
              r := 7;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 1;
          (* a block comment *)
          2, 3 :
            r := 2;
          -- a negative number
          -5 :
            r := 3;
          -- a parenthesised expression
          (6 + 1) :
            r := 4;
          -- an identifier
          abc :
            r := 5;
          -- a label on its own line
          7, 8 :
            r := 6;
          -- before a label that is followed by a comment
          9 :
            -- a comment after the label
            r := 7;
          END_CASE;
        OUT
      ],
      "a block comment before the label and one after a bare label" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            (* a *)
            2 :
              (* b *)
              r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          (* a *)
          2 :
            (* b *)
            r := 4;
          END_CASE;
        OUT
      ],
      "a block comment before the label and one after it on the label line" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            (* a *)
            2 : (* b *)
              r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          (* a *)
          2 :
            (* b *)
            r := 4;
          END_CASE;
        OUT
      ],
      "a nested block comment after a bare label" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            2 :
              (* a (* n *) z *)
              r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          2 :
            (* a (* n *) z *)
            r := 4;
          END_CASE;
        OUT
      ],
      "a line comment and a nested block comment after a bare label" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            2 :
              -- z
              (* a (* n *) c *)
              r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          2 :
            -- z
            (* a (* n *) c *)
            r := 4;
          END_CASE;
        OUT
      ],
      "a nested block comment before a label" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            (* a (* n *) z *)
            2 : r := 4;
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
          (* a (* n *) z *)
          2 :
            r := 4;
          END_CASE;
        OUT
      ],
      "a compound action" => [
        <<~SRC, <<~OUT
          CASE y OF
            1 : BEGIN
              r := 1;
              -- inside the compound
              r := 2;
            END;
            -- after the compound
            2 : BEGIN
              -- first in the compound
              r := 3;
            END;
          END_CASE;
        SRC
          CASE y OF
          1 :
            BEGIN
              r := 1;
              -- inside the compound
              r := 2;
            END;
          -- after the compound
          2 :
            BEGIN
              -- first in the compound
              r := 3;
            END;
          END_CASE;
        OUT
      ],
      "a CASE inside a CASE action, inside IF and inside REPEAT" => [
        <<~SRC, <<~OUT
          CASE y OF
            1 : CASE x OF
              1 : r := 1;
              -- inner between
              2 : r := 2;
            END_CASE;
            -- outer between
            2 : r := 3;
          END_CASE;
          IF x > 0 THEN
            CASE y OF
              1 : r := 1;
              -- in IF
              2 : r := 2;
            END_CASE;
          END_IF;
          REPEAT i := 1 TO 3;
            CASE y OF
              1 : r := 1;
              -- in REPEAT
              2 : r := 2;
            END_CASE;
          END_REPEAT;
        SRC
          CASE y OF
          1 :
            CASE x OF
            1 :
              r := 1;
            -- inner between
            2 :
              r := 2;
            END_CASE;
          -- outer between
          2 :
            r := 3;
          END_CASE;
          IF x > 0 THEN
            CASE y OF
            1 :
              r := 1;
            -- in IF
            2 :
              r := 2;
            END_CASE;
          END_IF;
          REPEAT i := 1 TO 3;
            CASE y OF
            1 :
              r := 1;
            -- in REPEAT
            2 :
              r := 2;
            END_CASE;
          END_REPEAT;
        OUT
      ],
      "the comments before OTHERWISE and END_CASE, as they were" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : r := 3;
            -- before OTHERWISE
            OTHERWISE : r := 5;
            -- before END_CASE
          END_CASE;
          CASE y OF
            1 : r := 3;
            -- before END_CASE of a CASE without OTHERWISE
          END_CASE;
        SRC
          CASE x OF
          1 :
            r := 3;
            -- before OTHERWISE
          OTHERWISE :
            r := 5;
            -- before END_CASE
          END_CASE;
          CASE y OF
          1 :
            r := 3;
            -- before END_CASE of a CASE without OTHERWISE
          END_CASE;
        OUT
      ],
      "a comment at the end of an action line and one after a bare label, as they were" => [
        <<~SRC, <<~OUT
          CASE x OF
            1 : -- after a bare label
              r := 3;
            2 : r := 4; -- at the end of an action line
          END_CASE;
        SRC
          CASE x OF
          1 : -- after a bare label
            r := 3;
          2 :
            r := 4; -- at the end of an action line
          END_CASE;
        OUT
      ],
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        cases.each do |name, (src, out)|
          context "with #{name}" do
            let(:source) { wrap(src.gsub(/^/, "  ")) }
            let(:expected) { expected_for(out.gsub(/^/, "  ")) }
            let(:file) { parse.call(source) }

            it "writes each comment on the lines above the label it precedes" do
              expect(file.format).to eq(expected)
            end

            it "writes the same text from the schema" do
              expect(file.schemas.first.format).to eq(expected.chomp)
            end

            it "writes the same text again from its own output" do
              expect(parse.call(expected).format).to eq(expected)
            end

            it "writes no comment in the stripped form" do
              stripped = file.schemas.first.format(no_remarks: true)
              expect(stripped).not_to include("--")
              expect(stripped).not_to include("(*")
            end
          end
        end

        it "holds the remark as a leading remark of the statement of the action, in the region before the label" do
          text = wrap("  CASE x OF\n    1 : r := 3;\n    -- own line\n    2 : r := 4;\n  END_CASE;\n")
          function = parse.call(text).schemas.first.functions.first
          case_node = function.statements.first
          expect(case_node.actions.map { |a| a.statement.untagged_remarks.map { |r| [r.placement, r.region] } })
            .to eq([[], [%w[leading before_label]]])
        end

        it "gives a comment after the label no region and leaves it between the label and the statement" do
          text = wrap("  CASE x OF\n    1 : r := 3;\n    2 :\n      -- after the label\n      r := 4;\n  END_CASE;\n")
          parsed = parse.call(text)
          case_node = parsed.schemas.first.functions.first.statements.first
          expect(case_node.actions.map { |a| a.statement.untagged_remarks.map { |r| [r.placement, r.region] } })
            .to eq([[], [["leading", nil]]])
          expect(parsed.format).to include("  2 :\n    -- after the label\n    r := 4;")
        end

        it "writes the comment above the label in the plain form" do
          text = wrap("  CASE x OF\n    1 : r := 3;\n    -- own line\n    2 : r := 4;\n  END_CASE;\n")
          plain = described_class.new(no_remarks: true, keep_untagged_remarks: true)
            .format(parse.call(text))
          expect(plain).to include("r := 3;\n  -- own line\n  2 :\n    r := 4;")
        end

        it "writes the stripped form as it did" do
          text = wrap("  CASE x OF\n    1 : r := 3;\n    -- own line\n    2 : r := 4;\n  END_CASE;\n")
          stripped = parse.call(text).schemas.first.format(no_remarks: true)
          expect(stripped).to eq(
            expected_for("  CASE x OF\n  1 :\n    r := 3;\n  2 :\n    r := 4;\n  END_CASE;\n").chomp.sub(/\A/, ""),
          )
        end

        it "writes the comment above the label in the pretty form" do
          text = wrap("  CASE x OF\n    1 : r := 3;\n    -- own line\n    2 : r := 4;\n  END_CASE;\n")
          pretty = Expressir::Express::PrettyFormatter.new.format(parse.call(text))
          expect(pretty).to include("r := 3;\n    -- own line\n    2 :\n        r := 4;")
        end
      end
    end
  end
end
