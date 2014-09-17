require 'rexml/document'
require './expsm'
require 'yaml'
include REXML
include EXPSM
## reeper
## Release 0.2
## 2009-11-26
##
## MAIN PROCESS STARTS HERE
## Parse input options
##
expxml_input = " "
map_input = " "
schema_input = " "
descxml_input = " "
debug = FALSE
passedArgs = []
for arg in ARGV
	argarray = arg.split('=')
	case argarray[0]
		when "expxml" then expxml_input = argarray[1]
		when "map" then map_input = argarray[1]
		when "schema" then schema_input = argarray[1]
		when "descxml" then descxml_input = argarray[1]
		when "debug" then debug = TRUE
		when "help", "-help", "--help", "-h", "--h"
			puts "reeper Version 0.1"
			puts " "
			puts "Usage parameters : expxml=<schema.xml> (map=<mymap.rb>) (schema=<name>) (descxml=<desc.xml>)"
			puts " "
			puts "  <schema.xml> required input EXPRESS as XML file"
			puts "  <mymap.rb> optional input mapping as Ruby file, default is filename ''mapping.rb''"
			puts "  <name> optional EXPRESS schema to map, default is all schemas in XML file"
			puts "  <desc.xml> optional input descriptions as XML file (may be same as expxml)"
			exit
		else
			passedArgs.push arg
	end
end
if expxml_input == " "
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : No EXPRESS as XML input"
	puts "Usage parameters : expxml=<schema.xml> map=<mapping.rb> (schema=<name>) (descxml=<desc.xml>)"
	exit
end
if FileTest.exist?(expxml_input) != true
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : EXPRESS as XML input file not found : #{expxml_input}"
	exit
end
if map_input == " " and FileTest.exist?('mapping.rb') != true
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : No Ruby Mapping File as input, default 'mapping.rb' not found"
	puts "Usage parameters : expxml=<schema.xml> (map=<mymap.rb>) (schema=<name>) (descxml=<desc.xml>)"
	exit
end
if map_input != " " and FileTest.exist?(map_input) != true
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : Ruby Mapping input file not found : #{map_input}"
	exit
end
if descxml_input != " " and FileTest.exist?(descxml_input) != true
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : Descriptions input file not found : #{descxml_input}"
	exit
end
##
##  Set up EXPRESS XML File and new output files
##
stime = Time.now.to_i
expxmlfile = File.new(expxml_input, "r")
exp = REXML::Document.new(expxmlfile)
schemaname_list = []

XPath.each( exp, '//express/schema/@name' ) { |n| schemaname_list.push n.to_s }

if schema_input != " " and !schemaname_list.include?(schema_input)
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : File contains no schema named :  #{schema_input}"
	expxmlfile.close
	exit
end

schema_list = exp.elements.to_a("//express/schema")
if schema_list.size == 0
	puts "reeper Version 0.1"
	puts " "
	puts "ERROR : File contains no 'schema' XML elements :  #{expxml_input}, may not be EXPRESS as XML"
	expxmlfile.close
	exit
end

puts "reeper : Creating EXPRESS Dictionary"
therepos = load_dictionary_express( exp, expxml_input )
expxmlfile.close

if descxml_input != " "
	descxmlfile = File.new(descxml_input, "r")
	descxml = REXML::Document.new(descxmlfile)
	load_descriptions( descxml, therepos )
	descxmlfile.close
end

if debug == TRUE
	debug_file = File.new("debug.txt", "w")
	debug_file.puts YAML.dump( therepos )
	debug_file.close
end
##
## include the Ruby mapping code
if map_input != " "
	require map_input
	puts "reeper : Using input mapping file #{map_input}"
else
	require 'mapping.rb'
	puts "reeper : Using default mapping file 'mapping.rb'"
end
##
## call the mapping code passing either the repository or a single schema as input

if schema_input != " "
	mapthing = therepos.schemas.detect { |s| s.name == schema_input }
else
	mapthing = therepos
end

map_from_express(mapthing, passedArgs)
