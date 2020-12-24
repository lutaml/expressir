
// Generated from Express.g4 by ANTLR 4.8

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
    virtual antlrcpp::Any visitAttributeRef(ExpressParser::AttributeRefContext *context) = 0;

    virtual antlrcpp::Any visitConstantRef(ExpressParser::ConstantRefContext *context) = 0;

    virtual antlrcpp::Any visitEntityRef(ExpressParser::EntityRefContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationRef(ExpressParser::EnumerationRefContext *context) = 0;

    virtual antlrcpp::Any visitFunctionRef(ExpressParser::FunctionRefContext *context) = 0;

    virtual antlrcpp::Any visitParameterRef(ExpressParser::ParameterRefContext *context) = 0;

    virtual antlrcpp::Any visitProcedureRef(ExpressParser::ProcedureRefContext *context) = 0;

    virtual antlrcpp::Any visitRuleLabelRef(ExpressParser::RuleLabelRefContext *context) = 0;

    virtual antlrcpp::Any visitRuleRef(ExpressParser::RuleRefContext *context) = 0;

    virtual antlrcpp::Any visitSchemaRef(ExpressParser::SchemaRefContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *context) = 0;

    virtual antlrcpp::Any visitTypeLabelRef(ExpressParser::TypeLabelRefContext *context) = 0;

    virtual antlrcpp::Any visitTypeRef(ExpressParser::TypeRefContext *context) = 0;

    virtual antlrcpp::Any visitVariableRef(ExpressParser::VariableRefContext *context) = 0;

    virtual antlrcpp::Any visitAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitAbstractSupertype(ExpressParser::AbstractSupertypeContext *context) = 0;

    virtual antlrcpp::Any visitAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitActualParameterList(ExpressParser::ActualParameterListContext *context) = 0;

    virtual antlrcpp::Any visitAddLikeOp(ExpressParser::AddLikeOpContext *context) = 0;

    virtual antlrcpp::Any visitAggregateInitializer(ExpressParser::AggregateInitializerContext *context) = 0;

    virtual antlrcpp::Any visitAggregateSource(ExpressParser::AggregateSourceContext *context) = 0;

    virtual antlrcpp::Any visitAggregateType(ExpressParser::AggregateTypeContext *context) = 0;

    virtual antlrcpp::Any visitAggregationTypes(ExpressParser::AggregationTypesContext *context) = 0;

    virtual antlrcpp::Any visitAlgorithmHead(ExpressParser::AlgorithmHeadContext *context) = 0;

    virtual antlrcpp::Any visitAliasStmt(ExpressParser::AliasStmtContext *context) = 0;

    virtual antlrcpp::Any visitArrayType(ExpressParser::ArrayTypeContext *context) = 0;

    virtual antlrcpp::Any visitAssignmentStmt(ExpressParser::AssignmentStmtContext *context) = 0;

    virtual antlrcpp::Any visitAttributeDecl(ExpressParser::AttributeDeclContext *context) = 0;

    virtual antlrcpp::Any visitAttributeId(ExpressParser::AttributeIdContext *context) = 0;

    virtual antlrcpp::Any visitAttributeQualifier(ExpressParser::AttributeQualifierContext *context) = 0;

    virtual antlrcpp::Any visitBagType(ExpressParser::BagTypeContext *context) = 0;

    virtual antlrcpp::Any visitBinaryType(ExpressParser::BinaryTypeContext *context) = 0;

    virtual antlrcpp::Any visitBooleanType(ExpressParser::BooleanTypeContext *context) = 0;

    virtual antlrcpp::Any visitBound1(ExpressParser::Bound1Context *context) = 0;

    virtual antlrcpp::Any visitBound2(ExpressParser::Bound2Context *context) = 0;

    virtual antlrcpp::Any visitBoundSpec(ExpressParser::BoundSpecContext *context) = 0;

    virtual antlrcpp::Any visitBuiltInConstant(ExpressParser::BuiltInConstantContext *context) = 0;

    virtual antlrcpp::Any visitBuiltInFunction(ExpressParser::BuiltInFunctionContext *context) = 0;

    virtual antlrcpp::Any visitBuiltInProcedure(ExpressParser::BuiltInProcedureContext *context) = 0;

    virtual antlrcpp::Any visitCaseAction(ExpressParser::CaseActionContext *context) = 0;

    virtual antlrcpp::Any visitCaseLabel(ExpressParser::CaseLabelContext *context) = 0;

    virtual antlrcpp::Any visitCaseStmt(ExpressParser::CaseStmtContext *context) = 0;

    virtual antlrcpp::Any visitCompoundStmt(ExpressParser::CompoundStmtContext *context) = 0;

    virtual antlrcpp::Any visitConcreteTypes(ExpressParser::ConcreteTypesContext *context) = 0;

    virtual antlrcpp::Any visitConstantBody(ExpressParser::ConstantBodyContext *context) = 0;

    virtual antlrcpp::Any visitConstantDecl(ExpressParser::ConstantDeclContext *context) = 0;

    virtual antlrcpp::Any visitConstantFactor(ExpressParser::ConstantFactorContext *context) = 0;

    virtual antlrcpp::Any visitConstantId(ExpressParser::ConstantIdContext *context) = 0;

    virtual antlrcpp::Any visitConstructedTypes(ExpressParser::ConstructedTypesContext *context) = 0;

    virtual antlrcpp::Any visitDeclaration(ExpressParser::DeclarationContext *context) = 0;

    virtual antlrcpp::Any visitDerivedAttr(ExpressParser::DerivedAttrContext *context) = 0;

    virtual antlrcpp::Any visitDeriveClause(ExpressParser::DeriveClauseContext *context) = 0;

    virtual antlrcpp::Any visitDomainRule(ExpressParser::DomainRuleContext *context) = 0;

    virtual antlrcpp::Any visitElement(ExpressParser::ElementContext *context) = 0;

    virtual antlrcpp::Any visitEntityBody(ExpressParser::EntityBodyContext *context) = 0;

    virtual antlrcpp::Any visitEntityConstructor(ExpressParser::EntityConstructorContext *context) = 0;

    virtual antlrcpp::Any visitEntityDecl(ExpressParser::EntityDeclContext *context) = 0;

    virtual antlrcpp::Any visitEntityHead(ExpressParser::EntityHeadContext *context) = 0;

    virtual antlrcpp::Any visitEntityId(ExpressParser::EntityIdContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationExtension(ExpressParser::EnumerationExtensionContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationId(ExpressParser::EnumerationIdContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationItems(ExpressParser::EnumerationItemsContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationItem(ExpressParser::EnumerationItemContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationReference(ExpressParser::EnumerationReferenceContext *context) = 0;

    virtual antlrcpp::Any visitEnumerationType(ExpressParser::EnumerationTypeContext *context) = 0;

    virtual antlrcpp::Any visitEscapeStmt(ExpressParser::EscapeStmtContext *context) = 0;

    virtual antlrcpp::Any visitExplicitAttr(ExpressParser::ExplicitAttrContext *context) = 0;

    virtual antlrcpp::Any visitExpression(ExpressParser::ExpressionContext *context) = 0;

    virtual antlrcpp::Any visitFactor(ExpressParser::FactorContext *context) = 0;

    virtual antlrcpp::Any visitFormalParameter(ExpressParser::FormalParameterContext *context) = 0;

    virtual antlrcpp::Any visitFunctionCall(ExpressParser::FunctionCallContext *context) = 0;

    virtual antlrcpp::Any visitFunctionDecl(ExpressParser::FunctionDeclContext *context) = 0;

    virtual antlrcpp::Any visitFunctionHead(ExpressParser::FunctionHeadContext *context) = 0;

    virtual antlrcpp::Any visitFunctionId(ExpressParser::FunctionIdContext *context) = 0;

    virtual antlrcpp::Any visitGeneralizedTypes(ExpressParser::GeneralizedTypesContext *context) = 0;

    virtual antlrcpp::Any visitGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *context) = 0;

    virtual antlrcpp::Any visitGeneralArrayType(ExpressParser::GeneralArrayTypeContext *context) = 0;

    virtual antlrcpp::Any visitGeneralBagType(ExpressParser::GeneralBagTypeContext *context) = 0;

    virtual antlrcpp::Any visitGeneralListType(ExpressParser::GeneralListTypeContext *context) = 0;

    virtual antlrcpp::Any visitGeneralRef(ExpressParser::GeneralRefContext *context) = 0;

    virtual antlrcpp::Any visitGeneralSetType(ExpressParser::GeneralSetTypeContext *context) = 0;

    virtual antlrcpp::Any visitGenericEntityType(ExpressParser::GenericEntityTypeContext *context) = 0;

    virtual antlrcpp::Any visitGenericType(ExpressParser::GenericTypeContext *context) = 0;

    virtual antlrcpp::Any visitGroupQualifier(ExpressParser::GroupQualifierContext *context) = 0;

    virtual antlrcpp::Any visitIfStmt(ExpressParser::IfStmtContext *context) = 0;

    virtual antlrcpp::Any visitIfStmtStatements(ExpressParser::IfStmtStatementsContext *context) = 0;

    virtual antlrcpp::Any visitIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *context) = 0;

    virtual antlrcpp::Any visitIncrement(ExpressParser::IncrementContext *context) = 0;

    virtual antlrcpp::Any visitIncrementControl(ExpressParser::IncrementControlContext *context) = 0;

    virtual antlrcpp::Any visitIndex(ExpressParser::IndexContext *context) = 0;

    virtual antlrcpp::Any visitIndex1(ExpressParser::Index1Context *context) = 0;

    virtual antlrcpp::Any visitIndex2(ExpressParser::Index2Context *context) = 0;

    virtual antlrcpp::Any visitIndexQualifier(ExpressParser::IndexQualifierContext *context) = 0;

    virtual antlrcpp::Any visitInstantiableType(ExpressParser::InstantiableTypeContext *context) = 0;

    virtual antlrcpp::Any visitIntegerType(ExpressParser::IntegerTypeContext *context) = 0;

    virtual antlrcpp::Any visitInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *context) = 0;

    virtual antlrcpp::Any visitInterval(ExpressParser::IntervalContext *context) = 0;

    virtual antlrcpp::Any visitIntervalHigh(ExpressParser::IntervalHighContext *context) = 0;

    virtual antlrcpp::Any visitIntervalItem(ExpressParser::IntervalItemContext *context) = 0;

    virtual antlrcpp::Any visitIntervalLow(ExpressParser::IntervalLowContext *context) = 0;

    virtual antlrcpp::Any visitIntervalOp(ExpressParser::IntervalOpContext *context) = 0;

    virtual antlrcpp::Any visitInverseAttr(ExpressParser::InverseAttrContext *context) = 0;

    virtual antlrcpp::Any visitInverseAttrType(ExpressParser::InverseAttrTypeContext *context) = 0;

    virtual antlrcpp::Any visitInverseClause(ExpressParser::InverseClauseContext *context) = 0;

    virtual antlrcpp::Any visitListType(ExpressParser::ListTypeContext *context) = 0;

    virtual antlrcpp::Any visitLiteral(ExpressParser::LiteralContext *context) = 0;

    virtual antlrcpp::Any visitLocalDecl(ExpressParser::LocalDeclContext *context) = 0;

    virtual antlrcpp::Any visitLocalVariable(ExpressParser::LocalVariableContext *context) = 0;

    virtual antlrcpp::Any visitLogicalExpression(ExpressParser::LogicalExpressionContext *context) = 0;

    virtual antlrcpp::Any visitLogicalLiteral(ExpressParser::LogicalLiteralContext *context) = 0;

    virtual antlrcpp::Any visitLogicalType(ExpressParser::LogicalTypeContext *context) = 0;

    virtual antlrcpp::Any visitMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *context) = 0;

    virtual antlrcpp::Any visitNamedTypes(ExpressParser::NamedTypesContext *context) = 0;

    virtual antlrcpp::Any visitNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *context) = 0;

    virtual antlrcpp::Any visitNullStmt(ExpressParser::NullStmtContext *context) = 0;

    virtual antlrcpp::Any visitNumberType(ExpressParser::NumberTypeContext *context) = 0;

    virtual antlrcpp::Any visitNumericExpression(ExpressParser::NumericExpressionContext *context) = 0;

    virtual antlrcpp::Any visitOneOf(ExpressParser::OneOfContext *context) = 0;

    virtual antlrcpp::Any visitParameter(ExpressParser::ParameterContext *context) = 0;

    virtual antlrcpp::Any visitParameterId(ExpressParser::ParameterIdContext *context) = 0;

    virtual antlrcpp::Any visitParameterType(ExpressParser::ParameterTypeContext *context) = 0;

    virtual antlrcpp::Any visitPopulation(ExpressParser::PopulationContext *context) = 0;

    virtual antlrcpp::Any visitPrecisionSpec(ExpressParser::PrecisionSpecContext *context) = 0;

    virtual antlrcpp::Any visitPrimary(ExpressParser::PrimaryContext *context) = 0;

    virtual antlrcpp::Any visitProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *context) = 0;

    virtual antlrcpp::Any visitProcedureDecl(ExpressParser::ProcedureDeclContext *context) = 0;

    virtual antlrcpp::Any visitProcedureHead(ExpressParser::ProcedureHeadContext *context) = 0;

    virtual antlrcpp::Any visitProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *context) = 0;

    virtual antlrcpp::Any visitProcedureId(ExpressParser::ProcedureIdContext *context) = 0;

    virtual antlrcpp::Any visitQualifiableFactor(ExpressParser::QualifiableFactorContext *context) = 0;

    virtual antlrcpp::Any visitQualifiedAttribute(ExpressParser::QualifiedAttributeContext *context) = 0;

    virtual antlrcpp::Any visitQualifier(ExpressParser::QualifierContext *context) = 0;

    virtual antlrcpp::Any visitQueryExpression(ExpressParser::QueryExpressionContext *context) = 0;

    virtual antlrcpp::Any visitRealType(ExpressParser::RealTypeContext *context) = 0;

    virtual antlrcpp::Any visitRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *context) = 0;

    virtual antlrcpp::Any visitReferencedAttribute(ExpressParser::ReferencedAttributeContext *context) = 0;

    virtual antlrcpp::Any visitReferenceClause(ExpressParser::ReferenceClauseContext *context) = 0;

    virtual antlrcpp::Any visitRelOp(ExpressParser::RelOpContext *context) = 0;

    virtual antlrcpp::Any visitRelOpExtended(ExpressParser::RelOpExtendedContext *context) = 0;

    virtual antlrcpp::Any visitRenameId(ExpressParser::RenameIdContext *context) = 0;

    virtual antlrcpp::Any visitRepeatControl(ExpressParser::RepeatControlContext *context) = 0;

    virtual antlrcpp::Any visitRepeatStmt(ExpressParser::RepeatStmtContext *context) = 0;

    virtual antlrcpp::Any visitRepetition(ExpressParser::RepetitionContext *context) = 0;

    virtual antlrcpp::Any visitResourceOrRename(ExpressParser::ResourceOrRenameContext *context) = 0;

    virtual antlrcpp::Any visitResourceRef(ExpressParser::ResourceRefContext *context) = 0;

    virtual antlrcpp::Any visitReturnStmt(ExpressParser::ReturnStmtContext *context) = 0;

    virtual antlrcpp::Any visitRuleDecl(ExpressParser::RuleDeclContext *context) = 0;

    virtual antlrcpp::Any visitRuleHead(ExpressParser::RuleHeadContext *context) = 0;

    virtual antlrcpp::Any visitRuleId(ExpressParser::RuleIdContext *context) = 0;

    virtual antlrcpp::Any visitRuleLabelId(ExpressParser::RuleLabelIdContext *context) = 0;

    virtual antlrcpp::Any visitSchemaBody(ExpressParser::SchemaBodyContext *context) = 0;

    virtual antlrcpp::Any visitSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitSchemaDecl(ExpressParser::SchemaDeclContext *context) = 0;

    virtual antlrcpp::Any visitSchemaId(ExpressParser::SchemaIdContext *context) = 0;

    virtual antlrcpp::Any visitSchemaVersionId(ExpressParser::SchemaVersionIdContext *context) = 0;

    virtual antlrcpp::Any visitSelector(ExpressParser::SelectorContext *context) = 0;

    virtual antlrcpp::Any visitSelectExtension(ExpressParser::SelectExtensionContext *context) = 0;

    virtual antlrcpp::Any visitSelectList(ExpressParser::SelectListContext *context) = 0;

    virtual antlrcpp::Any visitSelectType(ExpressParser::SelectTypeContext *context) = 0;

    virtual antlrcpp::Any visitSetType(ExpressParser::SetTypeContext *context) = 0;

    virtual antlrcpp::Any visitSimpleExpression(ExpressParser::SimpleExpressionContext *context) = 0;

    virtual antlrcpp::Any visitSimpleFactor(ExpressParser::SimpleFactorContext *context) = 0;

    virtual antlrcpp::Any visitSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *context) = 0;

    virtual antlrcpp::Any visitSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *context) = 0;

    virtual antlrcpp::Any visitSimpleTypes(ExpressParser::SimpleTypesContext *context) = 0;

    virtual antlrcpp::Any visitSkipStmt(ExpressParser::SkipStmtContext *context) = 0;

    virtual antlrcpp::Any visitStmt(ExpressParser::StmtContext *context) = 0;

    virtual antlrcpp::Any visitStringLiteral(ExpressParser::StringLiteralContext *context) = 0;

    virtual antlrcpp::Any visitStringType(ExpressParser::StringTypeContext *context) = 0;

    virtual antlrcpp::Any visitSubsuper(ExpressParser::SubsuperContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraint(ExpressParser::SubtypeConstraintContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *context) = 0;

    virtual antlrcpp::Any visitSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitSupertypeConstraint(ExpressParser::SupertypeConstraintContext *context) = 0;

    virtual antlrcpp::Any visitSupertypeExpression(ExpressParser::SupertypeExpressionContext *context) = 0;

    virtual antlrcpp::Any visitSupertypeFactor(ExpressParser::SupertypeFactorContext *context) = 0;

    virtual antlrcpp::Any visitSupertypeRule(ExpressParser::SupertypeRuleContext *context) = 0;

    virtual antlrcpp::Any visitSupertypeTerm(ExpressParser::SupertypeTermContext *context) = 0;

    virtual antlrcpp::Any visitSyntax(ExpressParser::SyntaxContext *context) = 0;

    virtual antlrcpp::Any visitTerm(ExpressParser::TermContext *context) = 0;

    virtual antlrcpp::Any visitTotalOver(ExpressParser::TotalOverContext *context) = 0;

    virtual antlrcpp::Any visitTypeDecl(ExpressParser::TypeDeclContext *context) = 0;

    virtual antlrcpp::Any visitTypeId(ExpressParser::TypeIdContext *context) = 0;

    virtual antlrcpp::Any visitTypeLabel(ExpressParser::TypeLabelContext *context) = 0;

    virtual antlrcpp::Any visitTypeLabelId(ExpressParser::TypeLabelIdContext *context) = 0;

    virtual antlrcpp::Any visitUnaryOp(ExpressParser::UnaryOpContext *context) = 0;

    virtual antlrcpp::Any visitUnderlyingType(ExpressParser::UnderlyingTypeContext *context) = 0;

    virtual antlrcpp::Any visitUniqueClause(ExpressParser::UniqueClauseContext *context) = 0;

    virtual antlrcpp::Any visitUniqueRule(ExpressParser::UniqueRuleContext *context) = 0;

    virtual antlrcpp::Any visitUntilControl(ExpressParser::UntilControlContext *context) = 0;

    virtual antlrcpp::Any visitUseClause(ExpressParser::UseClauseContext *context) = 0;

    virtual antlrcpp::Any visitVariableId(ExpressParser::VariableIdContext *context) = 0;

    virtual antlrcpp::Any visitWhereClause(ExpressParser::WhereClauseContext *context) = 0;

    virtual antlrcpp::Any visitWhileControl(ExpressParser::WhileControlContext *context) = 0;

    virtual antlrcpp::Any visitWidth(ExpressParser::WidthContext *context) = 0;

    virtual antlrcpp::Any visitWidthSpec(ExpressParser::WidthSpecContext *context) = 0;


};

