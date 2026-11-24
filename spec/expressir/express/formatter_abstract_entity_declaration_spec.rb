# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# ISO 10303-11:2004 has two forms: abstract_entity_declaration (`ABSTRACT`)
# and abstract_supertype_declaration (`ABSTRACT SUPERTYPE [subtype_constraint]`).
# Both set Entity#abstract. The formatter wrote `ABSTRACT SUPERTYPE` for
# both, adding the code token SUPERTYPE to the first. Entity#abstract_entity
# now records the bare form.
RSpec.describe Expressir::Express::Formatter, :ruby_lane do
  describe "an entity written with the bare ABSTRACT" do
    cases = {
      "ENTITY x ABSTRACT;\nEND_ENTITY;" =>
        "ENTITY x\n  ABSTRACT;\nEND_ENTITY;",
      "ENTITY x ABSTRACT SUBTYPE OF (y);\nEND_ENTITY;" =>
        "ENTITY x\n  ABSTRACT\n  SUBTYPE OF (y);\nEND_ENTITY;",
      "entity x abstract subtype of (y);\nend_entity;" =>
        "ENTITY x\n  ABSTRACT\n  SUBTYPE OF (y);\nEND_ENTITY;",
      "ENTITY x ABSTRACT SUPERTYPE;\nEND_ENTITY;" =>
        "ENTITY x\n  ABSTRACT SUPERTYPE;\nEND_ENTITY;",
      "ENTITY x ABSTRACT SUPERTYPE OF (ONEOF (a, b));\nEND_ENTITY;" =>
        "ENTITY x\n  ABSTRACT SUPERTYPE OF (ONEOF(a, b));\nEND_ENTITY;",
      "ENTITY x ABSTRACT SUPERTYPE SUBTYPE OF (y);\nEND_ENTITY;" =>
        "ENTITY x\n  ABSTRACT SUPERTYPE\n  SUBTYPE OF (y);\nEND_ENTITY;",
      "entity x abstract supertype subtype of (y);\nend_entity;" =>
        "ENTITY x\n  ABSTRACT SUPERTYPE\n  SUBTYPE OF (y);\nEND_ENTITY;",
      "ENTITY x SUBTYPE OF (y);\nEND_ENTITY;" =>
        "ENTITY x\n  SUBTYPE OF (y);\nEND_ENTITY;",
      "ENTITY x;\nEND_ENTITY;" => "ENTITY x;\nEND_ENTITY;",
    }

    lanes = {
      "the core lane" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
      "from_file" => lambda do |text|
        Tempfile.create(["abstract_probe", ".exp"]) do |f|
          f.write(text)
          f.flush
          Expressir::Express::Parser.from_file(f.path)
        end
      end,
    }

    def wrap(entity)
      "SCHEMA s;\n#{entity}\nEND_SCHEMA;\n"
    end

    def expected_for(entity)
      "SCHEMA s;\n\n#{entity}\n\nEND_SCHEMA;\n"
    end

    let(:four_forms) do
      ["ENTITY x ABSTRACT;\nEND_ENTITY;", "ENTITY x ABSTRACT SUBTYPE OF (y);\nEND_ENTITY;",
       "ENTITY x ABSTRACT SUPERTYPE;\nEND_ENTITY;", "ENTITY x;\nEND_ENTITY;"]
    end

    lanes.each do |lane, parse|
      context "with a file read by #{lane}" do
        cases.each do |source, expected|
          context "with #{source.inspect}" do
            let(:file) { parse.call(wrap(source)) }

            it "writes the form of the source" do
              expect(file.format).to eq(expected_for(expected))
              expect(file.schemas.first.format).to eq(expected_for(expected).chomp)
            end

            it "writes the same text again from its own output" do
              once = file.format
              expect(parse.call(once).format).to eq(once)
            end

            it "writes the pretty form with the same keywords" do
              text = Expressir::Express::PrettyFormatter.new(indent: 2, provenance: false)
                .format(file.schemas.first.entities.first)
              expect(text).to include(expected.lines[1].strip)
            end

            it "keeps the form through a YAML round trip" do
              entity = file.schemas.first.entities.first
              back = Expressir::Model::Declarations::Entity.from_yaml(entity.to_yaml)
              expect(back.abstract_entity).to eq(entity.abstract_entity)
              expect(back.abstract).to eq(entity.abstract)
              expect(back.to_yaml).to eq(entity.to_yaml)
            end
          end
        end

        it "sets abstract_entity for the bare form only" do
          flags = four_forms.map do |entity|
            e = parse.call(wrap(entity)).schemas.first.entities.first
            [e.abstract, e.abstract_entity]
          end
          expect(flags).to eq([[true, true], [true, true], [true, nil], [nil, nil]])
        end

        it "does not show the field in YAML when unset" do
          entity = parse.call(wrap("ENTITY x ABSTRACT SUPERTYPE;\nEND_ENTITY;")).schemas.first.entities.first
          expect(entity.to_yaml).not_to include("abstract_entity")
          expect(entity.to_yaml).to include("abstract: true")
        end

        it "writes a model without the field as before" do
          entity = parse.call(wrap("ENTITY x ABSTRACT;\nEND_ENTITY;")).schemas.first.entities.first
          entity.abstract_entity = nil
          expect(entity.format).to eq("ENTITY x\n  ABSTRACT SUPERTYPE;\nEND_ENTITY;")
        end

        it "leaves the SUBTYPE_CONSTRAINT form as it was" do
          text = "SCHEMA s;\nENTITY y;\nEND_ENTITY;\nSUBTYPE_CONSTRAINT sc FOR y;\n  ABSTRACT SUPERTYPE;\nEND_SUBTYPE_CONSTRAINT;\nEND_SCHEMA;\n"
          expect(parse.call(text).format).to include("  ABSTRACT SUPERTYPE;\nEND_SUBTYPE_CONSTRAINT;")
        end
      end
    end

    # Seen in review. The long form converts an abstract entity to the
    # `ABSTRACT SUPERTYPE` form, as it did before.
    it "writes ABSTRACT SUPERTYPE in the long form" do
      source = <<~EXP
        SCHEMA long_probe;
        ENTITY d ABSTRACT;
        END_ENTITY;
        ENTITY e ABSTRACT SUBTYPE OF (d);
        END_ENTITY;
        SUBTYPE_CONSTRAINT sc FOR e;
          ABSTRACT SUPERTYPE;
        END_SUBTYPE_CONSTRAINT;
        END_SCHEMA;
      EXP
      Tempfile.create(["long_probe", ".exp"]) do |f|
        f.write(source)
        f.flush
        repository = Expressir::Express::Parser.from_files([f.path])
        longform = Expressir::Express::Shtolo
          .new(repository.schemas.first, repository, longform_name: "long_probe").flatten.schema.format
        expect(longform).to include("ENTITY d\n  ABSTRACT SUPERTYPE;")
        expect(longform).to include("ENTITY e\n  ABSTRACT SUPERTYPE\n  SUBTYPE OF (d);")
      end
    end
  end
end
