module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.2 Alias statement
      class Alias < Statement
        include Identifier

        attribute :expression, Expressir::Model::Expression
        attribute :statements, Statement, collection: true

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items,
          ]
        end
      end
    end
  end
end
