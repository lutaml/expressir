module Expressir
  module Model
    module Types
      class Set < ModelElement
        attr_accessor :bound1
        attr_accessor :bound2
        attr_accessor :base_type

        def initialize(options = {})
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @base_type = options[:base_type]

          super
        end
      end
    end
  end
end