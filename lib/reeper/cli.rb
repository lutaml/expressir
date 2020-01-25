require "thor"
require "reeper/cli/ui"
require "reeper/express_parser"

module Reeper
  module Cli
    def self.ui
      Reeper::Cli::UI
    end

    def self.start(args)
      Base.start(args)
    end

    class Base < Thor
      desc "version", "The Reeper Version"
      def version
        Cli.ui.say("Version #{Reeper::VERSION}")
      end

      desc "express-to-owl FILE", "Express to OWL conversion"
      def express_to_owl(file)
        Cli.ui.say(ExpressParser.to_owl(file))
      end
    end
  end
end
