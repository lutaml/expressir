require 'erb'
# EXPRESS to OWL Structural Mapping
# Version 0.1
#
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-OWL mapping using Ruby ERB templates.
# Entity Types and Subtypes are mapped to OWL Class hierarchy.
# Select Types are mapped to OWL Class hierarchy.
# Enumeration Type and BOOLEAN attributes are mapped to OWL DatatypeProperties.
# The necessary import of the Dublin Core OWL is included.
# Annotations are added if not 'nil'.
# The output is in OWL RDF/XML abbreviated syntax.
# 
def map_from_express( mapinput )

# Add RDFS andor Dublin Core basic annotations

annotation_list = Array.new
annotation_list[0] = ['dc:source','ISO 10303-227 Plant Spatial Configuration ARM EXPRESS']
annotation_list[1] = ['dcterms:created','2009-09-23']
annotation_list[2] = ['dc:creator', 'David Price, Eurostep Limited']
annotation_list[3] = ['rdfs:comment', nil]
annotation_list[4] = ['owl:versionInfo', '1']

# add common string attributes to use OWL Thing as domain rather than schema classes
thing_attributes = []
thing_attributes.push 'id'
thing_attributes.push 'name'
thing_attributes.push 'description'

# datatypes for simple and aggregates of simple type
datatype_hash = Hash.new
datatype_hash["INTEGER"] = 'http://www.w3.org/2001/XMLSchema#integer'
datatype_hash["REAL"] = 'http://www.w3.org/2001/XMLSchema#float'
datatype_hash["NUMBER"] = 'http://www.w3.org/2001/XMLSchema#float'
datatype_hash["BINARY"] = 'http://www.w3.org/2001/XMLSchema#hexBinary'
datatype_hash["BOOLEAN"] = 'http://www.w3.org/2001/XMLSchema#boolean'
datatype_hash["LOGICAL"] = 'http://www.w3.org/2001/XMLSchema#boolean'
datatype_hash["STRING"] = 'http://www.w3.org/2001/XMLSchema#string'

# Template covering the start of the output file 
overall_start_template = %{<rdf:RDF 
xmlns:owl="http://www.w3.org/2002/07/owl#" 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:xsd="http://www.w3.org/2001/XMLSchema#"  
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dcterms="http://purl.org/dc/terms/"}

# Template covering the output file contents for each schema start
schema_start_template = %{xmlns="http://www.reeper.org/<%= schema.name %>#"
xml:base="http://www.reeper.org/<%= schema.name %>#" > 

<owl:Ontology rdf:about='' rdfs:label='<%= schema.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	  
</owl:Ontology>
}

# Template covering the output file contents for each entity type start
entity_start_template = %{
<owl:Class rdf:ID='<%= entity.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
}
# Template covering the output file contents for each entity type end
entity_end_template = %{</owl:Class>  
}

# Template covering the output file contents for each select type start
select_start_template = %{
<owl:Class rdf:ID='<%= select.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
}
# Template covering the output file contents for each select type end
select_end_template = %{</owl:Class>  
}

# Template covering the supertype(s) for each entity type
supertype_template = %{<rdfs:subClassOf rdf:resource='#<%= supertype.name %>' />
}

# Template covering OWL collections of classes
class_collection_template = %{<owl:Class><owl:unionOf rdf:parseType="Collection">
<%  class_name_list.each do |name| %>
    <owl:Class rdf:about='#<%= name %>' />
 <% end %>	  
</owl:unionOf>
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:Class>}

# Template covering abstract entity types
abstract_entity_template = %{<rdfs:subClassOf rdf:resource='#<%= supertype.name %>' />
}

# Template covering the output file contents for each attribute that is an aggregate
attribute_aggregate_template = %{}

# Template covering the output file contents for each attribute that is an aggregate of select of entity
attribute_aggregate_entity_select_template = %{}

# Template covering the output file contents for each attribute that is a select of entity
attribute_entity_select_template = %{}

# Template covering the output file contents for each attribute that is an entity
attribute_entity_template = %{}

# Template covering the output file contents for each attribute
attribute_template = %{}

# Template covering the output file contents for each attribute that is builtin datatype
attribute_builtin_template = %{<owl:DatatypeProperty rdf:ID='<%= attribute_name %>'>
<rdfs:domain rdf:resource='#<%= entity.name %>' />
<rdfs:range rdf:resource='<%= attribute_type %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:DatatypeProperty>
}

# Template covering the output file contents for each attribute that is builtin datatype
attribute_entity_template = %{<owl:ObjectProperty rdf:ID='<%= attribute_name %>'>
<rdfs:domain rdf:resource='#<%= entity.name %>' />
<rdfs:range rdf:resource='#<%= attribute_type %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:ObjectProperty>
}

# Template covering the output file contents for each attribute that is enum datatype
attribute_enum_template = %{<owl:DatatypeProperty rdf:ID='<%= attribute_name %>'>
<rdfs:domain rdf:resource='#<%= entity.name %>' />
   <rdfs:range><owl:DataRange><owl:oneOf><rdf:List>
<%  enumitem_name_list.each do |name| %>
   <rdf:first rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= name %></rdf:first>
 <% if enumitem_name_list[enumitem_name_list.size-1] != name %>	
     <rdf:rest><rdf:List>
 <% end %>	
 <% if enumitem_name_list[enumitem_name_list.size-1] == name %>	
    <rdf:rest rdf:resource="http://www.w3.org/1999/02/22-rdf-syntax-ns#nil"/> </rdf:List>
 <% end %>	
 <% end %>	  
  <% (1..enumitem_name_list.size-1).each do %>
    </rdf:rest></rdf:List>
   <% end %>	 
   </owl:oneOf></owl:DataRange></rdfs:range>
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 	 
</owl:DatatypeProperty>}


# Template covering the output file contents for each schema end
schema_end_template = %{}

# Template covering the end of the output file 
overall_end_template = %{  </rdf:RDF>}

# Set up list of schemas to process, input may be a repository containing schemas or a single schema
if mapinput.kind_of? EXPSM::Repository
	schema_list = mapinput.schemas
elsif mapinput.kind_of? EXPSM::SchemaDefinition
	schema_list = [mapinput]
else
	puts "ERROR : map_from_express input no Repository instance or Schema instance"
	exit
end

for schema in schema_list

# Set up separate file for each schema 
	filename = schema.name.to_s + ".owl"
	file = File.new(filename, "w")

# Evaluate and write file start template 
  res = ERB.new(overall_start_template)
  t = res.result(binding)
	file.puts t

# Evaluate and write schema start template 
	res = ERB.new(schema_start_template)
	t = res.result(binding)
	file.puts t

	select_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::TypeSelect }
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

# Handle select maps to OWL Class 

	for select in select_list
# Evaluate and write select start template 
		res = ERB.new(select_start_template)
		t = res.result(binding)
		file.puts t
    file.puts '<owl:equivalentClass>'
		class_name_list = select.selectitems.scan(/\w+/)
		res = ERB.new(class_collection_template)
		t = res.result(binding)
		file.puts t
    file.puts '</owl:equivalentClass>'

# Evaluate and write select end template 
		res = ERB.new(select_end_template)
		t = res.result(binding)
		file.puts t
	end

# Handle entity maps to OWL Class 

	for entity in entity_list
# Evaluate and write entity start template 
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t

		for supertype in entity.supertypes_array
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end
# Evaluate and write entity end template 
		res = ERB.new(entity_end_template)
		t = res.result(binding)
		file.puts t
	end

# Handle mapping general attributes to OWL DatatypeProperties 

	for a in thing_attributes
		file.puts '<owl:DatatypeProperty rdf:ID="' + a + '"><rdfs:range rdf:resource="http://www.w3.org/2001/XMLSchema#string"/></owl:DatatypeProperty>'
	end

	for entity in entity_list
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list

			if attr.isBuiltin and !thing_attributes.include?(attr.name)
				attribute_type = datatype_hash[attr.domain]
				attribute_name = entity.name + '.' + attr.name
				res = ERB.new(attribute_builtin_template)
				t = res.result(binding)
				file.puts t
			end

			if NamedType.find_by_name( attr.domain ).kind_of? EXPSM::TypeEnum
				attribute_name = entity.name + '.' + attr.name
				enumitem_name_list = NamedType.find_by_name( attr.domain ).items.scan(/\w+/)
				res = ERB.new(attribute_enum_template)
				t = res.result(binding)
				file.puts t
			end

			if attr.redeclare_entity
				puts "#WARNING: '" + entity.name + ' ' + attr.name + "' Attribute redeclaration may need hand editing"
			end

			if attr.instance_of? EXPSM::ExplicitAggregate
			else
			end
		end

	end

# Handle mapping general attributes to OWL ObjectProperties 
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }
	for entity in entity_list
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		attr_list = attr_list.reject { |a| a.isBuiltin }
		for attr in attr_list
			domain_type = NamedType.find_by_name( attr.domain )
			if !attr.redeclare_entity and (domain_type.kind_of? EXPSM::Entity or domain_type.kind_of? EXPSM::TypeSelect)
				attribute_type = attr.domain
				attribute_name = entity.name + '.' + attr.name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t
			end
			if attr.redeclare_entity
				puts "#WARNING: '" + entity.name + ' ' + attr.name + "' Attribute redeclaration may need hand editing"
			end
			if attr.instance_of? EXPSM::ExplicitAggregate
			else
			end
		end
	end

	res = ERB.new(schema_end_template)
	t = res.result(binding)
	file.puts t

end

res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t
end
