module Expressir
  module Model
    class RemarkItem < ModelElement
      attr_accessor :id
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])

        super
      end
    end
  end
end