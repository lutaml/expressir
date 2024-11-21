module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.5.1 Function
      class Function < Declaration
        include Identifier

        model_attr_accessor :parameters, "Array<Parameter>"
        model_attr_accessor :return_type, "DataType"
        model_attr_accessor :types, "Array<Type>"
        model_attr_accessor :entities, "Array<Entity>"
        model_attr_accessor :subtype_constraints, "Array<SubtypeConstraint>"
        model_attr_accessor :functions, "Array<Function>"
        model_attr_accessor :procedures, "Array<Procedure>"
        model_attr_accessor :constants, "Array<Constant>"
        model_attr_accessor :variables, "Array<Variable>"
        model_attr_accessor :statements, "Array<Statement>"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Array<Parameter>] :parameters
        # @option options [DataType] :return_type
        # @option options [Array<Type>] :types
        # @option options [Array<Entity>] :entities
        # @option options [Array<SubtypeConstraint>] :subtype_constraints
        # @option options [Array<Function>] :functions
        # @option options [Array<Procedure>] :procedures
        # @option options [Array<Constant>] :constants
        # @option options [Array<Variable>] :variables
        # @option options [Array<Statement>] :statements
        def initialize(options = {})
          initialize_identifier(options)

          @parameters = options[:parameters] || []
          @return_type = options[:return_type]
          @types = options[:types] || []
          @entities = options[:entities] || []
          @subtype_constraints = options[:subtype_constraints] || []
          @functions = options[:functions] || []
          @procedures = options[:procedures] || []
          @constants = options[:constants] || []
          @variables = options[:variables] || []
          @statements = options[:statements] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *parameters,
            *types,
            *types.flat_map(&:enumeration_items),
            *entities,
            *subtype_constraints,
            *functions,
            *procedures,
            *constants,
            *variables,
            *remark_items,
          ]
        end
      end
    end
  end
end
