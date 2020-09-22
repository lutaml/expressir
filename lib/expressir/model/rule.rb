module Expressir
  module Model
    class Rule
      attr_accessor :id
      attr_accessor :applies_to
      attr_accessor :declarations
      attr_accessor :constants
      attr_accessor :locals
      attr_accessor :where
      attr_accessor :statements

      def initialize(options = {})
        @id = options[:id]
        @applies_to = options[:applies_to]
        @declarations = options[:declarations]
        @constants = options[:constants]
        @locals = options[:locals]
        @where = options[:where]
        @statements = options[:statements]
      end
    end
  end
end