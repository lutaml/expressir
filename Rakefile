require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

GEMSPEC = Gem::Specification.load("expressir.gemspec")

Gem::PackageTask.new(GEMSPEC).define
