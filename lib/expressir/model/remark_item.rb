module Expressir
  module Model
    class RemarkItem < ModelElement
      model_attr_accessor :id
      model_attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []

        super
      end
    end
  end
end