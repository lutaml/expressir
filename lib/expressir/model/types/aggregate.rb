module Expressir
  module Model
    module Types
      class Aggregate < ModelElement
        include Identifier

        attr_accessor :base_type

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @remark_items = options.fetch(:remark_items, [])
          @source = options[:source]

          @base_type = options[:base_type]

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
end