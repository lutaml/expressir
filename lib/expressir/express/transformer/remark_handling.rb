# frozen_string_literal: true

require "parsanol"
require "set"

module Expressir
  module Express
    # Handles remark extraction and attachment for the Transformer.
    # Works with the AST directly, without needing Ctx objects.
    module RemarkHandling
      extend self

      # Extract all remarks from the AST with their tags and source positions.
      # @param ast [Hash] The AST from Parsanol parser
      # @param source [String] The original source code
      # @return [Array<Hash>] Array of remark info hashes
      def extract_remarks(ast, source)
        remarks = []

        # Extract embedded remarks (*...*)
        extract_embedded_remarks(ast, source, remarks)

        # Extract tail remarks (--...)
        extract_tail_remarks(ast, source, remarks)

        remarks
      end

      # Attach remarks to model elements based on their tagged paths.
      # @param model [Model::ModelElement] The root model element
      # @param remarks [Array<Hash>] The extracted remarks
      def attach_remarks(model, remarks)
        # Group remarks by their tag
        tagged_remarks, untagged_remarks = remarks.partition { |r| r[:tag] }

        # Process tagged remarks
        tagged_remarks.each do |remark|
          target = find_by_path(model, remark[:tag])
          if target
            add_remark(target, remark[:text])
          end
        end

        # Process untagged remarks (attach based on position)
        attach_untagged_remarks(model, untagged_remarks)
      end

      private

      def extract_embedded_remarks(ast, source, remarks, depth = 0)
        return if depth > 50 # Prevent infinite recursion

        case ast
        when Hash
          ast.each do |key, value|
            if key == :embeddedRemark
              extract_single_embedded_remark(value, source, remarks)
            else
              extract_embedded_remarks(value, source, remarks, depth + 1)
            end
          end
        when Array
          ast.each do |item|
            extract_embedded_remarks(item, source, remarks, depth + 1)
          end
        end
      end

      def extract_single_embedded_remark(data, source, remarks)
        return unless data

        # Find the slice to get position
        slice = find_slice(data)
        return unless slice

        # Extract content from the source
        content = source[slice.offset...(slice.offset + slice.length)]
        return unless content

        # Remove (* and *) delimiters
        if content =~ /^\(\*(.*?)\*\)$/m
          inner_content = $1.strip
          tag, text = parse_tagged_content(inner_content)

          remarks << {
            position: slice.offset,
            tag: tag,
            text: text,
            format: :embedded,
          }
        end
      end

      def extract_tail_remarks(ast, source, remarks, depth = 0)
        return if depth > 50

        case ast
        when Hash
          ast.each do |key, value|
            if key == :tailRemark
              extract_single_tail_remark(value, source, remarks)
            else
              extract_tail_remarks(value, source, remarks, depth + 1)
            end
          end
        when Array
          ast.each do |item|
            extract_tail_remarks(item, source, remarks, depth + 1)
          end
        end
      end

      def extract_single_tail_remark(data, source, remarks)
        return unless data

        # Find the slice to get position
        slice = find_slice(data)
        return unless slice

        # Extract content from the source
        content = source[slice.offset...(slice.offset + slice.length)]
        return unless content

        # Remove -- prefix and any trailing newline
        if content =~ /^--\s*(.*?)(?:\n|$)/m
          remark_text = $1.strip
          tag, text = parse_tagged_content(remark_text)

          remarks << {
            position: slice.offset,
            tag: tag,
            text: text,
            format: :tail,
          }
        end
      end

      def find_slice(data, depth = 0)
        return nil if depth > 10

        case data
        when Hash
          data.each_value do |value|
            return value if value.is_a?(Parsanol::Slice)

            result = find_slice(value, depth + 1)
            return result if result
          end
        when Array
          data.each do |item|
            result = find_slice(item, depth + 1)
            return result if result
          end
        end
        nil
      end

      def parse_tagged_content(content)
        if content =~ /^"([^"]+)"\s*(.*)$/m
          [$1, $2.strip]
        else
          [nil, content.strip]
        end
      end

      def find_by_path(model, path)
        return nil unless path
        return nil unless model.is_a?(Model::ModelElement)

        # Handle paths with colons (like "wr:WR1" for where rules)
        normalized_path = path.gsub(":", ".")

        begin
          model.find(normalized_path)
        rescue StandardError
          nil
        end
      end

      def add_remark(node, text)
        return unless node
        return unless node.is_a?(Model::ModelElement)

        node.remarks ||= []
        node.remarks << text
      end

      def attach_untagged_remarks(model, remarks)
        # For untagged remarks, we need to find nearby nodes
        # This is more complex and may require source position tracking
        # For now, skip untagged remarks as they are less common
      end
    end
  end
end
