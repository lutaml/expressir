module Expressir
  module Model
    class Explicit
      attr_accessor :id
      attr_accessor :supertype_attribute
      attr_accessor :optional
      attr_accessor :type
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @supertype_attribute = options[:supertype_attribute]
        @optional = options[:optional]
        @type = options[:type]
        @remarks = options[:remarks]
      end
    end
  end
end