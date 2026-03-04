# frozen_string_literal: true

require_relative "error"
require_relative "builder"

module Expressir
  module Express
    # Streaming builder that receives parse events from Parsanol native parser.
    #
    # This builder implements the Parsanol::BuilderCallbacks interface and
    # reconstructs the AST from streaming events, then uses the existing
    # Builder to convert to Model objects.
    #
    # The key insight is that when a value starts (HASH_START, ARRAY_START),
    # we must FIRST add it to the parent with the pending key, THEN push it
    # to the stack so nested values are added to the correct container.
    #
    class StreamingBuilder
      # Include Parsanol callbacks if available
      if defined?(Parsanol::BuilderCallbacks)
        include Parsanol::BuilderCallbacks
      end

      # @return [String, nil] Original source code for position tracking
      attr_accessor :source

      # @return [Boolean] Whether to include source in model elements
      attr_reader :include_source

      # Initialize the streaming builder
      #
      # @param source [String, nil] Original source code
      # @param include_source [Boolean] Whether to include source in model elements
      def initialize(source: nil, include_source: nil)
        @source = source
        @include_source = include_source
        @stack = [] # Stack of containers (Hash or Array)
        @pending_key = nil
        @final_ast = nil
      end

      # Called when parsing starts
      #
      # @param input [String] The input being parsed
      def on_start(input)
        @on_start ||= input
      end

      # Called when parsing succeeds
      def on_success
        # Parsing completed
      end

      # Called when parsing fails
      #
      # @param message [String] The error message
      def on_error(message)
        raise Error::SchemaParseFailure.new("(streaming)", message)
      end

      # Called when a string value is matched
      #
      # @param value [String] The matched string value
      # @param offset [Integer] Byte offset
      # @param length [Integer] Length
      def on_string(value, _offset, _length)
        add_value_to_current_container(value)
      end

      # Called when an integer value is matched
      #
      # @param value [Integer] The matched integer value
      def on_int(value)
        add_value_to_current_container(value)
      end

      # Called when a float value is matched
      #
      # @param value [Float] The matched float value
      def on_float(value)
        add_value_to_current_container(value)
      end

      # Called when a boolean value is matched
      #
      # @param value [Boolean] The matched boolean value
      def on_bool(value)
        add_value_to_current_container(value)
      end

      # Called when a nil/null value is matched
      def on_nil
        add_value_to_current_container(nil)
      end

      # Called when starting to parse a hash/object
      #
      # @param size [Integer, nil] Expected number of entries
      def on_hash_start(_size = nil)
        new_hash = {}

        # First add this hash to the parent (if any) with the pending key
        if @stack.any?
          add_value_to_current_container(new_hash)
        end

        # Then push to stack so nested values go into this hash
        @stack.push(new_hash)
        # Clear pending key - we're starting a new hash context
        @pending_key = nil
      end

      # Called when a hash key is encountered
      #
      # @param key [String] The hash key name
      def on_hash_key(key)
        # Convert string key to symbol to match existing parser AST format
        puts "DEBUG on_hash_key: #{key.inspect} (#{key.class})" if ENV["DEBUG_STREAMING"]
        @pending_key = key.to_sym
      end

      # Called when a hash value is about to be parsed
      #
      # @param key [String] The hash key name
      def on_hash_value(key)
        puts "DEBUG on_hash_value: #{key.inspect} (#{key.class})" if ENV["DEBUG_STREAMING"]
        @pending_key = nil
      end

      # Called when finishing parsing a hash/object
      #
      # @param size [Integer] Actual number of entries
      def on_hash_end(_size)
        return if @stack.empty?

        finished_hash = @stack.pop

        if @stack.empty?
          # This is the top-level hash, save it as final AST
          @final_ast = finished_hash
        end
        # If there's a parent, the hash was already added in on_hash_start
      end

      # Called when starting to parse an array
      #
      # @param size [Integer, nil] Expected number of elements
      def on_array_start(_size = nil)
        new_array = []

        # First add this array to the parent (if any) with the pending key
        if @stack.any?
          add_value_to_current_container(new_array)
        end

        # Then push to stack
        @stack.push(new_array)
        # Clear pending key - we're starting a new array context
        @pending_key = nil
      end

      # Called when an array element is about to be parsed
      #
      # @param index [Integer] The index of the element
      def on_array_element(index)
        # Element processed - no action needed
      end

      # Called when finishing parsing an array
      #
      # @param size [Integer] Actual number of elements
      def on_array_end(_size)
        return if @stack.empty?

        finished_array = @stack.pop

        if @stack.empty?
          # Top-level array, save as final AST
          @final_ast = finished_array
        end
        # If there's a parent, the array was already added in on_array_start
      end

      # Called when starting to parse a named rule
      #
      # @param name [String] The rule name
      def on_named_start(name)
        # Named captures are handled via hash wrapping - no action needed
      end

      # Called when finishing parsing a named rule
      #
      # @param name [String] The rule name
      def on_named_end(name)
        # Named captures are handled via hash wrapping - no action needed
      end

      # Called when parsing is complete. Returns the built Repository.
      #
      # @return [Model::Repository, nil] The final result
      def finish
        return nil unless @final_ast

        # Convert Parsanol native AST format to Builder-compatible format
        # Parsanol native: {"key" => [{:a => ...}, {:b => ...}]}  (Array of single-key hashes)
        # Builder:  {:key => {:a => ..., :b => ...}}       (Hash with multiple keys)
        converted_ast = convert_ast_format(@final_ast)

        # Pass to the existing Builder
        Builder.build_with_remarks(converted_ast, source: @source,
                                                  include_source: @include_source)
      end

      private

      # Process a hash, concatenating :str and :spaces arrays
      # This is called after merging single-key hashes
      def process_str_and_spaces(hash)
        result = {}
        hash.each do |key, value|
          result[key] = if %i[str spaces].include?(key) && value.is_a?(Array)
                          value.compact.join
                        else
                          value
                        end
        end
        result
      end

      # Convert Parsanol native AST format to Builder-compatible format
      #
      # Parsanol native represents:
      # - Sequences as arrays of single-key hashes: [{:a => 1}, {:b => 2}, []]
      # - Strings as arrays of characters: {:str => ["a", "b", "c", nil]}
      # - Spaces as arrays of whitespace: {:spaces => [" ", "\\n"]}
      #
      # Builder expects:
      # - Sequences as hashes with multiple keys: {:a => 1, :b => 2}
      # - Strings as concatenated strings: {:str => "abc"}
      # - Spaces as concatenated strings: {:spaces => " "}
      #
      # @param obj [Object] The AST node to convert
      # @return [Object] The converted AST
      def convert_ast_format(obj)
        case obj
        when Hash
          return obj if obj.empty?

          # Process each key-value pair
          result = {}
          obj.each do |key, value|
            # Check if this is a str or spaces key with an array value
            result[key] = if %i[str spaces].include?(key) && value.is_a?(Array)
                            # Concatenate character arrays
                            value.compact.join
                          else
                            # Recursively convert the value
                            convert_ast_format(value)
                          end
          end
          result
        when Array
          return obj if obj.empty?

          # First, convert each element
          converted_items = obj.map { |item| convert_ast_format(item) }

          # Flatten nested arrays that come from grammar repetition (.repeat)
          # These appear as arrays containing arrays (which may contain hashes)
          # This handles the case where (op_comma >> item).repeat produces [[{...}, {...}], [{...}, {...}]]
          # After inner conversion, this becomes [{multi-key hash}, {multi-key hash}]
          # which should be flattened into the parent array
          flattened_items = []
          converted_items.each do |item|
            if item.is_a?(Array)
              # Flatten this array into the parent
              flattened_items.concat(item)
            else
              flattened_items << item
            end
          end
          converted_items = flattened_items

          # Check if this is an array of hashes (Parsanol sequence format)
          # that should be merged into a single hash.
          # Empty arrays and nil values are treated as nil/absent optional elements
          non_empty_items = converted_items.reject do |item|
            item.nil? || (item.is_a?(Array) && item.empty?)
          end

          if non_empty_items.empty?
            # All items were nil or empty - return empty hash (sequence with all optionals absent)
            {}
          elsif non_empty_items.all?(Hash)
            # Check if this is a repetition pattern where all hashes have the SAME single key
            first_keys = non_empty_items.first.keys

            if first_keys.length == 1 &&
                non_empty_items.length > 1 &&
                non_empty_items.all? do |item|
                  item.keys.length == 1 && item.keys.first == first_keys.first
                end
              # Multiple items with the same single key - this is a repetition pattern
              # Keep as array (each element is already a single-key hash)
              return converted_items
            end

            # Check if any key appears in MULTIPLE hashes (repetition with separators pattern)
            # Example: [{formalParameter: {...}}, {op_delim: {...}}, {formalParameter: {...}}]
            # In this case, formalParameter appears in two different hashes
            all_keys = non_empty_items.flat_map(&:keys)
            key_counts = all_keys.tally
            if key_counts.any? { |_, count| count > 1 }
              # At least one key appears multiple times - this is a repetition pattern
              # Keep as array
              return converted_items
            end

            # Check if we have a repetition pattern that needs unzipping
            # Pattern: [{item: first}, {separator: [...], item: [rest...]}]
            # This happens when Parsanol groups repeated elements

            # More specific detection:
            # 1. First item has a single key with a non-array value
            # 2. A later item has the SAME key with an array value (the grouped repetitions)
            # 3. The later item also has a "separator" key (like op_comma)

            if non_empty_items.length >= 2
              first_item = non_empty_items[0]
              later_items = non_empty_items[1..]

              # Check if first item is simple (single key, non-array value)
              if first_item.keys.length == 1 && !first_item.values.first.is_a?(Array)
                first_key = first_item.keys.first

                # Look for a later item that:
                # 1. Has the same key as the first item
                # 2. That key has an array value with length > 1
                # 3. Also has at least one other key (the separator)
                repetition_item = later_items.find do |item|
                  item.key?(first_key) &&
                    item[first_key].is_a?(Array) &&
                    item[first_key].length > 1 &&
                    item.keys.length >= 2
                end

                if repetition_item
                  # This is a repetition pattern - unzip it
                  # Build interleaved result
                  result = [first_item]

                  later_items.each do |item|
                    # Find keys with array values
                    array_keys = item.select do |_, v|
                      v.is_a?(Array) && v.length > 1
                    end.keys

                    if array_keys.empty?
                      # No array values - add as-is
                      result << item
                    elsif array_keys.length == 1
                      # Single array key - expand it
                      key = array_keys.first
                      values = item[key]
                      other_keys = item.keys - [key]

                      values.each_with_index do |val, _idx|
                        new_item = { key => val }
                        other_keys.each do |ok|
                          new_item[ok] = item[ok]
                        end
                        result << new_item
                      end
                    else
                      # Multiple array keys - interleave them
                      # All arrays should have the same length
                      len = array_keys.map { |k| item[k].length }.max
                      other_keys = item.keys - array_keys

                      len.times do |idx|
                        new_item = {}
                        array_keys.each do |k|
                          values = item[k]
                          new_item[k] = values[idx] if idx < values.length
                        end
                        other_keys.each do |ok|
                          new_item[ok] = item[ok]
                        end
                        result << new_item
                      end
                    end
                  end

                  return result
                end
              end
            end

            # No repetition pattern detected - merge all hashes into one hash
            # This handles sequences like: tENUMERATION >> tOF >> enumerationItems
            # which produce: [{tENUMERATION: ...}, {tOF: ..., enumerationItems: ...}]
            merged = {}
            non_empty_items.each do |item|
              item.each do |key, value|
                # If key already exists, convert to array or append
                if merged.key?(key)
                  existing = merged[key]
                  if existing.is_a?(Array)
                    if value.is_a?(Array)
                      existing.concat(value)
                    else
                      existing << value
                    end
                  else
                    merged[key] = [existing, value]
                  end
                else
                  merged[key] = value
                end
              end
            end

            # Process the merged hash for :str/:spaces concatenation
            process_str_and_spaces(merged)
          else
            # Regular array - return the converted items
            converted_items
          end
        else
          obj
        end
      end

      # Add a value to the current container on top of the stack
      #
      # @param value The value to add
      def add_value_to_current_container(value)
        return if @stack.empty?

        container = @stack.last

        if container.is_a?(Hash)
          if @pending_key
            container[@pending_key] = value
          end
        elsif container.is_a?(Array)
          container << value
        else
          # This handles unexpected container types (debugging)
          if ENV["DEBUG_STREAMING"]
            puts "DEBUG: Unknown container type: #{container.class}"
            puts "  Container value: #{container.inspect[0..200]}"
            puts "  Pending key: #{@pending_key.inspect}"
            puts "  Stack depth: #{@stack.length}"
            puts "  Stack: #{@stack.map(&:class).inspect}"
          end
          raise "Unexpected container type: #{container.class}"
        end
      end

      # Get the final AST (for debugging)
      def final_ast
        @final_ast
      end
    end
  end
end
