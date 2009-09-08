require 'employment_schema'
require 'rexml/document'
include REXML
include EMP
$xnspre = "emp"
##
infile = File.new("example_employment_data.xml","r")
doc = REXML::Document.new infile
## create a model container for the data instances
m = EMP::Model___data.new
##
## Set the XML Namespace for the P28 E2 file
m.namespace = $xnspre
## Give model a name if you want
m.model_name = "Test dataset 1"
m.model_elements = []
m.readP28e2(doc)
if m.model_elements.size != 0
	puts "Copied " + m.model_elements.size.to_s
	for e in m.model_elements
		puts "p28id = " + e.getP28id.to_s
	end
##
## Set up the XML file and write all data in the model container to the file
	datafile = File.new("example_employment_data_copy.xml","w")
	p28file = REXML::Document.new
	m.writeP28e2 p28file
	datafile.puts p28file
	datafile.close
end
