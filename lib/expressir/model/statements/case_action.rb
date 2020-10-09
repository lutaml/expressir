module Expressir
  module Model
    module Statements
      class CaseAction
        attr_accessor :label
        attr_accessor :statement

        def initialize(options = {})
          @label = options[:label]
          @statement = options[:statement]
        end
      end
    end
  end
end