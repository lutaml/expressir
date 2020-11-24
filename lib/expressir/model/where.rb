module Expressir
  module Model
    class Where
      attr_accessor :id
      attr_accessor :expression

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @expression = options[:expression]
      end
    end
  end
end