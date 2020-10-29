module Expressir
  module Model
    module Types
      class GenericEntity
        attr_accessor :label
        attr_accessor :remarks

        def initialize(options = {})
          @label = options[:label]
          @remarks = options[:remarks]
        end
      end
    end
  end
end