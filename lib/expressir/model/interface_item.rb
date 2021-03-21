module Expressir
  module Model
    class InterfaceItem < ModelElement
      model_attr_accessor :ref
      model_attr_accessor :id

      def initialize(options = {})
        @ref = options[:ref] 
        @id = options[:id]

        super
      end
    end
  end
end