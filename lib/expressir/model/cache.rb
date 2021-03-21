module Expressir
  module Model
    class Cache < ModelElement
      model_attr_accessor :version
      model_attr_accessor :content

      def initialize(options = {})
        @version = options[:version]
        @content = options[:content]
      end
    end
  end
end