# frozen_string_literal: true

require "spec_helper"

# The plain form writes no informal-proposition lines from tagged
# descriptions (#723): a `(*"schema.entity.wr:IP1" ... *)` description is
# TAGGED-channel content, and `keep_untagged_remarks` keeps UNTAGGED
# comments only. The shorthand lines the SOURCE declared keep rendering
# on the full form.
RSpec.describe Expressir::Express::Formatter do
  let(:source) do
    <<~EXP
      SCHEMA ip_probe;
      ENTITY a;
        x : INTEGER;
      WHERE
        wr1 : x > 0;
      END_ENTITY;
      ENTITY b;
        x : INTEGER;
      WHERE
        wr1 : x > 0;
        --IP1: the source has this line
      END_ENTITY;
      END_SCHEMA;
      (*"ip_probe.a.wr:IP1"
      Text of the description of a.
      *)
      (*"ip_probe.b.wr:IP1"
      Text of the description of b.
      *)
    EXP
  end

  def parse
    Expressir::Express::Parser.from_exp(source)
  end

  it "writes no --IPn: line for an entity that declared none" do
    plain = parse.schemas.first.format(no_remarks: true, keep_untagged_remarks: true)

    entity_a = plain.split("END_ENTITY").first
    expect(entity_a).not_to include("--IP1:")
  end

  it "leaves no tagged description text anywhere in the plain form" do
    plain = parse.schemas.first.format(no_remarks: true, keep_untagged_remarks: true)

    expect(plain).not_to include("Text of the description")
  end

  it "keeps the source's own shorthand line on the full form" do
    full = parse.schemas.first.format

    expect(full).to include("--IP1: the source has this line")
  end
end
