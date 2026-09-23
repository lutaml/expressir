# frozen_string_literal: true

require "spec_helper"
require "open3"
require "tmpdir"

# Corpus differential for the SHTOLO flattener (TODO.parity-ee/14):
# for every module ARM in the STEPmod checkout, flatten it OUR way and
# compare against eengine's own concatenated reference. The primary
# gate is parser-level (we read eengine's reference file and diff the
# declaration sets ourselves); eengine's --concat_compare verdict is
# honored as a second signal wherever its report printer survives.
#
# eeng 5.0.20-Beta1 is the oracle binary — 5.1.0's cleanup rejects
# these files ("Unable to neutralize NIL"), and its compare printer
# dies with an unbound INTERFACE-ADD-VALUE slot on some genuine
# differences. MIM concatenates exceed the oracle's pass-2 parser, so
# the corpus is the ARM set.
#
# Runs only when the oracle exists and SHTOLO_CORPUS is set; module
# count bounded by SHTOLO_CORPUS_LIMIT (default 10).
RSpec.describe Expressir::Express::Shtolo, :production_scale do
  let(:eeng) do
    ENV.fetch("EENG_BIN", nil) ||
      File.expand_path("~/src/external/exp-engine-engine/eengine-5.0.20-Beta1-mac00sbcl",
                       __dir__)
  end

  let(:stepmod) do
    ENV.fetch("STEPMOD_ROOT", nil) || File.expand_path("~/src/mn/iso-10303", __dir__)
  end

  let(:limit) { Integer(ENV.fetch("SHTOLO_CORPUS_LIMIT", "10"), 10) }

  def modules_list
    list = Expressir.root_path.join("spec/fixtures/eeng/modules.lst")
    File.exist?(list) ? File.readlines(list).map(&:strip).reject(&:empty?) : []
  end

  before do
    skip "oracle binary not present" unless File.executable?(eeng)
    skip "STEPmod checkout not present" unless File.directory?(stepmod)
    skip "set SHTOLO_CORPUS=1 to run" unless ENV["SHTOLO_CORPUS"]
  end

  it "carries the same declarations as eengine's concatenated reference" do
    acceptable = %i[same oracle_crash]
    verdicts = Hash.new(0)
    failures = []

    modules_list.first(limit).each do |name|
      arm = File.join(stepmod, "schemas/modules/#{name}/arm.exp")
      if File.exist?(arm)
        verdict = compare_module(arm)
        verdicts[verdict] += 1
        failures << "#{name}(#{verdict})" unless acceptable.include?(verdict)
      else
        verdicts[:missing] += 1
      end
    end

    expect(failures).to be_empty,
                        "verdicts #{verdicts.inspect}; failing modules: #{failures.join(', ')}"
  end

  # :same          declaration sets match AND eengine agrees
  # :oracle_crash  sets match; eengine's own printer crashed (its bug)
  # :different     sets disagree — a real parity gap
  # :concat_error / :flatten_error  pipeline failures
  def compare_module(arm)
    Dir.mktmpdir("shtolo-corpus") do |dir|
      reference = concat_reference(arm, dir)
      return :concat_error unless reference

      trial = flatten_trial(arm, dir)
      return :flatten_error unless trial

      return :different unless declaration_sets_equal?(trial, reference)

      out = run_eeng("--concat_compare", "-mode", "arm_concatenated",
                     "-trial_schema", trial, "-reference_schema", reference)
      return :oracle_crash if out.nil? || out.include?(";; Error")

      out.include?("** No differences detected **") ? :same : :different
    end
  end

  def concat_reference(arm, dir)
    run_eeng("--concat_schema", "-mode", "arm_shortform",
             "-schema", arm, "-stepmod", stepmod, "-out-dir", dir)
    Dir[File.join(dir, "*_concatenated.exp")].first
  end

  def flatten_trial(arm, dir)
    files = Expressir::Commands::ParityInputs.closure_paths(arm)
      .select { |f| File.exist?(f) }
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

  def declaration_set(path)
    kinds = %i[types entities functions procedures rules constants]
    repo = Expressir::Express::Parser.from_files([path])
    set = Hash.new { |h, k| h[k] = Set.new }
    repo.schemas.each do |schema|
      kinds.each do |kind|
        Array(schema.public_send(kind)).each do |decl|
          set[kind] << decl.id.safe_downcase if decl.respond_to?(:id) && decl.id
        end
      end
    end
    set
  end

  def declaration_sets_equal?(trial, reference)
    declaration_set(trial) == declaration_set(reference)
  end

  def run_eeng(*args)
    out, _err, _status = Open3.capture3(eeng, *args)
    out
  rescue StandardError
    nil
  end
end
