module Expressir
  module Model
    module Identifier
      # @!attribute id
      #   @return [::String]
      # @!attribute remarks
      #   @return [::Array<::String>]
      # @!attribute remark_items
      #   @return [::Array<RemarkItem>]
      # @!attribute source
      #   @return [::String]
      # @!visibility private
      def self.included(mod)
        mod.model_attr_accessor :id, '::String'
        mod.model_attr_accessor :remarks, '::Array<::String>'
        mod.model_attr_accessor :remark_items, '::Array<RemarkItem>'
        mod.model_attr_accessor :source, '::String'
      end

      # @param [Hash] options
      # @option options [::String] :id
      # @option options [::Array<::String>] :remarks
      # @option options [::Array<RemarkItem>] :remark_items
      # @option options [::String] :source
      # @!visibility private
      def initialize_identifier(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]
      end
    end
  end
end