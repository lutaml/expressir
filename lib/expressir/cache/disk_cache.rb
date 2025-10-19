# frozen_string_literal: true

require "fileutils"
require "digest"
require "json"
require_relative "cache_strategy"

module Expressir
  module Cache
    # Disk-based cache with persistent storage
    #
    # Stores cached values as files on disk in a specified directory.
    # Each cache entry is stored as a separate file with metadata.
    #
    # Thread-safe through file system operations and Mutex for stats.
    class DiskCache < CacheStrategy
      DEFAULT_CACHE_DIR = ".cache/expressir"
      METADATA_SUFFIX = ".meta"

      # Initialize a new disk cache
      #
      # @param cache_dir [String] directory path for cache storage
      def initialize(cache_dir: DEFAULT_CACHE_DIR)
        super()
        @cache_dir = File.expand_path(cache_dir)
        @mutex = Mutex.new
        @hits = 0
        @misses = 0
        ensure_cache_dir_exists
      end

      # Retrieve a value from the cache
      #
      # @param key [String] cache key
      # @return [Object, nil] cached value or nil if not found
      def get(key)
        cache_file = cache_file_path(key)

        if File.exist?(cache_file)
          @mutex.synchronize { @hits += 1 }
          update_access_time(cache_file)
          read_cache_file(cache_file)
        else
          @mutex.synchronize { @misses += 1 }
          nil
        end
      rescue StandardError
        @mutex.synchronize { @misses += 1 }
        nil
      end

      # Store a value in the cache
      #
      # @param key [String] cache key
      # @param value [Object] value to cache
      # @return [Object] the cached value
      def put(key, value)
        cache_file = cache_file_path(key)
        write_cache_file(cache_file, value)
        value
      rescue StandardError => e
        raise CacheError, "Failed to write cache file: #{e.message}"
      end

      # Remove a value from the cache
      #
      # @param key [String] cache key
      # @return [Object, nil] the removed value or nil if not found
      def delete(key)
        cache_file = cache_file_path(key)
        meta_file = metadata_file_path(key)

        return nil unless File.exist?(cache_file)

        value = read_cache_file(cache_file)
        FileUtils.rm_f(cache_file)
        FileUtils.rm_f(meta_file)
        value
      rescue StandardError
        nil
      end

      # Clear all cached values
      #
      # @return [void]
      def clear
        return unless Dir.exist?(@cache_dir)

        Dir.glob(File.join(@cache_dir, "*")).each do |file|
          File.delete(file) if File.file?(file)
        end

        @mutex.synchronize do
          @hits = 0
          @misses = 0
        end
      rescue StandardError => e
        raise CacheError, "Failed to clear cache: #{e.message}"
      end

      # Check if a key exists in the cache
      #
      # @param key [String] cache key
      # @return [Boolean] true if key exists
      def exists?(key)
        File.exist?(cache_file_path(key))
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
            size: size,
            cache_dir: @cache_dir,
            disk_usage: calculate_disk_usage,
          }
        end
      end

      # Get the current number of entries in the cache
      #
      # @return [Integer] number of cached entries
      def size
        return 0 unless Dir.exist?(@cache_dir)

        Dir.glob(File.join(@cache_dir, "*"))
          .reject { |f| f.end_with?(METADATA_SUFFIX) }
          .count { |f| File.file?(f) }
      end

      private

      # Ensure the cache directory exists
      #
      # @return [void]
      def ensure_cache_dir_exists
        FileUtils.mkdir_p(@cache_dir)
      end

      # Generate cache file path from key
      #
      # @param key [String] cache key
      # @return [String] file path for cache entry
      def cache_file_path(key)
        hashed_key = Digest::SHA256.hexdigest(key)
        File.join(@cache_dir, hashed_key)
      end

      # Generate metadata file path from key
      #
      # @param key [String] cache key
      # @return [String] file path for metadata entry
      def metadata_file_path(key)
        "#{cache_file_path(key)}#{METADATA_SUFFIX}"
      end

      # Read a cache file
      #
      # @param cache_file [String] path to cache file
      # @return [Object] cached value
      def read_cache_file(cache_file)
        Marshal.load(File.binread(cache_file))
      end

      # Write a cache file
      #
      # @param cache_file [String] path to cache file
      # @param value [Object] value to cache
      # @return [void]
      def write_cache_file(cache_file, value)
        serialized = Marshal.dump(value)
        File.binwrite(cache_file, serialized)
        write_metadata(cache_file)
      end

      # Write metadata for a cache entry
      #
      # @param cache_file [String] path to cache file
      # @return [void]
      def write_metadata(cache_file)
        meta_file = "#{cache_file}#{METADATA_SUFFIX}"
        metadata = {
          created_at: Time.now.to_i,
          accessed_at: Time.now.to_i,
          size: File.size(cache_file),
        }
        File.write(meta_file, JSON.generate(metadata))
      end

      # Update access time for a cache entry
      #
      # @param cache_file [String] path to cache file
      # @return [void]
      def update_access_time(cache_file)
        meta_file = "#{cache_file}#{METADATA_SUFFIX}"
        return unless File.exist?(meta_file)

        metadata = JSON.parse(File.read(meta_file))
        metadata["accessed_at"] = Time.now.to_i
        File.write(meta_file, JSON.generate(metadata))
      rescue StandardError
        # Ignore metadata update errors
      end

      # Calculate total disk usage of cache
      #
      # @return [Integer] total bytes used by cache
      def calculate_disk_usage
        return 0 unless Dir.exist?(@cache_dir)

        Dir.glob(File.join(@cache_dir, "*"))
          .select { |f| File.file?(f) }
          .sum { |f| File.size(f) }
      end
    end
  end
end
