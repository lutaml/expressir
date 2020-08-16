require "pry"
require "nokogiri"
require "expressir/express/repository"
require "expressir/express/schema_definition"

module Expressir
  module Express
    def self.from_xml(file)
      Expressir::Express::Repository.from_xml(file)
    end
  end
end
