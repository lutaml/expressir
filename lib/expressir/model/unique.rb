module Expressir
  module Model
    class Unique
      attr_accessor :id
      attr_accessor :attributes

      def initialize(options = {})
        @id = options[:id]
        @attributes = options[:attributes]
      end
    end
  end
end