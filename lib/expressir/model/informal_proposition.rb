module Expressir
  module Model
    class InformalProposition < ModelElement
      include Identifier

      undef :source
      undef :source=

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        # @source = options[:source]

        super
      end
    end
  end
end