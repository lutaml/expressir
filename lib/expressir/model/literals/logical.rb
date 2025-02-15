module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.5 Logical literal
      class Logical < Literal
        TRUE = "TRUE"
        FALSE = "FALSE"
        UNKNOWN = "UNKNOWN"

        attribute :value, :string, values: %w[TRUE FALSE UNKNOWN]
      end
    end
  end
end
