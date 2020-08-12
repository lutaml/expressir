require "pry"
require "nokogiri"
require "expressr/express/repository"
require "expressr/express/schema_definition"

module Expressr
  module Express
    def self.from_xml(file)
      Expressr::Express::Repository.from_xml(file)
    end
  end
end
