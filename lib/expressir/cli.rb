require "thor"
require "expressir/cli/ui"
require "expressir/express_parser"

module Expressir
  module Cli
    def self.ui
      Expressir::Cli::UI
    end

    def self.start(args)
      Base.start(args)
    end

    class Base < Thor
      desc "version", "The Expressir Version"
      def version
        Cli.ui.say("Version #{Expressir::VERSION}")
      end

      desc "express-to-owl FILE", "Express to OWL conversion"
      def express_to_owl(file)
        Cli.ui.say(ExpressParser.to_owl(file))
      end
    end
  end
end
