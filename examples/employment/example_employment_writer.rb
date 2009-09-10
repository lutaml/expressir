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
##
## check that all mandatory attrs are set
##
puts 'Without name, org1 isValid = ' + org1.isValid.to_s
org1.name = 'Acme Plumbing'
##
## check again that all mandatory attrs are set
##
puts 'With name, org1 isValid = ' + org1.isValid.to_s

per1 = EMP::Person.new
per1.names = []
per1.names.push 'Joe'
per1.names.push 'Plumber'

emp1 = EMP::Employment.new
emp1.the_person = per1
emp1.the_organization = org1
emp1.start_date = '2008-04-01'
emp1.end_date = '2008-06-01'
emp1.job_title = 'Apprentice'
emp1.ended_by = per1
emp1.employment_type = 'atwill'

##
## put all instances in the model container, this is what gets written to XML
##
mydata.model_elements.push org1
mydata.model_elements.push emp1
mydata.model_elements.push per1
##
## Set up the XML file and write all data in the model container to the file
##
datafile = File.new("example_employment_data.xml","w")
p28file = REXML::Document.new
mydata.writeP28e2 p28file
datafile.puts p28file
datafile.close
