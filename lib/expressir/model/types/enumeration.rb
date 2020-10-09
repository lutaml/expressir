module Expressir
  module Model
    module Types
      class Enumeration
        attr_accessor :extensible
        attr_accessor :list
        attr_accessor :extension_type
        attr_accessor :extension_list

        def initialize(options = {})
          @extensible = options[:extensible]
          @list = options[:list]
          @extension_type = options[:extension_type]
          @extension_list = options[:extension_list]
        end
      end
    end
  end
end