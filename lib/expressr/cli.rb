require "thor"
require "expressr/cli/ui"
require "expressr/express_parser"

module Expressr
  module Cli
    def self.ui
      Expressr::Cli::UI
    end

    def self.start(args)
      Base.start(args)
    end

    class Base < Thor
      desc "version", "The Expressr Version"
      def version
        Cli.ui.say("Version #{Expressr::VERSION}")
      end

      desc "express-to-owl FILE", "Express to OWL conversion"
      def express_to_owl(file)
        Cli.ui.say(ExpressParser.to_owl(file))
      end
    end
  end
end
