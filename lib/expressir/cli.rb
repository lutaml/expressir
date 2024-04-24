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
      rescue StandardError => e
        # pp e
        nil
      end
    end

    desc "validate *PATH", "validate EXPRESS schema located at PATH"
    def validate(*paths)
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

        if ret.size
          ret.each do |schema_id|
            no_version << "Missing version string: schema `#{schema_id}` | #{x}"
          end
        end
      end

      if !no_valid.empty?
        puts "#{"*" * 20} RESULTS: FAILED TO PARSE #{"*" * 20}"
        no_valid.each do |msg|
          puts msg
        end
      end

      if !no_version.empty?
        puts "#{"*" * 20} RESULTS: MISSING VERSION STRING #{"*" * 20}"
        no_version.each do |msg|
          puts msg
        end
      end

      if no_valid.size || no_version.size
        exit 1
      end
    end

    desc "version", "Expressir Version"
    def version
      say(Expressir::VERSION)
    end
  end
end
