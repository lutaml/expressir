module Expressir
  module Model
    class SchemaVersionItem < ModelElement
      model_attr_accessor :name
      model_attr_accessor :value

      def initialize(options = {})
        @name = options[:name]
        @value = options[:value]

        super
      end
    end
  end
end