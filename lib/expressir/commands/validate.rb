module Expressir
  module Commands
    class Validate < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Process all validation results
        validation_results = process_schemas(paths)

        # Early check for no valid files
        if validation_results.empty?
          exit_with_error "No valid EXPRESS files were processed. Nothing to validate."
        end

        # Print validation results
        print_validation_results(validation_results)

        # Check if we have any actual validation issues based on the format
        has_errors = if validation_results.empty?
                       false # No results means no errors
                     elsif validation_results.first.is_a?(Hash)
                       validation_results.any? # If these are actual validation results from the new format, any results indicate errors
                     else
                       # For backwards compatibility with tests that use string format
                       validation_results.any? do |result|
                         result.include?("Failed to parse") || result.include?("Missing version string")
                       end
                     end

        # Early return for errors
        if has_errors
          exit 1
        end

        # Success path at the end
        say "Validation passed for all EXPRESS schemas."
      end

      private

      # Process schemas from various sources (files, directories, manifests)
      def process_schemas(paths)
        # Use process_paths from base to handle file loading with progress bar
        repositories = process_paths(paths)

        # Collect all validation issues
        validation_results = []

        # Check for missing version strings
        validation_results.concat(collect_missing_versions(repositories))

        # Check for files that failed to parse
        validation_results.concat(detect_failed_files(paths, repositories))

        # Return all validation results
        validation_results
      end

      # Collect schemas missing version strings
      def collect_missing_versions(repositories)
        missing = []

        repositories.each do |repository|
          repository.schemas.each do |schema|
            unless schema.version&.value
              # Handle file path conversion more carefully
              file_path = if schema.file
                            # Try to make path relative, but fall back to absolute path if not possible
                            file = Pathname.new(schema.file)
                            begin
                              file.relative_path_from(Pathname.new(Dir.pwd))
                            rescue ArgumentError
                              # If we can't create a relative path, just use the file path as is
                              file
                            end
                          else
                            "unknown"
                          end

              missing << {
                file: schema.file,
                result: :missing_version,
                message: "Missing version string: schema `#{schema.id}` | #{file_path}",
              }
            end
          end
        end

        missing
      end

      # Detect files that failed to parse
      def detect_failed_files(paths, repositories)
        # Only check individual .exp files, not directories or YAML manifests
        failed = []

        paths.each do |path|
          # Skip directories and YAML files
          next if File.directory?(path)
          next if [".yml", ".yaml"].include?(File.extname(path).downcase)

          # Only check .exp files
          # Check if this file is in any repository
          if File.extname(path).downcase == ".exp" && !repositories.any? { |repo| repo.schemas.any? { |s| s.file == path } }
            # Handle file path conversion more carefully
            file_path = begin
              Pathname.new(path).realpath.relative_path_from(Pathname.new(Dir.pwd))
            rescue ArgumentError
              path
            end

            failed << {
              file: path,
              result: :parse_failed,
              message: "Failed to parse: #{file_path}",
            }
          end
        end

        failed
      end

      def print_validation_results(results)
        # Exit early if no results
        return if results.empty?

        # Group results by type if we have structure with hash results
        if results.first.is_a?(Hash) && results.first.key?(:result)
          # Group results by type
          grouped_results = results.group_by { |r| r[:result] }

          # Print parse failures first
          print_validation_group(:parse_failed, "FAILED TO PARSE", grouped_results[:parse_failed] || [])

          # Then print missing versions
          print_validation_group(:missing_version, "MISSING VERSION STRING", grouped_results[:missing_version] || [])
        else
          # For backward compatibility with tests
          print_validation_errors(:failed_to_parse, results.select { |r| r.include?("Failed to parse") })
          print_validation_errors(:missing_version_string, results.select { |r| r.include?("Missing version string") })
        end
      end

      def print_validation_group(type, header, results)
        return if results.empty?

        say "#{'*' * 20} RESULTS: #{header} #{'*' * 20}"
        results.each do |result|
          say result[:message]
        end
      end

      # Legacy method kept for compatibility with tests
      def print_validation_errors(type, array)
        return if array.empty?

        say "#{'*' * 20} RESULTS: #{type.to_s.upcase.tr('_', ' ')} #{'*' * 20}"
        array.each do |msg|
          say msg
        end
      end
    end
  end
end
