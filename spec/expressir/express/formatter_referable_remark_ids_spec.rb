# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# annotated-express#103: referable note ids survive every parse path and a
# format-then-reparse round trip.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA s;
      FUNCTION f(a : INTEGER) : BOOLEAN;
        RETURN (TRUE);
      END_FUNCTION;
      ENTITY w;
        size : INTEGER;
      WHERE
        WR1: size > 0;
      END_ENTITY;
      END_SCHEMA;

      (*"s.f.__note:two"
      first
      *)

      (*"s.f.__note:3"
      second
      *)

      (*"s.w.wr:WR1.__note:n1"
      a rule note
      *)
    EXP
  end

  let(:parse_paths) do
    {
      "from_exp" => ->(src) { Expressir::Express::Parser.from_exp(src) },
      "from_file" => ->(src) { from_file(src) },
      "from_file without the core" => ->(src) { from_file(src, use_core: false) },
    }
  end
  let(:expected) { [["__note:two", "__note:3"], ["__note:n1"]] }

  def from_file(src, **options)
    Dir.mktmpdir do |dir|
      path = File.join(dir, "s.exp")
      File.write(path, src)
      Expressir::Express::Parser.from_file(path, **options)
    end
  end

  def note_ids(repo)
    schema = repo.schemas.first
    [schema.functions.first, schema.entities.first.where_rules.first]
      .map { |node| node.remark_items.map(&:id) }
  end

  %w[from_exp from_file].push("from_file without the core").each do |name|
    context "with #{name}" do
      let(:repo) { parse_paths.fetch(name).call(source) }

      # Un-gated (issue #623): plain from_file runs on whichever lane
      # is available — the "__note" ids are a formatter contract, not
      # a core-lane one.

      it "keeps the ids and the count" do
        expect(note_ids(repo)).to eq(expected)
      end

      it "keeps them through format and reparse" do
        reparsed = Expressir::Express::Parser.from_exp(described_class.format(repo))

        expect(note_ids(reparsed)).to eq(expected)
      end

      it "writes schema-relative tags without a leading dot" do
        formatted = described_class.format(repo)

        expect(formatted).to include('(*"s.f.__note:two" first *)')
        expect(formatted).to include('--"s.w.WR1.__note:n1" a rule note')
      end
    end
  end
end
