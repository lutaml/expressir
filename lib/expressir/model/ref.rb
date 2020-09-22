module Expressir
  module Model
    class Ref
      attr_accessor :id

      def initialize(options = {})
        @id = options[:id]
      end
    end
  end
end