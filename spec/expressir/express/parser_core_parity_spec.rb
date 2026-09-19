# frozen_string_literal: true

require "spec_helper"

# Remark attachment is position-dependent and rides on source_offset,
# which the wire format cannot carry yet (TODO.expressir-rs/06).
REMARK_KEYS = %w[remarks untagged_remarks remark_items header].freeze

RSpec.describe Expressir::Express::Parser, :no_cache do
  # The Rust core path (use_core: true) must produce a model whose
  # serialized shape matches the Ruby parse path. Structural equality
  # covers every declaration, type, expression, and statement node;
  # remark attachment is excluded until source_offset rides the wire
  # (needs a write-only lutaml-model mapping — TODO.expressir-rs/06).
  def structural(hash)
    case hash
    when Hash
      hash.each_with_object({}) do |(key, value), out|
        next if REMARK_KEYS.include?(key)

        stripped = structural(value)
        next if stripped.nil? || (stripped.respond_to?(:empty?) && stripped.empty?)

        out[key] = stripped
      end
    when Array
      stripped = hash.filter_map { |v| structural(v) }
      stripped.empty? ? nil : stripped
    else
      hash
    end
  end

  def syntax_fixtures
    Dir[File.expand_path("../../syntax/*.exp", __dir__)]
  end

  it "hydrates the same model structure as the Ruby path" do
    skip "expressir core extension not compiled" unless Expressir::Express::Core::NATIVE_AVAILABLE

    failures = syntax_fixtures.filter_map do |file|
      ruby_model = described_class.from_file(file)
      core_model = described_class.from_file(file, use_core: true)
      next unless structural(ruby_model.to_hash) != structural(core_model.to_hash)

      File.basename(file)
    rescue Expressir::Express::Error::SchemaParseFailure
      # Unparseable on both paths — covered by the failure-parity
      # example below.
      nil
    rescue StandardError => e
      "#{File.basename(file)} raised #{e.class}"
    end
    expect(failures).to be_empty
  end

  it "reports the same parse failures as the Ruby path" do
    skip "expressir core extension not compiled" unless Expressir::Express::Core::NATIVE_AVAILABLE

    syntax_fixtures.each do |file|
      ruby_outcome = begin
        described_class.from_file(file)
        :ok
      rescue Expressir::Express::Error::SchemaParseFailure
        :failure
      end
      core_outcome = begin
        described_class.from_file(file, use_core: true)
        :ok
      rescue Expressir::Express::Error::SchemaParseFailure
        :failure
      end
      expect(core_outcome).to eq(ruby_outcome), file
    end
  end
end
