module Expressir
  module Model
    module Types
      class Array < ModelElement
        model_attr_accessor :bound1
        model_attr_accessor :bound2
        model_attr_accessor :optional
        model_attr_accessor :unique
        model_attr_accessor :base_type

        def initialize(options = {})
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @optional = options[:optional]
          @unique = options[:unique]
          @base_type = options[:base_type]

          super
        end
      end
    end
  end
end