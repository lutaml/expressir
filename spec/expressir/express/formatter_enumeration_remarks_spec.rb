require "spec_helper"

RSpec.describe Expressir::Express::Formatter do
  describe "remark blocks on enumeration items" do
    # The enumeration item renders RemarkItem children through the
    # dispatch (format(item)), bypassing the guarded format_remark_items
    # path — the one formatter that leaked WG12 blocks into
    # no_remarks output.
    let(:source) do
      <<~EXPRESS
        SCHEMA enum_remark_schema;
          TYPE colour = ENUMERATION OF
            (red
            (*"enum_remark_schema.colour.red.tone" the red tone *),
             blue);
          END_TYPE;
        END_SCHEMA;
      EXPRESS
    end

    it "renders the item remark block in remarks mode" do
      formatted = described_class.format(Expressir::Express::Parser.from_exp(source))

      expect(formatted).to include("(*\"enum_remark_schema.colour.red.tone\" the red tone *)")
    end

    it "emits plain item ids when remarks are suppressed" do
      bare = described_class.new(no_remarks: true)
        .format(Expressir::Express::Parser.from_exp(source))

      expect(bare).not_to include("the red tone")
      expect(bare).to include("(red,\n   blue);")
    end
  end
end
