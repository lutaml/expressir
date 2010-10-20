require 'erb'
# EXPRESS to OWL Structural Mapping
# Version 0.2
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-OWL mapping using Ruby ERB templates.
#
# Configurable items are:
# If file named definitions.csv is found, definitions of items are read from that CSV.
#    Double quotes around ITEM and DEFINITION column values is required
# include_dublin_core - If true, import of the Dublin Core OWL is included. Set to true if dc used in annotation_list
# annotation_list - added to each construct created if found. Annotations are added if not 'nil'.
# usr_base of namespace for OWL constructs
# top_class - if not nil, makes every OWL class created a subclass if this class which is added to output
# thing_attributes - if specified, OWL domain is not set so they apply to OWL Thing
# datatype_hash - sets mappings for EXPRESS builtin to XSD datatypes
#

# Entity Types and Subtypes are mapped to OWL Class hierarchy.
# Select Types that resolve to all Entity Types are mapped to OWL Class hierarchy.
# Select Types that resolve to all Type are mapped to RDFS Datatype.
# Type = builtin are mapped to RDFS Datatypes that subtype XSD datatypes
# Explicit attrs of Type = builtin are mapped to OWL DatatypeProperties
# Enumeration Type and BOOLEAN attributes are mapped to OWL DatatypeProperties.
# The output is in OWL RDF/XML abbreviated syntax.


# 
def map_from_express( mapinput )

# Mapping Configuration Starts Here

# Set the base of the URI (i.e. the namespace) for OWL constructs created during the mapping
uri_base = 'http://www.navsea.navy.mil'

# Add RDFS andor Dublin Core basic annotations (rdfs:comment must be position zero as definition assignment hardcoded there)  

annotation_list = Array.new
#annotation_list[2] = ['dc:source','ISO 10303-227 Plant Spatial Configuration ARM EXPRESS']
annotation_list[3] = ['dcterms:created','2010-09-21']
annotation_list[2] = ['dc:creator', 'David Price, TopQuadrant Limited']
annotation_list[0] = ['rdfs:comment', nil]
annotation_list[4] = ['dc:source', 'OASIS PLCS TC modified ISO 10303-239 Edition 1 PLCS ARM Long Form EXPRESS']
annotation_list[1] = ['owl:versionInfo', '1']

include_dublin_core = true

# Read definitions from csv file if found
definition_hash = Hash.new
if FileTest.exist?('definitions.csv')
	require 'csv'
	puts '-- Definitions CSV File Found'
	CSV.open('definitions.csv', 'r') do |row|
		definition_hash[row[0].downcase] = row[1]
	end
end

# set to class name (e.g. 'TOP-THING') to make all created OWL Classes subclasses of a topmost class
top_class = 'AP239-ARM-THING'

# add common string attributes to use OWL Thing as domain rather than schema classes
thing_attributes = []
#thing_attributes.push 'id'
#thing_attributes.push 'name'
#thing_attributes.push 'description'

# datatypes for simple and aggregates of simple type
datatype_hash = Hash.new
datatype_hash["INTEGER"] = 'http://www.w3.org/2001/XMLSchema#integer'
datatype_hash["REAL"] = 'http://www.w3.org/2001/XMLSchema#float'
datatype_hash["NUMBER"] = 'http://www.w3.org/2001/XMLSchema#float'
datatype_hash["BINARY"] = 'http://www.w3.org/2001/XMLSchema#hexBinary'
datatype_hash["BOOLEAN"] = 'http://www.w3.org/2001/XMLSchema#boolean'
datatype_hash["LOGICAL"] = 'http://www.w3.org/2001/XMLSchema#boolean'
datatype_hash["STRING"] = 'http://www.w3.org/2001/XMLSchema#string'


######### Mapping Configuration Ends Here ##############33


# Template covering the start of the output file 
overall_start_template = %{<rdf:RDF 
xmlns:owl="http://www.w3.org/2002/07/owl#" 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:xsd="http://www.w3.org/2001/XMLSchema#"  
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
<% if include_dublin_core %>	  
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dcterms="http://purl.org/dc/terms/"
<% end %>	  
}

# Template covering the output file contents for each schema start
schema_start_template = %{xmlns="<%= uri_base %>/<%= schema.name %>#"
xml:base="<%= uri_base %>/<%= schema.name %>#" > 

<owl:Ontology rdf:about='' rdfs:label='<%= schema.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	  
<% if include_dublin_core %>	
<owl:imports rdf:resource="http://purl.org/dc/terms/"/>
<owl:imports rdf:resource="http://purl.org/dc/elements/1.1/"/>
<% end %>	  
</owl:Ontology>
<% if top_class != nil %>	
<owl:Class rdf:ID='<%= top_class %>' />
<% end %>
}

# Template covering the output file contents for each entity type start
entity_start_template = %{
<owl:Class rdf:ID='<%= entity.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
}
# Template covering the output file contents for each entity type end
entity_end_template = %{
<% if top_class != nil %>	
<rdfs:subClassOf rdf:resource='#<%= top_class %>' />
<% end %>
</owl:Class>  
}

# Template covering the output file contents for each select type start
select_start_template = %{
<owl:Class rdf:ID='<%= select.name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
}
# Template covering the output file contents for each select type end
select_end_template = %{<% if top_class != nil %>	
<rdfs:subClassOf rdf:resource='#<%= top_class %>' />
<% end %>
</owl:Class>  
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
</owl:Class>}


# Template covering OWL collections of RDFS datatypes
datatype_collection_template = %{<rdfs:Datatype rdf:ID='<%= type_name %>'>
<owl:equivalentClass><rdfs:Datatype><owl:unionOf rdf:parseType="Collection">
<%  type_name_list.each do |name| %>
    <rdf:Description rdf:ID='<%= name %>' />
 <% end %>
</owl:unionOf> 
</rdfs:Datatype></owl:equivalentClass>
</rdfs:Datatype>}

# Template covering abstract entity types
abstract_entity_template = %{<rdfs:subClassOf rdf:resource='#<%= supertype.name %>' />
}

# Template covering the output file contents for each defined type of builtin datatype
type_builtin_template = %{
<rdfs:Datatype rdf:ID='<%= type_builtin.name %>'>
<rdfs:subClassOf rdf:resource='<%= type_builtin_datatype %>'/>
</rdfs:Datatype>
}

# Template covering the output file contents for each attribute that is an aggregate
attribute_aggregate_template = %{}

# Template covering the output file contents for each attribute that is an aggregate of select of entity
attribute_aggregate_entity_select_template = %{}

# Template covering the output file contents for each attribute that is a select of entity
attribute_entity_select_template = %{}

# Template covering the output file contents for each attribute
attribute_template = %{}

# Template covering the output file contents for each attribute that is builtin datatype
attribute_builtin_template = %{<owl:DatatypeProperty rdf:ID='<%= owl_property_name %>'>
<% if owl_property_domain != nil %>	
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
 <% end %>
<rdfs:range rdf:resource='<%= owl_property_range %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:DatatypeProperty>
}

# Template covering the output file contents for each attribute that is builtin datatype
attribute_typebuiltin_template = %{<owl:DatatypeProperty rdf:ID='<%= owl_property_name %>'>
<% if owl_property_domain != nil %>	
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
 <% end %>
<rdfs:range rdf:resource='#<%= owl_property_range %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:DatatypeProperty>
}

# Template covering the output file contents for each attribute that is entity or select type
attribute_entity_template = %{<owl:ObjectProperty rdf:ID='<%= owl_property_name %>'>
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
<rdfs:range rdf:resource='#<%= owl_property_range %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
</owl:ObjectProperty>
}

# Template covering the output file contents for each attribute that is enum datatype
attribute_enum_template = %{<owl:DatatypeProperty rdf:ID='<%= owl_property_name %>'>
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
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

# A recursive function to return complete set of items, following nested selects, for a select that are not selects themselves
def get_all_selections( item_list )
	select_items = item_list.find_all{ |a| a.kind_of? EXPSM::TypeSelect}
	if select_items.size == 0
		return item_list
	end
	temp_item_list = item_list
	for select in select_items
		temp_item_list.delete( select )
		temp_item_list = temp_item_list + select.selectitems_array
	end
	final_list = get_all_selections( temp_item_list )
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
	defined_type_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Type }


# Handle defined type maps to RDFS Datatype 

	for type_builtin in defined_type_list
		if type_builtin.isBuiltin
			type_builtin_datatype = datatype_hash[type_builtin.domain]
			res = ERB.new(type_builtin_template)
			t = res.result(binding)
			file.puts t
		end
	end

# Handle select maps to OWL Class hierarchy and RDFS Datatypes

	for select in select_list
		class_name_list = select.selectitems.scan(/\w+/)

		this_select_all_items = get_all_selections( select.selectitems_array )
		this_select_type_items = this_select_all_items.find_all{ |a| a.kind_of? EXPSM::Type}

		case
		when this_select_type_items.size == 0
		
# Evaluate and write select start template 
			res = ERB.new(select_start_template)
			t = res.result(binding)
			file.puts t
		    file.puts '<owl:equivalentClass>'		
			res = ERB.new(class_collection_template)
			t = res.result(binding)
			file.puts t
		    file.puts '</owl:equivalentClass>'

# Evaluate and write select end template 
			res = ERB.new(select_end_template)
			t = res.result(binding)
			file.puts t
		when this_select_type_items.size == this_select_all_items.size
			type_name_list = class_name_list
			type_name = select.name
			res = ERB.new(datatype_collection_template)
			t = res.result(binding)
			file.puts t
		else
			puts "#WARNING: '" + select.name +  "' Select Type of Mixed Types and Entites not mapped"
		end
	end

# Handle entity maps to OWL Class 

	for entity in entity_list
# Evaluate and write entity start template
		if definition_hash[entity.name.downcase] != nil
			annotation_list[0] = ['rdfs:comment', definition_hash[entity.name.downcase]]
		else
			annotation_list[0] = ['rdfs:comment', nil]
		end
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

	# Handle mapping common string attributes to OWL DatatypeProperties of OWL Thing 

	for thing_attribute in thing_attributes
		owl_property_name = thing_attribute
		owl_property_range = 'http://www.w3.org/2001/XMLSchema#string'
		owl_property_domain = nil
		res = ERB.new(attribute_builtin_template)
		t = res.result(binding)
		file.puts t
	end

	for entity in entity_list
		attribute_list = entity.attributes.find_all{ |a| a.kind_of? EXPSM::Explicit and !thing_attributes.include?(a.name)}
		
		for attribute in attribute_list
			
			express_attribute_domain = nil
			if !attribute.isBuiltin
				express_attribute_domain = NamedType.find_by_name( attribute.domain )
			end
			
			case
			when (attribute.isBuiltin)
				owl_property_range = datatype_hash[attribute.domain]
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_builtin_template)
				t = res.result(binding)
				file.puts t

			when (express_attribute_domain.kind_of? EXPSM::TypeEnum)
				owl_property_name = entity.name + '.' + attribute.name
				enumitem_name_list = express_attribute_domain.items.scan(/\w+/)
				owl_property_domain = entity.name
				res = ERB.new(attribute_enum_template)
				t = res.result(binding)
				file.puts t
				
			when (!attribute.redeclare_entity and (express_attribute_domain.kind_of? EXPSM::Entity or express_attribute_domain.kind_of? EXPSM::TypeSelect))
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t
				
			when (!attribute.redeclare_entity and express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin)
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_typebuiltin_template)
				t = res.result(binding)
				file.puts t		
				
			else
				puts "#WARNING: '" + entity.name + ' ' + attribute.name + "' Attribute type not yet mapped"
			end

			if attribute.instance_of? EXPSM::ExplicitAggregate
				puts "#WARNING: '" + entity.name + ' ' + attribute.name + "' Aggregate cardinalities not mapped"
			end
			if attribute.redeclare_entity
				puts "#WARNING: '" + entity.name + ' ' + attribute.name + "' Attribute redeclaration may need hand editing"
			end
		end
	end

	# Handle mapping attribute of entity and select to OWL ObjectProperties 

	res = ERB.new(schema_end_template)
	t = res.result(binding)
	file.puts t

end

res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t
end
