require "pry"
require "nokogiri"
require "reeper/express/repository"
require "reeper/express/schema_definition"

module Reeper
  module Express
    def self.from_xml(file)
      Reeper::Express::Repository.from_xml(file)
    end
  end
end
