require "thor"
require "yaml"

module Expressir
  class Cli < Thor
    desc "format PATH", "pretty print EXPRESS schema located at PATH"
    def format(path)
      repository = Expressir::Express::Parser.from_file(path)
      repository.schemas.each do |schema|
        puts "\n(* Expressir formatted schema: #{schema.id} *)\n"
        puts schema.to_s(no_remarks: true)
      end
    end

    desc "clean PATH", "Strip remarks and prettify EXPRESS schema at PATH"
    method_option :output, type: :string, desc: "Output file path (defaults to stdout)"
    def clean(path)
      repository = Expressir::Express::Parser.from_file(path)
      formatted_schemas = repository.schemas.map do |schema|
        # Format schema without remarks
        schema.to_s(no_remarks: true)
      end.join("\n\n")

      if options[:output]
        File.write(options[:output], formatted_schemas)
        puts "Cleaned schema written to #{options[:output]}"
      else
        puts formatted_schemas
      end
    end

    desc "benchmark FILE_OR_YAML", "Benchmark schema loading performance for a file or list of files from YAML"
    method_option :ips, type: :boolean, desc: "Use benchmark-ips for detailed statistics"
    method_option :verbose, type: :boolean, desc: "Show verbose output"
    method_option :save, type: :boolean, desc: "Save benchmark results to file"
    method_option :format, type: :string, desc: "Output format (json, csv, default)"
    def benchmark(path)
      # Enable benchmarking via configuration
      Expressir.configuration.benchmark_enabled = true
      Expressir.configuration.benchmark_ips = options[:ips]
      Expressir.configuration.benchmark_verbose = options[:verbose]
      Expressir.configuration.benchmark_save = options[:save]
      Expressir.configuration.benchmark_format = options[:format] if options[:format]

      if [".yml", ".yaml"].include?(File.extname(path).downcase)
        benchmark_from_yaml(path)
      else
        benchmark_file(path)
      end
    end

    desc "benchmark-cache FILE_OR_YAML", "Benchmark schema loading with caching"
    method_option :ips, type: :boolean, desc: "Use benchmark-ips for detailed statistics"
    method_option :verbose, type: :boolean, desc: "Show verbose output"
    method_option :save, type: :boolean, desc: "Save benchmark results to file"
    method_option :format, type: :string, desc: "Output format (json, csv, default)"
    method_option :cache_path, type: :string, desc: "Path to store the cache file"
    def benchmark_cache(path)
      # Same options as benchmark + cache_path
      Expressir.configuration.benchmark_enabled = true
      Expressir.configuration.benchmark_ips = options[:ips]
      Expressir.configuration.benchmark_verbose = options[:verbose]
      Expressir.configuration.benchmark_save = options[:save]
      Expressir.configuration.benchmark_format = options[:format] if options[:format]

      # Run benchmarks with cache
      cache_path = options[:cache_path] || generate_temp_cache_path

      if [".yml", ".yaml"].include?(File.extname(path).downcase)
        benchmark_cache_from_yaml(path, cache_path)
      else
        benchmark_cache_file(path, cache_path)
      end
    end

    no_commands do
      def _validate_schema(path)
        repository = Expressir::Express::Parser.from_file(path)
        repository.schemas.inject([]) do |acc, schema|
          acc << schema.id unless schema.version&.value
          acc
        end
      rescue StandardError
        nil
      end

      def _print_validation_errors(type, array)
        return if array.empty?

        puts "#{'*' * 20} RESULTS: #{type.to_s.upcase.tr('_', ' ')} #{'*' * 20}"
        array.each do |msg|
          puts msg
        end
      end

      def benchmark_file(path)
        puts "Express Schema Loading Benchmark"
        puts "--------------------------------"

        repository = Expressir::Benchmark.measure_file(path) do
          Expressir::Express::Parser.from_file(path)
        end

        if repository
          puts "Loaded #{repository.schemas.size} schemas"
        else
          puts "Failed to load schema"
        end
      end

      def benchmark_from_yaml(yaml_path)
        puts "Express Schema Loading Benchmark from YAML"
        puts "--------------------------------"

        # Load schema list from YAML
        schema_list = YAML.load_file(yaml_path)
        if schema_list.is_a?(Hash) && schema_list["schemas"]
          # Handle format: { "schemas": ["path1", "path2", ...] }
          schema_files = schema_list["schemas"]
        elsif schema_list.is_a?(Array)
          # Handle format: ["path1", "path2", ...]
          schema_files = schema_list
        else
          puts "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
          return
        end

        puts "YAML File: #{yaml_path}"
        puts "Number of schemas in list: #{schema_files.size}"
        puts "--------------------------------"

        # Load the schemas
        Expressir::Benchmark.measure_collection(schema_files) do |file|
          repository = Expressir::Express::Parser.from_file(file)
          repository.schemas
        end
      end

      def benchmark_cache_file(path, cache_path)
        puts "Express Schema Loading Benchmark with Caching"
        puts "--------------------------------"
        puts "Schema: #{path}"
        puts "Cache: #{cache_path}"
        puts "--------------------------------"

        # Benchmark with caching
        results = Expressir::Benchmark.measure_with_cache(path, cache_path) do |file|
          Expressir::Express::Parser.from_file(file)
        end

        if results[:repository]
          schema_count = results[:repository].schemas.size
          puts "Loaded #{schema_count} schemas"
        else
          puts "Failed to load schema"
        end
      end

      def benchmark_cache_from_yaml(yaml_path, cache_path)
        puts "Express Schema Loading Benchmark with Caching from YAML"
        puts "--------------------------------"

        # Load schema list from YAML
        schema_list = YAML.load_file(yaml_path)
        if schema_list.is_a?(Hash) && schema_list["schemas"]
          # Handle format: { "schemas": ["path1", "path2", ...] }
          schema_files = schema_list["schemas"]
        elsif schema_list.is_a?(Array)
          # Handle format: ["path1", "path2", ...]
          schema_files = schema_list
        else
          puts "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
          return
        end

        puts "YAML File: #{yaml_path}"
        puts "Number of schemas in list: #{schema_files.size}"
        puts "Cache: #{cache_path}"
        puts "--------------------------------"

        # Process each file with caching
        schema_files.each_with_index do |file, index|
          puts "Processing file #{index + 1}/#{schema_files.size}: #{file}"

          # Benchmark with caching
          results = Expressir::Benchmark.measure_with_cache(file, cache_path) do |path|
            Expressir::Express::Parser.from_file(path)
          end

          puts "--------------------------------"
        end
      end

      def generate_temp_cache_path
        require "tempfile"
        Tempfile.new(["expressir_cache", ".bin"]).path
      end
    end

    desc "validate *PATH", "validate EXPRESS schema located at PATH"
    def validate(*paths) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      no_version = []
      no_valid = []

      paths.each do |path|
        x = Pathname.new(path).realpath.relative_path_from(Dir.pwd)
        puts "Validating #{x}"
        ret = _validate_schema(path)

        if ret.nil?
          no_valid << "Failed to parse: #{x}"
          next
        end

        ret.each do |schema_id|
          no_version << "Missing version string: schema `#{schema_id}` | #{x}"
        end
      end

      _print_validation_errors(:failed_to_parse, no_valid)
      _print_validation_errors(:missing_version_string, no_version)

      exit 1 unless [no_valid, no_version].all?(&:empty?)

      puts "Validation passed for all EXPRESS schemas."
    end

    desc "version", "Expressir Version"
    def version
      say(Expressir::VERSION)
    end
  end
end
