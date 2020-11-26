module Expressir
  module Model
    class Parameter
      include Identifier

      attr_accessor :var
      attr_accessor :type

      def initialize(options = {})
        @id = options[:id]

        @var = options[:var]
        @type = options[:type]
      end
    end
  end
end