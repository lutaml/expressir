require "expressir/version"

require "expressir/cli"
require "expressir/config"
require "expressir/express"

module Expressir
  class Error < StandardError; end

  def self.ui
    Expressir::Cli::UI
  end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressir.root)
  end
end
