# frozen_string_literal: true

require "spec_helper"

# A `--` comment at the end of the line of an enumeration item, and one on
# the line of a WHERE rule (after the rule, or after its label), is written
# back after the code it follows. Before, the model held these remarks on
# the item and on the rule, and no emitter wrote them.
RSpec.describe Expressir::Express::Formatter do
  describe "the comments of an enumeration item and of a WHERE rule" do
    let(:source) do
      <<~EXP
        SCHEMA lost_probe;
        TYPE colour = ENUMERATION OF
          (red, -- warm
           green); -- cold
        END_TYPE;
        ENTITY part;
          size : INTEGER;
        WHERE
          wr1 : size > 0; -- not empty
          wr2 : -- upper limit
            size < 100;
        END_ENTITY;
        TYPE positive = INTEGER;
        WHERE
          wr1 : SELF > 0; -- of a type
        END_TYPE;
        RULE r FOR (part);
        WHERE
          wr1 : -- of a rule
            TRUE;
        END_RULE;
        END_SCHEMA;
      EXP
    end

    let(:expected) do
      <<~EXP
        SCHEMA lost_probe;

        TYPE colour = ENUMERATION OF
          (red, -- warm
           green); -- cold
        END_TYPE;

        ENTITY part;
          size : INTEGER;
        WHERE
          wr1: size > 0; -- not empty
          wr2: -- upper limit
            size < 100;
        END_ENTITY;

        TYPE positive = INTEGER;
        WHERE
          wr1: SELF > 0; -- of a type
        END_TYPE;

        RULE r FOR (part);
        WHERE
          wr1: -- of a rule
            TRUE;
        END_RULE;

        END_SCHEMA;
      EXP
    end

    { "the core lane" => {}, "the Ruby builders" => { use_native: false } }.each do |lane, options|
      context "with a file read by #{lane}" do
        let(:file) { Expressir::Express::Parser.from_exp(source, **options) }

        # Two `--` remarks never share a line: the second would become
        # part of the first.
        it "keeps two comments of a rule without a label apart" do
          two = <<~EXP
            SCHEMA two;
            ENTITY part;
              size : INTEGER;
            WHERE
              (size > 0) -- first
                AND (size < 5); -- second
            END_ENTITY;
            END_SCHEMA;
          EXP
          text = Expressir::Express::Parser.from_exp(two, **options).format
          expect(text).to include("WHERE\n  -- first\n  (size > 0) AND (size < 5); -- second\nEND_ENTITY;")
        end

        it "writes each comment after the code it follows" do
          expect(file.format).to eq(expected)
        end

        it "writes the same text again from its own output" do
          once = file.format
          expect(Expressir::Express::Parser.from_exp(once, **options).format).to eq(once)
        end

        it "writes none of them in the stripped form" do
          expect(file.schemas.first.format(no_remarks: true)).not_to include("--")
        end
      end
    end
  end
end
