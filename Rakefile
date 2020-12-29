require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

spec = Gem::Specification.load("expressir.gemspec")

# add your default gem packing task
Gem::PackageTask.new(spec) do |pkg|
end

# HACK: Prevent rake-compiler from overriding required_ruby_version,
# because the shared library here is Ruby-agnostic.
# See https://github.com/rake-compiler/rake-compiler/issues/153
module FixRequiredRubyVersion
  def required_ruby_version=(*); end
end
Gem::Specification.prepend(FixRequiredRubyVersion)

ext = Rake::ExtensionTask.new("express_parser", spec) do |ext|
  ext.ext_dir = "ext/express-parser"
end
