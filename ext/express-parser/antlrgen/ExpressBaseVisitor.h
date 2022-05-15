
// Generated from Express.g4 by ANTLR 4.10.1

#pragma once


#include "antlr4-runtime.h"
#include "ExpressVisitor.h"


/**
 * This class provides an empty implementation of ExpressVisitor, which can be
 * extended to create a visitor which only needs to handle a subset of the available methods.
 */
class  ExpressBaseVisitor : public ExpressVisitor {
public:

  virtual std::any visitAttributeRef(ExpressParser::AttributeRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstantRef(ExpressParser::ConstantRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityRef(ExpressParser::EntityRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationRef(ExpressParser::EnumerationRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunctionRef(ExpressParser::FunctionRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitParameterRef(ExpressParser::ParameterRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureRef(ExpressParser::ProcedureRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleLabelRef(ExpressParser::RuleLabelRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleRef(ExpressParser::RuleRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaRef(ExpressParser::SchemaRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeLabelRef(ExpressParser::TypeLabelRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeRef(ExpressParser::TypeRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitVariableRef(ExpressParser::VariableRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAbstractSupertype(ExpressParser::AbstractSupertypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitActualParameterList(ExpressParser::ActualParameterListContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAddLikeOp(ExpressParser::AddLikeOpContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAggregateInitializer(ExpressParser::AggregateInitializerContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAggregateSource(ExpressParser::AggregateSourceContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAggregateType(ExpressParser::AggregateTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAggregationTypes(ExpressParser::AggregationTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAlgorithmHead(ExpressParser::AlgorithmHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAliasStmt(ExpressParser::AliasStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitArrayType(ExpressParser::ArrayTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAssignmentStmt(ExpressParser::AssignmentStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAttributeDecl(ExpressParser::AttributeDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAttributeId(ExpressParser::AttributeIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAttributeQualifier(ExpressParser::AttributeQualifierContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBagType(ExpressParser::BagTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBinaryType(ExpressParser::BinaryTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBooleanType(ExpressParser::BooleanTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBound1(ExpressParser::Bound1Context *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBound2(ExpressParser::Bound2Context *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBoundSpec(ExpressParser::BoundSpecContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBuiltInConstant(ExpressParser::BuiltInConstantContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBuiltInFunction(ExpressParser::BuiltInFunctionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBuiltInProcedure(ExpressParser::BuiltInProcedureContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitCaseAction(ExpressParser::CaseActionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitCaseLabel(ExpressParser::CaseLabelContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitCaseStmt(ExpressParser::CaseStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitCompoundStmt(ExpressParser::CompoundStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConcreteTypes(ExpressParser::ConcreteTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstantBody(ExpressParser::ConstantBodyContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstantDecl(ExpressParser::ConstantDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstantFactor(ExpressParser::ConstantFactorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstantId(ExpressParser::ConstantIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitConstructedTypes(ExpressParser::ConstructedTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDeclaration(ExpressParser::DeclarationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDerivedAttr(ExpressParser::DerivedAttrContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDeriveClause(ExpressParser::DeriveClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDomainRule(ExpressParser::DomainRuleContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitElement(ExpressParser::ElementContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityBody(ExpressParser::EntityBodyContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityConstructor(ExpressParser::EntityConstructorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityDecl(ExpressParser::EntityDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityHead(ExpressParser::EntityHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEntityId(ExpressParser::EntityIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationExtension(ExpressParser::EnumerationExtensionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationId(ExpressParser::EnumerationIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationItems(ExpressParser::EnumerationItemsContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationItem(ExpressParser::EnumerationItemContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationReference(ExpressParser::EnumerationReferenceContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEnumerationType(ExpressParser::EnumerationTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitEscapeStmt(ExpressParser::EscapeStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitExplicitAttr(ExpressParser::ExplicitAttrContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitExpression(ExpressParser::ExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFactor(ExpressParser::FactorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFormalParameter(ExpressParser::FormalParameterContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunctionCall(ExpressParser::FunctionCallContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunctionDecl(ExpressParser::FunctionDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunctionHead(ExpressParser::FunctionHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunctionId(ExpressParser::FunctionIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralizedTypes(ExpressParser::GeneralizedTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralArrayType(ExpressParser::GeneralArrayTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralBagType(ExpressParser::GeneralBagTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralListType(ExpressParser::GeneralListTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralRef(ExpressParser::GeneralRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGeneralSetType(ExpressParser::GeneralSetTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGenericEntityType(ExpressParser::GenericEntityTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGenericType(ExpressParser::GenericTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGroupQualifier(ExpressParser::GroupQualifierContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIfStmt(ExpressParser::IfStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIfStmtStatements(ExpressParser::IfStmtStatementsContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIncrement(ExpressParser::IncrementContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIncrementControl(ExpressParser::IncrementControlContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIndex(ExpressParser::IndexContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIndex1(ExpressParser::Index1Context *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIndex2(ExpressParser::Index2Context *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIndexQualifier(ExpressParser::IndexQualifierContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInstantiableType(ExpressParser::InstantiableTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIntegerType(ExpressParser::IntegerTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInterval(ExpressParser::IntervalContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIntervalHigh(ExpressParser::IntervalHighContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIntervalItem(ExpressParser::IntervalItemContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIntervalLow(ExpressParser::IntervalLowContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIntervalOp(ExpressParser::IntervalOpContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInverseAttr(ExpressParser::InverseAttrContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInverseAttrType(ExpressParser::InverseAttrTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInverseClause(ExpressParser::InverseClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitListType(ExpressParser::ListTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLiteral(ExpressParser::LiteralContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLocalDecl(ExpressParser::LocalDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLocalVariable(ExpressParser::LocalVariableContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLogicalExpression(ExpressParser::LogicalExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLogicalLiteral(ExpressParser::LogicalLiteralContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLogicalType(ExpressParser::LogicalTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNamedTypes(ExpressParser::NamedTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNullStmt(ExpressParser::NullStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNumberType(ExpressParser::NumberTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNumericExpression(ExpressParser::NumericExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitOneOf(ExpressParser::OneOfContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitParameter(ExpressParser::ParameterContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitParameterId(ExpressParser::ParameterIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitParameterType(ExpressParser::ParameterTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitPopulation(ExpressParser::PopulationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitPrecisionSpec(ExpressParser::PrecisionSpecContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitPrimary(ExpressParser::PrimaryContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureDecl(ExpressParser::ProcedureDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureHead(ExpressParser::ProcedureHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitProcedureId(ExpressParser::ProcedureIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitQualifiableFactor(ExpressParser::QualifiableFactorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitQualifiedAttribute(ExpressParser::QualifiedAttributeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitQualifier(ExpressParser::QualifierContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitQueryExpression(ExpressParser::QueryExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRealType(ExpressParser::RealTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitReferencedAttribute(ExpressParser::ReferencedAttributeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitReferenceClause(ExpressParser::ReferenceClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRelOp(ExpressParser::RelOpContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRelOpExtended(ExpressParser::RelOpExtendedContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRenameId(ExpressParser::RenameIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRepeatControl(ExpressParser::RepeatControlContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRepeatStmt(ExpressParser::RepeatStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRepetition(ExpressParser::RepetitionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitResourceOrRename(ExpressParser::ResourceOrRenameContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitResourceRef(ExpressParser::ResourceRefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitReturnStmt(ExpressParser::ReturnStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleDecl(ExpressParser::RuleDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleHead(ExpressParser::RuleHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleId(ExpressParser::RuleIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRuleLabelId(ExpressParser::RuleLabelIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaBody(ExpressParser::SchemaBodyContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaDecl(ExpressParser::SchemaDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaId(ExpressParser::SchemaIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSchemaVersionId(ExpressParser::SchemaVersionIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSelector(ExpressParser::SelectorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSelectExtension(ExpressParser::SelectExtensionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSelectList(ExpressParser::SelectListContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSelectType(ExpressParser::SelectTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSetType(ExpressParser::SetTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSimpleExpression(ExpressParser::SimpleExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSimpleFactor(ExpressParser::SimpleFactorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSimpleTypes(ExpressParser::SimpleTypesContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSkipStmt(ExpressParser::SkipStmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitStmt(ExpressParser::StmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitStringLiteral(ExpressParser::StringLiteralContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitStringType(ExpressParser::StringTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubsuper(ExpressParser::SubsuperContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraint(ExpressParser::SubtypeConstraintContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSupertypeConstraint(ExpressParser::SupertypeConstraintContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSupertypeExpression(ExpressParser::SupertypeExpressionContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSupertypeFactor(ExpressParser::SupertypeFactorContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSupertypeRule(ExpressParser::SupertypeRuleContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSupertypeTerm(ExpressParser::SupertypeTermContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSyntax(ExpressParser::SyntaxContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTerm(ExpressParser::TermContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTotalOver(ExpressParser::TotalOverContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeDecl(ExpressParser::TypeDeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeId(ExpressParser::TypeIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeLabel(ExpressParser::TypeLabelContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypeLabelId(ExpressParser::TypeLabelIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUnaryOp(ExpressParser::UnaryOpContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUnderlyingType(ExpressParser::UnderlyingTypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUniqueClause(ExpressParser::UniqueClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUniqueRule(ExpressParser::UniqueRuleContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUntilControl(ExpressParser::UntilControlContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitUseClause(ExpressParser::UseClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitVariableId(ExpressParser::VariableIdContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitWhereClause(ExpressParser::WhereClauseContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitWhileControl(ExpressParser::WhileControlContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitWidth(ExpressParser::WidthContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitWidthSpec(ExpressParser::WidthSpecContext *ctx) override {
    return visitChildren(ctx);
  }


};

