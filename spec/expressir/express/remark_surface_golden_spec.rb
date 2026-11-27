# frozen_string_literal: true

require "spec_helper"
require "json"
require "tmpdir"

# The whole remark surface, pinned (#793): consumers assert on where
# schema-level prose prints per formatter, which nodes carry which
# remark blocks on the wire, and how the wire nests — and the
# 2.4.86-2.4.90 wave changed those observables in five patch releases
# with no single test holding the whole surface. Each golden file here
# is one consumer-visible surface; a drift breaks exactly the file it
# changes, with the diff as the inventory of the observable change.
#
# EXPRESSIR_UPDATE_GOLDEN=1 bundle exec rspec spec/.../remark_surface_golden_spec.rb
#   rebakes the goldens after a DELIBERATE surface change; the change
#   and its golden diff belong in the changelog of the release that
#   ships it (the cut-over discipline: one deliberate shift, one
#   golden diff, one changelog entry naming it).
# The golden helper carries the expectation; the examples read as
# pins, not as inline assertions.
# CI pins EXPRESSIR_PROVENANCE_VERSION to the last release for stable
# listings; the goldens pin the surface, so they run under the repo's
# own version regardless of the environment's override.
ENV["EXPRESSIR_PROVENANCE_VERSION"] = Expressir::Version::VERSION

RSpec.describe "the remark surface" do # rubocop:disable RSpec/DescribeClass
  let(:golden_dir) { File.expand_path("../../fixtures/golden/remark_surface/golden", __dir__) }
  let(:update) { ENV["EXPRESSIR_UPDATE_GOLDEN"] == "1" }

  let(:root) { File.expand_path("../../fixtures/golden/remark_surface", __dir__) }

  let(:paths) do
    %w[demo_base.exp demo_ext.exp].map { |f| File.join(root, f) }
  end

  let(:repository) do
    Expressir::Express::Parser.from_files(paths, skip_references: true)
  end

  def golden(name, actual)
    path = File.join(golden_dir, name)
    # The logical text is pinned; newline endings ride the checkout
    # platform (git autocrlf) and are normalized on both sides.
    expected = File.binread(path).gsub("\r\n", "\n")
    actual = actual.gsub("\r\n", "\n")
    if update
      File.binwrite(path, actual)
      true
    else
      expect(expected).to eq(actual),
                          "the #{name} surface drifted — the diff above is the observable " \
                          "change; rebake with EXPRESSIR_UPDATE_GOLDEN=1 only for a " \
                          "deliberate change, and name it in the changelog (#793)"
    end
  end

  it "pins the hyperlinked verbatim form" do # rubocop:disable RSpec/NoExpectationExample
    text = Expressir::Express::Formatter.format(repository)
    golden("hyperlinked.adoc.golden", text)
  end

  it "pins the plain form" do # rubocop:disable RSpec/NoExpectationExample
    text = Expressir::Express::PrettyFormatter.new.format(repository)
    golden("plain.exp.golden", text)
  end

  it "pins the stripped source form" do # rubocop:disable RSpec/NoExpectationExample
    text = Expressir::Express::SourceFormatter.new.format(repository)
    golden("stripped.exp.golden", text)
  end

  it "pins the wire shape" do # rubocop:disable RSpec/NoExpectationExample
    # Paths are machine-dependent; the wire pins the SHAPE, with the
    # fixture root normalized to a stable token.
    wire = JSON.pretty_generate(repository.to_hash).gsub(root, "SPEC_FIXTURES")
    golden("wire.json.golden", wire)
  end

  it "pins where schema-level prose rides the model" do # rubocop:disable RSpec/NoExpectationExample
    report = repository.files.filter_map do |file|
      file.schemas.filter_map do |schema|
        prose = Array(schema.remark_items).map do |item|
          item.id.nil? ? "<untagged prose>" : item.id
        end
        "#{schema.id}: #{prose.join(', ')}" unless prose.empty?
      end
    end
    golden("schema_prose.txt.golden", "#{report.join("\n")}\n")
  end

  # The affordance (#793): every remark-surface observable is an option,
  # not a hard-forced behavior — a consumer migrating expectations holds
  # the surface by passing the options, not by chasing patch releases.
  describe Expressir::Express::PrettyFormatter do
    let(:root) do
      File.expand_path("../../fixtures/golden/remark_surface", __dir__)
    end

    let(:repository) do
      Expressir::Express::Parser.from_files(
        [File.join(root, "demo_base.exp")], skip_references: true
      )
    end

    it "suppresses remark blocks with no_remarks" do
      text = described_class.new(no_remarks: true).format(repository)
      expect(text).not_to include("the identifier of the base thing")
      expect(text).not_to include("kind_a: the first kind")
    end

    it "keeps untagged prose while suppressing tagged blocks" do # rubocop:disable RSpec/NoExpectationExample
      text = described_class.new(
        no_remarks: true, keep_untagged_remarks: true,
      ).format(repository)
      expect(text).to include("The base schema carries schema-level prose")
      expect(text).to include("kind_a: the first kind")
      expect(text).not_to include("The tagged block documents the base thing")
    end

    it "carries everything by default" do
      text = described_class.new.format(repository)
      expect(text).to include("kind_a: the first kind")
      expect(text).to include("The base schema carries schema-level prose")
    end
  end
end
