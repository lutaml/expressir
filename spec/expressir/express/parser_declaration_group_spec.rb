# frozen_string_literal: true

require "spec_helper"

# #655: a declaration that lists several names keeps its list — ISO
# 10303-11:2004 local_variable / formal_parameter / explicit_attr each
# declare a NAME LIST. The model splits the names into one node per name
# (references resolve per name), and the siblings of one source
# declaration share a declaration_group number, so the formatters print
# the combined declaration the source wrote: `a, b : INTEGER;` stays
# `a, b : INTEGER;`, while genuinely separate declarations stay separate.
RSpec.describe Expressir::Express::Parser, :ruby_lane do
  def parse(source, **options)
    described_class.from_exp(source, **options)
  end

  def schema_source(source, **options)
    Expressir::Express::SourceFormatter.format(parse(source, **options).schemas.first)
  end

  %i[ruby native].each do |lane|
    it "prints a multi-name local variable as one declaration on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        FUNCTION f : INTEGER;
        LOCAL
        a, b : INTEGER := 0;
        END_LOCAL;
        RETURN(1);
        END_FUNCTION;
        END_SCHEMA;
      EXP

      expect(out).to include("a, b : INTEGER := 0;")
      expect(out.scan("INTEGER := 0;").length).to eq(1)
    end

    it "prints multi-name formal parameters as one declaration on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        FUNCTION total(a, b : INTEGER) : INTEGER;
        RETURN(a + b);
        END_FUNCTION;
        END_SCHEMA;
      EXP

      expect(out).to include("FUNCTION total(a, b : INTEGER) : INTEGER;")
    end

    it "prints multi-name VAR parameters with one VAR on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        PROCEDURE reset(VAR a, b : INTEGER);
        END_PROCEDURE;
        END_SCHEMA;
      EXP

      expect(out).to include("PROCEDURE reset(VAR a, b : INTEGER);")
    end

    it "prints multi-name explicit attributes as one declaration on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        ENTITY e;
        a, b : INTEGER;
        END_ENTITY;
        END_SCHEMA;
      EXP

      expect(out).to include("a, b : INTEGER;")
    end

    it "keeps separate declarations separate on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        FUNCTION f : INTEGER;
        LOCAL
        a : INTEGER;
        b : INTEGER;
        END_LOCAL;
        RETURN(1);
        END_FUNCTION;
        END_SCHEMA;
      EXP

      expect(out).to include("a : INTEGER;\n    b : INTEGER;")
    end

    it "keeps two identical multi-name declarations distinct on the #{lane} engine" do
      use_native = lane == :native
      out = schema_source(<<~EXP, use_native: use_native)
        SCHEMA t;
        FUNCTION f : INTEGER;
        LOCAL
        a, b : INTEGER;
        a, b : REAL;
        END_LOCAL;
        RETURN(1);
        END_FUNCTION;
        END_SCHEMA;
      EXP

      expect(out).to include("a, b : INTEGER;")
      expect(out).to include("a, b : REAL;")
      expect(out.scan("a, b :").length).to eq(2)
    end
  end

  it "keeps the grouping through a serialization replay" do
    out = schema_source(<<~EXP)
      SCHEMA t;
      ENTITY e;
      a, b : INTEGER;
      END_ENTITY;
      END_SCHEMA;
    EXP

    yaml = parse(<<~EXP).to_yaml
      SCHEMA t;
      ENTITY e;
      a, b : INTEGER;
      END_ENTITY;
      END_SCHEMA;
    EXP
    reloaded = Expressir::Model::ExpFile.from_yaml(yaml)
    replay_out = Expressir::Express::SourceFormatter.format(reloaded.schemas.first)

    expect(out).to include("a, b : INTEGER;")
    expect(replay_out).to include("a, b : INTEGER;")
  end

  it "still resolves references per name" do
    repo = parse(<<~EXP)
      SCHEMA t;
      FUNCTION total(a, b : INTEGER) : INTEGER;
      RETURN(a + b);
      END_FUNCTION;
      END_SCHEMA;
    EXP
    fn = repo.schemas.first.functions.first
    ret = fn.statements.first.expression

    expect(fn.parameters.map(&:declaration_group)).to all(be_truthy)
    expect(fn.parameters.first.declaration_group).to eq(fn.parameters.last.declaration_group)
    expect(ret.operand1.id).to eq("a")
    expect(ret.operand2.id).to eq("b")
  end
end
