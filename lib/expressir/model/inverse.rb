module Expressir
  module Model
    class Inverse
      attr_accessor :supertype_attribute
      attr_accessor :id
      attr_accessor :type
      attr_accessor :attribute
      attr_accessor :remarks

      def initialize(options = {})
        @supertype_attribute = options[:supertype_attribute]
        @id = options[:id]
        @type = options[:type]
        @attribute = options[:attribute]
        @remarks = options[:remarks]
      end
    end
  end
end