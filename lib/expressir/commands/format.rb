module Expressir
  module Commands
    class Format < Base
      def run(path)
        repository = Expressir::Express::Parser.from_file(path)
        repository.schemas.each do |schema|
          say "\n(* Expressir formatted schema: #{schema.id} *)\n"
          say schema.to_s(no_remarks: true)
        end
      end
    end
  end
end
