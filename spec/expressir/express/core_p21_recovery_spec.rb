# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# The P21 recovery envelope through the ruby surface (#627): the
# population on well-formed input, the failure forensics on malformed
# input. Recovery is Rust-only — the no-native lanes skip.
RSpec.describe Expressir::Express::Core do
  before do
    skip "native extension not available" unless Expressir::Express::Core::NATIVE_AVAILABLE &&
      Expressir::Core.respond_to?(:parse_population_recovering)
  end

  let(:population) do
    <<~P21
      ISO-10303-21;
      HEADER;
      FILE_SCHEMA(('DEMO'));
      ENDSEC;
      DATA;
      #1=THING('a');
      #2=OTHER('b');
      ENDSEC;
      END-ISO-10303-21;
    P21
  end

  it "builds the population on well-formed input" do
    envelope = described_class.parse_population_recovering(population)

    expect(envelope["ok"]).to be(true)
    records = envelope.dig("population", "records")
    expect(records.map { |r| r["keyword"] }).to eq(%w[THING OTHER])
    expect(envelope["error"]).to be_nil
  end

  it "returns forensics on malformed input, strict staying loud" do
    junked = population.sub("ENDSEC;\nEND-ISO-10303-21;",
                            "\n#9999=JUNK(%%%);\nENDSEC;\nEND-ISO-10303-21;")

    envelope = described_class.parse_population_recovering(junked)

    expect(envelope["ok"]).to be(false)
    error = envelope["error"]
    expect(error["offset"]).to be_a(Integer)
    expect(error["expected"]).not_to be_empty
    expect(envelope["consumed_upto"]).to eq(error["offset"])
    expect(envelope["population"]).to be_nil
  end
end
