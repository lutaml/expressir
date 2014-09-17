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
# Real, Number, Integer, Boolean, String -> New Primitive Type
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

def get_uuid(id)
	if $uuidsRequired
		uuidmap = $uuidxml.xpath('//uuidmap[@id="' + id + '"]').first
		if uuidmap != nil
			$olduuids.delete uuidmap
			return ' xmi:uuid="' + uuidmap.attributes["uuid"].to_s.strip + '"'
		else
			theUUID = $uuid.generate
			uuidtext = theUUID.to_s.strip
			uuidmap = Nokogiri::XML::Node.new("uuidmap", $uuidxml)
			uuidmap['id'] = id
			uuidmap['uuid'] = theUUID
			$uuidxml.root.add_child uuidmap
			return ' xmi:uuid="' + theUUID + '"'
		end
	else
		return ""
	end
end

def get_where(id,rule)
	if $wherexml != nil
		wheremap = $wherexml.xpath('//wheremap[@id="' + id + '"]').first
		if wheremap != nil
			return wheremap.at("OCL").inner_html
		else
			wheremap = Nokogiri::XML::Node.new("wheremap", $wherexml)
			wheremap['id'] = id
			express = Nokogiri::XML::Node.new("EXPRESS", $wherexml)
			express.content = rule
			wheremap.add_child express
			ocl = Nokogiri::XML::Node.new("OCL", $wherexml)
			wheremap.add_child ocl
			$wherexml.root.add_child wheremap
			return ""
		end
	else
		return ""
	end
end

def put_ops(name, file)
# operation template
operation_template = %{<ownedOperation xmi:type="uml:Operation" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= op_name %>" bodyCondition="<%= xmiid %>-body">
<ownedRule xmi:type="uml:Constraint" xmi:id="<%= xmiid %>-body"<%= get_uuid(xmiid+'-body') %>>
<specification xmi:type="uml:OpaqueExpression" xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %>>
<body><%= op_ocl %></body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

parameter_template = %{<ownedParameter xmi:type="uml:Parameter" xmi:id="<%= par_xmiid %>"<%= get_uuid(par_xmiid) %> name="<%= par_name %>" type="<%= par_type %>"/>}

return_template = %{<ownedParameter xmi:type="uml:Parameter" xmi:id="<%= xmiid %>-return"<%= get_uuid(xmiid+'-return') %> direction="return" type="<%= ret_type %>"/>}

operation_end = %{</ownedOperation>}

	if $opsxml != nil
		ops = $opsxml.xpath('//operation[@for="' + name + '"]')
		for op in ops
			body = op.at('body')
			if body != nil
				op_ocl = body.content
				op_name = op['name']
				ret_type = op['type']
				xmiid = '_2_op_' + name + '_' + op_name
				res = ERB.new(operation_template)
				t = res.result(binding)
				file.puts t
				
				params = op.xpath('./param')
				for param in params
					par_name = param['name']
					par_xmiid = xmiid + '-' + par_name
					par_type = param['type']
					res = ERB.new(parameter_template)
					t = res.result(binding)
					file.puts t
				end
				res = ERB.new(return_template)
				t = res.result(binding)
				file.puts t				
				res = ERB.new(operation_end)
				t = res.result(binding)
				file.puts t
			else
				puts 'Operation ' + name + '.' + op['name'] + ' has no body - ignored!'
			end
		end
	end
end

def isEncapsulated (type, attrib)
	encapsulated = false
	rules = type.wheres.select {|w| w.name == "encapsulated"}
	if rules.length	> 0	
		for rule in rules
			if rule.expression == "SIZEOF(USEDIN(SELF, '')) = 1"
				encapsulated = true
			elsif rule.expression == "SIZEOF(QUERY(elem <* SELF | SIZEOF(USEDIN(elem, '')) = 1)) = SIZEOF(SELF)"
				encapsulated = true
			elsif rule.expression[0..24] == "SIZEOF(USEDIN(SELF, '') -"
				encapsulated = !(rule.expression[25..-1].include? (attrib.entity.name.upcase + "." + attrib.name.upcase))
			else
				puts "Unknown encapsulated rule: " + rule.expression
			end
			if encapsulated
				break
			end
		end
	end
	if (type.kind_of? EXPSM::Entity) && !encapsulated
		for supertype in type.supertypes_array
			encapsulated = isEncapsulated(supertype, attrib)
			if encapsulated
				break
			end
		end	
	end
	return encapsulated
end

def isEncapsulatedInto (entity, attrib)
	encapsulated = false
	rules = entity.wheres.select {|w| w.name == "encapsulateInto"}
	if rules.length	> 0	
		for rule in rules
			if rule.expression[0..6] == "EXISTS("
				encapsulated = (rule.expression[7..-1].include? (attrib.name))
			else
				puts "Unknown encapsulateInto rule: " + rule.expression 
			end
			if encapsulated
				break
			end
		end
	end
	for supertype in entity.supertypes_array
		encapsulated = isEncapsulatedInto(supertype, attrib)
		if encapsulated
			break
		end
	end
	return encapsulated
end

def map_from_express( mapinput , passedArgs)
# Enter file name here to override defaults (<schema>.xmi if one schema, and Model.xmi if more than one)
output_xmi_filename = nil

noprune = FALSE
schemaId = FALSE
$uuidsRequired = TRUE
for arg in passedArgs
	argarray = arg.split('=')
	case argarray[0]
		when "noprune" then noprune = TRUE
		when "nouuids" then $uuidsRequired = FALSE
		when "path" then outPath = argarray[1]
		when "schemaid" then schemaId = TRUE
	end
end

if $uuidsRequired
  $uuid = UUID.new
	uuidfile = File.open("UUIDs.xml")
	$uuidxml = Nokogiri::XML(uuidfile, &:noblanks)
	$olduuids = $uuidxml.xpath('//uuidmap')
end

if File.exists?("WhereRuleMapping.xml")
	wherefile = File.open("WhereRuleMapping.xml")
	$wherexml = Nokogiri::XML(wherefile, &:noblanks)
	wherefile.close
end

if File.exists?("Operators.xml")
	opsfile = File.open("Operators.xml")
	$opsxml = Nokogiri::XML(opsfile, &:noblanks)
	opsfile.close
end

# datatypes for builtin types that map directly to SysML
datatype_hash = Hash.new

# XMI File Start Template (includes datatypes for builtin with no direct UML equivalent)
overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:uml="http://www.omg.org/spec/UML/20090901" xmlns:StandardProfileL2="http://schema.omg.org/spec/UML/2.3/StandardProfileL2.xmi" xmlns:sysml="http://www.omg.org/spec/SysML/20100301/SysML-profile">
<uml:Model name="Data" xmi:id="_0_Data"<%= get_uuid('_0_Data') %>><%
$dtprefix=''
if outPath == nil %>
<packagedElement xmi:type="uml:Package" xmi:id="_0_SysMLfromEXPRESS"<%= get_uuid('_0_SysMLfromEXPRESS') %> name="SysMLfromEXPRESS"><%
else
 pathElements = outPath.split('/')
 for elem in pathElements 
  $dtprefix = $dtprefix + elem[0]%>
<packagedElement xmi:type="uml:Package" xmi:id="_0_<%= elem %>"<%= get_uuid('_0_'+elem) %> name="<%= elem %>"><%
 end
 $dtprefix = $dtprefix + '_'%>
<packagedElement xmi:type="uml:Package" xmi:id="_0_DataTypes"<%= get_uuid('_0_DataTypes') %> name="DataTypes"><%
end %>
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= $dtprefix %>BINARY"<%= get_uuid($dtprefix+'BINARY') %> name="Binary" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= $dtprefix %>STRING"<%= get_uuid($dtprefix+'STRING') %> name="String" />
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= $dtprefix %>NUMBER"<%= get_uuid($dtprefix+'NUMBER') %> name="Number" isAbstract="TRUE"/>
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= $dtprefix %>REAL"<%= get_uuid($dtprefix+'REAL') %> name="Real">
<generalization xmi:type="uml:Generalization" xmi:id="_generalization-<%= $dtprefix %>REAL_NUMBER"<%= get_uuid('_generalization-'+$dtprefix+'REAL_NUMBER') %> general="<%= $dtprefix %>NUMBER"/>
</packagedElement>
<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= $dtprefix %>INTEGER"<%= get_uuid($dtprefix+'INTEGER') %> name="Integer">
<generalization xmi:type="uml:Generalization" xmi:id="_generalization-<%= $dtprefix %>INTEGER_REAL"<%= get_uuid('_generalization-'+$dtprefix+'INTEGER_REAL') %> general="<%= $dtprefix %>REAL"/>
</packagedElement>
<packagedElement xmi:type="uml:Enumeration" xmi:id="<%= $dtprefix %>LOGICAL"<%= get_uuid($dtprefix+'LOGICAL') %> name="Logical">
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= $dtprefix %>UNKNOWN"<%= get_uuid($dtprefix+'UNKNOWN') %> name="Unknown" classifier="<%= $dtprefix %>LOGICAL"/>
</packagedElement>
<packagedElement xmi:type="uml:Enumeration" xmi:id="<%= $dtprefix %>BOOLEAN"<%= get_uuid($dtprefix+'BOOLEAN') %> name="Boolean">
<generalization xmi:type="uml:Generalization" xmi:id="<%= $dtprefix %>_generalization-<%= $dtprefix %>BOOLEAN-LOGICAL"<%= get_uuid('_generalization-'+$dtprefix+'BOOLEAN-LOGICAL') %> general="<%= $dtprefix %>LOGICAL"/>
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= $dtprefix %>TRUE"<%= get_uuid($dtprefix+'TRUE') %> name="True" classifier="<%= $dtprefix %>BOOLEAN"/>
<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= $dtprefix %>FALSE"<%= get_uuid($dtprefix+'FALSE') %> name="False" classifier="<%= $dtprefix %>BOOLEAN"/>
</packagedElement><%
if outPath != nil %>
</packagedElement><%
end %>}

# Model End Template
model_end_template = %{<profileApplication xmi:type="uml:ProfileApplication" xmi:id="_profileApplication0"<%= get_uuid('_profileApplication0') %>>
<appliedProfile xmi:type="uml:Profile" href="http://www.omg.org/spec/SysML/20100301/SysML-profile.uml#_0" />
</profileApplication><%
if outPath == nil %>
</packagedElement><%
else
 pathElements = outPath.split('/')
 for elem in pathElements %>
</packagedElement><%
 end
end %>
</uml:Model>}

# XMI File End Template
overall_end_template = %{<sysml:ValueType base_DataType="<%= $dtprefix %>LOGICAL" xmi:id="<%= $dtprefix %>LOGICAL_VT"<%= get_uuid($dtprefix+'LOGICAL_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>BOOLEAN" xmi:id="<%= $dtprefix %>BOOLEAN_VT"<%= get_uuid($dtprefix+'BOOLEAN_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>NUMBER" xmi:id="<%= $dtprefix %>NUMBER_VT"<%= get_uuid($dtprefix+'NUMBER_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>REAL" xmi:id="<%= $dtprefix %>REAL_VT"<%= get_uuid($dtprefix+'REAL_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>INTEGER" xmi:id="<%= $dtprefix %>INTEGER_VT"<%= get_uuid($dtprefix+'INTEGER_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>STRING" xmi:id="<%= $dtprefix %>STRING_VT"<%= get_uuid($dtprefix+'STRING_VT') %>/>
<sysml:ValueType base_DataType="<%= $dtprefix %>BINARY" xmi:id="<%= $dtprefix %>BINARY_VT"<%= get_uuid($dtprefix+'BINARY_VT') %>/>
</xmi:XMI>}

# SCHEMA Start Template
schema_start_template = %{<packagedElement xmi:type="uml:Package" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= schema.name %>">}

# SCHEMA INTERFACE Template
schema_interface_template = %{<packageImport xmi:type="uml:PackageImport" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> importedPackage="_1_<%= interfaced_schema.foreign_schema_id %>"/>}

# SCHEMA End Template
schema_end_template = %{</packagedElement>}

# ENTITY Block Template
entity_block_template = %{<sysml:Block base_Class="<%= baseClass %>" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>/>}

# ENTITY Start Template
entity_start_template = %{<packagedElement xmi:type="uml:Class" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= entity.name %>" <% if entity.isAbs %>isAbstract="TRUE"<% end %>>}

# SUBTYPE OF Template
supertype_template = %{<generalization xmi:type="uml:Generalization" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> general="<%= xmiid_general %>"/>}

# ENTITY End Template
entity_end_template = %{</packagedElement>}

# ENUMERATION Start Template
enum_start_template = %{<packagedElement xmi:type="uml:Enumeration" xmi:id="<%= type_xmiid %>"<%= get_uuid(type_xmiid) %> name="<%= enum.name %>">}

# ENUMERATION ITEM Template
enum_item_template = %{<ownedLiteral xmi:type="uml:EnumerationLiteral" xmi:id="<%= enumitem_xmiid %>"<%= get_uuid(enumitem_xmiid) %> name="<%= enumitem %>" classifier="<%= type_xmiid %>"/>}

# ENUMERATION End Template
enum_end_template = %{</packagedElement>}

# SELECT Start Template
select_start_template = %{<packagedElement xmi:type="uml:Class" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= type.name %>" isAbstract="TRUE">}

# SELECT End Template
select_end_template = %{</packagedElement>}

# SELECT Stereotype Template
select_stereotype_template = %{<StandardProfileL2:Auxiliary xmi:id="<%= xmiid %>application1"<%= get_uuid(xmiid+ 'application1') %> base_Class="<%= baseClass %>"/>}

# Template covering abstract entity types
abstract_entity_template = %{}

# Template covering the output file contents for each attribute that is an aggregate
attribute_aggregate_template = %{}

# Template covering the output file contents for each attribute that is an aggregate of select of entity
attribute_aggregate_entity_select_template = %{}

# Template covering the output file contents for each attribute that is a select of entity
attribute_entity_select_template = %{}

# Template covering the output file contents for each attribute that is an entity
attribute_entity_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= attr.name %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> type="<%= domain_xmiid %>" <% if direct_inverse or encapsulated %>aggregation='composite'<% end %> association="<%= assoc_xmiid %>"<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

# INVERSE ATTRIBUTE Template
inverse_attribute_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= inverse.name %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> isReadOnly='true' type="<%= domain_xmiid %>" association="<%= assoc_xmiid %>" <% if inverse.redeclare_entity %>redefinedProperty="<%= redefined_xmiid %>"<% end %>>}

#Template covering multiplicities
multiplicity = %{<% if lower == '0' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"<%= get_uuid(xmiid + '-lowerValue') %>/><% 
else
 if lower != '1' %><lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-lowerValue"<%= get_uuid(xmiid + '-lowerValue') %>  value="<%= lower %>"/><% 
 else
  dummy = get_uuid(xmiid + '-lowerValue')
	end
end %>
<% if upper != '1' %><upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-upperValue"<%= get_uuid(xmiid + '-upperValue') %> value="<%= upper %>"/><%
else
  dummy = get_uuid(xmiid + '-upperValue')
end %>}

#Template covering attribute wrapup
attribute_end = %{
</ownedAttribute>}


# EXPLICIT ATTRIBUTE ENTITY Create Association Template
attribute_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<memberEnd xmi:idref="<%= attr_xmiid %>"/><% 
if !inverse_exists %>
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid %>-end"<%= get_uuid(xmiid+'-end') %><% if encapsulatedInto %> aggregation='composite'<% end %> type="<%= owner_xmiid %>" association="<%= xmiid %>"<% 
  if !direct_inverse %>>
<lowerValue xmi:type="uml:LiteralInteger" xmi:id="<%= xmiid %>-end-lowerValue"<%= get_uuid(xmiid+'-end-lowerValue') %>/><%
    if encapsulated
      dummy = get_uuid(xmiid+'-end-upperValue')
    else %>
<upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="<%= xmiid %>-end-upperValue"<%= get_uuid(xmiid+'-end-upperValue') %> value="*"/><%
    end %>
</ownedEnd><% 
  else %>/><%
  end %><% 
else %><memberEnd xmi:idref="<%= iattr_xmiid %>"/><% 
end %><% 
if general_exists %>
<generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>"<%= get_uuid(general_xmiid) %> general="<%= redefined_xmiid %>"/><%
end %>
</packagedElement>}

 
# INVERSE ATTRIBUTE ENTITY Create Association Template
inverse_entity_association_template = %{<packagedElement xmi:type="uml:Association" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:type="uml:Property" xmi:id="<%= xmiid %>-end"<%= get_uuid(xmiid+'-end') %> type="<%= owner_xmiid %>" association="<%= xmiid %>">}

inverse_entity_association_end = %{</ownedEnd>
<generalization xmi:type="uml:Generalization" xmi:id="<%= general_xmiid %>"<%= get_uuid(general_xmiid) %> general="<%= redefined_xmiid %>"/>
</packagedElement>}

 
# Template covering the output file contents for each attribute
attribute_template = %{}

# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
attribute_builtin_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= attr.name %>"<% if islist %> isOrdered='true'<% end %><% if !isset %> isUnique='false'<% end %> aggregation='composite'<% if attr.redeclare_entity %> redefinedProperty="<%= redefined_xmiid %>"<% end %> 
<% if datatype_hash[domain_name] != nil %>>
<type xmi:type="uml:PrimitiveType" href="<%= datatype_hash[domain_name] %>" /><% else %>type="<%= $dtprefix+domain_name %>"><% end %>}


# EXPLICIT ATTRIBUTE ENUM and TYPE Template
attribute_enum_type_template = %{<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= attr.name %>" type="<%= type_xmiid %>" <% if islist %>isOrdered='true'<% end %> <% if !isset %>isUnique='false'<% end %> aggregation='composite'>}

# UNIQUE rule template
unique_template = %{<ownedRule xmi:type="uml:Constraint" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= unique.name %>">
<constrainedElement xmi:idref="<%= xmiid_entity %>"/>
<specification xmi:type="uml:OpaqueExpression" xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %>>
<body><%= entity.name %>::allInstances()-&gt;isUnique(<%= unique_text %>)</body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

# WHERE rule template
where_template = %{<ownedRule xmi:type="uml:Constraint" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= where.name %>">
<constrainedElement xmi:idref="<%= xmiidref %>"/>
<specification xmi:type="uml:OpaqueExpression" xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %>>
<body><%= where_ocl %></body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

# TYPE Template
type_template = %{<packagedElement xmi:type="uml:PrimitiveType" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= type.name %>" >
<% if datatype_hash[type.domain] != nil %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype<%= xmiid %>"<%= get_uuid('_supertype'+xmiid) %>>
<general xmi:type='uml:PrimitiveType' href="<%= datatype_hash[type.domain] %>" />
</generalization>
<% else %>
<generalization xmi:type="uml:Generalization" xmi:id="_supertype<%= xmiid %>"<%= get_uuid('_supertype'+xmiid) %> general="<%= $dtprefix+xmiid_general %>"/>
<% end %>}

# ProxyTYPE Start Template
proxy_start_template = %{<packagedElement xmi:type="uml:Class" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> name="<%= type.name %>Proxy">
<ownedAttribute xmi:type="uml:Property" xmi:id="<%= xmiid %>_value"<%= get_uuid(xmiid + "_value") %> name="value" type="<%= xmiid_type %>"/><%
dummy = get_uuid(xmiid + "_value-lowerValue")
dummy = get_uuid(xmiid + "_value-upperValue")
%>}

# proxy TYPE  Stereotype Template
proxy_stereotype_template = %{<StandardProfileL2:Type xmi:id="<%= xmiid %>application1"<%= get_uuid(xmiid+ 'application1') %> base_Class="<%= baseClass %>"/>}

#TYPE end Template
type_end_template=%{</packagedElement>}

# TYPE ValueType Template
valuetype_template = %{<sysml:ValueType base_DataType="<%= baseType %>" xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>/>}

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
		if schemaId
			get_prefix = lambda {|schema| '_' + schema.name + '-'}
		else
			get_prefix = lambda {|schema| '_'}
		end
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
# Set up list of all EXPRESS Selects in all schemas
all_select_list = []
# setup global proxy type handling
typeProxies = Hash.new

# build all_select_list
for schema in schema_list
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }
	all_select_list = all_select_list + select_list
end

# Set up storage for handling select types correctly
selectTypeType = Hash.new

# determine the type of select
# 	- entity if only contains entities
#	- type if only contains types
#	- hybrid if a mixture
#  - remove if a single object in list
unknownSelect = all_select_list.dup
for select in unknownSelect
	if (select.selectitems_array.size == 1 && !noprune)
		if !select.selectitems_array[0].kind_of? EXPSM::TypeSelect
			puts select.name + " is pruned since it only contains one element"
			selectTypeType[select.name] = "Remove"
		end
	end
	entcount = 0
	typcount = 0
	select.selectitems_array.each do |e|
		case e.class.to_s
			when "EXPSM::Entity" then entcount += 1
			when "EXPSM::Type" then typcount += 1
			when "EXPSM::TypeAggregate"
				domain =NamedType.find_by_name( e.domain )
				case domain.class.to_s
					when "EXPSM::Entity" then entcount += 1
					when "EXPSM::Type" then typcount += 1
					else
						puts "Unknown type in aggregate " + domain.class.to_s
				end
			when "EXPSM::TypeSelect"
				case selectTypeType[e.name]
					when "Entity" then entcount += 1
					when "Type" then typcount += 1
					when "Hybrid" then selectTypeType[select.name] = "Hybrid"
					when "Remove"
						case e.selectitems_array[0].class.to_s
							when "EXPSM::Entity" then entcount +=1
							when "EXPSM::Type" then typcount +=1
						end
				end
			else
				puts "unknown class " + e.class.to_s
		end
	end
	
	if selectTypeType[select.name] == nil
		case select.selectitems_array.length
			when entcount then  selectTypeType[select.name] = "Entity"
			when typcount then selectTypeType[select.name] = "Type"
			when entcount + typcount then selectTypeType[select.name] = "Hybrid"
			else
				unknownSelect.push select
		end
	end
	if selectTypeType[select.name] == "Hybrid"			
		puts select.name + " is Hybrid select - proxy block(s) generated."
	end
end
	
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

# Map EXPRESS TYPE of Builtin
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and e.isBuiltin}
	for type in type_list
		xmiid = prefix + type.name
		xmiid_type = xmiid
		xmiid_general = type.domain
		res = ERB.new(type_template)
		t = res.result(binding)
		file.puts t
		
# Map TYPE Select has Type as item
		for select in all_select_list
			if select.selectitems_array.include?(type)
				# sort out what type of select we are dealing with
				case selectTypeType[select.name]
					when "Type"
						xmiid = '_2_selectitem' + prefix + type.name + '-' + select.name
						xmiid_general = prefix + select.name
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					when "Hybrid"
						typeProxy = typeProxies[type.name]
						if typeProxy == nil
							typeProxies[type.name] = type
						end
					when "Remove"
					 # do nothing
				end
			end
		end		

#Map EXPRESS Where rules
		whererules = type.wheres.select {|w| w.name[0..10] != "encapsulate"}
		if whererules.size > 0
			for where in whererules
				xmiid = '_3_whr' + prefix + type.name + '-' + where.name.to_s
				where_ocl = get_where(xmiid, where.expression)
				if where_ocl.size > 0
					xmiidref = xmiid_type
					res = ERB.new(where_template)
					t = res.result(binding)
					file.puts t
				else
					puts "Where rule " + type.name + "." + where.name + " not mapped to OCL - ignored!"
				end
			end
		end

		put_ops(type.name, file)

		res = ERB.new(type_end_template)
		t = res.result(binding)
		file.puts t
	end

# Map EXPRESS TYPE of TYPE
	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and !e.isBuiltin}
	for type in type_list
		superselect = NamedType.find_by_name( type.domain )
		xmiid = prefix + type.name
		xmiid_type = xmiid
		# deal with select types
		if !superselect.kind_of? EXPSM::TypeSelect
			xmiid_general = prefix + type.domain
			res = ERB.new(type_template)
			t = res.result(binding)
			file.puts t
			
	# Map TYPE Select has Type as item
			for select in all_select_list
				if select.selectitems_array.include?(type)
					case selectTypeType[select.name]
						when "Type"
							xmiid = '_2_selectitem' + prefix + type.name + '-' + select.name
							xmiid_general = prefix + select.name
							res = ERB.new(supertype_template)
							t = res.result(binding)
							file.puts t
						when "Hybrid"
							typeProxy = typeProxies[type.name]
							if typeProxy == nil
								typeProxies[type.name] = type
							end
						when "Remove"
							# do nothing
					end
				end
			end
			
#Map EXPRESS Where rules
			whererules = type.wheres.select {|w| w.name[0..10] != "encapsulate"}
			if whererules.size > 0
				for where in whererules
					xmiid = '_3_whr' + prefix + type.name + '-' + where.name.to_s
					where_ocl = get_where(xmiid, where.expression)
					if where_ocl.size > 0
						xmiidref = xmiid_type
						res = ERB.new(where_template)
						t = res.result(binding)
						file.puts t
					else
						puts "Where rule " + type.name + "." + where.name + " not mapped to OCL - ignored!"
					end
				end
			end
			
			put_ops(type.name, file)

			res = ERB.new(type_end_template)
			t = res.result(binding)
			file.puts t
		end
	end
	
	typeProxies.each_value do |type| 
		if type.schema == schema
			# Evaluate and write proxy start template 
			xmiid_type = prefix + type.name
			xmiid = xmiid_type + "_Proxy"
			res = ERB.new(proxy_start_template)
			t = res.result(binding)
			file.puts t

			# Map TYPE Select has Entity as item
			for select in all_select_list
				if select.selectitems_array.include?(type)
					if selectTypeType[select.name] == "Hybrid"
						xmiid = '_2_selectitem' + prefix + type.name + '-' + select.name
						xmiid_general = prefix + select.name
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					end
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
	select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }
	for type in select_list
		if selectTypeType[type.name] != "Remove"
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
			for superselect in all_select_list
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
	end
	
	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

# Map EXPRESS Explicit Attribute resulting UML Association (the Association is referenced from Class resulting from Entity)
	for entity in entity_list
		attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
		for attr in attr_list
			
			orig_domain = NamedType.find_by_name( attr.domain )
			attr_domain = orig_domain
			agg_domain = nil
			begin
				unchanged = true
				case attr_domain.class.to_s
					# ignore re-named select types
					when "EXPSM::Type"
						superselect = NamedType.find_by_name( attr_domain.domain )
						if superselect.kind_of? EXPSM::TypeSelect
							attr_domain = superselect
							unchanged = false
						end
					#ignore named aggregates
					when "EXPSM::TypeAggregate"
						agg_domain = attr_domain
						attr_domain = NamedType.find_by_name( attr_domain.domain )
						unchanged = false
					# ignore removed select types
					when "EXPSM::TypeSelect"
						if selectTypeType[attr_domain.name] == "Remove"
							attr_domain = attr_domain.selectitems_array[0]
							unchanged = false
						end
				end
			end	 until unchanged			
			
			if attr_domain.kind_of? EXPSM::Entity or attr_domain.kind_of? EXPSM::TypeSelect
				xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
				attr_xmiid = '_2_attr' + prefix + entity.name + '-' + attr.name
				owner_xmiid = prefix + entity.name
				domain_xmiid = prefix + attr_domain.name
				
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
				direct_inverse = false
				for inverse in all_inverse_list
					if inverse.reverseAttr == attr
						if attr.domain == inverse.entity.name
							iattr_xmiid = '_2_attr' + get_prefix.call(inverse.entity.schema) + inverse.entity.name + '-' + inverse.name
							direct_inverses.push inverse
							all_inverse_list.delete inverse
							if !inverse.instance_of? EXPSM::InverseAggregate
								direct_inverse = true
							end
							inverse_exists = true
						end
					end
				end				
				
				encapsulated = false
				if attr_domain == orig_domain
					encapsulated = isEncapsulated(attr_domain, attr)
				else
					if agg_domain != nil
						encapsulated = isEncapsulated(agg_domain, attr)
					end
					if !encapsulated
						encapsulated = isEncapsulated(attr_domain, attr)
						if !encapsulated
							encapsulated = isEncapsulated(orig_domain, attr)
						end
					end
				end
				
				encapsulatedInto = isEncapsulatedInto(entity, attr)
				
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

		lower = '1'
		upper = '1'
		if inverse.reverseAttr.instance_of? EXPSM::ExplicitAggregate
			if inverse.reverseAttr.rank == 1
				upper = inverse.reverseAttr.dimensions[0].upper
				if upper == '?'
					upper = '*'
				end
				lower = inverse.reverseAttr.dimensions[0].lower
			end
		end
		if inverse.reverseAttr.isOptional == TRUE
			lower = '0'
		end
		res = ERB.new(inverse_entity_association_template)
		t = res.result(binding)
		file.puts t
		
		res = ERB.new(multiplicity,0,"<>")
		t = res.result(binding)
		file.puts t

		res = ERB.new(inverse_entity_association_end)
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
		for select in all_select_list
			if select.selectitems_array.include?(entity)
				if selectTypeType[select.name] != "Remove"
					xmiid = '_2_selectitem' + prefix + entity.name + '-' + select.name
					xmiid_general = prefix + select.name
					res = ERB.new(supertype_template)
					t = res.result(binding)
					file.puts t
				else
					# if in a select list that has been removed make it a subtype of all selects that include the removed select
					for superselect in all_select_list
						if superselect.selectitems_array.include?(select)
							puts entity.name + " added to " + superselect.name
							puts "    following removal of " + select.name
							xmiid = '_2_selectitem' + prefix + entity.name + '-' + superselect.name
							xmiid_general = prefix + superselect.name
							res = ERB.new(supertype_template)
							t = res.result(binding)
							file.puts t
						end
					end
				end
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
			
			domain_name = attr.domain
			orig_domain = NamedType.find_by_name( attr.domain )
			attr_domain = orig_domain
			agg_domain = nil
			attrType = nil
			begin
				unchanged = true
				case attr_domain.class.to_s
					# ignore re-named select types
					when "EXPSM::Type"
						superselect = NamedType.find_by_name( attr_domain.domain )
						if superselect.kind_of? EXPSM::TypeSelect
							attr_domain = superselect
							domain_name = attr_domain.name
							unchanged = false
						end
					#ignore named aggregations
					when "EXPSM::TypeAggregate"
						puts attr.name+":"+attr.domain
						attrType = attr_domain
						agg_domain = attr_domain
						if attr_domain.isBuiltin
							attr_domain = nil
						else
							newDomain = NamedType.find_by_name( attr_domain.domain )
							attr_domain = newDomain
							domain_name = attr_domain.name
							unchanged = false
						end
					# ignore removed select types
					when "EXPSM::TypeSelect"
						if selectTypeType[domain_name] == "Remove"
							attr_domain = attr_domain.selectitems_array[0]
							domain_name = attr_domain.name
							unchanged = false
						end
				end
			end until unchanged

#     set up cardinailty constraints from attribute being a 1-D aggregate
#       or a type defined to be a 1-D aggregate
      if attr.instance_of? EXPSM::ExplicitAggregate
				attrType = attr
			end
			
			if attrType != nil
				if attrType.rank == 1
					upper = attrType.dimensions[0].upper
					if upper == '?'
						upper = '*'
					end
					lower = attrType.dimensions[0].lower
					if attrType.dimensions[0].aggrtype == 'LIST'
						islist = true
					end
					if attrType.dimensions[0].aggrtype == 'BAG'
						isset = false
					end
					if attrType.dimensions[0].aggrtype == 'LIST' and !attrType.dimensions[0].isUnique
						isset = false
					end
				else
					puts "ERROR: aggregation of rank greater than 1 detected for "+attr.name
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

# Map EXPRESS Explicit Attributes of TYPE and TYPE Enum
			if attr_domain.kind_of? EXPSM::Type or attr_domain.kind_of? EXPSM::TypeEnum
				attrset= true
				type_xmiid = get_prefix.call(attr_domain.schema)  + domain_name
				res = ERB.new(attribute_enum_type_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end

# Map EXPRESS Explicit Attributes of Entity and Select
			if attr_domain.kind_of? EXPSM::Entity or attr_domain.kind_of? EXPSM::TypeSelect 
				attrset= true
				domain_xmiid = get_prefix.call(attr_domain.schema) + domain_name
				assoc_xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
				
				direct_inverse = false
				for inverse in direct_inverses
					if inverse.reverseAttr == attr
						if !inverse.instance_of? EXPSM::InverseAggregate
							direct_inverse = true
						end
					end
				end				
				
				if attr_domain == orig_domain
					encapsulated = isEncapsulated(attr_domain, attr)
				else
					if agg_domain != nil
						encapsulated = isEncapsulated(agg_domain, attr)
					else
						encapsulated = false
					end
					if !encapsulated
						encapsulated = isEncapsulated(attr_domain, attr)
						if !encapsulated
							encapsulated = isEncapsulated(orig_domain, attr)
						end
					end
				end

				res = ERB.new(attribute_entity_template,0,"<>")
				t = res.result(binding)
				file.puts t
			end
			
			if !attrset
				puts 'Oops ' + entity.name + '.' + attr.name
				puts attr.domain
			end 
			
			res = ERB.new(multiplicity,0,"<>")
			t = res.result(binding)
			file.puts t

			res = ERB.new(attribute_end)
			t = res.result(binding)
			file.puts t
		end

#Map EXPRESS Inverse Attributes
		inverse_attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Inverse }
		for inverse in inverse_attr_list
			xmiid = '_2_attr' + prefix + entity.name + '-' + inverse.name
#       set up references resulting from attribute being a redeclaration
			if inverse.redeclare_entity
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
			
			res = ERB.new(multiplicity,0,"<>")
			t = res.result(binding)
			file.puts t
			
			res = ERB.new(attribute_end)
			t = res.result(binding)
			file.puts t
		end

#Map EXPRESS Unique rules
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
		
#Map EXPRESS Where rules
		whererules = entity.wheres.select {|w| w.name[0..10] != "encapsulate"}
		if whererules.size > 0
			for where in whererules
				xmiid = '_3_whr' + prefix + entity.name + '-' + where.name.to_s
				where_ocl = get_where(xmiid, where.expression)
				if where_ocl.size > 0
					puts where_ocl
					xmiidref = xmiid_entity
					res = ERB.new(where_template)
					t = res.result(binding)
					file.puts t
				else
					puts "Where rule " + entity.name + "." + where.name.to_s + " not mapped to OCL - ignored!"
				end
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
	prefix = get_prefix.call(schema)	

	entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

	for entity in entity_list
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + entity.name
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
	end

	type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum}
	for type in type_list  
		# Evaluate and write TYPE ValueType template
		baseType = prefix + type.name
		xmiid = baseType + '-ValueType'
		res = ERB.new(valuetype_template)
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
		if !superselect.kind_of? EXPSM::TypeSelect
			# Evaluate and write TYPE ValueType template
			baseType = prefix + type.name
			xmiid = baseType + '-ValueType'
			res = ERB.new(valuetype_template)
			t = res.result(binding)
			file.puts t
		else
			puts type.name + " is a renamed select so ignored in the mapping"
		end
	end
end
	
	for select in all_select_list
		case selectTypeType[select.name]
			when "Type"
				# Evaluate and write TYPE ValueType template
				baseType = prefix + select.name
				xmiid = baseType + '-ValueType'
				res = ERB.new(valuetype_template)
				t = res.result(binding)
				file.puts t
			when "Remove"
				# do nothing
			else
				# Evaluate and write ENTITY Block template 
				baseClass = prefix + select.name
				xmiid = baseClass + '-Block'
				res = ERB.new(entity_block_template)
				t = res.result(binding)
				file.puts t
				res = ERB.new(select_stereotype_template)
				t = res.result(binding)
				file.puts t
		end
	end

	typeProxies.each_value do |type| 
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + type.name + "_Proxy"
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
		res = ERB.new(proxy_stereotype_template)
		t = res.result(binding)
		file.puts t
	end

	# Evaluate and write file end template 
	res = ERB.new(overall_end_template)
	t = res.result(binding)
	file.puts t

	if $uuidsRequired
		for uuidmap in $olduuids
			uuidmap.remove
		end
		uuidfile.close
		File.open("UUIDs.xml","w"){|file| $uuidxml.write_xml_to file} 
	end
	
	if $wherexml != nil
		File.open("WhereRuleMapping.xml","w"){|file| $wherexml.write_xml_to file}
	end
end

