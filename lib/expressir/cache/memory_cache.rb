# frozen_string_literal: true

require_relative "cache_strategy"

module Expressir
  module Cache
    # In-memory cache with LRU (Least Recently Used) eviction policy
    #
    # Stores cached values in memory with a configurable maximum size.
    # When the cache is full, the least recently used entry is evicted.
    #
    # Thread-safe through Mutex synchronization.
    class MemoryCache < CacheStrategy
      DEFAULT_MAX_SIZE = 100

      # Initialize a new memory cache
      #
      # @param max_size [Integer] maximum number of entries to cache
      def initialize(max_size: DEFAULT_MAX_SIZE)
        super()
        @max_size = max_size
        @cache = {}
        @access_order = []
        @mutex = Mutex.new
        @hits = 0
        @misses = 0
      end

      # Retrieve a value from the cache
      #
      # @param key [String] cache key
      # @return [Object, nil] cached value or nil if not found
      def get(key)
        @mutex.synchronize do
          if @cache.key?(key)
            @hits += 1
            update_access_order(key)
            @cache[key]
          else
            @misses += 1
            nil
          end
        end
      end

      # Store a value in the cache
      #
      # @param key [String] cache key
      # @param value [Object] value to cache
      # @return [Object] the cached value
      def put(key, value)
        @mutex.synchronize do
          if @cache.key?(key)
            @cache[key] = value
            update_access_order(key)
          else
            evict_lru if @cache.size >= @max_size
            @cache[key] = value
            @access_order.push(key)
          end
          value
        end
      end

      # Remove a value from the cache
      #
      # @param key [String] cache key
      # @return [Object, nil] the removed value or nil if not found
      def delete(key)
        @mutex.synchronize do
          @access_order.delete(key)
          @cache.delete(key)
        end
      end

      # Clear all cached values
      #
      # @return [void]
      def clear
        @mutex.synchronize do
          @cache.clear
          @access_order.clear
          @hits = 0
          @misses = 0
        end
      end

      # Check if a key exists in the cache
      #
      # @param key [String] cache key
      # @return [Boolean] true if key exists
      def exists?(key)
        @mutex.synchronize do
          @cache.key?(key)
        end
      end

      # Get cache statistics
      #
      # @return [Hash] hash containing cache statistics
      def stats
        @mutex.synchronize do
          total_requests = @hits + @misses
          hit_rate = total_requests.zero? ? 0.0 : @hits.to_f / total_requests
          {
            hits: @hits,
            misses: @misses,
            hit_rate: hit_rate,
            size: @cache.size,
            max_size: @max_size,
            evictions: @misses.positive? ? [@cache.size - @max_size, 0].max : 0,
          }
        end
      end

      # Get the current number of entries in the cache
      #
      # @return [Integer] number of cached entries
      def size
        @mutex.synchronize do
          @cache.size
        end
      end

      private

      # Update the access order for LRU tracking
      #
      # @param key [String] cache key
      # @return [void]
      def update_access_order(key)
        @access_order.delete(key)
        @access_order.push(key)
      end

      # Evict the least recently used entry
      #
      # @return [void]
      def evict_lru
        return if @access_order.empty?

        lru_key = @access_order.shift
        @cache.delete(lru_key)
      end
    end
  end
end
