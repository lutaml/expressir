# frozen_string_literal: true

require "spec_helper"
require "tmpdir"
require_relative "shtolo_corpus_differential_spec"

RSpec.describe ShtoloCorpusDifferential do
  it "strips trailing separator comments but keeps `--` inside string literals" do
    src = <<~EXP
      ENTITY x; v : STRING := 'a -- b'; END_ENTITY;
      end_function; -- other_arm (schemas/modules/other/arm.exp)
    EXP
    expect(described_class.strip_express_comments(src)).to eq(<<~EXP)
      ENTITY x; v : STRING := 'a -- b'; END_ENTITY;
      end_function;
    EXP
  end

  it "keeps doubled quotes inside string literals intact" do
    src = "ENTITY x; v : STRING := 'it''s -- fine'; END_ENTITY;\n"
    expect(described_class.strip_express_comments(src)).to eq(src)
  end

  it "resolves a bare eengine name through PATH" do
    Dir.mktmpdir do |dir|
      bin = File.join(dir, "eengine")
      File.write(bin, "#!/bin/sh\n")
      FileUtils.chmod("+x", bin)
      old = ENV.fetch("PATH", nil)
      ENV["PATH"] = dir
      begin
        expect(described_class.eengine_on_path).to eq(bin)
      ensure
        ENV["PATH"] = old
      end
    end
  end

  it "returns nil when eengine is on neither the default path nor PATH" do
    old = ENV.fetch("PATH", nil)
    ENV["PATH"] = ""
    begin
      expect(described_class.eengine_on_path).to be_nil
    ensure
      ENV["PATH"] = old
    end
  end
end
