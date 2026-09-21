# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require "yard"

YARD::Rake::YardocTask.new

Dir.glob(File.expand_path("lib/tasks/*.rake", __dir__)).sort.each { |task| load task }
