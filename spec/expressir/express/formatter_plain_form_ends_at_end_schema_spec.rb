# frozen_string_literal: true

require "spec_helper"
require "tempfile"

# The plain form (`no_remarks: true, keep_untagged_remarks: true`) is the
# schema with its untagged comments. A comment that follows `END_SCHEMA;`
# stands after the schema, so the plain form ends at `END_SCHEMA;`. The
# ordinary form keeps the comment.
RSpec.describe Expressir::Express::Formatter do
  describe "the plain form at END_SCHEMA" do
    let(:plain) { { no_remarks: true, keep_untagged_remarks: true } }

    let(:source) do
      <<~EXP
        SCHEMA end_probe;
        ENTITY a;
        END_ENTITY; -- after END_ENTITY
        END_SCHEMA; -- end_probe
      EXP
    end

    from_file = lambda do |text|
      Tempfile.create(["end_probe", ".exp"]) do |f|
        f.write(text)
        f.flush
        Expressir::Express::Parser.from_file(f.path)
      end
    end

    {
      "Parser.from_file" => from_file,
      "Parser.from_exp" => ->(text) { Expressir::Express::Parser.from_exp(text) },
      "the Ruby builders" => ->(text) { Expressir::Express::Parser.from_exp(text, use_native: false) },
    }.each do |lane, parse|
      context "with a file read by #{lane}" do
        let(:file) { parse.call(source) }

        it "ends the plain form of a schema at END_SCHEMA;" do
          text = file.schemas.first.format(**plain)
          expect(text).to end_with("END_SCHEMA;")
          expect(text).not_to include("-- end_probe")
        end

        it "ends the plain form of a file at END_SCHEMA;" do
          text = file.format(**plain)
          expect(text).to end_with("END_SCHEMA;\n")
          expect(text).not_to include("-- end_probe")
        end

        it "keeps the comment after another END_ keyword in the plain form" do
          expect(file.schemas.first.format(**plain)).to include("END_ENTITY; -- after END_ENTITY")
        end

        it "keeps the comment after END_SCHEMA; in the ordinary form" do
          expect(file.schemas.first.format).to end_with("END_SCHEMA; -- end_probe")
          expect(file.format).to end_with("END_SCHEMA; -- end_probe\n")
        end

        it "writes the stripped form as before" do
          expect(file.schemas.first.format(no_remarks: true))
            .to eq("SCHEMA end_probe;\n\nENTITY a;\nEND_ENTITY;\n\nEND_SCHEMA;")
        end

        it "ends each schema of a file at its END_SCHEMA;" do
          two = parse.call("SCHEMA one;\nEND_SCHEMA; -- one\nSCHEMA two;\nEND_SCHEMA; -- two\n")
          two.schemas.each do |schema|
            expect(schema.format(**plain)).to end_with("END_SCHEMA;")
          end
          expect(two.format(**plain)).not_to include("--")
        end

        it "keeps the comment after END_SCHEMA; in the ordinary form of the pretty formatter" do
          formatter = Expressir::Express::PrettyFormatter.new
          expect(formatter.format(file.schemas.first)).to end_with("END_SCHEMA; -- end_probe")
        end
      end
    end
  end
end
