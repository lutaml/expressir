require "reeper/express/attribute"

module Reeper
  module Express
    class ExplicitOrDerived < Attribute
      attr_accessor :isBuiltin, :isFixed, :width, :precision

      def initialize
        @isBuiltin = false
        @isFixed = false
        @width = nil
        @precision = nil
      end
    end
  end
end
