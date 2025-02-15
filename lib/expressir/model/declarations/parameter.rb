module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.5.3 Parameters
      class Parameter < ::Expressir::Model::Declaration
        include Identifier

        attribute :var, :boolean
        attribute :type, ::Expressir::Model::DataType

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
