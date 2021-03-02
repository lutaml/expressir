begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "#{$1}/express_parser"
rescue LoadError
  require_relative "express_parser"
end
require 'expressir/express_exp/visitor'

module Expressir
  module ExpressExp
    class Parser
      def self.from_file(file)
        input = File.read(file)

=begin
        char_stream = Antlr4::Runtime::CharStreams.from_string(input, 'String')
        lexer = ::ExpressParser::Lexer.new(char_stream)
        token_stream = Antlr4::Runtime::CommonTokenStream.new(lexer)
        parser = ::ExpressParser::Parser.new(token_stream)

        # don't attempt to recover from any parsing error
        parser.instance_variable_set(:@_err_handler, Antlr4::Runtime::BailErrorStrategy.new)

        parse_tree = parser.syntax()

        visitor = Visitor.new(token_stream)
        repo = visitor.visit(parse_tree)
=end

        parser = ::ExpressParser::Parser.parse(input)

        parse_tree = parser.syntax()

        visitor = Visitor.new(parser.tokens)
        repo = visitor.visit(parse_tree)

        repo.schemas.each{|schema| schema.file = file}

        repo
      end

      def self.from_files(files)
        schemas = files.map{|file| self.from_file(file).schemas}.flatten

        repo = Model::Repository.new({
          schemas: schemas
        })

        repo.schemas.each{|schema| schema.parent = repo}

        repo
      end

      # deprecated
      def self.from_exp(file)
        self.from_file(file)
      end
    end
  end
end