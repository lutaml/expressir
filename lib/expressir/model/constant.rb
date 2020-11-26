module Expressir
  module Model
    class Constant
      include Identifier

      attr_accessor :type
      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]

        @type = options[:type]
        @expression = options[:expression]
      end
    end
  end
end