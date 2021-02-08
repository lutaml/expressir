module Expressir
  module Model
    module Expressions
      class EntityConstructor < ModelElement
        attr_accessor :entity
        attr_accessor :parameters

        def initialize(options = {})
          @entity = options[:entity]
          @parameters = options.fetch(:parameters, [])
        end
      end
    end
  end
end