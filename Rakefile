require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"
require "rubocop/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)

task default: %i[compile spec]

GEMSPEC = Gem::Specification.load("expressir.gemspec")

RuboCop::RakeTask.new

Gem::PackageTask.new(GEMSPEC).define

YARD::Rake::YardocTask.new
