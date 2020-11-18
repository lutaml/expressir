module Expressir
  module Model
    class Attribute
      EXPLICIT = :EXPLICIT
      DERIVED = :DERIVED
      INVERSE = :INVERSE

      attr_accessor :kind
      attr_accessor :supertype_attribute
      attr_accessor :id
      attr_accessor :optional
      attr_accessor :type
      attr_accessor :expression

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @kind = options[:kind]
        @supertype_attribute = options[:supertype_attribute]
        @id = options[:id]
        @optional = options[:optional]
        @type = options[:type]
        @expression = options[:expression]
      end
    end
  end
end