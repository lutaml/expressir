module Expressir
  module Model
    class Cache < ModelElement
      attr_accessor :version
      attr_accessor :content

      def initialize(options = {})
        @version = options[:version]
        @content = options[:content]
      end
    end
  end
end