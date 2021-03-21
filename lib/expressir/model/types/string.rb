module Expressir
  module Model
    module Types
      class String < ModelElement
        model_attr_accessor :width
        model_attr_accessor :fixed

        def initialize(options = {})
          @width = options[:width]
          @fixed = options[:fixed]

          super
        end
      end
    end
  end
end