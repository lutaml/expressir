# frozen_string_literal: true

require_relative "base"

module Expressir
  module Commands
    # Detects a block anchor ([[name]]) defined in more than one remark
    # scope of the same schema. Committee sources occasionally repeat a
    # schema remark in an unscoped block and again as a tagged remark item
    # (e.g. __fund_cons); documents rendered from both scopes then carry
    # duplicated anchor attributes and fail the backend's unique-ID
    # validation. Reporting the duplication here fails at the source
    # stage instead.
    class ValidateRemarks < Base
      BLOCK_ANCHOR = /\A[ \t]*\[\[([^\]]+)\]\][ \t]*\r?\n?\z/

      def run(paths)
        if paths.size == 1 && File.extname(paths.first) == ".yaml"
          validate_from_manifest(paths.first)
        else
          validate_from_paths(paths)
        end
      end

      private

      def validate_from_manifest(manifest_path)
        unless File.exist?(manifest_path)
          raise Expressir::ManifestNotFoundError.new(manifest_path)
        end

        manifest = Expressir::SchemaManifest.from_file(manifest_path)
        paths = manifest.schemas.map(&:path).reject { |p| p.nil? || p.empty? }
        if paths.empty?
          raise Expressir::NoValidSchemaPathsError.new(
            "No valid schema paths found in manifest",
          )
        end

        validate_from_paths(paths)
      end

      def validate_from_paths(paths)
        violations = []
        paths.each do |path|
          repository = Expressir::Express::Parser.from_file(path)
          repository.schemas.each do |schema|
            violations.concat(duplicate_anchor_violations(schema, path))
          end
        end

        if violations.empty?
          say "Validation passed: no remark block anchor is defined in " \
              "more than one remark scope."
          return
        end

        say "#{'*' * 20} RESULTS: DUPLICATE REMARK BLOCK ANCHORS #{'*' * 20}"
        violations.each { |violation| say violation }
        raise Expressir::SchemaValidationError.new(
          "Remark validation failed: #{violations.size} duplicate block " \
          "anchor definition(s)",
          errors: violations,
        )
      end

      def duplicate_anchor_violations(schema, path)
        definitions = Hash.new { |hash, anchor| hash[anchor] = [] }
        remark_scopes(schema).each do |label, remarks|
          Array(remarks).each do |text|
            next if text.nil?

            source = text.is_a?(String) ? text : text.to_s
            source.each_line do |line|
              match = line.match(BLOCK_ANCHOR)
              next unless match

              definitions[match[1]] << label
            end
          end
        end

        definitions.filter_map do |anchor, labels|
          next if labels.size == 1

          "Duplicate remark block anchor `#{anchor}` defined in " \
            "#{labels.join(', ')} | schema `#{schema.id}` | #{path}"
        end
      end

      def remark_scopes(schema)
        scopes = [["the untagged schema remark", Array(schema.remarks)]]
        Array(schema.remark_items).each do |item|
          scopes << ["remark item `#{item.id}`", Array(item.remarks)]
        end
        scopes
      end
    end
  end
end
