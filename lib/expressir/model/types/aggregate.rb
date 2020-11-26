module Expressir
  module Model
    module Types
      class Aggregate
        include Identifier

        attr_accessor :base_type

        def initialize(options = {})
          @id = options[:id]

          @base_type = options[:base_type]
        end
      end
    end
  end
end