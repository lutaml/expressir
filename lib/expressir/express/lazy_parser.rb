# frozen_string_literal: true

require "parsanol"
require "parsanol/native"

module Expressir
  module Express
    # Lazy parser that tokenizes first, then parses on demand
    #
    # This approach provides:
    # - Fast initial load (lexer only, ~3ms for 700 lines)
    # - Lazy parsing of schema content
    # - Ability to skip function bodies if not needed
    #
    # Performance comparison (geometry_schema.exp, 733 lines):
    # - Full PEG parse: ~460 ms
    # - Lexer only: ~3 ms
    # - Lexer + scan: ~4 ms
    #
    class LazyParser
      # Tokenize EXPRESS source code
      # @param source [String] EXPRESS source code
      # @return [Array<Hash>] Array of tokens with location info
      def self.tokenize(source)
        if defined?(Parsanol::Native) && Parsanol::Native.method_defined?(:tokenize_express)
          Parsanol::Native.tokenize_express(source)
        else
          raise "Native lexer not available"
        end
      end

      # Quick scan to find schema boundaries and top-level declarations
      # @param tokens [Array<Hash>] Token array from lexer
      # @return [Array<Hash>] Schema metadata with token ranges
      def self.scan_schemas(tokens)
        schemas = []
        i = 0

        while i < tokens.length
          token = tokens[i]

          # Look for SCHEMA keyword
          if token["type"] == "keyword" && token["value"] == "SCHEMA"
            schema_start = i

            # Get schema ID
            i += 1
            schema_id = nil
            if tokens[i] && tokens[i]["type"] == "identifier"
              schema_id = tokens[i]["value"]
              i += 1
            end

            # Skip optional version string
            if tokens[i] && tokens[i]["type"] == "string"
              i += 1
            end

            # Skip to semicolon
            while i < tokens.length && !(tokens[i]["type"] == "delimiter" && tokens[i]["value"] == ";")
              i += 1
            end
            i += 1 # Skip semicolon

            # Find END_SCHEMA
            depth = 1
            schema_body_start = i
            declarations = []

            while i < tokens.length && depth.positive?
              t = tokens[i]

              if t["type"] == "keyword"
                case t["value"]
                when "SCHEMA"
                  depth += 1
                when "END_SCHEMA"
                  depth -= 1
                  schema_end = i if depth.zero?
                # Track top-level declarations
                when "ENTITY", "TYPE", "FUNCTION", "PROCEDURE", "RULE", "SUBTYPE_CONSTRAINT", "CONSTANT"
                  if depth == 1
                    decl_start = i
                    decl_type = t["value"]

                    # Get declaration ID
                    decl_id = nil
                    if tokens[i + 1] && tokens[i + 1]["type"] == "identifier"
                      decl_id = tokens[i + 1]["value"]
                    end

                    declarations << {
                      "type" => decl_type.downcase,
                      "id" => decl_id,
                      "start" => decl_start,
                    }
                  end
                end
              end

              i += 1
            end

            # Update declaration end positions
            declarations.each_with_index do |decl, idx|
              decl["end"] = if idx + 1 < declarations.length
                              declarations[idx + 1]["start"] - 1
                            else
                              schema_end - 1
                            end
            end

            schemas << {
              "id" => schema_id,
              "start" => schema_start,
              "end" => schema_end,
              "body_start" => schema_body_start,
              "declarations" => declarations,
            }
          end

          i += 1
        end

        schemas
      end

      # Quick parse - just get schema headers and declaration list
      # This is the fastest option for getting schema structure
      # @param source [String] EXPRESS source code
      # @return [Hash] Schema structure without full model
      def self.quick_parse(source)
        tokens = tokenize(source)
        scan_schemas(tokens)
      end

      # Parse EXPRESS source, optionally skipping function/procedure bodies
      # @param source [String] EXPRESS source code
      # @param options [Hash] Options for parsing
      # @option options [Boolean] :skip_bodies Skip function/procedure bodies
      # @option options [Boolean] :include_source Include source code in model
      # @return [Model::Repository, Hash] Parsed repository or structure hash
      def self.parse(source, skip_bodies: false, include_source: false)
        if skip_bodies
          # Return just the structure without building full model
          tokens = tokenize(source)
          scan_schemas(tokens)
        else
          # Fall back to full parsing
          require_relative "parser"
          Parser.from_exp(source, include_source: include_source)
        end
      end

      # Parse a specific declaration from the token stream
      # This is useful for lazy parsing - parse only what you need
      # @param source [String] EXPRESS source code
      # @param tokens [Array<Hash>] Token array from lexer
      # @param decl_info [Hash] Declaration info from scan_schemas
      # @return [Model::Declarations::*] Parsed declaration
      def self.parse_declaration(source, tokens, decl_info)
        require_relative "parser"

        # Extract source for this declaration
        start_offset = tokens[decl_info["start"]]["location"]["offset"]
        end_offset = tokens[decl_info["end"]]["location"]["offset"]
        decl_source = source[start_offset..end_offset]

        # Parse just this declaration
        # Note: This is a simplified approach - may need context from schema
        Parser.from_exp(decl_source)
      end
    end
  end
end
