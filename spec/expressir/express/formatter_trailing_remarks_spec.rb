require "spec_helper"

RSpec.describe Expressir::Express::Formatter do
  describe "comments closing a body" do
    let(:source) do
      <<~EXPRESS
        SCHEMA trailing_remark_schema;
          ENTITY thing; END_ENTITY;
          FUNCTION probe(input : INTEGER) : LOGICAL;
            LOCAL
              total : INTEGER := 0;
            END_LOCAL;
            CASE input OF
              1 :
                total := 1;
                -- CLOSES-ACTION before OTHERWISE
              OTHERWISE :
                total := 3;
                -- CLOSES-OTHERWISE before END_CASE
            END_CASE;
            BEGIN
              total := total + 1;
              -- CLOSES-COMPOUND before END
            END;
            RETURN (TRUE);

            -- CLOSES-FUNCTION after a blank line
          END_FUNCTION;
          RULE checks FOR (thing);
            ;
            -- CLOSES-RULE-BODY before WHERE
          WHERE
            wr1: TRUE;
          END_RULE;
        END_SCHEMA;
      EXPRESS
    end
    let(:repo) { Expressir::Express::Parser.from_exp(source) }
    let(:formatted) { described_class.format(repo) }
    let(:lines) { formatted.lines.map(&:rstrip) }

    def line_after(marker)
      idx = lines.index { |l| l.include?(marker) }
      raise "#{marker} not rendered" unless idx

      lines[idx + 1]
    end

    {
      "CLOSES-ACTION" => "OTHERWISE",
      "CLOSES-OTHERWISE" => "END_CASE",
      "CLOSES-COMPOUND" => "END;",
      "CLOSES-FUNCTION" => "END_FUNCTION",
      "CLOSES-RULE-BODY" => "WHERE",
    }.each do |marker, keyword|
      it "renders #{marker} immediately above #{keyword}" do
        expect(formatted.scan(marker).size).to eq(1)
        expect(line_after(marker)).to include(keyword)
      end
    end

    it "never leaves a comment trailing a closing keyword" do
      trailers = lines.select { |l| l =~ /END_\w+;.*--/ || l =~ /\AEND;.*--/ }

      expect(trailers).to be_empty
    end

    it "agrees with PrettyFormatter on every marker" do
      pretty = Expressir::Express::PrettyFormatter.new.format(repo)

      %w[CLOSES-ACTION CLOSES-OTHERWISE CLOSES-COMPOUND CLOSES-FUNCTION
         CLOSES-RULE-BODY].each do |marker|
        expect(pretty.scan(marker).size).to eq(formatted.scan(marker).size),
                                            "#{marker} differs between formatters"
      end
    end

    it "emits nothing when remarks are suppressed" do
      bare = described_class.new(no_remarks: true).format(repo)

      expect(bare).not_to include("CLOSES-")
    end
  end
end
