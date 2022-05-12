
// Generated from Express.g4 by ANTLR 4.10.1

#pragma once


#include "antlr4-runtime.h"
#include "ExpressParser.h"


/**
 * This interface defines an abstract listener for a parse tree produced by ExpressParser.
 */
class  ExpressListener : public antlr4::tree::ParseTreeListener {
public:

  virtual void enterAttributeRef(ExpressParser::AttributeRefContext *ctx) = 0;
  virtual void exitAttributeRef(ExpressParser::AttributeRefContext *ctx) = 0;

  virtual void enterConstantRef(ExpressParser::ConstantRefContext *ctx) = 0;
  virtual void exitConstantRef(ExpressParser::ConstantRefContext *ctx) = 0;

  virtual void enterEntityRef(ExpressParser::EntityRefContext *ctx) = 0;
  virtual void exitEntityRef(ExpressParser::EntityRefContext *ctx) = 0;

  virtual void enterEnumerationRef(ExpressParser::EnumerationRefContext *ctx) = 0;
  virtual void exitEnumerationRef(ExpressParser::EnumerationRefContext *ctx) = 0;

  virtual void enterFunctionRef(ExpressParser::FunctionRefContext *ctx) = 0;
  virtual void exitFunctionRef(ExpressParser::FunctionRefContext *ctx) = 0;

  virtual void enterParameterRef(ExpressParser::ParameterRefContext *ctx) = 0;
  virtual void exitParameterRef(ExpressParser::ParameterRefContext *ctx) = 0;

  virtual void enterProcedureRef(ExpressParser::ProcedureRefContext *ctx) = 0;
  virtual void exitProcedureRef(ExpressParser::ProcedureRefContext *ctx) = 0;

  virtual void enterRuleLabelRef(ExpressParser::RuleLabelRefContext *ctx) = 0;
  virtual void exitRuleLabelRef(ExpressParser::RuleLabelRefContext *ctx) = 0;

  virtual void enterRuleRef(ExpressParser::RuleRefContext *ctx) = 0;
  virtual void exitRuleRef(ExpressParser::RuleRefContext *ctx) = 0;

  virtual void enterSchemaRef(ExpressParser::SchemaRefContext *ctx) = 0;
  virtual void exitSchemaRef(ExpressParser::SchemaRefContext *ctx) = 0;

  virtual void enterSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *ctx) = 0;
  virtual void exitSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *ctx) = 0;

  virtual void enterTypeLabelRef(ExpressParser::TypeLabelRefContext *ctx) = 0;
  virtual void exitTypeLabelRef(ExpressParser::TypeLabelRefContext *ctx) = 0;

  virtual void enterTypeRef(ExpressParser::TypeRefContext *ctx) = 0;
  virtual void exitTypeRef(ExpressParser::TypeRefContext *ctx) = 0;

  virtual void enterVariableRef(ExpressParser::VariableRefContext *ctx) = 0;
  virtual void exitVariableRef(ExpressParser::VariableRefContext *ctx) = 0;

  virtual void enterAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *ctx) = 0;
  virtual void exitAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *ctx) = 0;

  virtual void enterAbstractSupertype(ExpressParser::AbstractSupertypeContext *ctx) = 0;
  virtual void exitAbstractSupertype(ExpressParser::AbstractSupertypeContext *ctx) = 0;

  virtual void enterAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *ctx) = 0;
  virtual void exitAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *ctx) = 0;

  virtual void enterActualParameterList(ExpressParser::ActualParameterListContext *ctx) = 0;
  virtual void exitActualParameterList(ExpressParser::ActualParameterListContext *ctx) = 0;

  virtual void enterAddLikeOp(ExpressParser::AddLikeOpContext *ctx) = 0;
  virtual void exitAddLikeOp(ExpressParser::AddLikeOpContext *ctx) = 0;

  virtual void enterAggregateInitializer(ExpressParser::AggregateInitializerContext *ctx) = 0;
  virtual void exitAggregateInitializer(ExpressParser::AggregateInitializerContext *ctx) = 0;

  virtual void enterAggregateSource(ExpressParser::AggregateSourceContext *ctx) = 0;
  virtual void exitAggregateSource(ExpressParser::AggregateSourceContext *ctx) = 0;

  virtual void enterAggregateType(ExpressParser::AggregateTypeContext *ctx) = 0;
  virtual void exitAggregateType(ExpressParser::AggregateTypeContext *ctx) = 0;

  virtual void enterAggregationTypes(ExpressParser::AggregationTypesContext *ctx) = 0;
  virtual void exitAggregationTypes(ExpressParser::AggregationTypesContext *ctx) = 0;

  virtual void enterAlgorithmHead(ExpressParser::AlgorithmHeadContext *ctx) = 0;
  virtual void exitAlgorithmHead(ExpressParser::AlgorithmHeadContext *ctx) = 0;

  virtual void enterAliasStmt(ExpressParser::AliasStmtContext *ctx) = 0;
  virtual void exitAliasStmt(ExpressParser::AliasStmtContext *ctx) = 0;

  virtual void enterArrayType(ExpressParser::ArrayTypeContext *ctx) = 0;
  virtual void exitArrayType(ExpressParser::ArrayTypeContext *ctx) = 0;

  virtual void enterAssignmentStmt(ExpressParser::AssignmentStmtContext *ctx) = 0;
  virtual void exitAssignmentStmt(ExpressParser::AssignmentStmtContext *ctx) = 0;

  virtual void enterAttributeDecl(ExpressParser::AttributeDeclContext *ctx) = 0;
  virtual void exitAttributeDecl(ExpressParser::AttributeDeclContext *ctx) = 0;

  virtual void enterAttributeId(ExpressParser::AttributeIdContext *ctx) = 0;
  virtual void exitAttributeId(ExpressParser::AttributeIdContext *ctx) = 0;

  virtual void enterAttributeQualifier(ExpressParser::AttributeQualifierContext *ctx) = 0;
  virtual void exitAttributeQualifier(ExpressParser::AttributeQualifierContext *ctx) = 0;

  virtual void enterBagType(ExpressParser::BagTypeContext *ctx) = 0;
  virtual void exitBagType(ExpressParser::BagTypeContext *ctx) = 0;

  virtual void enterBinaryType(ExpressParser::BinaryTypeContext *ctx) = 0;
  virtual void exitBinaryType(ExpressParser::BinaryTypeContext *ctx) = 0;

  virtual void enterBooleanType(ExpressParser::BooleanTypeContext *ctx) = 0;
  virtual void exitBooleanType(ExpressParser::BooleanTypeContext *ctx) = 0;

  virtual void enterBound1(ExpressParser::Bound1Context *ctx) = 0;
  virtual void exitBound1(ExpressParser::Bound1Context *ctx) = 0;

  virtual void enterBound2(ExpressParser::Bound2Context *ctx) = 0;
  virtual void exitBound2(ExpressParser::Bound2Context *ctx) = 0;

  virtual void enterBoundSpec(ExpressParser::BoundSpecContext *ctx) = 0;
  virtual void exitBoundSpec(ExpressParser::BoundSpecContext *ctx) = 0;

  virtual void enterBuiltInConstant(ExpressParser::BuiltInConstantContext *ctx) = 0;
  virtual void exitBuiltInConstant(ExpressParser::BuiltInConstantContext *ctx) = 0;

  virtual void enterBuiltInFunction(ExpressParser::BuiltInFunctionContext *ctx) = 0;
  virtual void exitBuiltInFunction(ExpressParser::BuiltInFunctionContext *ctx) = 0;

  virtual void enterBuiltInProcedure(ExpressParser::BuiltInProcedureContext *ctx) = 0;
  virtual void exitBuiltInProcedure(ExpressParser::BuiltInProcedureContext *ctx) = 0;

  virtual void enterCaseAction(ExpressParser::CaseActionContext *ctx) = 0;
  virtual void exitCaseAction(ExpressParser::CaseActionContext *ctx) = 0;

  virtual void enterCaseLabel(ExpressParser::CaseLabelContext *ctx) = 0;
  virtual void exitCaseLabel(ExpressParser::CaseLabelContext *ctx) = 0;

  virtual void enterCaseStmt(ExpressParser::CaseStmtContext *ctx) = 0;
  virtual void exitCaseStmt(ExpressParser::CaseStmtContext *ctx) = 0;

  virtual void enterCompoundStmt(ExpressParser::CompoundStmtContext *ctx) = 0;
  virtual void exitCompoundStmt(ExpressParser::CompoundStmtContext *ctx) = 0;

  virtual void enterConcreteTypes(ExpressParser::ConcreteTypesContext *ctx) = 0;
  virtual void exitConcreteTypes(ExpressParser::ConcreteTypesContext *ctx) = 0;

  virtual void enterConstantBody(ExpressParser::ConstantBodyContext *ctx) = 0;
  virtual void exitConstantBody(ExpressParser::ConstantBodyContext *ctx) = 0;

  virtual void enterConstantDecl(ExpressParser::ConstantDeclContext *ctx) = 0;
  virtual void exitConstantDecl(ExpressParser::ConstantDeclContext *ctx) = 0;

  virtual void enterConstantFactor(ExpressParser::ConstantFactorContext *ctx) = 0;
  virtual void exitConstantFactor(ExpressParser::ConstantFactorContext *ctx) = 0;

  virtual void enterConstantId(ExpressParser::ConstantIdContext *ctx) = 0;
  virtual void exitConstantId(ExpressParser::ConstantIdContext *ctx) = 0;

  virtual void enterConstructedTypes(ExpressParser::ConstructedTypesContext *ctx) = 0;
  virtual void exitConstructedTypes(ExpressParser::ConstructedTypesContext *ctx) = 0;

  virtual void enterDeclaration(ExpressParser::DeclarationContext *ctx) = 0;
  virtual void exitDeclaration(ExpressParser::DeclarationContext *ctx) = 0;

  virtual void enterDerivedAttr(ExpressParser::DerivedAttrContext *ctx) = 0;
  virtual void exitDerivedAttr(ExpressParser::DerivedAttrContext *ctx) = 0;

  virtual void enterDeriveClause(ExpressParser::DeriveClauseContext *ctx) = 0;
  virtual void exitDeriveClause(ExpressParser::DeriveClauseContext *ctx) = 0;

  virtual void enterDomainRule(ExpressParser::DomainRuleContext *ctx) = 0;
  virtual void exitDomainRule(ExpressParser::DomainRuleContext *ctx) = 0;

  virtual void enterElement(ExpressParser::ElementContext *ctx) = 0;
  virtual void exitElement(ExpressParser::ElementContext *ctx) = 0;

  virtual void enterEntityBody(ExpressParser::EntityBodyContext *ctx) = 0;
  virtual void exitEntityBody(ExpressParser::EntityBodyContext *ctx) = 0;

  virtual void enterEntityConstructor(ExpressParser::EntityConstructorContext *ctx) = 0;
  virtual void exitEntityConstructor(ExpressParser::EntityConstructorContext *ctx) = 0;

  virtual void enterEntityDecl(ExpressParser::EntityDeclContext *ctx) = 0;
  virtual void exitEntityDecl(ExpressParser::EntityDeclContext *ctx) = 0;

  virtual void enterEntityHead(ExpressParser::EntityHeadContext *ctx) = 0;
  virtual void exitEntityHead(ExpressParser::EntityHeadContext *ctx) = 0;

  virtual void enterEntityId(ExpressParser::EntityIdContext *ctx) = 0;
  virtual void exitEntityId(ExpressParser::EntityIdContext *ctx) = 0;

  virtual void enterEnumerationExtension(ExpressParser::EnumerationExtensionContext *ctx) = 0;
  virtual void exitEnumerationExtension(ExpressParser::EnumerationExtensionContext *ctx) = 0;

  virtual void enterEnumerationId(ExpressParser::EnumerationIdContext *ctx) = 0;
  virtual void exitEnumerationId(ExpressParser::EnumerationIdContext *ctx) = 0;

  virtual void enterEnumerationItems(ExpressParser::EnumerationItemsContext *ctx) = 0;
  virtual void exitEnumerationItems(ExpressParser::EnumerationItemsContext *ctx) = 0;

  virtual void enterEnumerationItem(ExpressParser::EnumerationItemContext *ctx) = 0;
  virtual void exitEnumerationItem(ExpressParser::EnumerationItemContext *ctx) = 0;

  virtual void enterEnumerationReference(ExpressParser::EnumerationReferenceContext *ctx) = 0;
  virtual void exitEnumerationReference(ExpressParser::EnumerationReferenceContext *ctx) = 0;

  virtual void enterEnumerationType(ExpressParser::EnumerationTypeContext *ctx) = 0;
  virtual void exitEnumerationType(ExpressParser::EnumerationTypeContext *ctx) = 0;

  virtual void enterEscapeStmt(ExpressParser::EscapeStmtContext *ctx) = 0;
  virtual void exitEscapeStmt(ExpressParser::EscapeStmtContext *ctx) = 0;

  virtual void enterExplicitAttr(ExpressParser::ExplicitAttrContext *ctx) = 0;
  virtual void exitExplicitAttr(ExpressParser::ExplicitAttrContext *ctx) = 0;

  virtual void enterExpression(ExpressParser::ExpressionContext *ctx) = 0;
  virtual void exitExpression(ExpressParser::ExpressionContext *ctx) = 0;

  virtual void enterFactor(ExpressParser::FactorContext *ctx) = 0;
  virtual void exitFactor(ExpressParser::FactorContext *ctx) = 0;

  virtual void enterFormalParameter(ExpressParser::FormalParameterContext *ctx) = 0;
  virtual void exitFormalParameter(ExpressParser::FormalParameterContext *ctx) = 0;

  virtual void enterFunctionCall(ExpressParser::FunctionCallContext *ctx) = 0;
  virtual void exitFunctionCall(ExpressParser::FunctionCallContext *ctx) = 0;

  virtual void enterFunctionDecl(ExpressParser::FunctionDeclContext *ctx) = 0;
  virtual void exitFunctionDecl(ExpressParser::FunctionDeclContext *ctx) = 0;

  virtual void enterFunctionHead(ExpressParser::FunctionHeadContext *ctx) = 0;
  virtual void exitFunctionHead(ExpressParser::FunctionHeadContext *ctx) = 0;

  virtual void enterFunctionId(ExpressParser::FunctionIdContext *ctx) = 0;
  virtual void exitFunctionId(ExpressParser::FunctionIdContext *ctx) = 0;

  virtual void enterGeneralizedTypes(ExpressParser::GeneralizedTypesContext *ctx) = 0;
  virtual void exitGeneralizedTypes(ExpressParser::GeneralizedTypesContext *ctx) = 0;

  virtual void enterGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *ctx) = 0;
  virtual void exitGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *ctx) = 0;

  virtual void enterGeneralArrayType(ExpressParser::GeneralArrayTypeContext *ctx) = 0;
  virtual void exitGeneralArrayType(ExpressParser::GeneralArrayTypeContext *ctx) = 0;

  virtual void enterGeneralBagType(ExpressParser::GeneralBagTypeContext *ctx) = 0;
  virtual void exitGeneralBagType(ExpressParser::GeneralBagTypeContext *ctx) = 0;

  virtual void enterGeneralListType(ExpressParser::GeneralListTypeContext *ctx) = 0;
  virtual void exitGeneralListType(ExpressParser::GeneralListTypeContext *ctx) = 0;

  virtual void enterGeneralRef(ExpressParser::GeneralRefContext *ctx) = 0;
  virtual void exitGeneralRef(ExpressParser::GeneralRefContext *ctx) = 0;

  virtual void enterGeneralSetType(ExpressParser::GeneralSetTypeContext *ctx) = 0;
  virtual void exitGeneralSetType(ExpressParser::GeneralSetTypeContext *ctx) = 0;

  virtual void enterGenericEntityType(ExpressParser::GenericEntityTypeContext *ctx) = 0;
  virtual void exitGenericEntityType(ExpressParser::GenericEntityTypeContext *ctx) = 0;

  virtual void enterGenericType(ExpressParser::GenericTypeContext *ctx) = 0;
  virtual void exitGenericType(ExpressParser::GenericTypeContext *ctx) = 0;

  virtual void enterGroupQualifier(ExpressParser::GroupQualifierContext *ctx) = 0;
  virtual void exitGroupQualifier(ExpressParser::GroupQualifierContext *ctx) = 0;

  virtual void enterIfStmt(ExpressParser::IfStmtContext *ctx) = 0;
  virtual void exitIfStmt(ExpressParser::IfStmtContext *ctx) = 0;

  virtual void enterIfStmtStatements(ExpressParser::IfStmtStatementsContext *ctx) = 0;
  virtual void exitIfStmtStatements(ExpressParser::IfStmtStatementsContext *ctx) = 0;

  virtual void enterIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *ctx) = 0;
  virtual void exitIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *ctx) = 0;

  virtual void enterIncrement(ExpressParser::IncrementContext *ctx) = 0;
  virtual void exitIncrement(ExpressParser::IncrementContext *ctx) = 0;

  virtual void enterIncrementControl(ExpressParser::IncrementControlContext *ctx) = 0;
  virtual void exitIncrementControl(ExpressParser::IncrementControlContext *ctx) = 0;

  virtual void enterIndex(ExpressParser::IndexContext *ctx) = 0;
  virtual void exitIndex(ExpressParser::IndexContext *ctx) = 0;

  virtual void enterIndex1(ExpressParser::Index1Context *ctx) = 0;
  virtual void exitIndex1(ExpressParser::Index1Context *ctx) = 0;

  virtual void enterIndex2(ExpressParser::Index2Context *ctx) = 0;
  virtual void exitIndex2(ExpressParser::Index2Context *ctx) = 0;

  virtual void enterIndexQualifier(ExpressParser::IndexQualifierContext *ctx) = 0;
  virtual void exitIndexQualifier(ExpressParser::IndexQualifierContext *ctx) = 0;

  virtual void enterInstantiableType(ExpressParser::InstantiableTypeContext *ctx) = 0;
  virtual void exitInstantiableType(ExpressParser::InstantiableTypeContext *ctx) = 0;

  virtual void enterIntegerType(ExpressParser::IntegerTypeContext *ctx) = 0;
  virtual void exitIntegerType(ExpressParser::IntegerTypeContext *ctx) = 0;

  virtual void enterInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *ctx) = 0;
  virtual void exitInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *ctx) = 0;

  virtual void enterInterval(ExpressParser::IntervalContext *ctx) = 0;
  virtual void exitInterval(ExpressParser::IntervalContext *ctx) = 0;

  virtual void enterIntervalHigh(ExpressParser::IntervalHighContext *ctx) = 0;
  virtual void exitIntervalHigh(ExpressParser::IntervalHighContext *ctx) = 0;

  virtual void enterIntervalItem(ExpressParser::IntervalItemContext *ctx) = 0;
  virtual void exitIntervalItem(ExpressParser::IntervalItemContext *ctx) = 0;

  virtual void enterIntervalLow(ExpressParser::IntervalLowContext *ctx) = 0;
  virtual void exitIntervalLow(ExpressParser::IntervalLowContext *ctx) = 0;

  virtual void enterIntervalOp(ExpressParser::IntervalOpContext *ctx) = 0;
  virtual void exitIntervalOp(ExpressParser::IntervalOpContext *ctx) = 0;

  virtual void enterInverseAttr(ExpressParser::InverseAttrContext *ctx) = 0;
  virtual void exitInverseAttr(ExpressParser::InverseAttrContext *ctx) = 0;

  virtual void enterInverseAttrType(ExpressParser::InverseAttrTypeContext *ctx) = 0;
  virtual void exitInverseAttrType(ExpressParser::InverseAttrTypeContext *ctx) = 0;

  virtual void enterInverseClause(ExpressParser::InverseClauseContext *ctx) = 0;
  virtual void exitInverseClause(ExpressParser::InverseClauseContext *ctx) = 0;

  virtual void enterListType(ExpressParser::ListTypeContext *ctx) = 0;
  virtual void exitListType(ExpressParser::ListTypeContext *ctx) = 0;

  virtual void enterLiteral(ExpressParser::LiteralContext *ctx) = 0;
  virtual void exitLiteral(ExpressParser::LiteralContext *ctx) = 0;

  virtual void enterLocalDecl(ExpressParser::LocalDeclContext *ctx) = 0;
  virtual void exitLocalDecl(ExpressParser::LocalDeclContext *ctx) = 0;

  virtual void enterLocalVariable(ExpressParser::LocalVariableContext *ctx) = 0;
  virtual void exitLocalVariable(ExpressParser::LocalVariableContext *ctx) = 0;

  virtual void enterLogicalExpression(ExpressParser::LogicalExpressionContext *ctx) = 0;
  virtual void exitLogicalExpression(ExpressParser::LogicalExpressionContext *ctx) = 0;

  virtual void enterLogicalLiteral(ExpressParser::LogicalLiteralContext *ctx) = 0;
  virtual void exitLogicalLiteral(ExpressParser::LogicalLiteralContext *ctx) = 0;

  virtual void enterLogicalType(ExpressParser::LogicalTypeContext *ctx) = 0;
  virtual void exitLogicalType(ExpressParser::LogicalTypeContext *ctx) = 0;

  virtual void enterMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *ctx) = 0;
  virtual void exitMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *ctx) = 0;

  virtual void enterNamedTypes(ExpressParser::NamedTypesContext *ctx) = 0;
  virtual void exitNamedTypes(ExpressParser::NamedTypesContext *ctx) = 0;

  virtual void enterNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *ctx) = 0;
  virtual void exitNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *ctx) = 0;

  virtual void enterNullStmt(ExpressParser::NullStmtContext *ctx) = 0;
  virtual void exitNullStmt(ExpressParser::NullStmtContext *ctx) = 0;

  virtual void enterNumberType(ExpressParser::NumberTypeContext *ctx) = 0;
  virtual void exitNumberType(ExpressParser::NumberTypeContext *ctx) = 0;

  virtual void enterNumericExpression(ExpressParser::NumericExpressionContext *ctx) = 0;
  virtual void exitNumericExpression(ExpressParser::NumericExpressionContext *ctx) = 0;

  virtual void enterOneOf(ExpressParser::OneOfContext *ctx) = 0;
  virtual void exitOneOf(ExpressParser::OneOfContext *ctx) = 0;

  virtual void enterParameter(ExpressParser::ParameterContext *ctx) = 0;
  virtual void exitParameter(ExpressParser::ParameterContext *ctx) = 0;

  virtual void enterParameterId(ExpressParser::ParameterIdContext *ctx) = 0;
  virtual void exitParameterId(ExpressParser::ParameterIdContext *ctx) = 0;

  virtual void enterParameterType(ExpressParser::ParameterTypeContext *ctx) = 0;
  virtual void exitParameterType(ExpressParser::ParameterTypeContext *ctx) = 0;

  virtual void enterPopulation(ExpressParser::PopulationContext *ctx) = 0;
  virtual void exitPopulation(ExpressParser::PopulationContext *ctx) = 0;

  virtual void enterPrecisionSpec(ExpressParser::PrecisionSpecContext *ctx) = 0;
  virtual void exitPrecisionSpec(ExpressParser::PrecisionSpecContext *ctx) = 0;

  virtual void enterPrimary(ExpressParser::PrimaryContext *ctx) = 0;
  virtual void exitPrimary(ExpressParser::PrimaryContext *ctx) = 0;

  virtual void enterProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *ctx) = 0;
  virtual void exitProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *ctx) = 0;

  virtual void enterProcedureDecl(ExpressParser::ProcedureDeclContext *ctx) = 0;
  virtual void exitProcedureDecl(ExpressParser::ProcedureDeclContext *ctx) = 0;

  virtual void enterProcedureHead(ExpressParser::ProcedureHeadContext *ctx) = 0;
  virtual void exitProcedureHead(ExpressParser::ProcedureHeadContext *ctx) = 0;

  virtual void enterProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *ctx) = 0;
  virtual void exitProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *ctx) = 0;

  virtual void enterProcedureId(ExpressParser::ProcedureIdContext *ctx) = 0;
  virtual void exitProcedureId(ExpressParser::ProcedureIdContext *ctx) = 0;

  virtual void enterQualifiableFactor(ExpressParser::QualifiableFactorContext *ctx) = 0;
  virtual void exitQualifiableFactor(ExpressParser::QualifiableFactorContext *ctx) = 0;

  virtual void enterQualifiedAttribute(ExpressParser::QualifiedAttributeContext *ctx) = 0;
  virtual void exitQualifiedAttribute(ExpressParser::QualifiedAttributeContext *ctx) = 0;

  virtual void enterQualifier(ExpressParser::QualifierContext *ctx) = 0;
  virtual void exitQualifier(ExpressParser::QualifierContext *ctx) = 0;

  virtual void enterQueryExpression(ExpressParser::QueryExpressionContext *ctx) = 0;
  virtual void exitQueryExpression(ExpressParser::QueryExpressionContext *ctx) = 0;

  virtual void enterRealType(ExpressParser::RealTypeContext *ctx) = 0;
  virtual void exitRealType(ExpressParser::RealTypeContext *ctx) = 0;

  virtual void enterRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *ctx) = 0;
  virtual void exitRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *ctx) = 0;

  virtual void enterReferencedAttribute(ExpressParser::ReferencedAttributeContext *ctx) = 0;
  virtual void exitReferencedAttribute(ExpressParser::ReferencedAttributeContext *ctx) = 0;

  virtual void enterReferenceClause(ExpressParser::ReferenceClauseContext *ctx) = 0;
  virtual void exitReferenceClause(ExpressParser::ReferenceClauseContext *ctx) = 0;

  virtual void enterRelOp(ExpressParser::RelOpContext *ctx) = 0;
  virtual void exitRelOp(ExpressParser::RelOpContext *ctx) = 0;

  virtual void enterRelOpExtended(ExpressParser::RelOpExtendedContext *ctx) = 0;
  virtual void exitRelOpExtended(ExpressParser::RelOpExtendedContext *ctx) = 0;

  virtual void enterRenameId(ExpressParser::RenameIdContext *ctx) = 0;
  virtual void exitRenameId(ExpressParser::RenameIdContext *ctx) = 0;

  virtual void enterRepeatControl(ExpressParser::RepeatControlContext *ctx) = 0;
  virtual void exitRepeatControl(ExpressParser::RepeatControlContext *ctx) = 0;

  virtual void enterRepeatStmt(ExpressParser::RepeatStmtContext *ctx) = 0;
  virtual void exitRepeatStmt(ExpressParser::RepeatStmtContext *ctx) = 0;

  virtual void enterRepetition(ExpressParser::RepetitionContext *ctx) = 0;
  virtual void exitRepetition(ExpressParser::RepetitionContext *ctx) = 0;

  virtual void enterResourceOrRename(ExpressParser::ResourceOrRenameContext *ctx) = 0;
  virtual void exitResourceOrRename(ExpressParser::ResourceOrRenameContext *ctx) = 0;

  virtual void enterResourceRef(ExpressParser::ResourceRefContext *ctx) = 0;
  virtual void exitResourceRef(ExpressParser::ResourceRefContext *ctx) = 0;

  virtual void enterReturnStmt(ExpressParser::ReturnStmtContext *ctx) = 0;
  virtual void exitReturnStmt(ExpressParser::ReturnStmtContext *ctx) = 0;

  virtual void enterRuleDecl(ExpressParser::RuleDeclContext *ctx) = 0;
  virtual void exitRuleDecl(ExpressParser::RuleDeclContext *ctx) = 0;

  virtual void enterRuleHead(ExpressParser::RuleHeadContext *ctx) = 0;
  virtual void exitRuleHead(ExpressParser::RuleHeadContext *ctx) = 0;

  virtual void enterRuleId(ExpressParser::RuleIdContext *ctx) = 0;
  virtual void exitRuleId(ExpressParser::RuleIdContext *ctx) = 0;

  virtual void enterRuleLabelId(ExpressParser::RuleLabelIdContext *ctx) = 0;
  virtual void exitRuleLabelId(ExpressParser::RuleLabelIdContext *ctx) = 0;

  virtual void enterSchemaBody(ExpressParser::SchemaBodyContext *ctx) = 0;
  virtual void exitSchemaBody(ExpressParser::SchemaBodyContext *ctx) = 0;

  virtual void enterSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *ctx) = 0;
  virtual void exitSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *ctx) = 0;

  virtual void enterSchemaDecl(ExpressParser::SchemaDeclContext *ctx) = 0;
  virtual void exitSchemaDecl(ExpressParser::SchemaDeclContext *ctx) = 0;

  virtual void enterSchemaId(ExpressParser::SchemaIdContext *ctx) = 0;
  virtual void exitSchemaId(ExpressParser::SchemaIdContext *ctx) = 0;

  virtual void enterSchemaVersionId(ExpressParser::SchemaVersionIdContext *ctx) = 0;
  virtual void exitSchemaVersionId(ExpressParser::SchemaVersionIdContext *ctx) = 0;

  virtual void enterSelector(ExpressParser::SelectorContext *ctx) = 0;
  virtual void exitSelector(ExpressParser::SelectorContext *ctx) = 0;

  virtual void enterSelectExtension(ExpressParser::SelectExtensionContext *ctx) = 0;
  virtual void exitSelectExtension(ExpressParser::SelectExtensionContext *ctx) = 0;

  virtual void enterSelectList(ExpressParser::SelectListContext *ctx) = 0;
  virtual void exitSelectList(ExpressParser::SelectListContext *ctx) = 0;

  virtual void enterSelectType(ExpressParser::SelectTypeContext *ctx) = 0;
  virtual void exitSelectType(ExpressParser::SelectTypeContext *ctx) = 0;

  virtual void enterSetType(ExpressParser::SetTypeContext *ctx) = 0;
  virtual void exitSetType(ExpressParser::SetTypeContext *ctx) = 0;

  virtual void enterSimpleExpression(ExpressParser::SimpleExpressionContext *ctx) = 0;
  virtual void exitSimpleExpression(ExpressParser::SimpleExpressionContext *ctx) = 0;

  virtual void enterSimpleFactor(ExpressParser::SimpleFactorContext *ctx) = 0;
  virtual void exitSimpleFactor(ExpressParser::SimpleFactorContext *ctx) = 0;

  virtual void enterSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *ctx) = 0;
  virtual void exitSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *ctx) = 0;

  virtual void enterSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *ctx) = 0;
  virtual void exitSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *ctx) = 0;

  virtual void enterSimpleTypes(ExpressParser::SimpleTypesContext *ctx) = 0;
  virtual void exitSimpleTypes(ExpressParser::SimpleTypesContext *ctx) = 0;

  virtual void enterSkipStmt(ExpressParser::SkipStmtContext *ctx) = 0;
  virtual void exitSkipStmt(ExpressParser::SkipStmtContext *ctx) = 0;

  virtual void enterStmt(ExpressParser::StmtContext *ctx) = 0;
  virtual void exitStmt(ExpressParser::StmtContext *ctx) = 0;

  virtual void enterStringLiteral(ExpressParser::StringLiteralContext *ctx) = 0;
  virtual void exitStringLiteral(ExpressParser::StringLiteralContext *ctx) = 0;

  virtual void enterStringType(ExpressParser::StringTypeContext *ctx) = 0;
  virtual void exitStringType(ExpressParser::StringTypeContext *ctx) = 0;

  virtual void enterSubsuper(ExpressParser::SubsuperContext *ctx) = 0;
  virtual void exitSubsuper(ExpressParser::SubsuperContext *ctx) = 0;

  virtual void enterSubtypeConstraint(ExpressParser::SubtypeConstraintContext *ctx) = 0;
  virtual void exitSubtypeConstraint(ExpressParser::SubtypeConstraintContext *ctx) = 0;

  virtual void enterSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *ctx) = 0;
  virtual void exitSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *ctx) = 0;

  virtual void enterSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *ctx) = 0;
  virtual void exitSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *ctx) = 0;

  virtual void enterSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *ctx) = 0;
  virtual void exitSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *ctx) = 0;

  virtual void enterSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *ctx) = 0;
  virtual void exitSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *ctx) = 0;

  virtual void enterSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *ctx) = 0;
  virtual void exitSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *ctx) = 0;

  virtual void enterSupertypeConstraint(ExpressParser::SupertypeConstraintContext *ctx) = 0;
  virtual void exitSupertypeConstraint(ExpressParser::SupertypeConstraintContext *ctx) = 0;

  virtual void enterSupertypeExpression(ExpressParser::SupertypeExpressionContext *ctx) = 0;
  virtual void exitSupertypeExpression(ExpressParser::SupertypeExpressionContext *ctx) = 0;

  virtual void enterSupertypeFactor(ExpressParser::SupertypeFactorContext *ctx) = 0;
  virtual void exitSupertypeFactor(ExpressParser::SupertypeFactorContext *ctx) = 0;

  virtual void enterSupertypeRule(ExpressParser::SupertypeRuleContext *ctx) = 0;
  virtual void exitSupertypeRule(ExpressParser::SupertypeRuleContext *ctx) = 0;

  virtual void enterSupertypeTerm(ExpressParser::SupertypeTermContext *ctx) = 0;
  virtual void exitSupertypeTerm(ExpressParser::SupertypeTermContext *ctx) = 0;

  virtual void enterSyntax(ExpressParser::SyntaxContext *ctx) = 0;
  virtual void exitSyntax(ExpressParser::SyntaxContext *ctx) = 0;

  virtual void enterTerm(ExpressParser::TermContext *ctx) = 0;
  virtual void exitTerm(ExpressParser::TermContext *ctx) = 0;

  virtual void enterTotalOver(ExpressParser::TotalOverContext *ctx) = 0;
  virtual void exitTotalOver(ExpressParser::TotalOverContext *ctx) = 0;

  virtual void enterTypeDecl(ExpressParser::TypeDeclContext *ctx) = 0;
  virtual void exitTypeDecl(ExpressParser::TypeDeclContext *ctx) = 0;

  virtual void enterTypeId(ExpressParser::TypeIdContext *ctx) = 0;
  virtual void exitTypeId(ExpressParser::TypeIdContext *ctx) = 0;

  virtual void enterTypeLabel(ExpressParser::TypeLabelContext *ctx) = 0;
  virtual void exitTypeLabel(ExpressParser::TypeLabelContext *ctx) = 0;

  virtual void enterTypeLabelId(ExpressParser::TypeLabelIdContext *ctx) = 0;
  virtual void exitTypeLabelId(ExpressParser::TypeLabelIdContext *ctx) = 0;

  virtual void enterUnaryOp(ExpressParser::UnaryOpContext *ctx) = 0;
  virtual void exitUnaryOp(ExpressParser::UnaryOpContext *ctx) = 0;

  virtual void enterUnderlyingType(ExpressParser::UnderlyingTypeContext *ctx) = 0;
  virtual void exitUnderlyingType(ExpressParser::UnderlyingTypeContext *ctx) = 0;

  virtual void enterUniqueClause(ExpressParser::UniqueClauseContext *ctx) = 0;
  virtual void exitUniqueClause(ExpressParser::UniqueClauseContext *ctx) = 0;

  virtual void enterUniqueRule(ExpressParser::UniqueRuleContext *ctx) = 0;
  virtual void exitUniqueRule(ExpressParser::UniqueRuleContext *ctx) = 0;

  virtual void enterUntilControl(ExpressParser::UntilControlContext *ctx) = 0;
  virtual void exitUntilControl(ExpressParser::UntilControlContext *ctx) = 0;

  virtual void enterUseClause(ExpressParser::UseClauseContext *ctx) = 0;
  virtual void exitUseClause(ExpressParser::UseClauseContext *ctx) = 0;

  virtual void enterVariableId(ExpressParser::VariableIdContext *ctx) = 0;
  virtual void exitVariableId(ExpressParser::VariableIdContext *ctx) = 0;

  virtual void enterWhereClause(ExpressParser::WhereClauseContext *ctx) = 0;
  virtual void exitWhereClause(ExpressParser::WhereClauseContext *ctx) = 0;

  virtual void enterWhileControl(ExpressParser::WhileControlContext *ctx) = 0;
  virtual void exitWhileControl(ExpressParser::WhileControlContext *ctx) = 0;

  virtual void enterWidth(ExpressParser::WidthContext *ctx) = 0;
  virtual void exitWidth(ExpressParser::WidthContext *ctx) = 0;

  virtual void enterWidthSpec(ExpressParser::WidthSpecContext *ctx) = 0;
  virtual void exitWidthSpec(ExpressParser::WidthSpecContext *ctx) = 0;


};

