require "thor"
require "reeper/cli/ui"

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
    end
  end
end
