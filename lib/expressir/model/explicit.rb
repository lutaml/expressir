module Expressir
  module Model
    class Explicit
      attr_accessor :id
      attr_accessor :optional
      attr_accessor :type

      def initialize(options = {})
        @id = options[:id]
        @optional = options[:optional]
        @type = options[:type]
      end
    end
  end
end