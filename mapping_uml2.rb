require 'erb'
# EXPRESS to UML 2 Mapping
# Version 0.1
#
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-UML2 (2.1.2) mapping using Ruby ERB templates.
# The output is in XMI 2.1 syntax in a file named <schema>.xmi if one schema input and 'Model.xmi' if more than one schema input.
# 
# Integer, Boolean, String -> UML equivalent builtin type
# Real, Number, Binary, Logical -> New PrimitiveType
# Schema -> Package
# Entity (subtype of) -> Class (Generalization)
# Select Type -> Interface and InterfaceRealization
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

def map_from_express( mapinput )

# Enter file name here to override defaults (<schema>.xmi if one schema, and Model.xmi if more than one)
output_xmi_filename = nil

# datatypes for builtin types that map directly to UML
datatype_hash = Hash.new
datatype_hash["INTEGER"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#Integer'
datatype_hash["BOOLEAN"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#Boolean'
datatype_hash["STRING"] = 'http://schema.omg.org/spec/UML/2.1.2/uml.xml#String'

# XMI File Start Template (includes datatypes for builtin with no direct UML equivalent)
overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?>
<uml:Model xmi:version = "2.1" xmlns:xmi = "http://schema.omg.org/spec/XMI/2.1" xmlns:uml = "http://schema.omg.org/spec/UML/2.1.2" name = "UMLfromEXPRESS" xmi:id = "_0">
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="REAL" name="Real" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="NUMBER" name="Number" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="BINARY" name="Binary" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="LOGICAL" name="Logical" />}

# XMI File End Template
overall_end_template = %{</uml:Model>}

# SCHEMA Start Template
schema_start_template = %{<packagedElement xmi:type = "uml:Package" xmi:id = "_1_<%= schema.name %>" name = "<%= schema.name %>" visibility = "public">}

# SCHEMA INTERFACE Template
schema_interface_template = %{<packageImport xmi:type='uml:PackageImport' xmi:id='_2_<%= schema.name %>-<%= interfaced_schema.foreign_schema_id %>' visibility='public' importedPackage='_1_<%= interfaced_schema.foreign_schema_id %>'/>}

# SCHEMA End Template
schema_end_template = %{</packagedElement>}

# ENTITY Start Template
entity_start_template = %{<packagedElement xmi:type = "uml:Class" xmi:id = "<%= xmiid %>" name = "<%= entity.name %>" isAbstract = "<% if entity.isAbs %>TRUE<% else %>FALSE<% end %>" visibility = "public">}

# SUBTYPE OF Template
supertype_template = %{<generalization xmi:type="uml:Generalization" xmi:id="<%= xmiid %>" general="<%= xmiid_general %>"/>}

# ENTITY End Template
entity_end_template = %{</packagedElement>}

# ENUMERATION Start Template
enum_start_template = %{<packagedElement xmi:type = "uml:Enumeration" xmi:id = "<%= type_xmiid %>" name = "<%= enum.name %>">}

# ENUMERATION ITEM Template
enum_item_template = %{<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= enumitem_xmiid %>" name="<%= enumitem %>" classifier="<%= type_xmiid %>" enumeration="<%= type_xmiid %>">
<specification xmi:type="uml:LiteralInteger" xmi:id="<%= enumitem_xmiid + '_specification' %> "/>
</ownedLiteral>}

# ENUMERATION End Template
enum_end_template = %{</packagedElement>}

# SELECT Start Template
select_start_template = %{<packagedElement xmi:type = "uml:Interface" xmi:id = "<%= xmiid %>" name = "<%= select.name %>" isAbstract = "TRUE" visibility = "public">}

# SELECT ITEM is ENTITY Template
selectitem_entity_template = %{ <interfaceRealization xmi:type="uml:InterfaceRealization" xmi:id="<%= xmiid %>" supplier="<%= xmiid_general %>" client="<%= xmiid_entity %>" contract="<%= xmiid_general %>" implementingClassifier="<%= xmiid_entity %>"/>}

# SELECT ITEM is TYPE Template
selectitem_type_template = %{ <packagedElement xmi:type="uml:Realization" xmi:id="<%= xmiid %>" supplier="<%= xmiid_general %>" client="<%= xmiid_type %>"/>}

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
attribute_entity_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= attr.name %>" visibility="public" isOrdered='<%= islist %>' isUnique='<%= isset %>' isLeaf='false' isStatic='false' isReadOnly='false' isDerived='false' isDerivedUnion='false' type="<%= domain_xmiid %>" aggregation="none" association="<%= assoc_xmiid %>"<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

# INVERSE ATTRIBUTE Template
inverse_attribute_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= inverse.name %>" visibility="public" isOrdered='<%= islist %>' isUnique='<%= isset %>' isLeaf='false' isStatic='false' isReadOnly='true' isDerived='false' isDerivedUnion='false' type="<%= domain_xmiid %>" aggregation="none" association="<%= assoc_xmiid %>" <% if inverse.redeclare_entity %>redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

#Template covering attribute wrapup
attribute_end = %{<% if lower == '0' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"/><% end %>
<% if lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"  value="<%= lower %>"/><% end %>
<% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" value="<%= upper %>"/><% end %>
</ownedAttribute>}


# EXPLICIT ATTRIBUTE ENTITY Create Association Template
attribute_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>" name="" visibility='public' isLeaf='false' isAbstract='false' isDerived='false'>
<memberEnd xmi:idref="<%= attr_xmiid %>"/>
<% if !inverse_exists %><memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid + '-end' %>" type="<%= owner_xmiid %>" owningAssociation="<%= xmiid %>" association="<%= xmiid %>" visibility='public'>
<lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"/>
<upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" value="*"/>
</ownedEnd><% else %><memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<% end %>
<% if general_exists %><generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>" general="<%= redefined_xmiid %>"/><% end %>
</packagedElement>}

 
# INVERSE ATTRIBUTE ENTITY Create Association Template
inverse_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>" name="" visibility='public' isLeaf='false' isAbstract='false' isDerived='false'>
<memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid + '-end' %>" type="<%= owner_xmiid %>" owningAssociation="<%= xmiid %>" association="<%= xmiid %>" visibility='public'/>
<generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>" general="<%= redefined_xmiid %>"/>
</packagedElement>}

 
# Template covering the output file contents for each attribute
attribute_template = %{}

# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
attribute_builtin_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= attr.name %>" visibility="public" <% if datatype_hash[attr.domain] != nil %>isOrdered='<%= islist %>' isUnique='<%= isset %>'<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>>
<type xmi:type="uml:PrimitiveType" href="<%= datatype_hash[attr.domain] %>" /><% end %>	
<% if datatype_hash[attr.domain] == nil %>type="<%= attr.domain %>"<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>><% end %>}


# EXPLICIT ATTRIBUTE ENUM and TYPE Template
attribute_enum_type_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= attr.name %>" visibility="public" type="<%= type_xmiid %>" isOrdered='<%= islist %>' isUnique='<%= isset %>' >}

# UNIQUE rule template
unique_template = %{<ownedRule xmi:type="uml:Constraint" xmi:id="<%= xmiid %>" name="<%= unique.name %>" visibility="public">
<constrainedElement xmi:idref="<%= xmiid_entity %>"/>
<specification xmi:type="uml:OpaqueExpression" xmi:id="<%= xmiid + '-spec' %>" visibility="public">
<body><%= entity.name %>::allInstance()-&gt;isUnique(<%= unique_text %>)</body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

# TYPE Template
type_template = %{<packagedElement xmi:type="uml:PrimitiveType" xmi:id="_<%= schema.name %>-<%= type.name %>" name="<%= type.name %>" >
<% if datatype_hash[type.domain] != nil %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype_<%= schema.name %>-<%= type.name %>">
<general xmi:type='uml:PrimitiveType' href="<%= datatype_hash[type.domain] %>" />
</generalization>
<% end %>	
<% if datatype_hash[type.domain] == nil %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype_<%= schema.name %>-<%= type.name %>" general="<%= type.domain %>"/>
<% end %>	
</packagedElement>}


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

	if schema_list.size == 1 and output_xmi_filename == nil
		schema = schema_list[0]
		output_xmi_filename = schema.name.to_s + ".xmi"
	elsif output_xmi_filename == nil
		output_xmi_filename = 'Model.xmi'
	end
	
	file = File.new(output_xmi_filename, "w")
	puts 'reeper : Writing output to file ' + output_xmi_filename

# Evaluate and write file start template 
	res = ERB.new(overall_start_template)
	t = res.result(binding)
	file.puts t

# Set up list of all EXPRESS Inverses in all schemas 
all_inverse_list = []

for schema in schema_list	
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }
	for entity in entity_list
		entity_inverse_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Inverse }
		for inverse in entity_inverse_list
			all_inverse_list.push inverse
		end
	end


# Evaluate and write schema start template 
	res = ERB.new(schema_start_template)
	t = res.result(binding)
	file.puts t
	
	interfaced_schema_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::InterfaceSpecification}
	
	for interfaced_schema in interfaced_schema_list
# Evaluate and write schema interface template 
		res = ERB.new(schema_interface_template)
		t = res.result(binding)
		file.puts t		
	end

# set up select_list - used in a number of places
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }

# Map EXPRESS TYPE of Builtin
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and e.isBuiltin}
	for type in type_list
		xmiid = '_' + schema.name + '-' + type.name
		res = ERB.new(type_template)
		t = res.result(binding)
		file.puts t
		
# Map TYPE Select has Type as item
		for select in select_list
			if select.selectitems_array.include?(type)
				xmiid = '_2_selectitem_' + schema.name + '-' + type.name + '-' + select.name
				xmiid_general = '_' + schema.name + '-' + select.name
				res = ERB.new(selectitem_type_template)
				t = res.result(binding)
				file.puts t
			end
		end
	end

# Map EXPRESS TYPE of TYPE Select
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and !e.isBuiltin}
	for select in type_list
		superselect = NamedType.find_by_name( select.domain )
		if superselect.kind_of? EXPSM::TypeSelect
# Evaluate and write TYPE Select start template 
			xmiid = '_' + schema.name + '-' + select.name
			xmiid_type = xmiid
			res = ERB.new(select_start_template)
			t = res.result(binding)
			file.puts t

# Write Select Item template for parent (maps to UML same as EXPRESS supertype)
			xmiid = '_2_superselect_' + schema.name + '-' + select.name + '-' + superselect.name
			xmiid_general = '_' + schema.name + '-' + superselect.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t

# Evaluate and write TYPE Select end template 
			res = ERB.new(select_end_template)
			t = res.result(binding)
			file.puts t
		end
	end

# Map EXPRESS Enumeration Types
	enum_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum }
	for enum in enum_list

# Evaluate and write TYPE Enum start template 
		type_xmiid = '_' + schema.name + '-' + enum.name
		res = ERB.new(enum_start_template)
		t = res.result(binding)
		file.puts t

		superenum = enum.extends_item
		if superenum != nil
			if superselect.kind_of? EXPSM::TypeEnum
	# Write Enum Item template for parent (maps to UML same as EXPRESS supertype)
				xmiid = '_2_superenum_' + schema.name + '-' + enum.name + '-' + superenum.name
				xmiid_general = '_' + superenum.schema.name + '-' + superenum.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write Enum Item template for each item
		enumitem_name_list = enum.items.scan(/\w+/)
		for enumitem in enumitem_name_list
			enumitem_xmiid = '_1_enumitem_' + schema.name + '-' + enum.name + '-' + enumitem
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
	for select in select_list

# Evaluate and write TYPE Select start template 
		xmiid = '_' + schema.name + '-' + select.name
		res = ERB.new(select_start_template)
		t = res.result(binding)
		file.puts t

		superselect = select.extends_item
		if superselect != nil
			if superselect.kind_of? EXPSM::TypeSelect
	# Write Select Item template for parent (maps to UML same as EXPRESS supertype)
				xmiid = '_2_superselect_' + schema.name + '-' + select.name + '-' + superselect.name
				xmiid_general = '_' + superselect.schema.name + '-' + superselect.name
				res = ERB.new(supertype_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Evaluate and write Select Item template for each item (maps to UML same as EXPRESS supertype)
		for superselect in select_list
			if superselect.selectitems_array.include?(select)
				xmiid = '_2_superselect_' + schema.name + '-' + select.name + '-' + superselect.name
				xmiid_general = '_' + schema.name + '-' + superselect.name
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
				xmiid = '_1_association_' + schema.name + '-' + entity.name + '-' + attr.name
				attr_xmiid = '_2_attr_' + schema.name + '-' + entity.name + '-' + attr.name
				owner_xmiid = '_' + schema.name + '-' + entity.name
				domain_xmiid = '_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name
				
				general_exists = false
				if attr.redeclare_entity
					general_exists = true
					redeclare_entity = NamedType.find_by_name( attr.redeclare_entity )
					general_xmiid = '_2_general_' + schema.name + '-' + entity.name + '-' + attr.name
					if attr.redeclare_oldname
						redefined_xmiid = '_1_association_' + redeclare_entity.schema.name + '-' + attr.redeclare_entity + '-' + attr.redeclare_oldname
					else
						redefined_xmiid = '_1_association_' + redeclare_entity.schema.name + '-' + attr.redeclare_entity + '-' + attr.name
					end
				end
				 
#			check if inverse refers to this attribute, affects how association is written
				inverse_exists = false
				for inverse in all_inverse_list
					if inverse.reverseAttr == attr
						if attr.domain == inverse.entity.name
							iattr_xmiid = '_2_attr_' + inverse.entity.schema.name + '-' + inverse.entity.name + '-' + inverse.name
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
		xmiid = '_1_association_' + inverse.reverseEntity.schema.name + '-' + inverse.entity.name + '-' + inverse.reverseAttr_id
		owner_xmiid = '_' + inverse.entity.schema.name + '-' + inverse.entity.name
		iattr_xmiid = '_2_attr_' + inverse.entity.schema.name + '-' + inverse.entity.name + '-' + inverse.name
		
		general_xmiid = '_2_general_' + inverse.reverseEntity.schema.name + '-' + inverse.entity.name + '-' + inverse.reverseAttr_id
		redefined_xmiid = '_1_association_' + inverse.entity.schema.name + '-' + inverse.reverseEntity.name + '-' + inverse.reverseAttr_id
		
		res = ERB.new(inverse_entity_association_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS Entity Types 
	for entity in entity_list
		
# Evaluate and write ENTITY start template 
		xmiid = '_' + schema.name + '-' + entity.name
		xmiid_entity = xmiid
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t

# Map Entity is SUBTYPE OF (i.e. list of supertypes)
		for supertype in entity.supertypes_array
			xmiid = '_2_supertype_' + schema.name + '-' + entity.name + '-' + supertype.name
			xmiid_general = '_' + supertype.schema.name + '-' + supertype.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end

# Map TYPE Select has Entity as item
		for select in select_list
			if select.selectitems_array.include?(entity)
				xmiid = '_2_selectitem_' + schema.name + '-' + entity.name + '-' + select.name
				xmiid_general = '_' + schema.name + '-' + select.name
				res = ERB.new(selectitem_entity_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Map EXPRESS Explicit Attributes 		
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list
			xmiid = '_2_attr_' + schema.name + '-' + entity.name + '-' + attr.name

#		 set up references resulting from attribute being a redeclaration
			if attr.redeclare_entity
				redeclare_entity = NamedType.find_by_name( attr.redeclare_entity )
				if attr.redeclare_oldname
					redefined_xmiid = '_2_attr_' + redeclare_entity.schema.name + '-' + attr.redeclare_entity + '-' + attr.redeclare_oldname
				else
					redefined_xmiid = '_2_attr_' + redeclare_entity.schema.name + '-' + attr.redeclare_entity + '-' + attr.name
				end
			end

#		 initialize default cardinailty constraints
			lower = '1'
			upper = '1'
			isset = 'true'
			islist = 'false'
			
#		 set up cardinailty constraints from attribute being a 1-D aggregate				
			if attr.instance_of? EXPSM::ExplicitAggregate and attr.rank == 1
				upper = attr.dimensions[0].upper
				if upper == '?'
					upper = '*'
				end
				lower = attr.dimensions[0].lower
				if attr.dimensions[0].aggrtype == 'LIST'
					islist = 'true'
				end
				if attr.dimensions[0].aggrtype == 'BAG'
					isset = 'false'
				end
				if attr.dimensions[0].aggrtype == 'LIST' and !attr.dimensions[0].isUnique
					isset = 'false'
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
				type_xmiid = '_' + attr_domain.schema.name + '-' + attr_domain.name
				res = ERB.new(attribute_enum_type_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end

# Map EXPRESS Explicit Attributes of Entity and Select
			if attr_domain.kind_of? EXPSM::Entity or attr_domain.kind_of? EXPSM::TypeSelect 
				attrset= true
				domain_xmiid = '_' + attr_domain.schema.name + '-' + attr_domain.name
				assoc_xmiid = '_1_association_' + schema.name + '-' + entity.name + '-' + attr.name
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
			xmiid = '_2_attr_' + schema.name + '-' + entity.name + '-' + inverse.name
#			 set up references resulting from attribute being a redeclaration
			if inverse.redeclare_entity
				puts 'FOUND REDECLARED INVERSE ' + inverse.name
				if inverse.redeclare_oldname
					redefined_xmiid = '_2_attr_' + schema.name + '-' + inverse.redeclare_entity + '-' + inverse.redeclare_oldname
				else
					redefined_xmiid = '_2_attr_' + schema.name + '-' + inverse.redeclare_entity + '-' + inverse.name
				end
			end

			lower = '1'
			upper = '1'
			isset = 'true'
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
					isset = 'false'
				end
			end
			domain_xmiid = '_' + schema.name + '-' + inverse.reverseEntity.name
			if inverse.reverseAttr.domain == entity.name
				assoc_xmiid = '_1_association_' + inverse.reverseEntity.schema.name + '-' + inverse.reverseEntity.name + '-' + inverse.reverseAttr_id
			else
				assoc_xmiid = '_1_association_' + inverse.reverseEntity.schema.name + '-' + entity.name + '-' + inverse.reverseAttr_id
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
				xmiid = '_3_uniq_' + schema.name + '-' + entity.name + '-' + unique.name
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

# Evaluate and write file end template 
res = ERB.new(overall_end_template)
t = res.result(binding)
file.puts t
end