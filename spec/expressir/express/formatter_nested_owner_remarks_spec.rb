# frozen_string_literal: true

require "spec_helper"

# Nested owners' tagged descriptions (issue #694): `(*"path" text *)`
# blocks describing an ENTITY, TYPE, FUNCTION or enumeration item — any
# owner below the schema — are stored per the #679 contract and must
# survive a parse-format round trip, once each, after the declaration
# they describe.
RSpec.describe Expressir::Express::Formatter do
  let(:markers) do
    {
      "MARKER-ENUM-LOW" => "repro_comments.strength_measure.low",
      "MARKER-ENTITY" => "repro_comments.bolted_joint",
      "MARKER-ATTR" => "repro_comments.bolted_joint.strength",
      "MARKER-DERIVE" => "repro_comments.bolted_joint.safe",
      "MARKER-FUNCTION" => "repro_comments.check",
    }
  end

  def formatted_output
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_file(
        Expressir.root_path.join("spec", "expressir", "nested_owner_remarks.exp"),
      ),
    )
  end

  it "writes every owner's tagged description, once" do
    output = formatted_output

    markers.each do |marker, tag|
      expect(output.scan(marker).size)
        .to eq(1), "#{marker} (#{tag}) is not written exactly once"
    end
  end

  it "renders the enumeration item's description with its TYPE" do
    output = formatted_output.lines.map(&:strip)

    enum_line = output.find { |l| l.include?("MARKER-ENUM-LOW") }
    end_type_index = output.index("END_TYPE;")
    expect(output.index(enum_line)).to be > end_type_index
    expect(enum_line).to include('"repro_comments.strength_measure.low"')
  end

  it "renders owner descriptions as blocks after their declarations" do
    output = formatted_output.lines.map(&:strip)

    expect(output.find { |l| l.include?("MARKER-ENTITY") })
      .to include('"repro_comments.bolted_joint"')
    expect(output.find { |l| l.include?("MARKER-FUNCTION") })
      .to include('"repro_comments.check"')

    entity_block = output.index(output.find { |l| l.include?("MARKER-ENTITY") })
    function_block = output.index(output.find { |l| l.include?("MARKER-FUNCTION") })
    expect(entity_block).to be > output.index("END_ENTITY;")
    expect(function_block).to be > output.index("END_FUNCTION;")
  end

  it "formats to a fixed point" do
    once = formatted_output
    twice = described_class.format(
      Expressir::Express::Parser.from_exp(once),
    )

    expect(twice).to eq(once)
  end
end
