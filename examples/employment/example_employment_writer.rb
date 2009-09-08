require 'employment_schema'
require 'rexml/document'
include REXML
include EMP
##
## create a model container for the data instances
##
mydata = EMP::Model___data.new
mydata.model_elements = []
##
## create an organization
##

org1 = EMP::Organization.new
org1.name = 'Acme Plumbing'

##
## put instance in the model container, this is what gets written to XML
##

mydata.model_elements.push org1

##
## Set up the XML file and write all data in the model container to the file
##
datafile = File.new("example_employment_data.xml","w")
p28file = REXML::Document.new
mydata.writeP28e2 p28file
datafile.puts p28file
datafile.close
