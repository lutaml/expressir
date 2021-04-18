module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < Declaration
        model_attr_accessor :id, 'String'
        model_attr_accessor :remarks, 'Array<String>'

        # @param [Hash] options
        # @option options [String] :id
        # @option options [Array<String>] :remarks
        def initialize(options = {})
          @id = options[:id]
          @remarks = options[:remarks] || []

          super
        end
      end
    end
  end
end