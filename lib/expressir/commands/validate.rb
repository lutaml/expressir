module Expressir
  module Commands
    class Validate < Base
      def run(paths)
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

      private

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
