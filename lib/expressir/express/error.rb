module Expressir
  module Express
    # Error raised when there's a version mismatch in the cache
    class CacheVersionMismatchError < StandardError
      attr_reader :cache_version, :expressir_version

      # Initialize a new CacheVersionMismatchError error
      # @param cache_version [String] The version of the cache file
      # @param expressir_version [String] The current Expressir version
      def initialize(cache_version, expressir_version)
        @cache_version = cache_version
        @expressir_version = expressir_version
        super("Cache version mismatch, cache version is #{cache_version}, Expressir version is #{expressir_version}")
      end
    end

    # Module containing specific error classes for the Express parser
    module Error
      # Error raised when a schema file fails to parse
      class SchemaParseFailure < StandardError
        attr_reader :filename, :original_error, :parse_failure_cause

        # Initialize a new SchemaParseFailure error
        # @param filename [String] The name of the file that failed to parse
        # @param original_error [Parslet::ParseFailed] The original parsing error
        def initialize(filename, original_error)
          @filename = filename
          @original_error = original_error
          @parse_failure_cause = original_error.parse_failure_cause
          super("Failed to parse schema in file '#{filename}': #{original_error.message}")
        end
      end
    end
  end
end
