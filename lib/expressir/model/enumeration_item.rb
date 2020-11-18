module Expressir
  module Model
    class EnumerationItem
      attr_accessor :id

      attr_accessor :parent
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
      end
    end
  end
end