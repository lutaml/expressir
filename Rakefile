# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require "yard"

YARD::Rake::YardocTask.new

desc "Regenerate the EXPRESS grammar JSON embedded in expressir-core"
task :"expressir:grammar:dump" do
  require "expressir/express/grammar/parser"
  json = Expressir::Express::Grammar::Parser.cached_grammar_json
  path = File.expand_path("crates/expressir-core/assets/express-grammar.json", __dir__)
  File.write(path, "#{json}\n")
  puts "wrote #{path}"
end
