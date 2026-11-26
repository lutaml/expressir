# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# The AsciiDoc listing face feeds `subs="+macros"` source blocks, where
# AsciiDoc also reads the EXPRESS text itself: runs of opening
# parentheses open index terms, text-following plus signs open inline
# passthroughs, a link right after `SELF\`'s backslash is read as an
# escaped cross reference, and an inline stem macro in remark text
# swallows the rest of the listing (TRThurman, expressir#709/#710; the
# corpus build-stop of #704/#706 rides the same face). The formatter
# writes those characters as passthrough, neutralises the stem macro,
# and the face omits the owner's tagged descriptions (expressir#704).
RSpec.describe Expressir::Express::AdocSourceFormatter do
  let(:express) do
    <<~EXPRESS
      SCHEMA listing_probe;

        TYPE marker = ENUMERATION OF
          (dot,
           plus);
        END_TYPE;

        (*"listing_probe.marker" The **marker** type. stem:[x^2] *)

        ENTITY styled;
          kinds : SET [1:?] OF marker;
        END_ENTITY;

        RULE styled_rule FOR (styled);
          WHERE
            WR1: NOT ((SIZEOF(kinds) > 0) AND
                      (SIZEOF(kinds) < 5));
            WR2: SELF\\styled.kinds <> '+';
          END_WHERE;
        END_RULE;
      END_SCHEMA;
    EXPRESS
  end

  def parse
    Dir.mktmpdir do |dir|
      path = File.join(dir, "listing_probe.exp")
      File.write(path, express)
      Expressir::Express::Parser.from_file(path).schemas.first
    end
  end

  it "omits the owner's tagged description blocks (expressir#704)" do
    adoc = parse.formatted_hyperlinked_adoc

    expect(adoc).not_to include('(*"listing_probe.marker"')
    expect(adoc).not_to include("stem:[x^2]")
  end

  it "keeps them on the base format face for the round trip" do
    schema = parse
    base = Expressir::Express::Formatter.format(schema)

    expect(base).to include('(*"listing_probe.marker" The **marker** type.')
  end

  it "writes the entity of a group reference plain (expressir#709)" do
    adoc = parse.formatted_hyperlinked_adoc

    expect(adoc).to include("SELF\\styled")
    expect(adoc).not_to include("SELF\\<<")
  end

  it "escapes every second parenthesis of a run of opening parentheses" do
    adoc = parse.formatted_hyperlinked_adoc

    expect(adoc).to include("+++(+++")
    # the first parenthesis of the run stays literal
    expect(adoc).to include("NOT (+++(+++SIZEOF")
  end

  it "writes a plus sign followed by text as passthrough" do
    adoc = parse.formatted_hyperlinked_adoc

    expect(adoc).to include("pass:[+]")
    expect(adoc).not_to match(/\n\+\n/)
  end

  it "leaves a plus sign surrounded by blanks alone" do
    Dir.mktmpdir do |dir|
      path = File.join(dir, "plus.exp")
      File.write(path, <<~EXPRESS)
        SCHEMA plus_probe;
          TYPE width = INTEGER;
          END_TYPE;
          ENTITY box;
            w : width;
          END_ENTITY;
          RULE wide FOR (box);
            WHERE
              WR1: w > 3 + 2;
            END_WHERE;
          END_RULE;
        END_SCHEMA;
      EXPRESS
      schema = Expressir::Express::Parser.from_file(path).schemas.first
      adoc = schema.formatted_hyperlinked_adoc

      expect(adoc).to include("3 + 2")
      expect(adoc).not_to include("pass:[+]")
    end
  end

  it "escapes an inline stem macro in remark text on the adoc face (expressir#704 family)" do
    Dir.mktmpdir do |dir|
      path = File.join(dir, "stem.exp")
      File.write(path, <<~EXPRESS)
        SCHEMA stem_probe;
          TYPE dot_type = ENUMERATION OF
            (dot,
             triangle);
          END_TYPE;
          ENTITY styled;
            (* points are presented as triangles (stem:[/_\\]). *)
            kind : dot_type;
          END_ENTITY;
        END_SCHEMA;
      EXPRESS
      schema = Expressir::Express::Parser.from_file(path).schemas.first
      adoc = schema.formatted_hyperlinked_adoc

      # the macro text survives as written; the opening bracket is
      # escaped so AsciiDoc cannot start a math context with it
      expect(adoc).to include("stem:\\[/_\\]")
      expect(adoc).not_to include("stem:[")
    end
  end

  # The listing faces carry the plain form (metanorma-cli#522): a
  # child-attached keyed description — the `__note` family the base
  # face renders — is omitted outright, stem macros and all.
  it "omits keyed description blocks on the listing face (metanorma-cli#522)" do
    Dir.mktmpdir do |dir|
      path = File.join(dir, "stem.exp")
      File.write(path, <<~EXPRESS)
        SCHEMA stem_probe;
          TYPE dot_type = ENUMERATION OF
            (dot,
             triangle);
          END_TYPE;
          (*"stem_probe.dot_type.__note" points are presented as triangles (stem:[/_\\]). *)
          ENTITY styled;
            kind : dot_type;
          END_ENTITY;
        END_SCHEMA;
      EXPRESS
      schema = Expressir::Express::Parser.from_file(path).schemas.first
      adoc = schema.formatted_hyperlinked_adoc

      expect(adoc).not_to include("__note")
      expect(adoc).not_to include("stem:")
    end
  end
end
