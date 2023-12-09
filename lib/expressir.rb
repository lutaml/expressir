require "expressir/version"

require "expressir/cli"
require "expressir/config"

Dir[File.join(__dir__, "expressir", "express", "*.rb")].sort.each do |fea|
  require fea
end

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
