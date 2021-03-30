module Expressir
  module Model
    class Function < ModelElement
      include Identifier

      model_attr_accessor :parameters
      model_attr_accessor :return_type
      model_attr_accessor :types
      model_attr_accessor :entities
      model_attr_accessor :subtype_constraints
      model_attr_accessor :functions
      model_attr_accessor :procedures
      model_attr_accessor :constants
      model_attr_accessor :variables
      model_attr_accessor :statements

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

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

      def enumeration_items
        types.flat_map{|x| x.enumeration_items}
      end

      def children
        [
          *parameters,
          *types,
          *enumeration_items,
          *entities,
          *subtype_constraints,
          *functions,
          *procedures,
          *constants,
          *variables,
          *remark_items
        ]
      end
    end
  end
end