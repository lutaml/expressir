module Expressir
  module Model
    module Types
      class GenericEntity
        include Identifier

        def initialize(options = {})
          @id = options[:id]
        end
      end
    end
  end
end