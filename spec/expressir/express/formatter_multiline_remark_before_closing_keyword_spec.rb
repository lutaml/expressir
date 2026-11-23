# frozen_string_literal: true

require "spec_helper"
require "tempfile"

module MultilineRemarkHelpers
  module_function

  def function(body)
    "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL x : INTEGER; END_LOCAL;\n#{body}  RETURN (1);\nEND_FUNCTION;\n"
  end

  # Every remark held by the model, in the order of a depth-first walk.
  def collect_remarks(node, found = [])
    case node
    when Array then node.each { |x| collect_remarks(x, found) }
    when Expressir::Model::ModelElement
      found.concat(Array(node.untagged_remarks)) if node.respond_to?(:untagged_remarks)
      node.instance_variables.each do |iv|
        next if iv == :@parent

        collect_remarks(node.instance_variable_get(iv), found)
      end
    end
    found
  end

  # Every fragment is written, in order, and the text after the last one
  # holds only the end of the comment and blanks up to the keyword.
  def in_place?(out, fragments, keyword)
    last = out.rindex(fragments.last)
    return false unless last
    return false unless fragments.each_cons(2).all? { |a, b| out.index(a) < out.index(b) }

    rest = out[(last + fragments.last.length)..]
    rest.match?(/\A\s*(\*\)\s*)?#{Regexp.escape(keyword)}/)
  end
end

# A comment of several lines on a line of its own before a closing keyword is
# written back before that keyword. The lookup of the keyword started on the
# second line of the comment, read the rest of the comment as code, and found
# no keyword: the comment was lost before ELSE, END_IF, OTHERWISE, END_CASE,
# END, WHERE of a RULE, END_FUNCTION, END_PROCEDURE and END_RULE.
RSpec.describe Expressir::Express::Formatter do
  describe "a comment of several lines on its own line before a closing keyword" do
    # keyword => [source builder, keyword as written by the formatter]
    constructs = {
      "ELSE" => ->(c) { "  IF p > 0 THEN\n    x := 1;\n  #{c}\n  ELSE\n    x := 2;\n  END_IF;\n" },
      "END_IF" => ->(c) { "  IF p > 0 THEN\n    x := 1;\n  #{c}\n  END_IF;\n" },
      "OTHERWISE" => ->(c) { "  CASE p OF\n    1 : x := 1;\n  #{c}\n  OTHERWISE : x := 2;\n  END_CASE;\n" },
      "END_CASE" => ->(c) { "  CASE p OF\n    1 : x := 1;\n  #{c}\n  END_CASE;\n" },
      "END;" => ->(c) { "  BEGIN\n    x := 1;\n  #{c}\n  END;\n" },
      "WHERE" => nil,
      "END_FUNCTION" => nil,
      "END_PROCEDURE" => nil,
      "END_RULE" => nil,
    }
    sources = {}
    constructs.each do |keyword, build|
      sources[keyword] =
        case keyword
        when "WHERE"
          ->(c) { "RULE r FOR (a);\n  LOCAL y : INTEGER; END_LOCAL;\n  y := 1;\n  #{c}\nWHERE\n  wr1 : TRUE;\nEND_RULE;\n" }
        when "END_RULE"
          ->(c) { "RULE r FOR (a);\n  y := 1;\nWHERE\n  wr1 : TRUE;\n  #{c}\nEND_RULE;\n" }
        when "END_FUNCTION"
          lambda { |c|
            "FUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL x : INTEGER; END_LOCAL;\n  x := 1;\n  #{c}\nEND_FUNCTION;\n"
          }
        when "END_PROCEDURE"
          ->(c) { "PROCEDURE pr(p : INTEGER);\n  LOCAL x : INTEGER; END_LOCAL;\n  x := 1;\n  #{c}\nEND_PROCEDURE;\n" }
        else
          ->(c) { MultilineRemarkHelpers.function(build.call(c)) }
        end
    end

    # form => [comment text with KW for the keyword, fragments in order]
    forms = {
      "a block of two lines" => ["(* a note\n     over two lines *)", ["a note", "over two lines"]],
      "a block of three lines" => ["(* c1\n     c2\n     c3 *)", %w[c1 c2 c3]],
      "a block whose first line is (* alone" => ["(*\n     c1\n     c2\n  *)", %w[c1 c2]],
      "a nested block of several lines" => ["(* c1 (* c2\n     c3 *) c4\n     c5 *)", %w[c1 c2 c3 c4 c5]],
      "a -- comment and a block of several lines" => ["-- c1\n  (* c2\n     c3 *)", %w[c1 c2 c3]],
      "a block of several lines and a -- comment" => ["(* c1\n     c2 *)\n  -- c3", %w[c1 c2 c3]],
      "a block naming the keyword" => ["(* KW\n     note KW *)", ["note KW"]],
      "a block naming another keyword" => ["(* END_IF ELSE\n     note OTHERWISE *)", ["note OTHERWISE"]],
      "a block followed by blank lines" => ["(* c1\n     c2 *)\n\n\n", %w[c1 c2]],
    }

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["multiline_remark", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    sources.each do |keyword, build|
      forms.each do |form, (comment, fragments)|
        # A first line that names END_FUNCTION, END_PROCEDURE or END_RULE is
        # read as a comment on that END_ line, whatever follows: not this case.
        next if form == "a block naming the keyword" && keyword.match?(/END_(FUNCTION|PROCEDURE|RULE)/)

        lanes.each do |lane, parse|
          context "with #{form} before #{keyword}, read by #{lane}" do
            let(:text) { "SCHEMA s;\n#{build.call(comment.gsub('KW', keyword.delete(';')))}END_SCHEMA;\n" }
            let(:file) { parse.call(text) }
            let(:frags) { fragments.map { |f| f.gsub("KW", keyword.delete(";")) } }

            it "writes every line of the comment before the keyword" do
              expect(MultilineRemarkHelpers.in_place?(file.format, frags, keyword)).to be(true), file.format
            end

            it "writes the same comment again from its own output" do
              once = file.format
              twice = parse.call(once).format
              expect(MultilineRemarkHelpers.in_place?(twice, frags, keyword)).to be(true), twice
            end

            it "holds the comment as trailing, and none in the stripped form" do
              remarks = MultilineRemarkHelpers.collect_remarks(file)
              expect(remarks.map(&:placement)).to all(eq("trailing"))
              expect(remarks).not_to be_empty
              stripped = file.format(no_remarks: true)
              expect(stripped).not_to include("(*")
              expect(stripped).not_to include("--")
            end
          end
        end
      end
    end

    # Code after the `*)` on the comment's last line: the comment is not on
    # lines of its own before the keyword, and stays where it was written
    # (the first two). Only comments after the `*)`: it is before the keyword.
    [
      ["    (* a\n       b *) y := 2;\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    y := 2;\n  ELSE\n"],
      ["    (* a\n       b *) (* c *) y := 2;\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    y := 2;\n    (* c *)\n  ELSE\n"],
      ["    (* a\n       b *) -- tail\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    -- tail\n  ELSE\n"],
      ["    (* a\n       b *) (* c *)\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    (* c *)\n  ELSE\n"],
      # After a comment of several lines, a block comment on the next line
      # with code after it is a code line too: the comment before it leads
      # that code. A comment of ONE line in that place is written as before
      # (the last four).
      ["    (* a\n       b *)\n    (* f *) y := 2;\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    y := 2;\n    (* f *)\n  ELSE\n"],
      ["    (* a\n       b *)\n    (* f\n       g *) y := 2;\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    (*\n    f\n           g\n    *)\n    y := 2;\n  ELSE\n"],
      ["    (* a *)\n    (* f *) y := 2;\n", "    y := 1;\n    y := 2;\n    (* a *)\n    (* f *)\n  ELSE\n"],
      ["    -- a\n    (* f *) y := 2;\n", "    y := 1;\n    y := 2;\n    -- a\n    (* f *)\n  ELSE\n"],
      ["    y := 2; (* r *)\n    (* f *) y := 6;\n", "    y := 1;\n    y := 2;\n    y := 6;\n    (* r *)\n    (* f *)\n  ELSE\n"],
      ["    (* a\n       b *) (* c *) y := 2;\n    (* f *) y := 6;\n", "    y := 1;\n    (*\n    a\n           b\n    *)\n    y := 2;\n    y := 6;\n    (* c *)\n    (* f *)\n  ELSE\n"],
    ].each_with_index do |(body, expected), n|
      lanes.each do |lane, parse|
        it "keeps the comment before code that follows on its last line (#{n + 1}), read by #{lane}" do
          head = "SCHEMA s;\nFUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL\n    y : INTEGER;\n  END_LOCAL;\n  IF p > 0 THEN\n    y := 1;\n"
          tail = "  ELSE\n    y := 3;\n  END_IF;\n  RETURN (y);\nEND_FUNCTION;\nEND_SCHEMA;\n"
          expect(parse.call("#{head}#{body}#{tail}").format).to include(expected)
        end
      end
    end

    it "leaves a comment of several lines between two statements as it was" do
      text = "SCHEMA s;\nFUNCTION f(p : INTEGER) : INTEGER;\n  LOCAL x : INTEGER; END_LOCAL;\n  x := 1;\n  (* c1\n     c2 *)\n  x := 2;\n  RETURN (x);\nEND_FUNCTION;\nEND_SCHEMA;\n"
      out = Expressir::Express::Parser.from_exp(text).format
      expect(out).to match(/x := 1;\n\s+\(\*\n?\s*c1\s+c2\s*\*?\)?\n?\s*x := 2;/)
      expect(MultilineRemarkHelpers.collect_remarks(Expressir::Express::Parser.from_exp(text)).map(&:placement)).to eq(["leading"])
    end

    it "keeps a comment of several lines before a declaration with the declaration" do
      text = "SCHEMA s;\n(* c1\n   c2 *)\nENTITY e;\n  a : INTEGER;\nEND_ENTITY;\nEND_SCHEMA;\n"
      out = Expressir::Express::Parser.from_exp(text).format
      expect(out.index("c2")).to be < out.index("ENTITY e")
    end

    it "keeps the comments before END_REPEAT and END_ALIAS" do
      %w[END_REPEAT END_ALIAS].each do |keyword|
        body = if keyword == "END_REPEAT"
                 "  REPEAT i := 1 TO 3;\n    x := 1;\n  (* c1\n     c2\n     c3 *)\n  END_REPEAT;\n"
               else
                 "  ALIAS q FOR x;\n    x := 1;\n  (* c1\n     c2\n     c3 *)\n  END_ALIAS;\n"
               end
        out = Expressir::Express::Parser.from_exp("SCHEMA s;\n#{MultilineRemarkHelpers.function(body)}END_SCHEMA;\n").format
        expect(MultilineRemarkHelpers.in_place?(out, %w[c1 c2 c3], keyword)).to be(true), out
      end
    end
  end
end
