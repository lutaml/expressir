module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.1 Attributes
      class Attribute < Declaration
        include Identifier

        EXPLICIT = :EXPLICIT
        DERIVED = :DERIVED
        INVERSE = :INVERSE

        model_attr_accessor :kind, ":EXPLICIT, :DERIVED, :INVERSE"
        model_attr_accessor :supertype_attribute, "Reference"
        model_attr_accessor :optional, "Boolean"
        model_attr_accessor :type, "DataType"
        model_attr_accessor :expression, "Expression"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [:EXPLICIT, :DERIVED, :INVERSE] :kind
        # @option options [Reference] :supertype_attribute
        # @option options [Boolean] :optional
        # @option options [DataType] :type
        # @option options [Expression] :operand
        def initialize(options = {})
          initialize_identifier(options)

          @kind = options[:kind]
          @supertype_attribute = options[:supertype_attribute]
          @optional = options[:optional]
          @type = options[:type]
          @expression = options[:expression]

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
