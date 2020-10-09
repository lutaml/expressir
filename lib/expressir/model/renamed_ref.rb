module Expressir
  module Model
    class RenamedRef
      attr_accessor :ref
      attr_accessor :id

      def initialize(options = {})
        @ref = options[:ref]
        @id = options[:id]
      end
    end
  end
end