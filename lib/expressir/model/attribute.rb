module Expressir
  module Model
    class Attribute < ModelElement
      include Identifier

      EXPLICIT = :EXPLICIT
      DERIVED = :DERIVED
      INVERSE = :INVERSE

      model_attr_accessor :kind
      model_attr_accessor :supertype_attribute
      model_attr_accessor :optional
      model_attr_accessor :type
      model_attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @kind = options[:kind]
        @supertype_attribute = options[:supertype_attribute]
        @optional = options[:optional]
        @type = options[:type]
        @expression = options[:expression]

        super
      end

      def children
        [
          *remark_items
        ]
      end
    end
  end
end