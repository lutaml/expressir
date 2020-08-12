require "expressr/version"

require "expressr/cli"
require "expressr/config"
require "expressr/express"

module Expressr
  class Error < StandardError; end

  def self.ui
    Expressr::Cli::UI
  end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressr.root)
  end
end
