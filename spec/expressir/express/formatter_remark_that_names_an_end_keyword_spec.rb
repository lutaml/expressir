# frozen_string_literal: true

# rubocop:disable RSpec/LeakyLocalVariable
require "spec_helper"
require "tempfile"

# A comment whose own text names an END_ keyword is not the END line of a
# scope. The attacher asked whether the LINE of a remark held an END_
# keyword, text of the comment included, so `-- before END_FUNCTION` on a
# line of its own was written after `END_FUNCTION;`; a lower-case mention
# was read differently by the Ruby and the Rust attach. The question is now
# asked of the code of the line only, in upper and lower case alike.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "a comment that names an END_ keyword in its own text" do
    keywords = %w[END_SCHEMA END_ENTITY END_TYPE END_FUNCTION END_PROCEDURE END_RULE]
    styles = %i[dash block]
    letter_cases = %i[upper lower]
    places = %i[before_end middle inner tail]

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text).format },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false).format },
      "from_file" => lambda do |text|
        Tempfile.create(["end_keyword_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path).format
        end
      end,
    }

    heads = {
      "END_ENTITY" => ["ENTITY e;\n  x : INTEGER;", "  y : INTEGER;", "END_ENTITY;"],
      "END_TYPE" => ["TYPE t = INTEGER;", nil, "END_TYPE;"],
      "END_FUNCTION" => ["FUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);", "  RETURN (x);", "END_FUNCTION;"],
      "END_PROCEDURE" => ["PROCEDURE p (x : INTEGER);\n  RETURN;", "  RETURN;", "END_PROCEDURE;"],
      "END_RULE" => ["RULE r FOR (e);\nWHERE\n  wr1 : TRUE;", nil, "END_RULE;"],
      "END_SCHEMA" => ["ENTITY e;\n  x : INTEGER;\nEND_ENTITY;", nil, ""],
    }

    host = lambda do |kind, comment, where|
      head, code, tail = heads.fetch(kind)
      body = "#{head}\n"
      case where
      when :before_end then body += "#{comment}\n"
      when :middle then body += "#{comment}\n#{code}\n"
      when :tail then body += "#{code} #{comment}\n"
      when :inner
        body = "ENTITY inner_e;\n  z : INTEGER;\n#{comment}\nEND_ENTITY;\n#{head}\n"
      end
      "SCHEMA s;\n#{body}#{tail}\nEND_SCHEMA;\n"
    end

    comment_of = lambda do |style, word|
      style == :dash ? "-- see #{word}" : "(* see #{word} *)"
    end

    lanes.each do |lane, format|
      context "with a schema read by #{lane}" do
        # Each expectation is built by formatting the same input with a
        # neutral word in the comment and putting the keyword back.
        keywords.each do |kind|
          letter_cases.each do |letters|
            name = letters == :upper ? kind : kind.downcase
            styles.each do |style|
              places.each do |where|
                code = heads.fetch(kind)[1]
                next if where == :middle && code.nil?
                next if where == :tail && code.nil?

                it "writes `#{comment_of.call(style, name)}` naming #{name} (#{where}) where a neutral word goes" do
                  actual = format.call(host.call(kind, comment_of.call(style, name), where))
                  neutral = format.call(host.call(kind, comment_of.call(style, "WORD"), where))
                  expect(actual).to eq(neutral.gsub("WORD", name))
                end
              end
            end
          end
        end

        it "writes a comment naming END_FUNCTION before END_FUNCTION" do
          source = "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);\n  -- this is before END_FUNCTION\nEND_FUNCTION;\nEND_SCHEMA;\n"
          expect(format.call(source)).to eq(<<~EXP)
            SCHEMA s;

            FUNCTION f(x : INTEGER) : INTEGER;
              RETURN (x);
              -- this is before END_FUNCTION
            END_FUNCTION;

            END_SCHEMA;
          EXP
        end

        it "writes a lower-case mention the same way" do
          source = "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);\n  -- before end_function\nEND_FUNCTION;\nEND_SCHEMA;\n"
          expect(format.call(source)).to eq(<<~EXP)
            SCHEMA s;

            FUNCTION f(x : INTEGER) : INTEGER;
              RETURN (x);
              -- before end_function
            END_FUNCTION;

            END_SCHEMA;
          EXP
        end

        it "leaves a remark that follows an END_ keyword where it was" do
          source = "SCHEMA s;\nENTITY person;\n  x : INTEGER;\nEND_ENTITY; -- person\nENTITY dog;\n  y : INTEGER;\nend_entity; -- dog\nTYPE t = INTEGER;\nEND_TYPE; -- t\nEND_SCHEMA; -- s\n"
          expect(format.call(source)).to eq(<<~EXP)
            SCHEMA s;

            ENTITY person;
              x : INTEGER;
            END_ENTITY; -- person

            ENTITY dog;
              y : INTEGER;
            END_ENTITY; -- dog

            TYPE t = INTEGER;
            END_TYPE; -- t

            END_SCHEMA; -- s
          EXP
        end

        # The last line of a block comment of several lines may hold an
        # apostrophe and further comments: none of that line is code.
        it "reads no code in the tail of a block comment of several lines" do
          source = "SCHEMA s;\nENTITY e;\n  a : INTEGER; (* x\n  it's *) (* a *) (* END_ENTITY *)\n  b : INTEGER;\nEND_ENTITY;\nEND_SCHEMA;\n"
          neutral = source.sub("(* END_ENTITY *)", "(* WORD *)")
          expect(format.call(source)).to eq(format.call(neutral).gsub("WORD", "END_ENTITY"))
        end

        it "reads a block comment of several lines at its first line" do
          source = "SCHEMA s;\nENTITY e;\n  x : INTEGER;\n  (* see\n END_SCHEMA for details *)\n  y : INTEGER;\nEND_ENTITY;\nEND_SCHEMA;\n"
          neutral = source.sub("END_SCHEMA for", "WORD for")
          expect(format.call(source)).to eq(format.call(neutral).gsub("WORD", "END_SCHEMA"))
        end

        it "gives the same text again from its own output" do
          source = "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);\n  -- this is before END_FUNCTION\nEND_FUNCTION;\nEND_SCHEMA;\n"
          once = format.call(source)
          expect(format.call(once)).to eq(once)
        end
      end
    end

    it "gives the same text on the three lanes for a lower-case mention" do
      source = "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);\n  -- before end_function\nEND_FUNCTION;\nEND_SCHEMA;\n"
      texts = lanes.values.map { |format| format.call(source) }
      expect(texts.uniq.size).to eq(1)
    end

    it "keeps the stripped form free of comments" do
      source = "SCHEMA s;\nFUNCTION f (x : INTEGER) : INTEGER;\n  RETURN (x);\n  -- this is before END_FUNCTION\nEND_FUNCTION;\nEND_SCHEMA;\n"
      schema = Expressir::Express::Parser.from_exp(source)
      expect(described_class.new(no_remarks: true).format(schema)).not_to include("--")
    end
  end
end
# rubocop:enable RSpec/LeakyLocalVariable
