module Expressir
  module Model
    class Where
      include Identifier

      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]

        @expression = options[:expression]
      end
    end
  end
end