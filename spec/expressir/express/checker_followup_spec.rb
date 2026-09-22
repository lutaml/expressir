# frozen_string_literal: true

require "spec_helper"
require "tempfile"
require "thor"

# Review follow-ups: #411 convergent inheritance is not a cycle,
# #412 built-in coverage, #413 unparseable file must fail validate check.
RSpec.describe "Checker review follow-ups" do
  def check_source(src)
    file = Tempfile.new(["chk", ".exp"])
    file.write(src)
    file.close
    repo = Expressir::Express::Parser.from_files([file.path])
    [Expressir::Express::Checker.new(repo).check, file]
  ensure
    file&.unlink
  end

  describe "#411 convergent (diamond) inheritance" do
    it "does not report a cycle for convergent branches" do
      result, file = check_source(<<~EXP)
        SCHEMA d;
        ENTITY root;
          x : STRING;
        END_ENTITY;
        ENTITY left SUBTYPE OF (root);
          a : STRING;
        END_ENTITY;
        ENTITY right SUBTYPE OF (root);
          b : STRING;
        END_ENTITY;
        ENTITY bottom SUBTYPE OF (left, right);
          c : STRING;
        END_ENTITY;
        END_SCHEMA;
      EXP
      file.unlink
      expect(result.errors.map(&:id)).not_to include(:check_subtype_cycle)
    end

    it "still reports true cycles" do
      result, file = check_source(<<~EXP)
        SCHEMA d;
        ENTITY p SUBTYPE OF (q);
          x : STRING;
        END_ENTITY;
        ENTITY q SUBTYPE OF (p);
          y : STRING;
        END_ENTITY;
        END_SCHEMA;
      EXP
      file.unlink
      expect(result.errors.map(&:id)).to include(:check_subtype_cycle)
    end
  end

  describe "#412 built-in coverage" do
    it "does not flag blength, insert, or remove as unresolved" do
      result, file = check_source(<<~EXP)
        SCHEMA d;
        ENTITY e;
          items : LIST [0:?] OF e;
        END_ENTITY;
        FUNCTION f(items : LIST [0:?] OF e) : INTEGER;
          LOCAL n : INTEGER := 0; END_LOCAL;
          IF SIZEOF(items) > 0 THEN
            n := BLENGTH(items);
          END_IF;
          INSERT(items, e(''));
          REMOVE(items);
          RETURN (n);
        END_FUNCTION;
        END_SCHEMA;
      EXP
      file.unlink
      unresolved = result.errors.select { |n| n.message =~ /blength|insert|remove/i }
      expect(unresolved).to be_empty
    end
  end

  describe "#413 unparseable file fails validate check" do
    it "Commands::Check raises instead of reporting a clean schema" do
      bad = Tempfile.new(["bad1", ".exp"])
      bad.write("SCHEMA bad;\nENTITY e\n  NOT EXPRESS ((( ;\n")
      bad.close
      begin
        expect do
          Expressir::Commands::Check.new({}).run(bad.path)
        end.to raise_error(Thor::Error, /failed to parse/)
      ensure
        bad.unlink
      end
    end
  end
end
