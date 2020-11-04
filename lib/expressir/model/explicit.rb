module Expressir
  module Model
    class Explicit
      attr_accessor :supertype_attribute
      attr_accessor :id
      attr_accessor :optional
      attr_accessor :type
      attr_accessor :remarks

      def initialize(options = {})
        @supertype_attribute = options[:supertype_attribute]
        @id = options[:id]
        @optional = options[:optional]
        @type = options[:type]
        @remarks = options[:remarks]
      end
    end
  end
end