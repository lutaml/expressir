# frozen_string_literal: true

require "spec_helper"

# #558: the parameter list is optional within the parentheses —
# ISO 10303-11:2004 syntax 253 (function_head) and 316
# (procedure_head) — so `FUNCTION f() : T;` and `PROCEDURE p();`
# parse on both engines and the empty parentheses round trip.
RSpec.describe Expressir::Express::Parser do
  def parse(source, **options)
    described_class.from_exp(source, **options)
  end

  %i[ruby native].each do |lane|
    it "parses a zero-argument function on the #{lane} engine" do
      use_native = lane == :native
      repo = parse("SCHEMA t;\nFUNCTION f() : INTEGER;\nRETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n",
                   use_native: use_native)
      fn = repo.schemas.first.functions.first

      expect(fn.id).to eq("f")
      expect(fn.parameters).to eq([])
    end

    it "parses a zero-argument procedure on the #{lane} engine" do
      use_native = lane == :native
      repo = parse("SCHEMA t;\nPROCEDURE p();\nEND_PROCEDURE;\nEND_SCHEMA;\n",
                   use_native: use_native)
      procedure = repo.schemas.first.procedures.first

      expect(procedure.id).to eq("p")
      expect(procedure.parameters).to eq([])
    end
  end

  it "distinguishes empty parentheses from no parentheses" do
    repo = parse("SCHEMA t;\nFUNCTION f() : INTEGER;\nRETURN (1);\nEND_FUNCTION;\nFUNCTION g : INTEGER;\nRETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n")
    f, g = repo.schemas.first.functions

    expect(f.parameters).to eq([])
    expect(g.parameters).to be_nil
  end
end
