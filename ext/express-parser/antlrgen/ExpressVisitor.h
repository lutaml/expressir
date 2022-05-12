
// Generated from Express.g4 by ANTLR 4.10.1

#pragma once


#include "antlr4-runtime.h"
#include "ExpressParser.h"



/**
 * This class defines an abstract visitor for a parse tree
 * produced by ExpressParser.
 */
class  ExpressVisitor : public antlr4::tree::AbstractParseTreeVisitor {
public:

  /**
   * Visit parse trees produced by ExpressParser.
   */
    virtual std::any visitAttributeRef(ExpressParser::AttributeRefContext *context) = 0;

    virtual std::any visitConstantRef(ExpressParser::ConstantRefContext *context) = 0;

    virtual std::any visitEntityRef(ExpressParser::EntityRefContext *context) = 0;

    virtual std::any visitEnumerationRef(ExpressParser::EnumerationRefContext *context) = 0;

    virtual std::any visitFunctionRef(ExpressParser::FunctionRefContext *context) = 0;

    virtual std::any visitParameterRef(ExpressParser::ParameterRefContext *context) = 0;

    virtual std::any visitProcedureRef(ExpressParser::ProcedureRefContext *context) = 0;

    virtual std::any visitRuleLabelRef(ExpressParser::RuleLabelRefContext *context) = 0;

    virtual std::any visitRuleRef(ExpressParser::RuleRefContext *context) = 0;

    virtual std::any visitSchemaRef(ExpressParser::SchemaRefContext *context) = 0;

    virtual std::any visitSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *context) = 0;

    virtual std::any visitTypeLabelRef(ExpressParser::TypeLabelRefContext *context) = 0;

    virtual std::any visitTypeRef(ExpressParser::TypeRefContext *context) = 0;

    virtual std::any visitVariableRef(ExpressParser::VariableRefContext *context) = 0;

    virtual std::any visitAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *context) = 0;

    virtual std::any visitAbstractSupertype(ExpressParser::AbstractSupertypeContext *context) = 0;

    virtual std::any visitAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *context) = 0;

    virtual std::any visitActualParameterList(ExpressParser::ActualParameterListContext *context) = 0;

    virtual std::any visitAddLikeOp(ExpressParser::AddLikeOpContext *context) = 0;

    virtual std::any visitAggregateInitializer(ExpressParser::AggregateInitializerContext *context) = 0;

    virtual std::any visitAggregateSource(ExpressParser::AggregateSourceContext *context) = 0;

    virtual std::any visitAggregateType(ExpressParser::AggregateTypeContext *context) = 0;

    virtual std::any visitAggregationTypes(ExpressParser::AggregationTypesContext *context) = 0;

    virtual std::any visitAlgorithmHead(ExpressParser::AlgorithmHeadContext *context) = 0;

    virtual std::any visitAliasStmt(ExpressParser::AliasStmtContext *context) = 0;

    virtual std::any visitArrayType(ExpressParser::ArrayTypeContext *context) = 0;

    virtual std::any visitAssignmentStmt(ExpressParser::AssignmentStmtContext *context) = 0;

    virtual std::any visitAttributeDecl(ExpressParser::AttributeDeclContext *context) = 0;

    virtual std::any visitAttributeId(ExpressParser::AttributeIdContext *context) = 0;

    virtual std::any visitAttributeQualifier(ExpressParser::AttributeQualifierContext *context) = 0;

    virtual std::any visitBagType(ExpressParser::BagTypeContext *context) = 0;

    virtual std::any visitBinaryType(ExpressParser::BinaryTypeContext *context) = 0;

    virtual std::any visitBooleanType(ExpressParser::BooleanTypeContext *context) = 0;

    virtual std::any visitBound1(ExpressParser::Bound1Context *context) = 0;

    virtual std::any visitBound2(ExpressParser::Bound2Context *context) = 0;

    virtual std::any visitBoundSpec(ExpressParser::BoundSpecContext *context) = 0;

    virtual std::any visitBuiltInConstant(ExpressParser::BuiltInConstantContext *context) = 0;

    virtual std::any visitBuiltInFunction(ExpressParser::BuiltInFunctionContext *context) = 0;

    virtual std::any visitBuiltInProcedure(ExpressParser::BuiltInProcedureContext *context) = 0;

    virtual std::any visitCaseAction(ExpressParser::CaseActionContext *context) = 0;

    virtual std::any visitCaseLabel(ExpressParser::CaseLabelContext *context) = 0;

    virtual std::any visitCaseStmt(ExpressParser::CaseStmtContext *context) = 0;

    virtual std::any visitCompoundStmt(ExpressParser::CompoundStmtContext *context) = 0;

    virtual std::any visitConcreteTypes(ExpressParser::ConcreteTypesContext *context) = 0;

    virtual std::any visitConstantBody(ExpressParser::ConstantBodyContext *context) = 0;

    virtual std::any visitConstantDecl(ExpressParser::ConstantDeclContext *context) = 0;

    virtual std::any visitConstantFactor(ExpressParser::ConstantFactorContext *context) = 0;

    virtual std::any visitConstantId(ExpressParser::ConstantIdContext *context) = 0;

    virtual std::any visitConstructedTypes(ExpressParser::ConstructedTypesContext *context) = 0;

    virtual std::any visitDeclaration(ExpressParser::DeclarationContext *context) = 0;

    virtual std::any visitDerivedAttr(ExpressParser::DerivedAttrContext *context) = 0;

    virtual std::any visitDeriveClause(ExpressParser::DeriveClauseContext *context) = 0;

    virtual std::any visitDomainRule(ExpressParser::DomainRuleContext *context) = 0;

    virtual std::any visitElement(ExpressParser::ElementContext *context) = 0;

    virtual std::any visitEntityBody(ExpressParser::EntityBodyContext *context) = 0;

    virtual std::any visitEntityConstructor(ExpressParser::EntityConstructorContext *context) = 0;

    virtual std::any visitEntityDecl(ExpressParser::EntityDeclContext *context) = 0;

    virtual std::any visitEntityHead(ExpressParser::EntityHeadContext *context) = 0;

    virtual std::any visitEntityId(ExpressParser::EntityIdContext *context) = 0;

    virtual std::any visitEnumerationExtension(ExpressParser::EnumerationExtensionContext *context) = 0;

    virtual std::any visitEnumerationId(ExpressParser::EnumerationIdContext *context) = 0;

    virtual std::any visitEnumerationItems(ExpressParser::EnumerationItemsContext *context) = 0;

    virtual std::any visitEnumerationItem(ExpressParser::EnumerationItemContext *context) = 0;

    virtual std::any visitEnumerationReference(ExpressParser::EnumerationReferenceContext *context) = 0;

    virtual std::any visitEnumerationType(ExpressParser::EnumerationTypeContext *context) = 0;

    virtual std::any visitEscapeStmt(ExpressParser::EscapeStmtContext *context) = 0;

    virtual std::any visitExplicitAttr(ExpressParser::ExplicitAttrContext *context) = 0;

    virtual std::any visitExpression(ExpressParser::ExpressionContext *context) = 0;

    virtual std::any visitFactor(ExpressParser::FactorContext *context) = 0;

    virtual std::any visitFormalParameter(ExpressParser::FormalParameterContext *context) = 0;

    virtual std::any visitFunctionCall(ExpressParser::FunctionCallContext *context) = 0;

    virtual std::any visitFunctionDecl(ExpressParser::FunctionDeclContext *context) = 0;

    virtual std::any visitFunctionHead(ExpressParser::FunctionHeadContext *context) = 0;

    virtual std::any visitFunctionId(ExpressParser::FunctionIdContext *context) = 0;

    virtual std::any visitGeneralizedTypes(ExpressParser::GeneralizedTypesContext *context) = 0;

    virtual std::any visitGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *context) = 0;

    virtual std::any visitGeneralArrayType(ExpressParser::GeneralArrayTypeContext *context) = 0;

    virtual std::any visitGeneralBagType(ExpressParser::GeneralBagTypeContext *context) = 0;

    virtual std::any visitGeneralListType(ExpressParser::GeneralListTypeContext *context) = 0;

    virtual std::any visitGeneralRef(ExpressParser::GeneralRefContext *context) = 0;

    virtual std::any visitGeneralSetType(ExpressParser::GeneralSetTypeContext *context) = 0;

    virtual std::any visitGenericEntityType(ExpressParser::GenericEntityTypeContext *context) = 0;

    virtual std::any visitGenericType(ExpressParser::GenericTypeContext *context) = 0;

    virtual std::any visitGroupQualifier(ExpressParser::GroupQualifierContext *context) = 0;

    virtual std::any visitIfStmt(ExpressParser::IfStmtContext *context) = 0;

    virtual std::any visitIfStmtStatements(ExpressParser::IfStmtStatementsContext *context) = 0;

    virtual std::any visitIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *context) = 0;

    virtual std::any visitIncrement(ExpressParser::IncrementContext *context) = 0;

    virtual std::any visitIncrementControl(ExpressParser::IncrementControlContext *context) = 0;

    virtual std::any visitIndex(ExpressParser::IndexContext *context) = 0;

    virtual std::any visitIndex1(ExpressParser::Index1Context *context) = 0;

    virtual std::any visitIndex2(ExpressParser::Index2Context *context) = 0;

    virtual std::any visitIndexQualifier(ExpressParser::IndexQualifierContext *context) = 0;

    virtual std::any visitInstantiableType(ExpressParser::InstantiableTypeContext *context) = 0;

    virtual std::any visitIntegerType(ExpressParser::IntegerTypeContext *context) = 0;

    virtual std::any visitInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *context) = 0;

    virtual std::any visitInterval(ExpressParser::IntervalContext *context) = 0;

    virtual std::any visitIntervalHigh(ExpressParser::IntervalHighContext *context) = 0;

    virtual std::any visitIntervalItem(ExpressParser::IntervalItemContext *context) = 0;

    virtual std::any visitIntervalLow(ExpressParser::IntervalLowContext *context) = 0;

    virtual std::any visitIntervalOp(ExpressParser::IntervalOpContext *context) = 0;

    virtual std::any visitInverseAttr(ExpressParser::InverseAttrContext *context) = 0;

    virtual std::any visitInverseAttrType(ExpressParser::InverseAttrTypeContext *context) = 0;

    virtual std::any visitInverseClause(ExpressParser::InverseClauseContext *context) = 0;

    virtual std::any visitListType(ExpressParser::ListTypeContext *context) = 0;

    virtual std::any visitLiteral(ExpressParser::LiteralContext *context) = 0;

    virtual std::any visitLocalDecl(ExpressParser::LocalDeclContext *context) = 0;

    virtual std::any visitLocalVariable(ExpressParser::LocalVariableContext *context) = 0;

    virtual std::any visitLogicalExpression(ExpressParser::LogicalExpressionContext *context) = 0;

    virtual std::any visitLogicalLiteral(ExpressParser::LogicalLiteralContext *context) = 0;

    virtual std::any visitLogicalType(ExpressParser::LogicalTypeContext *context) = 0;

    virtual std::any visitMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *context) = 0;

    virtual std::any visitNamedTypes(ExpressParser::NamedTypesContext *context) = 0;

    virtual std::any visitNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *context) = 0;

    virtual std::any visitNullStmt(ExpressParser::NullStmtContext *context) = 0;

    virtual std::any visitNumberType(ExpressParser::NumberTypeContext *context) = 0;

    virtual std::any visitNumericExpression(ExpressParser::NumericExpressionContext *context) = 0;

    virtual std::any visitOneOf(ExpressParser::OneOfContext *context) = 0;

    virtual std::any visitParameter(ExpressParser::ParameterContext *context) = 0;

    virtual std::any visitParameterId(ExpressParser::ParameterIdContext *context) = 0;

    virtual std::any visitParameterType(ExpressParser::ParameterTypeContext *context) = 0;

    virtual std::any visitPopulation(ExpressParser::PopulationContext *context) = 0;

    virtual std::any visitPrecisionSpec(ExpressParser::PrecisionSpecContext *context) = 0;

    virtual std::any visitPrimary(ExpressParser::PrimaryContext *context) = 0;

    virtual std::any visitProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *context) = 0;

    virtual std::any visitProcedureDecl(ExpressParser::ProcedureDeclContext *context) = 0;

    virtual std::any visitProcedureHead(ExpressParser::ProcedureHeadContext *context) = 0;

    virtual std::any visitProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *context) = 0;

    virtual std::any visitProcedureId(ExpressParser::ProcedureIdContext *context) = 0;

    virtual std::any visitQualifiableFactor(ExpressParser::QualifiableFactorContext *context) = 0;

    virtual std::any visitQualifiedAttribute(ExpressParser::QualifiedAttributeContext *context) = 0;

    virtual std::any visitQualifier(ExpressParser::QualifierContext *context) = 0;

    virtual std::any visitQueryExpression(ExpressParser::QueryExpressionContext *context) = 0;

    virtual std::any visitRealType(ExpressParser::RealTypeContext *context) = 0;

    virtual std::any visitRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *context) = 0;

    virtual std::any visitReferencedAttribute(ExpressParser::ReferencedAttributeContext *context) = 0;

    virtual std::any visitReferenceClause(ExpressParser::ReferenceClauseContext *context) = 0;

    virtual std::any visitRelOp(ExpressParser::RelOpContext *context) = 0;

    virtual std::any visitRelOpExtended(ExpressParser::RelOpExtendedContext *context) = 0;

    virtual std::any visitRenameId(ExpressParser::RenameIdContext *context) = 0;

    virtual std::any visitRepeatControl(ExpressParser::RepeatControlContext *context) = 0;

    virtual std::any visitRepeatStmt(ExpressParser::RepeatStmtContext *context) = 0;

    virtual std::any visitRepetition(ExpressParser::RepetitionContext *context) = 0;

    virtual std::any visitResourceOrRename(ExpressParser::ResourceOrRenameContext *context) = 0;

    virtual std::any visitResourceRef(ExpressParser::ResourceRefContext *context) = 0;

    virtual std::any visitReturnStmt(ExpressParser::ReturnStmtContext *context) = 0;

    virtual std::any visitRuleDecl(ExpressParser::RuleDeclContext *context) = 0;

    virtual std::any visitRuleHead(ExpressParser::RuleHeadContext *context) = 0;

    virtual std::any visitRuleId(ExpressParser::RuleIdContext *context) = 0;

    virtual std::any visitRuleLabelId(ExpressParser::RuleLabelIdContext *context) = 0;

    virtual std::any visitSchemaBody(ExpressParser::SchemaBodyContext *context) = 0;

    virtual std::any visitSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *context) = 0;

    virtual std::any visitSchemaDecl(ExpressParser::SchemaDeclContext *context) = 0;

    virtual std::any visitSchemaId(ExpressParser::SchemaIdContext *context) = 0;

    virtual std::any visitSchemaVersionId(ExpressParser::SchemaVersionIdContext *context) = 0;

    virtual std::any visitSelector(ExpressParser::SelectorContext *context) = 0;

    virtual std::any visitSelectExtension(ExpressParser::SelectExtensionContext *context) = 0;

    virtual std::any visitSelectList(ExpressParser::SelectListContext *context) = 0;

    virtual std::any visitSelectType(ExpressParser::SelectTypeContext *context) = 0;

    virtual std::any visitSetType(ExpressParser::SetTypeContext *context) = 0;

    virtual std::any visitSimpleExpression(ExpressParser::SimpleExpressionContext *context) = 0;

    virtual std::any visitSimpleFactor(ExpressParser::SimpleFactorContext *context) = 0;

    virtual std::any visitSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *context) = 0;

    virtual std::any visitSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *context) = 0;

    virtual std::any visitSimpleTypes(ExpressParser::SimpleTypesContext *context) = 0;

    virtual std::any visitSkipStmt(ExpressParser::SkipStmtContext *context) = 0;

    virtual std::any visitStmt(ExpressParser::StmtContext *context) = 0;

    virtual std::any visitStringLiteral(ExpressParser::StringLiteralContext *context) = 0;

    virtual std::any visitStringType(ExpressParser::StringTypeContext *context) = 0;

    virtual std::any visitSubsuper(ExpressParser::SubsuperContext *context) = 0;

    virtual std::any visitSubtypeConstraint(ExpressParser::SubtypeConstraintContext *context) = 0;

    virtual std::any visitSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *context) = 0;

    virtual std::any visitSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *context) = 0;

    virtual std::any visitSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *context) = 0;

    virtual std::any visitSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *context) = 0;

    virtual std::any visitSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *context) = 0;

    virtual std::any visitSupertypeConstraint(ExpressParser::SupertypeConstraintContext *context) = 0;

    virtual std::any visitSupertypeExpression(ExpressParser::SupertypeExpressionContext *context) = 0;

    virtual std::any visitSupertypeFactor(ExpressParser::SupertypeFactorContext *context) = 0;

    virtual std::any visitSupertypeRule(ExpressParser::SupertypeRuleContext *context) = 0;

    virtual std::any visitSupertypeTerm(ExpressParser::SupertypeTermContext *context) = 0;

    virtual std::any visitSyntax(ExpressParser::SyntaxContext *context) = 0;

    virtual std::any visitTerm(ExpressParser::TermContext *context) = 0;

    virtual std::any visitTotalOver(ExpressParser::TotalOverContext *context) = 0;

    virtual std::any visitTypeDecl(ExpressParser::TypeDeclContext *context) = 0;

    virtual std::any visitTypeId(ExpressParser::TypeIdContext *context) = 0;

    virtual std::any visitTypeLabel(ExpressParser::TypeLabelContext *context) = 0;

    virtual std::any visitTypeLabelId(ExpressParser::TypeLabelIdContext *context) = 0;

    virtual std::any visitUnaryOp(ExpressParser::UnaryOpContext *context) = 0;

    virtual std::any visitUnderlyingType(ExpressParser::UnderlyingTypeContext *context) = 0;

    virtual std::any visitUniqueClause(ExpressParser::UniqueClauseContext *context) = 0;

    virtual std::any visitUniqueRule(ExpressParser::UniqueRuleContext *context) = 0;

    virtual std::any visitUntilControl(ExpressParser::UntilControlContext *context) = 0;

    virtual std::any visitUseClause(ExpressParser::UseClauseContext *context) = 0;

    virtual std::any visitVariableId(ExpressParser::VariableIdContext *context) = 0;

    virtual std::any visitWhereClause(ExpressParser::WhereClauseContext *context) = 0;

    virtual std::any visitWhileControl(ExpressParser::WhileControlContext *context) = 0;

    virtual std::any visitWidth(ExpressParser::WidthContext *context) = 0;

    virtual std::any visitWidthSpec(ExpressParser::WidthSpecContext *context) = 0;


};

