require "employment_schema___module"
require "employment_schema___p28inst"
require "employment_schema___p28attr"
module EMP
class Person
   include Person___module
   @@entity = 'Person'
   @@attr___names = 'Names'
   @@Person___count = 0
   def initialize
      @@Person___count += 1
      @p28id = 'id-PERSON-' + @@Person___count.to_s
   end
  def isValid
    return case
      when !isValidPerson___module : false
      else true
      end
  end
   def writeP28 p28file
      e___added = p28file.root.add_element('emp:Person', {'id' => @p28id})
      if names != nil
         a___names = e___added.add_element('Names')
         for names___member in names
            amember___names = a___names.add_element('ex:string-wrapper')
            amember___names.text = names___member
         end
      end
   end
   def getP28id
      @p28id
   end
   def putP28id(the_id)
      @p28id = the_id
   end
   def getP28entity
      return('emp:' + @@entity)
   end
end
class Organization
   include Organization___module
   @@entity = 'Organization'
   @@attr___name = 'Name'
   @@Organization___count = 0
   def initialize
      @@Organization___count += 1
      @p28id = 'id-ORGANIZATION-' + @@Organization___count.to_s
   end
  def isValid
    return case
      when !isValidOrganization___module : false
      else true
      end
  end
   def writeP28 p28file
      e___added = p28file.root.add_element('emp:Organization', {'id' => @p28id})
      if name != nil
         a___name = e___added.add_element('Name')
         a___name.text = name
      end
   end
   def getP28id
      @p28id
   end
   def putP28id(the_id)
      @p28id = the_id
   end
   def getP28entity
      return('emp:' + @@entity)
   end
end
class Personorganizationrelationship
   include Personorganizationrelationship___module
   @@entity = 'Personorganizationrelationship'
   @@attr___the_person = 'The_person'
   @@attr___the_organization = 'The_organization'
   @@attr___start_date = 'Start_date'
   @@attr___end_date = 'End_date'
   @@Personorganizationrelationship___count = 0
   def initialize
      @@Personorganizationrelationship___count += 1
      @p28id = 'id-PERSONORGANIZATIONRELATIONSHIP-' + @@Personorganizationrelationship___count.to_s
   end
  def isValid
    return case
      when !isValidPersonorganizationrelationship___module : false
      else true
      end
  end
   def writeP28 p28file
      e___added = p28file.root.add_element('emp:Personorganizationrelationship', {'id' => @p28id})
      if the_person != nil
         a___the_person = e___added.add_element('The_person')
         a___the_person = a___the_person.add_element(the_person.getP28entity)
         a___the_person.attributes['ref'] = the_person.getP28id
         a___the_person.attributes['xsi:nil'] = 'true'
      end
      if the_organization != nil
         a___the_organization = e___added.add_element('The_organization')
         a___the_organization = a___the_organization.add_element(the_organization.getP28entity)
         a___the_organization.attributes['ref'] = the_organization.getP28id
         a___the_organization.attributes['xsi:nil'] = 'true'
      end
      if start_date != nil
         a___start_date = e___added.add_element('Start_date')
         a___start_date.text = start_date
      end
      if end_date != nil
         a___end_date = e___added.add_element('End_date')
         a___end_date.text = end_date
      end
   end
   def getP28id
      @p28id
   end
   def putP28id(the_id)
      @p28id = the_id
   end
   def getP28entity
      return('emp:' + @@entity)
   end
end
class Employment
   include Personorganizationrelationship___module
   include Employment___module
   @@entity = 'Employment'
   @@attr___job_title = 'Job_title'
   @@Employment___count = 0
   def initialize
      @@Employment___count += 1
      @p28id = 'id-EMPLOYMENT-' + @@Employment___count.to_s
   end
  def isValid
    return case
      when !isValidEmployment___module : false
      when !isValidPersonorganizationrelationship___module : false
      else true
      end
  end
   def writeP28 p28file
      e___added = p28file.root.add_element('emp:Employment', {'id' => @p28id})
      if the_person != nil
         a___the_person = e___added.add_element('The_person')
         a___the_person = a___the_person.add_element(the_person.getP28entity)
         a___the_person.attributes['ref'] = the_person.getP28id
         a___the_person.attributes['xsi:nil'] = 'true'
      end
      if the_organization != nil
         a___the_organization = e___added.add_element('The_organization')
         a___the_organization = a___the_organization.add_element(the_organization.getP28entity)
         a___the_organization.attributes['ref'] = the_organization.getP28id
         a___the_organization.attributes['xsi:nil'] = 'true'
      end
      if start_date != nil
         a___start_date = e___added.add_element('Start_date')
         a___start_date.text = start_date
      end
      if end_date != nil
         a___end_date = e___added.add_element('End_date')
         a___end_date.text = end_date
      end
      if job_title != nil
         a___job_title = e___added.add_element('Job_title')
         a___job_title.text = job_title
      end
   end
   def getP28id
      @p28id
   end
   def putP28id(the_id)
      @p28id = the_id
   end
   def getP28entity
      return('emp:' + @@entity)
   end
end
class Model___data
	attr_reader :model_elements, :model_name, :namespace, :originating_system, :preprocessor_version
	attr_writer :model_elements, :model_name, :namespace, :originating_system, :preprocessor_version
 def initialize
   @model_elements = []
   @namespace = 'emp'
 end
	def readP28e2 p28doc
		puts 'Reading P28E2 XML'
		read_P28_entity_instances(p28doc,self)
		read_P28_attribute_values(p28doc,self)
	end
	require 'time'
	def writeP28e2 p28file
		puts 'Writing P28E2 with XML namespace = ' + namespace
		@p28file = p28file
		p28file << XMLDecl.new
		the_ns = 'xmlns:' + namespace
		the_uos = namespace + ':uos'
		uos = p28file.add_element(the_uos, {the_ns => 'urn:iso10303-28:schema/Employment_schema'})
		uos.add_namespace('xsi','http://www.w3.org/2001/XMLSchema-instance')
		uos.add_namespace('ex','urn:iso:std:iso:10303:28:ed-2:2005:schema:common')
		uos.add_namespace('exp','urn:iso:std:iso:10303:28:ed-2:2005:schema:common')
		uos.add_attribute('xsi:schemaLocation','urn:iso10303-28:schema/Employment_schema Employment_schema.xsd')
		header = p28file.root.add_element('exp:header')
		t = header.add_element('time_stamp')
		t.text = Time.now.xmlschema()
		if self.originating_system != nil
			t = header.add_element('preprocessor_version')
			t.text = self.preprocessor_version
		end
		if self.originating_system != nil
			t = header.add_element('originating_system')
			t.text = self.originating_system
		end
		i = 1
		for e in model_elements
			puts i
			e.writeP28(p28file)
			i = i + 1
	     end
   end
end
end
