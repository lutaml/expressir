# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# The plain form (`no_remarks: true, keep_untagged_remarks: true`) writes the
# `--IPn:` comment lines the SOURCE has, with the source's own text. A
# proposition that exists only through a tagged `wr:IPn` description still
# writes nothing there (#723). The full and the stripped form are unchanged.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  def entity(wheres, tail = "")
    "SCHEMA s;\nENTITY e;\n  x : INTEGER;\nWHERE\n  WR1: x > 0;\n#{wheres}END_ENTITY;\nEND_SCHEMA;\n#{tail}"
  end

  let(:description) { "(*\"s.e.wr:IP1\"\ndescription text\n*)\n" }

  lanes = {
    "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
    "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    "from_file" => lambda do |text|
      Tempfile.create(["ip_lines", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end,
  }

  lanes.each do |lane, parse|
    context "with a file read by #{lane}" do
      def plain(file)
        file.schemas.first.format(no_remarks: true, keep_untagged_remarks: true)
      end

      it "writes a source line in the plain form and in the full form" do
        file = parse.call(entity("  --IP1: source text\n"))
        expect(plain(file)).to include("\n  --IP1: source text\nEND_ENTITY;")
        expect(file.format).to include("\n  --IP1: source text\nEND_ENTITY;")
      end

      it "writes nothing for a tagged description alone" do
        file = parse.call(entity("", description))
        expect(plain(file)).not_to include("--IP1")
        expect(file.format).to include("--IP1: description text")
      end

      it "writes one line when the source and the description have the same text" do
        file = parse.call(entity("  --IP1: description text\n", description))
        expect(plain(file).scan("--IP1: description text").size).to eq(1)
        expect(file.format.scan("--IP1: description text").size).to eq(2)
      end

      it "writes the source's text when the description has another" do
        file = parse.call(entity("  --IP1: source text\n", description))
        expect(plain(file)).to include("--IP1: source text")
        expect(plain(file)).not_to include("description text")
        expect(file.format).to include("  --IP1: description text\n  --IP1: source text\nEND_ENTITY;")
      end

      it "writes a bare marker and a marker with a blank after the dashes" do
        expect(plain(parse.call(entity("  --IP1:\n")))).to include("\n  --IP1:\nEND_ENTITY;")
        expect(plain(parse.call(entity("  -- IP1: spaced\n")))).to include("\n  --IP1: spaced\nEND_ENTITY;")
      end

      it "writes continuation lines and several lines as the full form does" do
        text = entity("  --IP1: first line\n  --      continuation one\n  --      continuation two\n  --IP2: second\n")
        expected = "WR1: x > 0;\n  -- continuation one\n  -- continuation two\n  --IP1: first line\n  --IP2: second\nEND_ENTITY;"
        file = parse.call(text)
        expect(file.format).to include(expected)
        expect(plain(file)).to include(expected)
      end

      it "writes lines between two WHERE rules where the full form writes them" do
        text = "SCHEMA s;\nENTITY e;\n  x : INTEGER;\nWHERE\n  WR1: x > 0;\n  --IP1: between\n  WR2: x < 10;\n  --IP2: after\nEND_ENTITY;\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(plain(file)).to eq(file.schemas.first.format)
        expect(plain(file)).to include("WR2: x < 10;\n  --IP1: between\n  --IP2: after\nEND_ENTITY;")
      end

      it "keeps the lines of an entity without formal WHERE rules" do
        text = "SCHEMA s;\nENTITY e;\n  x : INTEGER;\n  --IP1: no formal rules\nEND_ENTITY;\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(plain(file)).to eq(file.schemas.first.format)
        expect(plain(file)).to include("--IP1: no formal rules")
      end

      it "leaves a TYPE's lines as the full form has them" do
        text = "SCHEMA s;\nTYPE t = INTEGER;\nWHERE\n  WR1: SELF > 0;\n  --IP1: in a type\nEND_TYPE;\nEND_SCHEMA;\n"
        file = parse.call(text)
        expect(plain(file)).to eq(file.schemas.first.format)
      end

      it "writes no comment in the stripped form" do
        file = parse.call(entity("  --IP1: source text\n", description))
        expect(file.schemas.first.format(no_remarks: true)).not_to include("--")
      end

      it "writes the same plain form again from its own output" do
        file = parse.call(entity("  --IP1: first\n  --      more\n  --IP2: second\n", description))
        once = plain(file)
        expect(plain(parse.call(once))).to eq(once)
      end

      it "holds the source texts on the remark item" do
        held = lambda do |text|
          ip = parse.call(text).schemas.first.entities.first.informal_propositions.first
          ip.remark_items.first.source_remarks
        end
        expect(held.call(entity("  --IP1: source text\n", description))).to eq(["source text"])
        expect(held.call(entity("  --IP1:\n"))).to eq([""])
        expect(Array(held.call(entity("", description)))).to eq([])
      end

      it "keeps the source texts through the YAML round trip" do
        file = parse.call(entity("  --IP1: source text\n", description))
        back = Expressir::Model::ExpFile.from_yaml(file.to_yaml)
        expect(plain(back)).to eq(plain(file))
        expect(back.format).to eq(file.format)
      end
    end
  end
end
