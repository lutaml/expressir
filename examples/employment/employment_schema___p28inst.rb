def read_P28_entity_instances(p28doc,m)
  uos = p28doc.root
  for entity in uos.elements.to_a()
    id = entity.attribute('id')
    if entity.name == 'Person'
      r = EMP::Person.new
      m.model_elements.push r
      r.putP28id(id.to_s)
    end
    if entity.name == 'Organization'
      r = EMP::Organization.new
      m.model_elements.push r
      r.putP28id(id.to_s)
    end
    if entity.name == 'PersonOrganizationRelationship'
      r = EMP::PersonOrganizationRelationship.new
      m.model_elements.push r
      r.putP28id(id.to_s)
    end
    if entity.name == 'Employment'
      r = EMP::Employment.new
      m.model_elements.push r
      r.putP28id(id.to_s)
    end
  end
end
