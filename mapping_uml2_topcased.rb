require 'erb'
# EXPRESS to UML 2 Mapping - Topcased and Eclipse UML version
# Version 0.2, contribution by Engisis
#
# This function navigates the EXPRESS STEPMod Model and performs a structural EXPRESS-to-UML2 (2.1.2) mapping using Ruby ERB templates.
# The output is in XMI 2.1 syntax in a file named <schema>.xmi if one schema input and 'Model.xmi' if more than one schema input.
# This XMI file is then compatible with the open source Eclipse UML implementation (www.eclipse.org/uml2/) and the open source UML2 tools based
# on top of it (TopCased, Papyrus, etc.)
#
# Integer, Boolean, String, Real, Number, Binary, Logical -> PrimitiveType
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
# Inverse Attribute Partial Support (REMOVED for now)
# USE or REFERENCE (even with named items) -> UML PackageImport between Packages
#
#######################################################################################

def map_from_express( mapinput )

# Enter file name here to override defaults (<schema>.xmi if one schema, and Model.xmi if more than one)
output_xmi_filename = nil

# XMI File Start Template (includes datatypes for builtin with no direct UML equivalent)
prim_types = ['STRING', 'NUMBER', 'BINARY', 'REAL', 'LOGICAL', 'INTEGER', 'BOOLEAN']
overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?>
<uml:Model xmi:version = "2.1" xmlns:xmi = "http://schema.omg.org/spec/XMI/2.1" xmlns:uml = "http://www.eclipse.org/uml2/3.0.0/UML" name = "UMLfromEXPRESS" xmi:id = "_0">
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="REAL" name="Real" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="NUMBER" name="Number" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="BINARY" name="Binary" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="LOGICAL" name="Logical" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="STRING" name="String" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="INTEGER" name="Integer" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="BOOLEAN" name="Boolean" />}

# XMI File End Template
overall_end_template = %{  </uml:Model>}

# SCHEMA Start Template
schema_start_template = %{<packagedElement xmi:type = "uml:Package" xmi:id = "_1_<%= schema.name %>" name = "<%= schema.name %>" visibility = "public">}

# SCHEMA INTERFACE Template
schema_interface_template = %{<packageImport xmi:type='uml:PackageImport' xmi:id='_2_<%= schema.name %>-<%= interfaced_schema.foreign_schema_id %>' visibility='public' importedPackage='_1_<%= interfaced_schema.foreign_schema_id %>'/>}

# SCHEMA End Template
schema_end_template = %{</packagedElement>}

# ENTITY Start Template
entity_start_template = %{<packagedElement xmi:type = "uml:Class" xmi:id = "<%= xmiid %>" name = "<%= entity.name %>" isAbstract = "FALSE" visibility = "public">}

# SUBTYPE OF Template
supertype_template = %{<generalization xmi:type="uml:Generalization" xmi:id="<%= xmiid %>" general="<%= xmiid_supertype %>"/>}

# ENTITY End Template
entity_end_template = %{</packagedElement>}

# ENUMERATION Start Template
enum_start_template = %{<packagedElement xmi:type = "uml:Enumeration" xmi:id = "<%= type_xmiid %>" name = "<%= enum.name %>">}

# ENUMERATION ITEM Template
enum_item_template = %{<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= enumitem_xmiid %>" name="<%= enumitem %>" classifier="<%= type_xmiid %>" enumeration="<%= enumitem_xmiid %>">
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
# the complex entities are not specified as a property but as an ownedEnd - Eclipse UML needs them in the association
attribute_entity_template = %{
<% if prim_types.include? domain_xmiid %>  <ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= attr.name %>" visibility="public" isOrdered='<%= islist %>' isUnique='<%= isset %>' isLeaf='false' isStatic='false' isReadOnly='false' isDerived='false' isDerivedUnion='false' type="<%= domain_xmiid %>" aggregation="none" association="<%= assoc_xmiid %>" <% if attr.redeclare_entity %>redefinedProperty="<%= redefined_xmiid %>"<% end %>>
    <% if lower == '0' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"/><% end %>
    <% if lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"  value="<%= lower %>"/><% end %>
    <% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" value="<%= upper %>"/><% end %>
  </ownedAttribute>
<% end %>
}


# add Association attributes here
# EXPLICIT ATTRIBUTE ENTITY Create Association Template
# add a ownerEnd containing the complex entity
attribute_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>" name="" visibility='public' isLeaf='false' isAbstract='false' isDerived='false' memberEnd="<%= domain_prop_xmiid %> <%= attr_prop_xmiid %>" navigableOwnedEnd="<%= domain_prop_xmiid %>">
  <ownedEnd xmi:type="uml:Property" xmi:id="<%= domain_prop_xmiid %>" type="<%= domain_xmiid %>" name="<%= domain_attr_name %>" association="<%= xmiid %>" visibility='public'>
     <% if lower == '0' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= domain_prop_xmiid %>-lowerValue"/>
     <% elsif lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= domain_prop_xmiid %>-lowerValue" value="<%= lower %>"/>
     <% else %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= domain_prop_xmiid %>-lowerValue" value="1"/>
     <% end %>
     <% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= domain_prop_xmiid %>-upperValue" value="<%= upper %>"/>
     <% else %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= domain_prop_xmiid %>-upperValue" value="1"/>
     <% end %>
  </ownedEnd>
  <ownedEnd xmi:type="uml:Property" xmi:id="<%= attr_prop_xmiid %>" type="<%= attr_type %>" name="" association="<%= xmiid %>" visibility='public'>
    <lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= attr_prop_xmiid %>-lowerValue" value="1"/>
    <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= attr_prop_xmiid %>-upperValue" value="1"/>
  </ownedEnd>
</packagedElement>}


# Template covering the output file contents for each attribute
attribute_template = %{}

# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
attribute_builtin_template = %{  <ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>" name="<%= attr.name %>" visibility="public" type="<%= attr.domain %>" <% if attr.redeclare_entity %>redefinedProperty="<%= redefined_xmiid %>"<% end %>>
    <% if lower == '0' or attr.isOptional == TRUE %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"/><% end %>
    <% if lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"  value="<%= lower %>"/><% end %>
    <% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" value="<%= upper %>"/><% end %>
</ownedAttribute>}

# EXPLICIT ATTRIBUTE ENUM and TYPE Template
attribute_enum_type_template = %{  <ownedAttribute xmi:type="uml:Property" xmi:id="_<%= xmiid %>" name="<%= attr.name %>" visibility="public" type="<%= type_xmiid %>" isOrdered='<%= islist %>' isUnique='<%= isset %>' >
    <% if lower == '0' or attr.isOptional == TRUE %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"/><% end %>
    <% if lower != '0' and lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"  value="<%= lower %>"/><% end %>
    <% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue" value="<%= upper %>"/><% end %>
</ownedAttribute>}

# TYPE Template
type_template = %{<packagedElement xmi:type="uml:PrimitiveType" xmi:id="_<%= schema.name %>-<%= type.name %>" name="<%= type.name %>" >
<generalization xmi:type="uml:Generalization" xmi:id="_supertype_<%= schema.name %>-<%= type.name %>" general="<%= type.domain %>"/>
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

for schema in schema_list

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

# Map EXPRESS TYPE of Builtin
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and e.isBuiltin}
	for type in type_list
		xmiid = '_' + schema.name + '-' + type.name
		res = ERB.new(type_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS Enumeration Types
	enum_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum }
	for enum in enum_list

# Evaluate and write TYPE Enum start template
		type_xmiid = '_' + schema.name + '-' + enum.name
		res = ERB.new(enum_start_template)
		t = res.result(binding)
		file.puts t

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
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }
	for select in select_list

# Evaluate and write TYPE Select start template
		xmiid = '_' + schema.name + '-' + select.name
		res = ERB.new(select_start_template)
		t = res.result(binding)
		file.puts t

# Evaluate and write Select Item template for each item (maps to UML same as EXPRESS supertype)
		for superselect in select_list
			if superselect.selectitems_array.include?(select)
				xmiid = '_2_superselect_' + schema.name + '-' + select.name + '-' + superselect.name
				xmiid_supertype = '_' + schema.name + '-' + superselect.name
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
			        attr_prop_xmiid = '_2_attr_' + schema.name + '-' + entity.name + '-' + attr.name + "-end"

                                # type of the entity
                                attr_type = '_' + schema.name + '-' + entity.name

                                # type of the domain
                                domain_xmiid = '_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name
				domain_prop_xmiid = '_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name  + '-' + attr.name + "-end"
                                # name of the attr
                                domain_attr_name = attr.name

				owner_xmiid = '_' + schema.name + '-' + entity.name

				# association lower/upper
				lower = '1'
				upper = '1'
				isset = 'true'
				islist = 'false'
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

				res = ERB.new(attribute_entity_association_template)
				t = res.result(binding)
				file.puts t
			end
		end
	end

# Map EXPRESS Entity Types
	for entity in entity_list

# Evaluate and write ENTITY start template
		xmiid = '_' + schema.name + '-' + entity.name
		res = ERB.new(entity_start_template)
		t = res.result(binding)
		file.puts t

# Map Entity is SUBTYPE OF (i.e. list of supertypes)
		for supertype in entity.supertypes_array
			xmiid = '_2_supertype_' + schema.name + '-' + entity.name + '-' + supertype.name
			xmiid_supertype = '_' + schema.name + '-' + supertype.name
			res = ERB.new(supertype_template)
			t = res.result(binding)
			file.puts t
		end

# Map TYPE Select has Entity as item
		for select in select_list
			if select.selectitems_array.include?(entity)
				xmiid = '_2_selectitem_' + schema.name + '-' + entity.name + '-' + select.name
				xmiid_supplier = '_' + schema.name + '-' + select.name
				xmiid_client = '_' + schema.name + '-' + entity.name
				res = ERB.new(selectitem_entity_template)
				t = res.result(binding)
				file.puts t
			end
		end

# Map EXPRESS Explicit Attributes
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list
				xmiid = '_2_attr_' + schema.name + '-' + entity.name + '-' + attr.name

#       set up references resulting from attribute being a redeclaration
				if attr.redeclare_entity
					if attr.redeclare_oldname
						redefined_xmiid = '_2_attr_' + schema.name + '-' + attr.redeclare_entity + '-' + attr.redeclare_oldname
					else
						redefined_xmiid = '_2_attr_' + schema.name + '-' + attr.redeclare_entity + '-' + attr.name
					end
				end

#       initialize default cardinailty constraints
				lower = '1'
				upper = '1'
				isset = 'true'
				islist = 'false'

#       set up cardinailty constraints from attribute being a 1-D aggregate
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

# Map EXPRESS Explicit Attributes of Builtin
			if attr.isBuiltin
				res = ERB.new(attribute_builtin_template)
				t = res.result(binding)
				file.puts t
			end

# Map EXPRESS Explicit Attributes of TYPE and TYPE Enum
			if NamedType.find_by_name( attr.domain ).kind_of? EXPSM::Type or NamedType.find_by_name( attr.domain ).kind_of? EXPSM::TypeEnum
				type_xmiid = '_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name
				res = ERB.new(attribute_enum_type_template)
				t = res.result(binding)
				file.puts t
			end

# Map EXPRESS Explicit Attributes of Entity and Select
			if NamedType.find_by_name( attr.domain ).kind_of? EXPSM::Entity or NamedType.find_by_name( attr.domain ).kind_of? EXPSM::TypeSelect
				domain_xmiid = '_' + schema.name + '-' + NamedType.find_by_name( attr.domain ).name
				assoc_xmiid = '_1_association_' + schema.name + '-' + entity.name + '-' + attr.name
				res = ERB.new(attribute_entity_template)
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
