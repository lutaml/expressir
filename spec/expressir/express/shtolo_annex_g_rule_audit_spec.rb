# frozen_string_literal: true

require "spec_helper"
require "tmpdir"
require "tempfile"
require "fileutils"

# TODO.eengine/04 — the live rule audit for spec/fixtures/shtolo/
# annex-g-rules.md. One example per rule without prior coverage; the
# assertions encode the ANNEX (the contract), not eeng (a partial
# oracle). Results roll up into annex-g-rules.md.
RSpec.describe Expressir::Express::Shtolo do
  def parse_repository(sources)
    files = sources.map do |id, src|
      f = Tempfile.new([id.to_s, ".exp"])
      f.write(src)
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

  describe "G.NM.2 qualified strings in expressions" do
    it "rewrites the schema part of TYPEOF strings to the longform name" do
      repository, files = parse_repository(
        "this_schema" => "SCHEMA this_schema;\nTYPE whatsit = EXTENSIBLE ENUMERATION; END_TYPE;\nENTITY an_entity;\n  x : whatsit;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "sch_schema" => "SCHEMA sch_schema;\nUSE FROM this_schema (an_entity);\nRULE string_check FOR (an_entity);\nWHERE wr1 : 'THIS_SCHEMA.WHATSIT' IN TYPEOF(x);\nEND_RULE;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "sch_schema"), repository)
      files.each(&:unlink)
      rendered = Expressir::Express::PrettyFormatter.new.format(longform)
      expect(rendered).not_to include("THIS_SCHEMA.WHATSIT")
      expect(rendered).to include("SCH_SCHEMA.WHATSIT")
    end
  end

  describe "G.1.2 interface dedup" do
    it "drops duplicate USE items in favour of the REFERENCE twin" do
      repository, files = parse_repository(
        "source_schema" => "SCHEMA source_schema;\nTYPE widget = INTEGER; END_TYPE;\nEND_SCHEMA;\n",
        "sch_schema" => "SCHEMA sch_schema;\nUSE FROM source_schema (widget);\nREFERENCE FROM source_schema (widget);\nENTITY consumer;\n  w : widget;\nEND_ENTITY;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "sch_schema"), repository)
      files.each(&:unlink)
      # USE wins: exactly one widget copy survives in the longform
      expect(longform.entities.map(&:id).count { |i| i == "widget" } +
             longform.types.map(&:id).count { |i| i == "widget" }).to eq(1)
    end
  end

  describe "G.1.5 secondary population" do
    it "copies referenced types needed for completeness only" do
      repository, files = parse_repository(
        "source_schema" => "SCHEMA source_schema;\nTYPE used_type = INTEGER; END_TYPE;\nTYPE spare_type = REAL; END_TYPE;\nEND_SCHEMA;\n",
        "sch_schema" => "SCHEMA sch_schema;\nUSE FROM source_schema (used_type);\nREFERENCE FROM source_schema (spare_type);\nENTITY consumer;\n  u : used_type;\nEND_ENTITY;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "sch_schema"), repository)
      files.each(&:unlink)
      expect(longform.types.map(&:id)).to include("used_type")
    end
  end

  describe "G.1.8 tagged remarks travel" do
    # The flatten must carry whatever remark_items the copied source
    # declaration holds (remark ATTACHMENT from source text is
    # RemarkAttacher's contract, spec'd separately); the remark is
    # injected on the parsed entity to isolate the flatten behavior.
    it "carries remark_items on an interfaced entity into the longform" do
      repository, files = parse_repository(
        "source_schema" => "SCHEMA source_schema;\nENTITY marked;\n  a : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "sch_schema" => "SCHEMA sch_schema;\nUSE FROM source_schema (marked);\nENTITY consumer; m : marked; END_ENTITY;\nEND_SCHEMA;\n",
      )
      marked = repository.schemas.find { |s| s.id == "source_schema" }.entities.first
      marked.remark_items = [Expressir::Model::Declarations::RemarkItem.new(
        id: "rm_marked", remarks: ["marked:purpose the purpose of marked"],
      )]
      longform = flatten(schema_of(repository, "sch_schema"), repository)
      files.each(&:unlink)
      remarks = longform.entities.flat_map { |e| Array(e.remark_items).flat_map(&:remarks) }.join("\n")
      expect(remarks).to include("marked:purpose")
    end
  end

  describe "G.1.10 provenance remark" do
    it "records every contributing schema name" do
      repository, files = parse_repository(
        "alpha" => "SCHEMA alpha;\nENTITY a_ent; END_ENTITY;\nEND_SCHEMA;\n",
        "beta" => "SCHEMA beta;\nUSE FROM alpha (a_ent);\nENTITY b_ent; b : a_ent; END_ENTITY;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "beta"), repository)
      files.each(&:unlink)
      rendered = Expressir::Express::PrettyFormatter.new.format(longform)
      remarks = Array(longform.remark_items).flat_map(&:remarks).join("\n")
      expect(rendered + remarks).to include("alpha").and include("beta")
    end
  end

  describe "G.2.3 extensible enumeration" do
    it "folds the domain and turns extensions into typed exclusions" do
      repository, files = parse_repository(
        "base_schema" => "SCHEMA base_schema;\nTYPE status = EXTENSIBLE ENUMERATION OF (ok); END_TYPE;\nEND_SCHEMA;\n",
        "ext_schema" => "SCHEMA ext_schema;\nUSE FROM base_schema (status);\nTYPE status_ext = EXTENSIBLE ENUMERATION BASED_ON status WITH (pending, rework); END_TYPE;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "ext_schema"), repository)
      files.each(&:unlink)
      rendered = Expressir::Express::PrettyFormatter.new.format(longform)
      expect(rendered).to include("pending").and include("rework")
    end
  end

  describe "G.2.4 extensible select" do
    it "folds select extensions into the full domain" do
      repository, files = parse_repository(
        "base_schema" => "SCHEMA base_schema;\nENTITY thing; END_ENTITY;\nTYPE base_sel = EXTENSIBLE SELECT (thing); END_TYPE;\nEND_SCHEMA;\n",
        "ext_schema" => "SCHEMA ext_schema;\nUSE FROM base_schema (thing, base_sel);\nENTITY gadget_thing; END_ENTITY;\nTYPE gadget_sel = EXTENSIBLE SELECT BASED_ON base_sel WITH (gadget_thing); END_TYPE;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "ext_schema"), repository)
      files.each(&:unlink)
      expect(longform.types.map(&:id)).to include("base_sel", "gadget_sel")
    end
  end

  describe "G.2.6 abstract entity" do
    it "keeps ABSTRACT SUPERTYPE on the entity declaration" do
      repository, files = parse_repository(
        "base_schema" => "SCHEMA base_schema;\nENTITY root ABSTRACT SUPERTYPE OF (ONEOF (sub_a, sub_b));\n  shared : STRING;\nEND_ENTITY;\nENTITY sub_a SUBTYPE OF (root); END_ENTITY;\nENTITY sub_b SUBTYPE OF (root); END_ENTITY;\nEND_SCHEMA;\n",
      )
      longform = flatten(schema_of(repository, "base_schema"), repository)
      files.each(&:unlink)
      root = longform.entities.find { |e| e.id == "root" }
      expect(root.abstract).to be_truthy
      expect(root.supertype_expression).not_to be_nil
    end
  end
end
