module Expressir
  module Model
    module Types
      class GenericEntity < ModelElement
        include Identifier

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @remark_items = options.fetch(:remark_items, [])
          @source = options[:source]

          super
        end
      end

      def children
        [
          *remark_items
        ]
      end
    end
  end
end