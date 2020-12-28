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

# workaround for:
#  Don't know how to build task 'tmp/RUBY_PLATFORM/stage/ext/express-parser/antlr4-upstream' (see --tasks)
antlr_dir = File.join ext.ext_dir, 'antlr4-upstream'
stage_dir = File.join ext.tmp_dir, RUBY_PLATFORM, 'stage'
antrl4_out_dir = File.join stage_dir, antlr_dir
file antrl4_out_dir do |t|
  FileUtils.ln_s File.expand_path(antlr_dir), antrl4_out_dir
end