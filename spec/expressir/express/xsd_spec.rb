# frozen_string_literal: true

require "spec_helper"
require "tempfile"

RSpec.describe Expressir::Express::Xsd do
  def parse(schema_source)
    f = Tempfile.new(["xsd", ".exp"])
    f.write(schema_source)
    f.close
    repo = Expressir::Express::Parser.from_files([f.path])
    schema = repo.schemas.first
    [schema, f]
  end

  let(:schema_source) do
    <<~EXP
      SCHEMA demo;
      TYPE color = ENUMERATION OF (red, green); END_TYPE;
      TYPE label = STRING; END_TYPE;
      ENTITY base ABSTRACT SUPERTYPE; name : label; END_ENTITY;
      ENTITY widget SUBTYPE OF (base);
        count : INTEGER;
        tags : LIST [0:?] OF label;
        shade : color;
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  let(:xml) do
    schema, f = parse(schema_source)
    out = described_class.format(schema)
    f.unlink
    out
  end

  it "roots an xs:schema document with the xs namespace" do
    aggregate_failures do
      expect(xml).to include("<xs:schema")
      expect(xml).to include("xmlns:xs=\"http://www.w3.org/2001/XMLSchema\"")
    end
  end

  it "maps enumerations to simpleType facets" do
    aggregate_failures do
      expect(xml).to include("<xs:simpleType name=\"color\">")
      expect(xml).to include("<xs:enumeration value=\"red\">")
      expect(xml).to include("<xs:enumeration value=\"green\">")
    end
  end

  it "maps entities to element + complexType pairs" do
    aggregate_failures do
      expect(xml).to include("<xs:element name=\"widget\" type=\"widget\"")
      expect(xml).to include("<xs:complexType name=\"widget\">")
    end
  end

  it "links subtypes to their supertype via substitutionGroup" do
    expect(xml).to include("substitutionGroup=\"base\"")
  end

  it "maps built-ins and aggregates on attributes" do
    aggregate_failures do
      expect(xml).to include("<xs:element name=\"count\" type=\"xs:integer\"")
      expect(xml).to include("<xs:element name=\"tags\" type=\"label\" maxOccurs=\"unbounded\"")
    end
  end

  it "resolves attribute types to schema-local defined types" do
    expect(xml).to include("<xs:element name=\"name\" type=\"label\"")
  end
end
