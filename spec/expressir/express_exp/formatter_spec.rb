require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/formatter"
require "expressir/express_exp/schema_head_formatter"
require "expressir/express_exp/hyperlink_formatter"

RSpec.describe Expressir::ExpressExp::Formatter do
  describe ".format" do
    it "exports an object (single.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "single.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "single_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      result = Expressir::ExpressExp::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      result = Expressir::ExpressExp::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object (remark.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "remark.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "remark_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      result = Expressir::ExpressExp::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object (syntax.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      result = Expressir::ExpressExp::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object with schema head formatter (syntax.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "syntax_schema_head_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::ExpressExp::Formatter) do
        include Expressir::ExpressExp::SchemaHeadFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object with hyperlink formatter (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple_hyperlink_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::ExpressExp::Formatter) do
        include Expressir::ExpressExp::HyperlinkFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end

    it "exports an object with schema head and hyperlink formatter (multiple.exp)" do
      exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("original", "examples", "syntax", "multiple_schema_head_hyperlink_formatted.exp")

      repo = Expressir::ExpressExp::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::ExpressExp::Formatter) do
        include Expressir::ExpressExp::SchemaHeadFormatter
        include Expressir::ExpressExp::HyperlinkFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
    end
  end
end
