# frozen_string_literal: true

module Expressir
  module Express
    module Builders
      # Builds syntax (top-level) nodes into ExpFile objects.
      # Each parsed EXPRESS file is represented as an ExpFile containing schemas.
      class SyntaxBuilder
        # Build ExpFile from AST data
        # @param ast_data [Hash, Array] The parsed AST with syntax node
        #   - Ruby parser: Hash with :schema_decl key
        #   - Native parser: Hash with :syntax wrapper containing :schemaDecl
        # @return [Model::ExpFile] ExpFile containing the parsed schemas
        def call(ast_data)
          # Handle both formats:
          # - Ruby parser: ast_data is a merged Hash {:schema_decl => [...], :spaces => {...}}
          # - Native parser: ast_data is {:syntax => {:spaces, :schemaDecl => [...], :trailer}}
          schema_decl_data = extract_schema_decls(ast_data)

          schemas = Builder.build_children(schema_decl_data)
          Expressir::Model::ExpFile.new(schemas: schemas.compact)
        end

        private

        # Extract schema declarations from AST data.
        # Handles both Ruby (snake_case) and native (camelCase) formats.
        def extract_schema_decls(ast_data)
          if ast_data.is_a?(Hash)
            # Check for :syntax wrapper (native parser format)
            if ast_data.key?(:syntax)
              inner = ast_data[:syntax]
              return inner[:schemaDecl] || inner[:schema_decl] if inner.is_a?(Hash)
            end

            # Ruby parser format: snake_case
            return ast_data[:schema_decl] if ast_data.key?(:schema_decl)

            # Native parser format: camelCase at top level (legacy)
            return ast_data[:schemaDecl] if ast_data.key?(:schemaDecl)
          elsif ast_data.is_a?(Array)
            # Legacy native parser format: Array of Hashes
            merged = {}
            ast_data.each do |item|
              if item.is_a?(Hash)
                item.each do |_key, value|
                  if value.is_a?(Array)
                    value.each do |sub|
                      if sub.is_a?(Hash)
                        sub.each do |k, v|
                          snake_key = k.to_s
                            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                            .downcase
                            .to_sym
                          merged[snake_key] ||= []
                          merged[snake_key] = v if v.is_a?(Array)
                        end
                      end
                    end
                  end
                end
              end
            end
            return merged[:schema_decl]
          end
          nil
        end
      end
    end
  end
end
