module Expressir
  module Model
    module Statements
      class CaseAction < ModelElement
        model_attr_accessor :labels
        model_attr_accessor :statement

        def initialize(options = {})
          @labels = options[:labels] || []
          @statement = options[:statement]

          super
        end
      end
    end
  end
end