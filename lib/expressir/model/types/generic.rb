module Expressir
  module Model
    module Types
      class Generic
        attr_accessor :label

        def initialize(options = {})
          @label = options[:label]
        end
      end
    end
  end
end