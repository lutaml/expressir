require "thor"
require "yaml"
require "terminal-table"

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
          Expressir::Benchmark.measure_with_cache(file, cache_path) do |path|
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

    desc "coverage *PATH", "List EXPRESS entities and check documentation coverage"
    method_option :format, type: :string, desc: "Output format (text, json, yaml)", default: "text"
    def coverage(*paths)
      if paths.empty?
        puts "No paths specified. Please provide paths to EXPRESS files or directories."
        exit 1
      end

      reports = []

      paths.each do |path|
        if File.directory?(path)
          # Handle directory (find .exp files and process)
          puts "Processing directory: #{path}"
          exp_files = Dir.glob(File.join(path, "**", "*.exp"))
          if exp_files.empty?
            puts "No EXPRESS files found in directory: #{path}"
            next
          end

          # Parse all files and create a repository
          repository = nil
          begin
            repository = Expressir::Express::Parser.from_files(exp_files)
            report = Expressir::Coverage::Report.from_repository(repository)
            reports << report
          rescue StandardError => e
            puts "Error processing directory #{path}: #{e.message}"
          end
        elsif File.extname(path).downcase == ".exp"
          # Handle single EXPRESS file
          puts "Processing file: #{path}"
          begin
            report = Expressir::Coverage::Report.from_file(path)
            reports << report
          rescue StandardError => e
            puts "Error processing file #{path}: #{e.message}"
          end
        elsif [".yml", ".yaml"].include?(File.extname(path).downcase)
          # Handle YAML manifest
          puts "Processing YAML manifest: #{path}"
          begin
            schema_list = YAML.load_file(path)
            if schema_list.is_a?(Hash) && schema_list["schemas"]
              schema_files = schema_list["schemas"]
            elsif schema_list.is_a?(Array)
              schema_files = schema_list
            else
              puts "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
              next
            end

            repository = Expressir::Express::Parser.from_files(schema_files)
            report = Expressir::Coverage::Report.from_repository(repository)
            reports << report
          rescue StandardError => e
            puts "Error processing YAML manifest #{path}: #{e.message}"
          end
        else
          puts "Unsupported file type: #{path}"
        end
      end

      if reports.empty?
        puts "No valid EXPRESS files were processed. Nothing to report."
        exit 1
      end

      # Generate output based on format
      case options[:format].downcase
      when "json"
        display_json_output(reports)
      when "yaml"
        display_yaml_output(reports)
      else # Default to text
        display_text_output(reports)
      end
    end

    no_commands do
      def display_text_output(reports)
        puts "\nEXPRESS Documentation Coverage"
        puts "=============================="

        # If multiple reports, display directory coverage first
        if reports.size > 1
          puts "\nDirectory Coverage:"
          puts "-----------------"

          # Collect directory data from all reports
          dirs = {}
          reports.each do |report|
            report.directory_reports.each do |dir_report|
              dir = dir_report[:directory]
              dirs[dir] ||= { total: 0, documented: 0 }
              dirs[dir][:total] += dir_report[:total]
              dirs[dir][:documented] += dir_report[:documented]
            end
          end

          # Create a simple table format
          puts "| #{'Directory'.ljust(30)} | #{'Total'.ljust(10)} | #{'Documented'.ljust(10)} | #{'Coverage %'.ljust(10)} |"
          puts "|#{'-' * 32}|#{'-' * 12}|#{'-' * 12}|#{'-' * 12}|"

          # Add rows for each directory
          dirs.each do |dir, stats|
            coverage = stats[:total] > 0 ? (stats[:documented].to_f / stats[:total] * 100).round(2) : 100.0
            puts "| #{dir.ljust(30)} | #{stats[:total].to_s.ljust(10)} | #{stats[:documented].to_s.ljust(10)} | #{coverage.to_s.ljust(10)} |"
          end
        end

        # Display file coverage
        puts "\nFile Coverage:"
        puts "-------------"

        # Create a simple table format
        puts "| #{'File'.ljust(40)} | #{'Undocumented Entities'.ljust(40)} | #{'Coverage %'.ljust(10)} |"
        puts "|#{'-' * 42}|#{'-' * 42}|#{'-' * 12}|"

        reports.each do |report|
          report.file_reports.each do |file_report|
            file_path = file_report[:file]
            # Truncate file path if it's too long
            if file_path.length > 38
              file_path = "..." + file_path[-35..-1]
            end
            undocumented = file_report[:undocumented].join(", ")
            # Truncate undocumented list if it's too long
            if undocumented.length > 38
              undocumented = undocumented[0..35] + "..."
            end
            coverage = file_report[:coverage].round(2)

            puts "| #{file_path.ljust(40)} | #{undocumented.ljust(40)} | #{coverage.to_s.ljust(10)} |"
          end
        end

        # Get structured report for overall statistics
        overall = build_structured_report(reports)[:overall]

        puts "\nOverall Documentation Coverage: #{overall[:coverage_percentage]}%"
        puts "Total Entities: #{overall[:total_entities]}"
        puts "Documented Entities: #{overall[:documented_entities]}"
        puts "Undocumented Entities: #{overall[:undocumented_entities]}"
      end

      # Create a structured data report from coverage reports
      # @param reports [Array<Expressir::Coverage::Report>] The coverage reports
      # @return [Hash] A structured hash with coverage data
      def build_structured_report(reports)
        {
          overall: {
            total_entities: reports.sum { |r| r.total_entities.size },
            documented_entities: reports.sum { |r| r.documented_entities.size },
            undocumented_entities: reports.sum { |r| r.undocumented_entities.size },
            coverage_percentage: if reports.sum { |r| r.total_entities.size } > 0
                                   (reports.sum { |r| r.documented_entities.size }.to_f / reports.sum { |r| r.total_entities.size } * 100).round(2)
                                 else
                                   100.0
                                 end,
          },
          files: reports.flat_map { |r| r.file_reports },
          directories: reports.flat_map { |r| r.directory_reports },
        }
      end

      def display_json_output(reports)
        require "json"
        puts JSON.pretty_generate(build_structured_report(reports))
      end

      def display_yaml_output(reports)
        require "yaml"
        puts build_structured_report(reports).to_yaml
      end
    end

    desc "version", "Expressir Version"
    def version
      say(Expressir::VERSION)
    end
  end
end
