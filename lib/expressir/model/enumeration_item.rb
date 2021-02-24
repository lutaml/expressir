module Expressir
  module Model
    class EnumerationItem < ModelElement
      include Identifier

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        super
      end
    end
  end
end