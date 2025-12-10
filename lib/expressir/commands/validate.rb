# frozen_string_literal: true

require "thor"

module Expressir
  module Commands
    # Thor subcommand for EXPRESS validation operations
    class Validate < Thor
      desc "load PATH_OR_MANIFEST",
           "Validate EXPRESS schema loading and version strings"
      long_desc <<~DESC
        Validate EXPRESS schema(s) for parsing errors and version string presence.

        Accepts either:
        - Individual EXPRESS file paths (*.exp)
        - A Schema Manifest YAML file (*.yaml) containing schema definitions

        When using a Schema Manifest, all schemas in the manifest will be validated.

        Examples:
          # Validate individual EXPRESS files
          expressir validate load schema1.exp schema2.exp

          # Validate schemas from a manifest
          expressir validate load manifest.yaml

          # Validate with verbose output
          expressir validate load manifest.yaml --verbose
      DESC
      method_option :verbose, type: :boolean, default: false,
                              desc: "Show verbose output"
      def load(*paths)
        require_relative "validate_load"
        ValidateLoad.new(options).run(paths)
      end

      desc "ascii PATH_OR_MANIFEST",
           "Validate EXPRESS files for ASCII-only content"
      long_desc <<~DESC
        Validate EXPRESS file(s) for non-ASCII characters and provide replacement suggestions.

        Accepts either:
        - Individual EXPRESS file path (*.exp)
        - A directory path (with --recursive option)
        - A Schema Manifest YAML file (*.yaml) containing schema definitions

        When using a Schema Manifest, all schemas in the manifest will be validated.

        This command:
        - Scans each line for non-ASCII characters
        - Reports detailed information about each violation
        - Provides specific replacement suggestions (AsciiMath or ISO 10303-11)
        - Displays a summary table showing all violations
        - Optionally outputs structured data in YAML format

        Examples:
          # Validate a single EXPRESS file
          expressir validate ascii schema.exp

          # Validate all EXPRESS files in a directory recursively
          expressir validate ascii ../iso-10303/schemas -r

          # Validate schemas from a manifest
          expressir validate ascii manifest.yaml

          # Output results in YAML format
          expressir validate ascii manifest.yaml -y

          # Include remarks in validation (default: false)
          expressir validate ascii schema.exp --check-remarks
      DESC
      method_option :recursive, type: :boolean, default: false, aliases: "-r",
                                desc: "Validate EXPRESS files under the specified path recursively"
      method_option :yaml, type: :boolean, default: false, aliases: "-y",
                           desc: "Output results in YAML format"
      method_option :check_remarks, type: :boolean, default: false,
                                    desc: "Include remarks in ASCII validation (default: false, remarks are excluded)"
      method_option :verbose, type: :boolean, default: false,
                              desc: "Show verbose output"
      def ascii(path)
        require_relative "validate_ascii"
        ValidateAscii.new(options).run(path)
      end
    end
  end
end
