require 'erb'
# EXPRESS to OWL Structural Mapping
# Version 0.4
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-OWL mapping using Ruby ERB templates.
# The output is in OWL RDF/XML abbreviated syntax.
#
# Configurable items are:
# If file named definitions.csv is found, definitions of items are read from that CSV.
#    Double quotes around ITEM and DEFINITION column values is required
# include_dublin_core - If true, import of the Dublin Core OWL is included. Set to true if dc used in annotation_list
# annotation_list - added to each construct created if found. Annotations are added if not 'nil'.
# usr_base of namespace for OWL constructs
# top_class - if not nil, makes every OWL class created a subclass if this class which is added to output
# thing_attributes - if specified, OWL DatatypeProperty domain is set to OWL Thing and range set to string
# datatype_hash - sets mappings for EXPRESS builtin to XSD datatypes
# post_processed_schema - If true, write post-processed schema data (e.g. propety hash) for inclusion in other program or script 
#
# Mappings are:
# Entity Types and Subtypes are mapped to OWL Class hierarchy.
# Entity Type SUPERTYPE OF ONEOF( list-of-EntityTypes ) are mapped to OWL disjoint between Classes	
# Select Types that resolve to all Entity Types are mapped to OWL Class hierarchy.
# Select Types that resolve to all Type are mapped to RDFS Datatype.
# Type = builtin are mapped to RDFS Datatypes that subtype XSD datatypes
# Type of Type of ... that ultimately resolve to builtin are mapped to datatype subtype hierarchy
# Explicit attrs of Type = builtin are mapped to OWL DatatypeProperties
# Type = AGGR are mapped to subClassOf rdf:List
# Explicit attrs of 1-D LIST/ARRAY OF builtin/Type = builtin mapped to OWL ObjectProperty and subClassOf rdf:List and cardinality 1
# Inverse attrs are mapped to OWL DatatypeProperties with inverseOf set, except inverse of inherited not mapped
# Enumeration Type and BOOLEAN attributes are mapped to OWL DatatypeProperties.
# Attribute redeclarations that ref Entity/Select are mapped to ObjectProperty that is subproperty of that it redeclares
# Attribute redeclarations that ref builting simple types are mapped to DatatypeProperty that is subproperty of that it redeclares
# Type = type that is a select are mapped to Class subclass of referenced select Class
# Single Attribute OPTIONAL or not maps to cardinality restriction on Class owning attribute
# 1D SET/BAG Attribute bound maps to cardinality restriction on Class owning attribute
# Explicit attributes of n-dimensional aggregates not supported


# 
def map_from_express( mapinput )
puts ' '
puts 'EXPRESS to OWL Structural Mapping V0.4'
puts ' '

######### Mapping Configuration Starts Here ##############

# Set the base of the URI (i.e. the namespace) for OWL constructs created during the mapping
uri_base = 'http://www.reeper.org'

# Add RDFS andor Dublin Core basic annotations

# Set to true if any annotation_list elements use Dublin Core (dc: or dcterms:)
include_dublin_core = false

annotation_list = Array.new
# rdfs:comment must be position 0 as definition assignment hardcoded there
#annotation_list[0] = ['rdfs:comment', nil]
#annotation_list[1] = ['owl:versionInfo', '1']
#annotation_list[2] = ['dc:creator', 'David Price, TopQuadrant Limited']
#annotation_list[3] = ['dcterms:created','2010-10-22']
#annotation_list[4] = ['dc:source', '{ iso standard 10303 part(214) version(2) object(1) automotive-design-schema(1) }']

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

# Write the property_type_hash for inclusion in other scripts or not
post_processed_schema = false
post_processed_schema_file_name = 'postprocessed_schema.rb'
post_processed_schema_file = File.new(post_processed_schema_file_name,'w')

######### Mapping Configuration Ends Here ##############


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

# Template covering the output file contents for each entity type start or start of type = type that is a select
entity_start_template = %{
<owl:Class rdf:ID='<%= class_name %>' >
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>	 
}
# Template covering the output file contents for each entity type end or end of type = type that is a select
entity_end_template = %{
<% if top_class != nil %>	
<rdfs:subClassOf rdf:resource='#<%= top_class %>' />
<% end %>
</owl:Class>  
}

# Template covering the output file contents for end of type = type that is a select
class_end_template = %{</owl:Class>}

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

# Template covering the supertype(s) for each entity type and type = type that is a select
supertype_template = %{<rdfs:subClassOf rdf:resource='#<%= superclass_name %>' />
}

# Template covering OWL collections of class contents
class_collection_template = %{<owl:Class><owl:unionOf rdf:parseType="Collection">
<%  item_name_list.each do |name| %>
 <rdf:Description rdf:about='#<%= name %>'/>
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
<rdfs:Datatype rdf:ID='<%= datatype_name %>'>
<rdfs:subClassOf rdf:resource='<%= superdatatype_name %>'/>
</rdfs:Datatype>
}

# Template covering the mappings to rdf list
rdflist_template = %{<rdfs:Class rdf:ID='<%= list_name %>'>
<rdfs:subClassOf rdf:resource='<%= superlist_name %>'/>
</rdfs:Class>}

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
<% if owl_super_property_name != nil %>	
<rdfs:subPropertyOf rdf:resource='#<%= owl_super_property_name %>' />
 <% end %>
</owl:DatatypeProperty>
}

# Template covering the output file contents for each attribute that is type that is builtin datatype
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

# Template covering the output file contents for each attribute that is entity or select type
inverse_entity_template = %{<owl:ObjectProperty rdf:ID='<%= owl_property_name %>'>
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
<rdfs:range rdf:resource='#<%= owl_property_range %>' />
<%  annotation_list.each do |i| %><% if i[1] != nil and i[1] != '' %><<%= i[0] %> rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><%= i[1] %></<%= i[0] %>><% end %>
<% end %>
<owl:inverseOf rdf:resource="#<%= owl_inverted_property_name %>"/>	 
</owl:ObjectProperty>
}

# Template covering the output file contents for each attribute that is a redeclaration and reference to an entity or select type
attribute_redeclare_entity_template = %{<owl:ObjectProperty rdf:ID='<%= owl_property_name %>'>
<rdfs:domain rdf:resource='#<%= owl_property_domain %>' />
<rdfs:range rdf:resource='#<%= owl_property_range %>' />
<rdfs:subPropertyOf rdf:resource='#<%= owl_super_property_name %>' />
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



# Template covering min cardinality 
min_cardinality_template = %{<rdf:Description rdf:about='#<%= class_name %>'>
<rdfs:subClassOf>
<owl:Restriction>
<owl:onProperty rdf:resource='#<%= owl_property_name %>'/>
  <owl:minCardinality rdf:datatype="http://www.w3.org/2001/XMLSchema#nonNegativeInteger"><%= min_cardinality %></owl:minCardinality>
</owl:Restriction>
</rdfs:subClassOf>
</rdf:Description>}


# Template covering max cardinality 
max_cardinality_template = %{<rdf:Description rdf:about='#<%= class_name %>'>
<rdfs:subClassOf>
<owl:Restriction>
  <owl:onProperty rdf:resource='#<%= owl_property_name %>'/>
<owl:maxCardinality rdf:datatype="http://www.w3.org/2001/XMLSchema#nonNegativeInteger"><%= max_cardinality %></owl:maxCardinality>
</owl:Restriction>
</rdfs:subClassOf>
</rdf:Description>}

# Template covering cardinality 
cardinality_template = %{<rdf:Description rdf:about='#<%= class_name %>'>
<rdfs:subClassOf>
<owl:Restriction>
  <owl:onProperty rdf:resource='#<%= owl_property_name %>'/>
<owl:cardinality rdf:datatype="http://www.w3.org/2001/XMLSchema#nonNegativeInteger"><%= min_cardinality %></owl:cardinality>
</owl:Restriction>
</rdfs:subClassOf>
</rdf:Description>}

# Template covering the output file contents for each schema end
disjoint_template = %{
<rdf:Description rdf:about='#<%= first_class_name %>'>
<owl:disjointWith rdf:resource="#<%= disjoint_class_name %>"/>
</rdf:Description>}


# Template covering the output file contents for each schema end
schema_end_template = %{}

# Template covering the end of the output file 
overall_end_template = %{  </rdf:RDF>}


def post_process_entity(entity, post_processed_schema_file, datatype_hash)
	attribute_list = entity.attributes_all_array.find_all{ |a| a.kind_of? EXPSM::Explicit}

	for attribute in attribute_list

		express_attribute_domain = nil
		if !attribute.isBuiltin
				express_attribute_domain = NamedType.find_by_name( attribute.domain )
		end
		p28_property_name = entity.name.capitalize + '.' + attribute.name.capitalize
		property_quoted = false
		property_list = false
		property_type = '"' + attribute.domain + '"'
		if attribute.isBuiltin
			property_type = '"' + datatype_hash[attribute.domain] + '"'
		end
		if attribute.isBuiltin and attribute.domain == 'STRING'
			property_quoted = true
		end
		if (!attribute.redeclare_entity and express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin and express_attribute_domain == 'STRING')
			property_quoted = true
			property_type = '"' + datatype_hash[express_attribute_domain.domain] + '"'
		end
		if ( attribute.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'LIST')
			property_list = true
			property_type = '"' + datatype_hash[attribute.domain] + '"'
		end

		if (express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'LIST')
			property_list = true
			property_type = '"' + datatype_hash[express_attribute_domain.domain] + '"'
		end

		property_type = property_type.gsub('http://www.w3.org/2001/XMLSchema#','xsd:')
		post_processed_schema_file.puts 'property_range_hash["' + p28_property_name + '"] = [' + property_quoted.to_s + ',' + property_list.to_s  + ',' + property_type.to_s  + ']' 
	end
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

# A recursive function to return the ultimate underlying type of a type
def is_utlimate_type_builtin( the_type )
	base_type = NamedType.find_by_name( the_type.domain )
	case
		when (base_type.instance_of? EXPSM::TypeSelect or base_type.instance_of? EXPSM::Entity)
			return false
		when (base_type.kind_of? EXPSM::Type and base_type.isBuiltin)
			return true
		else
			return is_utlimate_type_builtin( base_type )
	end
end

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

	type_mapped_list = []
	entity_mapped_list = []
	explicit_mapped_list = []
	inverse_mapped_list = []	
	thing_attr_mapped_list = []
	superexpression_mapped_list = []
	list_mapped_list = []
	all_explicit_list = []
	all_derived_list = []
	all_inverse_list = []
	all_superexpression_list = []

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
	defined_type_not_builtin_list = defined_type_list.find_all{ |e| !e.isBuiltin }
	defined_type_builtin_list = defined_type_list.find_all{ |e| e.isBuiltin }

# Handle defined type maps to RDFS Datatype

	for type_builtin in defined_type_builtin_list

# Handle defined type maps to RDFS Datatype
		if !type_builtin.instance_of? EXPSM::TypeAggregate
			type_mapped_list.push type_builtin
			datatype_name = type_builtin.name
			superdatatype_name = datatype_hash[type_builtin.domain]
			res = ERB.new(type_builtin_template)
			t = res.result(binding)
			file.puts t
# Handle defined type maps to RDF List
		else
			type_mapped_list.push type_builtin
			list_name = type_builtin.name
			superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
			res = ERB.new(rdflist_template)
			t = res.result(binding)
			file.puts t
		end
	end
	

	for type_not_builtin in defined_type_not_builtin_list

		type_domain = NamedType.find_by_name( type_not_builtin.domain )
		type_is_builtin = is_utlimate_type_builtin( type_not_builtin )

		case

# Handle simple defined type refining simple defined type of builtin map to RDFS Datatype
			when (!type_not_builtin.instance_of? EXPSM::TypeAggregate and type_is_builtin and !type_domain.instance_of? EXPSM::TypeAggregate)
			type_mapped_list.push type_not_builtin
			datatype_name = type_not_builtin.name
			superdatatype_name = '#' + type_domain.name
			res = ERB.new(type_builtin_template)
			t = res.result(binding)
			file.puts t

# Handle simple defined type of aggr defined type of builtin map to RDF List
			when (!type_not_builtin.instance_of? EXPSM::TypeAggregate and type_domain.instance_of? EXPSM::TypeAggregate and type_is_builtin)
			type_mapped_list.push type_not_builtin
			list_name = type_not_builtin.name
			superlist_name = '#' + type_domain.name
			res = ERB.new(rdflist_template)
			t = res.result(binding)
			file.puts t

# Handle aggr defined type of simple defined type of builtin map to RDF List
			when (type_not_builtin.instance_of? EXPSM::TypeAggregate and type_domain.instance_of? EXPSM::Type and type_is_builtin)
			type_mapped_list.push type_not_builtin
			list_name = type_not_builtin.name
			superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
			res = ERB.new(rdflist_template)
			t = res.result(binding)
			file.puts t
			

			else
		end
	end

# Handle defined type that are type = type that is a select 

	for type_not_builtin in defined_type_not_builtin_list
 		type_domain = NamedType.find_by_name( type_not_builtin.domain )
 		if type_domain.kind_of? EXPSM::TypeSelect
 			type_mapped_list.push type_not_builtin
			superclass_name = type_not_builtin.domain
			class_name = type_not_builtin.name
			res = ERB.new(entity_start_template)
			t = res.result(binding)
			file.puts t

			superclass_name = type_not_builtin.domain
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		 
			res = ERB.new(class_end_template)
			t = res.result(binding)
			file.puts t
		end
	end

# Handle EXPRESS SELECT Type mapping to OWL Class hierarchy and RDFS Datatypes

	for select in select_list
	
		item_name_list = select.selectitems.scan(/\w+/)

		this_select_all_items = get_all_selections( select.selectitems_array )
		this_select_type_items = this_select_all_items.find_all{ |a| a.kind_of? EXPSM::Type}

		case		
#   Handle case of select items resolving to containing no item that is a non-select Type
		when this_select_type_items.size == 0
			type_mapped_list.push select
			
			res = ERB.new(select_start_template)
			t = res.result(binding)
			file.puts t
	    file.puts '<owl:equivalentClass>'		

			res = ERB.new(class_collection_template)
			t = res.result(binding)
			file.puts t
	    file.puts '</owl:equivalentClass>'

			res = ERB.new(select_end_template)
			t = res.result(binding)
			file.puts t

#   Handle case of select items resolving to containing only items that are non-select Type
		when this_select_type_items.size == this_select_all_items.size
			type_mapped_list.push select
			type_name_list = item_name_list
			type_name = select.name
			res = ERB.new(datatype_collection_template)
			t = res.result(binding)
			file.puts t
			puts 'WARNING: ' + select.name +  ' mapped to RDFS Datatype owl:unionOf of other datatypes, may not be supported in older OWL tools'

#   Warning for case of select items resolving mixed mixed non-select Type and Select/Entity			
		else
			puts "WARNING: '" + select.name +  "' Select Type of Mixed Types and Entites not mapped"
		end
	end

# Handle EXPRESS Entity mappings to OWL Class hierarchy 

	for entity in entity_list

		if definition_hash[entity.name.downcase] != nil
			annotation_list[0] = ['rdfs:comment', definition_hash[entity.name.downcase]]
		else
			annotation_list[0] = ['rdfs:comment', nil]
		end

		entity_mapped_list.push entity

		class_name = entity.name
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t

		for supertype in entity.supertypes_array
			superclass_name = supertype.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end

		res = ERB.new(entity_end_template)
		t = res.result(binding)
		file.puts t

# Post-process the entity
		post_process_entity(entity, post_processed_schema_file, datatype_hash) if post_processed_schema

		
		if entity.superexpression != nil
		all_superexpression_list.push entity 

# Handle simple case of one ONEOF in supertype expression mapped to disjoint between listed subclasses
			case
#			when (entity.superexpression.include?('ONEOF') and !entity.superexpression.include?('ANDOR') and !entity.superexpression.include?('TOTAL_OVER') and !entity.superexpression.include?('AND') and !entity.superexpression.include?('ABSTRACT'))

			when (entity.superexpression.include?('ONEOF'))
				superexpression_mapped_list.push entity	
				tempexpression = entity.superexpression
				if entity.superexpression.index('ONEOF') != 0
					puts 'WARNING: ' + entity.name + ' supertype mapping may be incomplete, only ONEOFs processed'
				end
				while (tempexpression.include?('ONEOF'))
					posoneof = tempexpression.index('ONEOF')
					tempexpression = tempexpression[posoneof + 5,tempexpression.length - 5]
					posclose = tempexpression.index(')')
					oneof_name_list = tempexpression[0,posclose].scan(/\w+/)
					while oneof_name_list.size != 0
						first_class_name = oneof_name_list[0]
						oneof_name_list.delete(first_class_name)
						for disjoint_class_name in oneof_name_list
							res = ERB.new(disjoint_template)
							t = res.result(binding)
							file.puts t
						end
					end
				end
			else
				puts 'WARNING: ' + entity.name + ' supertype expression not mapped'
			end
		
		end
		

	end

# Handle mapping common string attributes to OWL DatatypeProperties of OWL Thing 

	for thing_attribute in thing_attributes
		owl_property_name = thing_attribute
		owl_property_range = 'http://www.w3.org/2001/XMLSchema#string'
		owl_property_domain = nil
		owl_super_property_name = nil
		res = ERB.new(attribute_builtin_template)
		t = res.result(binding)
		file.puts t
	end

# Handle EXPRESS attributes on an entity-by-entity basis
	for entity in entity_list
		
		class_name = entity.name

		attribute_list = entity.attributes.find_all{ |a| a.kind_of? EXPSM::Explicit and !thing_attributes.include?(a.name)}
		thing_attr_list = entity.attributes.find_all{ |a| a.kind_of? EXPSM::Explicit and thing_attributes.include?(a.name)}
		inverse_list = entity.attributes.find_all{ |a| a.kind_of? EXPSM::Inverse and !thing_attributes.include?(a.name)}
		
		thing_attr_mapped_list = thing_attr_mapped_list + thing_attr_list
		
		all_explicit_list = all_explicit_list + entity.attributes.find_all{ |a| a.kind_of? EXPSM::Explicit}
		all_derived_list = all_derived_list + entity.attributes.find_all{ |a| a.kind_of? EXPSM::Derived}

		all_inverse_list = all_inverse_list + inverse_list

# Handle EXPRESS inverse attribute mapping to OWL inverse property		
		for attribute in inverse_list
			if attribute.reverseAttr != []
				inverse_mapped_list.push attribute
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_inverted_property_name = attribute.reverseEntity.name + '.' + attribute.reverseAttr.name
				res = ERB.new(inverse_entity_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Handle EXPRESS explicit attribute mapping to OWL property
		for attribute in attribute_list
			
			express_attribute_domain = nil
			if !attribute.isBuiltin
				express_attribute_domain = NamedType.find_by_name( attribute.domain )
			end
	
			case

# Handle EXPRESS explicit attributes of LIST of built-in simple type, including redeclaration
			when (attribute.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'LIST')
				explicit_mapped_list.push attribute
				list_mapped_list.push attribute
				list_name = entity.name + '.' + attribute.name + '-' + attribute.domain.to_s + '-List'
				superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
				res = ERB.new(rdflist_template)
				t = res.result(binding)
				file.puts t
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_property_range = list_name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attributes of ARRAY of built-in simple type, including redeclaration
			when (attribute.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'ARRAY')
				explicit_mapped_list.push attribute
				list_mapped_list.push attribute
				list_name = entity.name + '.' + attribute.name + '-' + attribute.domain.to_s + '-Array'
				superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
				res = ERB.new(rdflist_template)
				t = res.result(binding)
				file.puts t
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_property_range = list_name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attributes of LIST of TYPE that is built-in simple type, including redeclaration		
			when (express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'LIST')
				explicit_mapped_list.push attribute
				list_mapped_list.push attribute
				list_name = entity.name + '.' + attribute.name + '-' + attribute.domain.to_s + '-List'
				superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
				res = ERB.new(rdflist_template)
				t = res.result(binding)
				file.puts t
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_property_range = list_name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attributes of ARRAY of TYPE that is built-in simple type, including redeclaration		
			when (express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin and attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype = 'ARRAY')
				explicit_mapped_list.push attribute
				list_mapped_list.push attribute
				list_name = entity.name + '.' + attribute.name + '-' + attribute.domain.to_s + '-Array'
				superlist_name = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
				res = ERB.new(rdflist_template)
				t = res.result(binding)
				file.puts t
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_property_range = list_name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t


# Handle EXPRESS explicit attributes of built-in simple type, including redeclaration
			when (attribute.isBuiltin)
				explicit_mapped_list.push attribute
				owl_property_range = datatype_hash[attribute.domain]
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				owl_super_property_name = nil
				if attribute.redeclare_entity != nil
					if attribute.redeclare_oldname == nil
						owl_super_property_name = attribute.redeclare_entity + '.' + attribute.name
					else
						owl_super_property_name = attribute.redeclare_entity + '.' + attribute.redeclare_oldname
					end
				end
				res = ERB.new(attribute_builtin_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attribute, not redeclaration, refers to Type that is Type = builtin datatype				
			when (!attribute.redeclare_entity and express_attribute_domain.instance_of? EXPSM::Type and express_attribute_domain.isBuiltin)
				explicit_mapped_list.push attribute
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_typebuiltin_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attributes of enum type, ignoring redeclarations
			when (express_attribute_domain.kind_of? EXPSM::TypeEnum)
				if !type_mapped_list.include?(express_attribute_domain)
					type_mapped_list.push express_attribute_domain
				end
				explicit_mapped_list.push attribute
				owl_property_name = entity.name + '.' + attribute.name
				enumitem_name_list = express_attribute_domain.items.scan(/\w+/)
				owl_property_domain = entity.name
				res = ERB.new(attribute_enum_template)
				t = res.result(binding)
				file.puts t
				if attribute.redeclare_entity
					puts 'WARNING: ' + entity.name + ' ' + attribute.name + ' Attribute redeclaration for Enumerations not mapped'
				end

# Handle EXPRESS explicit attribute, not redeclaration, and only refer to EXPRESS Select or Entity				
			when (!attribute.redeclare_entity and (express_attribute_domain.kind_of? EXPSM::Entity or express_attribute_domain.kind_of? EXPSM::TypeSelect))
				explicit_mapped_list.push attribute
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attribute, redeclaration,	and only refer to EXPRESS Select or Entity	
			when (attribute.redeclare_entity and (express_attribute_domain.kind_of? EXPSM::Entity or express_attribute_domain.kind_of? EXPSM::TypeSelect))
				explicit_mapped_list.push attribute
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				if attribute.redeclare_oldname == nil
					owl_super_property_name = attribute.redeclare_entity + '.' + attribute.name
				else
					owl_super_property_name = attribute.redeclare_entity + '.' + attribute.redeclare_oldname
				end
				owl_property_domain = entity.name
				res = ERB.new(attribute_redeclare_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attribute of EXPRESS Type = A Type name that is a Select					
			when (express_attribute_domain.kind_of? EXPSM::Type and NamedType.find_by_name( express_attribute_domain.domain ).kind_of? EXPSM::TypeSelect)
				explicit_mapped_list.push attribute
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				owl_property_domain = entity.name
				res = ERB.new(attribute_entity_template)
				t = res.result(binding)
				file.puts t

# Handle EXPRESS explicit attribute, redeclaration,	and only refer to EXPRESS Type = A Type name that is a Select						
			when (attribute.redeclare_entity and (express_attribute_domain.kind_of? EXPSM::Type and NamedType.find_by_name( express_attribute_domain.domain ).kind_of? EXPSM::TypeSelect))
	
				explicit_mapped_list.push attribute		
				owl_property_range = attribute.domain
				owl_property_name = entity.name + '.' + attribute.name
				if attribute.redeclare_oldname == nil
					owl_super_property_name = attribute.redeclare_entity + '.' + attribute.name
				else
					owl_super_property_name = attribute.redeclare_entity + '.' + attribute.redeclare_oldname
				end
				owl_property_domain = entity.name
				res = ERB.new(attribute_redeclare_entity_template)
				t = res.result(binding)
				file.puts t

			else
				puts 'WARNING: ' + entity.name + ' ' + attribute.name + ' Attribute type not yet mapped'
			end

			min_cardinality = 1
			max_cardinality = 1
	
			if attribute.isOptional == true
				min_cardinality = 0
			end

			if (attribute.instance_of? EXPSM::ExplicitAggregate and attribute.rank == 1 and attribute.dimensions[0].aggrtype != 'LIST' and attribute.dimensions[0].aggrtype != 'ARRAY')
				if attribute.isOptional == false
					min_cardinality = attribute.dimensions[0].lower.to_i
				end
				if attribute.dimensions[0].upper == '?'
					max_cardinality = -1
				else
					max_cardinality = attribute.dimensions[0].upper.to_i
				end
				if attribute.rank > 1
					puts 'WARNING: ' + owl_property_name + ' n-dimensional aggregate attribute cardinalities not mapped ' 
					max_cardinality = -1
				end
			end			
			
			if min_cardinality == max_cardinality
				res = ERB.new(cardinality_template)
				t = res.result(binding)
				file.puts t
			else
				res = ERB.new(min_cardinality_template)
				t = res.result(binding)
				file.puts t
				if max_cardinality != -1
					res = ERB.new(max_cardinality_template)
					t = res.result(binding)
					file.puts t
				end
			end			


			if (attribute.redeclare_entity and !(express_attribute_domain.kind_of? EXPSM::Entity or express_attribute_domain.kind_of? EXPSM::TypeSelect))
				if 	(attribute.redeclare_entity and !(express_attribute_domain.kind_of? EXPSM::Type and NamedType.find_by_name( express_attribute_domain.domain ).kind_of? EXPSM::TypeSelect))
					if (attribute.redeclare_entity and !attribute.isBuiltin)
						puts 'WARNING: ' + entity.name + ' ' + attribute.name + ' Attribute redeclaration may need hand editing'
					end
				end
			end
			
		end

	end


	res = ERB.new(schema_end_template)
	t = res.result(binding)
	file.puts t
	
	puts ' '
	puts 'Schema Mapping Summary for : ' + schema.name
	all_type_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::DefinedType }
	
	
	puts '  ENTITYs mapped = ' + entity_mapped_list.size.to_s + ' of ' + entity_list.size.to_s
	puts '  - ' + superexpression_mapped_list.size.to_s + ' of ' + all_superexpression_list.size.to_s + ' ENTITY SUPERTYPE expressions mapped (only simple ONEOF supported)'	
	puts '  - ' + inverse_mapped_list.size.to_s + ' of ' + all_inverse_list.size.to_s + ' inverse attributes mapped (inverse of inherited not supported)'	
	notmapped_list = all_inverse_list - inverse_mapped_list
	for t in notmapped_list
		puts '  - Not mapped: ' + t.entity.name + '.' + t.name
	end	
	puts '  - ' + explicit_mapped_list.size.to_s + ' of ' + all_explicit_list.size.to_s + ' explicit attributes mapped, ' + list_mapped_list.size.to_s + ' mapped as rdf:List'
	puts '  - ' + thing_attr_mapped_list.size.to_s + ' of ' + all_explicit_list.size.to_s + ' explicit attributes mapped with owl:Thing as domain (configurable)'	
	notmapped_list = all_explicit_list - explicit_mapped_list - thing_attr_mapped_list
	for t in notmapped_list
		puts '  - Not mapped: ' + t.entity.name + '.' + t.name
	end
	puts '  - Zero of ' + all_derived_list.size.to_s + ' derived attributes mapped (not supported)'

	puts '  - Ordering for 1-D List/Array of (TYPE) builtin mapped to rdf:List (others not supported)'
	puts '  TYPEs mapped = ' + type_mapped_list.size.to_s + ' of ' + all_type_list.size.to_s
	notmapped_list = all_type_list - type_mapped_list
	for t in notmapped_list
		puts '  - Not mapped: ' + t.name
	end
	puts ' '
	puts 'Wrote post-processed schema to file: ' + post_processed_schema_file_name if post_processed_schema

end

res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t

post_processed_schema_file.close if post_processed_schema

end
