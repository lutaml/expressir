require "thor"

module Expressir
  class Cli < Thor
    desc "format PATH", "pretty print EXPRESS schema located at PATH"
    def format(path)
      repository = Expressir::Express::Parser.from_file(path)
      repository.schemas.each do |schema|
        puts "\n(* Expressir formatted schema: #{schema.id} *)\n"
        puts schema.to_s(no_remarks: true)
      end
    end

    no_commands do
      def _validate_schema(path)
        repository = Expressir::Express::Parser.from_file(path)
        repository.schemas.inject([]) do |acc, schema|
          acc << schema.id unless schema.version&.value
          acc
        end
      rescue StandardError
        nil
      end

      def _print_validation_errors(type, array)
        return if array.empty?

        puts "#{'*' * 20} RESULTS: #{type.to_s.upcase.gsub('_', ' ')} #{'*' * 20}"
        array.each do |msg|
          puts msg
        end
      end
    end

    desc "validate *PATH", "validate EXPRESS schema located at PATH"
    def validate(*paths) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      no_version = []
      no_valid = []

      paths.each do |path|
        x = Pathname.new(path).realpath.relative_path_from(Dir.pwd)
        puts "Validating #{x}"
        ret = _validate_schema(path)

        if ret.nil?
          no_valid << "Failed to parse: #{x}"
          next
        end

        ret.each do |schema_id|
          no_version << "Missing version string: schema `#{schema_id}` | #{x}"
        end
      end

      _print_validation_errors(:failed_to_parse, no_valid)
      _print_validation_errors(:missing_version_string, no_version)

      exit 1 unless [no_valid, no_version].all?(&:empty?)

      puts "Validation passed for all EXPRESS schemas."
    end

    desc "version", "Expressir Version"
    def version
      say(Expressir::VERSION)
    end
  end
end
