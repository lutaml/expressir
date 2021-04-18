require "thor"
require "expressir/cli/ui"

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
    end
  end
end
