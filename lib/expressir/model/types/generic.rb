module Expressir
  module Model
    module Types
      class Generic
        include Identifier

        def initialize(options = {})
          @id = options[:id]
        end
      end
    end
  end
end