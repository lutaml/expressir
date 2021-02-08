module Expressir
  module Model
    class Parameter < ModelElement
      include Identifier

      attr_accessor :var
      attr_accessor :type

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @var = options[:var]
        @type = options[:type]
      end
    end
  end
end