require "find"

module Expressir
  module Commands
    # Common parser/discovery helpers shared by parity CLI commands
    # (expand, flatten, check) — they all need: list of files in the
    # interface closure of a root file, and the root schema parsed.
    #
    # Schema resolution order (per the ELF schema manifest directive):
    #   1. `--manifest PATH` — an ELF schema manifest explicitly defines
    #      where each schema lives; this is the primary mode.
    #   2. `--stepmod DIR` — explicit opt-in to the STEPmod directory
    #      convention (`schemas/**/<name>.exp`) as the fallback.
    #   3. Otherwise the file's own directory is used; a lookup failure
    #      warns and points at the two explicit modes.
    module ParityInputs
      module_function

      # Resolve the transitive interface closure of +root_path+. The queue
      # holds paths and `seen` guards by schema name: mutual USE FROM
      # cycles must terminate (this loop once span rounds forever on them,
      # re-reading the same files).
      def closure_paths(root_path, manifest: nil, stepmod: nil)
        index = schema_index(root_path, manifest: manifest, stepmod: stepmod)
        seen = { File.basename(root_path, ".exp").downcase => root_path }
        missing = []
        queue = [root_path]
        until queue.empty?
          closure_names(File.read(queue.shift)).each do |dep|
            name = dep.downcase
            next if seen.key?(name)

            path = index&.[](name)
            unless path
              missing << name
              seen[name] = nil
              next
            end

            seen[name] = path
            queue << path
          end
        end
        unless missing.empty?
          warn "expressir: schema(s) not found: #{missing.uniq.join(', ')}" \
               "#{resolver_hint(manifest, stepmod)}"
        end
        seen.values.compact.uniq
      end

      def resolver_hint(manifest, stepmod)
        if manifest
          " (not in schema manifest #{manifest})"
        elsif stepmod
          " (not found under STEPmod root #{stepmod})"
        else
          " - provide --manifest PATH (ELF schema manifest) or " \
            "--stepmod DIR to resolve them"
        end
      end

      # Schema-name → path index from the ELF schema manifest.
      def manifest_index(manifest_path)
        manifest = Expressir::SchemaManifest.from_file(manifest_path)
        manifest.schemas.to_h do |entry|
          [entry.id.downcase, entry.path]
        end
      rescue StandardError => e
        warn "expressir: could not load schema manifest #{manifest_path}: #{e.message}"
        nil
      end

      # Schema-name → path index over a STEPmod checkout root (the
      # directory holding `schemas/`, or that directory itself).
      def stepmod_index(stepmod_dir)
        root = File.join(File.expand_path(stepmod_dir), "schemas")
        root = File.expand_path(stepmod_dir) unless File.directory?(root)
        h = {}
        Find.find(root) do |path|
          next unless path.end_with?(".exp")

          declared = File.read(path)[/\bSCHEMA\s+(\w+)/i, 1]
          h[declared.downcase] = path if declared
          h[File.basename(path, ".exp").downcase] ||= path
        end
        h
      end

      def schema_index(root_path, manifest: nil, stepmod: nil)
        return manifest_index(manifest) if manifest
        return stepmod_index(stepmod) if stepmod

        same_dir_index(root_path)
      end

      def same_dir_index(root_path)
        dir = File.dirname(File.expand_path(root_path))
        Dir.glob(File.join(dir, "*.exp")).to_h do |p|
          [File.basename(p, ".exp").downcase, p]
        end
      end

      # Interface names declared by +source+. Remark text is stripped
      # first: prose like "use from the main schema" must not spawn
      # phantom dependencies.
      def closure_names(source)
        code = source.gsub(/--[^\n]*/, "").gsub(/\(\*.*?\*\)/m, "")
        code.scan(/\bUSE\s+FROM\s+(\w+)/i).flatten.uniq +
          code.scan(/\bREFERENCE\s+FROM\s+(\w+)/i).flatten.uniq
      end

      def root_schema(root_path, manifest: nil, stepmod: nil)
        name = File.read(root_path)[/\bSCHEMA\s+(\w+)/, 1]
        # skip_references: longform generation and checking run their own
        # resolution; resolving every reference of a large closure here made
        # flatten crawl (minutes vs seconds).
        repo = Expressir::Express::Parser.from_files(
          closure_paths(root_path, manifest: manifest, stepmod: stepmod),
          skip_references: true,
          max_processes: 1,
        )
        [repo.schemas.find { |s| s.id&.downcase == name&.downcase }, repo]
      end
    end
  end
end
