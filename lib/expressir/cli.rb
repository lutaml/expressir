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

    desc "version", "Expressir Version"
    def version
      say(Expressir::VERSION)
    end
  end
end
