require "reeper/express/defined_type"

module Reeper
  module Express
    class Type < DefinedType
      attr_accessor :isBuiltin, :domain, :isFixed, :width, :precision

      def initialize(options = {})
        @isBuiltin = false
        @isFixed = false
        @width = nil
        @precision = nil
        @wheres = []
        @selectedBy = []

        super(options)
      end

      private

      def extract_type_attributes(document)
        super(document)
      end
    end
  end
end
