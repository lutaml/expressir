def read_P28_attribute_values(p28doc,m)
  uos = p28doc.root
  for entity in uos.elements.to_a()
    id = entity.attribute('id')
    i = 0
    if entity.name != 'header'
      while i != -1
        tempid = m.model_elements[i].getP28id
        if tempid == id.to_s
          r = m.model_elements[i]
          i = -2
        end
        i = i + 1
      end
    end
    if entity.name == 'Person'
      for child in entity.elements
        if child.name ==  'Names'
          memlist = []
          for member in child.elements
            memlist.push member.text()
          end
          r.names= memlist
        end
       end
    end
    if entity.name == 'Organization'
      for child in entity.elements
        if child.name ==  'Name'
          r.name= child.text()
        end
       end
    end
    if entity.name == 'PersonOrganizationRelationship'
      for child in entity.elements
        if child.name ==  'The_person'
          ref = child.elements[1].attribute('ref')
          i = 0
            while i != -1
              tempid = m.model_elements[i].getP28id.to_s
              if tempid == ref.to_s
                p = m.model_elements[i]
                i = -2
              end
 	          i = i + 1
            end
          r.the_person= p
        end
        if child.name ==  'The_organization'
          ref = child.elements[1].attribute('ref')
          i = 0
            while i != -1
              tempid = m.model_elements[i].getP28id.to_s
              if tempid == ref.to_s
                p = m.model_elements[i]
                i = -2
              end
 	          i = i + 1
            end
          r.the_organization= p
        end
        if child.name ==  'Start_date'
          r.start_date= child.text()
        end
        if child.name ==  'End_date'
          r.end_date= child.text()
        end
       end
    end
    if entity.name == 'Employment'
      for child in entity.elements
        if child.name ==  'The_person'
          ref = child.elements[1].attribute('ref')
          i = 0
            while i != -1
              tempid = m.model_elements[i].getP28id.to_s
              if tempid == ref.to_s
                p = m.model_elements[i]
                i = -2
              end
 	          i = i + 1
            end
          r.the_person= p
        end
        if child.name ==  'The_organization'
          ref = child.elements[1].attribute('ref')
          i = 0
            while i != -1
              tempid = m.model_elements[i].getP28id.to_s
              if tempid == ref.to_s
                p = m.model_elements[i]
                i = -2
              end
 	          i = i + 1
            end
          r.the_organization= p
        end
        if child.name ==  'Start_date'
          r.start_date= child.text()
        end
        if child.name ==  'End_date'
          r.end_date= child.text()
        end
        if child.name ==  'Job_title'
          r.job_title= child.text()
        end
       end
    end
  end
end
