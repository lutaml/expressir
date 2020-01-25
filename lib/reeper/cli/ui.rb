require "thor"

module Reeper
  module Cli
    class UI < Thor
      def self.ask(message)
        new.ask(message)
      end

      def self.say(message)
        new.say(message)
      end

      def self.error(message)
        if log_types.include?("error")
          new.error(message)
        end
      end

      def self.info(message)
        if log_types.include?("info")
          new.say(message)
        end
      end

      def self.run(command)
        require "open3"
        Open3.capture3(command)
      end

      def self.log_types
        Reeper.configuration.logs.map(&:to_s) || []
      end
    end
  end
end
