module Expressir
  module Model
    module Types
      class Binary < ModelElement
        attr_accessor :width
        attr_accessor :fixed

        def initialize(options = {})
          @width = options[:width]
          @fixed = options[:fixed]
        end
      end
    end
  end
end