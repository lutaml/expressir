# frozen_string_literal: true

module Expressir
  module Commands
    class ValidateLoad < Base
      def run(paths)
        # Determine if input is a manifest or direct paths
        if paths.size == 1 && File.extname(paths.first) == ".yaml"
          validate_from_manifest(paths.first)
        else
          validate_from_paths(paths)
        end
      end

      private

      def validate_from_manifest(manifest_path)
        unless File.exist?(manifest_path)
          say "Error: Manifest file not found: #{manifest_path}", :red
          exit 1
        end

        say "Loading manifest: #{manifest_path}..." if options[:verbose]

        # Load manifest
        manifest = Expressir::SchemaManifest.from_file(manifest_path)

        # Extract paths from manifest
        paths = manifest.schemas.map(&:path).reject { |p| p.nil? || p.empty? }

        if paths.empty?
          say "Error: No valid schema paths found in manifest", :red
          exit 1
        end

        say "Validating #{paths.size} schema(s) from manifest..." if options[:verbose]

        validate_from_paths(paths)
      end

      def validate_from_paths(paths)
        no_version = []
        no_valid = []

        paths.each do |path|
          x = Pathname.new(path).realpath.relative_path_from(Dir.pwd)
          say "Validating #{x}"
          ret = validate_schema(path)

          if ret.nil?
            no_valid << "Failed to parse: #{x}"
            next
          end

          ret.each do |schema_id|
            no_version << "Missing version string: schema `#{schema_id}` | #{x}"
          end
        end

        print_validation_errors(:failed_to_parse, no_valid)
        print_validation_errors(:missing_version_string, no_version)

        exit 1 unless [no_valid, no_version].all?(&:empty?)

        say "Validation passed for all EXPRESS schemas."
      end

      def validate_schema(path)
        repository = Expressir::Express::Parser.from_file(path)
        repository.schemas.inject([]) do |acc, schema|
          acc << schema.id unless schema.version&.value
          acc
        end
      rescue StandardError
        nil
      end

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
