$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "bundler/setup"
require "psych"
STANDARD_PSYCH = Psych
require "expressir"
require "yaml"
require "canon"

Dir["./spec/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  # canon 0.3.x probes the optional yeptris engine on its first YAML parse;
  # the probe's partial require rebinds ::Psych to a build that crashes on
  # mingw (leptris/yeptris#318). Restore the standard parser after every
  # example so the rebind cannot leak between them.
  config.around do |example|
    example.run
    Object.const_set(:Psych, STANDARD_PSYCH) if Psych != STANDARD_PSYCH
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.include Expressir::ConsoleHelper
  config.include Expressir::ModelElementSpecHelper

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

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
