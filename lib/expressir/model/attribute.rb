module Expressir
  module Model
    class Attribute < ModelElement
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
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
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