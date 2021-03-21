begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "#{$1}/express_parser"
rescue LoadError
  require_relative "express_parser"
end
require 'expressir/express_exp/visitor'
require 'expressir/express_exp/resolve_references_model_visitor'

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

module Expressir
  module ExpressExp
    class Parser
      def self.from_file(file, options = {})
        skip_references = options[:skip_references]

        input = File.read(file)

        parser = ::ExpressParser::Parser.parse(input)

        parse_tree = parser.syntax()

        visitor = Visitor.new(parser.tokens, options)
        repository = visitor.visit(parse_tree)

        repository.schemas.each do |schema|
          schema.file = file.to_s
        end

        unless skip_references
          resolve_references_model_visitor = ResolveReferencesModelVisitor.new
          resolve_references_model_visitor.visit(repository)
        end

        repository
      end

      def self.from_files(files, options = {})
        skip_references = options[:skip_references]

        schemas = files.each_with_index.map do |file, i|
          # start = Time.now
          repository = self.from_file(file, options.merge(skip_references: true))
          # STDERR.puts "#{i+1}/#{files.length} #{file} #{Time.now - start}"
          repository.schemas
        end.flatten

        repository = Model::Repository.new({
          schemas: schemas
        })

        unless skip_references
          resolve_references_model_visitor = ResolveReferencesModelVisitor.new
          resolve_references_model_visitor.visit(repository)
        end

        repository
      end
    end
  end
end