module Expressir
  module Model
    class EnumerationItem
      include Identifier

      def initialize(options = {})
        @id = options[:id]
      end
    end
  end
end