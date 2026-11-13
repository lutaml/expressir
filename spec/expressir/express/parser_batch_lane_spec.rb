# frozen_string_literal: true

require "spec_helper"

# expressir#659: the repository load parallelizes the cold per-schema
# parse on native threads (Expressir::Core::BatchStream) — the parse
# holds no GVL, so a cold multi-schema load scales with cores while
# staying byte-identical to sequential parsing and preserving input
# order. The fork pool (ParallelFiles) stays opt-in; the batch lane is
# the default for multi-file loads when the extension is present.
RSpec.describe Expressir::Express::Parser, :ruby_lane do
  let(:syntax_dir) { File.expand_path("../../syntax", __dir__) }
  let(:files) do
    %w[single.exp multiple.exp derived_attribute.exp geometry_schema.exp]
      .map { |f| File.join(syntax_dir, f) }
      .select { |f| File.exist?(f) }
  end

  def parse(paths, **opts)
    Expressir::Express::Parser.from_files(paths, skip_references: true, **opts)
  end

  def batch_enabled?
    Expressir::Express::Core::NATIVE_AVAILABLE &&
      Expressir::Core.const_defined?(:BatchStream, false)
  end

  it "is the default lane for a multi-file load when the ext is present" do
    skip "native batch lane unavailable" unless batch_enabled?

    expect(files.size).to be > 1
    repo = parse(files)
    expect(repo.files.size).to eq(files.size)
    expect(repo.files.compact.map(&:path)).to eq(files)
  end

  it "produces byte-identical models and order to the sequential lane" do
    skip "native batch lane unavailable" unless batch_enabled?

    batched = parse(files)
    sequential = parse(files, use_native: false)

    expect(batched.files.size).to eq(sequential.files.size)
    batched.files.zip(sequential.files).each do |batched_file, sequential_file|
      expect(batched_file.path).to eq(sequential_file.path)
      expect(batched_file.to_hash).to eq(sequential_file.to_hash)
    end
  end

  it "honors a worker cap" do
    skip "native batch lane unavailable" unless batch_enabled?

    repo = parse(files, max_processes: 2)
    expect(repo.files.compact.map(&:path)).to eq(files)
    expect(repo.files.compact.map(&:schemas).flatten.map(&:id)).not_to be_empty
  end

  it "keeps nil-padding parse failures in input position" do
    skip "native batch lane unavailable" unless batch_enabled?

    broken = File.join(syntax_dir, "broken_batch_probe.exp")
    File.write(broken, "SCHEMA broken;\nENTITY\nEND_SCHEMA;\n")
    begin
      nil
      errors = []
      described_class.from_files(
        [files.first, broken, files.last], skip_references: true
      ) do |file, exp_file, error|
        errors << file if error
        exp_file
      end
      repo = described_class.from_files(
        [files.first, broken, files.last], skip_references: true
      )
      expect(repo.files[0]).not_to be_nil
      expect(repo.files[1]).to be_nil
      expect(repo.files[2]).not_to be_nil
      expect(errors).to eq([broken])
    ensure
      File.delete(broken)
    end
  end
end
