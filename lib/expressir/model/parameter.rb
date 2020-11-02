module Expressir
  module Model
    class Parameter
      attr_accessor :id
      attr_accessor :type
      attr_accessor :var
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @var = options[:var]
        @remarks = options[:remarks]
      end
    end
  end
end