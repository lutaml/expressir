# frozen_string_literal: true

require "spec_helper"
require "tempfile"

RSpec.describe Expressir::Commands::ValidateRemarks do
  def write_schema(dir, duplication: false)
    path = File.join(dir, "schema.exp")
    # The duplicate-anchor check guards RENDERED scopes (tagged remark
    # blocks only — the #679 differentiation), so both colliding scopes
    # are tagged remark items.
    dup_scope = +""
    if duplication
      dup_scope = <<~EXP
        (*"sample.__dup"
        [[fig-one]]
        image::fig-one.svg[]
        *)
      EXP
    end
    File.write(path, <<~EXP)
      SCHEMA sample;
        (*"sample.__fund_cons"
        [[fig-one]]
        image::fig-one.svg[]
        *)
        ENTITY a; END_ENTITY;
        #{dup_scope}END_SCHEMA;
    EXP
    path
  end

  it "passes when each block anchor lives in a single remark scope" do
    Dir.mktmpdir("remarks-cli") do |dir|
      path = write_schema(dir)

      expect do
        described_class.new({}).run([path])
      end.not_to raise_error
    end
  end

  it "raises when an anchor is defined in two remark scopes" do
    Dir.mktmpdir("remarks-cli") do |dir|
      path = write_schema(dir, duplication: true)

      expect do
        described_class.new({}).run([path])
      end.to raise_error(Expressir::SchemaValidationError) do |error|
        report = error.errors.join(" | ")
        expect(report).to include("Duplicate remark block anchor `fig-one`")
        expect(report).to include("__fund_cons")
      end
    end
  end

  it "accepts a schema manifest" do
    Dir.mktmpdir("remarks-cli") do |dir|
      path = write_schema(dir)
      manifest = File.join(dir, "manifest.yaml")
      File.write(manifest, <<~YAML)
        ---
        schemas:
          sample:
            path: #{path}
      YAML

      expect do
        described_class.new({}).run([manifest])
      end.not_to raise_error
    end
  end
end
