module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.6 Implicit declarations
      class EntityConstructor < Expression
        model_attr_accessor :entity, 'Reference'
        model_attr_accessor :parameters, 'Array<Expression>'

        # @param [Hash] options
        # @option options [Reference] :entity
        # @option options [Array<Expression>] :parameters
        def initialize(options = {})
          @entity = options[:entity]
          @parameters = options[:parameters] || []

          super
        end
      end
    end
  end
end