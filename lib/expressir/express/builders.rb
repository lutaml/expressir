# frozen_string_literal: true

# Builder loader - requires all builder classes.
# This file has NO CODE, only requires.
# Each builder class registers itself with Builder.register.

# Ensure Expressir module and autoloads are set up first
require_relative "../../expressir"

require_relative "builders/helpers"
require_relative "builders/token_builder"
require_relative "builders/simple_id_builder"
require_relative "builders/syntax_builder"
require_relative "builders/schema_version_builder"
require_relative "builders/declaration_builder"
require_relative "builders/schema_body_decl_builder"
require_relative "builders/schema_decl_builder"
require_relative "builders/entity_decl_builder"
require_relative "builders/explicit_attr_builder"
require_relative "builders/attribute_decl_builder"
require_relative "builders/derive_clause_builder"
require_relative "builders/derived_attr_builder"
require_relative "builders/inverse_clause_builder"
require_relative "builders/inverse_attr_builder"
require_relative "builders/inverse_attr_type_builder"
require_relative "builders/unique_clause_builder"
require_relative "builders/unique_rule_builder"
require_relative "builders/where_clause_builder"
require_relative "builders/domain_rule_builder"
require_relative "builders/reference_builder"
require_relative "builders/literal_builder"
require_relative "builders/type_decl_builder"
require_relative "builders/type_builder"
require_relative "builders/expression_builder"
require_relative "builders/statement_builder"
require_relative "builders/function_decl_builder"
require_relative "builders/procedure_decl_builder"
require_relative "builders/rule_decl_builder"
require_relative "builders/subtype_constraint_builder"
require_relative "builders/interface_builder"
require_relative "builders/constant_builder"
require_relative "builders/qualifier_builder"
require_relative "builders/built_in_builder"
