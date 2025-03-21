require "zlib"

module Expressir
  module Express
    class Cache
      # Save Express model into a cache file
      # @param file [String] cache file path
      # @param content [Model::ModelElement] Express model
      # @param root_path [String] Express repository root path, to be stripped from Express file paths to create a portable cache file
      # @param test_overwrite_version [String] don't use, only for tests
      # @return [nil]
      def self.to_file(file, content, root_path: nil, test_overwrite_version: nil)
        version = test_overwrite_version || VERSION

        cache = Model::Cache.new(
          version: version,
          content: content,
          root_path: root_path,
        )

        yaml = cache.to_yaml
        yaml_compressed = Zlib::Deflate.deflate(yaml)

        File.binwrite(file, yaml_compressed)
        nil
      end

      # Load Express model from a cache file
      # @param file [String] cache file path
      # @param root_path [String] Express repository root path, to be prepended to Express file paths if loading a portable cache file
      # @param test_overwrite_version [String] don't use, only for tests
      # @return [Model::ModelElement] Express model
      def self.from_file(file, root_path: nil, test_overwrite_version: nil)
        version = test_overwrite_version || VERSION

        yaml_compressed = File.binread(file)
        yaml = Zlib::Inflate.inflate(yaml_compressed)
        cache = Model::Cache.from_yaml(yaml)

        if cache.version != version
          raise Error::CacheVersionMismatchError.new(cache.version, version)
        end

        cache
      end
    end
  end
end
