require "yaml"
require "ruby-progressbar"
require "pathname"

module Expressir
  module Commands
    class Base
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      # Common utilities that all commands might need
      def say(message)
        # Use instance variable for testability - if output is set, use it
        if defined?(@output) && @output
          @output.puts(message)
        else
          puts(message)
        end
      end

      def exit_with_error(message, exit_code = 1)
        say message
        # In test mode, raise an exception instead of exiting
        # This makes it easier to test error cases
        if defined?(@test_mode) && @test_mode
          raise message # Just raise the message as an exception
        else
          exit exit_code
        end
      end

      # Common file processing methods
      protected

      # Process a collection of paths, returning repositories
      def process_paths(paths, options = {})
        repositories = []

        paths.each do |path|
          result = process_path(path, options)
          repositories.concat([result].flatten.compact)
        end

        repositories
      end

      # Process a single path based on its type
      def process_path(path, options = {})
        # Check unsupported file type first (early return)
        ext = File.extname(path).downcase
        unless File.directory?(path) || ext == ".exp" || [".yml", ".yaml"].include?(ext)
          say "Unsupported file type: #{path}"
          return nil
        end

        # Branch into appropriate processor with minimal nesting
        return process_directory(path, options) if File.directory?(path)
        return process_yaml_manifest(path, options) if [".yml", ".yaml"].include?(ext)

        process_express_file(path, options) # Default case - .exp files
      end

      # Process a single EXPRESS file
      def process_express_file(path, options = {})
        say "Processing file: #{path}"

        begin
          Expressir::Express::Parser.from_file(path)
        rescue StandardError => e
          say "Error processing file #{path}: #{e.message}"
          nil
        end
      end

      # Process a directory of EXPRESS files
      def process_directory(path, options = {})
        say "Processing directory: #{path}"
        exp_files = Dir.glob(File.join(path, "**", "*.exp"))

        # Early return if no files found
        if exp_files.empty?
          say "No EXPRESS files found in directory: #{path}"
          return nil
        end

        say "Found #{exp_files.size} EXPRESS files to process"
        process_multiple_files(exp_files, "Processing files", options)
      end

      # Process a YAML manifest file
      def process_yaml_manifest(path, options = {})
        say "Processing YAML manifest: #{path}"

        # Early error handling
        begin
          schema_list = YAML.load_file(path)
        rescue StandardError => e
          say "Error processing YAML manifest #{path}: #{e.message}"
          return nil
        end

        manifest_dir = File.dirname(path)
        schema_files = extract_schema_files(schema_list, manifest_dir)

        # Early return for no valid schemas
        if schema_files.empty?
          say "No valid schema files found in manifest"
          return nil
        end

        # Process files (happy path at the end with minimal nesting)
        say "Found #{schema_files.size} schema files to process"
        process_multiple_files(schema_files, "Processing schemas", options)
      end

      # Extract schema files from YAML manifest with early returns
      def extract_schema_files(schema_list, manifest_dir)
        # Early returns for invalid formats
        return [] unless schema_list.is_a?(Hash) || schema_list.is_a?(Array)
        return schema_list if schema_list.is_a?(Array)
        return [] unless schema_list["schemas"]

        schemas_data = schema_list["schemas"]

        # Handle different formats with shallow branching
        return schemas_data unless schemas_data.is_a?(Hash)

        # Process nested structure
        schemas_data.values.map do |schema_data|
          next unless schema_data.is_a?(Hash) && schema_data["path"]

          File.expand_path(schema_data["path"], manifest_dir)
        end.compact
      end

      # Process multiple files with progress bar
      def process_multiple_files(files, title, options = {})
        progress = create_progress_bar(title, files.size)

        # Use Parser.from_files with a progress callback
        Expressir::Express::Parser.from_files(files) do |filename, _schemas, error|
          if error
            say "  Error processing #{File.basename(filename)}: #{error.message}"
          end
          progress.increment
        end
      end

      # Create a standardized progress bar
      def create_progress_bar(title, total)
        ProgressBar.create(
          title: title,
          total: total,
          format: "%t: [%B] %p%% %a [%c/%C] %e",
          output: $stdout,
        )
      end
    end
  end
end
