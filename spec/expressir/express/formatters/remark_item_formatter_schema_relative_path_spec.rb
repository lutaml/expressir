# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# Tags are relative to the schema: a file parsed inside a multi-file
# Repository must tag exactly like the same file parsed alone. Walking
# to the model ROOT stops at the Repository (whose id is nil) and leaves
# the ExpFile's path in every tag - the build machine's path prints on
# every schema page (TRThurman, expressir#708).
RSpec.describe Expressir::Express::Formatters::RemarkItemFormatter, "#schema_relative_path" do
  let(:schema_a) do
    <<~EXPRESS
      SCHEMA tags_a;
        ENTITY widget;
          size : tags_b.unit;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
  end

  let(:schema_b) do
    <<~EXPRESS
      SCHEMA tags_b;
        TYPE unit = INTEGER;
        END_TYPE;
        (*"tags_b.unit.__note" The unit of measure. *)
        ENTITY gauge;
          u : unit;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
  end

  def parse(files, single: false)
    Dir.mktmpdir do |dir|
      paths = files.map.with_index do |src, i|
        path = File.join(dir, "tags_#{i}.exp")
        File.write(path, src)
        path
      end
      repo = single ? Expressir::Express::Parser.from_file(paths.first) : Expressir::Express::Parser.from_files(paths)
      repo.schemas.find { |s| s.id == "tags_b" }
    end
  end

  it "tags like the single-file parse when read inside a repository" do
    alone = parse([schema_b], single: true)
    grouped = parse([schema_a, schema_b])

    alone_out = alone.formatted_hyperlinked_adoc
    grouped_out = grouped.formatted_hyperlinked_adoc

    expect(grouped_out).to include('(*"tags_b.unit.__note"')
    expect(grouped_out).not_to include("tags_1.exp.tags_b")
    expect(alone_out).to include('(*"tags_b.unit.__note"')
  end
end
