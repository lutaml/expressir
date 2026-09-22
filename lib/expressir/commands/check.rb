require "json"

module Expressir
  module Commands
    # `validate check` — semantic checks modeled on eeng check-p11 note
    # subset (expressir#282). Exits 1 when any :error notes are emitted.
    # Loads the interface closure of each input file so USE FROM targets
    # are visible — matches Concatenator/Shtolo expectations.
    class Check < Base
      def run(*paths)
        files = Array(paths).flat_map do |p|
          if File.directory?(p)
            Dir["#{p}/**/*.exp"]
          else
            ParityInputs.closure_paths(p).select { |f| File.exist?(f) }
          end
        end.uniq
        # Unparseable files come back as nil entries in repository.files
        # and are invisible to the Checker — surface them explicitly so a
        # parse failure is never reported as a clean bill of health (#413).
        parse_failures = {}
        repository = Expressir::Express::Parser.from_files(files) do |file, _exp_file, error|
          parse_failures[file] = error if error
        end
        result = Expressir::Express::Checker.new(repository).check

        failures = parse_failures.map do |file, error|
          [file, error || "could not be parsed"]
        end

        if options[:json]
          say JSON.generate(
            valid: result.valid? && failures.empty?,
            errors: serialize(result.errors) + failures.map do |file, error|
              { "id" => "parse_failure", "severity" => "error",
                "schema" => file, "message" => error.to_s }
            end,
            warnings: serialize(result.warnings),
          )
        else
          failures.each do |file, error|
            say "[error] parse_failure: #{file}: #{error}"
          end
          result.notes.each { |n| say "[#{n.severity}] #{n.id}: #{n.message}" }
          say "#{result.errors.size + failures.size} error(s), " \
              "#{result.warnings.size} warning(s)"
        end

        return if result.valid? && failures.empty?

        raise Thor::Error,
              "schema check produced #{result.errors.size + failures.size} error(s)"
      end

      private

      def serialize(notes)
        notes.map do |n|
          { id: n.id.to_s, severity: n.severity.to_s, schema: n.schema,
            message: n.message }
        end
      end
    end
  end
end
