module Expressir
  module Model
    class Unique
      include Identifier

      attr_accessor :attributes

      def initialize(options = {})
        @id = options[:id]

        @attributes = options[:attributes]
      end
    end
  end
end