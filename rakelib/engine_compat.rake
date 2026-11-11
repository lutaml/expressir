# frozen_string_literal: true

require "rake"

namespace :lint do
  desc "Verify ENGINE-COMPAT.json against the ext pin and rubygems (#618)"
  task :engine_compat do
    require_relative "../lib/expressir/tools/check_engine_compat"
    failures = Expressir::Tools::CheckEngineCompat.failures(root: Dir.pwd)
    if failures.empty?
      puts "lint:engine_compat OK"
    else
      warn failures.join("\n")
      raise "lint:engine_compat found #{failures.length} problem(s)"
    end
  end
end
