module Expressir
  module Model
    class Function
      attr_accessor :id
      attr_accessor :parameters
      attr_accessor :return_type
      attr_accessor :declarations
      attr_accessor :constants
      attr_accessor :locals
      attr_accessor :statements

      def initialize(options = {})
        @id = options[:id]
        @parameters = options[:parameters]
        @return_type = options[:return_type]
        @declarations = options[:declarations]
        @constants = options[:constants]
        @locals = options[:locals]
        @statements = options[:statements]
      end
    end
  end
end