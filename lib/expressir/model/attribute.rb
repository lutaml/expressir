module Expressir
  module Model
    class Attribute
      include Identifier

      EXPLICIT = :EXPLICIT
      DERIVED = :DERIVED
      INVERSE = :INVERSE

      attr_accessor :kind
      attr_accessor :supertype_attribute
      attr_accessor :optional
      attr_accessor :type
      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]

        @kind = options[:kind]
        @supertype_attribute = options[:supertype_attribute]
        @optional = options[:optional]
        @type = options[:type]
        @expression = options[:expression]
      end
    end
  end
end