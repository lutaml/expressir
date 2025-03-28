module Expressir
  module Commands
    class Version < Base
      def run
        say Expressir::VERSION
      end
    end
  end
end
