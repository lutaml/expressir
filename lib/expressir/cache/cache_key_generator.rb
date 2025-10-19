# frozen_string_literal: true

require "digest"

module Expressir
  module Cache
    # Generates cache keys for parser caching
    #
    # Creates consistent, collision-resistant cache keys based on
    # file paths and content using SHA256 hashing.
    class CacheKeyGenerator
      # Generate a cache key from file path and content
      #
      # @param file_path [String] path to the EXPRESS file
      # @param content [String] content of the EXPRESS file
      # @return [String] cache key
      def self.generate(file_path:, content:)
        new.generate(file_path: file_path, content: content)
      end

      # Generate a cache key from file path and content
      #
      # @param file_path [String] path to the EXPRESS file
      # @param content [String] content of the EXPRESS file
      # @return [String] cache key
      def generate(file_path:, content:)
        normalized_path = normalize_path(file_path)
        content_hash = hash_content(content)
        "#{normalized_path}:#{content_hash}"
      end

      # Generate a cache key from file path only
      #
      # This is useful when the content is already loaded and you want
      # to check if a cached version exists before parsing.
      #
      # @param file_path [String] path to the EXPRESS file
      # @return [String] cache key prefix
      def generate_from_path(file_path)
        normalize_path(file_path)
      end

      # Validate a cache key format
      #
      # @param key [String] cache key to validate
      # @return [Boolean] true if key is valid
      def valid_key?(key)
        key.is_a?(String) && key.include?(":") && key.split(":").length == 2
      end

      private

      # Normalize file path for consistent cache keys
      #
      # @param file_path [String] file path
      # @return [String] normalized path
      def normalize_path(file_path)
        File.expand_path(file_path)
      end

      # Generate SHA256 hash of content
      #
      # @param content [String] content to hash
      # @return [String] hexadecimal hash
      def hash_content(content)
        Digest::SHA256.hexdigest(content)
      end
    end
  end
end
