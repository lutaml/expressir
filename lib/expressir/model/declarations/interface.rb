module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class Interface < Declaration
        USE = :USE
        REFERENCE = :REFERENCE

        model_attr_accessor :kind, ':USE, :REFERENCE'
        model_attr_accessor :schema, 'Reference'
        model_attr_accessor :items, 'Array<InterfaceItem>'

        # @param [Hash] options
        # @option options [:USE, :REFERENCE] :kind
        # @option options [Reference] :schema
        # @option options [Array<InterfaceItem>] :items
        def initialize(options = {})
          @kind = options[:kind]
          @schema = options[:schema]
          @items = options[:items] || []

          super
        end
      end
    end
  end
end