module Expressir
  module Commands
    class Base
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      # Common utilities that all commands might need
      def say(message)
        puts message
      end

      def exit_with_error(message, exit_code = 1)
        say message
        exit exit_code
      end
    end
  end
end
