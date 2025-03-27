require "terminal-table"
require "json"
require "yaml"

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

        # Parse all files and create a repository
        repository = nil
        begin
          repository = Expressir::Express::Parser.from_files(exp_files)
          report = Expressir::Coverage::Report.from_repository(repository)
          reports << report
        rescue StandardError => e
          say "Error processing directory #{path}: #{e.message}"
        end
      end

      def handle_express_file(path, reports)
        say "Processing file: #{path}"
        begin
          report = Expressir::Coverage::Report.from_file(path)
          reports << report
        rescue StandardError => e
          say "Error processing file #{path}: #{e.message}"
        end
      end

      def handle_yaml_manifest(path, reports)
        say "Processing YAML manifest: #{path}"
        begin
          schema_list = YAML.load_file(path)
          if schema_list.is_a?(Hash) && schema_list["schemas"]
            schema_files = schema_list["schemas"]
          elsif schema_list.is_a?(Array)
            schema_files = schema_list
          else
            say "Invalid YAML format. Expected an array of schema paths or a hash with a 'schemas' key."
            return
          end

          repository = Expressir::Express::Parser.from_files(schema_files)
          report = Expressir::Coverage::Report.from_repository(repository)
          reports << report
        rescue StandardError => e
          say "Error processing YAML manifest #{path}: #{e.message}"
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
          coverage = stats["total"] > 0 ? (stats["documented"].to_f / stats["total"] * 100).round(2) : 100.0
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
            # Truncate file path if it's too long
            if file_path.length > 38
              file_path = "..." + file_path[-35..-1]
            end

            # Format undocumented entities as "TYPE name, TYPE name, ..."
            undocumented_formatted = file_report["undocumented"].map do |entity_info|
              "#{entity_info['type']} #{entity_info['name']}"
            end.join(", ")

            # Truncate undocumented list if it's too long
            if undocumented_formatted.length > 38
              undocumented_formatted = undocumented_formatted[0..35] + "..."
            end

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
            "coverage_percentage" => if reports.sum { |r| r.total_entities.size } > 0
                                       (reports.sum { |r| r.documented_entities.size }.to_f / reports.sum { |r| r.total_entities.size } * 100).round(2)
                                     else
                                       100.0
                                     end,
          },
          "files" => reports.flat_map { |r| r.file_reports },
          "directories" => reports.flat_map { |r| r.directory_reports },
        }
      end

      def display_json_output(reports)
        say JSON.pretty_generate(build_structured_report(reports))
      end

      def display_yaml_output(reports)
        say build_structured_report(reports).to_yaml
      end
    end
  end
end
