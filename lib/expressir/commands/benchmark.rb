module Expressir
  module Commands
    class Benchmark < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Configure benchmarking options
        configure_benchmarking

        # Process each path
        paths.each do |path|
          process_benchmark_path(path)
        end
      end

      private

      def process_benchmark_path(path)
        # Determine the path type and benchmark appropriately
        if File.directory?(path)
          benchmark_directory(path)
        elsif [".yml", ".yaml"].include?(File.extname(path).downcase)
          benchmark_from_yaml(path)
        else
          benchmark_file(path)
        end
      end

      def configure_benchmarking
        Expressir.configuration.benchmark_enabled = true
        Expressir.configuration.benchmark_ips = options[:ips]
        Expressir.configuration.benchmark_verbose = options[:verbose]
        Expressir.configuration.benchmark_save = options[:save]
        Expressir.configuration.benchmark_format = options[:format] if options[:format]
      end

      def benchmark_directory(dir_path)
        say "Express Schema Directory Loading Benchmark"
        say "--------------------------------"

        # Use common method to find all .exp files
        exp_files = Dir.glob(File.join(dir_path, "**", "*.exp"))

        # Early return if no files found
        if exp_files.empty?
          say "No EXPRESS files found in directory: #{dir_path}"
          return
        end

        say "Found #{exp_files.size} EXPRESS files to benchmark"
        say "--------------------------------"

        # Benchmark the whole directory
        Expressir::Benchmark.measure_collection(exp_files) do |file|
          repository = Expressir::Express::Parser.from_file(file)
          repository.schemas
        end
      end

      def benchmark_file(path)
        say "Express Schema Loading Benchmark"
        say "--------------------------------"

        repository = Expressir::Benchmark.measure_file(path) do
          Expressir::Express::Parser.from_file(path)
        end

        if repository
          say "Loaded #{repository.schemas.size} schemas"
        else
          say "Failed to load schema"
        end
      end

      def benchmark_from_yaml(yaml_path)
        say "Express Schema Loading Benchmark from YAML"
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
        say "--------------------------------"

        # Benchmark the collection
        Expressir::Benchmark.measure_collection(schema_files) do |file|
          repository = Expressir::Express::Parser.from_file(file)
          repository.schemas
        end
      end
    end
  end
end
