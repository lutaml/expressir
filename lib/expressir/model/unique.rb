module Expressir
  module Model
    class Unique < ModelElement
      include Identifier

      attr_accessor :attributes

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @attributes = options.fetch(:attributes, [])

        super
      end
    end
  end
end