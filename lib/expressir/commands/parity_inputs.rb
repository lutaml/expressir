module Expressir
  module Commands
    # Common parser/discovery helpers shared by parity CLI commands
    # (expand, flatten, check) — they all need: list of files in the
    # interface closure of a root file, and the root schema parsed.
    module ParityInputs
      module_function

      # Resolve the interface closure of +root_path+ (USE FROM / REFERENCE
      # FROM names found in the source file, by schema name, in the same
      # directory). Each named schema is loaded from
      # `dir/<name>.exp`; missing paths are surfaced.
      def closure_paths(root_path)
        dir = File.dirname(root_path)
        names = closure_names(File.read(root_path))
        paths = names.map { |n| File.join(dir, "#{n}.exp") }
        paths << root_path
        paths.uniq
      end

      def closure_names(source)
        source.scan(/\bUSE\s+FROM\s+(\w+)/i).flatten.uniq +
          source.scan(/\bREFERENCE\s+FROM\s+(\w+)/i).flatten.uniq
      end

      def root_schema(root_path)
        name = File.read(root_path)[/\bSCHEMA\s+(\w+)/, 1]
        repo = Expressir::Express::Parser.from_files(closure_paths(root_path))
        [repo.schemas.find { |s| s.id == name }, repo]
      end
    end
  end
end
