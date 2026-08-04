require "spec_helper"

RSpec.describe Expressir::Express::Formatter do
  describe "function body tail remarks" do
    let(:fixture) do
      Expressir.root_path.join("spec", "fixtures", "function_body_remarks.exp")
    end
    let(:repo) { Expressir::Express::Parser.from_file(fixture) }
    let(:formatted) { described_class.format(repo) }
    let(:lines) { formatted.lines.map(&:rstrip) }

    it "keeps every leading body comment exactly once" do
      %w[STEP-1 STEP-2 STEP-3 STEP-4].each do |step|
        count = formatted.scan(step).size
        expect(count).to eq(1), "#{step} appeared #{count} times"
      end
    end

    it "renders each comment directly above the statement it precedes" do
      expect(lines.index { |l| l.include?("-- STEP-1") })
        .to be < lines.index { |l| l.include?("total := total + input") }
      expect(lines.index { |l| l.include?("-- STEP-2") })
        .to be < lines.index { |l| l.include?("IF total > 100 THEN") }
      expect(lines.index { |l| l.include?("-- STEP-3") })
        .to be < lines.index { |l| l.include?("total := total - 1") }
      step1 = lines.index { |l| l.include?("-- STEP-1") }
      expect(lines[step1 + 1]).to include("-- accumulate the input value")
      expect(lines[step1 + 2]).to include("total := total + input")
    end

    it "does not invent remark tags from loop variables" do
      expect(formatted).not_to include('--"i"')
    end

    it "emits nothing after END_FUNCTION" do
      lines.each do |line|
        expect(line).to match(/\A\s*END_FUNCTION;\s*\z/) if line.include?("END_FUNCTION")
      end
    end

    it "keeps comments inside ELSE branches" do
      else_idx = lines.index { |l| l =~ /\A\s*ELSE\s*\z/ }
      step4_idx = lines.index { |l| l.include?("-- STEP-4") }
      expect(step4_idx).to be > else_idx
    end

    it "keeps a terminal comment before END_REPEAT at the block end" do
      term_idx = lines.index { |l| l.include?("-- TERMINAL-REPEAT") }
      expect(term_idx).not_to be_nil
      expect(lines[term_idx + 1]).to include("END_REPEAT")
    end

    it "does not pull a schema-level comment into a function body" do
      between_idx = lines.index { |l| l.include?("BETWEEN-FUNCTIONS") }
      if between_idx
        fn2_idx = lines.index { |l| l.include?("FUNCTION edge_cases") }
        expect(between_idx).to be < fn2_idx
      end
    end

    it "does not misplace a before-ELSE trailing comment" do
      before_else = lines.index { |l| l.include?("-- BEFORE-ELSE") }
      if before_else
        fn2_idx = lines.index { |l| l.include?("FUNCTION edge_cases") }
        expect(before_else).to be > fn2_idx
        expect(lines[before_else + 1]).not_to include("total := 0")
      end
    end

    it "attaches a comment after a same-line ELSE to the ELSE branch" do
      idx = lines.index { |l| l.include?("-- AFTER-INLINE-ELSE") }
      expect(idx).not_to be_nil
      expect(lines[idx + 1]).to include("total := 2")
    end

    it "emits no remarks with no_remarks: true" do
      bare = described_class.new(no_remarks: true).format(repo)
      expect(bare).not_to include("STEP-1")
    end

    it "keeps leading comments under PrettyFormatter" do
      pretty = Expressir::Express::PrettyFormatter.new.format(repo)
      expect(pretty.scan("STEP-1").size).to eq(1)
    end
  end
end
