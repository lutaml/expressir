require "expressir/express/model_element"

module Expressir
  module Express
    class Attribute < ModelElement
      attr_accessor :name, :entity, :domain, :redeclare_entity,
        :redeclare_oldname

      def initialize
        @redeclare_entity = nil
        @redeclare_oldname = nil
      end
    end
  end
end
