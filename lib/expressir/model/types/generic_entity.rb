module Expressir
  module Model
    module Types
      class GenericEntity
        attr_accessor :label

        def initialize(options = {})
          @label = options[:label]
        end
      end
    end
  end
end