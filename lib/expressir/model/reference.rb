module Expressir
  module Model
    class Reference
      attr_accessor :schema
      attr_accessor :items

      def initialize(options = {})
        @schema = options[:schema]
        @items = options[:items]
      end
    end
  end
end