module Expressir
  module Model
    class Type
      attr_accessor :id
      attr_accessor :type
      attr_accessor :where

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @where = options[:where]
      end
    end
  end
end