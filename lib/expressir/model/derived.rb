module Expressir
  module Model
    class Derived
      attr_accessor :supertype_attribute
      attr_accessor :id
      attr_accessor :type
      attr_accessor :expression
      attr_accessor :remarks

      def initialize(options = {})
        @supertype_attribute = options[:supertype_attribute]
        @id = options[:id]
        @type = options[:type]
        @expression = options[:expression]
        @remarks = options[:remarks]
      end
    end
  end
end