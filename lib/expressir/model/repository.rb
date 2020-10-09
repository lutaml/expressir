module Expressir
  module Model
    class Repository
      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options[:schemas]
      end
    end
  end
end