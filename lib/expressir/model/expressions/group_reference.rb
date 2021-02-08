module Expressir
  module Model
    module Expressions
      class GroupReference < ModelElement
        attr_accessor :ref
        attr_accessor :entity

        def initialize(options = {})
          @ref = options[:ref]
          @entity = options[:entity]
        end
      end
    end
  end
end