module Expressir
    module Model
      module Expressions
        class Query
          attr_accessor :id
          attr_accessor :source
          attr_accessor :expression
  
          def initialize(options = {})
            @id = options[:id]
            @source = options[:source]
            @expression = options[:expression]
          end
        end
      end
    end
  end