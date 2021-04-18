module Expressir
  module Model
    # Cache content object with Expressir version
    class Cache < ModelElement
      model_attr_accessor :version, 'String'
      model_attr_accessor :content, 'ModelElement'

      # @param [Hash] options
      # @option options [String] :version
      # @option options [ModelElement] :content
      def initialize(options = {})
        @version = options[:version]
        @content = options[:content]
      end
    end
  end
end