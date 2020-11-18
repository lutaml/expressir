module Expressir
  module Model
    class Unique
      attr_accessor :id
      attr_accessor :attributes

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @attributes = options[:attributes]
      end
    end
  end
end