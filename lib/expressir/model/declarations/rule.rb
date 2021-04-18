module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.6 Rule
      class Rule < Declaration
        include Identifier

        model_attr_accessor :applies_to, 'Array<Reference>'
        model_attr_accessor :types, 'Array<Type>'
        model_attr_accessor :entities, 'Array<Entity>'
        model_attr_accessor :subtype_constraints, 'Array<SubtypeConstraint>'
        model_attr_accessor :functions, 'Array<Function>'
        model_attr_accessor :procedures, 'Array<Procedure>'
        model_attr_accessor :constants, 'Array<Constant>'
        model_attr_accessor :variables, 'Array<Variable>'
        model_attr_accessor :statements, 'Array<Statement>'
        model_attr_accessor :where_rules, 'Array<WhereRule>'
        model_attr_accessor :informal_propositions, 'Array<RemarkItem>'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Array<Reference>] :applies_to
        # @option options [Array<Type>] :types
        # @option options [Array<Entity>] :entities
        # @option options [Array<SubtypeConstraint>] :subtype_constraints
        # @option options [Array<Function>] :functions
        # @option options [Array<Procedure>] :procedures
        # @option options [Array<Constant>] :constants
        # @option options [Array<Variable>] :variables
        # @option options [Array<Statement>] :statements
        # @option options [Array<WhereRule>] :where_rules
        # @option options [Array<RemarkItem>] :informal_propositions
        def initialize(options = {})
          initialize_identifier(options)

          @applies_to = options[:applies_to] || []
          @types = options[:types] || []
          @entities = options[:entities] || []
          @subtype_constraints = options[:subtype_constraints] || []
          @functions = options[:functions] || []
          @procedures = options[:procedures] || []
          @constants = options[:constants] || []
          @variables = options[:variables] || []
          @statements = options[:statements] || []
          @where_rules = options[:where_rules] || []
          @informal_propositions = options[:informal_propositions] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *types,
            *types.flat_map{|x| x.enumeration_items},
            *entities,
            *subtype_constraints,
            *functions,
            *procedures,
            *constants,
            *variables,
            *where_rules,
            *informal_propositions,
            *remark_items
          ]
        end
      end
    end
  end
end