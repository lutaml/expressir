module Expressir
  module Model
    class Interface < ModelElement
      USE = :USE
      REFERENCE = :REFERENCE

      attr_accessor :kind
      attr_accessor :schema
      attr_accessor :items

      def initialize(options = {})
        @kind = options[:kind]
        @schema = options[:schema]
        @items = options.fetch(:items, [])

        super
      end
    end
  end
end