module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class InterfacedItem < ModelElement
        model_attr_accessor :id, 'String'
        model_attr_accessor :remarks, 'Array<String>'
        model_attr_accessor :remark_items, 'Array<RemarkItem>'

        model_attr_accessor :base_item, 'ModelElement'

        # @param [Hash] options
        # @option options [String] :id
        # @option options [Array<String>] :remarks
        # @option options [Array<RemarkItem>] :remark_items
        # @option options [ModelElement] :base_item
        def initialize(options = {})
          @id = options[:id]
          @remarks = options[:remarks] || []
          @remark_items = options[:remark_items] || []

          @base_item = options[:base_item]

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items
          ]
        end
      end
    end
  end
end