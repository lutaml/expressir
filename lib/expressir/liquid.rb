require "liquid"

require "expressir/liquid/model_element_drop"

require "expressir/liquid/cache_drop"
require "expressir/liquid/data_type_drop"
require "expressir/liquid/declaration_drop"
require "expressir/liquid/expression_drop"
require "expressir/liquid/literal_drop"
require "expressir/liquid/reference_drop"
require "expressir/liquid/statement_drop"
require "expressir/liquid/supertype_expression_drop"
require "expressir/liquid/identifier_drop"
require "expressir/liquid/repository_drop"

Dir[File.join(__dir__, "liquid", "**", "*.rb")].sort.each do |f|
  require f
end
