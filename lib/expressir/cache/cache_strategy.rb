# frozen_string_literal: true

module Expressir
  module Cache
    # Abstract base class for cache strategies
    #
    # Defines the interface that all cache implementations must follow.
    # Subclasses must implement get, put, delete, clear, and exists? methods.
    #
    # This follows the Strategy pattern, allowing different caching mechanisms
    # to be swapped without changing client code.
    class CacheStrategy
      # Retrieve a value from the cache
      #
      # @param key [String] the cache key
      # @return [Object, nil] the cached value, or nil if not found
      def get(key)
        raise NotImplementedError, "#{self.class} must implement #get"
      end

      # Store a value in the cache
      #
      # @param key [String] the cache key
      # @param value [Object] the value to cache
      # @return [void]
      def put(key, value)
        raise NotImplementedError, "#{self.class} must implement #put"
      end

      # Remove a value from the cache
      #
      # @param key [String] the cache key
      # @return [void]
      def delete(key)
        raise NotImplementedError, "#{self.class} must implement #delete"
      end

      # Clear all entries from the cache
      #
      # @return [void]
      def clear
        raise NotImplementedError, "#{self.class} must implement #clear"
      end

      # Check if a key exists in the cache
      #
      # @param key [String] the cache key
      # @return [Boolean] true if the key exists
      def exists?(key)
        raise NotImplementedError, "#{self.class} must implement #exists?"
      end

      # Get cache statistics
      #
      # @return [Hash] statistics about cache usage
      def stats
        {
          type: self.class.name,
          size: size,
        }
      end

      # Get the number of entries in the cache
      #
      # @return [Integer] number of cached entries
      def size
        raise NotImplementedError, "#{self.class} must implement #size"
      end
    end
  end
end
