module Expressir
  module Commands
    class Format < Base
      def run(paths)
        # Early validation check
        if paths.empty?
          exit_with_error "No paths specified. Please provide paths to EXPRESS files or directories."
        end

        # Use common processing methods from base class
        repositories = process_paths(paths)

        # Early check for no valid files
        if repositories.empty?
          exit_with_error "No valid EXPRESS files were processed. Nothing to format."
        end

        # Format all schemas from all repositories
        repositories.each do |repository|
          repository.schemas.each do |schema|
            say "\n(* Expressir formatted schema: #{schema.id} *)\n"
            say schema.to_s(no_remarks: true)
          end
        end
      end
    end
  end
end
