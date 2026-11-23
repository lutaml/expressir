# frozen_string_literal: true

require "spec_helper"

# The pretty face's plain form keeps the same-line comments (#734):
# keep_untagged_remarks rides the option set the same way the source
# formatter's does (#722).
RSpec.describe Expressir::Express::PrettyFormatter do
  let(:source) do
    <<~EXP
      SCHEMA probe;
      ENTITY point;
        x : REAL; -- the abscissa
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  def parse
    Expressir::Express::Parser.from_exp(source)
  end

  it "keeps the same-line comment in the pretty plain form" do
    pretty = described_class.new(no_remarks: true, keep_untagged_remarks: true)
      .format(parse)

    expect(pretty).to include("-- the abscissa")
  end

  it "still strips it with no_remarks alone" do
    pretty = described_class.new(no_remarks: true).format(parse)

    expect(pretty).not_to include("-- the abscissa")
  end

  it "keeps it on the full pretty face" do
    pretty = described_class.new.format(parse)

    expect(pretty).to include("-- the abscissa")
  end
end
