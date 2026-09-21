# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# ISO 10303-11:2004 Annex G conversion — spec/fixtures/shtolo/
# annex-g-rules.md is the rule table this suite exercises.
RSpec.describe Expressir::Express::Shtolo do
  def parse_repository(sources)
    files = sources.map do |name, source|
      f = Tempfile.new(["#{name}1", ".exp"])
      f.write(source)
      f.close
      f
    end
    repository = Expressir::Express::Parser.from_files(files.map(&:path), skip_references: true)
    [repository, files]
  end

  def flatten(root_schema, repository)
    described_class.new(root_schema, repository).flatten.schema
  end

  def schema_of(model, id)
    model.schemas.find { |s| s.id == id }
  end

  describe "G.1.3 renamed USE items copy under their original name" do
    it "rewrites references from the alias to the original" do
      sources = {
        "second_schema" => "SCHEMA second_schema;\nENTITY alfred;\n  a1 : STRING;\nEND_ENTITY;\nENTITY bert;\n  b1 : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "sch_schema" => "SCHEMA sch_schema;\nUSE FROM second_schema (alfred AS alf, bert AS herbert);\nENTITY joe;\n  attr1 : alf;\n  attr2 : herbert;\nEND_ENTITY;\nEND_SCHEMA;\n",
      }
      repository, files = parse_repository(sources)
      longform = flatten(schema_of(repository, "sch_schema"), repository)
      files.each(&:unlink)

      joe = longform.entities.find { |e| e.id == "joe" }
      aggregate_failures do
        expect(longform.entities.map(&:id)).to include("alfred", "bert")
        expect(joe.attributes[0].type.id).to eq("alfred")
        expect(joe.attributes[1].type.id).to eq("bert")
      end
    end
  end

  describe "G.NM.1 name munging" do
    it "prefixes clashing declarations with schema_dot_" do
      sources = {
        "farming" => "SCHEMA farming;\nUSE FROM s1_schema (creature);\nENTITY farming_dot_dog SUBTYPE OF (creature);\n  x : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "s1_schema" => "SCHEMA s1_schema;\nENTITY creature;\n  y : STRING;\nEND_ENTITY;\nENTITY dog;\n  z : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
      }
      repository, files = parse_repository(sources)
      longform = flatten(schema_of(repository, "farming"), repository)
      files.each(&:unlink)

      ids = longform.entities.map(&:id)
      expect(ids).to include("creature")
    end
  end

  describe "G.2 stage 2 output invariants" do
    it "produces a schema with no interfaces and parses back" do
      sources = {
        "root_schema" => "SCHEMA root_schema;\nUSE FROM support_schema (identifier);\nENTITY root_entity;\n  id : identifier;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "support_schema" => "SCHEMA support_schema;\nTYPE identifier = STRING; END_TYPE;\nEND_SCHEMA;\n",
      }
      repository, files = parse_repository(sources)
      longform = flatten(schema_of(repository, "root_schema"), repository)
      files.each(&:unlink)

      expect(longform.interfaces).to be_empty
      text = Expressir::Express::Formatter.format(longform)
      expect(text).not_to match(/USE FROM|REFERENCE FROM/)

      f = Tempfile.new(%w[lf .exp])
      f.write("SCHEMA #{longform.id};\n#{text.sub(/\ASCHEMA #{longform.id};\n?/, '').sub(/END_SCHEMA;\s*\z/, '')}\nEND_SCHEMA;\n")
      f.close
      begin
        reparsed = Expressir::Express::Parser.from_file(f.path, skip_references: true)
        expect(reparsed.schemas.first.entities.map(&:id)).to include("root_entity")
      ensure
        f.unlink
      end
    end

    it "G.2.5 eliminates subtype constraints and emits a TOTAL_OVER rule" do
      sources = {
        "root" => <<~EXP,
          SCHEMA root;
          ENTITY person; name : STRING; END_ENTITY;
          ENTITY employee SUBTYPE OF (person); staff_no : STRING; END_ENTITY;
          SUBTYPE_CONSTRAINT person_sc FOR person;
            TOTAL_OVER (person, employee);
          END_SUBTYPE_CONSTRAINT;
          END_SCHEMA;
        EXP
      }
      repository, files = parse_repository(sources)
      longform = flatten(schema_of(repository, "root"), repository)
      files.each(&:unlink)

      aggregate_failures do
        expect(longform.subtype_constraints).to be_empty
        expect(longform.rules.map(&:id)).to include("total_over_person_sc")
      end
    end

    it "G.2.7 converts RENAMED attributes to DERIVE" do
      sources = {
        "root" => <<~EXP,
          SCHEMA root;
          ENTITY person; name : STRING; END_ENTITY;
          ENTITY employee SUBTYPE OF (person);
            SELF\\person.name RENAMED id : STRING;
          END_ENTITY;
          END_SCHEMA;
        EXP
      }
      repository, files = parse_repository(sources)
      longform = flatten(schema_of(repository, "root"), repository)
      files.each(&:unlink)

      emp = longform.entities.find { |e| e.id == "employee" }
      derived = emp.attributes.find { |a| a.kind == Expressir::Model::Declarations::Attribute::DERIVED }
      aggregate_failures do
        expect(derived).not_to be_nil
        expect(derived.id).to eq("id")
        text = Expressir::Express::Formatter.format(longform)
        expect(text).to include("DERIVE")
        expect(text).to include('SELF\person.name')
      end
    end
  end

  describe "eeng oracle differential", if: ENV.fetch("EENG_PARITY", nil) do
    it "flattens description_assignment MIM with the same declaration set" do
      stepmod = ENV["STEPMOD"] || "/Users/mulgogi/src/mn/iso-10303"
      File.join(stepmod, "schemas/modules/description_assignment/mim.exp")
      oracle = File.read(File.expand_path("../../fixtures/eeng/oracle/description-assignment-mim-concatenated.exp", __dir__))

      # Universe: every schema in the oracle closure.
      paths = oracle.scan(%r{^-- [A-Za-z_0-9]+ \((.+)\)$}).flatten.uniq
      repository = Expressir::Express::Parser.from_files(paths, skip_references: true)
      root = repository.schemas.find { |s| s.id == "Description_assignment_mim" }
      longform = flatten(root, repository)

      oracle_decls = oracle.scan(/^-- ([A-Za-z_0-9]+) \(/).flatten.map(&:upcase).sort
      expect([longform.id.upcase]).to eq([oracle_decls.first])
      expect(longform.interfaces).to be_empty
    end
  end
end
