require "terminal-table"
require "json"
require "yaml"
require "ruby-progressbar"

module Expressir
  module Commands
    class Coverage < Base
      def run(paths)
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        reports = collect_reports(paths)

        if reports.empty?
          exit_with_error "No valid EXPRESS files were processed. Nothing to report."
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

      private

      def collect_reports(paths)
        reports = []

        paths.each do |path|
          handle_path(path, reports)
        end

        reports
      end

      def handle_path(path, reports)
        if File.directory?(path)
          handle_directory(path, reports)
        elsif File.extname(path).downcase == ".exp"
          handle_express_file(path, reports)
        elsif [".yml", ".yaml"].include?(File.extname(path).downcase)
          handle_yaml_manifest(path, reports)
        else
          say "Unsupported file type: #{path}"
        end
      end

      def handle_directory(path, reports)
        say "Processing directory: #{path}"
        exp_files = Dir.glob(File.join(path, "**", "*.exp"))
        if exp_files.empty?
          say "No EXPRESS files found in directory: #{path}"
          return
        end

        say "Found #{exp_files.size} EXPRESS files to process"

        # Initialize progress bar for directory files
        progress = ProgressBar.create(
          title: "Processing files",
          total: exp_files.size,
          format: "%t: [%B] %p%% %a [%c/%C] %e",
          output: $stdout,
        )

        # Parse all files and create a repository with progress tracking
        begin
          repository = Expressir::Express::Parser.from_files(exp_files) do |filename, _schemas, error|
            if error
              say "  Error processing #{File.basename(filename)}: #{error.message}"
            end
            progress.increment
          end
          skip_types = parse_skip_types
          report = Expressir::Coverage::Report.from_repository(repository, skip_types)
          reports << report
        rescue StandardError => e
          say "Error processing directory #{path}: #{e.message}"
        end
      end

      def handle_express_file(path, reports)
        say "Processing file: #{path}"
        begin
          # For a single file, we don't need a progress bar
          skip_types = parse_skip_types
          report = Expressir::Coverage::Report.from_file(path, skip_types)
          reports << report
        rescue StandardError => e
          say "Error processing file #{path}: #{e.message}"
        end
      end

      def handle_yaml_manifest(path, reports)
        say "Processing YAML manifest: #{path}"
        begin
          schema_list = YAML.load_file(path)
          manifest_dir = File.dirname(path)

          if schema_list.is_a?(Hash) && schema_list["schemas"]
            schemas_data = schema_list["schemas"]

            # Handle the nested structure with schema name keys and path values
            if schemas_data.is_a?(Hash)
              schema_files = schemas_data.values.map do |schema_data|
                if schema_data.is_a?(Hash) && schema_data["path"]
                  # Make path relative to the manifest location
                  File.expand_path(schema_data["path"], manifest_dir)
                end
              end.compact

              say "Found #{schema_files.size} schema files to process"
            else
              # If it's a direct array of paths (old format)
              schema_files = schemas_data
            end
          elsif schema_list.is_a?(Array)
            schema_files = schema_list
          else
            say "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
            return
          end

          # Initialize progress bar
          if schema_files && !schema_files.empty?
            say "Processing schemas from manifest file"

            progress = ProgressBar.create(
              title: "Processing schemas",
              total: schema_files.size,
              format: "%t: [%B] %p%% %a [%c/%C] %e",
              output: $stdout,
            )

            # Process files with progress tracking
            repository = Expressir::Express::Parser.from_files(schema_files) do |filename, _schemas, error|
              if error
                say "  Error processing #{File.basename(filename)}: #{error.message}"
              end
              progress.increment
            end

            # Create and add the report
            skip_types = parse_skip_types
            report = Expressir::Coverage::Report.from_repository(repository, skip_types)
            reports << report
          end
        rescue StandardError => e
          say "Error processing YAML manifest #{path}: #{e.message}"
          say "Debug: schema_list structure: #{schema_list.class}" if schema_list
        end
      end

      def display_text_output(reports)
        say "\nEXPRESS Documentation Coverage"
        say "=============================="

        # If multiple reports, display directory coverage first
        if reports.size > 1
          display_directory_coverage(reports)
        end

        display_file_coverage(reports)
        display_overall_stats(reports)
      end

      def display_directory_coverage(reports)
        say "\nDirectory Coverage:"

        # Collect directory data from all reports
        dirs = {}
        reports.each do |report|
          report.directory_reports.each do |dir_report|
            dir = dir_report["directory"]
            dirs[dir] ||= { "total" => 0, "documented" => 0 }
            dirs[dir]["total"] += dir_report["total"]
            dirs[dir]["documented"] += dir_report["documented"]
          end
        end

        # Create table
        table = Terminal::Table.new(
          title: "Directory Coverage",
          headings: ["Directory", "Total", "Documented", "Coverage %"],
          style: {
            border_x: "-",
            border_y: "|",
            border_i: "+",
          },
        )

        # Add rows
        dirs.each do |dir, stats|
          coverage = stats["total"].positive? ? (stats["documented"].to_f / stats["total"] * 100).round(2) : 100.0
          table.add_row [dir, stats["total"], stats["documented"], "#{coverage}%"]
        end

        say table
      end

      def display_file_coverage(reports)
        say "\nFile Coverage:"

        # Create table
        table = Terminal::Table.new(
          title: "File Coverage",
          headings: ["File", "Undocumented Entities", "Coverage %"],
          style: {
            border_x: "-",
            border_y: "|",
            border_i: "+",
          },
        )

        reports.each do |report|
          report.file_reports.each do |file_report|
            file_path = file_report["file"]

            # Format undocumented entities as "TYPE name, TYPE name, ..."
            undocumented_formatted = file_report["undocumented"].map do |entity_info|
              "#{entity_info['type']} #{entity_info['name']}"
            end.join(", ")

            coverage = file_report["coverage"].round(2)
            table.add_row [file_path, undocumented_formatted, "#{coverage}%"]
          end
        end

        say table
      end

      def display_overall_stats(reports)
        # Get structured report for overall statistics
        overall = build_structured_report(reports)["overall"]

        table = Terminal::Table.new(
          title: "Overall Documentation Coverage",
          style: {
            border_x: "-",
            border_y: "|",
            border_i: "+",
          },
        )

        table.add_row ["Coverage Percentage", "#{overall['coverage_percentage']}%"]
        table.add_row ["Total Entities", overall["total_entities"]]
        table.add_row ["Documented Entities", overall["documented_entities"]]
        table.add_row ["Undocumented Entities", overall["undocumented_entities"]]

        say table
      end

      def build_structured_report(reports)
        {
          "overall" => {
            "total_entities" => reports.sum { |r| r.total_entities.size },
            "documented_entities" => reports.sum { |r| r.documented_entities.size },
            "undocumented_entities" => reports.sum { |r| r.undocumented_entities.size },
            "coverage_percentage" => if reports.sum { |r| r.total_entities.size }.positive?
                                       (reports.sum { |r| r.documented_entities.size }.to_f / reports.sum { |r| r.total_entities.size } * 100).round(2)
                                     else
                                       100.0
                                     end,
          },
          "files" => reports.flat_map(&:file_reports),
          "directories" => reports.flat_map(&:directory_reports),
        }
      end

      def display_json_output(reports)
        say JSON.pretty_generate(build_structured_report(reports))
      end

      def display_yaml_output(reports)
        say build_structured_report(reports).to_yaml
      end

      # Parse and validate the skip_types option
      # @return [Array<String>] Array of validated entity type names
      def parse_skip_types
        skip_types_option = options["exclude"]
        return [] unless skip_types_option

        # Split by comma and clean up whitespace
        requested_types = skip_types_option.split(",").map(&:strip).map(&:upcase)

        # Validate against known entity types
        valid_types = Expressir::Coverage::ENTITY_TYPE_MAP.keys
        invalid_types = requested_types - valid_types

        unless invalid_types.empty?
          exit_with_error "Invalid entity types: #{invalid_types.join(', ')}. " \
                          "Valid types are: #{valid_types.join(', ')}"
        end

        requested_types
      end
    end
  end
end
