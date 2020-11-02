require 'antlr4/runtime'
require 'expressir/express_exp/generated/ExpressVisitor'
require 'expressir/express_exp/generated/ExpressLexer'
require 'expressir/express_exp/generated/ExpressParser'
require 'expressir/express_exp/visitor'

module Expressir
  module ExpressExp
    class Parser
      def self.from_exp(file)
        input = File.read(file)

        char_stream = Antlr4::Runtime::CharStreams.from_string(input, 'String')
        lexer = Generated::ExpressLexer.new(char_stream)
        token_stream = Antlr4::Runtime::CommonTokenStream.new(lexer)
        parser = Generated::ExpressParser.new(token_stream)

        # don't attempt to recover from any parsing error
        parser.instance_variable_set(:@_err_handler, Antlr4::Runtime::BailErrorStrategy.new)

        parse_tree = parser.syntax()

        visitor = Visitor.new(token_stream)
        repo = visitor.visit(parse_tree)

        repo
      end
    end
  end
end