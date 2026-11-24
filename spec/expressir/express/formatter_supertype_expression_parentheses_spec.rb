# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# The pairs of parentheses the source writes around a supertype expression
# or one of its operands are written back. Before, the minimal-parentheses
# policy (#651) dropped every pair its precedence rule did not need, in
# SUPERTYPE OF and in a SUBTYPE_CONSTRAINT body. The pairs are recorded in
# `parenthesized`, as for expressions (#707); a model without the record
# keeps the minimal-parentheses text.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "the parentheses of a supertype expression" do
    let(:source) do
      <<~EXP
        SCHEMA paren_probe;
        ENTITY a
          ABSTRACT SUPERTYPE OF ((ONEOF (b, c)) ANDOR (d));
        END_ENTITY;
        ENTITY b SUBTYPE OF (a);
        END_ENTITY;
        ENTITY c SUBTYPE OF (a);
        END_ENTITY;
        ENTITY d
          SUPERTYPE OF ((e))
          SUBTYPE OF (a);
        END_ENTITY;
        ENTITY e SUBTYPE OF (d);
        END_ENTITY;
        ENTITY f
          SUPERTYPE OF ((((e))));
        END_ENTITY;
        ENTITY g
          SUPERTYPE OF ((b ANDOR c) AND d);
        END_ENTITY;
        ENTITY h
          SUPERTYPE OF ((b AND c) ANDOR d);
        END_ENTITY;
        ENTITY i
          SUPERTYPE OF (b AND (c ANDOR d));
        END_ENTITY;
        ENTITY j
          SUPERTYPE OF (ONEOF ((ONEOF ((b), (c))), (d ANDOR e)));
        END_ENTITY;
        ENTITY k
          SUPERTYPE OF (ONEOF (b, c) ANDOR d);
        END_ENTITY;
        ENTITY l
          SUPERTYPE OF (b ANDOR (c ANDOR d));
        END_ENTITY;
        SUBTYPE_CONSTRAINT sc_a FOR a;
          (ONEOF (b, c));
        END_SUBTYPE_CONSTRAINT;
        SUBTYPE_CONSTRAINT sc_b FOR a;
          ONEOF (b, c);
        END_SUBTYPE_CONSTRAINT;
        SUBTYPE_CONSTRAINT sc_c FOR a;
          ABSTRACT SUPERTYPE;
          TOTAL_OVER (b, c);
          ((b) ANDOR (c));
        END_SUBTYPE_CONSTRAINT;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA paren_probe;

        ENTITY a
          ABSTRACT SUPERTYPE OF ((ONEOF(b, c)) ANDOR (d));
        END_ENTITY;

        ENTITY b
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY c
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY d
          SUPERTYPE OF ((e))
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY e
          SUBTYPE OF (d);
        END_ENTITY;

        ENTITY f
          SUPERTYPE OF ((((e))));
        END_ENTITY;

        ENTITY g
          SUPERTYPE OF ((b ANDOR c) AND d);
        END_ENTITY;

        ENTITY h
          SUPERTYPE OF ((b AND c) ANDOR d);
        END_ENTITY;

        ENTITY i
          SUPERTYPE OF (b AND (c ANDOR d));
        END_ENTITY;

        ENTITY j
          SUPERTYPE OF (ONEOF((ONEOF((b), (c))), (d ANDOR e)));
        END_ENTITY;

        ENTITY k
          SUPERTYPE OF (ONEOF(b, c) ANDOR d);
        END_ENTITY;

        ENTITY l
          SUPERTYPE OF (b ANDOR (c ANDOR d));
        END_ENTITY;

        SUBTYPE_CONSTRAINT sc_a FOR a;
          (ONEOF(b, c));
        END_SUBTYPE_CONSTRAINT;

        SUBTYPE_CONSTRAINT sc_b FOR a;
          ONEOF(b, c);
        END_SUBTYPE_CONSTRAINT;

        SUBTYPE_CONSTRAINT sc_c FOR a;
          ABSTRACT SUPERTYPE;
          TOTAL_OVER(b, c);
          ((b) ANDOR (c));
        END_SUBTYPE_CONSTRAINT;

        END_SCHEMA;
      EXP
    end

    # What 2.4.80 wrote, and what a model without the record still writes.
    let(:minimal) do
      <<~EXP
        SCHEMA paren_probe;

        ENTITY a
          ABSTRACT SUPERTYPE OF (ONEOF(b, c) ANDOR d);
        END_ENTITY;

        ENTITY b
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY c
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY d
          SUPERTYPE OF (e)
          SUBTYPE OF (a);
        END_ENTITY;

        ENTITY e
          SUBTYPE OF (d);
        END_ENTITY;

        ENTITY f
          SUPERTYPE OF (e);
        END_ENTITY;

        ENTITY g
          SUPERTYPE OF ((b ANDOR c) AND d);
        END_ENTITY;

        ENTITY h
          SUPERTYPE OF (b AND c ANDOR d);
        END_ENTITY;

        ENTITY i
          SUPERTYPE OF (b AND (c ANDOR d));
        END_ENTITY;

        ENTITY j
          SUPERTYPE OF (ONEOF(ONEOF(b, c), d ANDOR e));
        END_ENTITY;

        ENTITY k
          SUPERTYPE OF (ONEOF(b, c) ANDOR d);
        END_ENTITY;

        ENTITY l
          SUPERTYPE OF (b ANDOR (c ANDOR d));
        END_ENTITY;

        SUBTYPE_CONSTRAINT sc_a FOR a;
          ONEOF(b, c);
        END_SUBTYPE_CONSTRAINT;

        SUBTYPE_CONSTRAINT sc_b FOR a;
          ONEOF(b, c);
        END_SUBTYPE_CONSTRAINT;

        SUBTYPE_CONSTRAINT sc_c FOR a;
          ABSTRACT SUPERTYPE;
          TOTAL_OVER(b, c);
          b ANDOR c;
        END_SUBTYPE_CONSTRAINT;

        END_SCHEMA;
      EXP
    end

    def supertype_of(file, id)
      file.schemas.first.entities.find { |e| e.id == id }.supertype_expression
    end

    def strip_record(node)
      return unless node.is_a?(Expressir::Model::ModelElement)

      node.parenthesized = nil
      node.class.attributes.each_key do |name|
        value = node.public_send(name)
        Array(value).each { |child| strip_record(child) }
      end
    end

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["paren_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "writes every pair of the source" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text from the schema" do
          expect(file.schemas.first.format).to eq(expected.chomp)
        end

        it "writes the same text again from its own output" do
          expect(parse.call(file.format).format).to eq(file.format)
        end

        it "records the depth of each pair" do
          a = supertype_of(file, "a")
          expect(a.parenthesized).to be_nil
          expect([a.operand1.parenthesized, a.operand2.parenthesized]).to eq([1, 1])
          expect(supertype_of(file, "d").parenthesized).to eq(1)
          expect(supertype_of(file, "f").parenthesized).to eq(3)
          expect(supertype_of(file, "g").operand1.parenthesized).to eq(1)
          k = supertype_of(file, "k")
          expect([k.operand1.parenthesized, k.operand2.parenthesized]).to eq([nil, nil])
        end

        it "keeps the record through yaml" do
          again = Expressir::Model::ExpFile.from_yaml(file.to_yaml)
          expect(supertype_of(again, "f").parenthesized).to eq(3)
          expect(supertype_of(again, "a").operand2.parenthesized).to eq(1)
        end

        it "writes the minimal parentheses for a model without the record" do
          strip_record(file)
          expect(file.schemas.first.format).to eq(minimal.chomp)
        end
      end
    end
  end
end
