module Expressir
  module Model
    class EnumerationItem
      attr_accessor :id
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks]
      end
    end
  end
end