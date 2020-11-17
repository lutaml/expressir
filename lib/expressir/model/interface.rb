module Expressir
  module Model
    class Interface
      USE = :USE
      REFERENCE = :REFERENCE

      attr_accessor :kind
      attr_accessor :schema
      attr_accessor :items

      def initialize(options = {})
        @kind = options[:kind]
        @schema = options[:schema]
        @items = options[:items]
      end
    end
  end
end