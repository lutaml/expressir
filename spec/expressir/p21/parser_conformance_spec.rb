# frozen_string_literal: true

require "spec_helper"
require "expressir"

# TODO.sota/03 part 1: the ISO 10303-21 conformance corpus extracted
# verbatim from the standard's detached source (conformance/
# *.p21). The reader's supported subset parses clean; structures
# beyond the ladder fail loudly rather than being silently accepted.
RSpec.describe Expressir::P21::Parser do
  def fixture(name)
    File.read(Expressir.root_path.join("spec/fixtures/p21/conformance", name))
  end

  it "parses the Annex H complete exchange structure" do
    population = described_class.parse(fixture("annex-h-0.p21"))
    expect(population.instances.size).to eq(13)
  end

  describe "structures beyond the reader's ladder" do
    # Annex E: named DATA sections with schema parameters and `..`
    # header placeholders; Annex I: ANCHOR and REFERENCE sections;
    # Annex J: EXPRESS-constant references and `....` placeholders.
    %w[annex-e-0.p21 annex-e-1.p21 annex-i-0.p21 annex-i-1.p21
       annex-j-0.p21].each do |name|
      it "rejects #{name} loudly" do
        expect { described_class.parse(fixture(name)) }
          .to raise_error(StandardError)
      end
    end
  end

  describe "malformed inputs" do
    it "rejects a truncated exchange structure" do
      expect { described_class.parse("ISO-10303-21;\nHEADER;\n") }
        .to raise_error(StandardError)
    end

    it "rejects a missing END marker" do
      source = fixture("annex-h-0.p21").sub("END-ISO-10303-21;", "")
      expect { described_class.parse(source) }
        .to raise_error(StandardError)
    end

    it "rejects garbage in the data section" do
      source = fixture("annex-h-0.p21").sub("#24=ED_LOOP((#21,#22,#23));", "NOT A RECORD")
      expect { described_class.parse(source) }
        .to raise_error(StandardError)
    end
  end
end
