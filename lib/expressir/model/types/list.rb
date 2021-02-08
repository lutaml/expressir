module Expressir
  module Model
    module Types
      class List < ModelElement
        attr_accessor :bound1
        attr_accessor :bound2
        attr_accessor :unique
        attr_accessor :base_type

        def initialize(options = {})
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @unique = options[:unique]
          @base_type = options[:base_type]
        end
      end
    end
  end
end