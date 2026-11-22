# frozen_string_literal: true

require "spec_helper"

# The declarations of a schema stand in the order of the source (#711,
# WG 12's plain-schema rule): format does not regroup them by kind.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA order_probe;
      ENTITY b_entity;
        x : INTEGER;
      END_ENTITY;
      TYPE a_type = INTEGER;
      END_TYPE;
      FUNCTION c_function(x : INTEGER) : INTEGER;
        RETURN (x);
      END_FUNCTION;
      END_SCHEMA;
    EXP
  end

  def round_trip
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_exp(source),
    )
  end

  it "writes the declarations in the order of the source" do
    heads = round_trip.lines.grep(/\A(ENTITY|TYPE|FUNCTION|CONSTANT|RULE|PROCEDURE)\b/)

    expect(heads).to eq([
                          "ENTITY b_entity;\n",
                          "TYPE a_type = INTEGER;\n",
                          "FUNCTION c_function(x : INTEGER) : INTEGER;\n",
                        ])
  end

  it "formats to a fixed point" do
    once = round_trip
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once),
    )

    expect(twice).to eq(once)
  end

  it "keeps the grouped layout for schemas without an order" do
    grouped_source = <<~EXP
      SCHEMA grouped;
      TYPE t = INTEGER;
      END_TYPE;
      ENTITY e;
        x : t;
      END_ENTITY;
      END_SCHEMA;
    EXP
    out = described_class.format(
      Expressir::Express::Parser.from_exp(grouped_source),
    )
    heads = out.lines.grep(/\A(ENTITY|TYPE)\b/)

    expect(heads).to eq(["TYPE t = INTEGER;\n", "ENTITY e;\n"])
  end
end
