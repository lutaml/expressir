# frozen_string_literal: true

module Expressir
  module Express
    # Builder registry for AST node type handlers.
    # Each builder is a callable object that transforms AST data into Model objects.
    # This is the ONLY way to build models from AST - no Transformer fallback.
    module Builder
      class << self
        # Thread-local key under which the current BuilderContext is stored
        # for the duration of a build_with_remarks call. Recursive build
        # calls read source/include_source from here instead of from
        # class-level mutable state.
        CONTEXT_KEY = :expressir_builder_context

        # Marker ivar for fast_convert_keys memoization (see there).
        SNAKED_MARKER = :@_expressir_keys_snaked

        # Returns the BuilderContext for the current thread, or nil if no
        # build is in progress.
        def current_context
          Thread.current[CONTEXT_KEY]
        end

        # Convenience accessors — read from the current context.
        def source
          current_context&.source
        end

        def include_source
          current_context&.include_source
        end

        # Thread-local snake_case conversion cache. Thread-local avoids the
        # mutable-constant anti-pattern while remaining thread-safe.
        # Each thread gets its own cache; the cache grows with the number of
        # unique AST node-type names encountered (bounded by grammar size).
        def snake_case_cache
          Thread.current[:expressir_snake_case_cache] ||= {}
        end

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
        # @return [Model::ModelElement] The built model object
        def build(ast)
          return nil unless ast

          # Optimized: Hash is 90%+ of cases, check it first
          case ast
          when Hash
            node_type = ast.keys.first
            node_data = ast[node_type]

            handler_key = cached_snake_case(node_type)
            snake_data = fast_convert_keys(node_data)

            builder = @register[handler_key]
            if builder
              result = builder.call(snake_data)

              # Fast path: single-key hash or non-nil result
              if !result.nil? || ast.keys.length <= 1
                attach_source_info(result, node_data)
                return result
              end

              # Slow path: first-key builder returned nil in a multi-key
              # hash. Try remaining keys for actual content. This handles
              # grammar patterns like `element >> (op_comma >> element).repeat`
              # which produce {:op_comma => ..., :element => {...}} where
              # the first key is an operator separator.
              # Previously gated by a hand-maintained OPERATOR_TOKENS set;
              # now tries all remaining keys unconditionally (TODO.bugs/21).
              ast.each_key do |key|
                next if key == node_type

                h_key = cached_snake_case(key)
                h_builder = @register[h_key]
                next unless h_builder

                n_data = ast[key]
                s_data = fast_convert_keys(n_data)
                result = h_builder.call(s_data)

                unless result.nil?
                  attach_source_info(result, n_data)
                  return result
                end
              end
            else
              raise Error::UnknownNodeTypeError, node_type
            end
            nil
          when Array
            ast.map do |item|
              build(item)
            end
          when Parsanol::Slice
            ast.to_s
          else
            ast
          end
        end

        # Build with remark attachment.
        #
        # Sets up a BuilderContext as a thread-local for the duration of the
        # build so recursive build calls can read source/include_source via
        # `Builder.source` / `Builder.include_source`. The previous context
        # (if any) is restored on exit so nested builds are reentrant.
        def build_with_remarks(ast, source: nil, include_source: nil)
          # Trigger BuilderRegistry autoload so all AST node type handlers
          # are registered before build() runs. The reference to
          # BuilderRegistry resolves the autoload defined in express.rb.
          BuilderRegistry

          previous = Thread.current[CONTEXT_KEY]
          Thread.current[CONTEXT_KEY] = BuilderContext.new(
            source: source,
            include_source: include_source,
          )

          result = build(ast)

          # Only attach remarks if include_source is explicitly true
          # (nil means use default behavior - attach remarks)
          if source && result && include_source != false
            attacher = RemarkAttacher.new(source)
            attacher.attach(result)
          end

          result
        ensure
          Thread.current[CONTEXT_KEY] = previous
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

        # Normalize a value to an Array for iteration.
        # Handles: nil → [], Parsanol::Slice → [], Array → Array, other → [other]
        def ensure_array(value)
          return [] if value.nil?
          return [] if value.is_a?(Parsanol::Slice)

          value.is_a?(Array) ? value : [value]
        end

        # Build children (array of AST nodes)
        # Optimized to avoid intermediate array allocations
        def build_children(ast_array)
          return [] if ast_array.nil?

          # Handle Parsanol::Slice (empty Slices from optional rules)
          # Convert to empty Array
          if ast_array.is_a?(Parsanol::Slice)
            return []
          end

          # Handle single element (common case)
          unless ast_array.is_a?(Array)
            return [build(ast_array)].compact
          end

          # Build result in single pass, avoiding flatten/compact/map chain
          result = []
          ast_array.each do |item|
            next if item.nil?

            # Empty Slices from optional rules should be treated as empty arrays
            if item.is_a?(Parsanol::Slice)
              next
            end

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

        # Keys containing uppercase need snake-casing; testing the key
        # directly avoids allocating `to_s` strings per key per pass.
        UPPERCASE_PATTERN = /[A-Z]/

        private

        # Cached snake_case conversion
        def cached_snake_case(name)
          snake_case_cache[name] ||= begin
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
        #
        # build() descends into child nodes whose subtrees the parent already
        # scanned, so unchanged containers are marked with an instance
        # variable and skipped on re-visits — without it, every subtree is
        # re-scanned once per ancestor level (~60 fast_convert_keys calls per
        # model node on real schemas). The marker is invisible to equality,
        # hashing, and inspection.
        def mark_snaked(obj)
          obj.instance_variable_set(SNAKED_MARKER, true)
          obj
        rescue FrozenError
          obj
        end

        def fast_convert_keys(obj)
          case obj
          when Hash
            return obj if obj.empty?
            return obj if obj.instance_variable_defined?(SNAKED_MARKER)

            # Single pass: recurse into container values and note which keys
            # need snake-casing, so the common no-conversion case allocates
            # nothing and the conversion case walks the keys once.
            keys = obj.keys
            converted_values = nil
            new_keys = nil

            keys.each_with_index do |k, i|
              val = obj[k]
              case val
              when Hash
                unless val.empty?
                  converted_val = fast_convert_keys(val)
                  (converted_values ||= {})[k] = converted_val unless converted_val.equal?(val)
                end
              when Array
                unless val.empty?
                  converted_val = fast_convert_keys(val)
                  (converted_values ||= {})[k] = converted_val unless converted_val.equal?(val)
                end
              end

              if k.match?(UPPERCASE_PATTERN)
                (new_keys ||= keys.dup)[i] = cached_snake_case(k)
              end
            end

            return mark_snaked(obj) unless new_keys || converted_values

            result = {}
            keys.each_with_index do |k, i|
              key = new_keys&.[](i) || k
              result[key] = converted_values&.key?(k) ? converted_values[k] : obj[k]
            end
            mark_snaked(result)
          when Array
            return obj if obj.empty?
            return obj if obj.instance_variable_defined?(SNAKED_MARKER)

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
            needs_conversion ? mark_snaked(result) : mark_snaked(obj)
          else
            obj
          end
        end

        def extract_source_info(data)
          return nil unless data

          src = source
          return nil unless src

          slice = find_slice(data)
          return nil unless slice

          {
            text: src[slice.offset...(slice.offset + slice.length)]&.strip,
            offset: slice.offset,
          }
        end

        def attach_source_info(result, data)
          return unless source && result.is_a?(Expressir::Model::ModelElement)

          source_info = extract_source_info(data)
          return unless source_info

          result.source_offset = source_info[:offset]
          result.source = source_info[:text] if include_source
        end

        def find_slice(data, depth = 0)
          return nil if depth > 10

          case data
          when Parsanol::Slice
            data
          when Hash
            # Skip 'spaces' key which contains whitespace/comments before content
            # Look for 'str' key first as it usually contains the actual content
            if data.key?(:str) && data[:str].is_a?(Parsanol::Slice)
              return data[:str]
            end

            # Then look in other keys, skipping 'spaces'
            data.each do |key, value|
              next if key == :spaces

              return value if value.is_a?(Parsanol::Slice)

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
