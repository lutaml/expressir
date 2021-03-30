module Expressir
  module Model
    module Types
      class GenericEntity < ModelElement
        include Identifier

        def initialize(options = {})
          @id = options[:id]
          @remarks = options[:remarks] || []
          @remark_items = options[:remark_items] || []
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