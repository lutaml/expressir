module Expressir
  module Model
    # Represents a remark with its format and optional tag
    # Supports both tail remarks (-- ...) and embedded remarks ((* ... *))
    # Can include optional tags for associating remarks with specific items
    class RemarkInfo < Lutaml::Model::Serializable
      attribute :text, :string
      attribute :format, :string      # 'tail' or 'embedded'
      attribute :tag, :string          # optional remark tag like "entity.attr"

      # Initialize a new RemarkInfo
      # @param text [String] The remark text content
      # @param format [String] The format type: 'tail' or 'embedded'
      # @param tag [String, nil] Optional tag for associating remark with item
      def initialize(text: nil, format: 'embedded', tag: nil, **options)
        super(text: text, format: format, tag: tag, **options)
      end

      # Check if this is a tail remark
      # @return [Boolean] True if format is 'tail'
      def tail?
        format == 'tail'
      end

      # Check if this is an embedded remark
      # @return [Boolean] True if format is 'embedded'
      def embedded?
        format == 'embedded'
      end

      # Check if this remark has a tag
      # @return [Boolean] True if tag is present
      def tagged?
        !tag.nil? && !tag.empty?
      end

      # For backward compatibility with string-based remarks
      # @return [String] The remark text
      def to_s
        text.to_s
      end

      # YAML serialization
      yaml do
        map 'text', to: :text
        map 'format', to: :format
        map 'tag', to: :tag
      end

      # XML serialization
      xml do
        root 'remark_info'
        map_element 'text', to: :text
        map_element 'format', to: :format
        map_element 'tag', to: :tag
      end
    end
  end
end
