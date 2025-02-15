module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.2 Real data type
      class Real < DataType
        attribute :precision, Expressir::Model::Expression
      end
    end
  end
end
