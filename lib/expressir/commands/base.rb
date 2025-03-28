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

      def exit_with_error(message, exit_code = 1)
        say message
        # In test mode, raise an exception instead of exiting
        # This makes it easier to test error cases
        if defined?(@test_mode) && @test_mode
          raise message # Just raise the message as an exception
        else
          exit exit_code
        end
      end
    end
  end
end
