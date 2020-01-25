## EXPRESS STEPMod Model Ruby Classes
## Version 0.1
##
## The Ruby classes in the model are based on the STEPMod DTD.
##

## process descriptions in external XML file
def load_descriptions( descxml, therepos )

  desc_list = descxml.elements.to_a("//ext_descriptions/ext_description")
  desclinkend_list = []
  XPath.each( descxml, '//ext_descriptions/ext_description/@linkend' ) { |n| desclinkend_list.push n.to_s }
  count_desc = desc_list.size
  puts "-- Processing descriptions . Count is #{count_desc.to_s}"

  for schema in therepos.schemas

    for decl in schema.contents
      if decl.kind_of? EXPSM::Entity
        pos = desclinkend_list.index(schema.name + '.' + decl.name)
        if pos != nil
          if desc_list[pos].has_elements?
            defn = 'ELEMENTS_FOUND'
          else
            defn = desc_list[pos].text
          end
          defn = defn.gsub('"','*')
          decl.definition = defn.strip
        end
      end
    end
  end
end

