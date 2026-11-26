# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# metanorma-cli#522: the listing face (`source`, the hyperlinked adoc)
# rides the plain form - keyed `__note`/`__remark`/`__example` blocks
# never appear in printed source, whichever lane parsed the file and
# however many files the repository holds - while the source's own
# untagged comments stay (expressir#712). 2.4.80's `extend_source_slices`
# dropped the memoized formatted text, and the reformat then printed the
# tagged items the attachment had collected; the ISO 10303-44 build
# printed 67 of them.
RSpec.describe Expressir::Express::SourceFormatter, "#source plain form" do
  let(:toy) do
    <<~EXPRESS
      SCHEMA toy_schema;

      ENTITY widget;
        name : STRING; -- a tail comment
        size : INTEGER;
      WHERE
        WR1: size > 0;
      END_ENTITY;

      END_SCHEMA;

      (*"toy_schema"
      Toy schema description.
      *)

      (*"toy_schema.widget"
      A widget.
      *)

      (*"toy_schema.widget.name.__note"
      This note is keyed to an attribute.
      *)

      (*"toy_schema.widget.size.__example"
      This example is keyed to an attribute.
      *)

      (*"toy_schema.widget.WR1.__note"
      This note is keyed to a rule.
      *)
    EXPRESS
  end

  let(:other) do
    <<~EXPRESS
      SCHEMA other_schema;

      ENTITY thing;
        label : STRING;
      END_ENTITY;

      END_SCHEMA;

      (*"other_schema"
      Other schema description.
      *)
    EXPRESS
  end

  def widget_source(*sources)
    Dir.mktmpdir do |dir|
      paths = sources.each_with_index.map do |src, i|
        path = File.join(dir, "file_#{i}.exp")
        File.write(path, src)
        path
      end
      repo = Expressir::Express::Parser.from_files(paths)
      repo.schemas.find { |s| s.id == "toy_schema" }.entities.first.source
    end
  end

  it "prints no keyed block in source, single file or many (metanorma-cli#522)" do
    expect(widget_source(toy)).not_to include("__note")
    expect(widget_source(toy, other)).not_to include("__note")
    expect(widget_source(toy, other)).not_to include("__example")
  end

  it "keeps the source's own untagged comments (expressir#712)" do
    src = widget_source(toy, other)
    expect(src).to include("-- a tail comment")
    expect(src).to include("name : STRING; -- a tail comment")
  end

  it "keeps the keyed blocks on the format face for the round trip" do
    Dir.mktmpdir do |dir|
      path = File.join(dir, "toy.exp")
      File.write(path, toy)
      schema = Expressir::Express::Parser.from_file(path).schemas.first
      base = Expressir::Express::Formatter.format(schema)

      expect(base).to include("__note")
      expect(base).to include("__example")
    end
  end
end
