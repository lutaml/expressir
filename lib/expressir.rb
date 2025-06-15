require_relative "expressir/version"
require_relative "expressir/cli"
require_relative "expressir/config"
require_relative "expressir/benchmark"
require_relative "expressir/coverage"
require "lutaml/model"
require "liquid" # To enable Lutaml::Model::Liquefiable

# ..........................................................
# https://bugs.ruby-lang.org/issues/19319
# The issue is that this bug is fixed for 3.1 and above,
# but not for 3.0 or 2.7, so we need a "safe" function
# ..........................................................
if RUBY_VERSION < "3.1"
  class String
    def safe_downcase
      each_char.map(&:downcase).join
    end
  end
else
  class String
    def safe_downcase
      downcase
    end
  end
end

module Expressir
  class Error < StandardError; end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressir.root)
  end

  # Autoload for Express module classes
  module Express
    autoload :Cache, "expressir/express/cache"
    autoload :Error, "expressir/express/error"
    autoload :Formatter, "expressir/express/formatter"
    autoload :HyperlinkFormatter, "expressir/express/hyperlink_formatter"
    autoload :ModelVisitor, "expressir/express/model_visitor"
    autoload :Parser, "expressir/express/parser"
    autoload :ResolveReferencesModelVisitor, "expressir/express/resolve_references_model_visitor"
    autoload :SchemaHeadFormatter, "expressir/express/schema_head_formatter"
    autoload :Visitor, "expressir/express/visitor"
  end

  # Autoload for Model module classes
  module Model
    autoload :ModelElement, "expressir/model/model_element"
    autoload :Cache, "expressir/model/cache"
    autoload :Identifier, "expressir/model/identifier"
    autoload :Repository, "expressir/model/repository"

    module DataTypes
      autoload :Aggregate, "expressir/model/data_types/aggregate"
      autoload :Array, "expressir/model/data_types/array"
      autoload :Bag, "expressir/model/data_types/bag"
      autoload :Binary, "expressir/model/data_types/binary"
      autoload :Boolean, "expressir/model/data_types/boolean"
      autoload :Enumeration, "expressir/model/data_types/enumeration"
      autoload :EnumerationItem, "expressir/model/data_types/enumeration_item"
      autoload :GenericEntity, "expressir/model/data_types/generic_entity"
      autoload :Generic, "expressir/model/data_types/generic"
      autoload :Integer, "expressir/model/data_types/integer"
      autoload :List, "expressir/model/data_types/list"
      autoload :Logical, "expressir/model/data_types/logical"
      autoload :Number, "expressir/model/data_types/number"
      autoload :Real, "expressir/model/data_types/real"
      autoload :Select, "expressir/model/data_types/select"
      autoload :Set, "expressir/model/data_types/set"
      autoload :String, "expressir/model/data_types/string"
    end

    module Declarations
      autoload :Attribute, "expressir/model/declarations/attribute"
      autoload :Constant, "expressir/model/declarations/constant"
      autoload :DerivedAttribute, "expressir/model/declarations/derived_attribute"
      autoload :Entity, "expressir/model/declarations/entity"
      autoload :Function, "expressir/model/declarations/function"
      autoload :Interface, "expressir/model/declarations/interface"
      autoload :InterfaceItem, "expressir/model/declarations/interface_item"
      autoload :InterfacedItem, "expressir/model/declarations/interfaced_item"
      autoload :InverseAttribute, "expressir/model/declarations/inverse_attribute"
      autoload :Parameter, "expressir/model/declarations/parameter"
      autoload :Procedure, "expressir/model/declarations/procedure"
      autoload :RemarkItem, "expressir/model/declarations/remark_item"
      autoload :Rule, "expressir/model/declarations/rule"
      autoload :Schema, "expressir/model/declarations/schema"
      autoload :SchemaVersion, "expressir/model/declarations/schema_version"
      autoload :SchemaVersionItem, "expressir/model/declarations/schema_version_item"
      autoload :SubtypeConstraint, "expressir/model/declarations/subtype_constraint"
      autoload :Type, "expressir/model/declarations/type"
      autoload :UniqueRule, "expressir/model/declarations/unique_rule"
      autoload :Variable, "expressir/model/declarations/variable"
      autoload :WhereRule, "expressir/model/declarations/where_rule"
      autoload :InformalPropositionRule, "expressir/model/declarations/informal_proposition_rule"
    end

    module Expressions
      autoload :AggregateInitializer, "expressir/model/expressions/aggregate_initializer"
      autoload :AggregateInitializerItem, "expressir/model/expressions/aggregate_initializer_item"
      autoload :BinaryExpression, "expressir/model/expressions/binary_expression"
      autoload :EntityConstructor, "expressir/model/expressions/entity_constructor"
      autoload :FunctionCall, "expressir/model/expressions/function_call"
      autoload :Interval, "expressir/model/expressions/interval"
      autoload :QueryExpression, "expressir/model/expressions/query_expression"
      autoload :UnaryExpression, "expressir/model/expressions/unary_expression"
    end

    module Literals
      autoload :Binary, "expressir/model/literals/binary"
      autoload :Integer, "expressir/model/literals/integer"
      autoload :Logical, "expressir/model/literals/logical"
      autoload :Real, "expressir/model/literals/real"
      autoload :String, "expressir/model/literals/string"
    end

    module References
      autoload :AttributeReference, "expressir/model/references/attribute_reference"
      autoload :GroupReference, "expressir/model/references/group_reference"
      autoload :IndexReference, "expressir/model/references/index_reference"
      autoload :SimpleReference, "expressir/model/references/simple_reference"
    end

    module Statements
      autoload :Alias, "expressir/model/statements/alias"
      autoload :Assignment, "expressir/model/statements/assignment"
      autoload :Case, "expressir/model/statements/case"
      autoload :CaseAction, "expressir/model/statements/case_action"
      autoload :Compound, "expressir/model/statements/compound"
      autoload :Escape, "expressir/model/statements/escape"
      autoload :If, "expressir/model/statements/if"
      autoload :Null, "expressir/model/statements/null"
      autoload :ProcedureCall, "expressir/model/statements/procedure_call"
      autoload :Repeat, "expressir/model/statements/repeat"
      autoload :Return, "expressir/model/statements/return"
      autoload :Skip, "expressir/model/statements/skip"
    end

    module SupertypeExpressions
      autoload :BinarySupertypeExpression, "expressir/model/supertype_expressions/binary_supertype_expression"
      autoload :OneofSupertypeExpression, "expressir/model/supertype_expressions/oneof_supertype_expression"
    end
  end

  # Autoload for Commands module classes
  module Commands
    autoload :Base, "expressir/commands/base"
    autoload :Benchmark, "expressir/commands/benchmark"
    autoload :BenchmarkCache, "expressir/commands/benchmark_cache"
    autoload :Clean, "expressir/commands/clean"
    autoload :Coverage, "expressir/commands/coverage"
    autoload :Format, "expressir/commands/format"
    autoload :Validate, "expressir/commands/validate"
    autoload :Version, "expressir/commands/version"
  end
end

require_relative "expressir/model"
