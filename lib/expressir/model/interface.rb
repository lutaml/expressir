module Expressir
  module Model
    class Interface < ModelElement
      USE = :USE
      REFERENCE = :REFERENCE

      model_attr_accessor :kind
      model_attr_accessor :schema
      model_attr_accessor :items

      def initialize(options = {})
        @kind = options[:kind]
        @schema = options[:schema]
        @items = options[:items] || []

        super
      end
    end
  end
end