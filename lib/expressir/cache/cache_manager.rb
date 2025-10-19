# frozen_string_literal: true

require_relative "memory_cache"
require_relative "disk_cache"
require_relative "cache_key_generator"

module Expressir
  module Cache
    # Manages caching with a two-tier strategy
    #
    # Implements a caching hierarchy:
    # 1. Fast memory cache (L1) for frequently accessed items
    # 2. Persistent disk cache (L2) for long-term storage
    #
    # When retrieving data:
    # - Check memory cache first (fastest)
    # - If not found, check disk cache
    # - If found in disk, promote to memory cache
    # - If not found anywhere, return nil
    #
    # When storing data:
    # - Store in both memory and disk caches
    class CacheManager
      attr_reader :memory_cache, :disk_cache, :key_generator

      # Initialize a new cache manager
      #
      # @param memory_cache [CacheStrategy] memory cache instance
      # @param disk_cache [CacheStrategy] disk cache instance
      # @param key_generator [CacheKeyGenerator] key generator instance
      def initialize(
        memory_cache: nil,
        disk_cache: nil,
        key_generator: nil
      )
        @memory_cache = memory_cache || MemoryCache.new
        @disk_cache = disk_cache || DiskCache.new
        @key_generator = key_generator || CacheKeyGenerator.new
      end

      # Retrieve a value from the cache hierarchy
      #
      # @param key [String] cache key
      # @return [Object, nil] cached value or nil if not found
      def get(key)
        # Try memory cache first (L1)
        value = @memory_cache.get(key)
        return value if value

        # Try disk cache (L2)
        value = @disk_cache.get(key)
        return nil unless value

        # Promote to memory cache
        @memory_cache.put(key, value)
        value
      end

      # Store a value in both cache tiers
      #
      # @param key [String] cache key
      # @param value [Object] value to cache
      # @return [Object] the cached value
      def put(key, value)
        @memory_cache.put(key, value)
        @disk_cache.put(key, value)
        value
      end

      # Remove a value from both cache tiers
      #
      # @param key [String] cache key
      # @return [void]
      def delete(key)
        @memory_cache.delete(key)
        @disk_cache.delete(key)
      end

      # Clear both cache tiers
      #
      # @return [void]
      def clear
        @memory_cache.clear
        @disk_cache.clear
      end

      # Check if a key exists in either cache tier
      #
      # @param key [String] cache key
      # @return [Boolean] true if key exists
      def exists?(key)
        @memory_cache.exists?(key) || @disk_cache.exists?(key)
      end

      # Get combined cache statistics
      #
      # @return [Hash] hash containing statistics from both tiers
      def stats
        {
          memory: @memory_cache.stats,
          disk: @disk_cache.stats,
          total_size: @memory_cache.size + @disk_cache.size,
        }
      end

      # Generate a cache key for file path and content
      #
      # @param file_path [String] path to the EXPRESS file
      # @param content [String] content of the EXPRESS file
      # @return [String] cache key
      def generate_key(file_path:, content:)
        @key_generator.generate(file_path: file_path, content: content)
      end

      # Fetch from cache or compute and store
      #
      # This is a convenience method that handles the common pattern of:
      # 1. Check cache
      # 2. If not found, compute value using block
      # 3. Store in cache
      # 4. Return value
      #
      # @param key [String] cache key
      # @yield Block that computes the value if not cached
      # @return [Object] cached or computed value
      def fetch(key)
        value = get(key)
        return value if value

        return nil unless block_given?

        value = yield
        put(key, value)
        value
      end

      # Fetch from cache using file path and content
      #
      # @param file_path [String] path to the EXPRESS file
      # @param content [String] content of the EXPRESS file
      # @yield Block that computes the value if not cached
      # @return [Object] cached or computed value
      def fetch_for_file(file_path:, content:)
        key = generate_key(file_path: file_path, content: content)
        fetch(key) { yield if block_given? }
      end
    end
  end
end
