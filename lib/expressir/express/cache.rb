require 'yaml'
require 'zlib'
require 'expressir/model'

module Expressir
  module Express
    class Cache
      def self.to_file(file, content, options = {})
        root_path = options[:root_path]
        test_overwrite_version = options[:test_overwrite_version] # don't use, only for tests

        version = test_overwrite_version || VERSION

        cache = Model::Cache.new({
          version: version,
          content: content
        })

        hash = cache.to_hash(root_path: root_path)
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
          raise Error.new("Cache version mismatch, cache version is #{cache.version}, Expressir version is #{version}")
        end

        cache.content
      end
    end
  end
end