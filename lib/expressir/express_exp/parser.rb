require 'express_parser'
require 'expressir/express_exp/visitor'

module Expressir
  module ExpressExp
    class Parser
      def self.from_exp(file)
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

        visitor = Visitor.new(nil)
        repo = parser.visit(visitor)

        repo
      end
    end
  end
end