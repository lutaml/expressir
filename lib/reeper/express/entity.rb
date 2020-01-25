require "reeper/express/explicit"
require "reeper/express/inverse"
require "reeper/express/derived"
require "reeper/express/named_type"
require "reeper/express/where_rule"
require "reeper/express/unique_rule"

require "reeper/express/explicit_aggregate"
require "reeper/express/inverse_aggregate"
require "reeper/express/derived_aggregate"

module Reeper
  module Express
    class Entity < NamedType
      attr_accessor :supertypes, :attributes, :isAbs, :superexpression,
        :uniques, :subtypes_array, :supertypes_array, :attributes_all_array,
        :supertypes_all

      def initialize(document: nil, schema: nil, **options)
        @isAbs = false
        @attributes = []
        @uniques = []
        @wheres = []
        @subtypes_array = []
        @supertypes_array = []
        @attributes_all_array = []
        @supertypes = nil
        @supertypes_all = nil
        @superexpression = nil
        @selectedBy = []

        @schema = schema
        @document = document
        @options = options
      end

      def find_attr_by_name( attrname )
        for attribute in attributes
          if attrname == attribute.name
            return attribute
          end
        end
        return nil
      end

      def find_attr_by_name_full( attrname )
        attr = find_attr_by_name( attrname )
        if attr != nil
          return attr
        end
        for supertype in supertypes_array
          attr = supertype.find_attr_by_name_full (attrname)
          if attr != nil
            return attr
          end
        end
      end

      def parse
        extract_attributes(@document, @schema)
        self
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      def extract_attributes(document, schema)
        @name = document.attributes["name"].to_s
        @supertypes = document.attributes["supertypes"]
        @superexpression = document.attributes["super.expression"]

        @wheres = extract_where_rules(document)
        @uniques = extract_unique_rules(document)

        @isAbs = document.attributes["supertypes"] == "YES" ||
          document.attributes["abstract.entity"] == "YES"

        @attributes = [
          extract_eplicits(document),
          extract_inverses(document),
          extract_derivedes(document),
        ].flatten
      end

      def extract_eplicits(document)
        document.xpath("explicit").map do |explicit|
          explicit_type = Express::Explicit

          if !explicit.xpath("aggregate").empty?
            explicit_type = Express::ExplicitAggregate
          end

          explicit_type.parse(explicit, self)
        end
      end

      def extract_inverses(document)
        document.xpath("inverse").map do |inverse|
          inverse_type = Express::Inverse

          if !inverse.xpath("inverse.aggregate").empty?
            inverse_type = Express::InverseAggregate
          end

          inverse_type.parse(inverse, self)
        end
      end

      def extract_derivedes(document)
        document.xpath("derived").map do |derived|
          derived_type = Express::Derived

          if !derived.xpath("aggregate").empty?
            derived_type = Express::DerivedAggregate
          end

          derived_type.parse(derived, self)
        end
      end

      def extract_unique_rules(document)
        document.xpath("unique").map do |unique|
          Express::UniqueRule.parse(unique)
        end
      end

      def extract_where_rules(document)
        document.xpath("where").map do |where|
          Express::WhereRule.parse(where)
        end
      end
    end
  end
end
