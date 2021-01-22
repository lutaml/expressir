module Expressir
  module Model
    class InformalProposition
      include Identifier

      def initialize(options = {})
        @id = options[:id]
      end
    end
  end
end