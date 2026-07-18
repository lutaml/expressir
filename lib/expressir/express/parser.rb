# frozen_string_literal: true

require "parsanol"

module Expressir
  module Express
    # Public-facing parser facade.
    #
    # Three concerns were split out (TODO.bugs/09):
    # - Grammar rules → {Grammar::Parser} (~250 Parsanol rules)
    # - Schema-block splitting → {SchemaBlockScanner}
    # - I/O orchestration → this class (from_file, from_exp, etc.)
    #
    # The facade delegates grammar work to Grammar::Parser and block
    # extraction to SchemaBlockScanner. All public methods remain
    # backward-compatible.
    class Parser
      # Threshold for using memory-bounded fresh parse (bytes)
      LARGE_FILE_THRESHOLD = 1024 * 1024 # 1 MB

      class << self
        # Delegate grammar-level queries to Grammar::Parser.
        def native_available? = Grammar::Parser.native_available?
        def cached_parser = Grammar::Parser.cached_parser
        def cached_grammar_json = Grammar::Parser.cached_grammar_json
        def cached_schema_grammar_json = Grammar::Parser.cached_schema_grammar_json
        def parse_native(source) = Grammar::Parser.parse_native(source)
        def clear_parser_cache = Grammar::Parser.clear_parser_cache
      end

      # UTF-8 BOM byte sequence (EF BB BF). Some editors prepend this
      # to EXPRESS files; the parser fails because SCHEMA isn't at byte 0.
      def self.strip_bom(source)
        bytes = source.b
        return source unless bytes.bytesize >= 3 &&
          bytes.getbyte(0) == 0xEF &&
          bytes.getbyte(1) == 0xBB &&
          bytes.getbyte(2) == 0xBF

        bytes.byteslice(3..).force_encoding(source.encoding)
      end
      private_class_method :strip_bom

      # Parses Express file into an Express model.
      # @param file [String] Express file path
      # @param skip_references [Boolean] skip resolving references
      # @param include_source [Boolean] attach original source code to model elements
      # @param use_native [Boolean] use native parser (default: true when available)
      # @return [Model::ExpFile] ExpFile containing parsed schemas
      # @raise [Error::SchemaParseFailure] if the schema file fails to parse
      def self.from_file(file, skip_references: nil, include_source: nil,
                         root_path: nil, use_native: nil) # rubocop:disable Metrics/AbcSize
        Expressir::Benchmark.measure_file(file) do
          source = strip_bom(File.read(file))

          schema_file = root_path ? Pathname.new(file.to_s).relative_path_from(root_path).to_s : file.to_s

          use_native = Grammar::Parser.native_available? if use_native.nil?

          begin
            ast = if use_native && Grammar::Parser.native_available?
                    begin
                      Grammar::Parser.parse_native(source)
                    rescue StandardError
                      Grammar::Parser.cached_parser.parse source
                    end
                  else
                    Grammar::Parser.cached_parser.parse source
                  end
          rescue Parsanol::ParseFailed => e
            raise Error::SchemaParseFailure.new(schema_file, e)
          end

          exp_file = ::Expressir::Express::Builder.build_with_remarks(ast, source: source,
                                                                           include_source: include_source)

          exp_file.path = schema_file
          exp_file.schemas.each do |schema|
            schema.file = schema_file
            schema.file_basename = File.basename(schema_file, ".exp")
          end

          unless skip_references
            Expressir::Benchmark.measure_references do
              ResolveReferencesModelVisitor.new.visit(exp_file)
            end
          end

          exp_file
        end
      end

      # Parses Express files into an Express model.
      # @param files [Array<String>] Express file paths
      # @param skip_references [Boolean] skip resolving references
      # @param include_source [Boolean] attach original source code to model elements
      # @param use_native [Boolean] use native parser (default: true when available)
      # @yield [filename, schemas, error] Optional block called for each file
      # @return [Model::Repository] Repository containing all parsed ExpFiles
      def self.from_files(files, skip_references: nil, include_source: nil,
root_path: nil, use_native: nil)
        all_exp_files = []

        files.each do |file|
          exp_file = from_file(file, skip_references: true,
                                     root_path: root_path, use_native: use_native)
          all_exp_files << exp_file

          yield(file, exp_file&.schemas, nil) if block_given?
        rescue StandardError => e
          yield(file, nil, e) if block_given?
          raise unless e.is_a?(Error::SchemaParseFailure)
        end

        repository = Model::Repository.new(files: all_exp_files)

        unless skip_references
          Expressir::Benchmark.measure_references do
            ResolveReferencesModelVisitor.new.visit(repository)
          end
        end

        repository
      end

      # Parses Express content string into an Express model.
      # @param content [String] EXPRESS source code
      # @param skip_references [Boolean] skip resolving references
      # @param include_source [Boolean] attach original source code to model elements
      # @param use_native [Boolean] use native parser (default: true when available)
      # @param use_streaming [Boolean] use streaming builder for maximum performance
      # @return [Model::ExpFile] Parsed ExpFile
      # @raise [Error::SchemaParseFailure] if the content fails to parse
      def self.from_exp(content, skip_references: nil, include_source: nil,
                         use_native: nil, use_streaming: false)
        content = strip_bom(content)
        if use_streaming && Grammar::Parser.native_available? && defined?(Parsanol::Native.parse_with_builder)
          return from_exp_streaming(content, skip_references: skip_references,
                                             include_source: include_source)
        end

        use_native = Grammar::Parser.native_available? if use_native.nil?

        begin
          ast = if use_native && Grammar::Parser.native_available?
                  Grammar::Parser.parse_native(content)
                else
                  Grammar::Parser.cached_parser.parse(content)
                end
        rescue Parsanol::ParseFailed, StandardError => e
          raise Error::SchemaParseFailure.new("(from string)", e)
        end

        exp_file = ::Expressir::Express::Builder.build_with_remarks(ast,
                                                                    source: content,
                                                                    include_source: include_source)

        exp_file.schemas.each do |schema|
          schema.file = nil
          schema.file_basename = nil
        end

        unless skip_references
          Expressir::Benchmark.measure_references do
            ResolveReferencesModelVisitor.new.visit(exp_file)
          end
        end

        exp_file
      end

      # Parse using streaming builder (construct-by-construct).
      # @param content [String] EXPRESS source code
      # @param skip_references [Boolean] skip resolving references
      # @param include_source [Boolean] attach original source code to model elements
      # @return [Model::ExpFile] Parsed ExpFile
      # @raise [Error::SchemaParseFailure] if the content fails to parse
      def self.from_exp_streaming_builder(content, skip_references: nil,
include_source: nil)
        grammar_json = Grammar::Parser.cached_grammar_json
        builder = ::Expressir::Express::StreamingBuilder.new(source: content,
                                                             include_source: include_source)

        begin
          exp_file = Parsanol::Native.parse_with_builder(grammar_json,
                                                         content, builder)
        rescue StandardError => e
          raise Error::SchemaParseFailure.new("(streaming)", e)
        end

        exp_file.schemas.each do |schema|
          schema.file = nil
          schema.file_basename = nil
        end

        unless skip_references
          Expressir::Benchmark.measure_references do
            ResolveReferencesModelVisitor.new.visit(exp_file)
          end
        end

        exp_file
      end

      # Parse each schema separately with fresh arena (memory-bounded).
      #
      # Splits source into schema blocks via {SchemaBlockScanner} and parses
      # each independently. Memory is bounded by the largest schema, not the
      # entire file.
      #
      # @param content [String] EXPRESS source code
      # @param skip_references [Boolean] skip resolving references
      # @param include_source [Boolean] attach original source code to model elements
      # @return [Model::ExpFile] Parsed ExpFile
      def self.from_exp_streaming(content, skip_references: nil,
include_source: nil)
        grammar_json = Grammar::Parser.cached_schema_grammar_json

        schema_blocks = SchemaBlockScanner.extract_schema_blocks(content)

        schemas = schema_blocks.map do |block|
          ast = Parsanol::Native.parse_fresh(grammar_json, block[:source])
          schema_model = Builder.build(ast)
          schema_model.source = block[:source]
          schema_model
        rescue StandardError => e
          raise Error::SchemaParseFailure.new(
            "(schema #{block[:name] || 'unknown'})", e
          )
        end

        exp_file = Expressir::Model::ExpFile.new
        exp_file.schemas = schemas

        exp_file.schemas.each do |schema|
          schema.file = nil
          schema.file_basename = nil
        end

        unless skip_references
          Expressir::Benchmark.measure_references do
            ResolveReferencesModelVisitor.new.visit(exp_file)
          end
        end

        exp_file
      end

      private_class_method :from_exp_streaming
    end
  end
end
