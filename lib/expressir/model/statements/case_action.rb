module Expressir
  module Model
    module Statements
      class CaseAction < ModelElement
        attr_accessor :labels
        attr_accessor :statement

        def initialize(options = {})
          @labels = options.fetch(:labels, [])
          @statement = options[:statement]
        end
      end
    end
  end
end