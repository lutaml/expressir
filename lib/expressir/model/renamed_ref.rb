module Expressir
  module Model
    class RenamedRef < ModelElement
      attr_accessor :ref
      attr_accessor :id

      def initialize(options = {})
        @ref = options[:ref]
        @id = options[:id]

        super
      end
    end
  end
end