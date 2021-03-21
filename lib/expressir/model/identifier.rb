module Expressir
  module Model
    module Identifier
      def self.included(mod)
        mod.model_attr_accessor :id
        mod.model_attr_accessor :remarks
        mod.model_attr_accessor :remark_items
        mod.model_attr_accessor :source
      end
    end
  end
end