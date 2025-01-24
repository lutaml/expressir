require "liquid"

require_relative "liquid/model_element_drop"

require_relative "liquid/cache_drop"
require_relative "liquid/data_type_drop"
require_relative "liquid/declaration_drop"
require_relative "liquid/expression_drop"
require_relative "liquid/literal_drop"
require_relative "liquid/reference_drop"
require_relative "liquid/statement_drop"
require_relative "liquid/supertype_expression_drop"
require_relative "liquid/identifier_drop"
require_relative "liquid/repository_drop"

Dir[File.join(__dir__, "liquid", "**", "*.rb")].sort.each do |f|
  require f
end
