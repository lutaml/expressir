module Expressir
  module Model
    module Statements
      class ProcedureCall
        attr_accessor :procedure
        attr_accessor :parameters

        def initialize(options = {})
          @procedure = options[:procedure]
          @parameters = options[:parameters]
        end
      end
    end
  end
end