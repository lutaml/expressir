# This file is kept for backward compatibility and to ensure all model classes are loaded
# when explicitly requiring 'expressir/model'. The actual autoload definitions are in the main
# expressir.rb file.

# Ensure all model classes are loaded by referencing them
# This triggers the autoload mechanism for each class

# Core model classes
Expressir::Model::ModelElement
Expressir::Model::Cache
Expressir::Model::Identifier
Expressir::Model::Repository

# Data types
Expressir::Model::DataTypes::Aggregate
Expressir::Model::DataTypes::Array
Expressir::Model::DataTypes::Bag
Expressir::Model::DataTypes::Binary
Expressir::Model::DataTypes::Boolean
Expressir::Model::DataTypes::Enumeration
Expressir::Model::DataTypes::EnumerationItem
Expressir::Model::DataTypes::GenericEntity
Expressir::Model::DataTypes::Generic
Expressir::Model::DataTypes::Integer
Expressir::Model::DataTypes::List
Expressir::Model::DataTypes::Logical
Expressir::Model::DataTypes::Number
Expressir::Model::DataTypes::Real
Expressir::Model::DataTypes::Select
Expressir::Model::DataTypes::Set
Expressir::Model::DataTypes::String

# Declarations
Expressir::Model::Declarations::Attribute
Expressir::Model::Declarations::Constant
Expressir::Model::Declarations::DerivedAttribute
Expressir::Model::Declarations::Entity
Expressir::Model::Declarations::Function
Expressir::Model::Declarations::Interface
Expressir::Model::Declarations::InterfaceItem
Expressir::Model::Declarations::InterfacedItem
Expressir::Model::Declarations::InverseAttribute
Expressir::Model::Declarations::Parameter
Expressir::Model::Declarations::Procedure
Expressir::Model::Declarations::RemarkItem
Expressir::Model::Declarations::Rule
Expressir::Model::Declarations::Schema
Expressir::Model::Declarations::SchemaVersion
Expressir::Model::Declarations::SchemaVersionItem
Expressir::Model::Declarations::SubtypeConstraint
Expressir::Model::Declarations::Type
Expressir::Model::Declarations::UniqueRule
Expressir::Model::Declarations::Variable
Expressir::Model::Declarations::WhereRule

# Expressions
Expressir::Model::Expressions::AggregateInitializer
Expressir::Model::Expressions::AggregateInitializerItem
Expressir::Model::Expressions::BinaryExpression
Expressir::Model::Expressions::EntityConstructor
Expressir::Model::Expressions::FunctionCall
Expressir::Model::Expressions::Interval
Expressir::Model::Expressions::QueryExpression
Expressir::Model::Expressions::UnaryExpression

# Literals
Expressir::Model::Literals::Binary
Expressir::Model::Literals::Integer
Expressir::Model::Literals::Logical
Expressir::Model::Literals::Real
Expressir::Model::Literals::String

# References
Expressir::Model::References::AttributeReference
Expressir::Model::References::GroupReference
Expressir::Model::References::IndexReference
Expressir::Model::References::SimpleReference

# Statements
Expressir::Model::Statements::Alias
Expressir::Model::Statements::Assignment
Expressir::Model::Statements::Case
Expressir::Model::Statements::CaseAction
Expressir::Model::Statements::Compound
Expressir::Model::Statements::Escape
Expressir::Model::Statements::If
Expressir::Model::Statements::Null
Expressir::Model::Statements::ProcedureCall
Expressir::Model::Statements::Repeat
Expressir::Model::Statements::Return
Expressir::Model::Statements::Skip

# Supertype expressions
Expressir::Model::SupertypeExpressions::BinarySupertypeExpression
Expressir::Model::SupertypeExpressions::OneofSupertypeExpression
