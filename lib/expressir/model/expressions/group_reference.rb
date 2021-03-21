module Expressir
  module Model
    module Expressions
      class GroupReference < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :entity

        def initialize(options = {})
          @ref = options[:ref]
          @entity = options[:entity]

          super
        end
      end
    end
  end
end