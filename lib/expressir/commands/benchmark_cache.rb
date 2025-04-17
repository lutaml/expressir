module Expressir
  module Commands
    class BenchmarkCache < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Configure benchmarking options
        configure_benchmarking

        # Set up cache path
        cache_path = options[:cache_path] || generate_temp_cache_path

        # Process each path
        paths.each do |path|
          process_benchmark_cache_path(path, cache_path)
        end
      end

      private

      def process_benchmark_cache_path(path, cache_path)
        # Determine the path type and benchmark appropriately
        if File.directory?(path)
          benchmark_cache_directory(path, cache_path)
        elsif [".yml", ".yaml"].include?(File.extname(path).downcase)
          benchmark_cache_from_yaml(path, cache_path)
        else
          benchmark_cache_file(path, cache_path)
        end
      end

      def configure_benchmarking
        Expressir.configuration.benchmark_enabled = true
        Expressir.configuration.benchmark_ips = options[:ips]
        Expressir.configuration.benchmark_verbose = options[:verbose]
        Expressir.configuration.benchmark_save = options[:save]
        Expressir.configuration.benchmark_format = options[:format] if options[:format]
      end

      def benchmark_cache_directory(dir_path, cache_path)
        say "Express Schema Directory Loading Benchmark with Caching"
        say "--------------------------------"

        # Find all .exp files in directory
        exp_files = Dir.glob(File.join(dir_path, "**", "*.exp"))

        # Early return if no files found
        if exp_files.empty?
          say "No EXPRESS files found in directory: #{dir_path}"
          return
        end

        say "Found #{exp_files.size} EXPRESS files to benchmark"
        say "Cache: #{cache_path}"
        say "--------------------------------"

        # Process each file with caching
        exp_files.each_with_index do |file, index|
          say "Processing file #{index + 1}/#{exp_files.size}: #{file}"

          # Benchmark with caching
          Expressir::Benchmark.measure_with_cache(file, cache_path) do |path|
            Expressir::Express::Parser.from_file(path)
          end
        end
      end

      def benchmark_cache_file(path, cache_path)
        say "Express Schema Loading Benchmark with Caching"
        say "--------------------------------"
        say "Schema: #{path}"
        say "Cache: #{cache_path}"
        say "--------------------------------"

        # Benchmark with caching
        results = Expressir::Benchmark.measure_with_cache(path, cache_path) do |file|
          Expressir::Express::Parser.from_file(file)
        end

        if results[:repository]
          schema_count = results[:repository].schemas.size
          say "Loaded #{schema_count} schemas"
        else
          say "Failed to load schema"
        end
      end

      def benchmark_cache_from_yaml(yaml_path, cache_path)
        say "Express Schema Loading Benchmark with Caching from YAML"
        say "--------------------------------"

        # Use common method to extract schema files from YAML
        begin
          schema_list = YAML.load_file(yaml_path)
        rescue StandardError => e
          say "Error loading YAML file: #{e.message}"
          return
        end

        manifest_dir = File.dirname(yaml_path)
        schema_files = extract_schema_files(schema_list, manifest_dir)

        # Early return if no valid schemas
        if schema_files.empty?
          say "No valid schema files found in manifest"
          return
        end

        say "YAML File: #{yaml_path}"
        say "Number of schemas in list: #{schema_files.size}"
        say "Cache: #{cache_path}"
        say "--------------------------------"

        # Process each file with caching
        schema_files.each_with_index do |file, index|
          say "Processing file #{index + 1}/#{schema_files.size}: #{file}"

          # Benchmark with caching
          Expressir::Benchmark.measure_with_cache(file, cache_path) do |path|
            Expressir::Express::Parser.from_file(path)
          end

          say "--------------------------------"
        end
      end

      def generate_temp_cache_path
        require "tempfile"
        Tempfile.new(["expressir_cache", ".bin"]).path
      end
    end
  end
end
