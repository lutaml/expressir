require "reeper/express/model_element"

module Reeper
  module Express
    class NamedType < ModelElement
      attr_accessor :name, :schema, :wheres, :selectedBy

      def self.find_by_name(name)
        found = nil

        ObjectSpace.each_object(NamedType) do |obj|
          found = obj if obj.name == name
        end

        found
      end
    end
  end
end
