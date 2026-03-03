# frozen_string_literal: true

require_relative "error"

module Expressir
  module Express
    # Builder registry for AST node type handlers.
    # Each builder is a callable object that transforms AST data into Model objects.
    # This is the ONLY way to build models from AST - no Transformer fallback.
    module Builder
      class << self
        attr_reader :source, :include_source

        # Cache for snake_case conversions
        SNAKE_CASE_CACHE = {} # rubocop:disable Style/MutableConstant

        # Register a builder for a node type.
        # @param node_type [Symbol] The AST node type
        # @param builder [#call] Optional callable that takes (ast_data)
        # @yield Block that takes (ast_data) if builder not provided
        def register(node_type, builder = nil, &block)
          @register ||= {}
          @register[node_type] = builder || block
        end

        # Build a Model object from AST data.
        # @param ast [Hash] The AST with node type as key
        # @param source [String, nil] The original source code
        # @param include_source [Boolean, nil] Whether to include source
        # @return [Model::ModelElement] The built model object
        def build(ast, source: nil, include_source: nil)
          return nil unless ast

          @source = source
          @include_source = include_source

          # Optimized: Hash is 90%+ of cases, check it first
          case ast
          when Hash
            node_type = ast.keys.first
            node_data = ast[node_type]

            handler_key = cached_snake_case(node_type)
            snake_data = fast_convert_keys(node_data)

            builder = @register[handler_key]
            raise Error::UnknownNodeTypeError, node_type unless builder

            result = builder.call(snake_data)

            if @include_source && result.respond_to?(:source=)
              source_info = extract_source_info(node_data)
              result.source = source_info if source_info
            end

            result
          when Array
            ast.map do |item|
              build(item, source: source, include_source: include_source)
            end
          when Parslet::Slice
            ast.to_s
          else
            ast
          end
        end

        # Build with remark attachment
        def build_with_remarks(ast, source: nil, include_source: nil)
          result = build(ast, source: source, include_source: include_source)

          if source && result
            attacher = RemarkAttacher.new(source)
            attacher.attach(result)
          end

          result
        end

        # Check if a builder is registered for a node type.
        def registered?(node_type)
          @register&.key?(node_type)
        end

        # Get all registered node types.
        def registered_types
          @register&.keys || []
        end

        # Build optional (returns nil if ast is nil)
        def build_optional(ast)
          return nil unless ast

          build(ast)
        end

        # Build children (array of AST nodes)
        # Optimized to avoid intermediate array allocations
        def build_children(ast_array)
          return [] unless ast_array

          # Handle single element (common case)
          unless ast_array.is_a?(Array)
            return ast_array.nil? ? [] : [build(ast_array)].compact
          end

          # Build result in single pass, avoiding flatten/compact/map chain
          result = []
          ast_array.each do |item|
            next if item.nil?

            case item
            when Array
              item.each do |sub|
                result << build(sub) unless sub.nil?
              end
            else
              built = build(item)
              result << built if built
            end
          end
          result
        end

        # Fast build methods - call registered builder directly without hash wrapping
        # These are optimized for hot paths in expression building
        # NOTE: These assume data is already snake_case (no key conversion needed)

        # Call a registered builder directly with data (avoids hash wrapper allocation)
        # @param node_type [Symbol] The node type key
        # @param data The data to pass to the builder (already snake_case)
        def build_node(node_type, data)
          builder = @register&.[](node_type)
          raise Error::UnknownNodeTypeError, node_type unless builder

          builder.call(data)
        end

        # Fast path for term nodes
        def build_term(data)
          build_node(:term, data)
        end

        # Fast path for factor nodes
        def build_factor(data)
          build_node(:factor, data)
        end

        # Fast path for simple_factor nodes
        def build_simple_factor(data)
          build_node(:simple_factor, data)
        end

        # Fast path for primary nodes
        def build_primary(data)
          build_node(:primary, data)
        end

        # Fast path for expression nodes
        def build_expression(data)
          build_node(:expression, data)
        end

        # Fast path for simple_expression nodes
        def build_simple_expression(data)
          build_node(:simple_expression, data)
        end

        private

        # Cached snake_case conversion
        def cached_snake_case(name)
          SNAKE_CASE_CACHE[name] ||= begin
            str = name.to_s
            # Check if already snake_case
            if /^[a-z_]+$/.match?(str)
              str.to_sym
            else
              str
                .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                .downcase
                .to_sym
            end
          end
        end

        # Optimized key conversion - returns original object when no conversion needed
        # This avoids unnecessary allocations for AST nodes that don't need key conversion
        def fast_convert_keys(obj)
          case obj
          when Hash
            return obj if obj.empty?

            # First pass: check if any conversion is needed
            keys = obj.keys
            needs_conversion = false
            converted_values = nil

            keys.each do |k|
              key_str = k.to_s
              # Check if key needs conversion (has uppercase)
              if key_str.match?(/[A-Z]/)
                needs_conversion = true
              end

              # Check if value needs conversion
              val = obj[k]
              case val
              when Hash
                next if val.empty?

                converted_val = fast_convert_keys(val)
                if !converted_val.equal?(val) # Identity check - same object?
                  needs_conversion = true
                  converted_values ||= {}
                  converted_values[k] = converted_val
                end
              when Array
                next if val.empty?

                converted_val = fast_convert_keys(val)
                if !converted_val.equal?(val)
                  needs_conversion = true
                  converted_values ||= {}
                  converted_values[k] = converted_val
                end
              end
            end

            # Return original if no conversion needed (zero allocation!)
            return obj unless needs_conversion

            # Build result only when necessary
            result = {}
            keys.each do |k|
              key_str = k.to_s
              new_key = key_str.match?(/[A-Z]/) ? cached_snake_case(k) : k
              new_val = converted_values&.key?(k) ? converted_values[k] : obj[k]
              result[new_key] = new_val
            end
            result
          when Array
            return obj if obj.empty?

            # Check if any element needs conversion
            needs_conversion = false
            result = []

            obj.each do |item|
              case item
              when Hash
                next if item.empty?

                converted = fast_convert_keys(item)
                result << converted
                needs_conversion = true unless converted.equal?(item)
              when Array
                next if item.empty?

                converted = fast_convert_keys(item)
                result << converted
                needs_conversion = true unless converted.equal?(item)
              else
                result << item
              end
            end

            # Return original if no conversion needed
            needs_conversion ? result : obj
          else
            obj
          end
        end

        def to_snake_case(name)
          cached_snake_case(name)
        end

        def convert_keys_to_snake_case(obj)
          fast_convert_keys(obj)
        end

        def extract_source_info(data)
          return nil unless data
          return nil unless @source

          slice = find_slice(data)
          return nil unless slice

          @source[slice.offset...(slice.offset + slice.length)]&.strip
        end

        def find_slice(data, depth = 0)
          return nil if depth > 10

          case data
          when Parslet::Slice
            data
          when Hash
            data.each_value do |value|
              return value if value.is_a?(Parslet::Slice)

              result = find_slice(value, depth + 1)
              return result if result
            end
            nil
          when Array
            data.each do |item|
              result = find_slice(item, depth + 1)
              return result if result
            end
            nil
          end
        end
      end
    end
  end
end

# Top-level alias for convenience in builder files
Builder = Expressir::Express::Builder
