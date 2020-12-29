require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

spec = Gem::Specification.load("expressir.gemspec")

# add your default gem packing task
Gem::PackageTask.new(spec) do |pkg|
end

ext = Rake::ExtensionTask.new("express_parser", spec) do |ext|
  ext.ext_dir = "ext/express-parser"
end
