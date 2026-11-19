# frozen_string_literal: true

require "spec_helper"
require "json"
require "open3"

RSpec.describe Expressir::Express::Core, "#646 lsp workspace delegation" do
  # The delegation choice is made at load time (the ext registers the
  # Core singletons), so the two lanes run in separate processes: the
  # native lane as-is, the fallback lane under EXPRESSIR_DISABLE_NATIVE.
  let(:fixtures) do
    dir = Expressir.root_path.join("spec/fixtures/class_coverage")
    {
      "file:///a.exp" => File.read(dir.join("support_schema.exp")),
      "file:///b.exp" => File.read(dir.join("interfaced_items.exp")),
    }
  end

  def lane_rows(disable_native:)
    script = <<~RUBY
      require "json"
      require "expressir"
      require "expressir/lsp"

      fixtures = JSON.parse(ARGV[0])
      workspace = Expressir::Lsp::Workspace.new
      fixtures.each do |uri, text|
        workspace.open(uri: uri, text: text)
      end

      rows = {}
      fixtures.keys.each do |uri|
        rows["symbols:\#{uri}"] = workspace.symbols(uri)
        symbol = workspace.symbols(uri).find do |s|
          s["kind"] == 5 # an entity (Class)
        end
        next unless symbol

        position = symbol["selectionRange"]["start"]
        rows["rename:\#{uri}"] = workspace.rename(uri, position, "renamed_thing")
      end
      puts JSON.generate(rows)
    RUBY
    env = disable_native ? { "EXPRESSIR_DISABLE_NATIVE" => "1" } : {}
    out, err, status = Open3.capture3(env, RbConfig.ruby, "-e", script,
                                      JSON.generate(fixtures))
    raise "lane failed: #{err}" unless status.success?

    JSON.parse(out)
  end

  it "produces identical symbol and rename rows on both lanes" do
    native = lane_rows(disable_native: false)
    fallback = lane_rows(disable_native: true)

    expect(native).to eq(fallback)
    expect(native.keys).to include(a_string_starting_with("symbols:"))
    expect(native.keys).to include(a_string_starting_with("rename:"))
  end

  it "keeps the fallback lane functional without the extension" do
    fallback = lane_rows(disable_native: true)
    symbols = fallback.values.find do |rows|
      rows.is_a?(Array) && rows.any?
    end
    expect(symbols).to be_truthy
  end
end
