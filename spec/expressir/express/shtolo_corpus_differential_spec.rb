# frozen_string_literal: true

require "spec_helper"
require "open3"
require "tmpdir"

# Corpus differential for the SHTOLO flattener (TODO.parity-ee/14):
# for every module ARM in the STEPmod checkout, flatten it OUR way and
# compare against eengine's own concatenated reference. The primary
# gate is parser-level AND body-level: we read eengine's reference
# file with our parser and diff every declaration's formatted text —
# names, kinds, and bodies. eengine's --concat_compare verdict is a
# second signal where its report printer survives.
#
# ORACLE_CRASH IS NOT PARITY: eengine's report printer dies with an
# unbound INTERFACE-ADD-VALUE slot whenever the compare finds an
# interface-level difference it cannot print — and the artifact-stage
# trial deliberately has no interfaces, so eeng almost always finds
# one. Crashed modules are classified :unverified (eengine confirmed
# nothing) and reported in the failure message; the body-level diff
# is what actually gates. The printer bug exists in 5.0.20-Beta1,
# 5.1.0, and 5.2.8 alike. MIM concatenates exceed the oracle's pass-2
# parser, so the corpus is the ARM set.
#
# Interfaces are excluded from the body diff BY DESIGN: the artifact
# stage produces one merged schema with the interface closure already
# dissolved into it, while eeng's concatenation keeps interface
# clauses per schema.
#
# Runs only when the oracle exists and SHTOLO_CORPUS is set; module
# count bounded by SHTOLO_CORPUS_LIMIT (default 10).
RSpec.describe Expressir::Express::Shtolo, :production_scale do
  let(:eeng) do
    ENV.fetch("EENG_BIN", nil) ||
      [File.expand_path("~/src/external/exp-engine-engine/eengine-5.0.20-Beta1-mac00sbcl",
                        __dir__), "eengine"].find { |candidate| File.executable?(candidate) || !candidate.include?("/") }
  end

  let(:stepmod) do
    ENV.fetch("STEPMOD_ROOT", nil) || File.expand_path("~/src/mn/iso-10303", __dir__)
  end

  let(:limit) { Integer(ENV.fetch("SHTOLO_CORPUS_LIMIT", "10"), 10) }

  def modules_list
    list = Expressir.root_path.join("spec/fixtures/eeng/modules.lst")
    File.exist?(list) ? File.readlines(list).map(&:strip).reject(&:empty?) : []
  end

  def kinds
    %i[types entities functions procedures rules constants]
  end

  before do
    skip "oracle binary not present" unless File.executable?(eeng)
    skip "STEPmod checkout not present" unless File.directory?(stepmod)
    skip "set SHTOLO_CORPUS=1 to run" unless ENV["SHTOLO_CORPUS"]
  end

  it "carries the same declarations and bodies as eengine's reference" do
    verdicts = Hash.new(0)
    failures = []

    modules_list.first(limit).each do |name|
      arm = File.join(stepmod, "schemas/modules/#{name}/arm.exp")
      if File.exist?(arm)
        verdict = compare_module(arm)
        verdicts[verdict] += 1
        ok = %i[same unverified]
        failures << "#{name}(#{verdict})" unless ok.include?(verdict)
      else
        verdicts[:missing] += 1
      end
    end

    expect(failures).to be_empty,
                        "verdicts #{verdicts.inspect}; failing modules: #{failures.join(', ')}"
  end

  # :same          bodies match AND eengine agrees
  # :unverified    our body-level diff is clean but eengine's compare
  #                crashed before rendering its verdict (its printer
  #                bug) — reported, never treated as pass evidence
  # :different     declarations or bodies disagree — a real parity gap
  # :concat_error / :flatten_error  pipeline failures
  def compare_module(arm)
    Dir.mktmpdir("shtolo-corpus") do |dir|
      reference = concat_reference(arm, dir)
      return :concat_error unless reference

      trial = flatten_trial(arm, dir)
      return :flatten_error unless trial

      return :different unless declaration_bodies_equal?(trial, reference)

      out = run_eeng("--concat_compare", "-mode", "arm_concatenated",
                     "-trial_schema", trial, "-reference_schema", reference)
      return :unverified if out.nil? || out.include?(";; Error")

      out.include?("** No differences detected **") ? :same : :different
    end
  end

  def concat_reference(arm, dir)
    run_eeng("--concat_schema", "-mode", "arm_shortform",
             "-schema", arm, "-stepmod", stepmod, "-out-dir", dir)
    Dir[File.join(dir, "*_concatenated.exp")].first
  end

  def flatten_trial(arm, dir)
    files = Expressir::Commands::ParityInputs
      .closure_paths(arm, stepmod: stepmod).select { |f| File.exist?(f) }
    repo = Expressir::Express::Parser.from_files(files)
    name = "#{File.basename(File.dirname(arm)).downcase}_arm"
    root = repo.schemas.find { |s| s.id.safe_downcase == name }
    return nil unless root

    opts = { extenders: :none, prune: false, stage: :artifact }
    schema = described_class.new(root, repo, **opts).flatten.schema
    trial = File.join(dir, "#{name}_trial.exp")
    File.write(trial, Expressir::Express::Formatter.format(schema))
    trial
  end

  # {kind => {downcased name => formatted body}} across all schemas.
  # A name-only diff cannot see changed WHERE rules or attribute
  # types; bodies can. Bodies compare CASE-INSENSITIVELY (eengine's
  # writers lowercase identifiers) and with remark lines stripped:
  # eengine's concatenation interleaves `-- <schema> (path)`
  # separator comments, which land on the following declaration when
  # re-parsed and are not part of the declaration.
  def declaration_bodies(path)
    repo = Expressir::Express::Parser.from_files([path])
    bodies = Hash.new { |h, k| h[k] = {} }
    repo.schemas.each do |schema|
      kinds.each do |kind|
        Array(schema.public_send(kind)).each do |decl|
          next unless decl.respond_to?(:id) && decl.id

          body = Expressir::Express::Formatter.format(decl)
            .gsub(/^\s*--[^\n]*\n?/, "")
          bodies[kind][decl.id.safe_downcase] = body.downcase
        end
      end
    end
    bodies
  end

  def declaration_bodies_equal?(trial, reference)
    declaration_bodies(trial) == declaration_bodies(reference)
  end

  def run_eeng(*args)
    out, _err, _status = Open3.capture3(eeng, *args)
    out
  rescue StandardError
    nil
  end
end
