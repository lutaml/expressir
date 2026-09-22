# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# eeng kernel/check.lisp note-id parity — subset covered by Checker.
# Fixtures use multi-line entity bodies to stay outside expressir#373's
# small single-line corruption window.
RSpec.describe Expressir::Express::Checker do
  def parse_repository(sources)
    files = sources.map do |name, source|
      f = Tempfile.new(["#{name}1", ".exp"])
      f.write(source)
      f.close
      f
    end
    repository = Expressir::Express::Parser.from_files(files.map(&:path))
    [repository, files]
  end

  def files
    @files ||= []
  end

  after do
    files.each(&:unlink)
  end

  def check(sources)
    repository, parsed = parse_repository(sources)
    files.concat(parsed)
    described_class.new(repository).check
  end

  describe "check-schema-interface-redundant" do
    it "flags a second identical USE FROM" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          END_ENTITY;
          END_SCHEMA;
        EXP
        "b" => <<~EXP,
          SCHEMA b;
          USE FROM a (e);
          USE FROM a (e);
          END_SCHEMA;
        EXP
      )
      expect(result.notes.map(&:id)).to include(:check_schema_interface_redundant)
    end
  end

  describe "check-schema-iface-resource-duplicate" do
    it "flags overlapping resources across two interfaces to the same schema" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          END_ENTITY;
          ENTITY f;
            y : STRING;
          END_ENTITY;
          END_SCHEMA;
        EXP
        "b" => <<~EXP,
          SCHEMA b;
          USE FROM a (e);
          USE FROM a (e, f);
          END_SCHEMA;
        EXP
      )
      expect(result.notes.map(&:id)).to include(:check_schema_iface_resource_duplicate)
    end
  end

  describe "check-unresolved-ref (missing interface schema)" do
    it "errors when the foreign schema is absent" do
      result = check(
        "b" => <<~EXP,
          SCHEMA b;
          USE FROM missing (e);
          END_SCHEMA;
        EXP
      )
      note = result.errors.find { |n| n.id == :check_unresolved_ref }
      expect(note).not_to be_nil
      expect(note.message).to include("missing")
    end
  end

  describe "check-unresolved-ref (missing resource)" do
    it "errors when an interface item is not declared in the foreign schema" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          END_ENTITY;
          END_SCHEMA;
        EXP
        "b" => <<~EXP,
          SCHEMA b;
          USE FROM a (nope);
          END_SCHEMA;
        EXP
      )
      note = result.errors.find { |n| n.id == :check_unresolved_ref && n.message.include?("nope") }
      expect(note).not_to be_nil
    end
  end

  describe "check-where-name-pattern" do
    it "warns when a WHERE label is not WR<n>" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          WHERE
            bad_label: TRUE;
          END_ENTITY;
          END_SCHEMA;
        EXP
      )
      expect(result.warnings.map(&:id)).to include(:check_where_name_pattern)
    end

    it "accepts WR1-style labels" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          WHERE
            WR1: TRUE;
          END_ENTITY;
          END_SCHEMA;
        EXP
      )
      expect(result.notes.map(&:id)).not_to include(:check_where_name_pattern)
    end
  end

  describe "check-unique-name-pattern" do
    it "warns when a UNIQUE label is not UR<n>" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          UNIQUE
            badu : x;
          END_ENTITY;
          END_SCHEMA;
        EXP
      )
      expect(result.warnings.map(&:id)).to include(:check_unique_name_pattern)
    end
  end

  describe "check-subtype-ref" do
    it "errors when SUBTYPE OF names an unknown entity" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e SUBTYPE OF (ghost);
            x : STRING;
          END_ENTITY;
          END_SCHEMA;
        EXP
      )
      expect(result.errors.map(&:id)).to include(:check_subtype_ref)
    end
  end

  describe "check-select-extended-type" do
    it "errors when BASED_ON names an unknown type" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          ENTITY e;
            x : STRING;
          END_ENTITY;
          TYPE s = SELECT BASED_ON missing WITH (e);
          END_TYPE;
          END_SCHEMA;
        EXP
      )
      expect(result.errors.map(&:id)).to include(:check_select_extended_type)
    end
  end

  describe "clean schema" do
    it "reports no errors for a self-contained schema" do
      result = check(
        "a" => <<~EXP,
          SCHEMA a;
          TYPE t = STRING; END_TYPE;
          ENTITY e;
            x : t;
          UNIQUE
            UR1 : x;
          WHERE
            WR1: TRUE;
          END_ENTITY;
          END_SCHEMA;
        EXP
      )
      expect(result).to be_valid
    end
  end

  # GH-411: convergent (diamond) inheritance is not a cycle.
  it "does not report a cycle for diamond inheritance" do
    repository, = parse_repository(
      "d" => <<~EXP,
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
    )
    expect(described_class.new(repository).check).to be_valid
  end

  it "still reports a genuine subtype cycle" do
    repository, = parse_repository(
      "c" => <<~EXP,
        SCHEMA c;
          ENTITY a SUBTYPE OF (b);
            x : STRING;
          END_ENTITY;
          ENTITY b SUBTYPE OF (a);
            y : STRING;
          END_ENTITY;
        END_SCHEMA;
      EXP
    )
    result = described_class.new(repository).check
    expect(result).not_to be_valid
    expect(result.errors.map(&:id)).to include(:check_subtype_cycle)
  end

  # GH-412: ISO 10303-11 built-in procedures BLENGTH/INSERT/REMOVE were
  # reported as unresolved references.
  it "accepts calls to BLENGTH, INSERT and REMOVE" do
    repository, = parse_repository(
      "m" => <<~EXP,
        SCHEMA m;
          ENTITY tagged;
            tag   : BINARY;
          WHERE
            WR1 : BLENGTH(tag) > 0;
          END_ENTITY;
          FUNCTION f(es : SET [0:?] OF tagged) : INTEGER;
            LOCAL
              acc : LIST [0:?] OF tagged := [];
            END_LOCAL;
            INSERT(acc, es[1], 0);
            REMOVE(acc, 1);
            RETURN (1);
          END_FUNCTION;
        END_SCHEMA;
      EXP
    )
    result = described_class.new(repository).check
    unresolved = result.errors.select { |e| e.id == :check_unresolved_ref }
    expect(unresolved).to be_empty
  end
end
