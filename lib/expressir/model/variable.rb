module Expressir
  module Model
    class Variable < ModelElement
      include Identifier

      attr_accessor :type
      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @type = options[:type]
        @expression = options[:expression]

        super
      end
    end
  end
end