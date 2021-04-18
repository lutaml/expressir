#!/usr/bin/env ruby

require 'expressir'
require 'expressir/express/parser'

# This file is from:
# https://github.com/metanorma/annotated-express/blob/master/data/resources/action_schema/action_schema.exp
file = 'action_schema.exp'

# repo = Expressir::Express::Parser.from_exp(file)
# schema = repo.schemas.find{|schema| schema.id == "support_resource_schema"}

repo = Expressir::Express::Parser.from_exp(file)
schema = repo.schemas.find{|schema| schema.id == "action_schema"}
entity = schema.entities.find{|entity| entity.id == "action_directive_relationship"}
where_rule = entity.where_rules.find{|where_rule| where_rule.id == "WR1"}

puts where_rule.inspect
