require "find"

module Expressir
  module Commands
    # Common parser/discovery helpers shared by parity CLI commands
    # (expand, flatten, check) — they all need: list of files in the
    # interface closure of a root file, and the root schema parsed.
    module ParityInputs
      module_function

      # Resolve the transitive interface closure of +root_path+. Deps are
      # looked up by schema name: first in the file's own directory, then
      # across the enclosing STEPmod checkout (the nearest ancestor holding
      # a `schemas/` directory, e.g. resources/ and modules/ trees).
      def closure_paths(root_path)
        index = schema_index(root_path)
        seen = { File.basename(root_path, ".exp").downcase => root_path }
        queue = [File.basename(root_path, ".exp").downcase]
        until queue.empty?
          name = queue.shift
          path = seen[name] || index[name]
          next unless path
          next if seen.key?(name) && seen[name] != root_path

          seen[name] = path
          closure_names(File.read(path)).each { |d| queue << d.downcase }
        end
        seen.values.uniq
      end

      # Schema-name → path map for the STEPmod checkout around +root_path+,
      # built once per invocation. The index root is the nearest ancestor
      # directory NAMED `schemas` (wg12-step layout:
      # `schemas/modules/<module>/mim.exp`), and entries key on the schema
      # name declared inside each file — module files are `arm.exp` /
      # `mim.exp`, so basenames cannot be the key. Falls back to the file's
      # own directory when there is no schemas/ ancestor.
      def schema_index(root_path)
        dir = File.dirname(File.expand_path(root_path))
        nil
        until dir == "/" || File.basename(dir) == "schemas"
          parent = File.dirname(dir)
          break if parent == dir

          dir = parent
        end
        return same_dir_index(root_path) unless File.basename(dir) == "schemas"

        @@indexes ||= {}
        @@indexes[dir] ||= begin
          h = {}
          Find.find(dir) do |path|
            next unless path.end_with?(".exp")

            declared = File.read(path)[/\bSCHEMA\s+(\w+)/i, 1]
            h[declared.downcase] = path if declared
            h[File.basename(path, ".exp").downcase] ||= path
          end
          h
        end
      end

      def same_dir_index(root_path)
        dir = File.dirname(File.expand_path(root_path))
        Dir.glob(File.join(dir, "*.exp")).to_h do |p|
          [File.basename(p, ".exp").downcase, p]
        end
      end

      def closure_names(source)
        source.scan(/\bUSE\s+FROM\s+(\w+)/i).flatten.uniq +
          source.scan(/\bREFERENCE\s+FROM\s+(\w+)/i).flatten.uniq
      end

      def root_schema(root_path)
        name = File.read(root_path)[/\bSCHEMA\s+(\w+)/, 1]
        repo = Expressir::Express::Parser.from_files(closure_paths(root_path),
                                                     max_processes: 1)
        [repo.schemas.find { |s| s.id == name }, repo]
      end
    end
  end
end
