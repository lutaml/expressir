module Expressir
  module Model
    module Statements
      class CaseAction
        attr_accessor :labels
        attr_accessor :statement

        def initialize(options = {})
          @labels = options[:labels]
          @statement = options[:statement]
        end
      end
    end
  end
end