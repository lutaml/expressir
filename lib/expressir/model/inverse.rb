module Expressir
  module Model
    class Inverse
      attr_accessor :id
      attr_accessor :supertype_attribute
      attr_accessor :type
      attr_accessor :attribute
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @supertype_attribute = options[:supertype_attribute]
        @type = options[:type]
        @attribute = options[:attribute]
        @remarks = options[:remarks]
      end
    end
  end
end