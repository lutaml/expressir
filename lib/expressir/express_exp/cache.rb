require 'yaml'
require 'zlib'
require 'expressir/model'

module Expressir
  module ExpressExp
    class Cache
      def self.to_file(file, model, options = {})
        root_path = options[:root_path]
        test_overwrite_version = options[:test_overwrite_version] # don't use, only for tests

        version = test_overwrite_version || VERSION

        cache = Model::Cache.new({
          version: version,
          model: model
        })

        hash = cache.to_hash(root_path: root_path, skip_empty: true)
        yaml = YAML.dump(hash)
        yaml_compressed = Zlib::Deflate.deflate(yaml)

        File.binwrite(file, yaml_compressed)
      end

      def self.from_file(file, options = {})
        root_path = options[:root_path]
        test_overwrite_version = options[:test_overwrite_version] # don't use, only for tests

        version = test_overwrite_version || VERSION

        yaml_compressed = File.binread(file)
        yaml = Zlib::Inflate.inflate(yaml_compressed)
        hash = YAML.load(yaml)
        cache = Model::ModelElement.from_hash(hash, root_path: root_path)

        if cache.version != version
          raise CacheLoadError.new("Cache version mismatch, cache version is #{cache.version}, Expressir version is #{VERSION}")
        end

        cache.model
      end
    end

    class CacheLoadError < StandardError
    end
  end
end