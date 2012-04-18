require 'erb'
require 'uuid'
require 'nokogiri'
include Nokogiri

# EXPRESS to SysML Mapping
# Version 0.1
#
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-SysML (1.2) mapping using Ruby ERB templates.
# The output is in XMI 2.1 syntax in a file named <schema>.xmi if one schema input and 'Model.xmi' if more than one schema input.
# 
# Real, Number, Integer, Boolean, String -> SysML equivalent builtin type
# Binary, Logical -> New PrimitiveType
# Schema -> Package
# Entity (subtype of) -> Class (Generalization) + Block stereotype
# Select Type -> Class & Generalization + Block/value  and <<Auxillary>> stereotype
# Enum Type -> Enumeration and EnumerationLiteral
# Explicit Attribute (Optional) Primitive or Enum -> Property owned by Class (with lower)
# Explicit Attribute (Optional) Entity -> Property owned by Class (with lower) plus Association owning other end property
# Explicit Attribute 1-D SET, BAG, LIST of Select or Entity -> Property owned by Class (with lower) 
#                                    plus Association owning other end property and multiplicity, unique and ordered set
# Explicit Attribute 1-D SET, BAG, LIST of Primitive or Enum -> Property owned by Class and multiplicity, unique and ordered set
# Explicit Attribute of Entity/Select/Builtin Redeclaration (Renamed) -> Property with (new) name that redefines inherited Property
# Inverse Attribute -> Association end adjustment
# Inverse Attribute Redeclaration (Renamed) -> Property with (new) name that redefines inherited Property
# USE or REFERENCE (even with named items) -> UML PackageImport between Packages
#
#######################################################################################
$uuid = UUID.new

def get_uuid(id)
	uuidmap = $uuidxml.xpath('//uuidmap[@id="' + id + '"]').first
	if uuidmap != nil
		return uuidmap.attributes["uuid"].to_s.strip
	else
		theUUID = $uuid.generate
		uuidtext = theUUID.to_s.strip
		uuidmap = Nokogiri::XML::Node.new("uuidmap", $uuidxml)
		uuidmap['id'] = id
		uuidmap['uuid'] = theUUID
		$uuidxml.root.add_child uuidmap
		return theUUID
	end
end

def isEncapsulated (type)
	encapsulated = type.wheres.select {|w| w.name == "encapsulated"}.length	> 0	
	if (type.kind_of? EXPSM::Entity) && !encapsulated
		for supertype in type.supertypes_array
			encapsulated = isEncapsulated(supertype)
			if encapsulated
				break
			end
		end	
	end
	return encapsulated
end

def map_from_express( mapinput )
# Enter file name here to override defaults (<schema>.xmi if one schema, and Model.xmi if more than one)
output_xmi_filename = nil

uuidfile = File.open("UUIDs.xml")
$uuidxml = Nokogiri::XML(uuidfile)

# datatypes for builtin types that map directly to SysML
datatype_hash = Hash.new

# XMI File Start Template (includes datatypes for builtin with no direct UML equivalent)
overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:uml="http://www.omg.org/spec/UML/20090901" xmlns:StandardProfileL2="http://schema.omg.org/spec/UML/2.3/StandardProfileL2.xmi" xmlns:sysml="http://www.omg.org/spec/SysML/20100301/SysML-profile">
<uml:Model name="Data" xmi:id="_0_Data" xmi:uuid="<%= get_uuid('_0_Data') %>">
<packagedElement xmi:type="uml:Package" xmi:id="_0_SysMLfromEXPRESS" xmi:uuid="<%= get_uuid('_0_SysMLfromEXPRESS') %>" name="SysMLfromEXPRESS">
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="BINARY" xmi:uuid="<%= get_uuid('BINARY') %>" name="Binary" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="STRING" xmi:uuid="<%= get_uuid('STRING') %>" name="String" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="NUMBER" xmi:uuid="<%= get_uuid('NUMBER') %>" name="Number" isAbstract="TRUE"/>
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="REAL" xmi:uuid="<%= get_uuid('REAL') %>" name="Real">
<generalization xmi:type="uml:Generalization" xmi:id="_generalization-REAL_NUMBER" xmi:uuid="<%= get_uuid('_generalization-REAL_NUMBER') %>" general="NUMBER"/>
</packagedElement>
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="INTEGER" xmi:uuid="<%= get_uuid('INTEGER') %>" name="Integer">
<generalization xmi:type="uml:Generalization" xmi:id="_generalization-INTEGER_NUMBER" xmi:uuid="<%= get_uuid('_generalization-INTEGER_NUMBER') %>" general="NUMBER"/>
</packagedElement>
<packagedElement xmi:type="uml:Enumeration" xmi:id="LOGICAL" xmi:uuid="<%= get_uuid('LOGICAL') %>" name="Logical">
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="UNKNOWN" xmi:uuid="<%= get_uuid('UNKNOWN') %>" name="Unknown" classifier="LOGICAL"/>
</packagedElement>
<packagedElement xmi:type="uml:Enumeration" xmi:id="BOOLEAN" xmi:uuid="<%= get_uuid('BOOLEAN') %>" name="Boolean">
<generalization xmi:type="uml:Generalization" xmi:id="_generalization-BOOLEAN-LOGICAL" xmi:uuid="<%= get_uuid('_generalization-BOOLEAN-LOGICAL') %>" general="LOGICAL"/>
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="TRUE" xmi:uuid="<%= get_uuid('TRUE') %>" name="True" classifier="BOOLEAN"/>
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="FALSE" xmi:uuid="<%= get_uuid('FALSE') %>" name="False" classifier="BOOLEAN"/>
</packagedElement>}

# Model End Template
model_end_template = %{<profileApplication xmi:type="uml:ProfileApplication" xmi:id="_profileApplication0" xmi:uuid="<%= get_uuid('_profileApplication0') %>">
<appliedProfile xmi:type="uml:Profile" href="http://www.omg.org/spec/SysML/20100301/SysML-profile.uml#_0" />
</profileApplication>
</packagedElement>
</uml:Model>}

# XMI File End Template
overall_end_template = %{<sysml:ValueType base_DataType="LOGICAL" xmi:id="LOGICAL_VT" xmi:uuid="<%= get_uuid('LOGICAL_VT') %>"/>
<sysml:ValueType base_DataType="BOOLEAN" xmi:id="BOOLEAN_VT" xmi:uuid="<%= get_uuid('BOOLEAN_VT') %>"/>
<sysml:ValueType base_DataType="NUMBER" xmi:id="NUMBER_VT" xmi:uuid="<%= get_uuid('NUMBER_VT') %>"/>
<sysml:ValueType base_DataType="REAL" xmi:id="REAL_VT" xmi:uuid="<%= get_uuid('REAL_VT') %>"/>
<sysml:ValueType base_DataType="INTEGER" xmi:id="INTEGER_VT" xmi:uuid="<%= get_uuid('INTEGER_VT') %>"/>
<sysml:ValueType base_DataType="STRING" xmi:id="STRING_VT" xmi:uuid="<%= get_uuid('STRING_VT') %>"/>
<sysml:ValueType base_DataType="BINARY" xmi:id="BINARY_VT" xmi:uuid="<%= get_uuid('BINARY_VT') %>"/>
</xmi:XMI>}

# SCHEMA Start Template
schema_start_template = %{<packagedElement xmi:type="uml:Package" xmi:id="<%= xmiid %>" xmi:uuid='<%= get_uuid(xmiid) %>' name="<%= schema.name %>">}

# SCHEMA INTERFACE Template
schema_interface_template = %{<packageImport xmi:type="uml:PackageImport" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" importedPackage="_1_<%= interfaced_schema.foreign_schema_id %>"/>}

# SCHEMA End Template
schema_end_template = %{</packagedElement>}

# ENTITY Block Template
entity_block_template = %{<sysml:Block base_Class="<%= baseClass %>" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>"/>}

# ENTITY Start Template
entity_start_template = %{<packagedElement xmi:type="uml:Class" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= entity.name %>" <% if entity.isAbs %>isAbstract="TRUE"<% end %>>}

# SUBTYPE OF Template
supertype_template = %{<generalization xmi:type="uml:Generalization" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" general="<%= xmiid_general %>"/>}

# ENTITY End Template
entity_end_template = %{</packagedElement>}

# ENUMERATION Start Template
enum_start_template = %{<packagedElement xmi:type="uml:Enumeration" xmi:id="<%= type_xmiid %>" xmi:uuid="<%= get_uuid(type_xmiid) %>" name="<%= enum.name %>">}

# ENUMERATION ITEM Template
enum_item_template = %{<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= enumitem_xmiid %>" xmi:uuid="<%= get_uuid(enumitem_xmiid) %>" name="<%= enumitem %>" classifier="<%= type_xmiid %>"/>}

# ENUMERATION End Template
enum_end_template = %{</packagedElement>}

selectTypeType = Hash.new

# SELECT Start Template
select_start_template = %{<packagedElement xmi:type="uml:Class" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= type.name %>" isAbstract="TRUE">}

# SELECT End Template
select_end_template = %{</packagedElement>}

# SELECT Stereotype Template
select_stereotype_template = %{<StandardProfileL2:auxiliary xmi:id="<%= xmiid %>application1" xmi:uuid="<%= get_uuid(xmiid+ 'application1') %>" base_Class="<%= baseClass %>"/>}

# Template covering abstract entity types
abstract_entity_template = %{}

# Template covering the output file contents for each attribute that is an aggregate
attribute_aggregate_template = %{}

# Template covering the output file contents for each attribute that is an aggregate of select of entity
attribute_aggregate_entity_select_template = %{}

# Template covering the output file contents for each attribute that is a select of entity
attribute_entity_select_template = %{}

# Template covering the output file contents for each attribute that is an entity
attribute_entity_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= attr.name %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> type="<%= domain_xmiid %>" <% if direct_inverse or encapsulated %>aggregation='composite'<% end %> association="<%= assoc_xmiid %>"<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

# INVERSE ATTRIBUTE Template
inverse_attribute_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= inverse.name %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> isReadOnly='true' type="<%= domain_xmiid %>" association="<%= assoc_xmiid %>" <% if inverse.redeclare_entity %>redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

#Template covering attribute wrapup
attribute_end = %{<% if lower == '0' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue" xmi:uuid="<%= get_uuid(xmiid + '-lowerValue') %>"/><% end %>
<% if lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue" xmi:uuid="<%= get_uuid(xmiid + '-lowerValue') %>"  value="<%= lower %>"/><% end %>
<% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" xmi:uuid="<%= get_uuid(xmiid + '-upperValue') %>" value="<%= upper %>"/><% end %>
</ownedAttribute>}


# EXPLICIT ATTRIBUTE ENTITY Create Association Template
attribute_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="">
<memberEnd xmi:idref="<%= attr_xmiid %>"/>
<% if !inverse_exists %><memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid %>-end" xmi:uuid="<%= get_uuid(xmiid+'-end') %>" type="<%= owner_xmiid %>" association="<%= xmiid %>">
<lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue" xmi:uuid="<%= get_uuid(xmiid+'-lowerValue') %>"/>
<upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" xmi:uuid="<%= get_uuid(xmiid+'-upperValue') %>" value="*"/>
</ownedEnd><% else %><memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<% end %>
<% if general_exists %><generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>" xmi:uuid="<%= get_uuid(general_xmiid) %>" general="<%= redefined_xmiid %>"/><% end %>
</packagedElement>}

 
# INVERSE ATTRIBUTE ENTITY Create Association Template
inverse_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="">
<memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid %>-end" xmi:uuid="<%= get_uuid(xmiid+'-end') %>" type="<%= owner_xmiid %>" association="<%= xmiid %>"/>
<generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>" xmi:uuid="<%= get_uuid(general_xmiid) %>" general="<%= redefined_xmiid %>"/>
</packagedElement>}

 
# Template covering the output file contents for each attribute
attribute_template = %{}

# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
attribute_builtin_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= attr.name %>" 
<% if datatype_hash[attr.domain] != nil %><% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> <% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>>
<type xmi:type="uml:PrimitiveType" href="<%= datatype_hash[attr.domain] %>" /><% end %>	
<% if datatype_hash[attr.domain] == nil %>type="<%= attr.domain %>"<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>><% end %>}


# EXPLICIT ATTRIBUTE ENUM and TYPE Template
attribute_enum_type_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= attr.name %>" type="<%= type_xmiid %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %>>}

# UNIQUE rule template
unique_template = %{<ownedRule xmi:type="uml:Constraint" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= unique.name %>">
<constrainedElement xmi:idref="<%= xmiid_entity %>"/>
<specification xmi:type="uml:OpaqueExpression" xmi:id="<%= xmiid %>-spec" xmi:uuid="<%= get_uuid(xmiid+'-spec') %>">
<body><%= entity.name %>::allInstance()-&gt;isUnique(<%= unique_text %>)</body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

# TYPE Template
type_template = %{<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>" name="<%= type.name %>" >
<% if datatype_hash[type.domain] != nil %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype<%= xmiid %>" xmi:uuid="<%= get_uuid('_supertype'+xmiid) %>">
<general xmi:type='uml:PrimitiveType' href="<%= datatype_hash[type.domain] %>" />
</generalization>
<% else %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype<%= xmiid %>" xmi:uuid="<%= get_uuid('_supertype'+xmiid) %>" general="<%= xmiid_general %>"/>
<% end %>}

#TYPE end Template
type_end_template=%{</packagedElement>}

# TYPE ValueType Template
valuetype_template = %{<sysml:ValueType base_DataType="<%= baseType %>" xmi:id="<%= xmiid %>" xmi:uuid="<%= get_uuid(xmiid) %>"/>}

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

# Set up XMI output file

	if schema_list.size == 1
		if output_xmi_filename == nil
			schema = schema_list[0]
			output_xmi_filename = schema.name.to_s + ".xmi"
		end
		get_prefix = lambda {|schema| '_'}
	else
		if output_xmi_filename == nil
			output_xmi_filename = 'Model.xmi'
		end
		get_prefix = lambda {|schema| '_' + schema.name + '-'}
	end
	
	file = File.new(output_xmi_filename, "w")
	puts 'reeper : Writing output to file ' + output_xmi_filename

# Evaluate and write file start template 
	res = ERB.new(overall_start_template)
	t = res.result(binding)
	file.puts t

# Set up list of all EXPRESS Inverses in all schemas 
all_inverse_list = []
direct_inverses = []

for schema in schema_list	
	prefix = get_prefix.call(schema)	
	
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }
	for entity in entity_list
		entity_inverse_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Inverse }
		for inverse in entity_inverse_list
			all_inverse_list.push inverse
		end
	end

# Evaluate and write schema start template 
	xmiid = '_1_' + schema.name
	res = ERB.new(schema_start_template)
	t = res.result(binding)
	file.puts t
	
	interfaced_schema_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::InterfaceSpecification}
	
	for interfaced_schema in interfaced_schema_list
# Evaluate and write schema interface template 
		xmiid = '_2_' + schema.name + '-' + interfaced_schema.foreign_schema_id
		res = ERB.new(schema_interface_template)
		t = res.result(binding)
		file.puts t		
	end

# set up select_list - used in a number of places
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }

# Map EXPRESS TYPE of Builtin
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and e.isBuiltin}
	for type in type_list
		xmiid = prefix + type.name
		xmiid_general = type.domain
		res = ERB.new(type_template)
		t = res.result(binding)
		file.puts t
		
# Map TYPE Select has Type as item
		for select in select_list
			if select.selectitems_array.include?(type)
				xmiid = '_2_selectitem' + prefix + type.name + '-' + select.name
				xmiid_general = prefix + select.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
				selectTypeType[select.name] = "ValueType"
			end
		end
		
		res = ERB.new(type_end_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS TYPE of TYPE
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and !e.isBuiltin}
	for type in type_list
		superselect = NamedType.find_by_name( type.domain )
		xmiid = prefix + type.name
		
		# deal with select types
		if superselect.kind_of? EXPSM::TypeSelect
# Evaluate and write TYPE Select start template 
			res = ERB.new(select_start_template)
			t = res.result(binding)
			file.puts t

# Write Select Item template for parent (maps to UML same as EXPRESS supertype)
			xmiid = '_2_superselect' + prefix + type.name + '-' + superselect.name
			xmiid_general = prefix + superselect.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t

# Evaluate and write TYPE Select end template 
			res = ERB.new(select_end_template)
			t = res.result(binding)
			file.puts t
		else
			xmiid_general = prefix + type.domain
			res = ERB.new(type_template)
			t = res.result(binding)
			file.puts t
			
	# Map TYPE Select has Type as item
			for select in select_list
				if select.selectitems_array.include?(type)
					xmiid = '_2_selectitem' + prefix + type.name + '-' + select.name
					xmiid_general = prefix + select.name
					res = ERB.new(supertype_template)
					t = res.result(binding)
					file.puts t
					selectTypeType[select.name] = "ValueType"
				end
			end
			
			res = ERB.new(type_end_template)
			t = res.result(binding)
			file.puts t
		end
	end

# Map EXPRESS Enumeration Types
	enum_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum }
	for enum in enum_list

# Evaluate and write TYPE Enum start template 
		type_xmiid = prefix + enum.name
		res = ERB.new(enum_start_template)
		t = res.result(binding)
		file.puts t

		superenum = enum.extends_item
		if superenum != nil
			if superselect.kind_of? EXPSM::TypeEnum
	# Write Enum Item template for parent (maps to UML same as EXPRESS supertype)
				xmiid = '_2_superenum' + prefix + enum.name + '-' + superenum.name
				xmiid_general = get_prefix.call(superenum.schema) + superenum.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write Enum Item template for each item
		enumitem_name_list = enum.items.scan(/\w+/)
		for enumitem in enumitem_name_list
			enumitem_xmiid = '_1_enumitem' + prefix + enum.name + '-' + enumitem
			res = ERB.new(enum_item_template)
			t = res.result(binding)
			file.puts t
		end

# Evaluate and write TYPE Enum end template 
		res = ERB.new(enum_end_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS TYPE Selects 
	for type in select_list

# Evaluate and write TYPE Select start template 
		xmiid = prefix + type.name
		res = ERB.new(select_start_template)
		t = res.result(binding)
		file.puts t
		
		superselect = type.extends_item
		if superselect != nil
			if superselect.kind_of? EXPSM::TypeSelect
	# Write Select Item template for parent (maps to UML same as EXPRESS supertype)
				xmiid = '_2_superselect' + prefix + type.name + '-' + superselect.name
				xmiid_general = get_prefix.call(superselect.schema)  + superselect.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write Select Item template for each item (maps to UML same as EXPRESS supertype)
		for superselect in select_list
			if superselect.selectitems_array.include?(type)
				xmiid = '_2_superselect' + prefix + type.name + '-' + superselect.name
				xmiid_general = prefix + superselect.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write TYPE Select end template 
		res = ERB.new(select_end_template)
		t = res.result(binding)
		file.puts t
	end
	
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

# Map EXPRESS Explicit Attribute resulting UML Association (the Association is referenced from Class resulting from Entity)
	for entity in entity_list
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list
			
			if NamedType.find_by_name( attr.domain ).kind_of? EXPSM::Entity or NamedType.find_by_name( attr.domain ).kind_of? EXPSM::TypeSelect
				xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
				attr_xmiid = '_2_attr' + prefix + entity.name + '-' + attr.name
				owner_xmiid = prefix + entity.name
				domain_xmiid = prefix + NamedType.find_by_name( attr.domain ).name
				
				general_exists = false
				if attr.redeclare_entity
					general_exists = true
					redeclare_entity = NamedType.find_by_name( attr.redeclare_entity )
					general_xmiid = '_2_general' + prefix + entity.name + '-' + attr.name
					if attr.redeclare_oldname
						redefined_xmiid = '_1_association' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.redeclare_oldname
					else
						redefined_xmiid = '_1_association' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.name
					end
				end
				 
#		  check if inverse refers to this attribute, affects how association is written
				inverse_exists = false
				for inverse in all_inverse_list
					if inverse.reverseAttr == attr
						if attr.domain == inverse.entity.name
							iattr_xmiid = '_2_attr' + get_prefix.call(inverse.entity.schema) + inverse.entity.name + '-' + inverse.name
							direct_inverses.push inverse
							all_inverse_list.delete inverse
							inverse_exists = true
						end
					end
				end				
				
				res = ERB.new(attribute_entity_association_template)
				t = res.result(binding)
				file.puts t
			end
		end
	end

# Map EXPRESS Inverse Attribute resulting UML Association (the Association is referenced from Class resulting from Entity)
	for inverse in all_inverse_list
		xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + inverse.entity.name + '-' + inverse.reverseAttr_id
		owner_xmiid = get_prefix.call(inverse.entity.schema) + inverse.entity.name
		iattr_xmiid = '_2_attr' + get_prefix.call(inverse.entity.schema) + inverse.entity.name + '-' + inverse.name
		
		general_xmiid = '_2_general' + get_prefix.call(inverse.reverseEntity.schema) + inverse.entity.name + '-' + inverse.reverseAttr_id
		redefined_xmiid = '_1_association' + get_prefix.call(inverse.entity.schema) + inverse.reverseEntity.name + '-' + inverse.reverseAttr_id
		
		res = ERB.new(inverse_entity_association_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS Entity Types 
	for entity in entity_list
		
# Evaluate and write ENTITY start template 
		xmiid = prefix + entity.name
		xmiid_entity = xmiid
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t


# Map Entity is SUBTYPE OF (i.e. list of supertypes)
		for supertype in entity.supertypes_array
			xmiid = '_2_supertype' + prefix + entity.name + '-' + supertype.name
			xmiid_general = get_prefix.call(supertype.schema) + supertype.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end

# Map TYPE Select has Entity as item
		for select in select_list
			if select.selectitems_array.include?(entity)
				xmiid = '_2_selectitem' + prefix + entity.name + '-' + select.name
				xmiid_general = prefix + select.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Map EXPRESS Explicit Attributes 		
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list
			xmiid = '_2_attr' + prefix + entity.name + '-' + attr.name

#     set up references resulting from attribute being a redeclaration
			if attr.redeclare_entity
				redeclare_entity = NamedType.find_by_name( attr.redeclare_entity )
				if attr.redeclare_oldname
					redefined_xmiid = '_2_attr' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.redeclare_oldname
				else
					redefined_xmiid = '_2_attr' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.name
				end
			end

#     initialize default cardinailty constraints
			lower = '1'
			upper = '1'
			isset = true
			islist = false
			
#     set up cardinailty constraints from attribute being a 1-D aggregate				
			if attr.instance_of? EXPSM::ExplicitAggregate and attr.rank == 1
				upper = attr.dimensions[0].upper
				if upper == '?'
					upper = '*'
				end
				lower = attr.dimensions[0].lower
				if attr.dimensions[0].aggrtype == 'LIST'
					islist = true
				end
				if attr.dimensions[0].aggrtype == 'BAG'
					isset = false
				end
				if attr.dimensions[0].aggrtype == 'LIST' and !attr.dimensions[0].isUnique
					isset = false
				end
			end
			if attr.isOptional == TRUE
				lower = '0'
			end
			
			attrset = false

# Map EXPRESS Explicit Attributes of Builtin
			if attr.isBuiltin
				attrset= true
				res = ERB.new(attribute_builtin_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end

			attr_domain = NamedType.find_by_name( attr.domain )

# Map EXPRESS Explicit Attributes of TYPE and TYPE Enum
			if attr_domain.kind_of? EXPSM::Type or attr_domain.kind_of? EXPSM::TypeEnum
				attrset= true
				type_xmiid = get_prefix.call(attr_domain.schema)  + attr_domain.name
				res = ERB.new(attribute_enum_type_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end

# Map EXPRESS Explicit Attributes of Entity and Select
			if attr_domain.kind_of? EXPSM::Entity or attr_domain.kind_of? EXPSM::TypeSelect 
				attrset= true
				domain_xmiid = get_prefix.call(attr_domain.schema) + attr_domain.name
				assoc_xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
				
				direct_inverse = false
				for inverse in direct_inverses
					if inverse.reverseAttr == attr
						if !inverse.instance_of? EXPSM::InverseAggregate
							direct_inverse = true
						end
					end
				end				
				
				encapsulated = isEncapsulated(attr_domain)

				res = ERB.new(attribute_entity_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end
			
			if !attrset
				puts 'Oops ' + entity.name + '.' + attr.name
				puts attr.domain
			end      

			res = ERB.new(attribute_end,0,"<>")
			t = res.result(binding)
			file.puts t
		end

#Map EXPRESS Inverse Attributes
		inverse_attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Inverse }
		for inverse in inverse_attr_list
			xmiid = '_2_attr' + prefix + entity.name + '-' + inverse.name
#       set up references resulting from attribute being a redeclaration
			if inverse.redeclare_entity
				puts 'FOUND REDECLARED INVERSE ' + inverse.name
				if inverse.redeclare_oldname
					redefined_xmiid = '_2_attr' + prefix + inverse.redeclare_entity + '-' + inverse.redeclare_oldname
				else
					redefined_xmiid = '_2_attr' + prefix + inverse.redeclare_entity + '-' + inverse.name
				end
			end

			lower = '1'
			upper = '1'
			isset = true
			if inverse.instance_of? EXPSM::InverseAggregate
				lower = '0'
				upper = '*'
				if inverse.upper != '?'
					upper = inverse.upper
				end
				if inverse.lower != '0'
					lower = inverse.lower
				end
				if inverse.aggrtype == 'BAG'
					isset = false
				end
			end
			domain_xmiid = prefix + inverse.reverseEntity.name
			if inverse.reverseAttr.domain == entity.name
				assoc_xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + inverse.reverseEntity.name + '-' + inverse.reverseAttr_id
			else
				assoc_xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + entity.name + '-' + inverse.reverseAttr_id
			end
			res = ERB.new(inverse_attribute_template)
			t = res.result(binding)
			file.puts t
			
			res = ERB.new(attribute_end,0,"<>")
			t = res.result(binding)
			file.puts t
		end

#Map EXPRESS Unique crules
		if entity.uniques.size > 0
			for unique in entity.uniques
				xmiid = '_3_uniq' + prefix + entity.name + '-' + unique.name
				if unique.attributes.size == 1
					unique_text = unique.attributes[0]
				else
					unique_text = 'Sequence{'+ unique.attributes.join(', ') +'}'
				end
				res = ERB.new(unique_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write ENTITY end template 
		res = ERB.new(entity_end_template)
		t = res.result(binding)
		file.puts t
	end

# Evaluate and write SCHEMA end template 
	res = ERB.new(schema_end_template)
	t = res.result(binding)
	file.puts t
end

#Evaluate and write model end template
res = ERB.new(model_end_template)
t = res.result(binding)
file.puts t

# Map EXPRESS Entity Types to blocks
for schema in schema_list

	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

	for entity in entity_list
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + entity.name
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
	end

	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and e.isBuiltin}
	for type in type_list  
		# Evaluate and write TYPE ValueType template
		baseType = prefix + type.name
		xmiid = baseType + '-ValueType'
		res = ERB.new(valuetype_template)
		t = res.result(binding)
		file.puts t
	end
	
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and !e.isBuiltin}
	for type in type_list
		superselect = NamedType.find_by_name( type.domain )
		if superselect.kind_of? EXPSM::TypeSelect
			# Evaluate and write ENTITY Block template 
			baseClass = prefix + type.name
			xmiid = baseClass + '-Block'
			res = ERB.new(entity_block_template)
			t = res.result(binding)
			file.puts t
			res = ERB.new(select_stereotype_template)
			t = res.result(binding)
			file.puts t
		else
			# Evaluate and write TYPE ValueType template
			baseType = prefix + type.name
			xmiid = baseType + '-ValueType'
			res = ERB.new(valuetype_template)
			t = res.result(binding)
			file.puts t
		end
	end
end
	
	for select in select_list
		if selectTypeType[select.name] == "ValueType"
			# Evaluate and write TYPE ValueType template
			baseType = prefix + select.name
			xmiid = baseType + '-ValueType'
			res = ERB.new(valuetype_template)
		else
			# Evaluate and write ENTITY Block template 
			baseClass = prefix + select.name
			xmiid = baseClass + '-Block'
			res = ERB.new(entity_block_template)
			t = res.result(binding)
			file.puts t
			res = ERB.new(select_stereotype_template)
		end
		t = res.result(binding)
		file.puts t
	end

# Evaluate and write file end template 
res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t

uuidfile.close

File.open("UUIDs.xml","w"){|file| $uuidxml.write_xml_to file} 

end