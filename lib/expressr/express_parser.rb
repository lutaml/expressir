require "expressr/parser"

module Expressr
  class ExpressParser
    def initialize(file, options)
      @file = file
      @options = options
    end

    def to_owl
      owl_parser.parse(express_xml, options)
    end

    def self.to_owl(file, **options)
      new(file, options).to_owl
    end

    private

    attr_reader :file, :options

    def owl_parser
      Expressr::Parser::OwlParser
    end

    def express_xml
      Expressr::Express.from_xml(file)
    end
  end
end
