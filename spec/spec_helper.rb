$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

# leptris 1.9.242+ mingw builds hang at native attach on windows (the
# windows sibling of leptris/leptris#1623): the rake matrix jobs have
# hit the 6h runner limit since the bundle moved to the leptris 1.9.3xx
# line (expressir#487). The pure-Ruby fallback avoids the attach; the
# gem line stays untouched.
ENV["LEPTRIS_NO_NATIVE"] = "1" if Gem.win_platform?

require "bundler/setup"
require "expressir"
require "yaml"
require "canon"

Dir["./spec/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.include Expressir::ConsoleHelper
  config.include Expressir::ModelElementSpecHelper

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Checks that parse a production-scale schema. They cost about a minute, so
  # `rake verify:remarks` runs them rather than the default suite.
  if ENV["EXPRESSIR_PRODUCTION_SCALE"].to_s.empty?
    config.filter_run_excluding :production_scale
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around do |ex|
    ex.run
  rescue Expressir::Error => e
    # rubocop:disable all
    puts "Got Expressir::Error: #{e.inspect}."
    if e.backtrace
      puts e.backtrace
    end
    # rubocop:enable all
    raise
  end
end

require "lutaml/model"
Lutaml::Model::Config.configure do |config|
  config.json_adapter_type = :standard
  config.xml_adapter_type = :nokogiri
  # Pin the YAML adapter so golden-file specs do not depend on whether
  # the optional yeptris engine is in the bundle (its output omits the
  # leading "---" document marker that Psych emits).
  config.yaml_adapter_type = :standard
end
