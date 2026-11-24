# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment inside the supertype expression of a SUBTYPE_CONSTRAINT is
# written back where it stands: after the operand it follows on its line,
# or on a line of its own before the operand it precedes. Before, the
# SUBTYPE_CONSTRAINT held these remarks with no placement and they were
# written after `END_SUBTYPE_CONSTRAINT;`. The operands are handled as the
# items of a SELECT are.
RSpec.describe Expressir::Express::Formatter do
  describe "the comments in the supertype expression of a SUBTYPE_CONSTRAINT" do
    def self.wrapped(body)
      head = "SCHEMA s;\nENTITY t;\nEND_ENTITY;\n"
      subtypes = %w[a b c d].map { |n| "ENTITY #{n}\n  SUBTYPE OF (t);\nEND_ENTITY;\n" }.join
      "#{head}#{subtypes}SUBTYPE_CONSTRAINT k FOR t;\n#{body}END_SUBTYPE_CONSTRAINT;\nEND_SCHEMA;\n"
    end

    from_file = lambda do |text|
      Tempfile.create(["constraint_probe", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end

    # A comment that stands inside the own parentheses of an operand is not
    # taken: it stays where it was, after END_SUBTYPE_CONSTRAINT;, on every
    # pass. So does one that follows the operator of an operand, whatever
    # stands between the comment and the operand's name.
    not_taken = {
      "  ONEOF (a, (-- x\n b));\n" => "  ONEOF(a, b);\nEND_SUBTYPE_CONSTRAINT; -- x\n",
      "  ONEOF (a, (\n -- x\n b));\n" => "  ONEOF(a, b);\nEND_SUBTYPE_CONSTRAINT; -- x\n",
      "  ONEOF (a, ( -- x\n b)) ;\n" => "  ONEOF(a, b);\nEND_SUBTYPE_CONSTRAINT; -- x\n",
      "  ONEOF ((-- l\n a), b);\n" => "  ONEOF(a, b);\nEND_SUBTYPE_CONSTRAINT; -- l\n",
      "  ONEOF (\n -- l\n (a), b);\n" => "  ONEOF(a, b);\nEND_SUBTYPE_CONSTRAINT; -- l\n",
      "  ONEOF (a,\n -- l\n (b), c);\n" => "  ONEOF(a, b, c);\nEND_SUBTYPE_CONSTRAINT; -- l\n",
      "  ONEOF (a ANDOR (-- l\n b), c);\n" => "  ONEOF(a ANDOR b, c);\nEND_SUBTYPE_CONSTRAINT; -- l\n",
      "  ONEOF (b) ANDOR\n (-- c\n c);\n" => "  ONEOF(b) ANDOR c;\nEND_SUBTYPE_CONSTRAINT; -- c\n",
      "  ONEOF (b) ANDOR\n ((* c *)\n c);\n" => "  ONEOF(b) ANDOR c;\nEND_SUBTYPE_CONSTRAINT;\n",
      "  ONEOF (a, b) ANDOR -- c\n c;\n" => "  ONEOF(a, b) ANDOR c;\nEND_SUBTYPE_CONSTRAINT; -- c\n",
      "  ONEOF (a, b) AND\n -- c\n c;\n" => "  ONEOF(a, b) AND c;\nEND_SUBTYPE_CONSTRAINT; -- c\n",
    }.freeze

    after_name = {
      "  ONEOF (a, (b -- y\n ));\n" => "-- y",
      "  ONEOF (a, (b (* y *)));\n" => "(* y *)",
    }.freeze

    after_operator = [
      "  ONEOF (a, b) ANDOR (-- l\n c);\n",
      "  ONEOF (a, b) ANDOR (c ANDOR (-- l\n d));\n",
      "  ONEOF (a, b ANDOR (-- l\n (c)));\n",
      "  ONEOF (a, b AND (-- l\n c));\n",
      "  ONEOF (a, (b ANDOR ( -- l\n c)));\n",
      "  (a ANDOR (-- l\n b));\n",
      "  ONEOF (a, b) andor (-- l\n c);\n",
      "  ONEOF (a, b) ANDOR (\n -- l\n c);\n",
    ].freeze

    {
      "Parser.from_file" => from_file,
      "Parser.from_exp" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    }.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:parse) { parse }
        let(:wrap) { ->(body) { self.class.superclass.wrapped(body) } }

        let(:listed) do
          "  ONEOF (a, -- from the first module\n         b, -- from the second module\n         " \
            "c); -- from the third module\n"
        end

        it "writes each comment where it stands in the list" do
          text = parse.call(wrap.call(listed)).format
          expect(text).to include("  ONEOF(a, -- from the first module\n        b, -- from the second module\n        " \
                                  "c); -- from the third module\nEND_SUBTYPE_CONSTRAINT;")
        end

        it "writes the same text again from its own output" do
          once = parse.call(wrap.call(listed)).format
          expect(parse.call(once).format).to eq(once)
        end

        it "holds the remarks on the operands" do
          constraint = parse.call(wrap.call(listed)).schemas.first.subtype_constraints.first
          held = constraint.supertype_expression.operands.map do |op|
            Array(op.untagged_remarks).map { |r| [r.text, r.placement] }
          end
          expect(held).to eq([[["from the first module", "inline"]],
                              [["from the second module", "inline"]],
                              [["from the third module", "inline"]]])
          expect(Array(constraint.untagged_remarks)).to be_empty
        end

        it "writes none of them in the stripped form" do
          text = parse.call(wrap.call(listed)).format(no_remarks: true)
          expect(text).to include("  ONEOF(a, b, c);\nEND_SUBTYPE_CONSTRAINT;")
          expect(text).not_to include("--")
        end

        it "keeps the remarks through a yaml round trip" do
          file = parse.call(wrap.call(listed))
          again = Expressir::Model::ExpFile.from_yaml(file.to_yaml)
          expect(again.format).to eq(file.format)
          expect(again.format).to include("ONEOF(a, -- from the first module")
        end

        it "writes a comment inside a nested expression and one after the semicolon" do
          text = parse.call(wrap.call("  (ONEOF (a, -- first\n          b) ANDOR c); -- last\n")).format
          expect(text).to include("  ONEOF(a, -- first\n        b) ANDOR c; -- last\nEND_SUBTYPE_CONSTRAINT;")
          expect(parse.call(text).format).to eq(text)
        end

        it "writes a comment on a line of its own before an operand" do
          text = parse.call(wrap.call("  ONEOF (\n    -- old_a,\n    a,\n    -- old_b,\n    b,\n    c);\n")).format
          expect(text).to include("  ONEOF(-- old_a,\n        a,\n        -- old_b,\n        b,\n        c);\n")
          expect(parse.call(text).format).to eq(text)
        end

        it "writes a comment after two operands on a line after the second" do
          text = parse.call(wrap.call("  ONEOF (a, b, -- after b\n         c, d);\n")).format
          expect(text).to include("  ONEOF(a,\n        b, -- after b\n        c,\n        d);")
        end

        it "writes a comment after the last operand after the semicolon" do
          text = parse.call(wrap.call("  ONEOF (a,\n         b -- after last\n        );\n")).format
          expect(text).to include("  ONEOF(a,\n        b); -- after last\nEND_SUBTYPE_CONSTRAINT;")
        end

        it "writes an expression without comments as before" do
          text = parse.call(wrap.call("  (ONEOF (a, b) ANDOR c) AND d;\n")).format
          expect(text).to include("  (ONEOF(a, b) ANDOR c) AND d;\nEND_SUBTYPE_CONSTRAINT;")
        end

        # An operand written in parentheses: the span a parser gives it may or
        # may not include the parentheses; the comments are placed the same.
        it "writes a comment after a parenthesized operand after the operand" do
          text = parse.call(wrap.call("  ONEOF ((a), -- x\n b);\n")).format
          expect(text).to include("  ONEOF(a, -- x\n        b);\n")
          text = parse.call(wrap.call("  ONEOF (a, ((b)), -- x\n c);\n")).format
          expect(text).to include("  ONEOF(a,\n        b, -- x\n        c);\n")
          text = parse.call(wrap.call("  ONEOF ((a), -- x\n (b), -- y\n c);\n")).format
          expect(text).to include("  ONEOF(a, -- x\n        b, -- y\n        c);\n")
          expect(parse.call(text).format).to eq(text)
        end

        it "writes a comment after a parenthesized last operand after the semicolon" do
          text = parse.call(wrap.call("  (b ANDOR ONEOF ( d , b , c , (c) )) -- c1\n;\n")).format
          expect(text).to include("  b ANDOR ONEOF(d,\n        b,\n        c,\n        c); -- c1\n" \
                                  "END_SUBTYPE_CONSTRAINT;")
          expect(parse.call(text).format).to eq(text)
        end

        # A block comment follows an operand as a line comment does.
        it "keeps a block comment after the last operand through a second pass" do
          bodies = ["  ONEOF (c, b) (* b1 *) ; -- c2\n", "  ONEOF (c, b) (* b1 *); -- c2\n",
                    "  ONEOF (a, b); (* x *) -- y\n", "  ONEOF (a, b); (* x *)\n"]
          bodies.each do |body|
            once = parse.call(wrap.call(body)).format
            expect(once).to include("(*")
            expect(parse.call(once).format).to eq(once)
          end
          text = parse.call(wrap.call("  ONEOF (c, b) (* b1 *) ; -- c2\n")).format
          expect(text).to include("  ONEOF(c,\n        b); (* b1 *)\nEND_SUBTYPE_CONSTRAINT; -- c2")
        end

        it "keeps a block comment between two operands after the comma" do
          text = parse.call(wrap.call("  ONEOF (a, (* x *) b -- y\n  , c);\n")).format
          expect(text).to include("  ONEOF(a, (* x *)\n        b,\n        c);\nEND_SUBTYPE_CONSTRAINT; -- y")
          expect(parse.call(text).format).to eq(text)
        end

        # Not changed: the comments of ABSTRACT SUPERTYPE and TOTAL_OVER, a
        # comment after an operator, and one after an inner ONEOF.
        it "writes the comments of the other lines of the constraint as before" do
          text = parse.call(wrap.call("  ABSTRACT SUPERTYPE; -- abstract\n  TOTAL_OVER (a, -- total a\n              b); -- total b\n  ONEOF (a, b);\n")).format
          expect(text).to include("  ABSTRACT SUPERTYPE;\n  TOTAL_OVER(a, b);\n  ONEOF(a, b);\n" \
                                  "END_SUBTYPE_CONSTRAINT; -- abstract\n-- total a\n-- total b\n")
        end

        it "writes a comment after an operator as before" do
          text = parse.call(wrap.call("  (ONEOF (a, b) ANDOR -- after operator\n   c);\n")).format
          expect(text).to include("  ONEOF(a, b) ANDOR c;\nEND_SUBTYPE_CONSTRAINT; -- after operator")
        end

        it "writes a comment after an inner ONEOF as before" do
          text = parse.call(wrap.call("  ONEOF (a, ONEOF (b, c) -- after inner\n         , d);\n")).format
          expect(text).to include("  ONEOF(a, ONEOF(b, c), d);\nEND_SUBTYPE_CONSTRAINT; -- after inner")
        end

        # A comment before an operand leads it when the last code before the
        # comment is a comma or the parenthesis that opens a ONEOF list, and
        # only the white space and comments of the source lie between the
        # comment and the operand's name.
        # A form feed after the comment is white space, as a blank is, in
        # every way of reading.
        it "leads the operand when a form feed follows the comment" do
          text = parse.call(wrap.call("  ONEOF (a,\n (* c *)\f\n b);\n")).format
          expect(text).to include("  ONEOF(a,\n        (* c *)\n        b);\n")
          text = parse.call(wrap.call("  ONEOF (a,\n (* c *) \f\n b);\n")).format
          expect(text).to include("  ONEOF(a,\n        (* c *)\n        b);\n")
        end

        it "writes a comment before an operand after the parenthesis of the list or a comma" do
          text = parse.call(wrap.call("  ONEOF (\n -- l\n a,\n -- m\n b);\n")).format
          expect(text).to include("  ONEOF(-- l\n        a,\n        -- m\n        b);\n")
          expect(parse.call(text).format).to eq(text)
        end

        it "keeps a block comment after a comma with the operand before a parenthesized operand" do
          text = parse.call(wrap.call("  ONEOF (a, (* l *)\n (b), c);\n")).format
          expect(text).to include("  ONEOF(a, (* l *)\n        b,\n        c);\n")
          expect(parse.call(text).format).to eq(text)
        end

        not_taken.each do |body, expected|
          it "writes #{body.inspect} as before" do
            text = parse.call(wrap.call(body)).format
            expect(text).to include("SUBTYPE_CONSTRAINT k FOR t;\n#{expected}")
            expect(parse.call(text).format).to eq(text)
          end
        end

        after_operator.each do |body|
          it "keeps the comment after the constraint in #{body.inspect}" do
            text = parse.call(wrap.call(body)).format
            expect(text).to include("END_SUBTYPE_CONSTRAINT; -- l\n")
            expect(parse.call(text).format).to eq(text)
          end
        end

        # After the name of the last operand and inside its parentheses the
        # comment follows the operand, as the Rust parser spans it (the name).
        after_name.each do |body, comment|
          it "writes the comment after the name in #{body.inspect} after the semicolon" do
            text = parse.call(wrap.call(body)).format
            expect(text).to include("  ONEOF(a,\n        b); #{comment}\nEND_SUBTYPE_CONSTRAINT;")
            expect(parse.call(text).format).to eq(text)
          end
        end

        # A comment before the name of an operand, inside its parentheses, is
        # held by no operand.
        it "does not hold a comment inside the parentheses of an operand on that operand" do
          constraint = parse.call(wrap.call("  ONEOF (a, (-- x\n b));\n")).schemas.first.subtype_constraints.first
          operands = constraint.supertype_expression.operands
          expect(operands.map { |op| Array(op.untagged_remarks) }).to all(be_empty)
        end
      end
    end
  end
end
