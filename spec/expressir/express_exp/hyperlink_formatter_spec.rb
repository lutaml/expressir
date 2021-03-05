require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/formatter"
require "expressir/express_exp/hyperlink_formatter"

RSpec.describe Expressir::ExpressExp::HyperlinkFormatter do
  describe ".format" do
    it "formats hyperlink" do
      repo = Expressir::ExpressExp::Parser.from_file(input_file)

      class CustomFormatter < Expressir::ExpressExp::Formatter
        include Expressir::ExpressExp::HyperlinkFormatter
      end
      result = CustomFormatter.format(repo)
      expected_result = File.read(output_file)

      expect(result).to eq(expected_result)
    end
  end

  def input_file
    @input_file ||= Expressir.root_path.join("original", "examples", "syntax", "hyperlink.exp")
  end

  def output_file
    @output_file ||= Expressir.root_path.join("original", "examples", "syntax", "hyperlink_formatted.exp")
  end
end
