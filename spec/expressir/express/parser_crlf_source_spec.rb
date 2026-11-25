# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# The parser's batch path reads files in binary mode: the batch workers
# open the files themselves, so their source offsets are raw-byte
# positions, and a text-mode read would translate CRLF on Windows,
# leaving the attach pass's text shorter than every offset past the
# first line end (#778). CRLF (and BOM) files therefore parse, hold
# their remarks and round-trip on every platform, on both lanes.
RSpec.describe Expressir::Express::Parser do
  let(:lf_source) do
    <<~EXP
      SCHEMA crlf_probe;
      ENTITY part;
        size : INTEGER; -- the size remark
      END_ENTITY;
      END_SCHEMA;
    EXP
  end

  let(:crlf_source) { lf_source.gsub("\n", "\r\n") }

  def with_crlf_file(content)
    Dir.mktmpdir("crlf_probe") do |dir|
      path = File.join(dir, "crlf_probe.exp")
      File.binwrite(path, content.b)
      yield path
    end
  end

  shared_examples "CRLF sources parse and hold their remarks" do
    it "parses a CRLF file and holds its remark" do
      with_crlf_file(crlf_source) do |path|
        file = parse.call(path)
        expect(file.schemas.first.id).to eq("crlf_probe")

        formatted = file.format
        expect(formatted).to include("-- the size remark")
        expect(described_class.from_exp(formatted).format).to eq(formatted)
      end
    end

    it "keeps every source offset inside the CRLF text" do
      with_crlf_file(crlf_source) do |path|
        source = File.binread(path)
        file = parse.call(path)

        file.schemas.first.children.each do |node|
          next unless node.respond_to?(:source_offset) && node.source_offset

          expect(node.source_offset).to be < source.bytesize
        end
      end
    end

    it "strips a UTF-8 BOM before parsing a CRLF file" do
      with_crlf_file("\xEF\xBB\xBF".b + crlf_source) do |path|
        file = parse.call(path)
        expect(file.schemas.first.id).to eq("crlf_probe")
      end
    end
  end

  context "with a file read by the core lane" do
    let(:parse) { ->(path) { described_class.from_file(path) } }

    it_behaves_like "CRLF sources parse and hold their remarks"
  end

  # The build-ext job disables the Ruby parse lanes
  # (EXPRESSIR_DISABLE_RUBY_PARSE): the fallback-lane context is the
  # suite's own tag for it.
  context "with a file read by the Ruby builders", :ruby_lane do
    let(:parse) { ->(path) { described_class.from_file(path, use_native: false) } }

    it_behaves_like "CRLF sources parse and hold their remarks"
  end

  it "parses CRLF files through from_files with remarks held inside the bytes" do
    Dir.mktmpdir("crlf_probe") do |dir|
      paths = Array.new(2) do |i|
        path = File.join(dir, "crlf_probe#{i}.exp")
        File.binwrite(path, crlf_source.gsub("crlf_probe", "crlf_probe#{i}").b)
        path
      end
      repo = described_class.from_files(paths)
      expect(repo.schemas.map(&:id)).to contain_exactly("crlf_probe0", "crlf_probe1")

      # The batch workers' offsets are raw-byte positions (#778): every
      # remark the attach pass reads stays within the file's bytes.
      raw = File.binread(paths.first)
      repo.schemas.first.children.each do |node|
        next unless node.respond_to?(:source_offset) && node.source_offset

        expect(node.source_offset).to be < raw.bytesize
      end
      expect(repo.format).to include("-- the size remark")
    end
  end
end
