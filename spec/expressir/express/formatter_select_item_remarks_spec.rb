# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# A comment inside the item list of a SELECT type is written back where it
# stands: after the item it follows on its line, or on a line of its own
# before the item it precedes. Before, the TYPE held these remarks with no
# placement and they were written after `END_TYPE;`. The items are handled
# as the items of an ENUMERATION are.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "the comments in the item list of a SELECT" do
    let(:source) do
      <<~EXP
        SCHEMA select_probe;
        TYPE first_select = SELECT (a, -- after the first item
           b);
        END_TYPE;
        TYPE second_select = SELECT (
          a, -- after an item
          -- on its own line between two items
          b, -- after the second item
          c); -- after the list
        END_TYPE;
        TYPE third_select = EXTENSIBLE GENERIC_ENTITY SELECT
          (-- after the parenthesis
           a,
           b);
        END_TYPE;
        TYPE fourth_select = SELECT BASED_ON third_select WITH (
          -- on its own line before the first item
          c);
        END_TYPE;
        ENTITY a;
        END_ENTITY;
        ENTITY b;
        END_ENTITY;
        ENTITY c;
        END_ENTITY;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA select_probe;

        TYPE first_select = SELECT
          (a, -- after the first item
           b);
        END_TYPE;

        TYPE second_select = SELECT
          (a, -- after an item
           -- on its own line between two items
           b, -- after the second item
           c); -- after the list
        END_TYPE;

        TYPE third_select = EXTENSIBLE GENERIC_ENTITY SELECT
          (-- after the parenthesis
           a,
           b);
        END_TYPE;

        TYPE fourth_select = SELECT BASED_ON third_select WITH
          (-- on its own line before the first item
           c);
        END_TYPE;

        ENTITY a;
        END_ENTITY;

        ENTITY b;
        END_ENTITY;

        ENTITY c;
        END_ENTITY;

        END_SCHEMA;
      EXP
    end

    def self.wrapped(body)
      "SCHEMA s;\n#{body}ENTITY a;\nEND_ENTITY;\nENTITY b;\nEND_ENTITY;\nENTITY c;\nEND_ENTITY;\nEND_SCHEMA;\n"
    end

    from_file = lambda do |text|
      Tempfile.create(["select_probe", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end

    {
      "Parser.from_file" => from_file,
      "Parser.from_exp" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    }.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes each comment where it stands in the list" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "holds the remarks on the items" do
          type = file.schemas.first.types[1]
          held = type.underlying_type.items.map do |item|
            Array(item.untagged_remarks).map { |r| [r.text, r.placement] }
          end
          expect(held).to eq([
                               [["after an item", "inline"]],
                               [["on its own line between two items", "leading"],
                                ["after the second item", "inline"]],
                               [["after the list", "inline"]],
                             ])
          expect(Array(type.untagged_remarks)).to be_empty
        end

        it "writes none of them in the stripped form" do
          expect(file.schemas.first.format(no_remarks: true)).not_to include("--")
        end

        # As for the last item of an ENUMERATION: before the `)` a tail
        # remark would take the `)` and the `;` with it.
        it "writes a comment after the last item after the semicolon" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a,\n   b -- after the last item\n  );\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b); -- after the last item\nEND_TYPE;")
        end

        it "keeps a comment after a select on one line on the line of the semicolon" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT (a, b); -- after the select\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b); -- after the select\nEND_TYPE;")
        end

        it "writes a comment after two items on a line after the second" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a, b, -- after two items\n   c);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b, -- after two items\n   c);")
        end

        it "writes a block comment after an item before the next item" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a, (* about b *)\n   b);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   (* about b *)\n   b);")
        end

        it "leaves a comment of a WHERE rule of the type with the rule" do
          body = "TYPE t = SELECT\n  (a, -- first\n   b);\nWHERE\n  wr1 : TRUE; -- of the rule\nEND_TYPE;\n"
          expect(parse.call(self.class.wrapped(body)).format)
            .to include("  (a, -- first\n   b);\nWHERE\n  wr1: TRUE; -- of the rule\nEND_TYPE;")
        end

        # Not changed: a comment between `SELECT` and the parenthesis, one
        # on a line of its own after the last item, and the head of a RULE,
        # whose `FOR` items are references too.
        it "writes a comment before the parenthesis as before" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT -- before the parenthesis\n  (a,\n   b);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b);\nEND_TYPE; -- before the parenthesis")
        end

        it "writes a comment on its own line after the last item as before" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a,\n   b\n   -- after the last item\n  );\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b);\nEND_TYPE; -- after the last item")
        end

        it "writes a comment on the head of a rule as before" do
          text = parse.call(self.class.wrapped("RULE r FOR (a, b); -- on the rule head\nWHERE\n  wr1 : TRUE;\nEND_RULE;\n")).format
          expect(text).to include("RULE r FOR (a, b);\n  -- on the rule head\nWHERE")
        end

        # A remark on a line of its own before an item is written at the
        # depth of the items, in an ENUMERATION as in a SELECT.
        it "keeps the indentation of an item after a comment" do
          text = parse.call(self.class.wrapped("TYPE e = ENUMERATION OF\n  (p,\n   -- before q\n   q);\nEND_TYPE;\n")).format
          expect(text).to include("  (p,\n   -- before q\n   q);")
        end

        # Seen in review. The lines inside a remark of several lines are
        # left as the formatter writes them; the remark and the item after
        # it start at the depth of the items.
        it "keeps the inner lines of a remark of several lines" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a,\n   (* c\n   d\n   e *)\n   b);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   (*\n  c\n     d\n     e\n  *)\n   b);")
          text = parse.call(self.class.wrapped("TYPE e = ENUMERATION OF\n  (p,\n   (* c\n   d\n   e *)\n   q);\nEND_TYPE;\n")).format
          expect(text).to include("  (p,\n   (*\n  c\n     d\n     e\n  *)\n   q);")
        end

        # Seen in review. Not changed: a block comment with code after it on
        # its line (it is not written, as before), and a comment on a line
        # of its own between `SELECT` and the parenthesis.
        it "leaves a block comment with code after it as before" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  (a, (* x *) b,\n   c);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b,\n   c);\nEND_TYPE;\n")
          expect(text).not_to include("(* x *)")
        end

        it "writes a comment on its own line before the parenthesis as before" do
          text = parse.call(self.class.wrapped("TYPE t = SELECT\n  -- before the parenthesis\n  (a,\n   b);\nEND_TYPE;\n")).format
          expect(text).to include("  (a,\n   b);\nEND_TYPE; -- before the parenthesis")
        end

        it "keeps the remarks of the items through a yaml round trip" do
          again = Expressir::Model::ExpFile.from_yaml(file.to_yaml)
          expect(again.schemas.first.format).to eq(file.schemas.first.format)
          expect(again.schemas.first.format).to include("(a, -- after an item")
        end
      end
    end
  end
end
