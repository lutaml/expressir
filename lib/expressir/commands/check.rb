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
        repository = Expressir::Express::Parser.from_files(files)
        result = Expressir::Express::Checker.new(repository).check

        result.notes.each { |n| say "[#{n.severity}] #{n.id}: #{n.message}" }
        say "#{result.errors.size} error(s), #{result.warnings.size} warning(s)"

        return if result.valid?

        raise Thor::Error, "schema check produced #{result.errors.size} error(s)"
      end
    end
  end
end
