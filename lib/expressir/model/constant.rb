module Expressir
  module Model
    class Constant
      attr_accessor :id
      attr_accessor :type
      attr_accessor :expression

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @expression = options[:expression]
      end
    end
  end
end