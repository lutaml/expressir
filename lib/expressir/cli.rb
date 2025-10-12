require "thor"
require "yaml"

require_relative "commands/base"
require_relative "commands/format"
require_relative "commands/clean"
require_relative "commands/benchmark"
require_relative "commands/benchmark_cache"
require_relative "commands/validate"
require_relative "commands/coverage"
require_relative "commands/changes"
require_relative "commands/version"

module Expressir
  class Cli < Thor
    # Exit with error code on command failures
    def self.exit_on_failure?
      true
    end

    desc "format PATH", "pretty print EXPRESS schema located at PATH"
    def format(path)
      Commands::Format.new(options).run(path)
    end

    desc "clean PATH", "Strip remarks and prettify EXPRESS schema at PATH"
    method_option :output, type: :string,
                           desc: "Output file path (defaults to stdout)"
    def clean(path)
      Commands::Clean.new(options).run(path)
    end

    desc "benchmark FILE_OR_YAML",
         "Benchmark schema loading performance for a file or list of files from YAML"
    method_option :ips, type: :boolean,
                        desc: "Use benchmark-ips for detailed statistics"
    method_option :verbose, type: :boolean, desc: "Show verbose output"
    method_option :save, type: :boolean, desc: "Save benchmark results to file"
    method_option :format, type: :string,
                           desc: "Output format (json, csv, default)"
    def benchmark(path)
      Commands::Benchmark.new(options).run(path)
    end

    desc "benchmark-cache FILE_OR_YAML", "Benchmark schema loading with caching"
    method_option :ips, type: :boolean,
                        desc: "Use benchmark-ips for detailed statistics"
    method_option :verbose, type: :boolean, desc: "Show verbose output"
    method_option :save, type: :boolean, desc: "Save benchmark results to file"
    method_option :format, type: :string,
                           desc: "Output format (json, csv, default)"
    method_option :cache_path, type: :string,
                               desc: "Path to store the cache file"
    def benchmark_cache(path)
      Commands::BenchmarkCache.new(options).run(path)
    end

    desc "validate *PATH", "validate EXPRESS schema located at PATH"
    def validate(*paths)
      Commands::Validate.new(options).run(paths)
    end

    desc "coverage *PATH",
         "List EXPRESS entities and check documentation coverage"
    method_option :format, type: :string,
                           desc: "Output format (text, json, yaml)", default: "text"
    method_option :exclude, type: :string,
                            desc: "Comma-separated list of EXPRESS entity types to skip from coverage (e.g., TYPE,CONSTANT,TYPE:SELECT)"
    method_option :output, type: :string,
                           desc: "Output file path for JSON/YAML formats (defaults to coverage_report.json/yaml)"
    method_option :ignore_files, type: :string,
                                 desc: "Path to YAML file containing array of files to ignore from overall coverage calculation"
    def coverage(*paths)
      Commands::Coverage.new(options).run(paths)
    end

    desc "changes SUBCOMMAND", "Commands for EXPRESS Changes files"
    subcommand "changes", Commands::Changes

    desc "version", "Expressir Version"
    def version
      Commands::Version.new(options).run
    end
  end
end
