# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

RSpec.describe Expressir::Express::Parser, "compiled schema set" do
  let(:files) do
    %w[syntax syntax_formatted remark].filter_map do |stem|
      path = File.expand_path("../../syntax/#{stem}.exp", __dir__)
      File.exist?(path) ? path : nil
    end
  end
  let(:set_path) { File.expand_path("tmp_compiled_set.exscs", Dir.tmpdir) }

  before { File.delete(set_path) if File.exist?(set_path) }

  after { File.delete(set_path) if File.exist?(set_path) }

  def core_available?
    Expressir::Express::Core::NATIVE_AVAILABLE &&
      Expressir::Core.const_defined?(:Set, false)
  end

  it "warm-loads a byte-identical repository from the artifact" do
    skip "native extension with compiled-set support required" unless core_available?

    cold = described_class.from_files(files, compiled_set: set_path)
    expect(File.exist?(set_path)).to be(true)
    expect(File.exist?("#{set_path}.remarks.json")).to be(true)
    cold_hashes = cold.files.map(&:to_hash)

    warm = described_class.from_files(files, compiled_set: set_path)
    expect(warm.files.map(&:to_hash)).to eq(cold_hashes)
  end

  it "rejects an artifact whose sources changed" do
    skip "native extension with compiled-set support required" unless core_available?

    described_class.from_files(files, compiled_set: set_path)
    set = Expressir::Core::Set.open(set_path)
    read_paths = files.to_h { |f| [f, f] }
    expect(set.matches_sources(read_paths)).to be(true)

    original = File.read(files[0])
    File.write(files[0], original + "\n-- staleness probe\n")
    begin
      expect(set.matches_sources(read_paths)).to be(false)
    ensure
      File.write(files[0], original)
    end
    expect(set.matches_sources(read_paths)).to be(true)
  end
end
