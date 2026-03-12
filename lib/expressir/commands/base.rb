module Expressir
  module Commands
    class Base
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      # Common utilities that all commands might need
      def say(message)
        # Use instance variable for testability - if output is set, use it
        if defined?(@output) && @output
          @output.puts(message)
        else
          puts(message)
        end
      end

      def exit_with_error(message, _exit_code = 1)
        raise Expressir::CommandError.new(message)
      end
    end
  end
end
