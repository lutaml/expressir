
// Generated from Express.g4 by ANTLR 4.8

#pragma once


#include "antlr4-runtime.h"




class  ExpressParser : public antlr4::Parser {
public:
  enum {
    T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, T__6 = 7, 
    T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, T__12 = 13, T__13 = 14, 
    T__14 = 15, T__15 = 16, T__16 = 17, T__17 = 18, T__18 = 19, T__19 = 20, 
    T__20 = 21, T__21 = 22, T__22 = 23, T__23 = 24, T__24 = 25, T__25 = 26, 
    T__26 = 27, T__27 = 28, T__28 = 29, ABS = 30, ABSTRACT = 31, ACOS = 32, 
    AGGREGATE = 33, ALIAS = 34, AND = 35, ANDOR = 36, ARRAY = 37, AS = 38, 
    ASIN = 39, ATAN = 40, BAG = 41, BASED_ON = 42, BEGIN_ = 43, BINARY = 44, 
    BLENGTH = 45, BOOLEAN = 46, BY = 47, CASE = 48, CONSTANT = 49, CONST_E = 50, 
    COS = 51, DERIVE = 52, DIV = 53, ELSE = 54, END_ = 55, END_ALIAS = 56, 
    END_CASE = 57, END_CONSTANT = 58, END_ENTITY = 59, END_FUNCTION = 60, 
    END_IF = 61, END_LOCAL = 62, END_PROCEDURE = 63, END_REPEAT = 64, END_RULE = 65, 
    END_SCHEMA = 66, END_SUBTYPE_CONSTRAINT = 67, END_TYPE = 68, ENTITY = 69, 
    ENUMERATION = 70, ESCAPE = 71, EXISTS = 72, EXP = 73, EXTENSIBLE = 74, 
    FALSE = 75, FIXED = 76, FOR = 77, FORMAT = 78, FROM = 79, FUNCTION = 80, 
    GENERIC = 81, GENERIC_ENTITY = 82, HIBOUND = 83, HIINDEX = 84, IF = 85, 
    IN = 86, INSERT = 87, INTEGER = 88, INVERSE = 89, LENGTH = 90, LIKE = 91, 
    LIST = 92, LOBOUND = 93, LOCAL = 94, LOG = 95, LOG10 = 96, LOG2 = 97, 
    LOGICAL = 98, LOINDEX = 99, MOD = 100, NOT = 101, NUMBER = 102, NVL = 103, 
    ODD = 104, OF = 105, ONEOF = 106, OPTIONAL = 107, OR = 108, OTHERWISE = 109, 
    PI = 110, PROCEDURE = 111, QUERY = 112, REAL = 113, REFERENCE = 114, 
    REMOVE = 115, RENAMED = 116, REPEAT = 117, RETURN = 118, ROLESOF = 119, 
    RULE = 120, SCHEMA = 121, SELECT = 122, SELF = 123, SET = 124, SIN = 125, 
    SIZEOF = 126, SKIP_ = 127, SQRT = 128, STRING = 129, SUBTYPE = 130, 
    SUBTYPE_CONSTRAINT = 131, SUPERTYPE = 132, TAN = 133, THEN = 134, TO = 135, 
    TRUE = 136, TYPE = 137, TYPEOF = 138, TOTAL_OVER = 139, UNIQUE = 140, 
    UNKNOWN = 141, UNTIL = 142, USE = 143, USEDIN = 144, VALUE_ = 145, VALUE_IN = 146, 
    VALUE_UNIQUE = 147, VAR = 148, WITH = 149, WHERE = 150, WHILE = 151, 
    XOR = 152, BinaryLiteral = 153, EncodedStringLiteral = 154, IntegerLiteral = 155, 
    RealLiteral = 156, SimpleId = 157, SimpleStringLiteral = 158, EmbeddedRemark = 159, 
    TailRemark = 160, Whitespace = 161
  };

  enum {
    RuleAttributeRef = 0, RuleConstantRef = 1, RuleEntityRef = 2, RuleEnumerationRef = 3, 
    RuleFunctionRef = 4, RuleParameterRef = 5, RuleProcedureRef = 6, RuleRuleLabelRef = 7, 
    RuleRuleRef = 8, RuleSchemaRef = 9, RuleSubtypeConstraintRef = 10, RuleTypeLabelRef = 11, 
    RuleTypeRef = 12, RuleVariableRef = 13, RuleAbstractEntityDeclaration = 14, 
    RuleAbstractSupertype = 15, RuleAbstractSupertypeDeclaration = 16, RuleActualParameterList = 17, 
    RuleAddLikeOp = 18, RuleAggregateInitializer = 19, RuleAggregateSource = 20, 
    RuleAggregateType = 21, RuleAggregationTypes = 22, RuleAlgorithmHead = 23, 
    RuleAliasStmt = 24, RuleArrayType = 25, RuleAssignmentStmt = 26, RuleAttributeDecl = 27, 
    RuleAttributeId = 28, RuleAttributeQualifier = 29, RuleBagType = 30, 
    RuleBinaryType = 31, RuleBooleanType = 32, RuleBound1 = 33, RuleBound2 = 34, 
    RuleBoundSpec = 35, RuleBuiltInConstant = 36, RuleBuiltInFunction = 37, 
    RuleBuiltInProcedure = 38, RuleCaseAction = 39, RuleCaseLabel = 40, 
    RuleCaseStmt = 41, RuleCompoundStmt = 42, RuleConcreteTypes = 43, RuleConstantBody = 44, 
    RuleConstantDecl = 45, RuleConstantFactor = 46, RuleConstantId = 47, 
    RuleConstructedTypes = 48, RuleDeclaration = 49, RuleDerivedAttr = 50, 
    RuleDeriveClause = 51, RuleDomainRule = 52, RuleElement = 53, RuleEntityBody = 54, 
    RuleEntityConstructor = 55, RuleEntityDecl = 56, RuleEntityHead = 57, 
    RuleEntityId = 58, RuleEnumerationExtension = 59, RuleEnumerationId = 60, 
    RuleEnumerationItems = 61, RuleEnumerationItem = 62, RuleEnumerationReference = 63, 
    RuleEnumerationType = 64, RuleEscapeStmt = 65, RuleExplicitAttr = 66, 
    RuleExpression = 67, RuleFactor = 68, RuleFormalParameter = 69, RuleFunctionCall = 70, 
    RuleFunctionDecl = 71, RuleFunctionHead = 72, RuleFunctionId = 73, RuleGeneralizedTypes = 74, 
    RuleGeneralAggregationTypes = 75, RuleGeneralArrayType = 76, RuleGeneralBagType = 77, 
    RuleGeneralListType = 78, RuleGeneralRef = 79, RuleGeneralSetType = 80, 
    RuleGenericEntityType = 81, RuleGenericType = 82, RuleGroupQualifier = 83, 
    RuleIfStmt = 84, RuleIfStmtStatements = 85, RuleIfStmtElseStatements = 86, 
    RuleIncrement = 87, RuleIncrementControl = 88, RuleIndex = 89, RuleIndex1 = 90, 
    RuleIndex2 = 91, RuleIndexQualifier = 92, RuleInstantiableType = 93, 
    RuleIntegerType = 94, RuleInterfaceSpecification = 95, RuleInterval = 96, 
    RuleIntervalHigh = 97, RuleIntervalItem = 98, RuleIntervalLow = 99, 
    RuleIntervalOp = 100, RuleInverseAttr = 101, RuleInverseAttrType = 102, 
    RuleInverseClause = 103, RuleListType = 104, RuleLiteral = 105, RuleLocalDecl = 106, 
    RuleLocalVariable = 107, RuleLogicalExpression = 108, RuleLogicalLiteral = 109, 
    RuleLogicalType = 110, RuleMultiplicationLikeOp = 111, RuleNamedTypes = 112, 
    RuleNamedTypeOrRename = 113, RuleNullStmt = 114, RuleNumberType = 115, 
    RuleNumericExpression = 116, RuleOneOf = 117, RuleParameter = 118, RuleParameterId = 119, 
    RuleParameterType = 120, RulePopulation = 121, RulePrecisionSpec = 122, 
    RulePrimary = 123, RuleProcedureCallStmt = 124, RuleProcedureDecl = 125, 
    RuleProcedureHead = 126, RuleProcedureHeadParameter = 127, RuleProcedureId = 128, 
    RuleQualifiableFactor = 129, RuleQualifiedAttribute = 130, RuleQualifier = 131, 
    RuleQueryExpression = 132, RuleRealType = 133, RuleRedeclaredAttribute = 134, 
    RuleReferencedAttribute = 135, RuleReferenceClause = 136, RuleRelOp = 137, 
    RuleRelOpExtended = 138, RuleRenameId = 139, RuleRepeatControl = 140, 
    RuleRepeatStmt = 141, RuleRepetition = 142, RuleResourceOrRename = 143, 
    RuleResourceRef = 144, RuleReturnStmt = 145, RuleRuleDecl = 146, RuleRuleHead = 147, 
    RuleRuleId = 148, RuleRuleLabelId = 149, RuleSchemaBody = 150, RuleSchemaBodyDeclaration = 151, 
    RuleSchemaDecl = 152, RuleSchemaId = 153, RuleSchemaVersionId = 154, 
    RuleSelector = 155, RuleSelectExtension = 156, RuleSelectList = 157, 
    RuleSelectType = 158, RuleSetType = 159, RuleSimpleExpression = 160, 
    RuleSimpleFactor = 161, RuleSimpleFactorExpression = 162, RuleSimpleFactorUnaryExpression = 163, 
    RuleSimpleTypes = 164, RuleSkipStmt = 165, RuleStmt = 166, RuleStringLiteral = 167, 
    RuleStringType = 168, RuleSubsuper = 169, RuleSubtypeConstraint = 170, 
    RuleSubtypeConstraintBody = 171, RuleSubtypeConstraintDecl = 172, RuleSubtypeConstraintHead = 173, 
    RuleSubtypeConstraintId = 174, RuleSubtypeDeclaration = 175, RuleSupertypeConstraint = 176, 
    RuleSupertypeExpression = 177, RuleSupertypeFactor = 178, RuleSupertypeRule = 179, 
    RuleSupertypeTerm = 180, RuleSyntax = 181, RuleTerm = 182, RuleTotalOver = 183, 
    RuleTypeDecl = 184, RuleTypeId = 185, RuleTypeLabel = 186, RuleTypeLabelId = 187, 
    RuleUnaryOp = 188, RuleUnderlyingType = 189, RuleUniqueClause = 190, 
    RuleUniqueRule = 191, RuleUntilControl = 192, RuleUseClause = 193, RuleVariableId = 194, 
    RuleWhereClause = 195, RuleWhileControl = 196, RuleWidth = 197, RuleWidthSpec = 198
  };

  ExpressParser(antlr4::TokenStream *input);
  ~ExpressParser();

  virtual std::string getGrammarFileName() const override;
  virtual const antlr4::atn::ATN& getATN() const override { return _atn; };
  virtual const std::vector<std::string>& getTokenNames() const override { return _tokenNames; }; // deprecated: use vocabulary instead.
  virtual const std::vector<std::string>& getRuleNames() const override;
  virtual antlr4::dfa::Vocabulary& getVocabulary() const override;


  class AttributeRefContext;
  class ConstantRefContext;
  class EntityRefContext;
  class EnumerationRefContext;
  class FunctionRefContext;
  class ParameterRefContext;
  class ProcedureRefContext;
  class RuleLabelRefContext;
  class RuleRefContext;
  class SchemaRefContext;
  class SubtypeConstraintRefContext;
  class TypeLabelRefContext;
  class TypeRefContext;
  class VariableRefContext;
  class AbstractEntityDeclarationContext;
  class AbstractSupertypeContext;
  class AbstractSupertypeDeclarationContext;
  class ActualParameterListContext;
  class AddLikeOpContext;
  class AggregateInitializerContext;
  class AggregateSourceContext;
  class AggregateTypeContext;
  class AggregationTypesContext;
  class AlgorithmHeadContext;
  class AliasStmtContext;
  class ArrayTypeContext;
  class AssignmentStmtContext;
  class AttributeDeclContext;
  class AttributeIdContext;
  class AttributeQualifierContext;
  class BagTypeContext;
  class BinaryTypeContext;
  class BooleanTypeContext;
  class Bound1Context;
  class Bound2Context;
  class BoundSpecContext;
  class BuiltInConstantContext;
  class BuiltInFunctionContext;
  class BuiltInProcedureContext;
  class CaseActionContext;
  class CaseLabelContext;
  class CaseStmtContext;
  class CompoundStmtContext;
  class ConcreteTypesContext;
  class ConstantBodyContext;
  class ConstantDeclContext;
  class ConstantFactorContext;
  class ConstantIdContext;
  class ConstructedTypesContext;
  class DeclarationContext;
  class DerivedAttrContext;
  class DeriveClauseContext;
  class DomainRuleContext;
  class ElementContext;
  class EntityBodyContext;
  class EntityConstructorContext;
  class EntityDeclContext;
  class EntityHeadContext;
  class EntityIdContext;
  class EnumerationExtensionContext;
  class EnumerationIdContext;
  class EnumerationItemsContext;
  class EnumerationItemContext;
  class EnumerationReferenceContext;
  class EnumerationTypeContext;
  class EscapeStmtContext;
  class ExplicitAttrContext;
  class ExpressionContext;
  class FactorContext;
  class FormalParameterContext;
  class FunctionCallContext;
  class FunctionDeclContext;
  class FunctionHeadContext;
  class FunctionIdContext;
  class GeneralizedTypesContext;
  class GeneralAggregationTypesContext;
  class GeneralArrayTypeContext;
  class GeneralBagTypeContext;
  class GeneralListTypeContext;
  class GeneralRefContext;
  class GeneralSetTypeContext;
  class GenericEntityTypeContext;
  class GenericTypeContext;
  class GroupQualifierContext;
  class IfStmtContext;
  class IfStmtStatementsContext;
  class IfStmtElseStatementsContext;
  class IncrementContext;
  class IncrementControlContext;
  class IndexContext;
  class Index1Context;
  class Index2Context;
  class IndexQualifierContext;
  class InstantiableTypeContext;
  class IntegerTypeContext;
  class InterfaceSpecificationContext;
  class IntervalContext;
  class IntervalHighContext;
  class IntervalItemContext;
  class IntervalLowContext;
  class IntervalOpContext;
  class InverseAttrContext;
  class InverseAttrTypeContext;
  class InverseClauseContext;
  class ListTypeContext;
  class LiteralContext;
  class LocalDeclContext;
  class LocalVariableContext;
  class LogicalExpressionContext;
  class LogicalLiteralContext;
  class LogicalTypeContext;
  class MultiplicationLikeOpContext;
  class NamedTypesContext;
  class NamedTypeOrRenameContext;
  class NullStmtContext;
  class NumberTypeContext;
  class NumericExpressionContext;
  class OneOfContext;
  class ParameterContext;
  class ParameterIdContext;
  class ParameterTypeContext;
  class PopulationContext;
  class PrecisionSpecContext;
  class PrimaryContext;
  class ProcedureCallStmtContext;
  class ProcedureDeclContext;
  class ProcedureHeadContext;
  class ProcedureHeadParameterContext;
  class ProcedureIdContext;
  class QualifiableFactorContext;
  class QualifiedAttributeContext;
  class QualifierContext;
  class QueryExpressionContext;
  class RealTypeContext;
  class RedeclaredAttributeContext;
  class ReferencedAttributeContext;
  class ReferenceClauseContext;
  class RelOpContext;
  class RelOpExtendedContext;
  class RenameIdContext;
  class RepeatControlContext;
  class RepeatStmtContext;
  class RepetitionContext;
  class ResourceOrRenameContext;
  class ResourceRefContext;
  class ReturnStmtContext;
  class RuleDeclContext;
  class RuleHeadContext;
  class RuleIdContext;
  class RuleLabelIdContext;
  class SchemaBodyContext;
  class SchemaBodyDeclarationContext;
  class SchemaDeclContext;
  class SchemaIdContext;
  class SchemaVersionIdContext;
  class SelectorContext;
  class SelectExtensionContext;
  class SelectListContext;
  class SelectTypeContext;
  class SetTypeContext;
  class SimpleExpressionContext;
  class SimpleFactorContext;
  class SimpleFactorExpressionContext;
  class SimpleFactorUnaryExpressionContext;
  class SimpleTypesContext;
  class SkipStmtContext;
  class StmtContext;
  class StringLiteralContext;
  class StringTypeContext;
  class SubsuperContext;
  class SubtypeConstraintContext;
  class SubtypeConstraintBodyContext;
  class SubtypeConstraintDeclContext;
  class SubtypeConstraintHeadContext;
  class SubtypeConstraintIdContext;
  class SubtypeDeclarationContext;
  class SupertypeConstraintContext;
  class SupertypeExpressionContext;
  class SupertypeFactorContext;
  class SupertypeRuleContext;
  class SupertypeTermContext;
  class SyntaxContext;
  class TermContext;
  class TotalOverContext;
  class TypeDeclContext;
  class TypeIdContext;
  class TypeLabelContext;
  class TypeLabelIdContext;
  class UnaryOpContext;
  class UnderlyingTypeContext;
  class UniqueClauseContext;
  class UniqueRuleContext;
  class UntilControlContext;
  class UseClauseContext;
  class VariableIdContext;
  class WhereClauseContext;
  class WhileControlContext;
  class WidthContext;
  class WidthSpecContext; 

  class  AttributeRefContext : public antlr4::ParserRuleContext {
  public:
    AttributeRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeIdContext *attributeId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AttributeRefContext* attributeRef();

  class  ConstantRefContext : public antlr4::ParserRuleContext {
  public:
    ConstantRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConstantIdContext *constantId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstantRefContext* constantRef();

  class  EntityRefContext : public antlr4::ParserRuleContext {
  public:
    EntityRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityIdContext *entityId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityRefContext* entityRef();

  class  EnumerationRefContext : public antlr4::ParserRuleContext {
  public:
    EnumerationRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EnumerationIdContext *enumerationId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationRefContext* enumerationRef();

  class  FunctionRefContext : public antlr4::ParserRuleContext {
  public:
    FunctionRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    FunctionIdContext *functionId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FunctionRefContext* functionRef();

  class  ParameterRefContext : public antlr4::ParserRuleContext {
  public:
    ParameterRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ParameterIdContext *parameterId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ParameterRefContext* parameterRef();

  class  ProcedureRefContext : public antlr4::ParserRuleContext {
  public:
    ProcedureRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ProcedureIdContext *procedureId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureRefContext* procedureRef();

  class  RuleLabelRefContext : public antlr4::ParserRuleContext {
  public:
    RuleLabelRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    RuleLabelIdContext *ruleLabelId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleLabelRefContext* ruleLabelRef();

  class  RuleRefContext : public antlr4::ParserRuleContext {
  public:
    RuleRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    RuleIdContext *ruleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleRefContext* ruleRef();

  class  SchemaRefContext : public antlr4::ParserRuleContext {
  public:
    SchemaRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SchemaIdContext *schemaId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaRefContext* schemaRef();

  class  SubtypeConstraintRefContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SubtypeConstraintIdContext *subtypeConstraintId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintRefContext* subtypeConstraintRef();

  class  TypeLabelRefContext : public antlr4::ParserRuleContext {
  public:
    TypeLabelRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    TypeLabelIdContext *typeLabelId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeLabelRefContext* typeLabelRef();

  class  TypeRefContext : public antlr4::ParserRuleContext {
  public:
    TypeRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    TypeIdContext *typeId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeRefContext* typeRef();

  class  VariableRefContext : public antlr4::ParserRuleContext {
  public:
    VariableRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    VariableIdContext *variableId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  VariableRefContext* variableRef();

  class  AbstractEntityDeclarationContext : public antlr4::ParserRuleContext {
  public:
    AbstractEntityDeclarationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ABSTRACT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AbstractEntityDeclarationContext* abstractEntityDeclaration();

  class  AbstractSupertypeContext : public antlr4::ParserRuleContext {
  public:
    AbstractSupertypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ABSTRACT();
    antlr4::tree::TerminalNode *SUPERTYPE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AbstractSupertypeContext* abstractSupertype();

  class  AbstractSupertypeDeclarationContext : public antlr4::ParserRuleContext {
  public:
    AbstractSupertypeDeclarationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ABSTRACT();
    antlr4::tree::TerminalNode *SUPERTYPE();
    SubtypeConstraintContext *subtypeConstraint();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AbstractSupertypeDeclarationContext* abstractSupertypeDeclaration();

  class  ActualParameterListContext : public antlr4::ParserRuleContext {
  public:
    ActualParameterListContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ParameterContext *> parameter();
    ParameterContext* parameter(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ActualParameterListContext* actualParameterList();

  class  AddLikeOpContext : public antlr4::ParserRuleContext {
  public:
    AddLikeOpContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OR();
    antlr4::tree::TerminalNode *XOR();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AddLikeOpContext* addLikeOp();

  class  AggregateInitializerContext : public antlr4::ParserRuleContext {
  public:
    AggregateInitializerContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ElementContext *> element();
    ElementContext* element(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AggregateInitializerContext* aggregateInitializer();

  class  AggregateSourceContext : public antlr4::ParserRuleContext {
  public:
    AggregateSourceContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SimpleExpressionContext *simpleExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AggregateSourceContext* aggregateSource();

  class  AggregateTypeContext : public antlr4::ParserRuleContext {
  public:
    AggregateTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *AGGREGATE();
    antlr4::tree::TerminalNode *OF();
    ParameterTypeContext *parameterType();
    TypeLabelContext *typeLabel();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AggregateTypeContext* aggregateType();

  class  AggregationTypesContext : public antlr4::ParserRuleContext {
  public:
    AggregationTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ArrayTypeContext *arrayType();
    BagTypeContext *bagType();
    ListTypeContext *listType();
    SetTypeContext *setType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AggregationTypesContext* aggregationTypes();

  class  AlgorithmHeadContext : public antlr4::ParserRuleContext {
  public:
    AlgorithmHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<DeclarationContext *> declaration();
    DeclarationContext* declaration(size_t i);
    ConstantDeclContext *constantDecl();
    LocalDeclContext *localDecl();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AlgorithmHeadContext* algorithmHead();

  class  AliasStmtContext : public antlr4::ParserRuleContext {
  public:
    AliasStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ALIAS();
    VariableIdContext *variableId();
    antlr4::tree::TerminalNode *FOR();
    GeneralRefContext *generalRef();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);
    antlr4::tree::TerminalNode *END_ALIAS();
    std::vector<QualifierContext *> qualifier();
    QualifierContext* qualifier(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AliasStmtContext* aliasStmt();

  class  ArrayTypeContext : public antlr4::ParserRuleContext {
  public:
    ArrayTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ARRAY();
    BoundSpecContext *boundSpec();
    antlr4::tree::TerminalNode *OF();
    InstantiableTypeContext *instantiableType();
    antlr4::tree::TerminalNode *OPTIONAL();
    antlr4::tree::TerminalNode *UNIQUE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ArrayTypeContext* arrayType();

  class  AssignmentStmtContext : public antlr4::ParserRuleContext {
  public:
    AssignmentStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    GeneralRefContext *generalRef();
    ExpressionContext *expression();
    std::vector<QualifierContext *> qualifier();
    QualifierContext* qualifier(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AssignmentStmtContext* assignmentStmt();

  class  AttributeDeclContext : public antlr4::ParserRuleContext {
  public:
    AttributeDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeIdContext *attributeId();
    RedeclaredAttributeContext *redeclaredAttribute();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AttributeDeclContext* attributeDecl();

  class  AttributeIdContext : public antlr4::ParserRuleContext {
  public:
    AttributeIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AttributeIdContext* attributeId();

  class  AttributeQualifierContext : public antlr4::ParserRuleContext {
  public:
    AttributeQualifierContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeRefContext *attributeRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  AttributeQualifierContext* attributeQualifier();

  class  BagTypeContext : public antlr4::ParserRuleContext {
  public:
    BagTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BAG();
    antlr4::tree::TerminalNode *OF();
    InstantiableTypeContext *instantiableType();
    BoundSpecContext *boundSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BagTypeContext* bagType();

  class  BinaryTypeContext : public antlr4::ParserRuleContext {
  public:
    BinaryTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BINARY();
    WidthSpecContext *widthSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BinaryTypeContext* binaryType();

  class  BooleanTypeContext : public antlr4::ParserRuleContext {
  public:
    BooleanTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BOOLEAN();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BooleanTypeContext* booleanType();

  class  Bound1Context : public antlr4::ParserRuleContext {
  public:
    Bound1Context(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Bound1Context* bound1();

  class  Bound2Context : public antlr4::ParserRuleContext {
  public:
    Bound2Context(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Bound2Context* bound2();

  class  BoundSpecContext : public antlr4::ParserRuleContext {
  public:
    BoundSpecContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Bound1Context *bound1();
    Bound2Context *bound2();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BoundSpecContext* boundSpec();

  class  BuiltInConstantContext : public antlr4::ParserRuleContext {
  public:
    BuiltInConstantContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CONST_E();
    antlr4::tree::TerminalNode *PI();
    antlr4::tree::TerminalNode *SELF();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BuiltInConstantContext* builtInConstant();

  class  BuiltInFunctionContext : public antlr4::ParserRuleContext {
  public:
    BuiltInFunctionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ABS();
    antlr4::tree::TerminalNode *ACOS();
    antlr4::tree::TerminalNode *ASIN();
    antlr4::tree::TerminalNode *ATAN();
    antlr4::tree::TerminalNode *BLENGTH();
    antlr4::tree::TerminalNode *COS();
    antlr4::tree::TerminalNode *EXISTS();
    antlr4::tree::TerminalNode *EXP();
    antlr4::tree::TerminalNode *FORMAT();
    antlr4::tree::TerminalNode *HIBOUND();
    antlr4::tree::TerminalNode *HIINDEX();
    antlr4::tree::TerminalNode *LENGTH();
    antlr4::tree::TerminalNode *LOBOUND();
    antlr4::tree::TerminalNode *LOINDEX();
    antlr4::tree::TerminalNode *LOG();
    antlr4::tree::TerminalNode *LOG2();
    antlr4::tree::TerminalNode *LOG10();
    antlr4::tree::TerminalNode *NVL();
    antlr4::tree::TerminalNode *ODD();
    antlr4::tree::TerminalNode *ROLESOF();
    antlr4::tree::TerminalNode *SIN();
    antlr4::tree::TerminalNode *SIZEOF();
    antlr4::tree::TerminalNode *SQRT();
    antlr4::tree::TerminalNode *TAN();
    antlr4::tree::TerminalNode *TYPEOF();
    antlr4::tree::TerminalNode *USEDIN();
    antlr4::tree::TerminalNode *VALUE_();
    antlr4::tree::TerminalNode *VALUE_IN();
    antlr4::tree::TerminalNode *VALUE_UNIQUE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BuiltInFunctionContext* builtInFunction();

  class  BuiltInProcedureContext : public antlr4::ParserRuleContext {
  public:
    BuiltInProcedureContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *INSERT();
    antlr4::tree::TerminalNode *REMOVE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BuiltInProcedureContext* builtInProcedure();

  class  CaseActionContext : public antlr4::ParserRuleContext {
  public:
    CaseActionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<CaseLabelContext *> caseLabel();
    CaseLabelContext* caseLabel(size_t i);
    StmtContext *stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  CaseActionContext* caseAction();

  class  CaseLabelContext : public antlr4::ParserRuleContext {
  public:
    CaseLabelContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  CaseLabelContext* caseLabel();

  class  CaseStmtContext : public antlr4::ParserRuleContext {
  public:
    CaseStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CASE();
    SelectorContext *selector();
    antlr4::tree::TerminalNode *OF();
    antlr4::tree::TerminalNode *END_CASE();
    std::vector<CaseActionContext *> caseAction();
    CaseActionContext* caseAction(size_t i);
    antlr4::tree::TerminalNode *OTHERWISE();
    StmtContext *stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  CaseStmtContext* caseStmt();

  class  CompoundStmtContext : public antlr4::ParserRuleContext {
  public:
    CompoundStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BEGIN_();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);
    antlr4::tree::TerminalNode *END_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  CompoundStmtContext* compoundStmt();

  class  ConcreteTypesContext : public antlr4::ParserRuleContext {
  public:
    ConcreteTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AggregationTypesContext *aggregationTypes();
    SimpleTypesContext *simpleTypes();
    TypeRefContext *typeRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConcreteTypesContext* concreteTypes();

  class  ConstantBodyContext : public antlr4::ParserRuleContext {
  public:
    ConstantBodyContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConstantIdContext *constantId();
    InstantiableTypeContext *instantiableType();
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstantBodyContext* constantBody();

  class  ConstantDeclContext : public antlr4::ParserRuleContext {
  public:
    ConstantDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CONSTANT();
    std::vector<ConstantBodyContext *> constantBody();
    ConstantBodyContext* constantBody(size_t i);
    antlr4::tree::TerminalNode *END_CONSTANT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstantDeclContext* constantDecl();

  class  ConstantFactorContext : public antlr4::ParserRuleContext {
  public:
    ConstantFactorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    BuiltInConstantContext *builtInConstant();
    ConstantRefContext *constantRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstantFactorContext* constantFactor();

  class  ConstantIdContext : public antlr4::ParserRuleContext {
  public:
    ConstantIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstantIdContext* constantId();

  class  ConstructedTypesContext : public antlr4::ParserRuleContext {
  public:
    ConstructedTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EnumerationTypeContext *enumerationType();
    SelectTypeContext *selectType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ConstructedTypesContext* constructedTypes();

  class  DeclarationContext : public antlr4::ParserRuleContext {
  public:
    DeclarationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityDeclContext *entityDecl();
    FunctionDeclContext *functionDecl();
    ProcedureDeclContext *procedureDecl();
    SubtypeConstraintDeclContext *subtypeConstraintDecl();
    TypeDeclContext *typeDecl();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DeclarationContext* declaration();

  class  DerivedAttrContext : public antlr4::ParserRuleContext {
  public:
    DerivedAttrContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeDeclContext *attributeDecl();
    ParameterTypeContext *parameterType();
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DerivedAttrContext* derivedAttr();

  class  DeriveClauseContext : public antlr4::ParserRuleContext {
  public:
    DeriveClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DERIVE();
    std::vector<DerivedAttrContext *> derivedAttr();
    DerivedAttrContext* derivedAttr(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DeriveClauseContext* deriveClause();

  class  DomainRuleContext : public antlr4::ParserRuleContext {
  public:
    DomainRuleContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();
    RuleLabelIdContext *ruleLabelId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DomainRuleContext* domainRule();

  class  ElementContext : public antlr4::ParserRuleContext {
  public:
    ElementContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();
    RepetitionContext *repetition();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ElementContext* element();

  class  EntityBodyContext : public antlr4::ParserRuleContext {
  public:
    EntityBodyContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ExplicitAttrContext *> explicitAttr();
    ExplicitAttrContext* explicitAttr(size_t i);
    DeriveClauseContext *deriveClause();
    InverseClauseContext *inverseClause();
    UniqueClauseContext *uniqueClause();
    WhereClauseContext *whereClause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityBodyContext* entityBody();

  class  EntityConstructorContext : public antlr4::ParserRuleContext {
  public:
    EntityConstructorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();
    std::vector<ExpressionContext *> expression();
    ExpressionContext* expression(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityConstructorContext* entityConstructor();

  class  EntityDeclContext : public antlr4::ParserRuleContext {
  public:
    EntityDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityHeadContext *entityHead();
    EntityBodyContext *entityBody();
    antlr4::tree::TerminalNode *END_ENTITY();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityDeclContext* entityDecl();

  class  EntityHeadContext : public antlr4::ParserRuleContext {
  public:
    EntityHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ENTITY();
    EntityIdContext *entityId();
    SubsuperContext *subsuper();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityHeadContext* entityHead();

  class  EntityIdContext : public antlr4::ParserRuleContext {
  public:
    EntityIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EntityIdContext* entityId();

  class  EnumerationExtensionContext : public antlr4::ParserRuleContext {
  public:
    EnumerationExtensionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BASED_ON();
    TypeRefContext *typeRef();
    antlr4::tree::TerminalNode *WITH();
    EnumerationItemsContext *enumerationItems();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationExtensionContext* enumerationExtension();

  class  EnumerationIdContext : public antlr4::ParserRuleContext {
  public:
    EnumerationIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationIdContext* enumerationId();

  class  EnumerationItemsContext : public antlr4::ParserRuleContext {
  public:
    EnumerationItemsContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<EnumerationItemContext *> enumerationItem();
    EnumerationItemContext* enumerationItem(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationItemsContext* enumerationItems();

  class  EnumerationItemContext : public antlr4::ParserRuleContext {
  public:
    EnumerationItemContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EnumerationIdContext *enumerationId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationItemContext* enumerationItem();

  class  EnumerationReferenceContext : public antlr4::ParserRuleContext {
  public:
    EnumerationReferenceContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EnumerationRefContext *enumerationRef();
    TypeRefContext *typeRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationReferenceContext* enumerationReference();

  class  EnumerationTypeContext : public antlr4::ParserRuleContext {
  public:
    EnumerationTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ENUMERATION();
    antlr4::tree::TerminalNode *EXTENSIBLE();
    antlr4::tree::TerminalNode *OF();
    EnumerationItemsContext *enumerationItems();
    EnumerationExtensionContext *enumerationExtension();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EnumerationTypeContext* enumerationType();

  class  EscapeStmtContext : public antlr4::ParserRuleContext {
  public:
    EscapeStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ESCAPE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  EscapeStmtContext* escapeStmt();

  class  ExplicitAttrContext : public antlr4::ParserRuleContext {
  public:
    ExplicitAttrContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<AttributeDeclContext *> attributeDecl();
    AttributeDeclContext* attributeDecl(size_t i);
    ParameterTypeContext *parameterType();
    antlr4::tree::TerminalNode *OPTIONAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ExplicitAttrContext* explicitAttr();

  class  ExpressionContext : public antlr4::ParserRuleContext {
  public:
    ExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<SimpleExpressionContext *> simpleExpression();
    SimpleExpressionContext* simpleExpression(size_t i);
    RelOpExtendedContext *relOpExtended();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ExpressionContext* expression();

  class  FactorContext : public antlr4::ParserRuleContext {
  public:
    FactorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<SimpleFactorContext *> simpleFactor();
    SimpleFactorContext* simpleFactor(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FactorContext* factor();

  class  FormalParameterContext : public antlr4::ParserRuleContext {
  public:
    FormalParameterContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ParameterIdContext *> parameterId();
    ParameterIdContext* parameterId(size_t i);
    ParameterTypeContext *parameterType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FormalParameterContext* formalParameter();

  class  FunctionCallContext : public antlr4::ParserRuleContext {
  public:
    FunctionCallContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    BuiltInFunctionContext *builtInFunction();
    FunctionRefContext *functionRef();
    ActualParameterListContext *actualParameterList();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FunctionCallContext* functionCall();

  class  FunctionDeclContext : public antlr4::ParserRuleContext {
  public:
    FunctionDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    FunctionHeadContext *functionHead();
    AlgorithmHeadContext *algorithmHead();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);
    antlr4::tree::TerminalNode *END_FUNCTION();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FunctionDeclContext* functionDecl();

  class  FunctionHeadContext : public antlr4::ParserRuleContext {
  public:
    FunctionHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FUNCTION();
    FunctionIdContext *functionId();
    ParameterTypeContext *parameterType();
    std::vector<FormalParameterContext *> formalParameter();
    FormalParameterContext* formalParameter(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FunctionHeadContext* functionHead();

  class  FunctionIdContext : public antlr4::ParserRuleContext {
  public:
    FunctionIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FunctionIdContext* functionId();

  class  GeneralizedTypesContext : public antlr4::ParserRuleContext {
  public:
    GeneralizedTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AggregateTypeContext *aggregateType();
    GeneralAggregationTypesContext *generalAggregationTypes();
    GenericEntityTypeContext *genericEntityType();
    GenericTypeContext *genericType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralizedTypesContext* generalizedTypes();

  class  GeneralAggregationTypesContext : public antlr4::ParserRuleContext {
  public:
    GeneralAggregationTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    GeneralArrayTypeContext *generalArrayType();
    GeneralBagTypeContext *generalBagType();
    GeneralListTypeContext *generalListType();
    GeneralSetTypeContext *generalSetType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralAggregationTypesContext* generalAggregationTypes();

  class  GeneralArrayTypeContext : public antlr4::ParserRuleContext {
  public:
    GeneralArrayTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ARRAY();
    antlr4::tree::TerminalNode *OF();
    ParameterTypeContext *parameterType();
    BoundSpecContext *boundSpec();
    antlr4::tree::TerminalNode *OPTIONAL();
    antlr4::tree::TerminalNode *UNIQUE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralArrayTypeContext* generalArrayType();

  class  GeneralBagTypeContext : public antlr4::ParserRuleContext {
  public:
    GeneralBagTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BAG();
    antlr4::tree::TerminalNode *OF();
    ParameterTypeContext *parameterType();
    BoundSpecContext *boundSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralBagTypeContext* generalBagType();

  class  GeneralListTypeContext : public antlr4::ParserRuleContext {
  public:
    GeneralListTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LIST();
    antlr4::tree::TerminalNode *OF();
    ParameterTypeContext *parameterType();
    BoundSpecContext *boundSpec();
    antlr4::tree::TerminalNode *UNIQUE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralListTypeContext* generalListType();

  class  GeneralRefContext : public antlr4::ParserRuleContext {
  public:
    GeneralRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ParameterRefContext *parameterRef();
    VariableIdContext *variableId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralRefContext* generalRef();

  class  GeneralSetTypeContext : public antlr4::ParserRuleContext {
  public:
    GeneralSetTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SET();
    antlr4::tree::TerminalNode *OF();
    ParameterTypeContext *parameterType();
    BoundSpecContext *boundSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GeneralSetTypeContext* generalSetType();

  class  GenericEntityTypeContext : public antlr4::ParserRuleContext {
  public:
    GenericEntityTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *GENERIC_ENTITY();
    TypeLabelContext *typeLabel();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GenericEntityTypeContext* genericEntityType();

  class  GenericTypeContext : public antlr4::ParserRuleContext {
  public:
    GenericTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *GENERIC();
    TypeLabelContext *typeLabel();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GenericTypeContext* genericType();

  class  GroupQualifierContext : public antlr4::ParserRuleContext {
  public:
    GroupQualifierContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  GroupQualifierContext* groupQualifier();

  class  IfStmtContext : public antlr4::ParserRuleContext {
  public:
    IfStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *IF();
    LogicalExpressionContext *logicalExpression();
    antlr4::tree::TerminalNode *THEN();
    IfStmtStatementsContext *ifStmtStatements();
    antlr4::tree::TerminalNode *END_IF();
    antlr4::tree::TerminalNode *ELSE();
    IfStmtElseStatementsContext *ifStmtElseStatements();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IfStmtContext* ifStmt();

  class  IfStmtStatementsContext : public antlr4::ParserRuleContext {
  public:
    IfStmtStatementsContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IfStmtStatementsContext* ifStmtStatements();

  class  IfStmtElseStatementsContext : public antlr4::ParserRuleContext {
  public:
    IfStmtElseStatementsContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IfStmtElseStatementsContext* ifStmtElseStatements();

  class  IncrementContext : public antlr4::ParserRuleContext {
  public:
    IncrementContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IncrementContext* increment();

  class  IncrementControlContext : public antlr4::ParserRuleContext {
  public:
    IncrementControlContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    VariableIdContext *variableId();
    Bound1Context *bound1();
    antlr4::tree::TerminalNode *TO();
    Bound2Context *bound2();
    antlr4::tree::TerminalNode *BY();
    IncrementContext *increment();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IncrementControlContext* incrementControl();

  class  IndexContext : public antlr4::ParserRuleContext {
  public:
    IndexContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IndexContext* index();

  class  Index1Context : public antlr4::ParserRuleContext {
  public:
    Index1Context(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    IndexContext *index();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Index1Context* index1();

  class  Index2Context : public antlr4::ParserRuleContext {
  public:
    Index2Context(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    IndexContext *index();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Index2Context* index2();

  class  IndexQualifierContext : public antlr4::ParserRuleContext {
  public:
    IndexQualifierContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Index1Context *index1();
    Index2Context *index2();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IndexQualifierContext* indexQualifier();

  class  InstantiableTypeContext : public antlr4::ParserRuleContext {
  public:
    InstantiableTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConcreteTypesContext *concreteTypes();
    EntityRefContext *entityRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InstantiableTypeContext* instantiableType();

  class  IntegerTypeContext : public antlr4::ParserRuleContext {
  public:
    IntegerTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *INTEGER();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntegerTypeContext* integerType();

  class  InterfaceSpecificationContext : public antlr4::ParserRuleContext {
  public:
    InterfaceSpecificationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ReferenceClauseContext *referenceClause();
    UseClauseContext *useClause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InterfaceSpecificationContext* interfaceSpecification();

  class  IntervalContext : public antlr4::ParserRuleContext {
  public:
    IntervalContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    IntervalLowContext *intervalLow();
    std::vector<IntervalOpContext *> intervalOp();
    IntervalOpContext* intervalOp(size_t i);
    IntervalItemContext *intervalItem();
    IntervalHighContext *intervalHigh();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntervalContext* interval();

  class  IntervalHighContext : public antlr4::ParserRuleContext {
  public:
    IntervalHighContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SimpleExpressionContext *simpleExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntervalHighContext* intervalHigh();

  class  IntervalItemContext : public antlr4::ParserRuleContext {
  public:
    IntervalItemContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SimpleExpressionContext *simpleExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntervalItemContext* intervalItem();

  class  IntervalLowContext : public antlr4::ParserRuleContext {
  public:
    IntervalLowContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SimpleExpressionContext *simpleExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntervalLowContext* intervalLow();

  class  IntervalOpContext : public antlr4::ParserRuleContext {
  public:
    IntervalOpContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IntervalOpContext* intervalOp();

  class  InverseAttrContext : public antlr4::ParserRuleContext {
  public:
    InverseAttrContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeDeclContext *attributeDecl();
    InverseAttrTypeContext *inverseAttrType();
    antlr4::tree::TerminalNode *FOR();
    AttributeRefContext *attributeRef();
    EntityRefContext *entityRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InverseAttrContext* inverseAttr();

  class  InverseAttrTypeContext : public antlr4::ParserRuleContext {
  public:
    InverseAttrTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();
    antlr4::tree::TerminalNode *OF();
    antlr4::tree::TerminalNode *SET();
    antlr4::tree::TerminalNode *BAG();
    BoundSpecContext *boundSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InverseAttrTypeContext* inverseAttrType();

  class  InverseClauseContext : public antlr4::ParserRuleContext {
  public:
    InverseClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *INVERSE();
    std::vector<InverseAttrContext *> inverseAttr();
    InverseAttrContext* inverseAttr(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InverseClauseContext* inverseClause();

  class  ListTypeContext : public antlr4::ParserRuleContext {
  public:
    ListTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LIST();
    antlr4::tree::TerminalNode *OF();
    InstantiableTypeContext *instantiableType();
    BoundSpecContext *boundSpec();
    antlr4::tree::TerminalNode *UNIQUE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ListTypeContext* listType();

  class  LiteralContext : public antlr4::ParserRuleContext {
  public:
    LiteralContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BinaryLiteral();
    antlr4::tree::TerminalNode *IntegerLiteral();
    LogicalLiteralContext *logicalLiteral();
    antlr4::tree::TerminalNode *RealLiteral();
    StringLiteralContext *stringLiteral();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LiteralContext* literal();

  class  LocalDeclContext : public antlr4::ParserRuleContext {
  public:
    LocalDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LOCAL();
    std::vector<LocalVariableContext *> localVariable();
    LocalVariableContext* localVariable(size_t i);
    antlr4::tree::TerminalNode *END_LOCAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LocalDeclContext* localDecl();

  class  LocalVariableContext : public antlr4::ParserRuleContext {
  public:
    LocalVariableContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<VariableIdContext *> variableId();
    VariableIdContext* variableId(size_t i);
    ParameterTypeContext *parameterType();
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LocalVariableContext* localVariable();

  class  LogicalExpressionContext : public antlr4::ParserRuleContext {
  public:
    LogicalExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LogicalExpressionContext* logicalExpression();

  class  LogicalLiteralContext : public antlr4::ParserRuleContext {
  public:
    LogicalLiteralContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FALSE();
    antlr4::tree::TerminalNode *TRUE();
    antlr4::tree::TerminalNode *UNKNOWN();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LogicalLiteralContext* logicalLiteral();

  class  LogicalTypeContext : public antlr4::ParserRuleContext {
  public:
    LogicalTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LOGICAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  LogicalTypeContext* logicalType();

  class  MultiplicationLikeOpContext : public antlr4::ParserRuleContext {
  public:
    MultiplicationLikeOpContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DIV();
    antlr4::tree::TerminalNode *MOD();
    antlr4::tree::TerminalNode *AND();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  MultiplicationLikeOpContext* multiplicationLikeOp();

  class  NamedTypesContext : public antlr4::ParserRuleContext {
  public:
    NamedTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();
    TypeRefContext *typeRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NamedTypesContext* namedTypes();

  class  NamedTypeOrRenameContext : public antlr4::ParserRuleContext {
  public:
    NamedTypeOrRenameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NamedTypesContext *namedTypes();
    antlr4::tree::TerminalNode *AS();
    EntityIdContext *entityId();
    TypeIdContext *typeId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NamedTypeOrRenameContext* namedTypeOrRename();

  class  NullStmtContext : public antlr4::ParserRuleContext {
  public:
    NullStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NullStmtContext* nullStmt();

  class  NumberTypeContext : public antlr4::ParserRuleContext {
  public:
    NumberTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *NUMBER();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NumberTypeContext* numberType();

  class  NumericExpressionContext : public antlr4::ParserRuleContext {
  public:
    NumericExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SimpleExpressionContext *simpleExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NumericExpressionContext* numericExpression();

  class  OneOfContext : public antlr4::ParserRuleContext {
  public:
    OneOfContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ONEOF();
    std::vector<SupertypeExpressionContext *> supertypeExpression();
    SupertypeExpressionContext* supertypeExpression(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  OneOfContext* oneOf();

  class  ParameterContext : public antlr4::ParserRuleContext {
  public:
    ParameterContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ParameterContext* parameter();

  class  ParameterIdContext : public antlr4::ParserRuleContext {
  public:
    ParameterIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ParameterIdContext* parameterId();

  class  ParameterTypeContext : public antlr4::ParserRuleContext {
  public:
    ParameterTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    GeneralizedTypesContext *generalizedTypes();
    NamedTypesContext *namedTypes();
    SimpleTypesContext *simpleTypes();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ParameterTypeContext* parameterType();

  class  PopulationContext : public antlr4::ParserRuleContext {
  public:
    PopulationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  PopulationContext* population();

  class  PrecisionSpecContext : public antlr4::ParserRuleContext {
  public:
    PrecisionSpecContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  PrecisionSpecContext* precisionSpec();

  class  PrimaryContext : public antlr4::ParserRuleContext {
  public:
    PrimaryContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    LiteralContext *literal();
    QualifiableFactorContext *qualifiableFactor();
    std::vector<QualifierContext *> qualifier();
    QualifierContext* qualifier(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  PrimaryContext* primary();

  class  ProcedureCallStmtContext : public antlr4::ParserRuleContext {
  public:
    ProcedureCallStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    BuiltInProcedureContext *builtInProcedure();
    ProcedureRefContext *procedureRef();
    ActualParameterListContext *actualParameterList();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureCallStmtContext* procedureCallStmt();

  class  ProcedureDeclContext : public antlr4::ParserRuleContext {
  public:
    ProcedureDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ProcedureHeadContext *procedureHead();
    AlgorithmHeadContext *algorithmHead();
    antlr4::tree::TerminalNode *END_PROCEDURE();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureDeclContext* procedureDecl();

  class  ProcedureHeadContext : public antlr4::ParserRuleContext {
  public:
    ProcedureHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *PROCEDURE();
    ProcedureIdContext *procedureId();
    std::vector<ProcedureHeadParameterContext *> procedureHeadParameter();
    ProcedureHeadParameterContext* procedureHeadParameter(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureHeadContext* procedureHead();

  class  ProcedureHeadParameterContext : public antlr4::ParserRuleContext {
  public:
    ProcedureHeadParameterContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    FormalParameterContext *formalParameter();
    antlr4::tree::TerminalNode *VAR();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureHeadParameterContext* procedureHeadParameter();

  class  ProcedureIdContext : public antlr4::ParserRuleContext {
  public:
    ProcedureIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProcedureIdContext* procedureId();

  class  QualifiableFactorContext : public antlr4::ParserRuleContext {
  public:
    QualifiableFactorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeRefContext *attributeRef();
    ConstantFactorContext *constantFactor();
    FunctionCallContext *functionCall();
    GeneralRefContext *generalRef();
    PopulationContext *population();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  QualifiableFactorContext* qualifiableFactor();

  class  QualifiedAttributeContext : public antlr4::ParserRuleContext {
  public:
    QualifiedAttributeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SELF();
    GroupQualifierContext *groupQualifier();
    AttributeQualifierContext *attributeQualifier();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  QualifiedAttributeContext* qualifiedAttribute();

  class  QualifierContext : public antlr4::ParserRuleContext {
  public:
    QualifierContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeQualifierContext *attributeQualifier();
    GroupQualifierContext *groupQualifier();
    IndexQualifierContext *indexQualifier();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  QualifierContext* qualifier();

  class  QueryExpressionContext : public antlr4::ParserRuleContext {
  public:
    QueryExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *QUERY();
    VariableIdContext *variableId();
    AggregateSourceContext *aggregateSource();
    LogicalExpressionContext *logicalExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  QueryExpressionContext* queryExpression();

  class  RealTypeContext : public antlr4::ParserRuleContext {
  public:
    RealTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *REAL();
    PrecisionSpecContext *precisionSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RealTypeContext* realType();

  class  RedeclaredAttributeContext : public antlr4::ParserRuleContext {
  public:
    RedeclaredAttributeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    QualifiedAttributeContext *qualifiedAttribute();
    antlr4::tree::TerminalNode *RENAMED();
    AttributeIdContext *attributeId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RedeclaredAttributeContext* redeclaredAttribute();

  class  ReferencedAttributeContext : public antlr4::ParserRuleContext {
  public:
    ReferencedAttributeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AttributeRefContext *attributeRef();
    QualifiedAttributeContext *qualifiedAttribute();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ReferencedAttributeContext* referencedAttribute();

  class  ReferenceClauseContext : public antlr4::ParserRuleContext {
  public:
    ReferenceClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *REFERENCE();
    antlr4::tree::TerminalNode *FROM();
    SchemaRefContext *schemaRef();
    std::vector<ResourceOrRenameContext *> resourceOrRename();
    ResourceOrRenameContext* resourceOrRename(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ReferenceClauseContext* referenceClause();

  class  RelOpContext : public antlr4::ParserRuleContext {
  public:
    RelOpContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RelOpContext* relOp();

  class  RelOpExtendedContext : public antlr4::ParserRuleContext {
  public:
    RelOpExtendedContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    RelOpContext *relOp();
    antlr4::tree::TerminalNode *IN();
    antlr4::tree::TerminalNode *LIKE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RelOpExtendedContext* relOpExtended();

  class  RenameIdContext : public antlr4::ParserRuleContext {
  public:
    RenameIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConstantIdContext *constantId();
    EntityIdContext *entityId();
    FunctionIdContext *functionId();
    ProcedureIdContext *procedureId();
    TypeIdContext *typeId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RenameIdContext* renameId();

  class  RepeatControlContext : public antlr4::ParserRuleContext {
  public:
    RepeatControlContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    IncrementControlContext *incrementControl();
    WhileControlContext *whileControl();
    UntilControlContext *untilControl();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RepeatControlContext* repeatControl();

  class  RepeatStmtContext : public antlr4::ParserRuleContext {
  public:
    RepeatStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *REPEAT();
    RepeatControlContext *repeatControl();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);
    antlr4::tree::TerminalNode *END_REPEAT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RepeatStmtContext* repeatStmt();

  class  RepetitionContext : public antlr4::ParserRuleContext {
  public:
    RepetitionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RepetitionContext* repetition();

  class  ResourceOrRenameContext : public antlr4::ParserRuleContext {
  public:
    ResourceOrRenameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ResourceRefContext *resourceRef();
    antlr4::tree::TerminalNode *AS();
    RenameIdContext *renameId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ResourceOrRenameContext* resourceOrRename();

  class  ResourceRefContext : public antlr4::ParserRuleContext {
  public:
    ResourceRefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConstantRefContext *constantRef();
    EntityRefContext *entityRef();
    FunctionRefContext *functionRef();
    ProcedureRefContext *procedureRef();
    TypeRefContext *typeRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ResourceRefContext* resourceRef();

  class  ReturnStmtContext : public antlr4::ParserRuleContext {
  public:
    ReturnStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RETURN();
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ReturnStmtContext* returnStmt();

  class  RuleDeclContext : public antlr4::ParserRuleContext {
  public:
    RuleDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    RuleHeadContext *ruleHead();
    AlgorithmHeadContext *algorithmHead();
    WhereClauseContext *whereClause();
    antlr4::tree::TerminalNode *END_RULE();
    std::vector<StmtContext *> stmt();
    StmtContext* stmt(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleDeclContext* ruleDecl();

  class  RuleHeadContext : public antlr4::ParserRuleContext {
  public:
    RuleHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RULE();
    RuleIdContext *ruleId();
    antlr4::tree::TerminalNode *FOR();
    std::vector<EntityRefContext *> entityRef();
    EntityRefContext* entityRef(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleHeadContext* ruleHead();

  class  RuleIdContext : public antlr4::ParserRuleContext {
  public:
    RuleIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleIdContext* ruleId();

  class  RuleLabelIdContext : public antlr4::ParserRuleContext {
  public:
    RuleLabelIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  RuleLabelIdContext* ruleLabelId();

  class  SchemaBodyContext : public antlr4::ParserRuleContext {
  public:
    SchemaBodyContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<InterfaceSpecificationContext *> interfaceSpecification();
    InterfaceSpecificationContext* interfaceSpecification(size_t i);
    ConstantDeclContext *constantDecl();
    std::vector<SchemaBodyDeclarationContext *> schemaBodyDeclaration();
    SchemaBodyDeclarationContext* schemaBodyDeclaration(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaBodyContext* schemaBody();

  class  SchemaBodyDeclarationContext : public antlr4::ParserRuleContext {
  public:
    SchemaBodyDeclarationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    DeclarationContext *declaration();
    RuleDeclContext *ruleDecl();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaBodyDeclarationContext* schemaBodyDeclaration();

  class  SchemaDeclContext : public antlr4::ParserRuleContext {
  public:
    SchemaDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SCHEMA();
    SchemaIdContext *schemaId();
    SchemaBodyContext *schemaBody();
    antlr4::tree::TerminalNode *END_SCHEMA();
    SchemaVersionIdContext *schemaVersionId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaDeclContext* schemaDecl();

  class  SchemaIdContext : public antlr4::ParserRuleContext {
  public:
    SchemaIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaIdContext* schemaId();

  class  SchemaVersionIdContext : public antlr4::ParserRuleContext {
  public:
    SchemaVersionIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    StringLiteralContext *stringLiteral();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SchemaVersionIdContext* schemaVersionId();

  class  SelectorContext : public antlr4::ParserRuleContext {
  public:
    SelectorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SelectorContext* selector();

  class  SelectExtensionContext : public antlr4::ParserRuleContext {
  public:
    SelectExtensionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BASED_ON();
    TypeRefContext *typeRef();
    antlr4::tree::TerminalNode *WITH();
    SelectListContext *selectList();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SelectExtensionContext* selectExtension();

  class  SelectListContext : public antlr4::ParserRuleContext {
  public:
    SelectListContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<NamedTypesContext *> namedTypes();
    NamedTypesContext* namedTypes(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SelectListContext* selectList();

  class  SelectTypeContext : public antlr4::ParserRuleContext {
  public:
    SelectTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SELECT();
    antlr4::tree::TerminalNode *EXTENSIBLE();
    SelectListContext *selectList();
    SelectExtensionContext *selectExtension();
    antlr4::tree::TerminalNode *GENERIC_ENTITY();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SelectTypeContext* selectType();

  class  SetTypeContext : public antlr4::ParserRuleContext {
  public:
    SetTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SET();
    antlr4::tree::TerminalNode *OF();
    InstantiableTypeContext *instantiableType();
    BoundSpecContext *boundSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SetTypeContext* setType();

  class  SimpleExpressionContext : public antlr4::ParserRuleContext {
  public:
    SimpleExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<TermContext *> term();
    TermContext* term(size_t i);
    std::vector<AddLikeOpContext *> addLikeOp();
    AddLikeOpContext* addLikeOp(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SimpleExpressionContext* simpleExpression();

  class  SimpleFactorContext : public antlr4::ParserRuleContext {
  public:
    SimpleFactorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AggregateInitializerContext *aggregateInitializer();
    EntityConstructorContext *entityConstructor();
    EnumerationReferenceContext *enumerationReference();
    IntervalContext *interval();
    QueryExpressionContext *queryExpression();
    SimpleFactorExpressionContext *simpleFactorExpression();
    SimpleFactorUnaryExpressionContext *simpleFactorUnaryExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SimpleFactorContext* simpleFactor();

  class  SimpleFactorExpressionContext : public antlr4::ParserRuleContext {
  public:
    SimpleFactorExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExpressionContext *expression();
    PrimaryContext *primary();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SimpleFactorExpressionContext* simpleFactorExpression();

  class  SimpleFactorUnaryExpressionContext : public antlr4::ParserRuleContext {
  public:
    SimpleFactorUnaryExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    UnaryOpContext *unaryOp();
    SimpleFactorExpressionContext *simpleFactorExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SimpleFactorUnaryExpressionContext* simpleFactorUnaryExpression();

  class  SimpleTypesContext : public antlr4::ParserRuleContext {
  public:
    SimpleTypesContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    BinaryTypeContext *binaryType();
    BooleanTypeContext *booleanType();
    IntegerTypeContext *integerType();
    LogicalTypeContext *logicalType();
    NumberTypeContext *numberType();
    RealTypeContext *realType();
    StringTypeContext *stringType();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SimpleTypesContext* simpleTypes();

  class  SkipStmtContext : public antlr4::ParserRuleContext {
  public:
    SkipStmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SKIP_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SkipStmtContext* skipStmt();

  class  StmtContext : public antlr4::ParserRuleContext {
  public:
    StmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AliasStmtContext *aliasStmt();
    AssignmentStmtContext *assignmentStmt();
    CaseStmtContext *caseStmt();
    CompoundStmtContext *compoundStmt();
    EscapeStmtContext *escapeStmt();
    IfStmtContext *ifStmt();
    NullStmtContext *nullStmt();
    ProcedureCallStmtContext *procedureCallStmt();
    RepeatStmtContext *repeatStmt();
    ReturnStmtContext *returnStmt();
    SkipStmtContext *skipStmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  StmtContext* stmt();

  class  StringLiteralContext : public antlr4::ParserRuleContext {
  public:
    StringLiteralContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleStringLiteral();
    antlr4::tree::TerminalNode *EncodedStringLiteral();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  StringLiteralContext* stringLiteral();

  class  StringTypeContext : public antlr4::ParserRuleContext {
  public:
    StringTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STRING();
    WidthSpecContext *widthSpec();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  StringTypeContext* stringType();

  class  SubsuperContext : public antlr4::ParserRuleContext {
  public:
    SubsuperContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SupertypeConstraintContext *supertypeConstraint();
    SubtypeDeclarationContext *subtypeDeclaration();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubsuperContext* subsuper();

  class  SubtypeConstraintContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OF();
    SupertypeExpressionContext *supertypeExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintContext* subtypeConstraint();

  class  SubtypeConstraintBodyContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintBodyContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AbstractSupertypeContext *abstractSupertype();
    TotalOverContext *totalOver();
    SupertypeExpressionContext *supertypeExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintBodyContext* subtypeConstraintBody();

  class  SubtypeConstraintDeclContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    SubtypeConstraintHeadContext *subtypeConstraintHead();
    SubtypeConstraintBodyContext *subtypeConstraintBody();
    antlr4::tree::TerminalNode *END_SUBTYPE_CONSTRAINT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintDeclContext* subtypeConstraintDecl();

  class  SubtypeConstraintHeadContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintHeadContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SUBTYPE_CONSTRAINT();
    SubtypeConstraintIdContext *subtypeConstraintId();
    antlr4::tree::TerminalNode *FOR();
    EntityRefContext *entityRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintHeadContext* subtypeConstraintHead();

  class  SubtypeConstraintIdContext : public antlr4::ParserRuleContext {
  public:
    SubtypeConstraintIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeConstraintIdContext* subtypeConstraintId();

  class  SubtypeDeclarationContext : public antlr4::ParserRuleContext {
  public:
    SubtypeDeclarationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SUBTYPE();
    antlr4::tree::TerminalNode *OF();
    std::vector<EntityRefContext *> entityRef();
    EntityRefContext* entityRef(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SubtypeDeclarationContext* subtypeDeclaration();

  class  SupertypeConstraintContext : public antlr4::ParserRuleContext {
  public:
    SupertypeConstraintContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    AbstractEntityDeclarationContext *abstractEntityDeclaration();
    AbstractSupertypeDeclarationContext *abstractSupertypeDeclaration();
    SupertypeRuleContext *supertypeRule();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SupertypeConstraintContext* supertypeConstraint();

  class  SupertypeExpressionContext : public antlr4::ParserRuleContext {
  public:
    SupertypeExpressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<SupertypeFactorContext *> supertypeFactor();
    SupertypeFactorContext* supertypeFactor(size_t i);
    std::vector<antlr4::tree::TerminalNode *> ANDOR();
    antlr4::tree::TerminalNode* ANDOR(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SupertypeExpressionContext* supertypeExpression();

  class  SupertypeFactorContext : public antlr4::ParserRuleContext {
  public:
    SupertypeFactorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<SupertypeTermContext *> supertypeTerm();
    SupertypeTermContext* supertypeTerm(size_t i);
    std::vector<antlr4::tree::TerminalNode *> AND();
    antlr4::tree::TerminalNode* AND(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SupertypeFactorContext* supertypeFactor();

  class  SupertypeRuleContext : public antlr4::ParserRuleContext {
  public:
    SupertypeRuleContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SUPERTYPE();
    SubtypeConstraintContext *subtypeConstraint();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SupertypeRuleContext* supertypeRule();

  class  SupertypeTermContext : public antlr4::ParserRuleContext {
  public:
    SupertypeTermContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    EntityRefContext *entityRef();
    OneOfContext *oneOf();
    SupertypeExpressionContext *supertypeExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SupertypeTermContext* supertypeTerm();

  class  SyntaxContext : public antlr4::ParserRuleContext {
  public:
    SyntaxContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *EOF();
    std::vector<SchemaDeclContext *> schemaDecl();
    SchemaDeclContext* schemaDecl(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  SyntaxContext* syntax();

  class  TermContext : public antlr4::ParserRuleContext {
  public:
    TermContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<FactorContext *> factor();
    FactorContext* factor(size_t i);
    std::vector<MultiplicationLikeOpContext *> multiplicationLikeOp();
    MultiplicationLikeOpContext* multiplicationLikeOp(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TermContext* term();

  class  TotalOverContext : public antlr4::ParserRuleContext {
  public:
    TotalOverContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *TOTAL_OVER();
    std::vector<EntityRefContext *> entityRef();
    EntityRefContext* entityRef(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TotalOverContext* totalOver();

  class  TypeDeclContext : public antlr4::ParserRuleContext {
  public:
    TypeDeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *TYPE();
    TypeIdContext *typeId();
    UnderlyingTypeContext *underlyingType();
    antlr4::tree::TerminalNode *END_TYPE();
    WhereClauseContext *whereClause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeDeclContext* typeDecl();

  class  TypeIdContext : public antlr4::ParserRuleContext {
  public:
    TypeIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeIdContext* typeId();

  class  TypeLabelContext : public antlr4::ParserRuleContext {
  public:
    TypeLabelContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    TypeLabelIdContext *typeLabelId();
    TypeLabelRefContext *typeLabelRef();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeLabelContext* typeLabel();

  class  TypeLabelIdContext : public antlr4::ParserRuleContext {
  public:
    TypeLabelIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeLabelIdContext* typeLabelId();

  class  UnaryOpContext : public antlr4::ParserRuleContext {
  public:
    UnaryOpContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *NOT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UnaryOpContext* unaryOp();

  class  UnderlyingTypeContext : public antlr4::ParserRuleContext {
  public:
    UnderlyingTypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ConcreteTypesContext *concreteTypes();
    ConstructedTypesContext *constructedTypes();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UnderlyingTypeContext* underlyingType();

  class  UniqueClauseContext : public antlr4::ParserRuleContext {
  public:
    UniqueClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *UNIQUE();
    std::vector<UniqueRuleContext *> uniqueRule();
    UniqueRuleContext* uniqueRule(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UniqueClauseContext* uniqueClause();

  class  UniqueRuleContext : public antlr4::ParserRuleContext {
  public:
    UniqueRuleContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ReferencedAttributeContext *> referencedAttribute();
    ReferencedAttributeContext* referencedAttribute(size_t i);
    RuleLabelIdContext *ruleLabelId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UniqueRuleContext* uniqueRule();

  class  UntilControlContext : public antlr4::ParserRuleContext {
  public:
    UntilControlContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *UNTIL();
    LogicalExpressionContext *logicalExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UntilControlContext* untilControl();

  class  UseClauseContext : public antlr4::ParserRuleContext {
  public:
    UseClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *USE();
    antlr4::tree::TerminalNode *FROM();
    SchemaRefContext *schemaRef();
    std::vector<NamedTypeOrRenameContext *> namedTypeOrRename();
    NamedTypeOrRenameContext* namedTypeOrRename(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  UseClauseContext* useClause();

  class  VariableIdContext : public antlr4::ParserRuleContext {
  public:
    VariableIdContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SimpleId();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  VariableIdContext* variableId();

  class  WhereClauseContext : public antlr4::ParserRuleContext {
  public:
    WhereClauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *WHERE();
    std::vector<DomainRuleContext *> domainRule();
    DomainRuleContext* domainRule(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  WhereClauseContext* whereClause();

  class  WhileControlContext : public antlr4::ParserRuleContext {
  public:
    WhileControlContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *WHILE();
    LogicalExpressionContext *logicalExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  WhileControlContext* whileControl();

  class  WidthContext : public antlr4::ParserRuleContext {
  public:
    WidthContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NumericExpressionContext *numericExpression();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  WidthContext* width();

  class  WidthSpecContext : public antlr4::ParserRuleContext {
  public:
    WidthSpecContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    WidthContext *width();
    antlr4::tree::TerminalNode *FIXED();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;

    virtual antlrcpp::Any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  WidthSpecContext* widthSpec();


private:
  static std::vector<antlr4::dfa::DFA> _decisionToDFA;
  static antlr4::atn::PredictionContextCache _sharedContextCache;
  static std::vector<std::string> _ruleNames;
  static std::vector<std::string> _tokenNames;

  static std::vector<std::string> _literalNames;
  static std::vector<std::string> _symbolicNames;
  static antlr4::dfa::Vocabulary _vocabulary;
  static antlr4::atn::ATN _atn;
  static std::vector<uint16_t> _serializedATN;


  struct Initializer {
    Initializer();
  };
  static Initializer _init;
};

