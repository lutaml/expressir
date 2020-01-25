require "reeper/express/defined_type"

module Reeper
  module Express
    class TypeSelect < DefinedType
      attr_accessor :selectitems_array, :selectitems, :extends, :extends_item,
        :isExtensible, :selectitems_all, :isGenericEntity, :isBuiltin,
        :cleaned_select_items

      def initialize(options = {})
        @isBuiltin = false
        @isExtensible = false
        @isGenericEntity = false
        @selectitems = nil
        @selectitems_array = []
        @cleaned_select_items = nil
        @wheres = []
        @selectedBy = []

        super(options)
      end

      ##
      # set cleaned_select_items = process select removing unnecessary
      # entity types (i.e. if supertype is there)
      #
      def clean_select_items
        @cleaned_select_items = ""

        if selectitems != nil
          itemname_list = selectitems.scan(/\w+/)
          dupitem_list = []
          for itemname in itemname_list
            itemptr = schema.find_namedtype_by_name( itemname )

            if itemptr.kind_of? EXPSM::Entity

              for itemname2 in itemname_list
                thetype = schema.find_namedtype_by_name( itemname2 )

                if thetype != nil
                  if itemptr.supertypes_all != nil &&
                      itemptr.supertypes_all.include?(thetype.name)

                    dupitem_list.push itemname
                  end
                end
              end
            end
          end

          itemname_list.each do |itemname|
            if !dupitem_list.include? itemname
              @cleaned_select_items = @cleaned_select_items + " " + itemname
            end
          end

          @cleaned_select_items = @cleaned_select_items.lstrip
        end
      end

      private

      def extract_type_attributes(document)
        if document.class == Nokogiri::XML::NodeSet
          document = document.first
        end

        @selectitems = document.attributes["selectitems"]
        @extends = document.attributes["basedon"]
        @isExtensible = document.attributes["extensible"] == "YES"
        @isGenericEntity = document.attributes["genericentity"] == "YES"

        if isExtensible
          @selectitems_all = selectitems
        end

        super(document)
      end
    end
  end
end
