# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# expressir#650 (SC4UTILITI-198): the schema's object-identifier string
# is identifying metadata of the schema (the ISO registration string).
# The printed form is normalized pretty-printing, NOT byte-identical
# round-trip — identifying metadata must survive normalization on
# every lane: the core lane (native parse + retained-wire render),
# the grammar fallback lane, and the PrettyFormatter.
OID = "{iso standard 10303 part(63) version(1) object(1) isogeometric_analysis_schema(1)}"
SOURCE = <<~EXP.freeze
  SCHEMA isogeometric_analysis_schema '#{OID}';
  ENTITY e;
    a : STRING;
  END_ENTITY;
  END_SCHEMA;
EXP

RSpec.describe "schema object-identifier preservation" do # rubocop:disable RSpec/DescribeClass
  def parse_source(**options)
    f = Tempfile.new(["oid650", ".exp"])
    f.write(SOURCE)
    f.close
    Expressir::Express::Parser.from_file(f.path, **options)
  ensure
    f&.unlink
  end

  it "captures the object identifier on the parse" do
    expect(parse_source.schemas[0].version.value).to eq(OID)
  end

  it "prints the object identifier on the core lane" do
    formatted = Expressir::Express::Formatter.new.format(parse_source)
    expect(formatted.lines.first.strip).to eq("SCHEMA isogeometric_analysis_schema '#{OID}';")
  end

  it "prints the object identifier on the fallback lane" do
    formatted = Expressir::Express::Formatter.new.format(
      parse_source(use_core: false, use_native: false),
    )
    expect(formatted.lines.first.strip).to eq("SCHEMA isogeometric_analysis_schema '#{OID}';")
  end

  it "prints the object identifier through the pretty formatter" do
    formatted = Expressir::Express::PrettyFormatter.new.format(parse_source)
    expect(formatted).to include("SCHEMA isogeometric_analysis_schema '#{OID}';")
  end
end
