# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# The declarations nested in a FUNCTION, PROCEDURE or RULE are written back
# in the order of the source (#711 reached the schema level only). The
# formatter wrote a callable's nested types, entities, functions and
# procedures grouped by kind, so a PROCEDURE written before a FUNCTION came
# out after it.
RSpec.describe Expressir::Express::Formatter do
  describe "declarations nested in a FUNCTION, PROCEDURE or RULE" do
    let(:source) do
      <<~EXP
        SCHEMA order_probe;
        ENTITY thing;
          v : INTEGER;
        END_ENTITY;
        FUNCTION outer_fn(a : INTEGER) : INTEGER;
          PROCEDURE nested_p1(VAR x : INTEGER);
            x := 1;
          END_PROCEDURE;
          FUNCTION nested_f1(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
          TYPE nested_t = INTEGER;
          END_TYPE;
          PROCEDURE nested_p2(VAR x : INTEGER);
            x := 2;
          END_PROCEDURE;
          RETURN (a);
        END_FUNCTION;
        PROCEDURE outer_proc(VAR a : INTEGER);
          FUNCTION inner_f(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
          TYPE inner_t = INTEGER;
          END_TYPE;
          PROCEDURE inner_p(VAR x : INTEGER);
            x := 3;
          END_PROCEDURE;
          a := 1;
        END_PROCEDURE;
        RULE outer_rule FOR (thing);
          PROCEDURE rule_p(VAR x : INTEGER);
            x := 4;
          END_PROCEDURE;
          FUNCTION rule_f(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
        WHERE
          wr1: TRUE;
        END_RULE;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA order_probe;

        ENTITY thing;
          v : INTEGER;
        END_ENTITY;

        FUNCTION outer_fn(a : INTEGER) : INTEGER;
          PROCEDURE nested_p1(VAR x : INTEGER);
            x := 1;
          END_PROCEDURE;
          FUNCTION nested_f1(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
          TYPE nested_t = INTEGER;
          END_TYPE;
          PROCEDURE nested_p2(VAR x : INTEGER);
            x := 2;
          END_PROCEDURE;
          RETURN (a);
        END_FUNCTION;

        PROCEDURE outer_proc(VAR a : INTEGER);
          FUNCTION inner_f(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
          TYPE inner_t = INTEGER;
          END_TYPE;
          PROCEDURE inner_p(VAR x : INTEGER);
            x := 3;
          END_PROCEDURE;
          a := 1;
        END_PROCEDURE;

        RULE outer_rule FOR (thing);
          PROCEDURE rule_p(VAR x : INTEGER);
            x := 4;
          END_PROCEDURE;
          FUNCTION rule_f(y : INTEGER) : INTEGER;
            RETURN (y);
          END_FUNCTION;
        WHERE
          wr1: TRUE;
        END_RULE;

        END_SCHEMA;
      EXP
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["order_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "keeps the order of the source" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(parse.call(once).format).to eq(once)
        end

        it "records the order on each callable that nests declarations" do
          schema = file.schemas.first
          expect(schema.functions.first.declaration_order).to eq(%w[nested_p1 nested_f1 nested_t nested_p2])
          expect(schema.procedures.first.declaration_order).to eq(%w[inner_f inner_t inner_p])
          expect(schema.rules.first.declaration_order).to eq(%w[rule_p rule_f])
        end

        it "records nothing on a callable without nested declarations" do
          text = "SCHEMA s;\nFUNCTION f : INTEGER;\n  RETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n"
          expect(parse.call(text).schemas.first.functions.first.declaration_order).to eq([])
        end

        it "keeps the order and no comment in the stripped form" do
          stripped = parse.call(source.sub("x := 1;", "x := 1; -- kept")).schemas.first.format(no_remarks: true)
          expect(stripped).not_to include("kept")
          expect(stripped.index("nested_p1")).to be < stripped.index("nested_f1")
        end

        it "writes a model without the order grouped by kind, as before" do
          schema = parse.call(source).schemas.first
          [schema.functions.first, schema.procedures.first, schema.rules.first].each do |c|
            c.declaration_order = []
          end
          text = schema.format
          expect(text).to include(
            "FUNCTION outer_fn(a : INTEGER) : INTEGER;\n  TYPE nested_t = INTEGER;\n  END_TYPE;\n  " \
            "FUNCTION nested_f1(y : INTEGER) : INTEGER;\n    RETURN (y);\n  END_FUNCTION;\n  PROCEDURE nested_p1",
          )
        end

        # The record is written once per nested declaration: ids that repeat
        # (EXPRESS has no overloading, but a source may still carry them)
        # neither double nor drop a declaration.
        it "writes nested declarations of one id once each" do
          text = <<~EXP
            SCHEMA s;
            FUNCTION f(a : INTEGER) : INTEGER;
              FUNCTION g(x : INTEGER) : INTEGER;
                RETURN (x);
              END_FUNCTION;
              FUNCTION g(y : REAL) : REAL;
                RETURN (y);
              END_FUNCTION;
              FUNCTION g(z : STRING) : STRING;
                RETURN (z);
              END_FUNCTION;
              RETURN (a);
            END_FUNCTION;
            PROCEDURE p;
              PROCEDURE q(VAR a : INTEGER);
                a := 1;
              END_PROCEDURE;
              PROCEDURE q(VAR b : REAL);
                b := 1.0;
              END_PROCEDURE;
              TYPE x = INTEGER;
              END_TYPE;
              FUNCTION x(y : INTEGER) : INTEGER;
                RETURN (y);
              END_FUNCTION;
            END_PROCEDURE;
            RULE r FOR (thing);
              FUNCTION g(x : INTEGER) : INTEGER;
                RETURN (x);
              END_FUNCTION;
              FUNCTION g(y : REAL) : REAL;
                RETURN (y);
              END_FUNCTION;
            WHERE
              wr1: TRUE;
            END_RULE;
            END_SCHEMA;
          EXP
          out = parse.call(text).format
          expect(out.scan("FUNCTION g(").length).to eq(5)
          expect(out.scan("g(y : REAL)").length).to eq(2)
          expect(out.scan("g(z : STRING)").length).to eq(1)
          expect(out.scan("PROCEDURE q(").length).to eq(2)
          expect(out.scan("TYPE x").length).to eq(1)
          expect(out.scan("FUNCTION x(").length).to eq(1)
          expect(out.index("q(VAR a")).to be < out.index("q(VAR b")
          expect(out.index("TYPE x")).to be < out.index("FUNCTION x(")
        end

        describe "with a record that does not match the declarations" do
          let(:small) do
            "SCHEMA s;\nFUNCTION f : INTEGER;\n  TYPE t1 = INTEGER;\n  END_TYPE;\n  FUNCTION g1 : INTEGER;\n    " \
              "RETURN (1);\n  END_FUNCTION;\n  PROCEDURE p1;\n  END_PROCEDURE;\n  RETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n"
          end

          def written(schema)
            schema.format.scan(/^ +(?:TYPE|FUNCTION|PROCEDURE) (\w+)/).flatten
          end

          it "writes a record naming only some, then the rest grouped by kind" do
            schema = parse.call(small).schemas.first
            schema.functions.first.declaration_order = %w[g1]
            expect(written(schema)).to eq(%w[g1 t1 p1])
          end

          it "skips unknown and repeated ids" do
            schema = parse.call(small).schemas.first
            schema.functions.first.declaration_order = %w[nope p1 p1 other]
            expect(written(schema)).to eq(%w[p1 t1 g1])
          end

          it "writes grouped by kind for an empty or a nil record" do
            empty_records = [[], nil]
            empty_records.each do |record|
              schema = parse.call(small).schemas.first
              schema.functions.first.declaration_order = record
              expect(written(schema)).to eq(%w[t1 g1 p1])
            end
          end

          it "writes a declaration added to the model after parsing" do
            schema = parse.call(small).schemas.first
            schema.functions.first.types << Expressir::Model::Declarations::Type.new(id: "newt")
            expect(written(schema)).to eq(%w[t1 g1 p1 newt])
          end
        end
      end
    end

    it "formats a model loaded from yaml written before the order was recorded as it did" do
      yaml = Expressir::Express::Parser.from_exp(source).schemas.first.to_yaml
      expect(yaml).to include("declaration_order")
      # drop the nested records only (the schema's own list stays)
      old_yaml = yaml.gsub(/^( {2,})declaration_order:\n(?:\1- .*\n)+/, "")
      expect(old_yaml).not_to eq(yaml)
      old = Expressir::Model::Declarations::Schema.from_yaml(old_yaml)
      expect(old.functions.first.declaration_order).to eq([])
      expect(old.format).to include("  FUNCTION nested_f1(y : INTEGER) : INTEGER;\n    RETURN (y);\n  END_FUNCTION;\n  PROCEDURE nested_p1")
    end
  end

  describe "SchemaCompare" do
    let(:with_type_first) do
      "SCHEMA s;\nFUNCTION f : INTEGER;\n  TYPE t1 = INTEGER;\n  END_TYPE;\n  FUNCTION g1 : INTEGER;\n    RETURN (1);\n  END_FUNCTION;\n  RETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n"
    end
    let(:with_function_first) do
      "SCHEMA s;\nFUNCTION f : INTEGER;\n  FUNCTION g1 : INTEGER;\n    RETURN (1);\n  END_FUNCTION;\n  TYPE t1 = INTEGER;\n  END_TYPE;\n  RETURN (1);\nEND_FUNCTION;\nEND_SCHEMA;\n"
    end

    def schema_of(text)
      Expressir::Express::Parser.from_exp(text).schemas.first
    end

    it "does not report a callable as changed when only the order of its nested declarations differs" do
      base = schema_of(with_type_first)
      revised = schema_of(with_function_first)
      expect(base.functions.first.declaration_order).not_to eq(revised.functions.first.declaration_order)
      expect(Expressir::Express::SchemaCompare.compare(base, revised)).to be_empty
    end

    it "does not report a callable as changed when one model has no record" do
      base = schema_of(with_type_first)
      older = schema_of(with_type_first)
      older.functions.first.declaration_order = []
      expect(Expressir::Express::SchemaCompare.compare(base, older)).to be_empty
    end
  end
end
