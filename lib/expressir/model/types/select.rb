module Expressir
  module Model
    module Types
      class Select
        attr_accessor :extensible
        attr_accessor :generic_entity
        attr_accessor :list
        attr_accessor :extension_type
        attr_accessor :extension_list

        def initialize(options = {})
          @extensible = options[:extensible]
          @generic_entity = options[:generic_entity]
          @list = options[:list]
          @extension_type = options[:extension_type]
          @extension_list = options[:extension_list]
        end
      end
    end
  end
end