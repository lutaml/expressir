require "reeper/version"

require "reeper/cli"
require "reeper/config"
require "reeper/express"

module Reeper
  class Error < StandardError; end

  def self.ui
    Reeper::Cli::UI
  end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Reeper.root)
  end
end
