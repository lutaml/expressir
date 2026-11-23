# frozen_string_literal: true

require "spec_helper"

# The same-line remarks of a CONSTANT and a UNIQUE rule keep rendering
# (#735): the attach places them on the declaration and the emitters
# write the tail back after the `;`. The render reparses to itself.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA s;
      CONSTANT circle_constant : REAL := 3.14; -- the circle constant
      END_CONSTANT;
      ENTITY e;
        id : STRING;
        size : INTEGER;
        UNIQUE
          u1 : id; -- the identifier
        WHERE
          wr1 : size > 0;
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  def round_trip
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source, skip_references: true),
    )
  end

  {
    "the constant" => "-- the circle constant",
    "the unique rule" => "-- the identifier",
  }.each do |spot, remark|
    it "keeps the comment of #{spot}" do
      expect(round_trip).to include(remark)
    end
  end

  it "formats to a fixed point" do
    once = round_trip
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once, skip_references: true),
    )

    expect(twice).to eq(once)
  end
end
