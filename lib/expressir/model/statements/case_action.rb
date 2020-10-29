module Expressir
  module Model
    module Statements
      class CaseAction
        attr_accessor :expression
        attr_accessor :statement

        def initialize(options = {})
          @expression = options[:expression]
          @statement = options[:statement]
        end
      end
    end
  end
end