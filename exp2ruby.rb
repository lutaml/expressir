require 'rexml/document'
include REXML
##
## Set global variable for XML namespace prefix to use (including the colon)
$xnspre = ""
##
## Set global variable that is the name of the Ruby module containing the resulting EXPRESS-based classes (make uppercase)
$modname = ""
##
## Set up Part 28 writer functions for attributes of simple, aggregates of simple, instance reference and aggregate of instance reference
##
def write_attribute_text_p28writer(rubyfile, attribute_name)
  rubyfile.puts "         a___" + attribute_name + ".text = " + attribute_name
end
def write_member_text_p28writer(rubyfile, attribute_name, attr_type,attr_aggr_dim)
  rubyfile.puts "         for " + attribute_name + "___member in " + attribute_name
  rubyfile.puts "            amember___" + attribute_name + " = a___" + attribute_name + ".add_element(" + "'ex:" +  attr_type.downcase + "-wrapper'" + ")"
  rubyfile.puts "            amember___" + attribute_name + ".text = " + attribute_name + "___member"
  rubyfile.puts "         end"
end
def write_attribute_id_p28writer(rubyfile, attribute_name)
  rubyfile.puts "         a___" + attribute_name + " = a___" + attribute_name + ".add_element(" + attribute_name + ".getP28entity)"
  rubyfile.puts "         a___" + attribute_name + ".attributes['ref'] = " + attribute_name + ".getP28id"
  rubyfile.puts "         a___" + attribute_name + ".attributes['xsi:nil'] = 'true'"
end
def write_member_id_p28writer(rubyfile, attribute_name,attr_aggr_dim)
  rubyfile.puts "         for " + attribute_name + "___member in " + attribute_name
  rubyfile.puts "            amember___" + attribute_name + " = a___" + attribute_name + ".add_element(" + attribute_name + "___member.getP28entity)"
  rubyfile.puts "            amember___" + attribute_name + ".attributes['ref'] = " + attribute_name + "___member" + ".getP28id"
  rubyfile.puts "            amember___" + attribute_name + ".attributes['xsi:nil'] = 'true'"
  rubyfile.puts "         end"
end
##
## this function handles the output related to EXPRESS explicit attributes
def handle_explicit(rubyfile, exp, attribute)
  attr_redecl = attribute.elements["redeclaration"]
  if attr_redecl == nil
    rubyfile.puts "      if " + attribute.attributes["name"].downcase + " != nil"
    rubyfile.puts "         a___" + attribute.attributes["name"].downcase + " = e___added.add_element('" + attribute.attributes["name"].capitalize + "'" + ")"
    attr_builtintype = attribute.elements["builtintype"]
    attr_type = attribute.elements["typename"]
    attr_aggr = attribute.elements["aggregate"]
    attr_aggr_dim = attribute.elements.size - 1
    if attr_builtintype != nil
      if attr_aggr == nil
        write_attribute_text_p28writer(rubyfile, attribute.attributes["name"].downcase)
      else
        attr_datatype = attr_builtintype.attributes["type"]
        write_member_text_p28writer(rubyfile, attribute.attributes["name"].downcase, attr_datatype,attr_aggr_dim)
      end
    end
    if attr_type != nil
      attr_type_name = attr_type.attributes["name"]
      xp = "//schema/entity[@name = " + "'" + attr_type_name + "'" + "]"
      attr_type_entity = exp.root.elements[xp]
      if attr_type_entity != nil
        if attr_aggr != nil
          write_member_id_p28writer(rubyfile, attribute.attributes["name"].downcase,attr_aggr_dim)
        else
          write_attribute_id_p28writer(rubyfile, attribute.attributes["name"].downcase)
        end
      end
      xp = "//schema/type[@name = " + "'" + attr_type_name + "'" + "]"
      attr_type_type = exp.root.elements[xp]
      if attr_type_type != nil
        attr_type_type_builtin = attr_type_type.elements["builtintype"]
        if attr_type_type_builtin != nil
          write_attribute_text_p28writer(rubyfile, attribute.attributes["name"].downcase)
        end
				attr_type_type_enum = attr_type_type.elements["enumeration"]
				if attr_type_type_enum != nil
					if attr_aggr != nil
						write_member_text_p28writer(rubyfile, attribute.attributes["name"].downcase, attr_datatype,attr_aggr_dim)
					else
						write_attribute_text_p28writer(rubyfile, attribute.attributes["name"].downcase)         
          end
        end

        attr_type_type_select = attr_type_type.elements["select"]
        if attr_type_type_select != nil
          if attr_aggr != nil
            write_member_id_p28writer(rubyfile, attribute.attributes["name"].downcase,attr_aggr_dim)
          else
            write_attribute_id_p28writer(rubyfile, attribute.attributes["name"].downcase)
          end
        end
      end
    end
    rubyfile.puts "      end"
  end
end
##
## this function handles the p28 reader related to EXPRESS explicit attributes
def handle_attr_p28read(rubyp28attr, exp, attribute)
  attr_redecl = attribute.elements["redeclaration"]
  if attr_redecl == nil
    attr_builtintype = attribute.elements["builtintype"]
    attr_type = attribute.elements["typename"]
    attr_aggr = attribute.elements["aggregate"]
    if attr_builtintype != nil
      if attr_aggr == nil
        write_attribute_text_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
      else
        attr_datatype = attr_builtintype.attributes["type"]
        write_member_text_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
      end
    end
    if attr_type != nil
      attr_type_name = attr_type.attributes["name"]
      xp = "//schema/entity[@name = " + "'" + attr_type_name + "'" + "]"
      attr_type_entity = exp.root.elements[xp]
      if attr_type_entity != nil
        if attr_aggr != nil
          write_member_id_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
        else
          write_attribute_id_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
        end
      end
      xp = "//schema/type[@name = " + "'" + attr_type_name + "'" + "]"
      attr_type_type = exp.root.elements[xp]
      if attr_type_type != nil
        attr_type_type_builtin = attr_type_type.elements["builtintype"]
        if attr_type_type_builtin != nil
          write_attribute_text_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
        end

				attr_type_type_enum = attr_type_type.elements["enumeration"]
				if attr_type_type_enum != nil
					write_attribute_text_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
        end

        attr_type_type_select = attr_type_type.elements["select"]
        if attr_type_type_select != nil
          if attr_aggr != nil
            write_member_id_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
          else
            write_attribute_id_p28reader(rubyp28attr, attribute.attributes["name"].downcase)
          end
        end
      end
    end
  end
end
def get_all_supertypes(exp)
  if $todo_array.size == 0
    return
  end
  temp_array = $todo_array
  new_name_array = []
  temp_array.reverse_each do |super_name|
    $name_array.push super_name
    new_name_array.push super_name
    $todo_array.pop
  end
  new_name_array.reverse_each do |super_name|
    xp = "//schema/entity[@name = " + "'" + super_name + "'" + "]"
    entity = exp.root.elements[xp]
    supertypes = entity.attributes["supertypes"]
    if supertypes != nil
      supertype_names = supertypes.split
      supertype_names.each do |super_name|
        $todo_array.push super_name
      end
    end
  end
  get_all_supertypes(exp)
end
def write_read_P28_entity_instance_read(rubyp28inst, name)
  rubyp28inst.puts "    if entity.name == " + "'" + name + "'"
  rubyp28inst.puts "      r = " + $modname + "::" + name + ".new"
  rubyp28inst.puts "      m.model_elements.push r"
  rubyp28inst.puts "      r.putP28id(id.to_s)"
  rubyp28inst.puts "    end"
end
def write_read_P28_attribute_value_read(rubyp28attr, ename, exp)
  rubyp28attr.puts "    if entity.name == " + "'" + ename + "'"
  rubyp28attr.puts "      for child in entity.elements"
  xp = "//schema/entity[@name = " + "'" + ename + "'" + "]"
  current_entity = exp.root.elements[xp]
  supertypes = current_entity.attributes["supertypes"]
  $name_array = []
  $todo_array = []
  if supertypes != nil
    supertype_names = supertypes.split
    supertype_names.each do |super_name|
      $todo_array.push super_name
    end
  end
  get_all_supertypes(exp)
  $name_array.reverse_each do |super_name|
    xp = "//schema/entity[@name = " + "'" + super_name + "'" + "]"
    super_entity = exp.root.elements[xp]
    for super_attribute in super_entity.elements.to_a("./explicit")
      ## aname = super_attribute.attributes["name"]
      handle_attr_p28read(rubyp28attr, exp, super_attribute)
      ## write_attribute_text_p28reader(rubyp28attr,aname)
    end
  end
  for current_attribute in current_entity.elements.to_a("./explicit")
    ## aname = current_attribute.attributes["name"]
    ## write_attribute_text_p28reader(rubyp28attr,aname)
    handle_attr_p28read(rubyp28attr, exp, current_attribute)
  end
  rubyp28attr.puts "       end"
  rubyp28attr.puts "    end"
end
def write_attribute_text_p28reader(rubyp28attr, attribute_name)
  rubyp28attr.puts "        if child.name ==  '" + attribute_name.capitalize + "'"
  rubyp28attr.puts "          r." + attribute_name.downcase + "= child.text()"
  rubyp28attr.puts "        end"
end
def write_member_text_p28reader(rubyp28attr, attribute_name)
  rubyp28attr.puts "        if child.name ==  '" + attribute_name.capitalize + "'"
  rubyp28attr.puts "          memlist = []"
  rubyp28attr.puts "          for member in child.elements"
  rubyp28attr.puts "            memlist.push member.text()"
  rubyp28attr.puts "          end"
  rubyp28attr.puts "          r." + attribute_name.downcase + "= memlist"
  rubyp28attr.puts "        end"
end
def write_member_id_p28reader(rubyp28attr, attribute_name)
  rubyp28attr.puts "        if child.name ==  '" + attribute_name.capitalize + "'"
  rubyp28attr.puts "          memlist = []"
  rubyp28attr.puts "          for member in child.elements"
  rubyp28attr.puts "            ref = member.attribute('ref')"
  rubyp28attr.puts "            i = 0"
  rubyp28attr.puts "              while i != -1"
  rubyp28attr.puts "                tempid = m.model_elements[i].getP28id.to_s"
  rubyp28attr.puts "                if tempid == ref.to_s"
  rubyp28attr.puts "                  p = m.model_elements[i]"
  rubyp28attr.puts "                  i = -2"
  rubyp28attr.puts "                end"
  rubyp28attr.puts " 	            i = i + 1"
  rubyp28attr.puts "              end"
  rubyp28attr.puts "            memlist.push p"
  rubyp28attr.puts "          end"
  rubyp28attr.puts "          r." + attribute_name.downcase + "= memlist"
  rubyp28attr.puts "        end"
end
def write_attribute_id_p28reader(rubyp28attr, attribute_name)
  rubyp28attr.puts "        if child.name ==  '" + attribute_name.capitalize + "'"
  rubyp28attr.puts "          ref = child.elements[1].attribute('ref')"
  rubyp28attr.puts "          i = 0"
  rubyp28attr.puts "            while i != -1"
  rubyp28attr.puts "              tempid = m.model_elements[i].getP28id.to_s"
  rubyp28attr.puts "              if tempid == ref.to_s"
  rubyp28attr.puts "                p = m.model_elements[i]"
  rubyp28attr.puts "                i = -2"
  rubyp28attr.puts "              end"
  rubyp28attr.puts " 	          i = i + 1"
  rubyp28attr.puts "            end"
  rubyp28attr.puts "          r." + attribute_name.downcase + "= p"
  rubyp28attr.puts "        end"
end
## exp2ruby
## Version 0.1
## 2006-09-07
##
## Parse input options : exp=<filename> prefix=<shortname> are required
##
exp_input = " "
prefix_input = " "
for arg in ARGV
  argarray = arg.split('=')
  if argarray[0] == "exp"
    exp_input = argarray[1]
  end
  if argarray[0] == "prefix"
    prefix_input = argarray[1]
  end
  if argarray[0] == "help" or argarray[0] == "-help" or argarray[0] == "--help"
    puts "exp2ruby Version 0.1"
    puts " "
    puts "Usage : exp2ruby exp=<schema.xml> prefix=<shortname>"
    puts " "
    puts "  <schema.xml> 	required input EXPRESS as XML file"
    puts "  <shortname> 	required XML Namespace prefix shortname (case sensitive) and Ruby module name (automatic upcase)"
    puts "Example: exp2ruby exp=Model.XML prefix=ap233 results in ap233 for XML prefix and AP233 for Ruby module name for EXPRESS in Model.XML file"
    exit
  end
end
if exp_input == " "
  puts "ERROR : No Schema XML input file (exp=<schema.xml>)"
  exit
end
if prefix_input == " "
  puts "ERROR : No XML Prefix and Ruby module name specified (prefix=<shortname>)"
  exit
end
if FileTest.exist?(exp_input) != true
  puts "ERROR : Schema XML input file not found : " + exp_input
  exit
end
$modname = prefix_input.upcase
$xnspre = prefix_input + ':'
puts "exp2ruby : XML prefix = " + prefix_input
puts "exp2ruby : Ruby module name = " + $modname
##
##  Set up EXPRESS XML File and new Ruby files
##
expxmlfile = File.new(exp_input, "r")
exp = Document.new(expxmlfile)
schema_element = exp.elements["//schema[1]"]
schema_name = schema_element.attributes["name"]
puts "exp2ruby : EXPRESS SCHEMA = " + schema_name.to_s
rubyfile = File.new(schema_name + ".rb", "w")
rubyfile.puts "require " + '"' + schema_name + "___module" + '"'
rubyfile.puts "require " + '"' + schema_name + "___p28inst" + '"'
rubyfile.puts "require " + '"' + schema_name + "___p28attr" + '"'
rubyfile.puts  "module " + $modname
rubymodule = File.new(schema_name + "___module.rb", "w")
##
## Set up P28 E2 instance reader code
rubyp28inst = File.new(schema_name + "___p28inst.rb", "w")
rubyp28inst.puts "def read_P28_entity_instances(p28doc,m)"
rubyp28inst.puts "  uos = p28doc.root"
rubyp28inst.puts "  for entity in uos.elements.to_a()"
rubyp28inst.puts "    id = entity.attribute('id')"
##
## Set up P28 E2 attribute reader code
rubyp28attr = File.new(schema_name + "___p28attr.rb", "w")
rubyp28attr.puts "def read_P28_attribute_values(p28doc,m)"
rubyp28attr.puts "  uos = p28doc.root"
rubyp28attr.puts "  for entity in uos.elements.to_a()"
rubyp28attr.puts "    id = entity.attribute('id')"
rubyp28attr.puts "    i = 0"
rubyp28attr.puts "    if entity.name != 'header'"
rubyp28attr.puts "      while i != -1"
rubyp28attr.puts "        tempid = m.model_elements[i].getP28id"
rubyp28attr.puts "        if tempid == id.to_s"
rubyp28attr.puts "          r = m.model_elements[i]"
rubyp28attr.puts "          i = -2"
rubyp28attr.puts "        end"
rubyp28attr.puts "        i = i + 1"
rubyp28attr.puts "      end"
rubyp28attr.puts "    end"
##
## Global arrays used to deal with supertypes
$name_array = []
$todo_array = []
##
## WRITE a Ruby module for each entity type and include each locally-defined attribute
##
stime = Time.now
ne = 0
entity_list = exp.elements.to_a("//schema/entity")
ce = entity_list.size
for entity in entity_list
  ne = ne + 1
  puts "Entity " + ne.to_s + " of " + ce.to_s + " = " + entity.attributes["name"].to_s + "  (after " + ((Time.now - stime)/60).to_s + " minutes"
  rubymodule.puts "module " + entity.attributes["name"].capitalize + "___module"
  ##
  ## write accessor (reader and writer) for each locally defined explicit attribute
  ##
  mandatory_attribute_name_list = []
  for attribute in entity.elements.to_a("./explicit")
    attr_redecl = attribute.elements["redeclaration"]
    if attr_redecl == nil
      rubymodule.puts "  attr_accessor :" + attribute.attributes["name"].downcase
      if attribute.attributes["optional"] == nil or attribute.attributes["optional"].to_s == 'NO'
        mandatory_attribute_name_list.push attribute.attributes["name"].downcase
      end
    end
  end
  if mandatory_attribute_name_list.size != 0
				rubymodule.puts '  def isValid' + entity.attributes["name"].capitalize + "___module"
				rubymodule.puts '    return case'
				for mp in mandatory_attribute_name_list
					rubymodule.puts '      when ' + mp + ' == nil : false'
				end
				rubymodule.puts '      else true'
				rubymodule.puts '      end'
				rubymodule.puts '  end'
			else
				rubymodule.puts '  def isValid' + entity.attributes["name"].capitalize + "___module"
				rubymodule.puts '    return true'
				rubymodule.puts '  end'
			end
  rubymodule.puts "end"
  ##
  ## WRITE P28 READER for each entity instance and attribute value
  write_read_P28_entity_instance_read(rubyp28inst, entity.attributes["name"])
  write_read_P28_attribute_value_read(rubyp28attr, entity.attributes["name"], exp)
  ##
  ## WRITE a Ruby class for each entity type, include module for it and each supertype
  ##
  rubyfile.puts "class " + entity.attributes["name"].capitalize
  supertypes = entity.attributes["supertypes"]
  $name_array = []
  $todo_array = []
  if supertypes != nil
    supertype_names = supertypes.split
    supertype_names.each do |super_name|
      $todo_array.push super_name
    end
  end
  get_all_supertypes(exp)
  $name_array.reverse_each do |super_name|
    rubyfile.puts "   include " + super_name.capitalize  + "___module"
  end
  rubyfile.puts "   include " + entity.attributes["name"].capitalize + "___module"
  ##
  ## write class variables containing the entity type and attribute names from the schema
  ##
  rubyfile.puts "   @@entity = " + "'" + entity.attributes["name"].capitalize + "'"
  for attribute in entity.elements.to_a("./explicit")
    attr_redecl = attribute.elements["redeclaration"]
    if attr_redecl == nil
      rubyfile.puts "   @@attr___" + attribute.attributes["name"].downcase + " = " + "'" + attribute.attributes["name"].capitalize + "'"
    end
  end
 
  ##
  ## initialize the count of the number of instances of the class for the entity type
  ## increment the count each time a new instance is created and use it to define a Part 28 E2 XML ID for the instance
  ##
  rubyfile.puts "   @@" + entity.attributes["name"].capitalize + "___count = 0"
  rubyfile.puts "   def initialize"
  rubyfile.puts "      @@" + entity.attributes["name"].capitalize + "___count += 1"
  rubyfile.puts "      @p28id = " + "'" + "id-" + entity.attributes["name"].upcase + "-" + "' + " + "@@" + entity.attributes["name"].capitalize+ "___count.to_s"
  rubyfile.puts "   end"
  ##
  ## add the method to check validity of instance
  ##
  rubyfile.puts '  def isValid'
	rubyfile.puts '    return case'
	rubyfile.puts '      when !isValid' + entity.attributes["name"].capitalize + '___module : false'						
	$name_array.reverse_each do |super_name|
	  rubyfile.puts '      when !isValid' + super_name.capitalize + '___module : false'
	end
	rubyfile.puts '      else true'
	rubyfile.puts '      end'
	rubyfile.puts '  end'
  ##
  ## add the method to write the Part 28 Edition 2 file content for the entity instance
  ##
  rubyfile.puts "   def writeP28 p28file"
  rubyfile.puts "      e___added = p28file.root.add_element(" + "\'" + $xnspre + entity.attributes["name"].capitalize + "\', " + "{\'id\' => @p28id})"
  ##
  $name_array = []
  $todo_array = []
  if supertypes != nil
    supertype_names = supertypes.split
    supertype_names.each do |super_name|
      $todo_array.push super_name
    end
  end
  get_all_supertypes(exp)
  $name_array.reverse_each do |super_name|
    xp = "//entity[@name = " + "'" + super_name + "'" + "]"
    super_entity = exp.root.elements[xp]
    for super_attribute in super_entity.elements.to_a("./explicit")
      handle_explicit(rubyfile, exp, super_attribute)
    end
  end
  
  for attribute in entity.elements.to_a("./explicit")
    handle_explicit(rubyfile, exp, attribute)
  end
  
  rubyfile.puts "   end"
  rubyfile.puts "   def getP28id"
  rubyfile.puts "      @p28id"
  rubyfile.puts "   end"
  rubyfile.puts "   def putP28id(the_id)"
  rubyfile.puts "      @p28id = the_id"
  rubyfile.puts "   end"
  rubyfile.puts "   def getP28entity"
  rubyfile.puts "      return(" + "'" + $xnspre + "'"  + " + @@entity)"
  rubyfile.puts "   end"
  rubyfile.puts "end"
end
rubyfile.puts "class Model___data"
rubyfile.puts "	attr_reader :model_elements, :model_name, :namespace, :originating_system, :preprocessor_version"
rubyfile.puts "	attr_writer :model_elements, :model_name, :namespace, :originating_system, :preprocessor_version"
rubyfile.puts " def initialize"
rubyfile.puts "   @model_elements = []"
rubyfile.puts "   @namespace = '" + $xnspre.chop + "'"
rubyfile.puts " end"
rubyfile.puts "	def readP28e2 p28doc"
rubyfile.puts "		puts 'Reading P28E2 XML'"
rubyfile.puts "		read_P28_entity_instances(p28doc,self)"
rubyfile.puts "		read_P28_attribute_values(p28doc,self)"
rubyfile.puts "	end"
rubyfile.puts "	require 'time'"
rubyfile.puts "	def writeP28e2 p28file"
rubyfile.puts "		puts 'Writing P28E2 with XML namespace = ' + namespace"
rubyfile.puts "		@p28file = p28file"
rubyfile.puts "		p28file << XMLDecl.new"
rubyfile.puts "		the_ns = 'xmlns:' + namespace"
rubyfile.puts "		the_uos = namespace + ':uos'"
rubyfile.puts "		uos = p28file.add_element(the_uos, {the_ns => 'urn:iso10303-28:schema/" + schema_name.capitalize + "'})"
rubyfile.puts "		uos.add_namespace('xsi','http://www.w3.org/2001/XMLSchema-instance')"
rubyfile.puts "		uos.add_namespace('ex','urn:iso:std:iso:10303:28:ed-2:2005:schema:common')"
rubyfile.puts "		uos.add_namespace('exp','urn:iso:std:iso:10303:28:ed-2:2005:schema:common')"
rubyfile.puts "		uos.add_attribute('xsi:schemaLocation','urn:iso10303-28:schema/" + schema_name.capitalize + " " +  schema_name.capitalize + ".xsd')"
rubyfile.puts "		header = p28file.root.add_element('exp:header')"
rubyfile.puts "		t = header.add_element('time_stamp')"
rubyfile.puts "		t.text = Time.now.xmlschema()"
rubyfile.puts "		if self.originating_system != nil"
rubyfile.puts "			t = header.add_element('preprocessor_version')"
rubyfile.puts "			t.text = self.preprocessor_version"
rubyfile.puts "		end"
rubyfile.puts "		if self.originating_system != nil"
rubyfile.puts "			t = header.add_element('originating_system')"
rubyfile.puts "			t.text = self.originating_system"
rubyfile.puts "		end"
rubyfile.puts "		i = 1"
rubyfile.puts "		for e in model_elements"
rubyfile.puts "			puts i"
rubyfile.puts "			e.writeP28(p28file)"
rubyfile.puts "			i = i + 1"
rubyfile.puts "	     end"
rubyfile.puts "   end"
rubyfile.puts "end"
rubyfile.puts "end"
rubyp28inst.puts "  end"
rubyp28inst.puts "end"
rubyp28attr.puts "  end"
rubyp28attr.puts "end"
expxmlfile.close
rubyfile.close
rubymodule.close
rubyp28inst.close
rubyp28attr.close
