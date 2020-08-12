require "expressr/express/model_element"

module Expressr
  module Express
    class SubtypeConstraint < ModelElement
      attr_accessor :name, :entity, :isAbs, :totalover, :expression

      def initialize
        @isAbs = false
        @totalover = nil
      end
    end
  end
end
