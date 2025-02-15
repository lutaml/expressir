module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.2.2 Domain rules (WHERE clause)
      class WhereRule < ::Expressir::Model::Declaration
        include Identifier

        attribute :expression, ::Expressir::Model::Expression

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
