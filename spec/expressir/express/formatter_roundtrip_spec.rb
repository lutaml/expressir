require "spec_helper"

RSpec.describe Expressir::Express::Formatter do
  def assert_roundtrip(exp_text)
    repo1 = Expressir::Express::Parser.from_exp(exp_text, use_native: false)
    formatted1 = described_class.format(repo1)

    repo2 = Expressir::Express::Parser.from_exp(formatted1, use_native: false)
    formatted2 = described_class.format(repo2)

    strip = ->(t) { t.lines.reject { |l| l.strip.start_with?("--") || l.strip.empty? }.join }
    expect(strip.call(formatted1)).to(
      eq(strip.call(formatted2)),
      "Structural content should be stable across format iterations",
    )
  end

  def parse(exp_text)
    Expressir::Express::Parser.from_exp(exp_text, use_native: false)
  end

  describe "unary expression with interval operand" do
    it "wraps interval in parens when negated (NOT {interval})" do
      exp_text = "SCHEMA t; FUNCTION f : BOOLEAN; " \
                 "IF NOT ({1 <= 2 <= 3}) THEN RETURN (TRUE); END_IF; " \
                 "END_FUNCTION; END_SCHEMA;"
      assert_roundtrip(exp_text)
    end

    it "formats NOT ({interval}) correctly" do
      repo = parse("SCHEMA t; FUNCTION f : BOOLEAN; " \
                   "IF NOT ({1 <= 2 <= 3}) THEN RETURN (TRUE); END_IF; " \
                   "END_FUNCTION; END_SCHEMA;")

      formatted = described_class.format(repo)
      expect(formatted).to include("NOT ({1 <= 2 <= 3})")
      expect(formatted).not_to include("NOT {1 <= 2 <= 3}")
    end
  end

  describe "shorthand variable declarations" do
    it "preserves multiple variables declared on one line" do
      repo = parse("SCHEMA t; FUNCTION f : INTEGER; " \
                   "LOCAL slo, shi : INTEGER; END_LOCAL; " \
                   "RETURN (slo + shi); END_FUNCTION; END_SCHEMA;")

      func = repo.schemas.first.functions.first
      expect(func.variables.length).to eq(2)
      expect(func.variables[0].id).to eq("slo")
      expect(func.variables[1].id).to eq("shi")
      expect(func.variables[0].type).to eq(func.variables[1].type)
    end

    it "roundtrips shorthand variable declarations" do
      exp_text = "SCHEMA t; FUNCTION f : INTEGER; " \
                 "LOCAL slo, shi : INTEGER; END_LOCAL; " \
                 "RETURN (slo + shi); END_FUNCTION; END_SCHEMA;"
      assert_roundtrip(exp_text)
    end
  end

  describe "procedure VAR parameters" do
    it "preserves VAR parameter flag" do
      repo = parse("SCHEMA t; PROCEDURE p(x : INTEGER; VAR y : INTEGER); " \
                   "END_PROCEDURE; END_SCHEMA;")

      proc = repo.schemas.first.procedures.first
      expect(proc.parameters.length).to eq(2)
      expect(proc.parameters[0].var).to be_nil
      expect(proc.parameters[1].var).to be(true)
    end
  end

  describe "group qualification with index qualifier" do
    it "roundtrips group-qualified index expressions" do
      exp_text = "SCHEMA t; " \
                 "ENTITY sup; field : LIST OF INTEGER; END_ENTITY; " \
                 "ENTITY sub SUBTYPE OF (sup); inc : LIST OF INTEGER; END_ENTITY; " \
                 "FUNCTION f(x : sup) : BOOLEAN; " \
                 "LOCAL v : INTEGER; END_LOCAL; " \
                 "v := x\\sub.field[1]; " \
                 "IF x\\sub.inc[2] >= 0 THEN RETURN (TRUE); END_IF; " \
                 "RETURN (FALSE); END_FUNCTION; END_SCHEMA;"
      assert_roundtrip(exp_text)
    end
  end

  describe "binary expression parenthesization" do
    it "adds parens for same-precedence left-associative operators" do
      repo = parse("SCHEMA t; FUNCTION f : INTEGER; " \
                   "LOCAL x : INTEGER; END_LOCAL; " \
                   "x := 4 + 2 + 1; RETURN (x); END_FUNCTION; END_SCHEMA;")

      formatted = described_class.format(repo)
      expect(formatted).to include("(4 + 2) + 1")
    end

    it "roundtrips chained binary expressions" do
      exp_text = "SCHEMA t; FUNCTION f : BOOLEAN; " \
                 "LOCAL x : INTEGER; END_LOCAL; " \
                 "x := (4 + 2) - 1; RETURN (x > 0); END_FUNCTION; END_SCHEMA;"
      assert_roundtrip(exp_text)
    end
  end

  describe "binary literals" do
    it "preserves binary literal formatting" do
      repo = parse("SCHEMA t; FUNCTION f : BOOLEAN; " \
                   "LOCAL x : BINARY; END_LOCAL; " \
                   "x := %01010101; RETURN (TRUE); END_FUNCTION; END_SCHEMA;")

      formatted = described_class.format(repo)
      expect(formatted).to include("%01010101")
    end
  end

  describe "syntax.exp full roundtrip" do
    it "roundtrips syntax.exp structural content" do
      exp_file = Expressir.root_path.join("spec", "syntax", "syntax.exp")
      repo1 = Expressir::Express::Parser.from_file(exp_file)
      formatted1 = described_class.format(repo1)

      repo2 = Expressir::Express::Parser.from_exp(formatted1, use_native: false)
      formatted2 = described_class.format(repo2)

      strip = ->(t) { t.lines.reject { |l| l.strip.start_with?("--") || l.strip.empty? }.join }
      expect(strip.call(formatted1)).to eq(strip.call(formatted2))
    end
  end
end
