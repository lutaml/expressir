require_relative "expressir/version"
require_relative "expressir/errors"

require "lutaml/model"
require "liquid" # To enable Lutaml::Model::Liquefiable

# ..........................................................
# https://bugs.ruby-lang.org/issues/19319
# The issue is that this bug is fixed for 3.1 and above,
# but not for 3.0 or 2.7, so we need a "safe" function
# ..........................................................
if RUBY_VERSION < "3.1"
  class String
    def safe_downcase
      each_char.map(&:downcase).join
    end
  end
else
  class String
    def safe_downcase
      downcase
    end
  end
end

module Expressir
  # Namespace modules - autoload loads the namespace file which contains
  # autoload definitions for classes within that namespace
  autoload :Config, "#{__dir__}/expressir/config"
  extend Config

  autoload :Benchmark, "#{__dir__}/expressir/benchmark"
  autoload :Coverage, "#{__dir__}/expressir/coverage"

  autoload :Express, "#{__dir__}/expressir/express"
  autoload :Model, "#{__dir__}/expressir/model"
  autoload :Commands, "#{__dir__}/expressir/commands"
  autoload :Changes, "#{__dir__}/expressir/changes"
  autoload :Package, "#{__dir__}/expressir/package"
  autoload :Manifest, "#{__dir__}/expressir/manifest"
  autoload :Eengine, "#{__dir__}/expressir/eengine"
  autoload :SchemaManifest, "#{__dir__}/expressir/schema_manifest"
  autoload :SchemaManifestEntry, "#{__dir__}/expressir/schema_manifest_entry"

  # CLI is loaded last so that namespace autoloads are defined first
  # CLI uses Expressir::Commands::* which triggers autoload
  autoload :Cli, "#{__dir__}/expressir/cli"

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressir.root)
  end
end
