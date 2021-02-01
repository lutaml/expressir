module Expressir
  module Model
    class Cache < ModelElement
      attr_accessor :version
      attr_accessor :model

      def initialize(options = {})
        @version = options[:version]
        @model = options[:model]
      end
    end
  end
end