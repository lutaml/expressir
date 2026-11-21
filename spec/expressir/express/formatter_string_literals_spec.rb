# frozen_string_literal: true

require "spec_helper"

# String literal round trips (issues #697 and #698):
#
# - #697: a literal whose body starts with a blank lost the blank at
#   parse on both engines (' ' became '', ' a' became '''), and the
#   ''' spelling the formatter produced for it is not even EXPRESS.
# - #698: the doubled apostrophe is the in-string escape
#   (ISO 10303-11, simple_string_literal); both engines rejected it
#   outright.
#
# The model keeps the source spelling, so the formatter re-emits it
# verbatim and the round trip is exact.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA s;
      CONSTANT
        one_blank : STRING := ' ';
        two_blanks : STRING := '  ';
        leading : STRING := ' a';
        trailing : STRING := 'a ';
        inner : STRING := 'a b';
        empty : STRING := '';
        apos : STRING := 'it''s';
        four : STRING := '''';
        head3 : STRING := '''a';
        tail3 : STRING := 'a''';
        two_literals : STRING := 'a' + 'b';
      END_CONSTANT;
      END_SCHEMA;
    EXP
  end

  def round_trip
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
  end

  it "parses every literal shape" do
    expect { round_trip }.not_to raise_error
  end

  it "writes every literal back unchanged" do
    output = round_trip

    {
      "one_blank" => "' '",
      "two_blanks" => "'  '",
      "leading" => "' a'",
      "trailing" => "'a '",
      "inner" => "'a b'",
      "empty" => "''",
      "apos" => "'it''s'",
      "four" => "''''",
      "head3" => "'''a'",
      "tail3" => "'a'''",
      "two_literals" => "'a' + 'b'",
    }.each do |id, literal|
      line = output.lines.find { |l| l.include?(id) }
      expect(line).not_to be_nil, "#{id} is not written at all"
      expect(line).to include(literal), "#{id} is written as #{line.strip.inspect}"
    end
  end

  it "keeps adjacent literals adjacent" do
    expect(round_trip).to include(":= 'a' + 'b';")
  end

  it "round trips to a fixed point" do
    once = round_trip
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once),
    )

    expect(twice).to eq(once)
  end
end
