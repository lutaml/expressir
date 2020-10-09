module Expressir
  module Model
    module Expressions
      class GroupQualifier
        attr_accessor :entity

        def initialize(options = {})
          @entity = options[:entity]
        end
      end
    end
  end
end