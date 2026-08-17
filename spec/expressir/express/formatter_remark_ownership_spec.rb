# frozen_string_literal: true

require "spec_helper"

# Where each remark ends up, as opposed to whether it survives.
#
# A remark can come through a round trip intact and still be wrong. On main,
# two remarks in `function_body_remarks.exp` escape a REPEAT loop and reattach
# to the enclosing statement and function: the text is present, spelled the
# same, and counted, so the conservation spec passes them. This one does not.
#
# Tagged remarks are traced too. They live in a plain string collection on
# the element they bind to rather than in the RemarkInfo list, and reading
# only the latter made this spec pass `remark.exp` while examining none of
# its remarks. That fixture holds 133 tagged tail remarks and one tagged
# embedded remark, hence 134.
#
# The only move allowed is the documented schema-level gap, where a remark
# between declarations is written outside its SCHEMA and a reparse attaches it
# to the file. `escapes` names the remarks allowed to make that move, and the
# shape is checked so a remark leaving any other construct fails. Naming them
# rather than counting them is what stops one remark from starting to escape
# while another stops, which a count cannot tell apart from no change at all.
#
# `traced` and `tagged` are floors, not snapshots, and they exist for a
# different reason: an ownership check that reads no remarks passes every
# fixture. That is exactly how the tagged-remark blind spot went unnoticed,
# `remark.exp` reporting no moves while none of its remarks were read.
# Adding a comment to a shared fixture should not fail these; losing coverage
# should.
#
# An `escapes` entry is a remark identity: text, RemarkInfo format, taggedness.
round_trips = {
  "spec/fixtures/examples/autonomous_vehicle_navigation_schema.exp" =>
    { traced: 29, tagged: 20,
      escapes: [["vr_geometry_schema", "tail", false]] },
  "spec/fixtures/examples/geometry_schema.exp" =>
    { traced: 28, tagged: 20, escapes: [] },
  "spec/fixtures/examples/nested_functions_test_schema.exp" =>
    { traced: 10, tagged: 0,
      escapes: [["Top-level procedure with inner function", "tail", false]] },
  # Nine, because this fixture is a deliberate spread of schema-level
  # remarks: before and after the constant block, before a type, and two
  # outside SCHEMA entirely.
  "spec/fixtures/examples/tail_remarks_test_schema.exp" =>
    { traced: 33, tagged: 7,
      escapes: [
        ["Multiple consecutive untagged tail remarks", "tail", false],
        ["Testing coexistence of all four remark types", "tail", false],
        ["Untagged embedded remark", "embedded", false],
        ["Untagged tail remark after function", "tail", false],
        ["Untagged tail remark after schema declaration", "tail", false],
        ["Untagged tail remark before function", "tail", false],
        ["Untagged tail remark before schema end", "tail", false],
        ["in the correct order and position", "tail", false],
        ["showing that they should all be preserved", "tail", false],
      ] },
  "spec/fixtures/function_body_remarks.exp" =>
    { traced: 13, tagged: 0, escapes: [] },
  "spec/syntax/remark.exp" =>
    { traced: 134, tagged: 134, escapes: [] },
  "spec/syntax/syntax.exp" =>
    { traced: 22, tagged: 0,
      escapes: [["constants", "tail", false], ["interfaces", "tail", false]] },
}.freeze

RSpec.describe Expressir::Express::Formatter do
  let(:ownership) { Expressir::RemarkOwnership }

  describe "remark ownership" do
    round_trips.each do |path, expected|
      it "keeps every surviving remark of #{File.basename(path)} in place" do
        source_model = Expressir::Express::Parser.from_file(path)
        reparsed_model = Expressir::Express::Parser.from_exp(
          source_model.to_s,
        )

        traced = Expressir::RemarkOwnership::Trace.of(source_model)
        moved = ownership.moved(
          traced, Expressir::RemarkOwnership::Trace.of(reparsed_model)
        )

        expect(traced.size).to be >= expected[:traced]
        expect(traced.count(&:tagged))
          .to be >= expected[:tagged]
        expect(moved.reject { |_, move| ownership.schema_escape?(move) })
          .to eq({})
        # Sorted through a key rather than directly: an identity holds a nil
        # format for a tagged remark and a boolean for taggedness, and sorting
        # tuples that differ there raises.
        escaped = moved.keys.sort_by do |text, format, tagged|
          [text, format.to_s, tagged ? 1 : 0]
        end

        expect(escaped).to eq(expected[:escapes])
      end
    end
  end
end
