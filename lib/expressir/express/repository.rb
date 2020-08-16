require "expressir/express/interface_specification"

module Expressir
  module Express
    class Repository
      @@next_integer_id = 0
      attr_accessor :name, :schemas

      def initialize(options = {}) @file = options.fetch(:file, nil)
        @schemas = options.fetch(:schemas, [])
      end

      # @todo Existing Code
      #
      # Please revisit this soon, and check if this is necessary
      # after our recent restrucutre, if not then delegate this
      # behavior to the respective instanace.
      #
      def get_next_integer
        @@next_integer_id += 1
        @@next_integer_id
      end

      # @todo Existing Code
      #
      # Please revisit this soon, and check if this is necessary
      # after our recent restrucutre, if not then delegate this
      # behavior to the respective instanace.
      #
      def get_xmlid(thing)
        if !thing.class.name.include? "::"
          "id-" + thing.class.name + "-" + get_next_integer.to_s
        else
          thing_type = thing.class.name.split("::")
          "id-" + thing_type[1] + "-" + get_next_integer.to_s
        end
      end

      # @todo Existing Code
      #
      # Please revisit this soon, and check if this is necessary
      # after our recent restrucutre, if not then delegate this
      # behavior to the respective instanace.
      #
      def find_namedtype_by_name(typename)
        foundtype = nil

        while foundtype == nil
          schemas.each do |schema|
            foundtype = schema.find_namedtype_by_name(typename)
            break unless foundtype.nil?
          end
        end

        foundtype
      end

      def parse
        @name = document.xpath("//express/schema/@name").to_s

        @schemas = document.xpath("//express/schema").map do |schema|
          Expressir::Express::SchemaDefinition.new(schema)
        end

        # @todo: Disabling for now
        #
        #post_process_repository
        self
      end

      def self.from_xml(file)
        new(file: file).parse
      end

      private

      def document
        @document ||= File.open(@file) { |fpath| Nokogiri::XML(fpath) }
      end

      # @todo Existing Code
      #
      # Please revisit this soon, and check if this is necessary
      # after our recent restrucutre, if not then delegate this
      # behavior to the respective instanace.
      #
      def post_process_repository
        schemas.each do |schema|
          schema.all_schema_array = get_all_interfaced_schemas(schema)

          schema.contents.each do |content|
            post_process_schema_content(content, schema)
          end

          # @todo: Copying existing code
          #
          # I'm not sure why we are running the content loop again, when
          # we already had that one once, but I'm keeping it as it for now
          # since this might be something we actually need to run after the
          # initial pointer/linking setup, but please revisit and clean this
          # up once we have more visibility.
          #
          schema.contents.each do |content|
            if content.is_a?(Express::Entity)
              content.attributes.each do |attr|
                if attr.is_a?(Express::Inverse)
                  attr_to_find = attr.reverseAttr_id
                  attr.reverseEntity = schema.find_namedtype_by_name(attr.domain)
                  attr.reverseAttr = attr.reverseEntity.find_attr_by_name_full(
                    attr_to_find
                  )
                end
              end
            end
          end
        end
      end

      # @todo: Existing Code
      #
      # We are just copying over this method from the existing codebase
      # please revisit this one soon, this is recursively calling itself
      # and this might be one of the potential reason for slow parsing
      #
      def get_all_interfaced_schemas(schema, schema_list = [])
        ispec_list = schema.contents.select do |content|
          content.is_a? Express::InterfaceSpecification
        end

        if !ispec_list&.nil?
          ispec_list.each do |ispec|
            if !(schema_list.include? ispec.foreign_schema)
              schema_list.push ispec.foreign_schema
            end

            get_all_interfaced_schemas(ispec.foreign_schema, schema_list)
          end
        end

        schema_list
      end

      def post_process_schema_content(content, schema)
        post_process_interface_specification(content)
        post_process_type_select(content, schema)
        post_process_golbal_rules(content, schema)
        post_process_entity(content, schema)
      end

      # @todo: Existing Code
      #
      # Neeed to double check if this is actually necessary in the long
      # run, or use the new strucutre to handle these kind of linking.
      #
      def post_process_interface_specification(content)
        if content.is_a? Express::InterfaceSpecification
          content.explicit_items.each do |item|
            name_to_find = item.original_name || item.name
            type = content.foreign_schema.find_namedtype_by_name(name_to_find)
            item.foreign_type = type if type
          end
        end
      end

      # @todo: Existing Code
      #
      # Need to be double check, and see if what's the actually point
      # of having those linked into the instances, and if there are then
      # we should also look for ways to handle those with the classes.
      #
      def post_process_type_select(content, schema)
        if content.is_a?(Express::TypeSelect)
          if !content.extends.nil?
            content.extends_item = schema.find_namedtype_by_name(content.extends)
          end

          if !content.selectitems.nil?
            select_temp = content.selectitems.to_s.scan(/\w+/)

            select_temp.each do |name|
              thetype = schema.find_namedtype_by_name(name)

              if thetype
                content.selectitems_array.push(thetype)
                thetype.selectedBy.push(content)
              else
                Expressir.ui.error("ERROR : SELECT Item Not Found : " + name)
              end
            end
          end
        end
      end

      # @todo: Existing Code
      #
      # Please revisit this soon, and investigate the actual necessity
      # of this post processing, and if there are anything we can do with
      # the actual instance, specially when we are extracting the instance
      #
      def post_process_golbal_rules(content, schema)
        if content.is_a?(Express::GlobalRule)
          ent_temp = content.entities.to_s.scan(/\w+/)

          ent_temp.each do |name|
            thetype = schema.find_namedtype_by_name(name.to_s)

            if thetype
              content.entities_array.push(thetype)
            else
              Expressir.ui.error("ERROR : Rule Entity Not Found : " + name)
            end
          end
        end
      end

      # @todo: Existing Code
      #
      # Please revisit this soon, and investigate the actual necessity
      # of this post processing, and if there are anything we can do with
      # the actual instance, specially when we are extracting the instance
      #
      def post_process_entity(content, schema)
        if content.is_a?(Express::Entity)
          if content.supertypes
            supername_array = content.supertypes.to_s.scan(/\w+/)

            supername_array.each do |supername|
              thetype = schema.find_namedtype_by_name(supername)

              if thetype
                content.supertypes_array.push(thetype)
              else
                Expressir.ui.error(
                  "ERROR : SUPERTYPE Item Not Found : " + supername,
                )
              end
            end
          end

          if content.supertypes
            content.supertypes_all = get_all_supertypes(content, "")
          end

          if content.supertypes_all
            all_supername_array = content.supertypes_all.scan(/\w+/)

            all_supername_array.each do |supername|
              supertype = schema.find_namedtype_by_name(supername)

              supertype.attributes.each do |superattr|
                content.attributes_all_array.push(superattr)
              end
            end
          end

          content.attributes.each do |localattr|
            content.attributes_all_array.push(localattr)
          end

          attributes_to_remove = []

          content.attributes_all_array.each do |next_attr|
            if next_attr.redeclare_entity
              the_entity = schema.find_namedtype_by_name(
                next_attr.redeclare_entity,
              )

              redattr_name = next_attr.redeclare_oldname || next_attr.name
              the_attr = the_entity.find_attr_by_name(redattr_name)
              attributes_to_remove.push(the_attr)
            end
          end

          attributes_to_remove.each do |attribute_remove|
            content.attributes_all_array.delete(attribute_remove)
          end

          subarray = schema.contents.select do |con|
            con.is_a?(Express::Entity) && con.supertypes
          end

          subarray.each do |subptr|
            subname_array = subptr.supertypes.to_s.scan(/\w+/)
            if subname_array.include?(content.name)
              content.subtypes_array.push(subptr)
            end
          end
        end
      end

      # @todo: Existing Code
      #
      def get_all_supertypes(content, superlist)
        if content.supertypes != nil
          superlist = content.supertypes.to_s + " " + superlist

          content.supertypes_array.each do |sup|
            superlist = get_all_supertypes(sup, superlist)
          end
        end

        superlist.lstrip
      end
    end
  end
end
