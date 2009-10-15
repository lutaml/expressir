require 'erb'
# EXPRESS to UML 2 Mapping
# Version 0.1
#
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-UML2 (2.1.2) mapping using Ruby ERB templates.
# The output is in XMI 2.1 syntax.
# 
# Integer, Boolean, String -> UML equivalent builtin type
# Real, Number, Binary, Logical -> New PrimitiveType
# Schema -> Package
# Entity (subtype of) -> Class (Generalization)
# Select Type -> Interface and InterfaceRealization
# Enum Type -> Enumeration and EnumerationLiteral
# Explicit Attribute (Optional) Primitive or Enum -> Property owned by Class (with lower)
#
#######################################################################################

def map_from_express( mapinput )

# datatypes for simple and aggregates of simple type
datatype_hash = Hash.new
datatype_hash["INTEGER"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#Integer'
# datatype_hash["REAL"] = 'http://www.w3.org/2001/XMLSchema#float'
# datatype_hash["NUMBER"] = 'http://www.w3.org/2001/XMLSchema#float'
# datatype_hash["BINARY"] = 'http://www.w3.org/2001/XMLSchema#hexBinary'
datatype_hash["BOOLEAN"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#Boolean'
# datatype_hash["LOGICAL"] = 'http://www.w3.org/2001/XMLSchema#boolean'
datatype_hash["STRING"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#String'

# XMI File Start Template
overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?>
<uml:Model xmi:version = "2.1" xmlns:xmi = "http://schema.omg.org/spec/XMI/2.1" xmlns:uml = "http://schema.omg.org/spec/UML/2.1.2" name = "UMLfromEXPRESS" xmi:id = "_0">
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="REAL" name="Real" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="NUMBER" name="Number" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="BINARY" name="Binary" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="LOGICAL" name="Logical" />}

# XMI File End Template
overall_end_template = %{  </uml:Model>}

# SCHEMA Start Template
schema_start_template = %{<packagedElement xmi:type = "uml:Package" xmi:id = "_1_<%= schema.name %>" name = "<%= schema.name %>" visibility = "public">}

# SCHEMA End Template
schema_end_template = %{</packagedElement>}

# ENTITY Start Template
entity_start_template = %{<packagedElement xmi:type = "uml:Class" xmi:id = "<%= xmiid %>" name = "<%= entity.name %>" isAbstract = "FALSE" visibility = "public">}

# SUBTYPE OF Template
supertype_template = %{<generalization xmi:type="uml:Generalization" xmi:id="<%= xmiid %>" general="<%= xmiid_supertype %>"/>}

# ENTITY End Template
entity_end_template = %{</packagedElement>}

# ENUMERATION Start Template
enum_start_template = %{<packagedElement xmi:type = "uml:Enumeration" xmi:id = "<%= enum_xmiid %>" name = "<%= enum.name %>">}

# ENUMERATION ITEM Template
enum_item_template = %{<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= enumitem_xmiid %>" name="<%= enumitem %>" classifier="<%= enum_xmiid %>" enumeration="<%= enumitem_xmiid %>">
<specification xmi:type="uml:LiteralInteger" xmi:id="<%= enumitem_xmiid + '_specification' %> "/>
</ownedLiteral>}

# ENUMERATION End Template
enum_end_template = %{</packagedElement>}

# SELECT Start Template
select_start_template = %{<packagedElement xmi:type = "uml:Interface" xmi:id = "<%= xmiid %>" name = "<%= select.name %>" isAbstract = "TRUE" visibility = "public">}

# SELECT ITEM IS ENTITY Template
selectitem_entity_template = %{ <interfaceRealization xmi:type="uml:InterfaceRealization" xmi:id="<%= xmiid %>" supplier="<%= xmiid_supplier %>" client="<%= xmiid_client %>" contract="<%= xmiid_supplier %>" implementingClassifier="<%= xmiid_client %>"/>}

# SELECT ITEM IS SELECT Template
selectitem_select_template = %{ <interfaceRealization xmi:type="uml:InterfaceRealization" xmi:id="<%= xmiid %>" supplier="<%= xmiid_supplier %>" client="<%= xmiid_client %>" contract="<%= xmiid_supplier %>" implementingClassifier="<%= xmiid_client %>"/>}

# SELECT End Template
select_end_template = %{</packagedElement>}

# Template covering abstract entity types
abstract_entity_template = %{}

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

# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
attribute_builtin_template = %{
<% if datatype_hash[attr.domain] != nil %>
<ownedAttribute xmi:type="uml:Property" xmi:id="_<%= schema.name %>-<%= entity.name %>-<%= attr.name %>" name="<%= attr.name %>" visibility="public">
<type xmi:type="uml:PrimitiveType" href="<%= datatype_hash[attr.domain] %>"/>
<% end %>	
<% if datatype_hash[attr.domain] == nil %>
<ownedAttribute xmi:type="uml:Property" xmi:id="_<%= schema.name %>-<%= entity.name %>-<%= attr.name %>" name="<%= attr.name %>" visibility="public" type="<%= attr.domain %>" >
<% end %>	
 <% if attr.isOptional == TRUE %>	
   <lowerValue xmi:type="uml:LiteralInteger" xmi:id="_<%= schema.name %>-<%= entity.name %>-<%= attr.name %>_lowerValue"/>
 <% end %>	
</ownedAttribute>}

# Template covering the output file contents for each attribute that is builtin datatype
attribute_entity_template = %{}

# EXPLICIT ATTRIBUTE ENUM TYPE Template
attribute_enum_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="_<%= schema.name %>-<%= entity.name %>-<%= attr.name %>" name="<%= attr.name %>" visibility="public" type="<%= enum_xmiid %>">
 <% if attr.isOptional == TRUE %>	
   <lowerValue xmi:type="uml:LiteralInteger" xmi:id="_<%= schema.name %>-<%= entity.name %>-<%= attr.name %>_lowerValue"/>
 <% end %>	
</ownedAttribute>}


#############################################################################################
# Set up list of schemas to process, input may be a repository containing schemas or a single schema
#############################################################################################

if mapinput.kind_of? EXPSM::Repository
	schema_list = mapinput.schemas
elsif mapinput.kind_of? EXPSM::SchemaDefinition
	schema_list = [mapinput]
else
	puts "ERROR : map_from_express input no Repository instance or Schema instance"
	exit
end

# Set up separate file for each schema 
	filename = 'Model.xmi'
	file = File.new(filename, "w")

# Evaluate and write file start template 
  res = ERB.new(overall_start_template)
  t = res.result(binding)
	file.puts t

for schema in schema_list

# Evaluate and write schema start template 
	res = ERB.new(schema_start_template)
	t = res.result(binding)
	file.puts t


# Handle enum maps to UML Enumeration
	enum_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum }
	for enum in enum_list

# Evaluate and write enum start template 
		enum_xmiid = '_1_enum_' + schema.name + '-' + enum.name + enum_list.index(enum).to_s
		res = ERB.new(enum_start_template)
		t = res.result(binding)
		file.puts t

		enumitem_name_list = enum.items.scan(/\w+/)
		for enumitem in enumitem_name_list
			enumitem_xmiid = '_1_enumitem_' + schema.name + '-' + enum.name + enum_list.index(enum).to_s + '-' + enumitem
			res = ERB.new(enum_item_template)
			t = res.result(binding)
			file.puts t
		end

# Evaluate and write enum end template 
		res = ERB.new(enum_end_template)
		t = res.result(binding)
		file.puts t
	end

# Handle select maps to UML Interface 
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }
	for select in select_list

# Evaluate and write select start template 
		xmiid = '_1_select_' + schema.name + '-' + select.name + select_list.index(select).to_s
		res = ERB.new(select_start_template)
		t = res.result(binding)
		file.puts t

		for superselect in select_list
			if superselect.selectitems_array.include?(select)
				xmiid = '_2_superselect_' + schema.name + '-' + select.name + select_list.index(select).to_s + '-' + superselect.name
				xmiid_supertype = '_1_select_' + schema.name + '-' + superselect.name + select_list.index(superselect).to_s
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write select end template 
		res = ERB.new(select_end_template)
		t = res.result(binding)
		file.puts t
	end

# Handle entity maps to UML Class 
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }
	for entity in entity_list
# Evaluate and write entity start template 
		xmiid = '_1_entity_' + schema.name + '-' + entity.name + entity_list.index(entity).to_s
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t

		for supertype in entity.supertypes_array
			xmiid = '_2_supertype_' + schema.name + '-' + entity.name + entity_list.index(entity).to_s + '-' + supertype.name
			xmiid_supertype = '_1_entity_' + schema.name + '-' + supertype.name + entity_list.index(supertype).to_s
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end

		for select in select_list
			if select.selectitems_array.include?(entity)
				xmiid = '_2_selectitem_' + schema.name + '-' + entity.name + entity_list.index(entity).to_s + '-' + select.name
				xmiid_supplier = '_1_select_' + schema.name + '-' + select.name + select_list.index(select).to_s
				xmiid_client = '_1_entity_' + schema.name + '-' + entity.name + entity_list.index(entity).to_s
				res = ERB.new(selectitem_entity_template)
				t = res.result(binding)
				file.puts t
			end
		end


		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list

			if attr.isBuiltin and !attr.instance_of? EXPSM::ExplicitAggregate
				attrout_type = datatype_hash[attr.domain]
				attrout_name = entity.name + '.' + attr.name
				res = ERB.new(attribute_builtin_template)
				t = res.result(binding)
				file.puts t
			end

			if NamedType.find_by_name( attr.domain ).kind_of? EXPSM::TypeEnum
				attrout_name = entity.name + '.' + attr.name
				enum_xmiid = '_1_enum_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name + enum_list.index(NamedType.find_by_name( attr.domain )).to_s
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


# Evaluate and write entity end template 
		res = ERB.new(entity_end_template)
		t = res.result(binding)
		file.puts t
	end


	res = ERB.new(schema_end_template)
	t = res.result(binding)
	file.puts t

end

res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t
end
