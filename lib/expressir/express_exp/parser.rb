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
        
        parse_tree = parser.syntax()

        visitor = Visitor.new()
        visitor.visit(parse_tree)
      end
    end
  end
end