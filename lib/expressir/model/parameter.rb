module Expressir
  module Model
    class Parameter
      attr_accessor :id
      attr_accessor :type
      attr_accessor :var

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @var = options[:var]
      end
    end
  end
end