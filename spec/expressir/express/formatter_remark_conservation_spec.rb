# frozen_string_literal: true

require "spec_helper"

# What a round trip does to the remarks in each fixture.
#
# `lost` names the untagged remarks the formatter does not write back.
# `tagged_lost` counts the tagged ones it drops, and `tagged_survivors` names
# the ones it keeps: `remark.exp` alone would contribute 127 lost pairs and
# bury every other entry, but the handful that survive fit, and pinning them
# is what stops a swap from passing as a no-op.
#
# These are gaps, not rules. A remark that starts going missing is a
# regression. A remark that starts surviving means a gap closed, and this
# table is what tells you to update it. `tagged_lost` is only a readable
# total; what pins the tagged side is `tagged_survivors`, which fixes the
# rendered set exactly and so determines the lost set with it.
#
# What this does NOT catch: these are multisets, so a remark that moves to the
# wrong declaration while still being written out leaves every count
# unchanged. Conservation is about whether a remark survives, not about where
# it lands; `formatter_remark_ownership_spec.rb` covers where.
round_trips = {
  # Trailing remarks on REFERENCE FROM lines, plus 20 `--IPn:` informal
  # proposition declarations that are dropped with them.
  "spec/fixtures/examples/autonomous_vehicle_navigation_schema.exp" => {
    lost: { "ACME 5000-41" => 1, "ACME 5000-42" => 3, "ACME 5000-43" => 1 },
    tagged_lost: 20, tagged_survivors: []
  },
  "spec/fixtures/examples/geometry_schema.exp" => {
    lost: { "ACME 5000-41" => 1, "ACME 5000-42" => 3, "ACME 5000-43" => 1 },
    tagged_lost: 20, tagged_survivors: []
  },
  # Remarks sitting between schema-level declarations.
  "spec/fixtures/examples/nested_functions_test_schema.exp" => {
    lost: {
      "Another top-level function (should be included in coverage)" => 1,
      "Simple entity for the rule" => 1,
      "Top-level function (should be included in coverage)" => 1,
      "Top-level rule with inner function" => 1,
    },
    tagged_lost: 0, tagged_survivors: []
  },
  "spec/fixtures/function_body_remarks.exp" => {
    lost: { "BETWEEN-FUNCTIONS schema level comment" => 1 },
    tagged_lost: 0, tagged_survivors: []
  },
  "spec/syntax/syntax.exp" => {
    lost: {
      "aggregate initializer expressions" => 1, "aggregation types" => 1,
      "constant expressions" => 1, "constructed types" => 1,
      "function call or entity constructor expressions" => 1,
      "function expressions" => 1, "operator expressions" => 1,
      "query expressions" => 1, "reference expressions" => 1,
      "schema" => 1, "statements" => 1, "types" => 1
    },
    tagged_lost: 0, tagged_survivors: []
  },
  # Schema-level remarks, plus two that sit outside SCHEMA entirely.
  "spec/fixtures/examples/tail_remarks_test_schema.exp" => {
    lost: {
      "Final untagged tail remark at end of file" => 1,
      "Untagged tail remark after constant" => 1,
      "Untagged tail remark after constants block" => 1,
      "Untagged tail remark after enum item" => 1,
      "Untagged tail remark at very beginning of file" => 1,
      "Untagged tail remark before constants" => 1,
      "Untagged tail remark before type definition" => 1,
    },
    tagged_lost: 6, tagged_survivors: []
  },
  # All 133 remarks here are tagged. The six that survive sit inside a
  # FUNCTION or PROCEDURE body and keep their tags; the other 127 are dropped
  # because nothing outside a body re-emits the binding.
  "spec/syntax/remark.exp" => {
    lost: {}, tagged_lost: 127,
    tagged_survivors: [
      ["remark_alias", "function alias scope - function alias"],
      ["remark_repeat", "function repeat scope - function repeat"],
      ["remark_query", "function query scope - function query"],
      ["remark_alias", "procedure alias scope - procedure alias"],
      ["remark_repeat", "procedure repeat scope - procedure repeat"],
      ["remark_query", "procedure query scope - procedure query"],
    ]
  },
}.freeze

RSpec.describe Expressir::Express::Formatter do
  let(:conservation) { Expressir::RemarkConservation }

  describe "remark conservation" do
    round_trips.each do |path, expected|
      it "round trips the remarks of #{File.basename(path)}" do
        source = File.read(path)
        rendered = Expressir::Express::Parser.from_file(path).to_s

        source_untagged = conservation.untagged_texts(source)
        rendered_untagged = conservation.untagged_texts(rendered)
        source_tagged = conservation.tagged_pairs(source)
        rendered_tagged = conservation.tagged_pairs(rendered)

        expect(conservation.lost(source_untagged, rendered_untagged))
          .to eq(expected[:lost])
        expect(conservation.gained(source_untagged, rendered_untagged))
          .to be_empty
        expect(conservation.lost(source_tagged, rendered_tagged).values.sum)
          .to eq(expected[:tagged_lost])
        expect(conservation.gained(source_tagged, rendered_tagged)).to be_empty
        expect(rendered_tagged).to eq(expected[:tagged_survivors])
      end
    end

    # A tagged remark that survives must not stand in for an untagged one that
    # did not. Both carry the text "duplicate" here, and only the tagged one is
    # written back; comparing all remarks together would report no loss at all.
    it "does not let a surviving tagged remark mask an untagged loss" do
      source = <<~EXPRESS
        -- duplicate
        SCHEMA x;
        FUNCTION f : BOOLEAN;
          LOCAL v : STRING; END_LOCAL;
          ALIAS a FOR v; ;
            --"a" duplicate
          END_ALIAS;
          RETURN(TRUE);
        END_FUNCTION;
        END_SCHEMA;
      EXPRESS
      rendered = Expressir::Express::Parser.from_exp(
        source, skip_references: true, use_native: false
      ).to_s

      # The bare `;` after the ALIAS header is a null statement, not a typo:
      # an ALIAS needs a body, and the schema does not parse without it.
      expect(conservation.tagged_pairs(rendered))
        .to eq([["a", "duplicate"]])
      expect(conservation.lost(conservation.untagged_texts(source),
                               conservation.untagged_texts(rendered)))
        .to eq({ "duplicate" => 1 })
    end
  end

  describe "production scale conservation", :production_scale do
    # 637 KB of real EXPRESS, which costs about a minute to parse. That is why
    # `rake verify:remarks` runs this and the default suite does not.
    #
    # The losses are pinned text by text rather than as a total, because a
    # total lets a newly lost remark pass whenever some other one starts
    # surviving. Regenerate the fixture only when you have read the diff and
    # can say why each line moved.
    let(:losses) do
      YAML.load_file(
        "spec/fixtures/remark_conservation/mathematical_functions_losses.yml",
      )
    end

    it "loses only the remarks recorded in the fixture" do
      path = "spec/syntax/mathematical_functions_schema/" \
             "mathematical_functions_schema.exp"
      source = File.read(path)
      rendered = Expressir::Express::Parser.from_file(path).to_s

      source_untagged = conservation.untagged_texts(source)
      rendered_untagged = conservation.untagged_texts(rendered)
      source_tagged = conservation.tagged_pairs(source)
      rendered_tagged = conservation.tagged_pairs(rendered)

      expect(conservation.lost(source_untagged, rendered_untagged))
        .to eq(losses)
      expect(conservation.gained(source_untagged, rendered_untagged))
        .to be_empty
      expect(conservation.lost(source_tagged, rendered_tagged)).to be_empty
      expect(conservation.gained(source_tagged, rendered_tagged)).to be_empty
    end
  end
end
