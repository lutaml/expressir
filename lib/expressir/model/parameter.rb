module Expressir
  module Model
    class Parameter < ModelElement
      include Identifier

      model_attr_accessor :var
      model_attr_accessor :type

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @var = options[:var]
        @type = options[:type]

        super
      end

      def children
        [
          *remark_items
        ]
      end
    end
  end
end