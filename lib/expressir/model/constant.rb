module Expressir
  module Model
    class Constant < ModelElement
      include Identifier

      attr_accessor :type
      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @type = options[:type]
        @expression = options[:expression]
      end
    end
  end
end