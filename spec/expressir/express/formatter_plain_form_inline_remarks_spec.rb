# frozen_string_literal: true

require "spec_helper"

# The plain form — format(no_remarks: true, keep_untagged_remarks: true),
# the call suma makes for a plain schema — keeps the untagged comments of
# the source and leaves out the tagged descriptions. A comment at the end
# of a code line is one of them: the plain form writes it on the line
# where format writes it.
RSpec.describe Expressir::Express::Formatter do
  describe "the plain form and the comments at the end of a code line" do
    let(:source) do
      <<~EXP
        SCHEMA inline_probe;
        USE FROM other_schema; -- end of a USE FROM line
        REFERENCE FROM third_schema (g); -- end of a REFERENCE FROM line
        ENTITY point;
          x : REAL; -- end of an attribute line
          y : REAL;
        END_ENTITY;
        FUNCTION f(a : INTEGER) : INTEGER;
          LOCAL
            r : INTEGER := 0; -- end of a local variable line
          END_LOCAL;
          IF a > 0 THEN -- end of an IF line
            r := a; -- end of a statement line
          END_IF;
          CASE a OF
            1 : -- after a case label
              r := 1;
            OTHERWISE : r := 2;
          END_CASE;
          RETURN (r); -- end of a RETURN line
        END_FUNCTION;
        END_SCHEMA;
        (*"inline_probe.point"
        A tagged description.
        *)
      EXP
    end

    comments = ["end of a USE FROM line", "end of a REFERENCE FROM line",
                "end of an attribute line", "end of a local variable line",
                "end of an IF line", "end of a statement line",
                "after a case label", "end of a RETURN line"].freeze

    def line_of(text, comment)
      text.lines.find { |line| line.include?(comment) }
    end

    { "the core lane" => {}, "the Ruby builders" => { use_native: false } }.each do |lane, options|
      context "with a file read by #{lane}" do
        let(:schema) do
          Expressir::Express::Parser.from_exp(source, **options).schemas.first
        end
        let(:ordinary) { schema.format }
        let(:plain) { schema.format(no_remarks: true, keep_untagged_remarks: true) }

        comments.each do |comment|
          it "writes the comment (#{comment}) where format writes it" do
            expect(line_of(ordinary, comment)).not_to be_nil
            expect(line_of(plain, comment)).to eq(line_of(ordinary, comment))
          end

          it "writes no comment (#{comment}) when only no_remarks is set" do
            expect(schema.format(no_remarks: true)).not_to include(comment)
          end
        end

        it "leaves out the tagged description" do
          expect(ordinary).to include("A tagged description.")
          expect(plain).not_to include("A tagged description.")
        end

        it "has the code of the stripped form" do
          stripped = schema.format(no_remarks: true)
          without_comments = plain.lines.map { |line| line.sub(/\s*--.*$/, "").rstrip }
          expect(without_comments.reject(&:empty?))
            .to eq(stripped.lines.map(&:rstrip).reject(&:empty?))
        end
      end
    end
  end
end
