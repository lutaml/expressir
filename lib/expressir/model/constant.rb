module Expressir
  module Model
    class Constant
      attr_accessor :id
      attr_accessor :type
      attr_accessor :expression
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @expression = options[:expression]
        @remarks = options[:remarks]
      end
    end
  end
end