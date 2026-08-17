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
# `embedded_lost` counts the `(* *)` remarks the formatter drops and
# `embedded_survivors` names the ones it keeps, tagged and untagged together
# as `[tag, text]` pairs. Embedded remarks were invisible here until this
# table gained those two columns: conservation read only tail remarks, so
# deleting every embedded remark in the formatter left the gate green.
#
# These are gaps, not rules. A remark that starts going missing is a
# regression. A remark that starts surviving means a gap closed, and this
# table is what tells you to update it. `tagged_lost` and `embedded_lost` are
# only readable totals; what pins those two sides is `tagged_survivors` and
# `embedded_survivors`, which fix the rendered set exactly and so determine
# the lost set with it. Pinning embedded survivors rather than embedded
# losses is also what keeps a 1.5 KB copyright block out of this table.
#
# What this does NOT catch: these are multisets, so a remark that moves to the
# wrong declaration while still being written out leaves every count
# unchanged. Conservation is about whether a remark survives, not about where
# it lands; `formatter_remark_ownership_spec.rb` covers where.
round_trips = {
  # Nothing untagged is lost in these two any more: the remarks trailing
  # their REFERENCE FROM lines now survive. What remains is 20 `--IPn:`
  # informal proposition declarations each, which the formatter never emits.
  #
  # Embedded: the file header, which sits outside SCHEMA, and the blocks
  # introducing the interface clause and the first TYPE. The block
  # introducing an ENTITY is the one that survives.
  "spec/fixtures/examples/autonomous_vehicle_navigation_schema.exp" => {
    lost: {}, tagged_lost: 20, tagged_survivors: [],
    embedded_lost: 3,
    embedded_survivors: [[nil, "VR spatial computing additions  next 3 entities"]]
  },
  "spec/fixtures/examples/geometry_schema.exp" => {
    lost: {}, tagged_lost: 20, tagged_survivors: [],
    embedded_lost: 3,
    embedded_survivors: [[nil, "VR spatial computing additions  next 3 entities"]]
  },
  # Remarks sitting between schema-level declarations.
  "spec/fixtures/examples/nested_functions_test_schema.exp" => {
    lost: {
      "Another top-level function (should be included in coverage)" => 1,
      "Simple entity for the rule" => 1,
      "Top-level function (should be included in coverage)" => 1,
      "Top-level rule with inner function" => 1,
    },
    tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
  },
  "spec/fixtures/function_body_remarks.exp" => {
    lost: { "BETWEEN-FUNCTIONS schema level comment" => 1 },
    tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
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
    tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
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
    tagged_lost: 6, tagged_survivors: [],
    # Embedded: the block before SCHEMA, and the tagged one. The two sitting
    # inside the schema body survive.
    embedded_lost: 2,
    embedded_survivors: [[nil, "Untagged embedded remark"],
                         [nil, "Untagged embedded remark within entity"]]
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
    ],
    # Embedded: one tagged block, on the schema. Nothing re-emits an
    # embedded binding.
    embedded_lost: 1, embedded_survivors: []
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

        source_embedded = conservation.embedded_pairs(source)
        rendered_embedded = conservation.embedded_pairs(rendered)

        expect(conservation.lost(source_embedded, rendered_embedded).values.sum)
          .to eq(expected[:embedded_lost])
        expect(conservation.gained(source_embedded, rendered_embedded))
          .to be_empty
        expect(rendered_embedded).to eq(expected[:embedded_survivors])
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

    # Tail and embedded remarks are asserted in one example rather than two so
    # the schema is parsed once. A second example would cost another minute
    # for nothing.
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

      # Every embedded remark in the schema is dropped: 1139 in the source,
      # 1138 of them tagged, and none written back. Pinned as a count and an
      # empty survivor list rather than text by text, because the texts run to
      # 22 KB apiece.
      #
      # The source count is not decoration. With survivors pinned empty it is
      # the only thing standing between this and a vacuous pass: if the
      # scanner ever returned nothing, "survivors empty" would still hold
      # while examining zero remarks. Exact rather than a floor, because the
      # fixture is frozen and the count pins the loss set.
      source_embedded = conservation.embedded_pairs(source)
      rendered_embedded = conservation.embedded_pairs(rendered)

      expect(source_embedded.size).to eq(1139)
      expect(rendered_embedded).to be_empty
    end
  end
end
