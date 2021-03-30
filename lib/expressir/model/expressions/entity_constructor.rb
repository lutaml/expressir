module Expressir
  module Model
    module Expressions
      class EntityConstructor < ModelElement
        model_attr_accessor :entity
        model_attr_accessor :parameters

        def initialize(options = {})
          @entity = options[:entity]
          @parameters = options[:parameters] || []

          super
        end
      end
    end
  end
end