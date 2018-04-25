## EXPRESS STEPMod Model Ruby Classes
## Version 0.1
##
## The Ruby classes in the model are based on the STEPMod DTD.
module EXPSM
class Comment
	attr_accessor :comment, :ModelElement
end
class ModelElement
	attr_accessor :definition
end
class Remark < Comment
end
class Repository
	attr_accessor :name, :schemas
	@@next_integer_id = 0
	def initialize
		@schemas = []
	end
	def get_next_integer()
		@@next_integer_id += 1
		return @@next_integer_id
	end
	def get_xmlid(thing)
		if !thing.class.name.include? "::"
			return  "id-" + thing.class.name + "-" + get_next_integer().to_s  
		else
			thing_type = thing.class.name.split("::")
			return xmlid = "id-" + thing_type[1] + "-" + get_next_integer().to_s
		end
	end
	def find_namedtype_by_name( typename )
		foundtype = nil
		while foundtype == nil
			for schema in schemas
				foundtype = schema.find_namedtype_by_name( typename )
				break if foundtype != nil
			end
		end
		return foundtype
	end
end
class SchemaDefinition < ModelElement
	attr_accessor :contents, :name, :identification, :all_schema_array
	def initialize
		@all_schema_array = []
	end
	def find_namedtype_by_name( typename )
		
		## search current schema and interfaced item aliases
		nt = contents.detect { |t| t.kind_of? EXPSM::NamedType and t.name == typename }
		if nt != nil
			return nt
		end

		for schema in self.all_schema_array
			## search all interfaced schemas
			nt = schema.contents.detect { |t| t.kind_of? EXPSM::NamedType and t.name == typename }
			if nt != nil
				return nt
			end
		
		end
		puts "*** NOT HERE " + typename + " IN " + self.name
		puts "*** SEARCHED " + all_schema_array.size.to_s + " SCHEMAS:"
		for schema in self.all_schema_array
			puts "  - " + schema.name
		end
		return nil
	end
end
class NamedType < ModelElement
	attr_accessor :name, :schema, :wheres, :selectedBy
  def self.find_by_name(name)
    found = nil
    ObjectSpace.each_object(NamedType) { |o|
      found = o if o.name == name
    }
    found
  end

end
class Entity < NamedType
	attr_accessor :supertypes, :attributes, :isAbs, :superexpression, :uniques, :subtypes_array, :supertypes_array, :attributes_all_array, :supertypes_all
	def initialize
		@isAbs = false
		@attributes = []
		@uniques = []
		@wheres = []
		@subtypes_array = []
		@supertypes_array = []
		@attributes_all_array = []
		@supertypes = nil
		@supertypes_all = nil
		@superexpression = nil
		@selectedBy = []
	end
	def find_attr_by_name( attrname )
		for attribute in attributes
			if attrname == attribute.name
				return attribute
			end
		end
		return nil
	end
	def find_attr_by_name_full( attrname )
		attr = find_attr_by_name( attrname )
		if attr != nil
			return attr
		end
		for supertype in supertypes_array
			attr = supertype.find_attr_by_name_full (attrname)
			if attr != nil
				return attr
			end
		end
	end	
end
class Attribute < ModelElement
	attr_accessor :name, :entity, :domain, :redeclare_entity, :redeclare_oldname
	def initialize
		@redeclare_entity = nil
		@redeclare_oldname = nil
	end
end
class ExplicitOrDerived < Attribute
		attr_accessor :isBuiltin, :isFixed, :width, :precision
	def initialize
		@isBuiltin = false
		@isFixed = false
		@width = nil
		@precision = nil
	end		
end
class Explicit < ExplicitOrDerived
	attr_accessor :isOptional
	def initialize
		@isOptional = false
	end
end
class ExplicitAggregate < Explicit
	attr_accessor :rank, :dimensions
	def initialize
		@rank = 0
		@dimensions = []
		@isOptional = false
	end
end
class AggregateDimension
	attr_accessor :aggrtype, :lower, :upper, :isUnique, :isOptionalArray
	def initialize
		@aggrtype = "SET"
		@lower = "0"
		@upper = "?"
		@isUnique = false
		@isOptionalArray = false
	end
end
class Derived < ExplicitOrDerived
	attr_accessor :expression
end
class DerivedAggregate < Derived
	attr_accessor  :rank, :dimensions
	def initialize
		@rank = 0
		@dimensions = []
	end
end
class Inverse < Attribute
	attr_accessor :reverseAttr_id, :reverseAttr, :reverseEntity
end
class DefinedType < NamedType
end
class InverseAggregate < Inverse
	attr_accessor :aggrtype, :lower, :upper
	def initialize
		@aggrtype = "SET"
		@lower = "0"
		@upper = "?"
end

	end
class Type < DefinedType
	attr_accessor :isBuiltin, :domain, :isFixed, :width, :precision
	def initialize
		@isBuiltin = false
		@isFixed = false
		@width = nil
		@precision = nil
		@wheres = []
		@selectedBy = []
	end
end
class TypeAggregate < Type
	attr_accessor :rank, :dimensions
	def initialize
		@rank = 0
		@dimensions = []
		@wheres = []
		@selectedBy = []
	end
end
class TypeSelect < DefinedType
	attr_accessor :selectitems_array, :selectitems, :extends, :extends_item, :isExtensible, :selectitems_all, :isGenericEntity, :isBuiltin, :cleaned_select_items
	def initialize
		@isBuiltin = false
		@isExtensible = false
		@isGenericEntity = false
		@selectitems = nil
		@selectitems_array = []
		@cleaned_select_items = nil
		@wheres = []
		@selectedBy = []
	end
##
## set cleaned_select_items = process select removing unnecessary entity types (i.e. if supertype is there)
	def clean_select_items
		@cleaned_select_items = ''
		if selectitems != nil
			itemname_list = selectitems.scan(/\w+/)
			dupitem_list = []
			for itemname in itemname_list
				itemptr = schema.find_namedtype_by_name( itemname )
				if itemptr.kind_of? EXPSM::Entity
					for itemname2 in itemname_list
						thetype = schema.find_namedtype_by_name( itemname2 )
						if thetype != nil
							if itemptr.supertypes_all != nil and itemptr.supertypes_all.include? thetype.name
								dupitem_list.push itemname
							end
						end
					end
				end
			end
			for itemname in itemname_list
				if !dupitem_list.include? itemname
					@cleaned_select_items = @cleaned_select_items + ' ' + itemname
				end
			end
			@cleaned_select_items = @cleaned_select_items.lstrip
		end
	end
end
class TypeEnum < DefinedType
	attr_accessor :items_array, :items, :extends, :extends_item, :isExtensible, :allitems, :isBuiltin
	def initialize
		@isBuiltin = false
		@selectedBy = []
	end
end
class InterfaceSpecification < ModelElement
	attr_accessor :kind, :current_schema, :explicit_items, :current_schema_id, :foreign_schema_id, :foreign_schema
	def initialize
		@explicit_items = []
	end
end
class InterfacedItem
	attr_accessor :name, :original_name, :foreign_schema, :foreign_type
	def initialize
		@original_name = nil
	end
end
class WhereRule < ModelElement
	attr_accessor :name, :expression
	def initialize
		@name = nil
	end
end
class UniqueRule < ModelElement
	attr_accessor :name, :attributes
	def initialize
		@name = nil
		@attributes = []
	end
end
class SubtypeConstraint < ModelElement
	attr_accessor :name, :entity, :isAbs, :totalover, :expression
	def initialize
		@isAbs = false
		@totalover = nil
	end	
end
class GlobalRule < ModelElement
		attr_accessor :name, :entities, :algorithm, :wheres, :schema, :entities_array
	def initialize
		@entities_array = []
		@wheres = []
	end	
end
end
##
## Function : load dictionary with Schema declarations
def load_dictionary_express_schemas(schemaxml_list, repos)
	for schemaxml in schemaxml_list
		snew = EXPSM::SchemaDefinition.new
		repos.schemas.push snew
		snew.name = schemaxml.attributes["name"]
		snew.contents = []
	end
end
##
## Function : load dictionary with Use and Reference
def load_dictionary_express_interface(schemaxml, repos)
	schema_name = schemaxml.attributes["name"]
	for this_schema in repos.schemas
		if schema_name == this_schema.name
			current_schema = this_schema
		end
	end
	interfacexml_list = schemaxml.elements.to_a("interface")
	puts "-- Interface count is " + interfacexml_list.size.to_s
	for interfacexml in interfacexml_list	
		ispec = EXPSM::InterfaceSpecification.new
		current_schema.contents.push ispec
		ispec.foreign_schema_id = interfacexml.attributes["schema"].to_s
		
		for this_schema in repos.schemas
			if ispec.foreign_schema_id == this_schema.name
				ispec.foreign_schema = this_schema
			end
		end

		ispec.current_schema_id = schema_name
		ispec.current_schema = current_schema
#		current_schema.contents.push ispec
		ispec.kind = interfacexml.attributes["kind"].to_s
		
		itemxml_list = interfacexml.elements.to_a("interfaced.item")
		ispec.explicit_items = []
		for iitemxml in itemxml_list
			iinew = EXPSM::InterfacedItem.new
			ispec.explicit_items.push iinew
			if iitemxml.attributes["alias"] != nil
				iinew.name = iitemxml.attributes["alias"].to_s
				iinew.original_name = iitemxml.attributes["name"].to_s
			else
				iinew.name = iitemxml.attributes["name"].to_s
			end
			iinew.foreign_schema = ispec.foreign_schema 
		end
	end
end
##
## Function : process EXPRESS aggregates
def load_dictionary_express_aggregate(elementxml, expnew)
	if elementxml.elements["aggregate"] != nil
		aggrxml_list = elementxml.elements.to_a("aggregate")
		expnew.rank = aggrxml_list.size
		for aggrxml in aggrxml_list
			dimnew = EXPSM::AggregateDimension.new
			expnew.dimensions.push dimnew
			if aggrxml.attributes["type"] != nil
				dimnew.aggrtype = aggrxml.attributes["type"]
			end
			if aggrxml.attributes["lower"] != nil
				dimnew.lower = aggrxml.attributes["lower"]
			end
			if aggrxml.attributes["upper"] != nil
				dimnew.upper = aggrxml.attributes["upper"]
			end
			if aggrxml.attributes["optional"] != nil
				if aggrxml.attributes["optional"] == "YES"
					dimnew.isOptionalArray = true
				end
			end
			if aggrxml.attributes["unique"] != nil
				if aggrxml.attributes["unique"] == "YES"
					dimnew.isUnique = true
				end
			end
		end
	end
	##
	## Handle INVERSE Aggregates which are never nested and only BAG/SET
	if elementxml.elements["inverse.aggregate"] != nil
		if elementxml.elements["inverse.aggregate"].attributes["type"] != nil
			expnew.aggrtype = elementxml.elements["inverse.aggregate"].attributes["type"]
		end
		if elementxml.elements["inverse.aggregate"].attributes["lower"] != nil
			expnew.lower = elementxml.elements["inverse.aggregate"].attributes["lower"]
		end
		if elementxml.elements["inverse.aggregate"].attributes["upper"] != nil
			expnew.upper = elementxml.elements["inverse.aggregate"].attributes["upper"]
		end
	end
end
##
## Function : process EXPRESS builtin types
def load_dictionary_express_builtintype(elementxml, expnew)
	if elementxml.elements["builtintype"] != nil
		expnew.domain = elementxml.elements["builtintype"].attributes["type"].to_s
		expnew.isBuiltin = true
		if elementxml.elements["builtintype"].attributes["width"] != nil
			expnew.width = elementxml.elements["builtintype"].attributes["width"].to_s
		end
		if elementxml.elements["builtintype"].attributes["precision"] != nil
			expnew.precision = elementxml.elements["builtintype"].attributes["precision"].to_s
		end
		if elementxml.elements["builtintype"].attributes["fixed"] != nil
			if elementxml.elements["builtintype"].attributes["fixed"] = "YES"
				expnew.isFixed = true
			end
		end
	end 
end
##
## Function : load dictionary with EXPRESS Entity Types
def load_dictionary_express_entity(schemaxml, repos)
	
	schema_name = schemaxml.attributes["name"]
	for temp in repos.schemas
		if schema_name == temp.name
			the_schema = temp
		end
	end
	
	entityxml_list = schemaxml.elements.to_a("entity")
	puts "-- Entity count is " + entityxml_list.size.to_s
	for entityxml in entityxml_list
		entnew = EXPSM::Entity.new
		entnew.name = entityxml.attributes["name"].to_s
		entnew.schema = the_schema
		the_schema.contents.push entnew
		if entityxml.attributes["super.expression"] != nil
			entnew.superexpression = entityxml.attributes["super.expression"]
		end
		if entityxml.attributes["supertypes"] != nil
			entnew.supertypes = entityxml.attributes["supertypes"]
		end
		if entityxml.attributes["abstract.entity"] != nil
			if entityxml.attributes["abstract.entity"] == "YES"
				entnew.isAbs = true
			end
		end
		if entityxml.attributes["abstract.supertype"] != nil
			if entityxml.attributes["abstract.supertype"] == "YES"
				entnew.isAbs = true
			end
		end
##
## Handle explicit attributes
		if entityxml.elements["explicit"] != nil
			explicitxml_list = entityxml.elements.to_a("explicit")
			for explicitxml in explicitxml_list
				if explicitxml.elements["aggregate"] != nil
					attnew = EXPSM::ExplicitAggregate.new
					load_dictionary_express_aggregate(explicitxml, attnew)		 
				else
					attnew = EXPSM::Explicit.new
				end
			
				attnew.name = explicitxml.attributes["name"].to_s
				entnew.attributes.push attnew
				attnew.entity = entnew

				if explicitxml.attributes["optional"] != nil
					if explicitxml.attributes["optional"].to_s == "YES"
						attnew.isOptional = true
					end
				end

				if explicitxml.elements["builtintype"] != nil
					load_dictionary_express_builtintype(explicitxml, attnew)
				end

				if explicitxml.elements["typename"] != nil
					attnew.domain = explicitxml.elements["typename"].attributes["name"].to_s
				end

				if explicitxml.elements["redeclaration"] != nil
					attnew.redeclare_entity = explicitxml.elements["redeclaration"].attributes["entity-ref"].to_s
					if explicitxml.elements["redeclaration"].attributes["old_name"] != nil
						attnew.redeclare_oldname = explicitxml.elements["redeclaration"].attributes["old_name"].to_s
					end
				end
			end
		end
		##
		## Handle inverse attributes
		if entityxml.elements["inverse"] != nil
			inversexml_list = entityxml.elements.to_a("inverse")
			for inversexml in inversexml_list
				if inversexml.elements["inverse.aggregate"] != nil
					attnew = EXPSM::InverseAggregate.new
					load_dictionary_express_aggregate(inversexml, attnew)
				else
					attnew = EXPSM::Inverse.new
				end
				attnew.reverseAttr_id = inversexml.attributes["attribute"]
				attnew.name = inversexml.attributes["name"].to_s
				entnew.attributes.push attnew
				attnew.entity = entnew
				if inversexml.attributes["entity"] != nil
					attnew.domain = inversexml.attributes["entity"].to_s
				end	
				if inversexml.elements["redeclaration"] != nil
					attnew.redeclare_entity = inversexml.elements["redeclaration"].attributes["entity-ref"].to_s
					if inversexml.elements["redeclaration"].attributes["old_name"] != nil
						attnew.redeclare_oldname = inversexml.elements["redeclaration"].attributes["old_name"].to_s
					end
				end
			end
		end
		##
		## Handle derived attributes
		if entityxml.elements["derived"] != nil
			derivedxml_list = entityxml.elements.to_a("derived")
			for derivedxml in derivedxml_list
				if derivedxml.elements["aggregate"] != nil
					attnew = EXPSM::DerivedAggregate.new
					load_dictionary_express_aggregate(derivedxml, attnew)
				else
					attnew = EXPSM::Derived.new
				end

				attnew.name = derivedxml.attributes["name"].to_s
				attnew.expression = derivedxml.attributes["expression"].to_s
				entnew.attributes.push attnew

				if derivedxml.elements["builtintype"] != nil
					load_dictionary_express_builtintype(derivedxml, attnew)
				end

				if derivedxml.elements["typename"] != nil
					attnew.domain = derivedxml.elements["typename"].attributes["name"].to_s
				end

				if derivedxml.elements["redeclaration"] != nil
					attnew.redeclare_entity = derivedxml.elements["redeclaration"].attributes["entity-ref"].to_s
					if derivedxml.elements["redeclaration"].attributes["old_name"] != nil
						attnew.redeclare_oldname = derivedxml.elements["redeclaration"].attributes["old_name"].to_s
					end
				end
			end
		end
    
    ## Process unique rules
		if entityxml.elements["unique"] != nil
			uniquexml_list = entityxml.elements.to_a("unique")
			for uniquexml in uniquexml_list
        uniquenew = EXPSM::UniqueRule.new
        if uniquexml.attributes["label"] != nil
          uniquenew.name = uniquexml.attributes["label"]
        end
        attrxml_list = uniquexml.elements.to_a("unique.attribute")
        for attrxml in attrxml_list
          aname = attrxml.attributes["attribute"]
          if uniquexml.attributes["entity-ref"] != nil
            puts "ENTITY-REF found in UNIQUE RULE: " + entnew.name
          end          
          uniquenew.attributes.push aname
        end
				entnew.uniques.push uniquenew
			end
		end
		
		## Process where rules
		if entityxml.elements["where"] != nil
			wherexml_list = entityxml.elements.to_a("where")
			for wherexml in wherexml_list
				wherenew = process_where_rulexml( wherexml )
				entnew.wheres.push wherenew
			end
		end

	end
end
##
## Function : load dictionary with EXPRESS Defined Types
def load_dictionary_express_type(schemaxml, repos)

	schema_name = schemaxml.attributes["name"]
	for temp in repos.schemas
		if schema_name == temp.name
			the_schema = temp
		end
	end
	
	## Process EXPRESS Type declarations
	typexml_list = schemaxml.elements.to_a("type")
	puts "-- Type count is " + typexml_list.size.to_s
	for typexml in typexml_list	
	 	##
 		## Process TYPE = SELECT
	 	if typexml.elements["select"] != nil
 			tnew = EXPSM::TypeSelect.new
			if typexml.elements["select"].attributes["selectitems"] != nil
				tnew.selectitems = typexml.elements["select"].attributes["selectitems"]
			end
			if typexml.elements["select"].attributes["genericentity"] != nil
				if typexml.elements["select"].attributes["genericentity"] == "YES"
					tnew.isGenericEntity = true
				end
			end
			if typexml.elements["select"].attributes["extensible"] != nil
				if typexml.elements["select"].attributes["extensible"] == "YES"
					tnew.isExtensible = true
				end
			end
			if typexml.elements["select"].attributes["basedon"] != nil
				tnew.extends = typexml.elements["select"].attributes["basedon"]
			end
			if tnew.isExtensible == false
				tnew.selectitems_all = tnew.selectitems
			end
		end
		##
		## Process Type = Enumeration Of
		if typexml.elements["enumeration"] != nil
			tnew = EXPSM::TypeEnum.new
			tnew.items = typexml.elements["enumeration"].attributes["items"]
			tnew.items_array = tnew.items.scan(/\w+/)
		end
		##
		## Process Type = anything other than SELECT and Enumeration		
		if typexml.elements["select"] == nil and typexml.elements["enumeration"] == nil
			if typexml.elements["aggregate"] != nil
				tnew = EXPSM::TypeAggregate.new
				load_dictionary_express_aggregate(typexml, tnew)	
			end
			if typexml.elements["aggregate"] == nil
				tnew = EXPSM::Type.new
			end
			if typexml.elements["builtintype"] != nil
				load_dictionary_express_builtintype(typexml, tnew)
			end
			if typexml.elements["typename"] != nil
				tnew.domain = typexml.elements["typename"].attributes["name"]
			end
		end

		tnew.name = typexml.attributes["name"].to_s
		tnew.schema = the_schema
		the_schema.contents.push tnew
		
		## Process where rules
		if typexml.elements["where"] != nil
			wherexml_list = typexml.elements.to_a("where")
			for wherexml in wherexml_list
				wherenew = process_where_rulexml( wherexml )
				tnew.wheres.push wherenew
			end
		end
	end
end

##
## Function : post-process dictionary completing its population
def postprocess_dictionary_express(repos)
	puts "-- Post processing dictionary for " + repos.name.to_s
	for schema in repos.schemas
		##
		## Add pointer to all interfaced schemas
		schema_list = []
		schema.all_schema_array = get_all_interfaced_schemas( schema, schema_list)
		
		for decl in schema.contents

			##
			## Add pointer to the named type in interfaced item.foreign_type
			if decl.kind_of? EXPSM::InterfaceSpecification
				for item in decl.explicit_items
					name_to_find = item.name
					if item.original_name != nil
						name_to_find = item.original_name
					end
					thetype = decl.foreign_schema.find_namedtype_by_name( name_to_find )
					if thetype != nil
						item.foreign_type =  thetype
					end
				end
			end

			##
			## Add pointers to SELECT type select items in selectitems_array
			if decl.kind_of? EXPSM::TypeSelect
				if decl.extends != nil
					decl.extends_item = schema.find_namedtype_by_name( decl.extends )
				end
				if decl.selectitems != nil
					select_temp = decl.selectitems.scan(/\w+/)
					for name in select_temp
						thetype = schema.find_namedtype_by_name( name.to_s )
						if thetype != nil
							decl.selectitems_array.push thetype
							thetype.selectedBy.push decl
						else
							puts "ERROR : SELECT Item Not Found : " + name
						end
					end
				end
			end
			
			## Add entities list as an array of pointers to Global Rule
			if decl.kind_of? EXPSM::GlobalRule
				ent_temp = decl.entities.scan(/\w+/)
				for name in ent_temp
					thetype = schema.find_namedtype_by_name( name.to_s )
					if thetype != nil
						decl.entities_array.push thetype
					else
						puts "ERROR : Rule Entity Not Found : " + name
					end
				end
			end


			##
			## Sort entities
			if decl.kind_of? EXPSM::Entity
			##
			## Add pointers to supertypes
				if decl.supertypes != nil
					supername_array = decl.supertypes.scan(/\w+/)
					for supername in supername_array
						thetype = schema.find_namedtype_by_name( supername )
						if thetype != nil
							decl.supertypes_array.push thetype
						else
							puts "ERROR : SUPERTYPE Item Not Found : " + supername
						end
					end
				end
			##
			## Add all supertypes to supertypes_all
				if decl.supertypes != nil
					decl.supertypes_all = get_all_supertypes( decl, '')
				end
			##
			## Add all explicit attributes to attributes_all_array
				if decl.supertypes_all != nil
					all_supername_array = decl.supertypes_all.scan(/\w+/)
					for supername in all_supername_array
						supertype = schema.find_namedtype_by_name( supername )
						for superattr in supertype.attributes
							decl.attributes_all_array.push superattr
						end
					end
				end
				for localattr in decl.attributes
					decl.attributes_all_array.push localattr
				end
				attributes_to_remove = []
				for nextattribute in decl.attributes_all_array
					the_attr = nil
					if nextattribute.redeclare_entity != nil
						the_entity = schema.find_namedtype_by_name( nextattribute.redeclare_entity )
						redattr_name = nextattribute.name
						if nextattribute.redeclare_oldname != nil
							redattr_name = nextattribute.redeclare_oldname
						end
						the_attr = the_entity.find_attr_by_name( redattr_name )
						attributes_to_remove.push the_attr
					end					
				end
				for attribute_remove in attributes_to_remove
						decl.attributes_all_array.delete( attribute_remove )
				end
			##
			## Add pointers to subtypes
				subarray = schema.contents.find_all { |e| e.kind_of? EXPSM::Entity and e.supertypes != nil}
				for subptr in subarray
					subname_array = subptr.supertypes.scan(/\w+/)
					if subname_array.include?(decl.name)
						decl.subtypes_array.push subptr
					end
				end

			end
			
		end
		
		for decl in schema.contents
			##
			## Add pointer to reverse entity and attribute in inverses
			if decl.kind_of? EXPSM::Entity
				for attr in decl.attributes
					if attr.kind_of? EXPSM::Inverse
						attr_to_find = attr.reverseAttr_id
						attr.reverseEntity = schema.find_namedtype_by_name( attr.domain )
						attr.reverseAttr = attr.reverseEntity.find_attr_by_name_full( attr_to_find )
					end
				end
			end
		end
	end
	puts "-- Post processing complete"
end
##
## process supertypes in the schema
def get_all_supertypes( decl, superlist)
	if decl.supertypes != nil
		superlist = decl.supertypes + ' ' + superlist
		for sup in decl.supertypes_array
			 superlist = get_all_supertypes( sup, superlist)
		end
	end
	return superlist.lstrip
end
##
## process all interfaced schemas
def get_all_interfaced_schemas( schema, schema_list)
	ispec_list = schema.contents.find_all{ |i| i.kind_of? EXPSM::InterfaceSpecification}
	if ispec_list != nil
		for ispec in ispec_list
			if !(schema_list.include? ispec.foreign_schema)
				schema_list.push ispec.foreign_schema
			end
			get_all_interfaced_schemas( ispec.foreign_schema, schema_list)
		end
	end
	return schema_list
end

##
## process rules in the schema
def load_dictionary_express_rule( schemaxml, repos)
	
	schema_name = schemaxml.attributes["name"]
	for temp in repos.schemas
		if schema_name == temp.name
			the_schema = temp
		end
	end

## Process global rules
	rulexml_list = schemaxml.elements.to_a("rule")
	puts "-- Rule count is " + rulexml_list.size.to_s
	for rulexml in rulexml_list
		rulenew = EXPSM::GlobalRule.new
		rulenew.name = rulexml.attributes["name"].to_s
		rulenew.entities = rulexml.attributes["appliesto"].to_s
		# set entity array in post processor
		rulenew.schema = the_schema
		the_schema.contents.push rulenew
		if rulexml.attributes["algorithm"] != nil
			rulenew.algorithm = rulexml.attributes["algorithm"]
		end
	## need to do wheres
		wherexml_list = rulexml.elements.to_a("where")
		for wherexml in wherexml_list
			wherenew = process_where_rulexml( wherexml )
			rulenew.wheres.push wherenew
		end
	end
end
def process_where_rulexml( wherexml )
	wherenew = EXPSM::WhereRule.new
	wherenew.expression = wherexml.attributes["expression"]
	if wherexml.attributes["label"] != nil
		wherenew.name = wherexml.attributes["label"]
	end
	return wherenew
end

def load_dictionary_express( exp, repname )

	schema_list = exp.elements.to_a("//express/schema")
	count_schemas = schema_list.size
	puts "-- Schema count is #{count_schemas.to_s}"

	therepos = EXPSM::Repository.new
	therepos.name = repname

	load_dictionary_express_schemas( schema_list, therepos)

	for schemaxml in schema_list

		puts "-- SCHEMA " + schemaxml.attributes["name"].to_s
	
		load_dictionary_express_interface( schemaxml, therepos)

		load_dictionary_express_entity( schemaxml, therepos)

		load_dictionary_express_type( schemaxml, therepos)
		
		load_dictionary_express_rule( schemaxml, therepos)

	end

	postprocess_dictionary_express( therepos )

	return therepos
end
##
## process descriptions in external XML file
def load_descriptions( descxml, therepos )

	desc_list = descxml.elements.to_a("//ext_descriptions/ext_description")
	desclinkend_list = []
	XPath.each( descxml, '//ext_descriptions/ext_description/@linkend' ) { |n| desclinkend_list.push n.to_s }
	count_desc = desc_list.size
	puts "-- Processing descriptions . Count is #{count_desc.to_s}"

	for schema in therepos.schemas
		
		for decl in schema.contents
		  if decl.kind_of? EXPSM::Entity
		    pos = desclinkend_list.index(schema.name + '.' + decl.name)
			if pos != nil
			  if desc_list[pos].has_elements?
			    defn = 'ELEMENTS_FOUND'
			  else
			    defn = desc_list[pos].text
			  end
			  defn = defn.gsub('"','*')
			  decl.definition = defn.strip
			end
		  end
		end
	end
end
