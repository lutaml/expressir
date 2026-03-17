# frozen_string_literal: true

module Expressir
  module Model
    # Marker for types that can have remark_items children
    # These are types where RemarkItem children can be created
    module HasRemarkItems; end

    # Marker for scope containers (can contain declarations)
    # Includes schemas, functions, procedures, rules, entities, types, and files
    module ScopeContainer; end

    # Marker for types supporting informal propositions
    module HasInformalPropositions; end

    # Marker for types supporting where rules
    module HasWhereRules; end
  end
end
