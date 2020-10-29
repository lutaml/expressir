module Expressir
  module Model
    class Derived
      attr_accessor :id
      attr_accessor :supertype_attribute
      attr_accessor :type
      attr_accessor :expression
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @supertype_attribute = options[:supertype_attribute]
        @type = options[:type]
        @expression = options[:expression]
        @remarks = options[:remarks]
      end
    end
  end
end