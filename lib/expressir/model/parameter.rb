module Expressir
  module Model
    class Parameter
      attr_accessor :var
      attr_accessor :id
      attr_accessor :type

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @var = options[:var]
        @id = options[:id]
        @type = options[:type]
      end
    end
  end
end