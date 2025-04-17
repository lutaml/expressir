require "terminal-table"
require "json"

module Expressir
  module Commands
    class Coverage < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Use common processing methods from base class
        repositories = process_paths(paths)

        # Early check for no valid files
        if repositories.empty?
          exit_with_error "No valid EXPRESS files were processed. Nothing to report."
        end

        # Generate reports from repositories
        reports = repositories.map do |repo|
          Expressir::Coverage::Report.from_repository(repo)
        end

        # Generate output based on format
        case options[:format]&.downcase
        when "json"
          display_json_output(reports)
        when "yaml"
          display_yaml_output(reports)
        else # Default to text
          display_text_output(reports)
        end
      end

      private

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
    end
  end
end
