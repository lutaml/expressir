module Expressir
  module Model
    class SchemaVersion < ModelElement
      model_attr_accessor :value
      model_attr_accessor :items

      def initialize(options = {})
        @value = options[:value]
        @items = options[:items] || []

        super
      end
    end
  end
end