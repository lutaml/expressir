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
        ignored_files = parse_ignore_files

        paths.each do |path|
          handle_path(path, reports, ignored_files)
        end

        reports
      end

      def handle_path(path, reports, ignored_files)
        if File.directory?(path)
          handle_directory(path, reports, ignored_files)
        elsif File.extname(path).downcase == ".exp"
          handle_express_file(path, reports, ignored_files)
        elsif [".yml", ".yaml"].include?(File.extname(path).downcase)
          handle_yaml_manifest(path, reports, ignored_files)
        else
          say "Unsupported file type: #{path}"
        end
      end

      def handle_directory(path, reports, ignored_files)
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
          report = Expressir::Coverage::Report.from_repository(repository,
                                                               skip_types, ignored_files)
          reports << report
        rescue StandardError => e
          say "Error processing directory #{path}: #{e.message}"
        end
      end

      def handle_express_file(path, reports, ignored_files)
        say "Processing file: #{path}"
        begin
          # For a single file, we don't need a progress bar
          skip_types = parse_skip_types
          report = Expressir::Coverage::Report.from_file(path, skip_types,
                                                         ignored_files)
          reports << report
        rescue StandardError => e
          say "Error processing file #{path}: #{e.message}"
        end
      end

      def handle_yaml_manifest(path, reports, ignored_files)
        say "Processing YAML manifest: #{path}"
        begin
          schema_list = YAML.load_file(path)
          manifest_dir = File.dirname(path)

          if schema_list.is_a?(Hash) && schema_list["schemas"]
            schemas_data = schema_list["schemas"]

            # Handle the nested structure with schema name keys and path values
            if schemas_data.is_a?(Hash)
              schema_files = schemas_data.values.filter_map do |schema_data|
                if schema_data.is_a?(Hash) && schema_data["path"]
                  # Make path relative to the manifest location
                  File.expand_path(schema_data["path"], manifest_dir)
                end
              end

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
            report = Expressir::Coverage::Report.from_repository(repository,
                                                                 skip_types, ignored_files)
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
          table.add_row [dir, stats["total"], stats["documented"],
                         "#{coverage}%"]
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

        table.add_row ["Coverage Percentage",
                       "#{overall['coverage_percentage']}%"]
        table.add_row ["Total Entities", overall["total_entities"]]
        table.add_row ["Documented Entities", overall["documented_entities"]]
        table.add_row ["Undocumented Entities",
                       overall["undocumented_entities"]]

        say table
      end

      def build_structured_report(reports)
        # Calculate ignored file statistics
        ignored_files = reports.flat_map(&:ignored_file_reports)
        ignored_entities_count = ignored_files.sum { |f| f["total"] }

        overall_stats = {
          "total_entities" => reports.sum { |r| r.total_entities.size },
          "documented_entities" => reports.sum do |r|
            r.documented_entities.size
          end,
          "undocumented_entities" => reports.sum do |r|
            r.undocumented_entities.size
          end,
          "coverage_percentage" => if reports.sum do |r|
            r.total_entities.size
          end.positive?
                                     (reports.sum do |r|
                                       r.documented_entities.size
                                     end.to_f / reports.sum do |r|
                                                  r.total_entities.size
                                                end * 100).round(2)
                                   else
                                     100.0
                                   end,
        }

        # Add ignored file information if there are any
        if ignored_files.any?
          overall_stats["ignored_files_count"] = ignored_files.size
          overall_stats["ignored_entities_count"] = ignored_entities_count
        end

        structured_report = {
          "overall" => overall_stats,
          "files" => reports.flat_map(&:file_reports),
          "directories" => reports.flat_map(&:directory_reports),
        }

        # Add ignored files section if there are any
        if ignored_files.any?
          structured_report["ignored_files"] = ignored_files
        end

        structured_report
      end

      def display_json_output(reports)
        output_file = options[:output] || "coverage_report.json"
        File.write(output_file,
                   JSON.pretty_generate(build_structured_report(reports)))
        say "JSON coverage report written to: #{output_file}"
      end

      def display_yaml_output(reports)
        output_file = options[:output] || "coverage_report.yaml"
        File.write(output_file, build_structured_report(reports).to_yaml)
        say "YAML coverage report written to: #{output_file}"
      end

      # Parse and validate the skip_types option
      # @return [Array<String>] Array of validated entity type names
      def parse_skip_types
        skip_types_option = options["exclude"] || options[:exclude]
        return [] unless skip_types_option

        # Handle both string (comma-separated) and array inputs
        requested_types = if skip_types_option.is_a?(Array)
                            skip_types_option.map(&:to_s).map(&:strip).map(&:upcase)
                          else
                            skip_types_option.split(",").map(&:strip).map(&:upcase)
                          end

        # Validate each type (supports both TYPE and TYPE:SUBTYPE formats)
        requested_types.each do |type|
          validate_skip_type(type)
        end

        requested_types
      end

      # Validate a single skip type (supports TYPE:SUBTYPE and FUNCTION:SUBTYPE syntax)
      # @param type [String] The type to validate
      def validate_skip_type(type)
        if type.include?(":")
          # Handle TYPE:SUBTYPE and FUNCTION:SUBTYPE format
          main_type, subtype = type.split(":", 2)

          # Validate main type
          unless Expressir::Coverage::ENTITY_TYPE_MAP.key?(main_type)
            exit_with_error "Invalid entity type: #{main_type}. " \
                            "Valid types are: #{Expressir::Coverage::ENTITY_TYPE_MAP.keys.join(', ')}"
          end

          # For TYPE, validate subtype
          if main_type == "TYPE"
            unless Expressir::Coverage::TYPE_SUBTYPES.include?(subtype)
              exit_with_error "Invalid TYPE subtype: #{subtype}. " \
                              "Valid TYPE subtypes are: #{Expressir::Coverage::TYPE_SUBTYPES.join(', ')}"
            end
          # For FUNCTION, validate subtype
          elsif main_type == "FUNCTION"
            unless subtype == "INNER"
              exit_with_error "Invalid FUNCTION subtype: #{subtype}. " \
                              "Valid FUNCTION subtypes are: INNER"
            end
          else
            exit_with_error "Subtype syntax (#{type}) is only supported for TYPE and FUNCTION entities"
          end
        else
          # Handle simple type format
          unless Expressir::Coverage::ENTITY_TYPE_MAP.key?(type)
            exit_with_error "Invalid entity type: #{type}. " \
                            "Valid types are: #{Expressir::Coverage::ENTITY_TYPE_MAP.keys.join(', ')}"
          end
        end
      end

      # Parse and expand ignore files from YAML
      # @return [Hash] Hash mapping absolute file paths to their matched patterns
      def parse_ignore_files
        ignore_files_option = options["ignore_files"] || options[:ignore_files]
        return {} unless ignore_files_option

        unless File.exist?(ignore_files_option)
          say "Warning: Ignore files YAML not found: #{ignore_files_option}"
          return {}
        end

        begin
          patterns = YAML.load_file(ignore_files_option)
          unless patterns.is_a?(Array)
            say "Warning: Invalid ignore files YAML format. Expected an array of file patterns."
            return {}
          end

          ignore_files_dir = File.dirname(File.expand_path(ignore_files_option))
          expanded_files = {}

          patterns.each do |pattern|
            # Resolve pattern relative to the YAML file's directory
            full_pattern = File.expand_path(pattern, ignore_files_dir)

            # Expand glob pattern
            matched_files = Dir.glob(full_pattern)

            if matched_files.empty?
              say "Warning: No files matched pattern: #{pattern}"
            else
              matched_files.each do |file_path|
                # Store absolute path and the original pattern that matched it
                expanded_files[File.expand_path(file_path)] = pattern
              end
            end
          end

          if expanded_files.any?
            say "Found #{expanded_files.size} files to ignore from patterns"
          end

          expanded_files
        rescue StandardError => e
          say "Warning: Error processing ignore files YAML #{ignore_files_option}: #{e.message}"
          {}
        end
      end
    end
  end
end
