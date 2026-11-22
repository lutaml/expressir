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
  # Embedded: only the file header block is lost. The blocks introducing the
  # interface clause, the first TYPE, and the ENTITY all survive.
  "spec/fixtures/examples/autonomous_vehicle_navigation_schema.exp" => {
    # the IP markers round-trip in the ISO shorthand (see geometry)
    lost: {}, tagged_lost: 0,
    tagged_survivors: [
      ["IP1", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP3", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP3", ""],
      ["IP4", ""],
      ["IP5", ""],
      ["IP1", ""],
      ["IP2", ""],
    ],
    embedded_lost: 1,
    embedded_survivors: [
      [nil, "for immersive geometry added volume_with_faces"],
      [nil, "VR spatial computing TYPE additions"],
      [nil, "VR spatial computing additions  next 3 entities"],
    ]
  },
  "spec/fixtures/examples/geometry_schema.exp" => {
    # the IP markers render back in the ISO shorthand and round-trip
    # (the all-legacy-scope-remarks train): twenty tagged pairs survive
    lost: {}, tagged_lost: 0,
    tagged_survivors: [
      ["IP1", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP3", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP1", ""],
      ["IP2", ""],
      ["IP3", ""],
      ["IP4", ""],
      ["IP5", ""],
      ["IP1", ""],
      ["IP2", ""],
    ],
    embedded_lost: 1,
    embedded_survivors: [
      [nil, "for immersive geometry added volume_with_faces"],
      [nil, "VR spatial computing TYPE additions"],
      [nil, "VR spatial computing additions  next 3 entities"],
    ]
  },
  # Schema-level remarks between declarations survive: they attach to the
  # nearest preceding declaration and render from it.
  "spec/fixtures/examples/nested_functions_test_schema.exp" => {
    lost: {}, tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
  },
  "spec/fixtures/function_body_remarks.exp" => {
    lost: {}, tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
  },
  "spec/syntax/syntax.exp" => {
    # expressir#653: attachment measures the ORIGINAL captured spans, and
    # the placements are byte-identical to the core lane; the lost set is
    # the core-agreed verdict.
    lost: {
      # the all-legacy-scope-remarks render conserves the procedure's
      # section comments; only the schema-level loss remains
      "schema" => 1,
    },
    tagged_lost: 0, tagged_survivors: [],
    embedded_lost: 0, embedded_survivors: []
  },
  # expressir#653: the original-span measurement re-homes the tail
  # remarks onto the constructs they physically follow; the lost set is
  # the core-agreed verdict (byte-identical lanes).
  "spec/fixtures/examples/tail_remarks_test_schema.exp" => {
    lost: {
      "Final untagged tail remark at end of file" => 1,
      "Untagged tail remark after constant" => 1,
      "Untagged tail remark at very beginning of file" => 1,
    },
    tagged_lost: 6, tagged_survivors: [],
    embedded_lost: 3,
    embedded_survivors: [
      # expressir#694: every owner's tagged descriptions render after
      # its declaration, so the round trip re-houses them per owner.
      # The owners stand in the order of the source (#711), and
      # mixed_remarks_type follows test_entity there.
      ["tail_remarks_test_schema.test_enumeration", "Tagged tail remark for type"],
      ["tail_remarks_test_schema.test_entity.attr2", "Tagged tail remark for next attribute"],
      [nil, "Untagged embedded remark within entity"],
      ["tail_remarks_test_schema.test_entity", "Tagged tail remark for entity"],
      ["tail_remarks_test_schema.mixed_remarks_type", "Tagged tail remark"],
      ["tail_remarks_test_schema.mixed_remarks_type", "Tagged embedded remark"],
      ["tail_remarks_test_schema", "Tagged tail remark for schema"],
      ["tail_remarks_test_schema", "Tagged tail remark for schema at end"],
    ],
    embedded_normalized: [
      ["tail_remarks_test_schema.test_enumeration", "Tagged tail remark for type"],
      ["tail_remarks_test_schema.test_entity.attr2", "Tagged tail remark for next attribute"],
      ["tail_remarks_test_schema.test_entity", "Tagged tail remark for entity"],
      ["tail_remarks_test_schema.mixed_remarks_type", "Tagged tail remark"],
      ["tail_remarks_test_schema.mixed_remarks_type", "Tagged embedded remark"],
      ["tail_remarks_test_schema", "Tagged tail remark for schema"],
      ["tail_remarks_test_schema", "Tagged tail remark for schema at end"],
    ]
  },
  # All 133 remarks here are tagged. expressir#603 made the formatter
  # re-emit remark items, so most tags now survive in their canonical
  # form; the lost count covers the legacy bare-tag alias pairs the
  # canonical full-path tag replaces, plus genuinely dropped bindings.
  # The RULE query survivor came back with #555: the rule's statements
  # render again.
  "spec/syntax/remark.exp" => {
    # 124: the all-legacy-scope-remarks render conserves one more
    # tagged tail (the multi-remark end scope).
    lost: {}, tagged_lost: 124,
    # Legacy bare-tag alias pairs the canonical full-path tag replaces
    # (the item is addressed bare in the schema scope and by path in
    # the universal scope; the render emits the path form once).
    tagged_normalized: [
      ["remark_schema.remark_item", "schema scope - schema remark item"],
      # the IP informal-proposition texts render back in the ISO
      # shorthand now (the all-legacy-scope-remarks train)
      ["IP1", "entity scope - entity informal proposition, with prefix"],
      ["IP1", "schema scope - entity informal proposition"],
      ["IP1", "schema scope - entity informal proposition, with prefix"],
      ["IP1", "universal scope - entity informal proposition"],
      ["IP1", "universal scope - entity informal proposition, with prefix"],
    ],
    # expressir#603 canonical: remark items re-house as embedded blocks
    # (`(*"path" text *)`), so their two tail-sourced bindings appear
    # here as embedded blocks. Same item, same texts — new housing.
    # The schema's own tagged tail descriptions re-house the same way
    # (the schema-level source formatter emission).
    embedded_normalized: [
      ["remark_schema.remark_constant", "schema scope - constant"],
      ["remark_schema.remark_constant", "universal scope - constant"],
      ["remark_schema.remark_type.WR1", "type scope - type where"],
      ["remark_schema.remark_type.WR1", "type scope - type where, with prefix"],
      ["remark_schema.remark_type.WR1", "schema scope - type where"],
      ["remark_schema.remark_type.WR1", "schema scope - type where, with prefix"],
      ["remark_schema.remark_type.WR1", "universal scope - type where"],
      ["remark_schema.remark_type.WR1", "universal scope - type where, with prefix"],
      ["remark_schema.remark_type.remark_enumeration_item", "schema scope - enumeration item"],
      ["remark_schema.remark_type.remark_enumeration_item", "schema scope - enumeration item, on the same level as the type"],
      ["remark_schema.remark_type.remark_enumeration_item", "universal scope - enumeration item"],
      ["remark_schema.remark_type.remark_enumeration_item", "universal scope - enumeration item, on the same level as the type"],
      ["remark_schema.remark_type", "schema scope - type"],
      ["remark_schema.remark_type", "universal scope - type"],
      ["remark_schema.remark_entity.remark_attribute", "entity scope - entity attribute"],
      ["remark_schema.remark_entity.remark_attribute", "schema scope - entity attribute"],
      ["remark_schema.remark_entity.remark_attribute", "universal scope - entity attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "entity scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "schema scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "universal scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "entity scope - entity inverse attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "schema scope - entity inverse attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "universal scope - entity inverse attribute"],
      ["remark_schema.remark_entity.UR1", "entity scope - entity unique"],
      ["remark_schema.remark_entity.UR1", "schema scope - entity unique"],
      ["remark_schema.remark_entity.UR1", "universal scope - entity unique"],
      ["remark_schema.remark_entity.WR1", "entity scope - entity where"],
      ["remark_schema.remark_entity.WR1", "entity scope - entity where, with prefix"],
      ["remark_schema.remark_entity.WR1", "schema scope - entity where"],
      ["remark_schema.remark_entity.WR1", "schema scope - entity where, with prefix"],
      ["remark_schema.remark_entity.WR1", "universal scope - entity where"],
      ["remark_schema.remark_entity.WR1", "universal scope - entity where, with prefix"],
      ["remark_schema.remark_entity", "schema scope - entity"],
      ["remark_schema.remark_entity", "universal scope - entity"],
      ["remark_schema.remark_subtype_constraint", "schema scope - subtype constraint"],
      ["remark_schema.remark_subtype_constraint", "universal scope - subtype constraint"],
      ["remark_schema.remark_function.remark_parameter", "function scope - function parameter"],
      ["remark_schema.remark_function.remark_parameter", "schema scope - function parameter"],
      ["remark_schema.remark_function.remark_parameter", "universal scope - function parameter"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "function scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "function scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "schema scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "schema scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "universal scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "universal scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type", "function scope - function type"],
      ["remark_schema.remark_function.remark_type", "schema scope - function type"],
      ["remark_schema.remark_function.remark_type", "universal scope - function type"],
      ["remark_schema.remark_function.remark_constant", "function scope - function constant"],
      ["remark_schema.remark_function.remark_constant", "schema scope - function constant"],
      ["remark_schema.remark_function.remark_constant", "universal scope - function constant"],
      ["remark_schema.remark_function.remark_variable", "function scope - function variable"],
      ["remark_schema.remark_function.remark_variable", "schema scope - function variable"],
      ["remark_schema.remark_function.remark_variable", "universal scope - function variable"],
      ["remark_schema.remark_function", "schema scope - function"],
      ["remark_schema.remark_function", "universal scope - function"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "rule scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "rule scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "schema scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "schema scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "universal scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "universal scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type", "rule scope - rule type"],
      ["remark_schema.remark_rule.remark_type", "schema scope - rule type"],
      ["remark_schema.remark_rule.remark_type", "universal scope - rule type"],
      ["remark_schema.remark_rule.remark_constant", "rule scope - rule constant"],
      ["remark_schema.remark_rule.remark_constant", "schema scope - rule constant"],
      ["remark_schema.remark_rule.remark_constant", "universal scope - rule constant"],
      ["remark_schema.remark_rule.remark_variable", "rule scope - rule variable"],
      ["remark_schema.remark_rule.remark_variable", "schema scope - rule variable"],
      ["remark_schema.remark_rule.remark_variable", "universal scope - rule variable"],
      ["remark_schema.remark_rule.WR1", "rule scope - rule where"],
      ["remark_schema.remark_rule.WR1", "rule scope - rule where, with prefix"],
      ["remark_schema.remark_rule.WR1", "schema scope - rule where"],
      ["remark_schema.remark_rule.WR1", "schema scope - rule where, with prefix"],
      ["remark_schema.remark_rule.WR1", "universal scope - rule where"],
      ["remark_schema.remark_rule.WR1", "universal scope - rule where, with prefix"],
      ["remark_schema.remark_rule", "schema scope - rule"],
      ["remark_schema.remark_rule", "universal scope - rule"],
      ["remark_schema.remark_procedure.remark_parameter", "procedure scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_parameter", "schema scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_parameter", "universal scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "procedure scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "procedure scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "schema scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "schema scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "universal scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "universal scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type", "procedure scope - procedure type"],
      ["remark_schema.remark_procedure.remark_type", "schema scope - procedure type"],
      ["remark_schema.remark_procedure.remark_type", "universal scope - procedure type"],
      ["remark_schema.remark_procedure.remark_constant", "procedure scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_constant", "schema scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_constant", "universal scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_variable", "procedure scope - procedure variable"],
      ["remark_schema.remark_procedure.remark_variable", "schema scope - procedure variable"],
      ["remark_schema.remark_procedure.remark_variable", "universal scope - procedure variable"],
      ["remark_schema.remark_procedure", "schema scope - procedure"],
      ["remark_schema.remark_procedure", "universal scope - procedure"],
      ["remark_schema", "The tail remark is written at the end of a physical line."],
      ["remark_schema", "UTF8 test: Příliš žluťoučký kůň úpěl ďábelské ódy."],
      ["remark_schema", "universal scope - schema before"],
      ["remark_schema", "universal scope - schema"],
      ["remark_schema.remark_item", "schema scope - schema remark item"],
      ["remark_schema.remark_item", "universal scope - schema remark item"],
    ],
    # expressir#603 canonical: the schema-level remark item's blocks,
    # plus the schema's own description block now conserved.
    embedded_survivors: [
      # expressir#694: the round trip re-houses every owner's tagged
      # descriptions as blocks after its declaration, on top of the
      # schema's own conserved blocks.
      ["remark_schema.remark_constant", "schema scope - constant"],
      ["remark_schema.remark_constant", "universal scope - constant"],
      ["remark_schema.remark_type.WR1", "type scope - type where"],
      ["remark_schema.remark_type.WR1", "type scope - type where, with prefix"],
      ["remark_schema.remark_type.WR1", "schema scope - type where"],
      ["remark_schema.remark_type.WR1", "schema scope - type where, with prefix"],
      ["remark_schema.remark_type.WR1", "universal scope - type where"],
      ["remark_schema.remark_type.WR1", "universal scope - type where, with prefix"],
      ["remark_schema.remark_type.remark_enumeration_item", "schema scope - enumeration item"],
      ["remark_schema.remark_type.remark_enumeration_item", "schema scope - enumeration item, on the same level as the type"],
      ["remark_schema.remark_type.remark_enumeration_item", "universal scope - enumeration item"],
      ["remark_schema.remark_type.remark_enumeration_item", "universal scope - enumeration item, on the same level as the type"],
      ["remark_schema.remark_type", "schema scope - type"],
      ["remark_schema.remark_type", "universal scope - type"],
      ["remark_schema.remark_entity.remark_attribute", "entity scope - entity attribute"],
      ["remark_schema.remark_entity.remark_attribute", "schema scope - entity attribute"],
      ["remark_schema.remark_entity.remark_attribute", "universal scope - entity attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "entity scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "schema scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_derived_attribute", "universal scope - entity derived attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "entity scope - entity inverse attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "schema scope - entity inverse attribute"],
      ["remark_schema.remark_entity.remark_inverse_attribute", "universal scope - entity inverse attribute"],
      ["remark_schema.remark_entity.UR1", "entity scope - entity unique"],
      ["remark_schema.remark_entity.UR1", "schema scope - entity unique"],
      ["remark_schema.remark_entity.UR1", "universal scope - entity unique"],
      ["remark_schema.remark_entity.WR1", "entity scope - entity where"],
      ["remark_schema.remark_entity.WR1", "entity scope - entity where, with prefix"],
      ["remark_schema.remark_entity.WR1", "schema scope - entity where"],
      ["remark_schema.remark_entity.WR1", "schema scope - entity where, with prefix"],
      ["remark_schema.remark_entity.WR1", "universal scope - entity where"],
      ["remark_schema.remark_entity.WR1", "universal scope - entity where, with prefix"],
      ["remark_schema.remark_entity", "schema scope - entity"],
      ["remark_schema.remark_entity", "universal scope - entity"],
      ["remark_schema.remark_subtype_constraint", "schema scope - subtype constraint"],
      ["remark_schema.remark_subtype_constraint", "universal scope - subtype constraint"],
      ["remark_schema.remark_function.remark_parameter", "function scope - function parameter"],
      ["remark_schema.remark_function.remark_parameter", "schema scope - function parameter"],
      ["remark_schema.remark_function.remark_parameter", "universal scope - function parameter"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "function scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "function scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "schema scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "schema scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "universal scope - function enumeration item"],
      ["remark_schema.remark_function.remark_type.remark_enumeration_item", "universal scope - function enumeration item, on the same level as the type"],
      ["remark_schema.remark_function.remark_type", "function scope - function type"],
      ["remark_schema.remark_function.remark_type", "schema scope - function type"],
      ["remark_schema.remark_function.remark_type", "universal scope - function type"],
      ["remark_schema.remark_function.remark_constant", "function scope - function constant"],
      ["remark_schema.remark_function.remark_constant", "schema scope - function constant"],
      ["remark_schema.remark_function.remark_constant", "universal scope - function constant"],
      ["remark_schema.remark_function.remark_variable", "function scope - function variable"],
      ["remark_schema.remark_function.remark_variable", "schema scope - function variable"],
      ["remark_schema.remark_function.remark_variable", "universal scope - function variable"],
      ["remark_schema.remark_function", "schema scope - function"],
      ["remark_schema.remark_function", "universal scope - function"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "rule scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "rule scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "schema scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "schema scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "universal scope - rule enumeration item"],
      ["remark_schema.remark_rule.remark_type.remark_enumeration_item", "universal scope - rule enumeration item, on the same level as the type"],
      ["remark_schema.remark_rule.remark_type", "rule scope - rule type"],
      ["remark_schema.remark_rule.remark_type", "schema scope - rule type"],
      ["remark_schema.remark_rule.remark_type", "universal scope - rule type"],
      ["remark_schema.remark_rule.remark_constant", "rule scope - rule constant"],
      ["remark_schema.remark_rule.remark_constant", "schema scope - rule constant"],
      ["remark_schema.remark_rule.remark_constant", "universal scope - rule constant"],
      ["remark_schema.remark_rule.remark_variable", "rule scope - rule variable"],
      ["remark_schema.remark_rule.remark_variable", "schema scope - rule variable"],
      ["remark_schema.remark_rule.remark_variable", "universal scope - rule variable"],
      ["remark_schema.remark_rule.WR1", "rule scope - rule where"],
      ["remark_schema.remark_rule.WR1", "rule scope - rule where, with prefix"],
      ["remark_schema.remark_rule.WR1", "schema scope - rule where"],
      ["remark_schema.remark_rule.WR1", "schema scope - rule where, with prefix"],
      ["remark_schema.remark_rule.WR1", "universal scope - rule where"],
      ["remark_schema.remark_rule.WR1", "universal scope - rule where, with prefix"],
      ["remark_schema.remark_rule", "schema scope - rule"],
      ["remark_schema.remark_rule", "universal scope - rule"],
      ["remark_schema.remark_procedure.remark_parameter", "procedure scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_parameter", "schema scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_parameter", "universal scope - procedure parameter"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "procedure scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "procedure scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "schema scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "schema scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "universal scope - procedure enumeration item"],
      ["remark_schema.remark_procedure.remark_type.remark_enumeration_item", "universal scope - procedure enumeration item, on the same level as the type"],
      ["remark_schema.remark_procedure.remark_type", "procedure scope - procedure type"],
      ["remark_schema.remark_procedure.remark_type", "schema scope - procedure type"],
      ["remark_schema.remark_procedure.remark_type", "universal scope - procedure type"],
      ["remark_schema.remark_procedure.remark_constant", "procedure scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_constant", "schema scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_constant", "universal scope - procedure constant"],
      ["remark_schema.remark_procedure.remark_variable", "procedure scope - procedure variable"],
      ["remark_schema.remark_procedure.remark_variable", "schema scope - procedure variable"],
      ["remark_schema.remark_procedure.remark_variable", "universal scope - procedure variable"],
      ["remark_schema.remark_procedure", "schema scope - procedure"],
      ["remark_schema.remark_procedure", "universal scope - procedure"],
      ["remark_schema", "Any character within the EXPRESS character set may occur between the start and end of\nan embedded remark including the newline character; therefore, embedded remarks can span\nseveral physical lines."],
      ["remark_schema", "The tail remark is written at the end of a physical line."],
      ["remark_schema", "UTF8 test: Příliš žluťoučký kůň úpěl ďábelské ódy."],
      ["remark_schema", "universal scope - schema before"],
      ["remark_schema", "universal scope - schema"],
      ["remark_schema.remark_item", "schema scope - schema remark item"],
      ["remark_schema.remark_item", "universal scope - schema remark item"],
    ],
    tagged_survivors: [
      # expressir#603: the bare-tag WHERE item now survives too; the IP
      # informal-proposition texts render back in the ISO shorthand
      # (the all-legacy-scope-remarks train, see tagged_normalized)
      ["unusual_placement", "placed inside WHERE clauses (or other enumerable context)"],
      ["IP1", "entity scope - entity informal proposition, with prefix"],
      ["IP1", "schema scope - entity informal proposition"],
      ["IP1", "schema scope - entity informal proposition, with prefix"],
      ["IP1", "universal scope - entity informal proposition"],
      ["IP1", "universal scope - entity informal proposition, with prefix"],
      ["IP1", "entity scope - entity informal proposition"],
      ["remark_alias", "function alias scope - function alias"],
      ["remark_repeat", "function repeat scope - function repeat"],
      ["remark_query", "function query scope - function query"],
      ["remark_query", "rule query scope - rule query"],
      ["remark_alias", "procedure alias scope - procedure alias"],
      ["remark_repeat", "procedure repeat scope - procedure repeat"],
      ["remark_query", "procedure query scope - procedure query"],
    ],
    # Embedded: one tagged block, on the schema — now conserved by the
    # schema-level source formatter emission. Nothing is lost.
    embedded_lost: 0
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
        normalized = expected[:tagged_normalized] || []
        gained_tagged = conservation.gained(source_tagged, rendered_tagged).keys
        expect(gained_tagged - normalized).to be_empty
        expect(rendered_tagged).to eq(expected[:tagged_survivors])

        source_embedded = conservation.embedded_pairs(source)
        rendered_embedded = conservation.embedded_pairs(rendered)

        expect(conservation.lost(source_embedded, rendered_embedded).values.sum)
          .to eq(expected[:embedded_lost])
        # expressir#603 canonical: remark items re-house as embedded
        # blocks (`(*"path" text *)`), so their tail-sourced bindings
        # appear here as embedded blocks. Same item, same texts — new
        # housing.
        embedded_normalized = expected[:embedded_normalized] || []
        gained_embedded = conservation.gained(source_embedded, rendered_embedded).keys
        expect(gained_embedded - embedded_normalized).to be_empty
        expect(rendered_embedded).to eq(expected[:embedded_survivors])
      end
    end

    # A tagged remark that survives must not stand in for an untagged one that
    # did not. Both carry the text "duplicate" here, and only the tagged one is
    # written back; comparing all remarks together would report no loss at all.
    it "does not let a surviving tagged remark mask an untagged loss", :ruby_lane do
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

    # No fixture puts an embedded remark above a statement, so the emitter
    # for that position went unguarded: deleting only leading embedded
    # remarks from the formatter left every other example in this file green.
    it "keeps an embedded remark written above a statement" do
      source = <<~EXPRESS
        SCHEMA x;
        FUNCTION f : INTEGER;
        (* keep me *)
        RETURN(1);
        END_FUNCTION;
        END_SCHEMA;
      EXPRESS
      rendered = Expressir::Express::Parser.from_exp(source).to_s

      expect(conservation.embedded_pairs(rendered))
        .to eq(conservation.embedded_pairs(source))
      expect(conservation.embedded_pairs(rendered)).to eq([[nil, "keep me"]])
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
    #
    # expressir#653 fix: attachment measures the ORIGINAL captured spans,
    # so the verdict is stable — the losses file is the core-agreed set,
    # byte-identical across the ruby, native, and core lanes.
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
      # The informal-proposition texts render back in the ISO
      # shorthand, tagged IP1/IP2/... — the shorthand is the canonical
      # short-tag form of the source's `wr:IPn` blocks, so the round
      # trip gains those pairs.
      ip_gains = conservation.gained(source_tagged, rendered_tagged).keys
      expect(ip_gains).to all(satisfy { |(tag, _)| tag.match?(/\AIP\d+\z/) })

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

      # expressir#603 canonical: remark items render as embedded blocks
      # now, so the rendered side carries the item blocks. Every
      # rendered embedded remark belongs to a remark item (its tag is a
      # schema path) or is the schema's own description block (the bare
      # schema id — the schema-level source formatter emission); every
      # UNTAGGED embedded remark is still dropped.
      rendered_item_blocks = rendered_embedded.select do |(tag, _), _|
        tag&.start_with?("mathematical_functions_schema")
      end
      expect(rendered_embedded - rendered_item_blocks).to be_empty
      expect(rendered_item_blocks).not_to be_empty
    end
  end
end
