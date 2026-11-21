# frozen_string_literal: true

require "spec_helper"

# The WG 12 tail-remark acceptance table (issue #693): a tail remark may
# follow any token (ISO 10303-11:2004, 7.1.6), and the formatted schema
# must carry every remark of the source, once, next to the token it
# followed. The fixture (16 remarks, one per position) was built for this
# by Thomas Thurman; each row pins both survival and placement.
RSpec.describe Expressir::Express::Formatter do
  # The WG 12 acceptance rows: remark id -> [token, position].
  let(:placements) do
    {
      "r01" => ["FUNCTION", "function head"],
      "r02" => ["v : INTEGER", "local variable"],
      "r03" => ["v := 1;", "assignment"],
      "r04" => ["THEN", "IF ... THEN"],
      "r05" => ["END_IF;", "END_IF"],
      "r06" => ["OF", "CASE ... OF"],
      "r07" => ["1 :", "case label, action next line"],
      "r08" => ["BEGIN", "BEGIN"],
      "r09" => ["END;", "END"],
      "r10" => ["v := 4;", "case action on the label's line"],
      "r11" => ["OTHERWISE", "OTHERWISE"],
      "r12" => ["END_CASE;", "END_CASE"],
      "r13" => ["REPEAT", "REPEAT"],
      "r14" => ["END_REPEAT;", "END_REPEAT"],
      "r15" => ["RETURN", "RETURN"],
      "r16" => ["END_FUNCTION;", "END_FUNCTION"],
    }
  end

  def formatted_positions
    Expressir::Express::Formatter.format(
      Expressir::Express::Parser.from_file(
        Expressir.root_path.join("spec", "expressir", "remark_positions.exp"),
      ),
    )
  end

  it "writes every remark next to the token it followed" do
    output = formatted_positions.lines.map(&:strip)

    placements.each do |id, (token, position)|
      line = output.find { |l| l.include?(id) }
      expect(line).not_to be_nil, "#{id} (#{position}) is not written at all"
      expect(line)
        .to include(token), "#{id} (#{position}) is not next to its token"
    end
  end

  it "writes each remark exactly once" do
    output = formatted_positions

    placements.each_key do |id|
      expect(output.scan(id).size).to eq(1), "#{id} is written more than once"
    end
  end

  # The WG 12 real-schema shape: consecutive case labels each carrying a
  # remark, with the actions on the following lines (ISO 10303-46
  # get_coordinate_values writes four of these).
  it "writes every consecutive case-label remark on its own label line" do
    source = <<~EXP
      SCHEMA labels;
      FUNCTION g (s : INTEGER) : INTEGER;
        CASE s OF
          1 : -- first case
            v := 1;
          2 : -- second case
            v := 2;
          3 : -- third case
            v := 3;
          4 : -- fourth case
            v := 4;
        END_CASE;
        RETURN (v);
      END_FUNCTION;
      END_SCHEMA;
    EXP
    output = described_class.format(
      Expressir::Express::Parser.from_exp(source),
    ).lines.map(&:strip)

    %w[first second third fourth].each_with_index do |name, i|
      line = output.find { |l| l.include?("#{name} case") }
      expect(line).not_to be_nil, "the #{name} case remark is not written"
      expect(line).to include("#{i + 1} :"),
                      "the #{name} case remark is not on its label line"
    end
  end
end
