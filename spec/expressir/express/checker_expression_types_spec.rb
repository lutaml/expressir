# frozen_string_literal: true

require "spec_helper"
require "expressir"

# TODO.sota/01 tier 2: operator domain typing per ISO 10303-11:2004
# ch.12. eengine performs no expression typing (kernel/check.lisp
# traverses structurally only), so the note id is our own.
RSpec.describe Expressir::Express::Checker do
  def notes_for(exp)
    checker = described_class.new(Expressir::Express::Parser.from_exp(exp))
    checker.check
    checker.notes.select { |note| note.id == :check_expr_operand_domain }
  end

  it "accepts a domain-correct derive expression set" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        TYPE color = ENUMERATION OF (red, green); END_TYPE;
        ENTITY e;
          n : INTEGER;
          r : REAL;
          c : color;
          s1 : STRING;
        DERIVE
          sum : INTEGER := n + 1;
          scale : REAL := r * 2.0;
          flag : BOOLEAN := (c = color.red) AND (n > 1);
          e_ok : BOOLEAN := 1 IN [1, 2];
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes).to be_empty
  end

  it "flags numeric operands on a logical operator (12.4)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          n : INTEGER;
        DERIVE
          bad : BOOLEAN := NOT 3;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.4)")
  end

  it "flags cross-family value comparison (12.2.1)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          n : INTEGER;
          s1 : STRING;
        DERIVE
          bad : BOOLEAN := n = s1;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.2.1)")
  end

  it "flags mixed aggregate subset comparison (12.6)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          items : LIST OF INTEGER;
          n : INTEGER;
        DERIVE
          bad : BOOLEAN := items <= n;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.6)")
  end

  it "flags membership against a non-aggregate (12.2.3)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          n : INTEGER;
        DERIVE
          bad : BOOLEAN := n IN 5;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.2.3)")
  end

  it "flags like over a non-string (12.2.5)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          s1 : STRING;
          n : INTEGER;
        DERIVE
          bad : BOOLEAN := s1 LIKE n;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.2.5)")
  end

  it "flags interval bounds that are not mutually comparable (12.2.4)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY e;
          s1 : STRING;
        DERIVE
          bad : BOOLEAN := {1 <= s1 <= 2};
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes.map(&:message).join).to include("(12.2.4)")
  end

  it "admits the union of an aggregate with an element singleton (12.6 table 17)" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        ENTITY item; END_ENTITY;
        ENTITY e;
          items : LIST OF item;
          one : item;
        DERIVE
          more : LIST OF item := items + one;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes).to be_empty
  end

  it "never flags operands whose types it cannot decide" do
    notes = notes_for(<<~EXPRESS)
      SCHEMA s;
        USE FROM foreign_schema (mystery);
        ENTITY e;
        DERIVE
          ok : BOOLEAN := mystery = mystery;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
    expect(notes).to be_empty
  end
end
