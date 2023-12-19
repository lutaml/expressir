begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "#{$1}/express_parser"
rescue LoadError
  require_relative "express_parser"
end
require 'expressir/express/visitor'
require 'expressir/express/resolve_references_model_visitor'

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
  module Express
    class Parser
      # Parses Express file into an Express model
      # @param [String] file Express file path
      # @param [Boolean] skip_references skip resolving references
      # @param [Boolean] include_source attach original source code to model elements
      # @return [Model::Repository]
      def self.from_file(file, skip_references: nil, include_source: nil)
        raise Errno::ENOENT, "File not found: #{file}" unless File.exist?(file)

      # An important note re memory management
      # parse, syntax, visitor methods return complex tree structures created in native (C++) extension
      # visit method references nodes and leaves of this structures but it is totally untransparent for Ruby GarbageCllector
      # so in this class we keep those C++ structure marked for GC so they are not freed
        @parser = ::ExpressParser::ParserExt.new(file.to_s)
        @parse_tree = @parser.syntax()
        @visitor = Visitor.new(@parser.tokens, include_source: include_source)
        @repository = @visitor.visit(@parse_tree)

        @repository.schemas.each do |schema|
          schema.file = file.to_s
        end

        unless skip_references
          @resolve_references_model_visitor = ResolveReferencesModelVisitor.new
          @resolve_references_model_visitor.visit(@repository)
        end

        @repository
      end

      # Parses Express files into an Express model
      # @param [Array<String>] files Express file paths
      # @param [Boolean] skip_references skip resolving references
      # @param [Boolean] include_source attach original source code to model elements
      # @return [Model::Repository]
      def self.from_files(files, skip_references: nil, include_source: nil)
        schemas = files.each_with_index.map do |file, i|
          # start = Time.now
          repository = self.from_file(file, skip_references: true)
          # STDERR.puts "#{i+1}/#{files.length} #{file} #{Time.now - start}"
          repository.schemas
        end.flatten

        @repository = Model::Repository.new(
          schemas: schemas
        )

        unless @skip_references
          @resolve_references_model_visitor = ResolveReferencesModelVisitor.new
          @resolve_references_model_visitor.visit(@repository)
        end

        @repository
      end
    end
  end
end