$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
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

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around do |ex|
    ex.run
  rescue SystemExit => e
    puts "Got SystemExit: #{e.inspect}."
    puts e.backtrace if e.backtrace
    # raise
  end
end
