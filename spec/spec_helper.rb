require "bundler/setup"
require "expressir"

Dir["./spec/support/**/*.rb"].sort.each { |file| require file }

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

  config.around(:example) do |ex|
    ex.run
  rescue SystemExit => e
    puts "Got SystemExit: #{e.inspect}."
    raise
  end
end
