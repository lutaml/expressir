module Expressir
  module Model
    class Inverse
      attr_accessor :id
      attr_accessor :type
      attr_accessor :attribute

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @attribute = options[:attribute]
      end
    end
  end
end