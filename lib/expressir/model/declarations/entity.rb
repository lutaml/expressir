module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2 Entity declaration
      class Entity < Declaration
        include Identifier

        model_attr_accessor :abstract, "Boolean"
        model_attr_accessor :supertype_expression, "SupertypeExpression"
        model_attr_accessor :subtype_of, "Array<Reference>"
        model_attr_accessor :attributes, "Array<Attribute>"
        model_attr_accessor :unique_rules, "Array<UniqueRule>"
        model_attr_accessor :where_rules, "Array<WhereRule>"
        model_attr_accessor :informal_propositions, "Array<RemarkItem>"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Boolean] :abstract
        # @option options [SupertypeExpression] :supertype_expression
        # @option options [Array<Reference>] :subtype_of
        # @option options [Array<Attribute>] :attributes
        # @option options [Array<UniqueRule>] :unique_rules
        # @option options [Array<WhereRule>] :where_rules
        # @option options [Array<RemarkItem>] :informal_propositions
        def initialize(options = {})
          initialize_identifier(options)

          @abstract = options[:abstract]
          @supertype_expression = options[:supertype_expression]
          @subtype_of = options[:subtype_of] || []
          @attributes = options[:attributes] || []
          @unique_rules = options[:unique_rules] || []
          @where_rules = options[:where_rules] || []
          @informal_propositions = options[:informal_propositions] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *attributes,
            *unique_rules,
            *where_rules,
            *informal_propositions,
            *remark_items,
          ]
        end
      end
    end
  end
end
