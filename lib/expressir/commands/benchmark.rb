module Expressir
  module Commands
    class Benchmark < Base
      def run(path)
        configure_benchmarking

        if [".yml", ".yaml"].include?(File.extname(path).downcase)
          benchmark_from_yaml(path)
        else
          benchmark_file(path)
        end
      end

      private

      def configure_benchmarking
        Expressir.configuration.benchmark_enabled = true
        Expressir.configuration.benchmark_ips = options[:ips]
        Expressir.configuration.benchmark_verbose = options[:verbose]
        Expressir.configuration.benchmark_save = options[:save]
        Expressir.configuration.benchmark_format = options[:format] if options[:format]
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

        # Load schema list from YAML
        schema_list = YAML.load_file(yaml_path)
        if schema_list.is_a?(Hash) && schema_list["schemas"]
          # Handle format: { "schemas": ["path1", "path2", ...] }
          schema_files = schema_list["schemas"]
        elsif schema_list.is_a?(Array)
          # Handle format: ["path1", "path2", ...]
          schema_files = schema_list
        else
          say "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
          return
        end

        say "YAML File: #{yaml_path}"
        say "Number of schemas in list: #{schema_files.size}"
        say "--------------------------------"

        # Load the schemas
        Expressir::Benchmark.measure_collection(schema_files) do |file|
          repository = Expressir::Express::Parser.from_file(file)
          repository.schemas
        end
      end
    end
  end
end
