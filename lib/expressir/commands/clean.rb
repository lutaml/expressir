module Expressir
  module Commands
    class Clean < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Use common processing methods from base class
        repositories = process_paths(paths)

        # Early check for no valid files
        if repositories.empty?
          exit_with_error "No valid EXPRESS files were processed. Nothing to clean."
        end

        # Collect all formatted schemas from all repositories
        formatted_schemas = repositories.flat_map do |repository|
          repository.schemas.map do |schema|
            # Format schema without remarks
            schema.to_s(no_remarks: true)
          end
        end.join("\n\n")

        # Output to file or display
        if options[:output]
          File.write(options[:output], formatted_schemas)
          say "Cleaned schemas written to #{options[:output]}"
        else
          say formatted_schemas
        end
      end
    end
  end
end
