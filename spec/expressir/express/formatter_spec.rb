require "yaml"
require "spec_helper"
require "expressir/express/parser"
require "expressir/express/formatter"
require "expressir/express/schema_head_formatter"
require "expressir/express/hyperlink_formatter"

RSpec.describe Expressir::Express::Formatter do
  describe ".format" do
    it "exports an object (single.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "single.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "single_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      result = Expressir::Express::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "multiple_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      result = Expressir::Express::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object (remark.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "remark.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "remark_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      result = Expressir::Express::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "syntax_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      result = Expressir::Express::Formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object with schema head formatter (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "syntax_schema_head_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::Express::Formatter) do
        include Expressir::Express::SchemaHeadFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object with hyperlink formatter (syntax.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "syntax_hyperlink_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::Express::Formatter) do
        include Expressir::Express::HyperlinkFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object with hyperlink formatter (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "multiple_hyperlink_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::Express::Formatter) do
        include Expressir::Express::HyperlinkFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end

    it "exports an object with schema head and hyperlink formatter (multiple.exp)" do |example|
      print "\n[#{example.description}] "
      exp_file = Expressir.root_path.join("spec", "syntax", "multiple.exp")
      formatted_exp_file = Expressir.root_path.join("spec", "syntax", "multiple_schema_head_hyperlink_formatted.exp")

      repo = Expressir::Express::Parser.from_file(exp_file)

      formatter = Class.new(Expressir::Express::Formatter) do
        include Expressir::Express::SchemaHeadFormatter
        include Expressir::Express::HyperlinkFormatter
      end
      result = formatter.format(repo)
      # File.write(formatted_exp_file, result)
      expected_result = File.read(formatted_exp_file)

      expect(result).to eq(expected_result)

      # Validate Object Space
      GC.start
      GC.verify_compaction_references
      GC.verify_internal_consistency
    end
  end
end
