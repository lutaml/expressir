require 'erb'
require 'uuid'
require 'nokogiri'
include Nokogiri

# EXPRESS to SysML Mapping
# Version 0.5
#
# This function navigates the EXPRESS STEPMod Model Ruby Classes
# and performs a structural EXPRESS-to-SysML (1.4) mapping using Ruby ERB templates.
# The output is in XMI 2.1 or 2.5 syntax in a file named <schema>.xmi if one schema input and 'Model.xmi' if more than one schema input.
# 
# Real, Number, Integer, Boolean, String -> New Primitive Type
# Binary, Logical -> New PrimitiveType
# Schema -> Package
# Entity (subtype of) -> Class (Generalization) + Block stereotype
# Select Type -> Class & Generalization + Block/value  and <<Auxillary>> stereotype
# Agg Type -> Collapsed into attribute if just used, converted into class with elements if part of aggregation or select type
# Enum Type -> Enumeration and EnumerationLiteral
# Explicit Attribute (Optional) Primitive or Enum -> Property owned by Class (with lower)
# Explicit Attribute (Optional) Entity -> Property owned by Class (with lower) plus Association owning other end property
# Explicit Attribute 1-D SET, BAG, LIST of Select or Entity -> Property owned by Class (with lower) 
#                                    plus Association owning other end property and multiplicity, unique and ordered set
# Explicit Attribute 1-D SET, BAG, LIST of Primitive or Enum -> Property owned by Class and multiplicity, unique and ordered set
#                Higher level aggregations create intermediary blocks
# Explicit Attribute of Entity/Select/Builtin Redeclaration (Renamed) -> Property with (new) name that redefines inherited Property
# Inverse Attribute -> Association end adjustment
# Inverse Attribute Redeclaration (Renamed) -> Property with (new) name that redefines inherited Property
# USE or REFERENCE (even with named items) -> UML PackageImport between Packages
#
#######################################################################################

def get_uuid(id)
	if $uuidsRequired
		uuidmap = $uuidxml.xpath('//uuidmap[@id="' + id + '"]').first
		if !uuidmap.nil?
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
	if !$wherexml.nil?
		wheremap = $wherexml.xpath('//wheremap[@id="' + id + '"]').first
		if !wheremap.nil?
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
operation_template = %{<ownedOperation xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Operation">
<name><%= op_name %></name>
<ownedRule xmi:id="<%= xmiid %>-body"<%= get_uuid(xmiid+'-body') %> xmi:type="uml:Constraint">
<specification xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %> xmi:type="uml:OpaqueExpression">
<body><%= op_ocl %></body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

parameter_template = %{<ownedParameter xmi:id="<%= par_xmiid %>"<%= get_uuid(par_xmiid) %> xmi:type="uml:Parameter">
<name><%= par_name %></name>
<type xmi:idref="<%= par_type %>"/>
</ownedParameter>}

return_template = %{<ownedParameter xmi:id="<%= xmiid %>-return"<%= get_uuid(xmiid+'-return') %> xmi:type="uml:Parameter">
<direction>return</direction>
<type xmi:idref="<%= ret_type %>"/>
</ownedParameter>}

operation_end = %{</ownedOperation>}

	if !$opsxml.nil?
		ops = $opsxml.xpath('//operation[@for="' + name + '"]')
		for op in ops
			body = op.at('body')
			if !body.nil?
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
				encapsulated = !(rule.expression[25..-1].include? ("." + attrib.entity.name.upcase + "." + attrib.name.upcase))
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

def isEncapsulatedInto (parent, entity, attrib)
	encapsulated = false
	rules = parent.wheres.select {|w| w.name == "encapsulateInto"}
	if rules.length	> 0	
		for rule in rules
			ruleString = rule.expression.upcase
			if ruleString[0..6] == "EXISTS("
				closeParen = ruleString.index(')')
				if ruleString[closeParen..-1].include? " XOR (SIZEOF(TYPEOF(SELF) *"
					if !ruleString[closeParen+28..-1].include? ('.'+entity.name.upcase+'''')
						encapsulated = (ruleString[6..closeParen].include? ('('+attrib.name.upcase+')'))
					end
				else
					encapsulated = (ruleString[6..closeParen].include? ('('+attrib.name.upcase+')'))
				end
			else
				puts "Unknown encapsulateInto rule: " + rule.expression 
			end
			if encapsulated
				break
			end
		end
	end
	if !encapsulated
		for supertype in parent.supertypes_array
			encapsulated = isEncapsulatedInto(supertype, entity, attrib)
			if encapsulated
				break
			end
		end
	end
	return encapsulated
end

def map_from_express(mapinput, passedArgs)
	# Enter file name here to override defaults (<schema>.xmi if one schema, and Model.xmi if more than one)
	output_xmi_filename = nil

	noprune = false
	schemaId = false
	$uuidsRequired = true
	xmiVersion = "2.1"
	dtHandle = "local"
	outPath = nil
	for arg in passedArgs
		argarray = arg.split('=')
		case argarray[0]
			when "noprune" then noprune = true
			when "nouuids" then $uuidsRequired = false
			when "path" then outPath = argarray[1]
			when "schemaid" then schemaId = true
			when "xmi" then xmiVersion = argarray[1]
			when "types" then dtHandle = argarray[1]
		end
	end

	case xmiVersion
		when "2.1" then $StandardProfile = "StandardProfileL2"
		when "2.5" then $StandardProfile = "StandardProfile"
		else
			puts "XMI version "+xmiVersion+" is not handled!"
			exit
	end
		
	case dtHandle
		when "local"
			puts "Data types will generated within the package structure"
		when "ignore"
			puts "Data types will not be generated"
		when "export"
			puts "Data types will be exported to DataTypes.xmi"
		else
			puts "Data type handling option: "+dtHandle+" not valid!"
			exit
	end
		
	if dtHandle != "local"
		if outPath.nil?
			puts "path must be specified when type=" + dtHandle
			exit
		end
	end

	uuidSafe = nil
	uuidOldSafe = nil
	if $uuidsRequired
		$uuid = UUID.new
		if File.exists?("UUIDs.xml")
			uuidfile = File.open("UUIDs.xml")
			$uuidxml = Nokogiri::XML(uuidfile, &:noblanks)
			uuidfile.close
		else
			$uuidxml = Nokogiri::XML::Builder.new { |b| b.uuids }.doc
		end	
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

	# datatypes for builtin types that have been exported
	datatype_hash = Hash.new

	# XMI File Start Template (includes datatypes for builtin with no direct UML equivalent)
	overall_start_template = %{<?xml version="1.0" encoding="UTF-8"?><%
if xmiVersion == "2.1" %>
<xmi:XMI xmi:version="2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:uml="http://www.omg.org/spec/UML/20090901" xmlns:StandardProfileL2="http://schema.omg.org/spec/UML/2.3/StandardProfileL2.xmi" xmlns:sysml="http://www.omg.org/spec/SysML/20100301/SysML-profile"><%
else %>
<xmi:XMI xmlns:uml='http://www.omg.org/spec/UML/20131001' xmlns:xmi='http://www.omg.org/spec/XMI/20131001' xmlns:StandardProfile='http://www.omg.org/spec/UML/20131001/StandardProfile' xmlns:sysml='http://www.omg.org/spec/SysML/20150709/SysML'><%
end 
$dtprefix=''
if !outPath.nil?
 pathElements = outPath.split('/')
	if dtHandle=='local'
		for elem in pathElements 
			$dtprefix = $dtprefix + elem[0]
	 end 
		$dtprefix = $dtprefix + '_'
 end
end %>}

	# Package Structure Start
	package_start = %{<%
if outPath.nil?
	name = "SysMLfromEXPRESS"
else
 pathElements = outPath.split('/')
 name = pathElements[-1]
end %>
<uml:Package xmi:id="_0_<%= name %>"<%= get_uuid('_0_'+name) %> xmi:type="uml:Package">
<name><%= name %></name>}

	# Apply SysML profile
	apply_sysml = %{<profileApplication xmi:id="_profileApplication0"<%= get_uuid('_profileApplication0') %> xmi:type="uml:ProfileApplication"><%
if xmiVersion == "2.1" %>
<appliedProfile href="http://www.omg.org/spec/SysML/20100301/SysML-profile.uml#_0"/><%
else %>
<appliedProfile href="http://www.omg.org/spec/SysML/20150709/SysML.xmi#_SysML__0"/><%
end %>
</profileApplication>}

	# Package end
	package_end = %{</uml:Package>}

	# XMI File End Template
	overall_end_template = %{</xmi:XMI>}

	#DATA TYPEs
	data_types = %{<packagedElement xmi:id="<%= $dtprefix %>BINARY"<%= get_uuid($dtprefix+'BINARY') %> xmi:type="uml:PrimitiveType">
<name>Binary</name>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>STRING"<%= get_uuid($dtprefix+'STRING') %> xmi:type="uml:PrimitiveType">
<name>String</name>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>NUMBER"<%= get_uuid($dtprefix+'NUMBER') %> xmi:type="uml:PrimitiveType">
<name>Number</name>
<isAbstract>true</isAbstract>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>REAL"<%= get_uuid($dtprefix+'REAL') %> xmi:type="uml:PrimitiveType">
<name>Real</name>
<generalization xmi:id="_generalization-<%= $dtprefix %>REAL_NUMBER"<%= get_uuid('_generalization-'+$dtprefix+'REAL_NUMBER') %> xmi:type="uml:Generalization">
<general xmi:idref="<%= $dtprefix %>NUMBER"/>
</generalization>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>INTEGER"<%= get_uuid($dtprefix+'INTEGER') %> xmi:type="uml:PrimitiveType">
<name>Integer</name>
<generalization xmi:id="_generalization-<%= $dtprefix %>INTEGER_REAL"<%= get_uuid('_generalization-'+$dtprefix+'INTEGER_REAL') %> xmi:type="uml:Generalization">
<general xmi:idref="<%= $dtprefix %>REAL"/>
</generalization>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>LOGICAL"<%= get_uuid($dtprefix+'LOGICAL') %> xmi:type="uml:Enumeration">
<name>Logical</name>
<ownedLiteral xmi:id="<%= $dtprefix %>UNKNOWN"<%= get_uuid($dtprefix+'UNKNOWN') %> xmi:type="uml:EnumerationLiteral">
<name>Unknown</name>
</ownedLiteral>
</packagedElement>
<packagedElement xmi:id="<%= $dtprefix %>BOOLEAN"<%= get_uuid($dtprefix+'BOOLEAN') %> xmi:type="uml:Enumeration">
<name>Boolean</name>
<generalization xmi:id="<%= $dtprefix %>_generalization-<%= $dtprefix %>BOOLEAN-LOGICAL"<%= get_uuid('_generalization-'+$dtprefix+'BOOLEAN-LOGICAL') %> xmi:type="uml:Generalization">
<general xmi:idref="<%= $dtprefix %>LOGICAL"/>
</generalization>
<ownedLiteral xmi:id="<%= $dtprefix %>TRUE"<%= get_uuid($dtprefix+'TRUE') %> xmi:type="uml:EnumerationLiteral">
<name>True</name>
</ownedLiteral>
<ownedLiteral xmi:id="<%= $dtprefix %>FALSE"<%= get_uuid($dtprefix+'FALSE') %> xmi:type="uml:EnumerationLiteral">
<name>False</name>
</ownedLiteral>
</packagedElement>}

	#DATA TYPE end
	data_type_stereos = %{<sysml:ValueType xmi:id="<%= $dtprefix %>LOGICAL_VT"<%= get_uuid($dtprefix+'LOGICAL_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>LOGICAL"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>BOOLEAN_VT"<%= get_uuid($dtprefix+'BOOLEAN_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>BOOLEAN"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>NUMBER_VT"<%= get_uuid($dtprefix+'NUMBER_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>NUMBER"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>REAL_VT"<%= get_uuid($dtprefix+'REAL_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>REAL"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>INTEGER_VT"<%= get_uuid($dtprefix+'INTEGER_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>INTEGER"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>STRING_VT"<%= get_uuid($dtprefix+'STRING_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>STRING"/>
</sysml:ValueType>
<sysml:ValueType xmi:id="<%= $dtprefix %>BINARY_VT"<%= get_uuid($dtprefix+'BINARY_VT') %>>
<base_DataType xmi:idref="<%= $dtprefix %>BINARY"/>
</sysml:ValueType>}

	# SCHEMA Start Template
	schema_start_template = %{<% if schema_list.size > 1 %><packagedElement<% else %><uml:Package<% end %> xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Package">
<name><%= schema.name %></name>}

	# SCHEMA INTERFACE Template
	schema_interface_template = %{<packageImport xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:PackageImport">
<importedPackage xmi:idref="_1_<%= interfaced_schema.foreign_schema_id %>"/>
</packageImport>}

	# SCHEMA End Template
	schema_end_template = %{<% if schema_list.size > 1 %></packagedElement><% else %></uml:Package><% end %>}

	# ENTITY Block Template
	entity_block_template = %{<sysml:Block xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<base_Class xmi:idref="<%= baseClass %>"/>
</sysml:Block>}

	# ENTITY Start Template
	entity_start_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Class">
<name><%= entity.name %></name><% if entity.isAbs %>
<isAbstract>true</isAbstract><% end %>}

	# SUBTYPE OF Template
	supertype_template = %{<generalization xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Generalization">
<general xmi:idref="<%= xmiid_general %>"/>
</generalization>}

	# ENTITY End Template
	entity_end_template = %{</packagedElement>}

	# ENUMERATION Start Template
	enum_start_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Enumeration">
<name><%= enum.name %></name><% if !general.nil?
if !datatype_hash[general].nil? %>
<generalization xmi:id="<%= gen_xmiid %>"<%= get_uuid(gen_xmiid) %> xmi:type="uml:Generalization">
<general href="<%= datatype_hash[general] %>"/>
</generalization><% else %>
<generalization xmi:id="<%= gen_xmiid %>"<%= get_uuid(gen_xmiid) %> xmi:type="uml:Generalization">
<general xmi:idref="<%= xmiid_general %>"/>
</generalization>
<% end 
end%>}

	# ENUMERATION ITEM Template
	enum_item_template = %{<ownedLiteral xmi:id="<%= enumitem_xmiid %>"<%= get_uuid(enumitem_xmiid) %> xmi:type="uml:EnumerationLiteral">
<name><%= enumitem %></name>
</ownedLiteral>}

	# ENUMERATION End Template
	enum_end_template = %{</packagedElement>}

	# SELECT Start Template
	select_start_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="<% if selectTypeType[type.name] == "Type" %>uml:DataType<% else %>uml:Class<% end %>">
<name><%= type.name %></name>
<isAbstract>true</isAbstract>}

	# SELECT End Template
	select_end_template = %{</packagedElement>}

	# SELECT Stereotype Template
	select_stereotype_template = %{<<%= $StandardProfile %>:Auxiliary xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<base_Class xmi:idref="<%= baseClass %>"/>
</<%= $StandardProfile %>:Auxiliary>}

	# Template covering the output file contents for each attribute that is an entity
	attribute_entity_template = %{<ownedAttribute xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Property">
<name><%= attr.name %></name><% if islist %>
<isOrdered>true</isOrdered><% end %><% if !isset %>
<isUnique>false</isUnique><% end %>
<type xmi:idref="<%= domain_xmiid %>"/><% if (direct_inverse and !encapsulatedInto) or encapsulated %>
<aggregation>composite</aggregation><% end %>
<association xmi:idref="<%= assoc_xmiid %>"/><% if attr.redeclare_entity %>
<redefinedProperty xmi:idref="<%= redefined_xmiid %>"/><% end %>}

	# INVERSE ATTRIBUTE Template
	inverse_attribute_template = %{<ownedAttribute xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Property">
<name><%= inverse.name %></name><% if !isset %>
<isUnique>false</isUnique><% end %>
<isReadOnly>true</isReadOnly><% if encapsulatedInto %>
<aggregation>composite</aggregation><% end %>
<type xmi:idref="<%= domain_xmiid %>"/>
<association xmi:idref="<%= assoc_xmiid %>"/><% if inverse.redeclare_entity %>
<redefinedProperty xmi:idref="<%= redefined_xmiid %>"/><% end %>}

	#Template covering multiplicities
	multiplicity = %{<% dummy = nil
if lower == '0' %><lowerValue xmi:id="<%= xmiid %>-lowerValue"<%= get_uuid(xmiid + '-lowerValue') %> xmi:type="uml:LiteralInteger"/><% 
else
 if lower != '1' %><lowerValue xmi:id="<%= xmiid %>-lowerValue"<%= get_uuid(xmiid + '-lowerValue') %> xmi:type=<% if /\\d+/ === lower %>"uml:LiteralInteger"<% else %>"uml:LiteralString"<% end %>>
<value><%= lower %></value>
</lowerValue><% 
 else
		dummy = get_uuid(xmiid + '-lowerValue')
	end
end %><% if dummy.nil? %>
<% end %><% if upper != '1' %><upperValue xmi:id="<%= xmiid %>-upperValue"<%= get_uuid(xmiid + '-upperValue') %> xmi:type=<% if /(\\d+|\\*)/ === upper %>"uml:LiteralUnlimitedNatural"<% else %>"uml:LiteralString"<% end %>>
<value><%= upper %></value>
</upperValue><%
else
	dummy = get_uuid(xmiid + '-upperValue')
end %>}

	#Template covering attribute wrapup
	attribute_end = %{</ownedAttribute>}


	# EXPLICIT ATTRIBUTE ENTITY Create Association Template
	attribute_entity_association_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Association">
<memberEnd xmi:idref="<%= attr_xmiid %>"/><% 
if !inverse_exists %>
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<ownedEnd xmi:id="<%= xmiid %>-end"<%= get_uuid(xmiid+'-end') %> xmi:type="uml:Property"><% if encapsulatedInto %>
<aggregation>composite</aggregation><% end %>
<type xmi:idref="<%= owner_xmiid %>"/>
<association xmi:idref="<%= xmiid %>"/>
<lowerValue xmi:id="<%= xmiid %>-end-lowerValue"<%= get_uuid(xmiid+'-end-lowerValue') %> xmi:type="uml:LiteralInteger"/><%
	if encapsulated
		dummy = get_uuid(xmiid+'-end-upperValue')
	else %>
<upperValue xmi:id="<%= xmiid %>-end-upperValue"<%= get_uuid(xmiid+'-end-upperValue') %> xmi:type="uml:LiteralUnlimitedNatural">
<value>*</value>
</upperValue><%
	end %>
</ownedEnd><% 
else %><memberEnd xmi:idref="<%= iattr_xmiid %>"/><% 
end %><% 
if general_exists %>
<generalization xmi:id="<%= general_xmiid %>"<%= get_uuid(general_xmiid) %> xmi:type="uml:Generalization">
<general xmi:idref="<%= redefined_xmiid %>"/>
</generalization><%
end %>
</packagedElement>}

	 
	# INVERSE ATTRIBUTE ENTITY Create Association Template
	inverse_entity_association_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Association">
<memberEnd xmi:idref="<%= xmiid + '-end' %>"/>
<memberEnd xmi:idref="<%= iattr_xmiid %>"/>
<ownedEnd xmi:id="<%= xmiid %>-end"<%= get_uuid(xmiid+'-end') %> xmi:type="uml:Property">
<type xmi:idref="<%= owner_xmiid %>"/>
<association xmi:idref="<%= xmiid %>"/><% xmiid = xmiid + '-end' %>}

	inverse_entity_association_end = %{</ownedEnd>
<generalization xmi:id="<%= general_xmiid %>"<%= get_uuid(general_xmiid) %> xmi:type="uml:Generalization">
<general xmi:idref="<%= redefined_xmiid %>"/>
</generalization>
</packagedElement>}

	 
	# EXPLICIT ATTRIBUTE SIMPLE TYPE Template
	attribute_builtin_template = %{<ownedAttribute xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Property">
<name><%= attr.name %></name><% if islist %>
<isOrdered>true</isOrdered><% end %><% if !isset %>
<isUnique>false</isUnique><% end %>
<aggregation>composite</aggregation><% if attr.redeclare_entity %>
<redefinedProperty xmi:idref="<%= redefined_xmiid %>"/><% end %><% if !nestedAggs[domain_name].nil? %>
<type xmi:idref="<%= prefix+domain_name %>"/><% else if !datatype_hash[domain_name].nil? %>
<type href="<%= datatype_hash[domain_name] %>"/><% else %>
<type xmi:idref="<%= $dtprefix+domain_name %>"/><% end end %>}


	# EXPLICIT ATTRIBUTE ENUM and TYPE Template
	attribute_enum_type_template = %{<ownedAttribute xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Property">
<name><%= attr.name %></name>
<type xmi:idref="<%= type_xmiid %>"/><% if islist %>
<isOrdered>true</isOrdered><% end %><% if !isset %>
<isUnique>false</isUnique><% end %>
<aggregation>composite</aggregation>}

	# Lower bound constraint template
	bound_constraint = %{<ownedRule xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Constraint">
<name><%= name %>_LB</name>
<constrainedElement xmi:idref="<%= xmiid_entity %>"/>
<specification xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %> xmi:type="uml:OpaqueExpression">
<body><%= name %>-&gt;isEmpty() or <%= name %>-&gt;size() &gt;= <%= bound %></body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

	# UNIQUE rule template
	unique_template = %{<ownedRule xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Constraint">
<name><%= unique.name %></name>
<constrainedElement xmi:idref="<%= xmiid_entity %>"/>
<specification xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %> xmi:type="uml:OpaqueExpression">
<body><%= entity.name %>::allInstances()-&gt;isUnique(<%= unique_text %>)</body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

	# WHERE rule template
	where_template = %{<ownedRule xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Constraint">
<name><%= where.name %></name>
<constrainedElement xmi:idref="<%= xmiidref %>"/>
<specification xmi:id="<%= xmiid %>-spec"<%= get_uuid(xmiid+'-spec') %> xmi:type="uml:OpaqueExpression">
<body><%= where_ocl %></body>
<language>OCL2.0</language>
</specification>
</ownedRule>}

	# TYPE Template
	type_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:PrimitiveType">
<name><%= type.name %></name><% if !datatype_hash[type.domain].nil? %>
<generalization xmi:id="_supertype<%= xmiid %>"<%= get_uuid('_supertype'+xmiid) %> xmi:type="uml:Generalization">
<general href="<%= datatype_hash[type.domain] %>"/>
</generalization><% else %>
<generalization xmi:id="_supertype<%= xmiid %>"<%= get_uuid('_supertype'+xmiid) %> xmi:type="uml:Generalization">
<general xmi:idref="<%= $dtprefix+xmiid_general %>"/>
</generalization>
<% end %>}

	# ProxyTYPE Start Template
	proxy_start_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Class">
<name><%= type.name %>Proxy</name>
<ownedAttribute xmi:id="<%= xmiid %>_value"<%= get_uuid(xmiid + "_value") %> xmi:type="uml:Property">
<name>value</name>
<type xmi:idref="<%= xmiid_type %>"/>
<aggregation>composite</aggregation>
</ownedAttribute><%
dummy = get_uuid(xmiid + "_value-lowerValue")
dummy = get_uuid(xmiid + "_value-upperValue")
%>}

	# AggTYPE Start Template
	aggtype_start_template = %{<packagedElement xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Class">
<name><%= type_name %></name>}

	aggtype_attribute = %{<ownedAttribute xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %> xmi:type="uml:Property">
<name>elements</name><% if islist %>
<isOrdered>true</isOrdered><% end %><% if !isset %>
<isUnique>false</isUnique><% end %><% if datatype_hash[type.domain].nil? %>
<type xmi:idref="<%= xmiid_type %>"/><% else %>
<type href="<%= datatype_hash[type.domain] %>"/><% end %><% if associationNeeded %>
<association xmi:idref="<%= assoc_xmiid %>"/><% else %>
<aggregation>composite</aggregation><% end %>}

	aggtype_association = %{<packagedElement xmi:id="<%= assoc_xmiid %>"<%= get_uuid(assoc_xmiid) %> xmi:type="uml:Association">
<memberEnd xmi:idref="<%= xmiid %>"/>
<memberEnd xmi:idref="<%= assoc_xmiid + '-end' %>"/>
<ownedEnd xmi:id="<%= assoc_xmiid %>-end"<%= get_uuid(assoc_xmiid+'-end') %> xmi:type="uml:Property">
<type xmi:idref="<%= xmiid_type %>"/>
<association xmi:idref="<%= assoc_xmiid %>"/>
<lowerValue xmi:id="<%= assoc_xmiid %>-end-lowerValue"<%= get_uuid(assoc_xmiid+'-end-lowerValue') %> xmi:type="uml:LiteralInteger"/>
</ownedEnd>
</packagedElement>}

# TYPE  Stereotype Template
	type_stereotype_template = %{<<%= $StandardProfile %>:Type xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<base_Class xmi:idref="<%= baseClass %>"/>
</<%= $StandardProfile %>:Type>}

	#TYPE end Template
	type_end_template=%{</packagedElement>}

	# TYPE ValueType Template
	valuetype_template = %{<sysml:ValueType xmi:id="<%= xmiid %>"<%= get_uuid(xmiid) %>>
<base_DataType xmi:idref="<%= baseType %>"/>
</sysml:ValueType>}

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
		if output_xmi_filename.nil?
			schema = schema_list[0]
			output_xmi_filename = schema.name.to_s + ".xmi"
		end
		if schemaId
			get_prefix = lambda {|schema| '_' + schema.name + '-'}
		else
			get_prefix = lambda {|schema| '_'}
		end
	else
		if output_xmi_filename.nil?
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

	if dtHandle != "local"
		pathElements = outPath.split('/')
		relPath = "DataTypes.xmi"
		for elem in pathElements 
			relPath = "../" + relPath
		end
		datatype_hash["LOGICAL"] = relPath + "#LOGICAL"
		datatype_hash["BOOLEAN"] = relPath + "#BOOLEAN"
		datatype_hash["NUMBER"] = relPath + "#NUMBER"
		datatype_hash["REAL"] = relPath + "#REAL"
		datatype_hash["INTEGER"] = relPath + "#INTEGER"
		datatype_hash["STRING"] = relPath + "#STRING"
		datatype_hash["BINARY"] = relPath + "#BINARY"
	end

	# sort out data types
	if dtHandle != "ignore"
		if dtHandle == "local"
			dtfile = file
		else
			dtfile = File.new("DataTypes.xmi","w")
			res = ERB.new(overall_start_template)
			t = res.result(binding)
			dtfile.puts t
			if $uuidsRequired
				uuidSafe = $uuidxml
				uuidOldSafe = $olduuids
				if File.exists?("DataTypes_UUIDs.xml")
					uuidfile = File.open("DataTypes_UUIDs.xml")
					$uuidxml = Nokogiri::XML(uuidfile, &:noblanks)
					uuidfile.close
				else
					$uuidxml = Nokogiri::XML::Builder.new { |b| b.uuids }.doc
				end
				$olduuids = $uuidxml.xpath('//uuidmap')
			end
			xmiid = "_0_" + $dtprefix + "DataTypes"
			dtfile.puts '<uml:Package xmi:id="'+ xmiid +'"' + get_uuid(xmiid) +' xmi:type="uml:Package">'
			dtfile.puts '<name>DataTypes</name>'
			res = ERB.new(apply_sysml)
			t = res.result(binding)
			dtfile.puts t
		end
		res = ERB.new(data_types)
		t = res.result(binding)
		dtfile.puts t
		if dtHandle == "export"
			dtfile.puts '</uml:Package>'
		end
		if !uuidSafe.nil?
			tmp = uuidSafe
			uuidSafe = $uuidxml
			$uuidxml = tmp
			tmp = uuidOldSafe
			uuidOldSafe = $olduuids
			$olduuids = tmp
		end
	end

	# Set up list of all EXPRESS Inverses in all schemas 
	all_inverse_list = []
	direct_inverses = []
	# Set up list of all EXPRESS Selects in all schemas
	all_select_list = []
	renamed_select_list = []
	# setup global proxy type handling
	typeProxies = Hash.new

	# build all_select_list
	for schema in schema_list
		select_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeSelect }
		all_select_list = all_select_list + select_list
		type_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::Type and !e.isBuiltin}
		for type in type_list
			superselect = NamedType.find_by_name( type.domain )
			while (superselect.instance_of? EXPSM::Type and !superselect.isBuiltin)
				superselect = NamedType.find_by_name(superselect.domain)
			end
			if superselect.kind_of? EXPSM::TypeSelect
				renamed_select_list << type
			end
		end
	end

	# Set up storage for handling Aggregate and Select Types correctly
	aggTypes = Hash.new
	specialSelects = Hash.new

	# determine Aggregate and Select types needing special consideration
	for schema in schema_list
		entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }
		for entity in entity_list
			attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
			for attr in attr_list
				if attr.instance_of? EXPSM::ExplicitAggregate
					orig_domain = NamedType.find_by_name( attr.domain )
					if orig_domain.class.to_s == "EXPSM::TypeAggregate"
						if aggTypes[attr.domain].nil?
							aggTypes[attr.domain] = orig_domain
						end
					end
				end
				if attr.redeclare_entity
					attr_domain = NamedType.find_by_name(attr.domain)
					if attr_domain.instance_of? EXPSM::TypeSelect
						supertype = NamedType.find_by_name( attr.redeclare_entity )
						if attr.redeclare_oldname
							redeclOf = supertype.find_attr_by_name( attr.redeclare_oldname )
						else
							redeclOf = supertype.find_attr_by_name( attr.name )
						end
						redecl_domain = NamedType.find_by_name( redeclOf.domain )
						case redecl_domain.class.to_s
							when 'EXPSM::Entity', 'EXPSM::TypeSelect'
								if specialSelects[attr.domain].nil?
									specialSelects[attr.domain] = [redecl_domain]
								else
									if !specialSelects[attr.domain].include?(redecl_domain)
										specialSelects[attr.domain].push(redecl_domain)
									end
								end
						end
					end
				end
			end
		end
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
				when "EXPSM::TypeEnum" then typcount += 1
				when "EXPSM::TypeAggregate"
					if selectTypeType[select.name] != "Remove"
						entcount += 1
						if aggTypes[e.name].nil?
							aggTypes[e.name] = e
						end
					end
				when "EXPSM::TypeSelect"
					case selectTypeType[e.name]
						when "Entity" then entcount += 1
						when "Type" then typcount += 1
						when "Hybrid" then selectTypeType[select.name] = "Hybrid"
						when "Remove"
							case e.selectitems_array[0].class.to_s
								when "EXPSM::Entity" then entcount += 1
								when "EXPSM::Type" then typcount += 1
							end
					end
				else
					puts "unknown class " + e.class.to_s + " for " + select.name
			end
		end
		
		if selectTypeType[select.name].nil?
			case select.selectitems_array.size
				when entcount then  selectTypeType[select.name] = "Entity"
				when typcount then selectTypeType[select.name] = "Type"
				else
					if (entcount > 0) && (typcount > 0)
						selectTypeType[select.name] = "Hybrid"
					else
						unknownSelect.push select
					end
			end
		end
		if selectTypeType[select.name] == "Hybrid"			
			puts select.name + " is Hybrid select - proxy block(s) generated."
		end
	end

	# process subsetted select types
	selectSubset = Hash.new
	selectSubs = Hash.new
	for select in renamed_select_list
		superselect = NamedType.find_by_name( select.domain )
		if superselect.kind_of? EXPSM::TypeSelect
			temp = []
			superselect.selectitems_array.each{|e|
				if e.kind_of? EXPSM::TypeSelect
					e.selectitems_array.each{|inner|
						if inner.kind_of? EXPSM::TypeSelect
							puts "select of select select for " + superselect.name
						else
							temp << inner.name
						end}
				else
					temp << e.name
				end}
			if selectSubset[superselect.name].nil?
				selectSubset[superselect.name] = temp.dup
			end
			select.wheres.each{|rule| ruleString = rule.expression.upcase
				if ruleString[0..5] == "NOT ('"
					startPos = ruleString.index('.',6) + 1
					endPos = ruleString.index("'",startPos) - 1
					removeName = ruleString[startPos..endPos]
					temp.reject!{|e| e.upcase == removeName}
				else
					puts "Unexpected expression: " + rule.expression
				end
				}
			selectSubset[select.name] = temp
			selectSubset[superselect.name] = selectSubset[superselect.name] - temp
			if selectSubs[superselect.name].nil?
				selectSubs[superselect.name] = [select.name]
			else
				selectSubs[superselect.name] << select.name
			end
			selectTypeType[select.name] = selectTypeType[superselect.name]
		else
			puts "ERROR: Unhandled select subset for " + superselect.name
		end
	end

	if schema_list.size > 1
		res = ERB.new(package_start)
		t = res.result(binding)
		file.puts t
		
		#Apply sysml profile
		res = ERB.new(apply_sysml)
		t = res.result(binding)
		file.puts t
	end
		
	for schema in schema_list	
		# Set up storage for handling nested Aggregates correctly
		nestedAggs = Hash.new
		nestedTypes = Hash.new
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
		
		if schema_list.size == 1
			#Apply sysml profile
			res = ERB.new(apply_sysml)
			t = res.result(binding)
			file.puts t
		end

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
			if ["BOOLEAN", "LOGICAL"].include?(type.domain)
				enum = type
				general = type.domain
				gen_xmiid = '_supertype' + xmiid
				res = ERB.new(enum_start_template)
				t = res.result(binding)
				file.puts t
			else
				res = ERB.new(type_template)
				t = res.result(binding)
				file.puts t
			end
			
			# Map TYPE Select has Type as item
			for select in type.selectedBy
				# sort out what type of select we are dealing with
				case selectTypeType[select.name]
					when "Type"
						superName = select.name
						subset = selectSubset[superName]
						if !subset.nil?
							if !subset.include?(type.name)
								selectSubs[superName].each{|e|
									if selectSubset[e].include?(type.name)
										superName = e
									end}
							end
						end
						xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
						xmiid_general = prefix + superName
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					when "Hybrid"
						typeProxy = typeProxies[type.name]
						if typeProxy.nil?
							typeProxies[type.name] = type
						end
					when "Remove"
					 # do nothing
				end
			end		

			# Map EXPRESS Where rules
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
			domain = NamedType.find_by_name( type.domain )
			xmiid = prefix + type.name
			xmiid_type = xmiid
			# deal with special cases
			case domain.class.to_s
				when "EXPSM::TypeSelect"
					res = ERB.new(select_start_template)
					t = res.result(binding)
					file.puts t

					xmiid = '_2_superselect' + prefix + type.name + '-' + type.domain
					xmiid_general = prefix + type.domain
					res = ERB.new(supertype_template)
					t = res.result(binding)
					file.puts t

				when "EXPSM::TypeEnum"
					enum = type
					gen_xmiid = '_2_superenum' + prefix + type.name + '-' + type.domain
					xmiid_general = prefix + type.domain
					general = type.domain
					res = ERB.new(enum_start_template)
					t = res.result(binding)
					file.puts t

				else
					xmiid_general = prefix + type.domain
					res = ERB.new(type_template)
					t = res.result(binding)
					file.puts t
			end
					
			# Map TYPE Select has Type as item
			if selectTypeType[type.name] == "Type"
				for select in type.selectedBy
					case selectTypeType[select.name]
						when "Type"
							superName = select.name
							subset = selectSubset[superName]
							if !subset.nil?
								if !subset.include?(type.name)
									selectSubs[superName].each{|e|
										if selectSubset[e].include?(type.name)
											superName = e
										end}
								end
							end
							xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
							xmiid_general = prefix + superName
							res = ERB.new(supertype_template)
							t = res.result(binding)
							file.puts t
						when "Hybrid"
							typeProxy = typeProxies[type.name]
							if typeProxy.nil?
								typeProxies[type.name] = type
							end
						when "Remove"
							# do nothing
					end
				end
			else
				for select in type.selectedBy
					if selectTypeType[select.name] != "Remove"
						superName = select.name
						subset = selectSubset[superName]
						if !subset.nil?
							if !subset.include?(type.name)
								selectSubs[superName].each{|e|
									if selectSubset[e].include?(type.name)
										superName = e
									end}
							end
						end
						xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
						xmiid_general = prefix + superName
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					end
				end
			end
			
			case domain.class.to_s
				when "EXPSM::TypeSelect"
				when "EXPSM::TypeEnum"
					#Map EXPRESS Where rules
					whererules = type.wheres.select {|w| w.name[0..10] != "encapsulate"}
					if whererules.size > 0
						for where in whererules
							xmiid = '_3_whr' + prefix + type.name + '-' + where.name.to_s
							where_ocl = where.expression.gsub("<>", "&lt;&gt;")
							xmiidref = xmiid_type
							res = ERB.new(where_template)
							t = res.result(binding)
							file.puts t
						end
					end
				else
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
			end
				
			res = ERB.new(type_end_template)
			t = res.result(binding)
			file.puts t
		end

		aggTypes.each_value do |type| 
			if type.schema == schema
				# Evaluate and write aggType start template 
				# initialize default cardinailty constraints
				isset = true
				islist = false

				upper = type.dimensions[0].upper
				if upper == '?'
					upper = '*'
				end
				lower = type.dimensions[0].lower
				if type.dimensions[0].aggrtype == 'ARRAY'
					puts 'Warning ARRAY not fully supported for '+type.name
					upper = upper - lower + 1
					lower = upper
				end
				if type.dimensions[0].aggrtype == 'LIST'
					islist = true
				end
				if type.dimensions[0].aggrtype == 'BAG'
					isset = false
				end
				if type.dimensions[0].aggrtype == 'LIST' and !type.dimensions[0].isUnique
					isset = false
				end

				xmiid = prefix + type.name
				associationNeeded = false
				if type.isBuiltin
					xmiid_type = $dtprefix + type.domain
				else
					xmiid_type = prefix + type.domain

					domain = NamedType.find_by_name( type.domain )
					case domain.class.to_s
						when "EXPSM::Entity"
							associationNeeded = true
						when "EXPSM::Type"
								case selectTypeType[type.domain]
									when "Entity", "Hybrid"
										associationNeeded = true
								end
						when "EXPSM::TypeAggregate"
							if !aggTypes[type.domain].nil?
								associationNeeded = true
							end
						when "EXPSM::TypeSelect"
							case selectTypeType[type.domain]
								when "Entity", "Hybrid"
									associationNeeded = true
							end
					end
				end

				type_name = type.name
				res = ERB.new(aggtype_start_template)
				t = res.result(binding)
				file.puts t
				
				# Map TYPE Select has Entity as item
				for select in type.selectedBy
					superName = select.name
					subset = selectSubset[superName]
					if !subset.nil?
						if !subset.include?(type.name)
							selectSubs[superName].each{|e|
								if selectSubset[e].include?(type.name)
									superName = e
								end}
						end
					end
					xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
					xmiid_general = prefix + superName
					res = ERB.new(supertype_template)
					t = res.result(binding)
					file.puts t
				end
				
				if associationNeeded
					assoc_xmiid = '_1_association' + prefix + type.name + '-elements'
				end
				
				xmiid = '_2_attr' + prefix + type.name + "-elements" 
				res = ERB.new(aggtype_attribute)
				t = res.result(binding)
				file.puts t

				res = ERB.new(multiplicity,0,"<>")
				t = res.result(binding)
				if !t.nil? && t.size>0
					file.puts t
				end

				res = ERB.new(attribute_end)
				t = res.result(binding)
				file.puts t

				res = ERB.new(type_end_template)
				t = res.result(binding)
				file.puts t
				
				if associationNeeded
					res = ERB.new(aggtype_association)
					t = res.result(binding)
					file.puts t
				end
			end
		end
		
		# Map EXPRESS Enumeration Types
		enum_list = schema.contents.find_all{ |e| e.instance_of? EXPSM::TypeEnum }
		for enum in enum_list

			superenum = enum.extends_item
			general = nil
			if !superenum.nil?
				if superenum.kind_of? EXPSM::TypeEnum
					# Write Enum Item template for parent (maps to UML same as EXPRESS supertype)
					gen_xmiid = '_2_superenum' + prefix + enum.name + '-' + superenum.name
					xmiid_general = get_prefix.call(superenum.schema) + superenum.name
					general = superenum.name
				end
			end
			# Evaluate and write TYPE Enum start template 
			xmiid = prefix + enum.name
			res = ERB.new(enum_start_template)
			t = res.result(binding)
			file.puts t

			# Map TYPE Select has Enum as item
			for select in enum.selectedBy
				# sort out what type of select we are dealing with
				case selectTypeType[select.name]
					when "Type"
						superName = select.name
						subset = selectSubset[superName]
						if !subset.nil?
							if !subset.include?(enum.name)
								selectSubs[superName].each{|e|
									if selectSubset[e].include?(enum.name)
										superName = e
									end}
							end
						end
						xmiid = '_2_selectitem' + prefix + enum.name + '-' + superName
						xmiid_general = prefix + superName
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					when "Hybrid"
						typeProxy = typeProxies[enum.name]
						if typeProxy.nil?
							typeProxies[enum.name] = enum
						end
					when "Remove"
					 # do nothing
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
				
				# Deal with ad-hoc subtype constraints on entities
				superentities = specialSelects[type.name]
				if !superentities.nil?
					superentities.each {|superentity|
						xmiid = '_2_superentity' + prefix + type.name + '-' + superentity.name
						xmiid_general = get_prefix.call(superentity.schema)  + superentity.name
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t}
				end

				superselect = type.extends_item
				if !superselect.nil?
					if superselect.kind_of? EXPSM::TypeSelect
						if !superentities.include?(superselect)
							# Write Select Item template for parent (maps to UML same as EXPRESS supertype)
							xmiid = '_2_superselect' + prefix + type.name + '-' + superselect.name
							xmiid_general = get_prefix.call(superselect.schema)  + superselect.name
							res = ERB.new(supertype_template)
							t = res.result(binding)
							file.puts t
						end
					end
				end
				
				# Evaluate and write Select Item template for each item (maps to UML same as EXPRESS supertype)
				if selectTypeType[type.name] == "Type"
					for superselect in type.selectedBy
						case selectTypeType[superselect.name]
							when "Hybrid"
								typeProxy = typeProxies[type.name]
								if typeProxy.nil?
									typeProxies[type.name] = type
								end
							when "Remove"
								# do nothing
							else
								superName = superselect.name
								subset = selectSubset[superselect.name]
								if !subset.nil?
									if !subset.include?(type.name)
										selectSubs[superselect.name].each{|e|
											if selectSubset[e].include?(type.name)
												superName = e
											end}
									end
								end
								if superentities.nil? || superentities.all?{|superentity| superentity.name != superName}
									xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
									xmiid_general = prefix + superName
									res = ERB.new(supertype_template)
									t = res.result(binding)
									file.puts t
								end
						end
					end
				else
					for superselect in type.selectedBy
						if selectTypeType[superselect.name] !="Remove"
							superName = superselect.name
							subset = selectSubset[superselect.name]
							if !subset.nil?
								if !subset.include?(type.name)
									selectSubs[superselect.name].each{|e|
										if selectSubset[e].include?(type.name)
											superName = e
										end}
								end
							end
							if superentities.nil? || superentities.all?{|superentity| superentity.name != superName}
								xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
								xmiid_general = prefix + superName
								res = ERB.new(supertype_template)
								t = res.result(binding)
								file.puts t
							end
						end
					end
				end

				# Evaluate and write TYPE Select end template 
				res = ERB.new(select_end_template)
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
				for select in type.selectedBy
					if selectTypeType[select.name] == "Hybrid"
						superName = select.name
						subset = selectSubset[superName]
						if !subset.nil?
							if !subset.include?(type.name)
								selectSubs[superName].each{|e|
									if selectSubset[e].include?(type.name)
										superName = e
									end}
							end
						end
						xmiid = '_2_selectitem' + prefix + type.name + '-' + superName
						xmiid_general = prefix + superName
						res = ERB.new(supertype_template)
						t = res.result(binding)
						file.puts t
					end
				end
				
				res = ERB.new(type_end_template)
				t = res.result(binding)
				file.puts t
			end
		end

		entity_list = schema.contents.find_all{ |e| e.kind_of? EXPSM::Entity }

		# Map EXPRESS Explicit Attribute resulting UML Association (the Association is referenced from Class resulting from Entity)
		for entity in entity_list
			attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
			for attr in attr_list
				
				domain_name = attr.domain
				orig_domain = NamedType.find_by_name(domain_name)
				attr_domain = orig_domain
				agg_domain = nil
				attrType = nil
				associationNeeded = false
				begin
					unchanged = true
					case attr_domain.class.to_s
						when "EXPSM::Entity"
							associationNeeded = true
						when "EXPSM::Type"
								case selectTypeType[domain_name]
									when "Entity", "Hybrid"
										associationNeeded = true
								end
						#ignore unhandled named aggregations
						when "EXPSM::TypeAggregate"
							if aggTypes[domain_name].nil?
								attrType = attr_domain
								agg_domain = attr_domain
								if attr_domain.isBuiltin
									domain_name = attr_domain.domain
									attr_domain = nil
								else
									domain_name = attr_domain.domain
									attr_domain = NamedType.find_by_name(domain_name)
									unchanged = false
								end
							else
								associationNeeded = true
							end
						when "EXPSM::TypeSelect"
							case selectTypeType[domain_name]
								when "Entity", "Hybrid"
									associationNeeded = true
								# ignore removed select types
								when "Remove"
								attr_domain = attr_domain.selectitems_array[0]
								domain_name = attr_domain.name
								unchanged = false
							end
					end
				end until unchanged
				
				if attr.instance_of? EXPSM::ExplicitAggregate
					attrType = attr
				end
				
				if !attrType.nil?
					if attrType.rank > 1
						associationNeeded = true
						for i in 2..attrType.rank
							domain_name = attrType.dimensions[i-1].aggrtype+domain_name
						end
					end
				end

				if associationNeeded
					xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
					attr_xmiid = '_2_attr' + prefix + entity.name + '-' + attr.name
					owner_xmiid = prefix + entity.name
					if attr_domain.nil?
						domain_xmiid = prefix + domain_name
					else
						domain_xmiid = get_prefix.call(attr_domain.schema) +  attr_domain.name
					end
					
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
					
					# check if inverse refers to this attribute, affects how association is written
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
					if !attr_domain.nil?
						if attr_domain == orig_domain
							encapsulated = isEncapsulated(attr_domain, attr)
						else
							if !agg_domain.nil?
								encapsulated = isEncapsulated(agg_domain, attr)
							end
							if !encapsulated
								encapsulated = isEncapsulated(attr_domain, attr)
								if !encapsulated
									encapsulated = isEncapsulated(orig_domain, attr)
								end
							end
						end
					end
					
					encapsulatedInto = false
					if !inverse_exists
						encapsulatedInto = isEncapsulatedInto(entity, entity, attr)
					end
					
					res = ERB.new(attribute_entity_association_template)
					t = res.result(binding)
					file.puts t
				end
			end
		end

		# Map EXPRESS Inverse Attribute resulting UML Association (the Association is referenced from Class resulting from Entity)
		for inverse in all_inverse_list
			if inverse.entity.schema == schema
				temp_id = get_prefix.call(inverse.entity.schema) + inverse.entity.name + '-' + inverse.name
				xmiid = '_1_association' + temp_id
				owner_xmiid = get_prefix.call(inverse.entity.schema) + inverse.entity.name
				iattr_xmiid = '_2_attr' + temp_id
				
				general_xmiid = '_2_general' + temp_id
				redefined_xmiid = '_1_association' + get_prefix.call(inverse.reverseAttr.entity.schema) + inverse.reverseAttr.entity.name + '-' + inverse.reverseAttr_id

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
				if inverse.reverseAttr.isOptional
					lower = '0'
				end
				res = ERB.new(inverse_entity_association_template)
				t = res.result(binding)
				file.puts t
				
				res = ERB.new(multiplicity,0,"<>")
				t = res.result(binding)
				if !t.nil? && t.size>0
					file.puts t
				end

				res = ERB.new(inverse_entity_association_end)
				t = res.result(binding)
				file.puts t
			end
		end

		# Map EXPRESS Entity Types 
		for entity in entity_list
			lowBounds = Hash.new
			
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
			for select in entity.selectedBy
				if selectTypeType[select.name] != "Remove"
					superName = select.name
					subset = selectSubset[superName]
					if !subset.nil?
						if !subset.include?(entity.name)
							selectSubs[superName].each{|e|
								if selectSubset[e].include?(entity.name)
									superName = e
								end}
						end
					end
					xmiid = '_2_selectitem' + prefix + entity.name + '-' + superName
					xmiid_general = prefix + superName
					res = ERB.new(supertype_template)
					t = res.result(binding)
					file.puts t
				else
					# if in a select list that has been removed make it a subtype of all selects that include the removed select
					for superselect in all_select_list
						if superselect.selectitems_array.include?(select)
							superName = superselect.name
							subset = selectSubset[superName]
							if !subset.nil?
								if !subset.include?(select.name)
									selectSubs[superName].each{|e|
										if selectSubset[e].include?(select.name)
											superName = e
										end}
								end
							end
							puts entity.name + " added to " + superName
							puts "    following removal of " + select.name
							xmiid = '_2_selectitem' + prefix + entity.name + '-' + superName
							xmiid_general = prefix + superName
							res = ERB.new(supertype_template)
							t = res.result(binding)
							file.puts t
						end
					end
				end
			end

			# Map EXPRESS Explicit Attributes
			attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Explicit }
			for attr in attr_list
				xmiid = '_2_attr' + prefix + entity.name + '-' + attr.name

				# set up references resulting from attribute being a redeclaration
				if attr.redeclare_entity
					redeclare_entity = NamedType.find_by_name( attr.redeclare_entity )
					if attr.redeclare_oldname
						redefined_xmiid = '_2_attr' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.redeclare_oldname
					else
						redefined_xmiid = '_2_attr' + get_prefix.call(redeclare_entity.schema) + attr.redeclare_entity + '-' + attr.name
					end
				end

				# initialize default cardinailty constraints
				lower = '1'
				upper = '1'
				isset = true
				islist = false
				
				domain_name = attr.domain
				orig_domain = NamedType.find_by_name( attr.domain )
				attr_domain = orig_domain
				agg_domain = nil
				attrType = nil
				associationNeeded = false
				begin
					unchanged = true
					case attr_domain.class.to_s
						when "EXPSM::Entity"
							associationNeeded = true
						when "EXPSM::Type"
								case selectTypeType[attr_domain.name]
									when "Entity", "Hybrid"
										associationNeeded = true
								end
						#ignore unhandled named aggregations
						when "EXPSM::TypeAggregate"
							if aggTypes[attr.domain].nil?
								attrType = attr_domain
								agg_domain = attr_domain
								if attr_domain.isBuiltin
									domain_name = attr_domain.domain
									attr_domain = nil
								else
									newDomain = NamedType.find_by_name( attr_domain.domain )
									attr_domain = newDomain
									domain_name = attr_domain.name
									unchanged = false
								end
							else
								associationNeeded = true
							end
						when "EXPSM::TypeSelect"
							case selectTypeType[attr_domain.name]
								when "Entity", "Hybrid"
									associationNeeded = true
								# ignore removed select types
								when "Remove"
								attr_domain = attr_domain.selectitems_array[0]
								domain_name = attr_domain.name
								unchanged = false
							end
					end
				end until unchanged

				# set up cardinailty constraints from attribute being a 1-D aggregate
				# or a type defined to be a 1-D aggregate
				if attr.instance_of? EXPSM::ExplicitAggregate
					attrType = attr
				end
				
				if !attrType.nil?
					upper = attrType.dimensions[0].upper
					if upper == '?'
						upper = '*'
					end
					lower = attrType.dimensions[0].lower
					if attrType.dimensions[0].aggrtype == 'ARRAY'
						puts 'Warning ARRAY not fully supported for '+attr.name
					end
					if attrType.dimensions[0].aggrtype == 'LIST'
						islist = true
					end
					if attrType.dimensions[0].aggrtype == 'BAG'
						isset = false
					end
					if attrType.dimensions[0].aggrtype == 'LIST' and !attrType.dimensions[0].isUnique
						isset = false
					end
					if attrType.rank > 1
						associationNeeded = true
						for i in 2..attrType.rank
							domain_name = attrType.dimensions[i-1].aggrtype+domain_name+lower+upper
							nestedAggs[domain_name] = attrType.dimensions[i-1]
							nestedTypes[domain_name] = attrType
						end
					end
				end
				if attr.isOptional
					case lower
						when '0','1'
						else
							lowBounds[attr.name] = lower
					end
					lower = '0'
				end
				
				# Map EXPRESS Explicit Attributes that need an association
				if associationNeeded
					if attr_domain.nil?
						domain_xmiid = prefix + domain_name
					else
						domain_xmiid = get_prefix.call(attr_domain.schema) + domain_name
					end
					assoc_xmiid = '_1_association' + prefix + entity.name + '-' + attr.name
					
					direct_inverse = false
					encapsulatedInto = false
					for inverse in direct_inverses
						if inverse.reverseAttr == attr
							if !inverse.instance_of? EXPSM::InverseAggregate
								direct_inverse = true
								encapsulatedInto = isEncapsulatedInto(entity, entity, attr)
							end
						end
					end				
					
					if !attr_domain.nil?
						if attr_domain == orig_domain
							encapsulated = isEncapsulated(attr_domain, attr)
						else
							if !agg_domain.nil?
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
					end

					res = ERB.new(attribute_entity_template,0,"<>")
					t = res.result(binding)
					file.puts t
				else
					# Map EXPRESS Explicit Attributes of Builtin
					if attr.isBuiltin or (attr_domain.nil?)
						res = ERB.new(attribute_builtin_template,0,"<>")
						t = res.result(binding)
						file.puts t
					else
						# Map EXPRESS Explicit Attributes of TYPE, TYPE Enum and TYPE Select (type)
						type_xmiid = get_prefix.call(attr_domain.schema)  + domain_name
						res = ERB.new(attribute_enum_type_template,0,"<>")
						t = res.result(binding)
						file.puts t
					end
				end
				
				res = ERB.new(multiplicity,0,"<>")
				t = res.result(binding)
				if !t.nil? && t.size>0
					file.puts t
				end

				res = ERB.new(attribute_end)
				t = res.result(binding)
				file.puts t
			end

			#Map EXPRESS Inverse Attributes
			inverse_attr_list = entity.attributes.find_all{ |e| e.kind_of? EXPSM::Inverse }
			for inverse in inverse_attr_list
				xmiid = '_2_attr' + prefix + entity.name + '-' + inverse.name
				# set up references resulting from attribute being a redeclaration
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
				if all_inverse_list.include?(inverse)
					assoc_xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + entity.name + '-' + inverse.name
				else
					if inverse.reverseAttr.domain == entity.name
						assoc_xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + inverse.reverseEntity.name + '-' + inverse.reverseAttr_id
					else
						assoc_xmiid = '_1_association' + get_prefix.call(inverse.reverseEntity.schema) + entity.name + '-' + inverse.reverseAttr_id
					end
				end
				
				encapsulatedInto = isEncapsulatedInto(inverse.reverseEntity, inverse.reverseEntity, inverse.reverseAttr)
				
				res = ERB.new(inverse_attribute_template)
				t = res.result(binding)
				file.puts t
				
				res = ERB.new(multiplicity,0,"<>")
				t = res.result(binding)
				if !t.nil? && t.size>0
					file.puts t
				end
				
				res = ERB.new(attribute_end)
				t = res.result(binding)
				file.puts t
			end

			# Create lower bound constraints where required
			lowBounds.each do |name, bound| 
				xmiid = '_3_lb' + prefix + entity.name + '-' + name
				res = ERB.new(bound_constraint)
				t = res.result(binding)
				file.puts t
			end

			# Map EXPRESS Unique rules
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
			
			# Map EXPRESS Where rules
			whererules = entity.wheres.select {|w| w.name[0..10] != "encapsulate"}
			if whererules.size > 0
				for where in whererules
					xmiid = '_3_whr' + prefix + entity.name + '-' + where.name.to_s
					where_ocl = get_where(xmiid, where.expression)
					if where_ocl.size > 0
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

		nestedAggs.each do |type_name, dimension| 
			# Evaluate and write aggType start template 
			# initialize default cardinailty constraints
			isset = true
			islist = false
			
			upper = dimension.upper
			if upper == '?'
				upper = '*'
			end
			lower = dimension.lower
			if dimension.aggrtype == 'LIST'
				islist = true
			end
			if dimension.aggrtype == 'BAG'
				isset = false
			end
			if dimension.aggrtype == 'LIST' and !dimension.isUnique
				isset = false
			end

			xmiid = prefix + type_name
			type = nestedTypes[type_name]
			associationNeeded = false
			
			if type.isBuiltin
				xmiid_type = $dtprefix + type.domain
			else
				xmiid_type = prefix + type.domain

				domain = NamedType.find_by_name( type.domain )
				case domain.class.to_s
					when "EXPSM::Entity"
						associationNeeded = true
					when "EXPSM::Type"
							case selectTypeType[type.domain]
								when "Entity", "Hybrid"
									associationNeeded = true
							end
					when "EXPSM::TypeAggregate"
						if !aggTypes[type.domain].nil?
							associationNeeded = true
						end
					when "EXPSM::TypeSelect"
						case selectTypeType[type.domain]
							when "Entity", "Hybrid"
								associationNeeded = true
						end
				end
			end
			res = ERB.new(aggtype_start_template)
			t = res.result(binding)
			file.puts t
			
			if associationNeeded
				assoc_xmiid = '_1_association' + prefix + type.name + '-elements'
			end
			
			xmiid = '_2_attr' + prefix + type.name + "-elements" 
			res = ERB.new(aggtype_attribute)
			t = res.result(binding)
			file.puts t
			
			res = ERB.new(multiplicity,0,"<>")
			t = res.result(binding)
			if !t.nil? && t.size>0
				file.puts t
			end

			res = ERB.new(attribute_end)
			t = res.result(binding)
			file.puts t

			res = ERB.new(type_end_template)
			t = res.result(binding)
			file.puts t
			
			if associationNeeded
				res = ERB.new(aggtype_association)
				t = res.result(binding)
				file.puts t
			end
		end

		# Evaluate and write SCHEMA end template 
		res = ERB.new(schema_end_template)
		t = res.result(binding)
		file.puts t
	end
	
	if schema_list.size > 1
		res = ERB.new(package_end)
		t = res.result(binding)
		file.puts t
	end
		
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
				xmiid = baseType + '-Auxiliary'
				res = ERB.new(select_stereotype_template)
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
				xmiid = baseClass + '-Auxiliary'
				res = ERB.new(select_stereotype_template)
				t = res.result(binding)
				file.puts t
		end
	end

	selectSubset.each_key do |select|
		if selectSubs[select].nil?
			case selectTypeType[select]
				when "Type"
					# Evaluate and write TYPE ValueType template
					baseType = prefix + select
					xmiid = baseType + '-ValueType'
					res = ERB.new(valuetype_template)
					t = res.result(binding)
					file.puts t
					xmiid = baseType + '-Auxiliary'
					res = ERB.new(select_stereotype_template)
					t = res.result(binding)
					file.puts t
				when "Remove"
					# do nothing
				else
					# Evaluate and write ENTITY Block template 
					baseClass = prefix + select
					xmiid = baseClass + '-Block'
					res = ERB.new(entity_block_template)
					t = res.result(binding)
					file.puts t
					xmiid = baseClass + '-Auxiliary'
					res = ERB.new(select_stereotype_template)
					t = res.result(binding)
					file.puts t
			end
		end
	end

	typeProxies.each_value do |type| 
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + type.name + "_Proxy"
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
		xmiid = baseClass + '-Type'
		res = ERB.new(type_stereotype_template)
		t = res.result(binding)
		file.puts t
	end

	aggTypes.each_value do |type| 
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + type.name
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
		xmiid = baseClass + '-Type'
		res = ERB.new(type_stereotype_template)
		t = res.result(binding)
		file.puts t
	end

	nestedTypes.each_key do |type_name| 
		# Evaluate and write ENTITY Block template 
		baseClass = prefix + type_name
		xmiid = baseClass + '-Block'
		res = ERB.new(entity_block_template)
		t = res.result(binding)
		file.puts t
		xmiid = baseClass + '-Type'
		res = ERB.new(type_stereotype_template)
		t = res.result(binding)
		file.puts t
	end
	
	if dtHandle != "ignore"
		if dtHandle == "export"
			if !uuidSafe.nil?
				tmp = uuidSafe
				uuidSafe = $uuidxml
				$uuidxml = tmp
				tmp = uuidOldSafe
				uuidOldSafe = $olduuids
				$olduuids = tmp
			end
		end
		res = ERB.new(data_type_stereos)
		t = res.result(binding)
		dtfile.puts t
		if dtHandle == "export"
			res = ERB.new(overall_end_template)
			t = res.result(binding)
			dtfile.puts t
			if !uuidSafe.nil?
				for uuidmap in $olduuids
					uuidmap.remove
				end
				File.open("DataTypes_UUIDs.xml","w"){|file| $uuidxml.write_xml_to file} 
				$uuidxml = uuidSafe
				$olduuids = uuidOldSafe
			end
			dtfile.close
		end
	end

	# Evaluate and write file end template 
	res = ERB.new(overall_end_template)
	t = res.result(binding)
	file.puts t
	
	file.close

	if $uuidsRequired
		for uuidmap in $olduuids
			uuidmap.remove
		end
		File.open("UUIDs.xml","w"){|file| $uuidxml.write_xml_to file} 
	end
	
	if !$wherexml.nil?
		File.open("WhereRuleMapping.xml","w"){|file| $wherexml.write_xml_to file}
	end
end

