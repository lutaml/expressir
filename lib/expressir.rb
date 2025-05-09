require "zeitwerk"
require_relative "expressir/version"
require_relative "expressir/cli"
require_relative "expressir/config"
require_relative "expressir/benchmark"
require_relative "expressir/coverage"
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
  class Error < StandardError; end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressir.root)
  end
end

loader = Zeitwerk::Loader.for_gem
loader.setup

Dir[File.join(__dir__, "expressir", "express", "*.rb")].sort.each do |fea|
  require fea
end

require_relative "expressir/model"
