module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.1 Type declaration
      class Type < Declaration
        include Identifier

        model_attr_accessor :underlying_type, 'DataType'
        model_attr_accessor :where_rules, 'Array<WhereRule>'
        model_attr_accessor :informal_propositions, 'Array<RemarkItem>'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [DataType] :underlying_type
        # @option options [Array<WhereRule>] :where_rules
        # @option options [Array<RemarkItem>] :informal_propositions
        def initialize(options = {})
          initialize_identifier(options)

          @underlying_type = options[:underlying_type]
          @where_rules = options[:where_rules] || []
          @informal_propositions = options[:informal_propositions] || []

          super
        end

        # @return [Array<DataTypes::EnumerationItem>]
        def enumeration_items
          underlying_type.is_a?(DataTypes::Enumeration) ? underlying_type.items : []
        end

        # @return [Array<Declaration>]
        def children
          [
            *enumeration_items,
            *where_rules,
            *informal_propositions,
            *remark_items
          ]
        end
      end
    end
  end
end