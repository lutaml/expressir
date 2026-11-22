# frozen_string_literal: true

require "spec_helper"

# Printed EXPRESS keeps the parentheses of the source (#707, WG 12's
# requirement from #651): the printer neither adds nor removes a pair —
# the groups the source wrote survive even where operator precedence
# would not need them.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA parens;
      ENTITY e;
        a : INTEGER;
        b : INTEGER;
        c : INTEGER;
        d : INTEGER;
      WHERE
        WR1: ((a > 1) AND (a < 10));
        WR2: ((a + 1) * 2) > a;
        WR3: (a + b) * c = d;
        WR4: (a + b) + c = d;
      END_ENTITY;
      FUNCTION f(x : INTEGER) : INTEGER;
        RETURN (((x)));
      END_FUNCTION;
      END_SCHEMA;
    EXP
  end

  def round_trip
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
  end

  {
    "WR1" => "((a > 1) AND (a < 10))",
    "WR2" => "((a + 1) * 2) > a",
    "WR3" => "(a + b) * c = d",
    "WR4" => "(a + b) + c = d",
    "RETURN" => "(((x)))",
  }.each do |id, expected|
    it "keeps the source pairs of #{id}" do
      line = round_trip.lines.find { |l| l.include?(id) }
      expect(line).to include(expected), "#{id}: #{line&.strip.inspect}"
    end
  end

  it "formats to a fixed point" do
    once = round_trip
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once),
    )

    expect(twice).to eq(once)
  end
end
