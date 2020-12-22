#include <iostream>

#include "antlr4-runtime.h"

#include "ExpressParser.h"
#include "ExpressBaseVisitor.h"
#include "ExpressLexer.h"

#include "rice/Array.hpp"
#include "rice/Class.hpp"
#include "rice/Constructor.hpp"
#include "rice/Director.hpp"

#ifdef _WIN32
#undef FALSE
#undef TRUE
#undef OPTIONAL
#undef IN
#undef OUT
#endif

using namespace std;
using namespace Rice;
using namespace antlr4;

Class rb_cAttributeRefContext;
Class rb_cAttributeIdContext;
Class rb_cConstantRefContext;
Class rb_cConstantIdContext;
Class rb_cEntityRefContext;
Class rb_cEntityIdContext;
Class rb_cEnumerationRefContext;
Class rb_cEnumerationIdContext;
Class rb_cFunctionRefContext;
Class rb_cFunctionIdContext;
Class rb_cParameterRefContext;
Class rb_cParameterIdContext;
Class rb_cProcedureRefContext;
Class rb_cProcedureIdContext;
Class rb_cRuleLabelRefContext;
Class rb_cRuleLabelIdContext;
Class rb_cRuleRefContext;
Class rb_cRuleIdContext;
Class rb_cSchemaRefContext;
Class rb_cSchemaIdContext;
Class rb_cSubtypeConstraintRefContext;
Class rb_cSubtypeConstraintIdContext;
Class rb_cTypeLabelRefContext;
Class rb_cTypeLabelIdContext;
Class rb_cTypeRefContext;
Class rb_cTypeIdContext;
Class rb_cVariableRefContext;
Class rb_cVariableIdContext;
Class rb_cAbstractEntityDeclarationContext;
Class rb_cAbstractSupertypeContext;
Class rb_cAbstractSupertypeDeclarationContext;
Class rb_cSubtypeConstraintContext;
Class rb_cActualParameterListContext;
Class rb_cParameterContext;
Class rb_cAddLikeOpContext;
Class rb_cAggregateInitializerContext;
Class rb_cElementContext;
Class rb_cAggregateSourceContext;
Class rb_cSimpleExpressionContext;
Class rb_cAggregateTypeContext;
Class rb_cParameterTypeContext;
Class rb_cTypeLabelContext;
Class rb_cAggregationTypesContext;
Class rb_cArrayTypeContext;
Class rb_cBagTypeContext;
Class rb_cListTypeContext;
Class rb_cSetTypeContext;
Class rb_cAlgorithmHeadContext;
Class rb_cDeclarationContext;
Class rb_cConstantDeclContext;
Class rb_cLocalDeclContext;
Class rb_cAliasStmtContext;
Class rb_cGeneralRefContext;
Class rb_cStmtContext;
Class rb_cQualifierContext;
Class rb_cBoundSpecContext;
Class rb_cInstantiableTypeContext;
Class rb_cAssignmentStmtContext;
Class rb_cExpressionContext;
Class rb_cAttributeDeclContext;
Class rb_cRedeclaredAttributeContext;
Class rb_cAttributeQualifierContext;
Class rb_cBinaryTypeContext;
Class rb_cWidthSpecContext;
Class rb_cBooleanTypeContext;
Class rb_cBound1Context;
Class rb_cNumericExpressionContext;
Class rb_cBound2Context;
Class rb_cBuiltInConstantContext;
Class rb_cBuiltInFunctionContext;
Class rb_cBuiltInProcedureContext;
Class rb_cCaseActionContext;
Class rb_cCaseLabelContext;
Class rb_cCaseStmtContext;
Class rb_cSelectorContext;
Class rb_cCompoundStmtContext;
Class rb_cConcreteTypesContext;
Class rb_cSimpleTypesContext;
Class rb_cConstantBodyContext;
Class rb_cConstantFactorContext;
Class rb_cConstructedTypesContext;
Class rb_cEnumerationTypeContext;
Class rb_cSelectTypeContext;
Class rb_cEntityDeclContext;
Class rb_cFunctionDeclContext;
Class rb_cProcedureDeclContext;
Class rb_cSubtypeConstraintDeclContext;
Class rb_cTypeDeclContext;
Class rb_cDerivedAttrContext;
Class rb_cDeriveClauseContext;
Class rb_cDomainRuleContext;
Class rb_cRepetitionContext;
Class rb_cEntityBodyContext;
Class rb_cExplicitAttrContext;
Class rb_cInverseClauseContext;
Class rb_cUniqueClauseContext;
Class rb_cWhereClauseContext;
Class rb_cEntityConstructorContext;
Class rb_cEntityHeadContext;
Class rb_cSubsuperContext;
Class rb_cEnumerationExtensionContext;
Class rb_cEnumerationItemsContext;
Class rb_cEnumerationItemContext;
Class rb_cEnumerationReferenceContext;
Class rb_cEscapeStmtContext;
Class rb_cRelOpExtendedContext;
Class rb_cFactorContext;
Class rb_cSimpleFactorContext;
Class rb_cFormalParameterContext;
Class rb_cFunctionCallContext;
Class rb_cFunctionHeadContext;
Class rb_cGeneralizedTypesContext;
Class rb_cGeneralAggregationTypesContext;
Class rb_cGenericEntityTypeContext;
Class rb_cGenericTypeContext;
Class rb_cGeneralArrayTypeContext;
Class rb_cGeneralBagTypeContext;
Class rb_cGeneralListTypeContext;
Class rb_cGeneralSetTypeContext;
Class rb_cGroupQualifierContext;
Class rb_cIfStmtContext;
Class rb_cLogicalExpressionContext;
Class rb_cIfStmtStatementsContext;
Class rb_cIfStmtElseStatementsContext;
Class rb_cIncrementContext;
Class rb_cIncrementControlContext;
Class rb_cIndexContext;
Class rb_cIndex1Context;
Class rb_cIndex2Context;
Class rb_cIndexQualifierContext;
Class rb_cIntegerTypeContext;
Class rb_cInterfaceSpecificationContext;
Class rb_cReferenceClauseContext;
Class rb_cUseClauseContext;
Class rb_cIntervalContext;
Class rb_cIntervalLowContext;
Class rb_cIntervalOpContext;
Class rb_cIntervalItemContext;
Class rb_cIntervalHighContext;
Class rb_cInverseAttrContext;
Class rb_cInverseAttrTypeContext;
Class rb_cLiteralContext;
Class rb_cLogicalLiteralContext;
Class rb_cStringLiteralContext;
Class rb_cLocalVariableContext;
Class rb_cLogicalTypeContext;
Class rb_cMultiplicationLikeOpContext;
Class rb_cNamedTypesContext;
Class rb_cNamedTypeOrRenameContext;
Class rb_cNullStmtContext;
Class rb_cNumberTypeContext;
Class rb_cOneOfContext;
Class rb_cSupertypeExpressionContext;
Class rb_cPopulationContext;
Class rb_cPrecisionSpecContext;
Class rb_cPrimaryContext;
Class rb_cQualifiableFactorContext;
Class rb_cProcedureCallStmtContext;
Class rb_cProcedureHeadContext;
Class rb_cProcedureHeadParameterContext;
Class rb_cQualifiedAttributeContext;
Class rb_cQueryExpressionContext;
Class rb_cRealTypeContext;
Class rb_cReferencedAttributeContext;
Class rb_cResourceOrRenameContext;
Class rb_cRelOpContext;
Class rb_cRenameIdContext;
Class rb_cRepeatControlContext;
Class rb_cWhileControlContext;
Class rb_cUntilControlContext;
Class rb_cRepeatStmtContext;
Class rb_cResourceRefContext;
Class rb_cReturnStmtContext;
Class rb_cRuleDeclContext;
Class rb_cRuleHeadContext;
Class rb_cSchemaBodyContext;
Class rb_cSchemaBodyDeclarationContext;
Class rb_cSchemaDeclContext;
Class rb_cSchemaVersionIdContext;
Class rb_cSelectExtensionContext;
Class rb_cSelectListContext;
Class rb_cTermContext;
Class rb_cSimpleFactorExpressionContext;
Class rb_cSimpleFactorUnaryExpressionContext;
Class rb_cUnaryOpContext;
Class rb_cStringTypeContext;
Class rb_cSkipStmtContext;
Class rb_cSupertypeConstraintContext;
Class rb_cSubtypeDeclarationContext;
Class rb_cSubtypeConstraintBodyContext;
Class rb_cTotalOverContext;
Class rb_cSubtypeConstraintHeadContext;
Class rb_cSupertypeRuleContext;
Class rb_cSupertypeFactorContext;
Class rb_cSupertypeTermContext;
Class rb_cSyntaxContext;
Class rb_cUnderlyingTypeContext;
Class rb_cUniqueRuleContext;
Class rb_cWidthContext;
Class rb_cToken;
Class rb_cParser;
Class rb_cParseTree;
Class rb_cTerminalNode;
Class rb_cContextProxy;

class ContextProxy {
public:
  ContextProxy(tree::ParseTree* orig) {
    this -> orig = orig;
  }

  tree::ParseTree* getOriginal() {
    return orig;
  }

  std::string getText() {
    return orig -> getText();
  }

  Array getChildren() {
    if (children == nullptr) {
      children = new Array();

      if (orig != nullptr) {
        for (auto it = orig -> children.begin(); it != orig -> children.end(); it ++) {
          Object parseTree = ContextProxy::wrapParseTree(*it);

          if (parseTree != Nil) {
            children -> push(parseTree);
          }
        }
      }
    }

    return *children;
  }

  Object getParent() {
    if (parent == Nil) {
      if (orig != nullptr) {
        parent = ContextProxy::wrapParseTree(orig -> parent);
      }
    }

    return parent;
  }

  size_t childCount() {
    if (orig == nullptr) {
      return 0;
    }

    return getChildren().size();
  }

  bool doubleEquals(Object other) {
    if (other.is_a(rb_cContextProxy)) {
      return from_ruby<ContextProxy*>(other) -> getOriginal() == getOriginal();
    } else {
      return false;
    }
  }

private:

  static Object wrapParseTree(tree::ParseTree* node);

protected:
  tree::ParseTree* orig = nullptr;
  Array* children = nullptr;
  Object parent = Nil;
};

class TerminalNodeProxy : public ContextProxy {
public:
  TerminalNodeProxy(tree::ParseTree* tree) : ContextProxy(tree) { }
};

class AttributeRefContextProxy : public ContextProxy {
public:
  AttributeRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeId();

};

class AttributeIdContextProxy : public ContextProxy {
public:
  AttributeIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class ConstantRefContextProxy : public ContextProxy {
public:
  ConstantRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object constantId();

};

class ConstantIdContextProxy : public ContextProxy {
public:
  ConstantIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class EntityRefContextProxy : public ContextProxy {
public:
  EntityRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityId();

};

class EntityIdContextProxy : public ContextProxy {
public:
  EntityIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class EnumerationRefContextProxy : public ContextProxy {
public:
  EnumerationRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationId();

};

class EnumerationIdContextProxy : public ContextProxy {
public:
  EnumerationIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class FunctionRefContextProxy : public ContextProxy {
public:
  FunctionRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object functionId();

};

class FunctionIdContextProxy : public ContextProxy {
public:
  FunctionIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class ParameterRefContextProxy : public ContextProxy {
public:
  ParameterRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterId();

};

class ParameterIdContextProxy : public ContextProxy {
public:
  ParameterIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class ProcedureRefContextProxy : public ContextProxy {
public:
  ProcedureRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object procedureId();

};

class ProcedureIdContextProxy : public ContextProxy {
public:
  ProcedureIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class RuleLabelRefContextProxy : public ContextProxy {
public:
  RuleLabelRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object ruleLabelId();

};

class RuleLabelIdContextProxy : public ContextProxy {
public:
  RuleLabelIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class RuleRefContextProxy : public ContextProxy {
public:
  RuleRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object ruleId();

};

class RuleIdContextProxy : public ContextProxy {
public:
  RuleIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class SchemaRefContextProxy : public ContextProxy {
public:
  SchemaRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object schemaId();

};

class SchemaIdContextProxy : public ContextProxy {
public:
  SchemaIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class SubtypeConstraintRefContextProxy : public ContextProxy {
public:
  SubtypeConstraintRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object subtypeConstraintId();

};

class SubtypeConstraintIdContextProxy : public ContextProxy {
public:
  SubtypeConstraintIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class TypeLabelRefContextProxy : public ContextProxy {
public:
  TypeLabelRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeLabelId();

};

class TypeLabelIdContextProxy : public ContextProxy {
public:
  TypeLabelIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class TypeRefContextProxy : public ContextProxy {
public:
  TypeRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeId();

};

class TypeIdContextProxy : public ContextProxy {
public:
  TypeIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class VariableRefContextProxy : public ContextProxy {
public:
  VariableRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object variableId();

};

class VariableIdContextProxy : public ContextProxy {
public:
  VariableIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleId();
};

class AbstractEntityDeclarationContextProxy : public ContextProxy {
public:
  AbstractEntityDeclarationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object ABSTRACT();
};

class AbstractSupertypeContextProxy : public ContextProxy {
public:
  AbstractSupertypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object ABSTRACT();
  Object SUPERTYPE();
};

class AbstractSupertypeDeclarationContextProxy : public ContextProxy {
public:
  AbstractSupertypeDeclarationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object subtypeConstraint();
  Object ABSTRACT();
  Object SUPERTYPE();
};

class SubtypeConstraintContextProxy : public ContextProxy {
public:
  SubtypeConstraintContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object supertypeExpression();
  Object OF();
};

class ActualParameterListContextProxy : public ContextProxy {
public:
  ActualParameterListContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameter();
  Object parameterAt(size_t i);

};

class ParameterContextProxy : public ContextProxy {
public:
  ParameterContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();

};

class AddLikeOpContextProxy : public ContextProxy {
public:
  AddLikeOpContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object OR();
  Object XOR();
};

class AggregateInitializerContextProxy : public ContextProxy {
public:
  AggregateInitializerContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object element();
  Object elementAt(size_t i);

};

class ElementContextProxy : public ContextProxy {
public:
  ElementContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();
  Object repetition();

};

class AggregateSourceContextProxy : public ContextProxy {
public:
  AggregateSourceContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();

};

class SimpleExpressionContextProxy : public ContextProxy {
public:
  SimpleExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object term();
  Object termAt(size_t i);
  Object addLikeOp();
  Object addLikeOpAt(size_t i);

};

class AggregateTypeContextProxy : public ContextProxy {
public:
  AggregateTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterType();
  Object typeLabel();
  Object AGGREGATE();
  Object OF();
};

class ParameterTypeContextProxy : public ContextProxy {
public:
  ParameterTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object generalizedTypes();
  Object namedTypes();
  Object simpleTypes();

};

class TypeLabelContextProxy : public ContextProxy {
public:
  TypeLabelContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeLabelId();
  Object typeLabelRef();

};

class AggregationTypesContextProxy : public ContextProxy {
public:
  AggregationTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object arrayType();
  Object bagType();
  Object listType();
  Object setType();

};

class ArrayTypeContextProxy : public ContextProxy {
public:
  ArrayTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object boundSpec();
  Object instantiableType();
  Object ARRAY();
  Object OF();
  Object OPTIONAL();
  Object UNIQUE();
};

class BagTypeContextProxy : public ContextProxy {
public:
  BagTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object instantiableType();
  Object boundSpec();
  Object BAG();
  Object OF();
};

class ListTypeContextProxy : public ContextProxy {
public:
  ListTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object instantiableType();
  Object boundSpec();
  Object LIST();
  Object OF();
  Object UNIQUE();
};

class SetTypeContextProxy : public ContextProxy {
public:
  SetTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object instantiableType();
  Object boundSpec();
  Object SET();
  Object OF();
};

class AlgorithmHeadContextProxy : public ContextProxy {
public:
  AlgorithmHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object declaration();
  Object declarationAt(size_t i);
  Object constantDecl();
  Object localDecl();

};

class DeclarationContextProxy : public ContextProxy {
public:
  DeclarationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityDecl();
  Object functionDecl();
  Object procedureDecl();
  Object subtypeConstraintDecl();
  Object typeDecl();

};

class ConstantDeclContextProxy : public ContextProxy {
public:
  ConstantDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object constantBody();
  Object constantBodyAt(size_t i);
  Object CONSTANT();
  Object END_CONSTANT();
};

class LocalDeclContextProxy : public ContextProxy {
public:
  LocalDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object localVariable();
  Object localVariableAt(size_t i);
  Object LOCAL();
  Object END_LOCAL();
};

class AliasStmtContextProxy : public ContextProxy {
public:
  AliasStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object variableId();
  Object generalRef();
  Object stmt();
  Object stmtAt(size_t i);
  Object qualifier();
  Object qualifierAt(size_t i);
  Object ALIAS();
  Object FOR();
  Object END_ALIAS();
};

class GeneralRefContextProxy : public ContextProxy {
public:
  GeneralRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterRef();
  Object variableId();

};

class StmtContextProxy : public ContextProxy {
public:
  StmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object aliasStmt();
  Object assignmentStmt();
  Object caseStmt();
  Object compoundStmt();
  Object escapeStmt();
  Object ifStmt();
  Object nullStmt();
  Object procedureCallStmt();
  Object repeatStmt();
  Object returnStmt();
  Object skipStmt();

};

class QualifierContextProxy : public ContextProxy {
public:
  QualifierContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeQualifier();
  Object groupQualifier();
  Object indexQualifier();

};

class BoundSpecContextProxy : public ContextProxy {
public:
  BoundSpecContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object bound1();
  Object bound2();

};

class InstantiableTypeContextProxy : public ContextProxy {
public:
  InstantiableTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object concreteTypes();
  Object entityRef();

};

class AssignmentStmtContextProxy : public ContextProxy {
public:
  AssignmentStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object generalRef();
  Object expression();
  Object qualifier();
  Object qualifierAt(size_t i);

};

class ExpressionContextProxy : public ContextProxy {
public:
  ExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();
  Object simpleExpressionAt(size_t i);
  Object relOpExtended();

};

class AttributeDeclContextProxy : public ContextProxy {
public:
  AttributeDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeId();
  Object redeclaredAttribute();

};

class RedeclaredAttributeContextProxy : public ContextProxy {
public:
  RedeclaredAttributeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object qualifiedAttribute();
  Object attributeId();
  Object RENAMED();
};

class AttributeQualifierContextProxy : public ContextProxy {
public:
  AttributeQualifierContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeRef();

};

class BinaryTypeContextProxy : public ContextProxy {
public:
  BinaryTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object widthSpec();
  Object BINARY();
};

class WidthSpecContextProxy : public ContextProxy {
public:
  WidthSpecContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object width();
  Object FIXED();
};

class BooleanTypeContextProxy : public ContextProxy {
public:
  BooleanTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object BOOLEAN();
};

class Bound1ContextProxy : public ContextProxy {
public:
  Bound1ContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class NumericExpressionContextProxy : public ContextProxy {
public:
  NumericExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();

};

class Bound2ContextProxy : public ContextProxy {
public:
  Bound2ContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class BuiltInConstantContextProxy : public ContextProxy {
public:
  BuiltInConstantContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object CONST_E();
  Object PI();
  Object SELF();
};

class BuiltInFunctionContextProxy : public ContextProxy {
public:
  BuiltInFunctionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object ABS();
  Object ACOS();
  Object ASIN();
  Object ATAN();
  Object BLENGTH();
  Object COS();
  Object EXISTS();
  Object EXP();
  Object FORMAT();
  Object HIBOUND();
  Object HIINDEX();
  Object LENGTH();
  Object LOBOUND();
  Object LOINDEX();
  Object LOG();
  Object LOG2();
  Object LOG10();
  Object NVL();
  Object ODD();
  Object ROLESOF();
  Object SIN();
  Object SIZEOF();
  Object SQRT();
  Object TAN();
  Object TYPEOF();
  Object USEDIN();
  Object VALUE_();
  Object VALUE_IN();
  Object VALUE_UNIQUE();
};

class BuiltInProcedureContextProxy : public ContextProxy {
public:
  BuiltInProcedureContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object INSERT();
  Object REMOVE();
};

class CaseActionContextProxy : public ContextProxy {
public:
  CaseActionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object caseLabel();
  Object caseLabelAt(size_t i);
  Object stmt();

};

class CaseLabelContextProxy : public ContextProxy {
public:
  CaseLabelContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();

};

class CaseStmtContextProxy : public ContextProxy {
public:
  CaseStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object selector();
  Object caseAction();
  Object caseActionAt(size_t i);
  Object stmt();
  Object CASE();
  Object OF();
  Object END_CASE();
  Object OTHERWISE();
};

class SelectorContextProxy : public ContextProxy {
public:
  SelectorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();

};

class CompoundStmtContextProxy : public ContextProxy {
public:
  CompoundStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object stmt();
  Object stmtAt(size_t i);
  Object BEGIN_();
  Object END_();
};

class ConcreteTypesContextProxy : public ContextProxy {
public:
  ConcreteTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object aggregationTypes();
  Object simpleTypes();
  Object typeRef();

};

class SimpleTypesContextProxy : public ContextProxy {
public:
  SimpleTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object binaryType();
  Object booleanType();
  Object integerType();
  Object logicalType();
  Object numberType();
  Object realType();
  Object stringType();

};

class ConstantBodyContextProxy : public ContextProxy {
public:
  ConstantBodyContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object constantId();
  Object instantiableType();
  Object expression();

};

class ConstantFactorContextProxy : public ContextProxy {
public:
  ConstantFactorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object builtInConstant();
  Object constantRef();

};

class ConstructedTypesContextProxy : public ContextProxy {
public:
  ConstructedTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationType();
  Object selectType();

};

class EnumerationTypeContextProxy : public ContextProxy {
public:
  EnumerationTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationItems();
  Object enumerationExtension();
  Object ENUMERATION();
  Object EXTENSIBLE();
  Object OF();
};

class SelectTypeContextProxy : public ContextProxy {
public:
  SelectTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object selectList();
  Object selectExtension();
  Object SELECT();
  Object EXTENSIBLE();
  Object GENERIC_ENTITY();
};

class EntityDeclContextProxy : public ContextProxy {
public:
  EntityDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityHead();
  Object entityBody();
  Object END_ENTITY();
};

class FunctionDeclContextProxy : public ContextProxy {
public:
  FunctionDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object functionHead();
  Object algorithmHead();
  Object stmt();
  Object stmtAt(size_t i);
  Object END_FUNCTION();
};

class ProcedureDeclContextProxy : public ContextProxy {
public:
  ProcedureDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object procedureHead();
  Object algorithmHead();
  Object stmt();
  Object stmtAt(size_t i);
  Object END_PROCEDURE();
};

class SubtypeConstraintDeclContextProxy : public ContextProxy {
public:
  SubtypeConstraintDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object subtypeConstraintHead();
  Object subtypeConstraintBody();
  Object END_SUBTYPE_CONSTRAINT();
};

class TypeDeclContextProxy : public ContextProxy {
public:
  TypeDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeId();
  Object underlyingType();
  Object whereClause();
  Object TYPE();
  Object END_TYPE();
};

class DerivedAttrContextProxy : public ContextProxy {
public:
  DerivedAttrContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeDecl();
  Object parameterType();
  Object expression();

};

class DeriveClauseContextProxy : public ContextProxy {
public:
  DeriveClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object derivedAttr();
  Object derivedAttrAt(size_t i);
  Object DERIVE();
};

class DomainRuleContextProxy : public ContextProxy {
public:
  DomainRuleContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();
  Object ruleLabelId();

};

class RepetitionContextProxy : public ContextProxy {
public:
  RepetitionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class EntityBodyContextProxy : public ContextProxy {
public:
  EntityBodyContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object explicitAttr();
  Object explicitAttrAt(size_t i);
  Object deriveClause();
  Object inverseClause();
  Object uniqueClause();
  Object whereClause();

};

class ExplicitAttrContextProxy : public ContextProxy {
public:
  ExplicitAttrContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeDecl();
  Object attributeDeclAt(size_t i);
  Object parameterType();
  Object OPTIONAL();
};

class InverseClauseContextProxy : public ContextProxy {
public:
  InverseClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object inverseAttr();
  Object inverseAttrAt(size_t i);
  Object INVERSE();
};

class UniqueClauseContextProxy : public ContextProxy {
public:
  UniqueClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object uniqueRule();
  Object uniqueRuleAt(size_t i);
  Object UNIQUE();
};

class WhereClauseContextProxy : public ContextProxy {
public:
  WhereClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object domainRule();
  Object domainRuleAt(size_t i);
  Object WHERE();
};

class EntityConstructorContextProxy : public ContextProxy {
public:
  EntityConstructorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object expression();
  Object expressionAt(size_t i);

};

class EntityHeadContextProxy : public ContextProxy {
public:
  EntityHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityId();
  Object subsuper();
  Object ENTITY();
};

class SubsuperContextProxy : public ContextProxy {
public:
  SubsuperContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object supertypeConstraint();
  Object subtypeDeclaration();

};

class EnumerationExtensionContextProxy : public ContextProxy {
public:
  EnumerationExtensionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeRef();
  Object enumerationItems();
  Object BASED_ON();
  Object WITH();
};

class EnumerationItemsContextProxy : public ContextProxy {
public:
  EnumerationItemsContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationItem();
  Object enumerationItemAt(size_t i);

};

class EnumerationItemContextProxy : public ContextProxy {
public:
  EnumerationItemContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationId();

};

class EnumerationReferenceContextProxy : public ContextProxy {
public:
  EnumerationReferenceContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object enumerationRef();
  Object typeRef();

};

class EscapeStmtContextProxy : public ContextProxy {
public:
  EscapeStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object ESCAPE();
};

class RelOpExtendedContextProxy : public ContextProxy {
public:
  RelOpExtendedContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object relOp();
  Object IN();
  Object LIKE();
};

class FactorContextProxy : public ContextProxy {
public:
  FactorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleFactor();
  Object simpleFactorAt(size_t i);

};

class SimpleFactorContextProxy : public ContextProxy {
public:
  SimpleFactorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object aggregateInitializer();
  Object entityConstructor();
  Object enumerationReference();
  Object interval();
  Object queryExpression();
  Object simpleFactorExpression();
  Object simpleFactorUnaryExpression();

};

class FormalParameterContextProxy : public ContextProxy {
public:
  FormalParameterContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterId();
  Object parameterIdAt(size_t i);
  Object parameterType();

};

class FunctionCallContextProxy : public ContextProxy {
public:
  FunctionCallContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object builtInFunction();
  Object functionRef();
  Object actualParameterList();

};

class FunctionHeadContextProxy : public ContextProxy {
public:
  FunctionHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object functionId();
  Object parameterType();
  Object formalParameter();
  Object formalParameterAt(size_t i);
  Object FUNCTION();
};

class GeneralizedTypesContextProxy : public ContextProxy {
public:
  GeneralizedTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object aggregateType();
  Object generalAggregationTypes();
  Object genericEntityType();
  Object genericType();

};

class GeneralAggregationTypesContextProxy : public ContextProxy {
public:
  GeneralAggregationTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object generalArrayType();
  Object generalBagType();
  Object generalListType();
  Object generalSetType();

};

class GenericEntityTypeContextProxy : public ContextProxy {
public:
  GenericEntityTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeLabel();
  Object GENERIC_ENTITY();
};

class GenericTypeContextProxy : public ContextProxy {
public:
  GenericTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeLabel();
  Object GENERIC();
};

class GeneralArrayTypeContextProxy : public ContextProxy {
public:
  GeneralArrayTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterType();
  Object boundSpec();
  Object ARRAY();
  Object OF();
  Object OPTIONAL();
  Object UNIQUE();
};

class GeneralBagTypeContextProxy : public ContextProxy {
public:
  GeneralBagTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterType();
  Object boundSpec();
  Object BAG();
  Object OF();
};

class GeneralListTypeContextProxy : public ContextProxy {
public:
  GeneralListTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterType();
  Object boundSpec();
  Object LIST();
  Object OF();
  Object UNIQUE();
};

class GeneralSetTypeContextProxy : public ContextProxy {
public:
  GeneralSetTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object parameterType();
  Object boundSpec();
  Object SET();
  Object OF();
};

class GroupQualifierContextProxy : public ContextProxy {
public:
  GroupQualifierContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();

};

class IfStmtContextProxy : public ContextProxy {
public:
  IfStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object logicalExpression();
  Object ifStmtStatements();
  Object ifStmtElseStatements();
  Object IF();
  Object THEN();
  Object END_IF();
  Object ELSE();
};

class LogicalExpressionContextProxy : public ContextProxy {
public:
  LogicalExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();

};

class IfStmtStatementsContextProxy : public ContextProxy {
public:
  IfStmtStatementsContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object stmt();
  Object stmtAt(size_t i);

};

class IfStmtElseStatementsContextProxy : public ContextProxy {
public:
  IfStmtElseStatementsContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object stmt();
  Object stmtAt(size_t i);

};

class IncrementContextProxy : public ContextProxy {
public:
  IncrementContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class IncrementControlContextProxy : public ContextProxy {
public:
  IncrementControlContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object variableId();
  Object bound1();
  Object bound2();
  Object increment();
  Object TO();
  Object BY();
};

class IndexContextProxy : public ContextProxy {
public:
  IndexContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class Index1ContextProxy : public ContextProxy {
public:
  Index1ContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object index();

};

class Index2ContextProxy : public ContextProxy {
public:
  Index2ContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object index();

};

class IndexQualifierContextProxy : public ContextProxy {
public:
  IndexQualifierContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object index1();
  Object index2();

};

class IntegerTypeContextProxy : public ContextProxy {
public:
  IntegerTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object INTEGER();
};

class InterfaceSpecificationContextProxy : public ContextProxy {
public:
  InterfaceSpecificationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object referenceClause();
  Object useClause();

};

class ReferenceClauseContextProxy : public ContextProxy {
public:
  ReferenceClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object schemaRef();
  Object resourceOrRename();
  Object resourceOrRenameAt(size_t i);
  Object REFERENCE();
  Object FROM();
};

class UseClauseContextProxy : public ContextProxy {
public:
  UseClauseContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object schemaRef();
  Object namedTypeOrRename();
  Object namedTypeOrRenameAt(size_t i);
  Object USE();
  Object FROM();
};

class IntervalContextProxy : public ContextProxy {
public:
  IntervalContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object intervalLow();
  Object intervalOp();
  Object intervalOpAt(size_t i);
  Object intervalItem();
  Object intervalHigh();

};

class IntervalLowContextProxy : public ContextProxy {
public:
  IntervalLowContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();

};

class IntervalOpContextProxy : public ContextProxy {
public:
  IntervalOpContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};


};

class IntervalItemContextProxy : public ContextProxy {
public:
  IntervalItemContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();

};

class IntervalHighContextProxy : public ContextProxy {
public:
  IntervalHighContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object simpleExpression();

};

class InverseAttrContextProxy : public ContextProxy {
public:
  InverseAttrContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeDecl();
  Object inverseAttrType();
  Object attributeRef();
  Object entityRef();
  Object FOR();
};

class InverseAttrTypeContextProxy : public ContextProxy {
public:
  InverseAttrTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object boundSpec();
  Object OF();
  Object SET();
  Object BAG();
};

class LiteralContextProxy : public ContextProxy {
public:
  LiteralContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object logicalLiteral();
  Object stringLiteral();
  Object BinaryLiteral();
  Object IntegerLiteral();
  Object RealLiteral();
};

class LogicalLiteralContextProxy : public ContextProxy {
public:
  LogicalLiteralContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object FALSE();
  Object TRUE();
  Object UNKNOWN();
};

class StringLiteralContextProxy : public ContextProxy {
public:
  StringLiteralContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SimpleStringLiteral();
  Object EncodedStringLiteral();
};

class LocalVariableContextProxy : public ContextProxy {
public:
  LocalVariableContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object variableId();
  Object variableIdAt(size_t i);
  Object parameterType();
  Object expression();

};

class LogicalTypeContextProxy : public ContextProxy {
public:
  LogicalTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object LOGICAL();
};

class MultiplicationLikeOpContextProxy : public ContextProxy {
public:
  MultiplicationLikeOpContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object DIV();
  Object MOD();
  Object AND();
};

class NamedTypesContextProxy : public ContextProxy {
public:
  NamedTypesContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object typeRef();

};

class NamedTypeOrRenameContextProxy : public ContextProxy {
public:
  NamedTypeOrRenameContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object namedTypes();
  Object entityId();
  Object typeId();
  Object AS();
};

class NullStmtContextProxy : public ContextProxy {
public:
  NullStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};


};

class NumberTypeContextProxy : public ContextProxy {
public:
  NumberTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object NUMBER();
};

class OneOfContextProxy : public ContextProxy {
public:
  OneOfContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object supertypeExpression();
  Object supertypeExpressionAt(size_t i);
  Object ONEOF();
};

class SupertypeExpressionContextProxy : public ContextProxy {
public:
  SupertypeExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object supertypeFactor();
  Object supertypeFactorAt(size_t i);
  Object ANDOR();
  Object ANDORAt(size_t i);
};

class PopulationContextProxy : public ContextProxy {
public:
  PopulationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();

};

class PrecisionSpecContextProxy : public ContextProxy {
public:
  PrecisionSpecContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};

class PrimaryContextProxy : public ContextProxy {
public:
  PrimaryContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object literal();
  Object qualifiableFactor();
  Object qualifier();
  Object qualifierAt(size_t i);

};

class QualifiableFactorContextProxy : public ContextProxy {
public:
  QualifiableFactorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeRef();
  Object constantFactor();
  Object functionCall();
  Object generalRef();
  Object population();

};

class ProcedureCallStmtContextProxy : public ContextProxy {
public:
  ProcedureCallStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object builtInProcedure();
  Object procedureRef();
  Object actualParameterList();

};

class ProcedureHeadContextProxy : public ContextProxy {
public:
  ProcedureHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object procedureId();
  Object procedureHeadParameter();
  Object procedureHeadParameterAt(size_t i);
  Object PROCEDURE();
};

class ProcedureHeadParameterContextProxy : public ContextProxy {
public:
  ProcedureHeadParameterContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object formalParameter();
  Object VAR();
};

class QualifiedAttributeContextProxy : public ContextProxy {
public:
  QualifiedAttributeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object groupQualifier();
  Object attributeQualifier();
  Object SELF();
};

class QueryExpressionContextProxy : public ContextProxy {
public:
  QueryExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object variableId();
  Object aggregateSource();
  Object logicalExpression();
  Object QUERY();
};

class RealTypeContextProxy : public ContextProxy {
public:
  RealTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object precisionSpec();
  Object REAL();
};

class ReferencedAttributeContextProxy : public ContextProxy {
public:
  ReferencedAttributeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object attributeRef();
  Object qualifiedAttribute();

};

class ResourceOrRenameContextProxy : public ContextProxy {
public:
  ResourceOrRenameContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object resourceRef();
  Object renameId();
  Object AS();
};

class RelOpContextProxy : public ContextProxy {
public:
  RelOpContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};


};

class RenameIdContextProxy : public ContextProxy {
public:
  RenameIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object constantId();
  Object entityId();
  Object functionId();
  Object procedureId();
  Object typeId();

};

class RepeatControlContextProxy : public ContextProxy {
public:
  RepeatControlContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object incrementControl();
  Object whileControl();
  Object untilControl();

};

class WhileControlContextProxy : public ContextProxy {
public:
  WhileControlContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object logicalExpression();
  Object WHILE();
};

class UntilControlContextProxy : public ContextProxy {
public:
  UntilControlContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object logicalExpression();
  Object UNTIL();
};

class RepeatStmtContextProxy : public ContextProxy {
public:
  RepeatStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object repeatControl();
  Object stmt();
  Object stmtAt(size_t i);
  Object REPEAT();
  Object END_REPEAT();
};

class ResourceRefContextProxy : public ContextProxy {
public:
  ResourceRefContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object constantRef();
  Object entityRef();
  Object functionRef();
  Object procedureRef();
  Object typeRef();

};

class ReturnStmtContextProxy : public ContextProxy {
public:
  ReturnStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();
  Object RETURN();
};

class RuleDeclContextProxy : public ContextProxy {
public:
  RuleDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object ruleHead();
  Object algorithmHead();
  Object whereClause();
  Object stmt();
  Object stmtAt(size_t i);
  Object END_RULE();
};

class RuleHeadContextProxy : public ContextProxy {
public:
  RuleHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object ruleId();
  Object entityRef();
  Object entityRefAt(size_t i);
  Object RULE();
  Object FOR();
};

class SchemaBodyContextProxy : public ContextProxy {
public:
  SchemaBodyContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object interfaceSpecification();
  Object interfaceSpecificationAt(size_t i);
  Object constantDecl();
  Object schemaBodyDeclaration();
  Object schemaBodyDeclarationAt(size_t i);

};

class SchemaBodyDeclarationContextProxy : public ContextProxy {
public:
  SchemaBodyDeclarationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object declaration();
  Object ruleDecl();

};

class SchemaDeclContextProxy : public ContextProxy {
public:
  SchemaDeclContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object schemaId();
  Object schemaBody();
  Object schemaVersionId();
  Object SCHEMA();
  Object END_SCHEMA();
};

class SchemaVersionIdContextProxy : public ContextProxy {
public:
  SchemaVersionIdContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object stringLiteral();

};

class SelectExtensionContextProxy : public ContextProxy {
public:
  SelectExtensionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object typeRef();
  Object selectList();
  Object BASED_ON();
  Object WITH();
};

class SelectListContextProxy : public ContextProxy {
public:
  SelectListContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object namedTypes();
  Object namedTypesAt(size_t i);

};

class TermContextProxy : public ContextProxy {
public:
  TermContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object factor();
  Object factorAt(size_t i);
  Object multiplicationLikeOp();
  Object multiplicationLikeOpAt(size_t i);

};

class SimpleFactorExpressionContextProxy : public ContextProxy {
public:
  SimpleFactorExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object expression();
  Object primary();

};

class SimpleFactorUnaryExpressionContextProxy : public ContextProxy {
public:
  SimpleFactorUnaryExpressionContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object unaryOp();
  Object simpleFactorExpression();

};

class UnaryOpContextProxy : public ContextProxy {
public:
  UnaryOpContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object NOT();
};

class StringTypeContextProxy : public ContextProxy {
public:
  StringTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object widthSpec();
  Object STRING();
};

class SkipStmtContextProxy : public ContextProxy {
public:
  SkipStmtContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};

  Object SKIP_();
};

class SupertypeConstraintContextProxy : public ContextProxy {
public:
  SupertypeConstraintContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object abstractEntityDeclaration();
  Object abstractSupertypeDeclaration();
  Object supertypeRule();

};

class SubtypeDeclarationContextProxy : public ContextProxy {
public:
  SubtypeDeclarationContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object entityRefAt(size_t i);
  Object SUBTYPE();
  Object OF();
};

class SubtypeConstraintBodyContextProxy : public ContextProxy {
public:
  SubtypeConstraintBodyContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object abstractSupertype();
  Object totalOver();
  Object supertypeExpression();

};

class TotalOverContextProxy : public ContextProxy {
public:
  TotalOverContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object entityRefAt(size_t i);
  Object TOTAL_OVER();
};

class SubtypeConstraintHeadContextProxy : public ContextProxy {
public:
  SubtypeConstraintHeadContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object subtypeConstraintId();
  Object entityRef();
  Object SUBTYPE_CONSTRAINT();
  Object FOR();
};

class SupertypeRuleContextProxy : public ContextProxy {
public:
  SupertypeRuleContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object subtypeConstraint();
  Object SUPERTYPE();
};

class SupertypeFactorContextProxy : public ContextProxy {
public:
  SupertypeFactorContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object supertypeTerm();
  Object supertypeTermAt(size_t i);
  Object AND();
  Object ANDAt(size_t i);
};

class SupertypeTermContextProxy : public ContextProxy {
public:
  SupertypeTermContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object entityRef();
  Object oneOf();
  Object supertypeExpression();

};

class SyntaxContextProxy : public ContextProxy {
public:
  SyntaxContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object schemaDecl();
  Object schemaDeclAt(size_t i);
  Object EOF();
};

class UnderlyingTypeContextProxy : public ContextProxy {
public:
  UnderlyingTypeContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object concreteTypes();
  Object constructedTypes();

};

class UniqueRuleContextProxy : public ContextProxy {
public:
  UniqueRuleContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object referencedAttribute();
  Object referencedAttributeAt(size_t i);
  Object ruleLabelId();

};

class WidthContextProxy : public ContextProxy {
public:
  WidthContextProxy(tree::ParseTree* ctx) : ContextProxy(ctx) {};
  Object numericExpression();

};


template <>
Object to_ruby<Token*>(Token* const &x) {
  if (!x) return Nil;
  return Data_Object<Token>(x, rb_cToken, nullptr, nullptr);
}

template <>
Object to_ruby<tree::ParseTree*>(tree::ParseTree* const &x) {
  if (!x) return Nil;
  return Data_Object<tree::ParseTree>(x, rb_cParseTree, nullptr, nullptr);
}

template <>
Object to_ruby<tree::TerminalNode*>(tree::TerminalNode* const &x) {
  if (!x) return Nil;
  return Data_Object<tree::TerminalNode>(x, rb_cTerminalNode, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AttributeRefContext*>(ExpressParser::AttributeRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AttributeRefContext>(x, rb_cAttributeRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<AttributeRefContextProxy*>(AttributeRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AttributeRefContextProxy>(x, rb_cAttributeRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AttributeIdContext*>(ExpressParser::AttributeIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AttributeIdContext>(x, rb_cAttributeIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<AttributeIdContextProxy*>(AttributeIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AttributeIdContextProxy>(x, rb_cAttributeIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstantRefContext*>(ExpressParser::ConstantRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstantRefContext>(x, rb_cConstantRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstantRefContextProxy*>(ConstantRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstantRefContextProxy>(x, rb_cConstantRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstantIdContext*>(ExpressParser::ConstantIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstantIdContext>(x, rb_cConstantIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstantIdContextProxy*>(ConstantIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstantIdContextProxy>(x, rb_cConstantIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityRefContext*>(ExpressParser::EntityRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityRefContext>(x, rb_cEntityRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityRefContextProxy*>(EntityRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityRefContextProxy>(x, rb_cEntityRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityIdContext*>(ExpressParser::EntityIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityIdContext>(x, rb_cEntityIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityIdContextProxy*>(EntityIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityIdContextProxy>(x, rb_cEntityIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationRefContext*>(ExpressParser::EnumerationRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationRefContext>(x, rb_cEnumerationRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationRefContextProxy*>(EnumerationRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationRefContextProxy>(x, rb_cEnumerationRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationIdContext*>(ExpressParser::EnumerationIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationIdContext>(x, rb_cEnumerationIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationIdContextProxy*>(EnumerationIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationIdContextProxy>(x, rb_cEnumerationIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FunctionRefContext*>(ExpressParser::FunctionRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FunctionRefContext>(x, rb_cFunctionRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<FunctionRefContextProxy*>(FunctionRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FunctionRefContextProxy>(x, rb_cFunctionRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FunctionIdContext*>(ExpressParser::FunctionIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FunctionIdContext>(x, rb_cFunctionIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<FunctionIdContextProxy*>(FunctionIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FunctionIdContextProxy>(x, rb_cFunctionIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ParameterRefContext*>(ExpressParser::ParameterRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ParameterRefContext>(x, rb_cParameterRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ParameterRefContextProxy*>(ParameterRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ParameterRefContextProxy>(x, rb_cParameterRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ParameterIdContext*>(ExpressParser::ParameterIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ParameterIdContext>(x, rb_cParameterIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ParameterIdContextProxy*>(ParameterIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ParameterIdContextProxy>(x, rb_cParameterIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureRefContext*>(ExpressParser::ProcedureRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureRefContext>(x, rb_cProcedureRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureRefContextProxy*>(ProcedureRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureRefContextProxy>(x, rb_cProcedureRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureIdContext*>(ExpressParser::ProcedureIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureIdContext>(x, rb_cProcedureIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureIdContextProxy*>(ProcedureIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureIdContextProxy>(x, rb_cProcedureIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleLabelRefContext*>(ExpressParser::RuleLabelRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleLabelRefContext>(x, rb_cRuleLabelRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleLabelRefContextProxy*>(RuleLabelRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleLabelRefContextProxy>(x, rb_cRuleLabelRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleLabelIdContext*>(ExpressParser::RuleLabelIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleLabelIdContext>(x, rb_cRuleLabelIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleLabelIdContextProxy*>(RuleLabelIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleLabelIdContextProxy>(x, rb_cRuleLabelIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleRefContext*>(ExpressParser::RuleRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleRefContext>(x, rb_cRuleRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleRefContextProxy*>(RuleRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleRefContextProxy>(x, rb_cRuleRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleIdContext*>(ExpressParser::RuleIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleIdContext>(x, rb_cRuleIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleIdContextProxy*>(RuleIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleIdContextProxy>(x, rb_cRuleIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaRefContext*>(ExpressParser::SchemaRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaRefContext>(x, rb_cSchemaRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaRefContextProxy*>(SchemaRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaRefContextProxy>(x, rb_cSchemaRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaIdContext*>(ExpressParser::SchemaIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaIdContext>(x, rb_cSchemaIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaIdContextProxy*>(SchemaIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaIdContextProxy>(x, rb_cSchemaIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintRefContext*>(ExpressParser::SubtypeConstraintRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintRefContext>(x, rb_cSubtypeConstraintRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintRefContextProxy*>(SubtypeConstraintRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintRefContextProxy>(x, rb_cSubtypeConstraintRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintIdContext*>(ExpressParser::SubtypeConstraintIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintIdContext>(x, rb_cSubtypeConstraintIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintIdContextProxy*>(SubtypeConstraintIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintIdContextProxy>(x, rb_cSubtypeConstraintIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeLabelRefContext*>(ExpressParser::TypeLabelRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeLabelRefContext>(x, rb_cTypeLabelRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeLabelRefContextProxy*>(TypeLabelRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeLabelRefContextProxy>(x, rb_cTypeLabelRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeLabelIdContext*>(ExpressParser::TypeLabelIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeLabelIdContext>(x, rb_cTypeLabelIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeLabelIdContextProxy*>(TypeLabelIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeLabelIdContextProxy>(x, rb_cTypeLabelIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeRefContext*>(ExpressParser::TypeRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeRefContext>(x, rb_cTypeRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeRefContextProxy*>(TypeRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeRefContextProxy>(x, rb_cTypeRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeIdContext*>(ExpressParser::TypeIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeIdContext>(x, rb_cTypeIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeIdContextProxy*>(TypeIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeIdContextProxy>(x, rb_cTypeIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::VariableRefContext*>(ExpressParser::VariableRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::VariableRefContext>(x, rb_cVariableRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<VariableRefContextProxy*>(VariableRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<VariableRefContextProxy>(x, rb_cVariableRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::VariableIdContext*>(ExpressParser::VariableIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::VariableIdContext>(x, rb_cVariableIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<VariableIdContextProxy*>(VariableIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<VariableIdContextProxy>(x, rb_cVariableIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AbstractEntityDeclarationContext*>(ExpressParser::AbstractEntityDeclarationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AbstractEntityDeclarationContext>(x, rb_cAbstractEntityDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<AbstractEntityDeclarationContextProxy*>(AbstractEntityDeclarationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AbstractEntityDeclarationContextProxy>(x, rb_cAbstractEntityDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AbstractSupertypeContext*>(ExpressParser::AbstractSupertypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AbstractSupertypeContext>(x, rb_cAbstractSupertypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<AbstractSupertypeContextProxy*>(AbstractSupertypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AbstractSupertypeContextProxy>(x, rb_cAbstractSupertypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AbstractSupertypeDeclarationContext*>(ExpressParser::AbstractSupertypeDeclarationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AbstractSupertypeDeclarationContext>(x, rb_cAbstractSupertypeDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<AbstractSupertypeDeclarationContextProxy*>(AbstractSupertypeDeclarationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AbstractSupertypeDeclarationContextProxy>(x, rb_cAbstractSupertypeDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintContext*>(ExpressParser::SubtypeConstraintContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintContext>(x, rb_cSubtypeConstraintContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintContextProxy*>(SubtypeConstraintContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintContextProxy>(x, rb_cSubtypeConstraintContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ActualParameterListContext*>(ExpressParser::ActualParameterListContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ActualParameterListContext>(x, rb_cActualParameterListContext, nullptr, nullptr);
}

template <>
Object to_ruby<ActualParameterListContextProxy*>(ActualParameterListContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ActualParameterListContextProxy>(x, rb_cActualParameterListContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ParameterContext*>(ExpressParser::ParameterContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ParameterContext>(x, rb_cParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<ParameterContextProxy*>(ParameterContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ParameterContextProxy>(x, rb_cParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AddLikeOpContext*>(ExpressParser::AddLikeOpContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AddLikeOpContext>(x, rb_cAddLikeOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<AddLikeOpContextProxy*>(AddLikeOpContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AddLikeOpContextProxy>(x, rb_cAddLikeOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AggregateInitializerContext*>(ExpressParser::AggregateInitializerContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AggregateInitializerContext>(x, rb_cAggregateInitializerContext, nullptr, nullptr);
}

template <>
Object to_ruby<AggregateInitializerContextProxy*>(AggregateInitializerContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AggregateInitializerContextProxy>(x, rb_cAggregateInitializerContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ElementContext*>(ExpressParser::ElementContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ElementContext>(x, rb_cElementContext, nullptr, nullptr);
}

template <>
Object to_ruby<ElementContextProxy*>(ElementContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ElementContextProxy>(x, rb_cElementContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AggregateSourceContext*>(ExpressParser::AggregateSourceContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AggregateSourceContext>(x, rb_cAggregateSourceContext, nullptr, nullptr);
}

template <>
Object to_ruby<AggregateSourceContextProxy*>(AggregateSourceContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AggregateSourceContextProxy>(x, rb_cAggregateSourceContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SimpleExpressionContext*>(ExpressParser::SimpleExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SimpleExpressionContext>(x, rb_cSimpleExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<SimpleExpressionContextProxy*>(SimpleExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SimpleExpressionContextProxy>(x, rb_cSimpleExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AggregateTypeContext*>(ExpressParser::AggregateTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AggregateTypeContext>(x, rb_cAggregateTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<AggregateTypeContextProxy*>(AggregateTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AggregateTypeContextProxy>(x, rb_cAggregateTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ParameterTypeContext*>(ExpressParser::ParameterTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ParameterTypeContext>(x, rb_cParameterTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ParameterTypeContextProxy*>(ParameterTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ParameterTypeContextProxy>(x, rb_cParameterTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeLabelContext*>(ExpressParser::TypeLabelContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeLabelContext>(x, rb_cTypeLabelContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeLabelContextProxy*>(TypeLabelContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeLabelContextProxy>(x, rb_cTypeLabelContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AggregationTypesContext*>(ExpressParser::AggregationTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AggregationTypesContext>(x, rb_cAggregationTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<AggregationTypesContextProxy*>(AggregationTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AggregationTypesContextProxy>(x, rb_cAggregationTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ArrayTypeContext*>(ExpressParser::ArrayTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ArrayTypeContext>(x, rb_cArrayTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ArrayTypeContextProxy*>(ArrayTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ArrayTypeContextProxy>(x, rb_cArrayTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BagTypeContext*>(ExpressParser::BagTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BagTypeContext>(x, rb_cBagTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<BagTypeContextProxy*>(BagTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BagTypeContextProxy>(x, rb_cBagTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ListTypeContext*>(ExpressParser::ListTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ListTypeContext>(x, rb_cListTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ListTypeContextProxy*>(ListTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ListTypeContextProxy>(x, rb_cListTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SetTypeContext*>(ExpressParser::SetTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SetTypeContext>(x, rb_cSetTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<SetTypeContextProxy*>(SetTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SetTypeContextProxy>(x, rb_cSetTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AlgorithmHeadContext*>(ExpressParser::AlgorithmHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AlgorithmHeadContext>(x, rb_cAlgorithmHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<AlgorithmHeadContextProxy*>(AlgorithmHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AlgorithmHeadContextProxy>(x, rb_cAlgorithmHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::DeclarationContext*>(ExpressParser::DeclarationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::DeclarationContext>(x, rb_cDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<DeclarationContextProxy*>(DeclarationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<DeclarationContextProxy>(x, rb_cDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstantDeclContext*>(ExpressParser::ConstantDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstantDeclContext>(x, rb_cConstantDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstantDeclContextProxy*>(ConstantDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstantDeclContextProxy>(x, rb_cConstantDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LocalDeclContext*>(ExpressParser::LocalDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LocalDeclContext>(x, rb_cLocalDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<LocalDeclContextProxy*>(LocalDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LocalDeclContextProxy>(x, rb_cLocalDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AliasStmtContext*>(ExpressParser::AliasStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AliasStmtContext>(x, rb_cAliasStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<AliasStmtContextProxy*>(AliasStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AliasStmtContextProxy>(x, rb_cAliasStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralRefContext*>(ExpressParser::GeneralRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralRefContext>(x, rb_cGeneralRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralRefContextProxy*>(GeneralRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralRefContextProxy>(x, rb_cGeneralRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::StmtContext*>(ExpressParser::StmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::StmtContext>(x, rb_cStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<StmtContextProxy*>(StmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<StmtContextProxy>(x, rb_cStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::QualifierContext*>(ExpressParser::QualifierContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::QualifierContext>(x, rb_cQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<QualifierContextProxy*>(QualifierContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<QualifierContextProxy>(x, rb_cQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BoundSpecContext*>(ExpressParser::BoundSpecContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BoundSpecContext>(x, rb_cBoundSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<BoundSpecContextProxy*>(BoundSpecContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BoundSpecContextProxy>(x, rb_cBoundSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::InstantiableTypeContext*>(ExpressParser::InstantiableTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::InstantiableTypeContext>(x, rb_cInstantiableTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<InstantiableTypeContextProxy*>(InstantiableTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<InstantiableTypeContextProxy>(x, rb_cInstantiableTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AssignmentStmtContext*>(ExpressParser::AssignmentStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AssignmentStmtContext>(x, rb_cAssignmentStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<AssignmentStmtContextProxy*>(AssignmentStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AssignmentStmtContextProxy>(x, rb_cAssignmentStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ExpressionContext*>(ExpressParser::ExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ExpressionContext>(x, rb_cExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressionContextProxy*>(ExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressionContextProxy>(x, rb_cExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AttributeDeclContext*>(ExpressParser::AttributeDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AttributeDeclContext>(x, rb_cAttributeDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<AttributeDeclContextProxy*>(AttributeDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AttributeDeclContextProxy>(x, rb_cAttributeDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RedeclaredAttributeContext*>(ExpressParser::RedeclaredAttributeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RedeclaredAttributeContext>(x, rb_cRedeclaredAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<RedeclaredAttributeContextProxy*>(RedeclaredAttributeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RedeclaredAttributeContextProxy>(x, rb_cRedeclaredAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::AttributeQualifierContext*>(ExpressParser::AttributeQualifierContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::AttributeQualifierContext>(x, rb_cAttributeQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<AttributeQualifierContextProxy*>(AttributeQualifierContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<AttributeQualifierContextProxy>(x, rb_cAttributeQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BinaryTypeContext*>(ExpressParser::BinaryTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BinaryTypeContext>(x, rb_cBinaryTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<BinaryTypeContextProxy*>(BinaryTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BinaryTypeContextProxy>(x, rb_cBinaryTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::WidthSpecContext*>(ExpressParser::WidthSpecContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::WidthSpecContext>(x, rb_cWidthSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<WidthSpecContextProxy*>(WidthSpecContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<WidthSpecContextProxy>(x, rb_cWidthSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BooleanTypeContext*>(ExpressParser::BooleanTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BooleanTypeContext>(x, rb_cBooleanTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<BooleanTypeContextProxy*>(BooleanTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BooleanTypeContextProxy>(x, rb_cBooleanTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::Bound1Context*>(ExpressParser::Bound1Context* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::Bound1Context>(x, rb_cBound1Context, nullptr, nullptr);
}

template <>
Object to_ruby<Bound1ContextProxy*>(Bound1ContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<Bound1ContextProxy>(x, rb_cBound1Context, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::NumericExpressionContext*>(ExpressParser::NumericExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::NumericExpressionContext>(x, rb_cNumericExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<NumericExpressionContextProxy*>(NumericExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<NumericExpressionContextProxy>(x, rb_cNumericExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::Bound2Context*>(ExpressParser::Bound2Context* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::Bound2Context>(x, rb_cBound2Context, nullptr, nullptr);
}

template <>
Object to_ruby<Bound2ContextProxy*>(Bound2ContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<Bound2ContextProxy>(x, rb_cBound2Context, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BuiltInConstantContext*>(ExpressParser::BuiltInConstantContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BuiltInConstantContext>(x, rb_cBuiltInConstantContext, nullptr, nullptr);
}

template <>
Object to_ruby<BuiltInConstantContextProxy*>(BuiltInConstantContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BuiltInConstantContextProxy>(x, rb_cBuiltInConstantContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BuiltInFunctionContext*>(ExpressParser::BuiltInFunctionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BuiltInFunctionContext>(x, rb_cBuiltInFunctionContext, nullptr, nullptr);
}

template <>
Object to_ruby<BuiltInFunctionContextProxy*>(BuiltInFunctionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BuiltInFunctionContextProxy>(x, rb_cBuiltInFunctionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::BuiltInProcedureContext*>(ExpressParser::BuiltInProcedureContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::BuiltInProcedureContext>(x, rb_cBuiltInProcedureContext, nullptr, nullptr);
}

template <>
Object to_ruby<BuiltInProcedureContextProxy*>(BuiltInProcedureContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<BuiltInProcedureContextProxy>(x, rb_cBuiltInProcedureContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::CaseActionContext*>(ExpressParser::CaseActionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::CaseActionContext>(x, rb_cCaseActionContext, nullptr, nullptr);
}

template <>
Object to_ruby<CaseActionContextProxy*>(CaseActionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<CaseActionContextProxy>(x, rb_cCaseActionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::CaseLabelContext*>(ExpressParser::CaseLabelContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::CaseLabelContext>(x, rb_cCaseLabelContext, nullptr, nullptr);
}

template <>
Object to_ruby<CaseLabelContextProxy*>(CaseLabelContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<CaseLabelContextProxy>(x, rb_cCaseLabelContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::CaseStmtContext*>(ExpressParser::CaseStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::CaseStmtContext>(x, rb_cCaseStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<CaseStmtContextProxy*>(CaseStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<CaseStmtContextProxy>(x, rb_cCaseStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SelectorContext*>(ExpressParser::SelectorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SelectorContext>(x, rb_cSelectorContext, nullptr, nullptr);
}

template <>
Object to_ruby<SelectorContextProxy*>(SelectorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SelectorContextProxy>(x, rb_cSelectorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::CompoundStmtContext*>(ExpressParser::CompoundStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::CompoundStmtContext>(x, rb_cCompoundStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<CompoundStmtContextProxy*>(CompoundStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<CompoundStmtContextProxy>(x, rb_cCompoundStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConcreteTypesContext*>(ExpressParser::ConcreteTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConcreteTypesContext>(x, rb_cConcreteTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConcreteTypesContextProxy*>(ConcreteTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConcreteTypesContextProxy>(x, rb_cConcreteTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SimpleTypesContext*>(ExpressParser::SimpleTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SimpleTypesContext>(x, rb_cSimpleTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<SimpleTypesContextProxy*>(SimpleTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SimpleTypesContextProxy>(x, rb_cSimpleTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstantBodyContext*>(ExpressParser::ConstantBodyContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstantBodyContext>(x, rb_cConstantBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstantBodyContextProxy*>(ConstantBodyContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstantBodyContextProxy>(x, rb_cConstantBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstantFactorContext*>(ExpressParser::ConstantFactorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstantFactorContext>(x, rb_cConstantFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstantFactorContextProxy*>(ConstantFactorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstantFactorContextProxy>(x, rb_cConstantFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ConstructedTypesContext*>(ExpressParser::ConstructedTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ConstructedTypesContext>(x, rb_cConstructedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ConstructedTypesContextProxy*>(ConstructedTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ConstructedTypesContextProxy>(x, rb_cConstructedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationTypeContext*>(ExpressParser::EnumerationTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationTypeContext>(x, rb_cEnumerationTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationTypeContextProxy*>(EnumerationTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationTypeContextProxy>(x, rb_cEnumerationTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SelectTypeContext*>(ExpressParser::SelectTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SelectTypeContext>(x, rb_cSelectTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<SelectTypeContextProxy*>(SelectTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SelectTypeContextProxy>(x, rb_cSelectTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityDeclContext*>(ExpressParser::EntityDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityDeclContext>(x, rb_cEntityDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityDeclContextProxy*>(EntityDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityDeclContextProxy>(x, rb_cEntityDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FunctionDeclContext*>(ExpressParser::FunctionDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FunctionDeclContext>(x, rb_cFunctionDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<FunctionDeclContextProxy*>(FunctionDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FunctionDeclContextProxy>(x, rb_cFunctionDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureDeclContext*>(ExpressParser::ProcedureDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureDeclContext>(x, rb_cProcedureDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureDeclContextProxy*>(ProcedureDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureDeclContextProxy>(x, rb_cProcedureDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintDeclContext*>(ExpressParser::SubtypeConstraintDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintDeclContext>(x, rb_cSubtypeConstraintDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintDeclContextProxy*>(SubtypeConstraintDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintDeclContextProxy>(x, rb_cSubtypeConstraintDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TypeDeclContext*>(ExpressParser::TypeDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TypeDeclContext>(x, rb_cTypeDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<TypeDeclContextProxy*>(TypeDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TypeDeclContextProxy>(x, rb_cTypeDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::DerivedAttrContext*>(ExpressParser::DerivedAttrContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::DerivedAttrContext>(x, rb_cDerivedAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<DerivedAttrContextProxy*>(DerivedAttrContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<DerivedAttrContextProxy>(x, rb_cDerivedAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::DeriveClauseContext*>(ExpressParser::DeriveClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::DeriveClauseContext>(x, rb_cDeriveClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<DeriveClauseContextProxy*>(DeriveClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<DeriveClauseContextProxy>(x, rb_cDeriveClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::DomainRuleContext*>(ExpressParser::DomainRuleContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::DomainRuleContext>(x, rb_cDomainRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<DomainRuleContextProxy*>(DomainRuleContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<DomainRuleContextProxy>(x, rb_cDomainRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RepetitionContext*>(ExpressParser::RepetitionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RepetitionContext>(x, rb_cRepetitionContext, nullptr, nullptr);
}

template <>
Object to_ruby<RepetitionContextProxy*>(RepetitionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RepetitionContextProxy>(x, rb_cRepetitionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityBodyContext*>(ExpressParser::EntityBodyContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityBodyContext>(x, rb_cEntityBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityBodyContextProxy*>(EntityBodyContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityBodyContextProxy>(x, rb_cEntityBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ExplicitAttrContext*>(ExpressParser::ExplicitAttrContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ExplicitAttrContext>(x, rb_cExplicitAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExplicitAttrContextProxy*>(ExplicitAttrContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ExplicitAttrContextProxy>(x, rb_cExplicitAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::InverseClauseContext*>(ExpressParser::InverseClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::InverseClauseContext>(x, rb_cInverseClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<InverseClauseContextProxy*>(InverseClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<InverseClauseContextProxy>(x, rb_cInverseClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UniqueClauseContext*>(ExpressParser::UniqueClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UniqueClauseContext>(x, rb_cUniqueClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<UniqueClauseContextProxy*>(UniqueClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UniqueClauseContextProxy>(x, rb_cUniqueClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::WhereClauseContext*>(ExpressParser::WhereClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::WhereClauseContext>(x, rb_cWhereClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<WhereClauseContextProxy*>(WhereClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<WhereClauseContextProxy>(x, rb_cWhereClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityConstructorContext*>(ExpressParser::EntityConstructorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityConstructorContext>(x, rb_cEntityConstructorContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityConstructorContextProxy*>(EntityConstructorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityConstructorContextProxy>(x, rb_cEntityConstructorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EntityHeadContext*>(ExpressParser::EntityHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EntityHeadContext>(x, rb_cEntityHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<EntityHeadContextProxy*>(EntityHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EntityHeadContextProxy>(x, rb_cEntityHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubsuperContext*>(ExpressParser::SubsuperContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubsuperContext>(x, rb_cSubsuperContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubsuperContextProxy*>(SubsuperContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubsuperContextProxy>(x, rb_cSubsuperContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationExtensionContext*>(ExpressParser::EnumerationExtensionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationExtensionContext>(x, rb_cEnumerationExtensionContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationExtensionContextProxy*>(EnumerationExtensionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationExtensionContextProxy>(x, rb_cEnumerationExtensionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationItemsContext*>(ExpressParser::EnumerationItemsContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationItemsContext>(x, rb_cEnumerationItemsContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationItemsContextProxy*>(EnumerationItemsContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationItemsContextProxy>(x, rb_cEnumerationItemsContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationItemContext*>(ExpressParser::EnumerationItemContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationItemContext>(x, rb_cEnumerationItemContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationItemContextProxy*>(EnumerationItemContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationItemContextProxy>(x, rb_cEnumerationItemContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EnumerationReferenceContext*>(ExpressParser::EnumerationReferenceContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EnumerationReferenceContext>(x, rb_cEnumerationReferenceContext, nullptr, nullptr);
}

template <>
Object to_ruby<EnumerationReferenceContextProxy*>(EnumerationReferenceContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EnumerationReferenceContextProxy>(x, rb_cEnumerationReferenceContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::EscapeStmtContext*>(ExpressParser::EscapeStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::EscapeStmtContext>(x, rb_cEscapeStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<EscapeStmtContextProxy*>(EscapeStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<EscapeStmtContextProxy>(x, rb_cEscapeStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RelOpExtendedContext*>(ExpressParser::RelOpExtendedContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RelOpExtendedContext>(x, rb_cRelOpExtendedContext, nullptr, nullptr);
}

template <>
Object to_ruby<RelOpExtendedContextProxy*>(RelOpExtendedContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RelOpExtendedContextProxy>(x, rb_cRelOpExtendedContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FactorContext*>(ExpressParser::FactorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FactorContext>(x, rb_cFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<FactorContextProxy*>(FactorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FactorContextProxy>(x, rb_cFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SimpleFactorContext*>(ExpressParser::SimpleFactorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SimpleFactorContext>(x, rb_cSimpleFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<SimpleFactorContextProxy*>(SimpleFactorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SimpleFactorContextProxy>(x, rb_cSimpleFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FormalParameterContext*>(ExpressParser::FormalParameterContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FormalParameterContext>(x, rb_cFormalParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<FormalParameterContextProxy*>(FormalParameterContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FormalParameterContextProxy>(x, rb_cFormalParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FunctionCallContext*>(ExpressParser::FunctionCallContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FunctionCallContext>(x, rb_cFunctionCallContext, nullptr, nullptr);
}

template <>
Object to_ruby<FunctionCallContextProxy*>(FunctionCallContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FunctionCallContextProxy>(x, rb_cFunctionCallContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::FunctionHeadContext*>(ExpressParser::FunctionHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::FunctionHeadContext>(x, rb_cFunctionHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<FunctionHeadContextProxy*>(FunctionHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<FunctionHeadContextProxy>(x, rb_cFunctionHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralizedTypesContext*>(ExpressParser::GeneralizedTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralizedTypesContext>(x, rb_cGeneralizedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralizedTypesContextProxy*>(GeneralizedTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralizedTypesContextProxy>(x, rb_cGeneralizedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralAggregationTypesContext*>(ExpressParser::GeneralAggregationTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralAggregationTypesContext>(x, rb_cGeneralAggregationTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralAggregationTypesContextProxy*>(GeneralAggregationTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralAggregationTypesContextProxy>(x, rb_cGeneralAggregationTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GenericEntityTypeContext*>(ExpressParser::GenericEntityTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GenericEntityTypeContext>(x, rb_cGenericEntityTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GenericEntityTypeContextProxy*>(GenericEntityTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GenericEntityTypeContextProxy>(x, rb_cGenericEntityTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GenericTypeContext*>(ExpressParser::GenericTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GenericTypeContext>(x, rb_cGenericTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GenericTypeContextProxy*>(GenericTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GenericTypeContextProxy>(x, rb_cGenericTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralArrayTypeContext*>(ExpressParser::GeneralArrayTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralArrayTypeContext>(x, rb_cGeneralArrayTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralArrayTypeContextProxy*>(GeneralArrayTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralArrayTypeContextProxy>(x, rb_cGeneralArrayTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralBagTypeContext*>(ExpressParser::GeneralBagTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralBagTypeContext>(x, rb_cGeneralBagTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralBagTypeContextProxy*>(GeneralBagTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralBagTypeContextProxy>(x, rb_cGeneralBagTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralListTypeContext*>(ExpressParser::GeneralListTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralListTypeContext>(x, rb_cGeneralListTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralListTypeContextProxy*>(GeneralListTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralListTypeContextProxy>(x, rb_cGeneralListTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GeneralSetTypeContext*>(ExpressParser::GeneralSetTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GeneralSetTypeContext>(x, rb_cGeneralSetTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<GeneralSetTypeContextProxy*>(GeneralSetTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GeneralSetTypeContextProxy>(x, rb_cGeneralSetTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::GroupQualifierContext*>(ExpressParser::GroupQualifierContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::GroupQualifierContext>(x, rb_cGroupQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<GroupQualifierContextProxy*>(GroupQualifierContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<GroupQualifierContextProxy>(x, rb_cGroupQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IfStmtContext*>(ExpressParser::IfStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IfStmtContext>(x, rb_cIfStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<IfStmtContextProxy*>(IfStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IfStmtContextProxy>(x, rb_cIfStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LogicalExpressionContext*>(ExpressParser::LogicalExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LogicalExpressionContext>(x, rb_cLogicalExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<LogicalExpressionContextProxy*>(LogicalExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LogicalExpressionContextProxy>(x, rb_cLogicalExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IfStmtStatementsContext*>(ExpressParser::IfStmtStatementsContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IfStmtStatementsContext>(x, rb_cIfStmtStatementsContext, nullptr, nullptr);
}

template <>
Object to_ruby<IfStmtStatementsContextProxy*>(IfStmtStatementsContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IfStmtStatementsContextProxy>(x, rb_cIfStmtStatementsContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IfStmtElseStatementsContext*>(ExpressParser::IfStmtElseStatementsContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IfStmtElseStatementsContext>(x, rb_cIfStmtElseStatementsContext, nullptr, nullptr);
}

template <>
Object to_ruby<IfStmtElseStatementsContextProxy*>(IfStmtElseStatementsContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IfStmtElseStatementsContextProxy>(x, rb_cIfStmtElseStatementsContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IncrementContext*>(ExpressParser::IncrementContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IncrementContext>(x, rb_cIncrementContext, nullptr, nullptr);
}

template <>
Object to_ruby<IncrementContextProxy*>(IncrementContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IncrementContextProxy>(x, rb_cIncrementContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IncrementControlContext*>(ExpressParser::IncrementControlContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IncrementControlContext>(x, rb_cIncrementControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<IncrementControlContextProxy*>(IncrementControlContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IncrementControlContextProxy>(x, rb_cIncrementControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IndexContext*>(ExpressParser::IndexContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IndexContext>(x, rb_cIndexContext, nullptr, nullptr);
}

template <>
Object to_ruby<IndexContextProxy*>(IndexContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IndexContextProxy>(x, rb_cIndexContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::Index1Context*>(ExpressParser::Index1Context* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::Index1Context>(x, rb_cIndex1Context, nullptr, nullptr);
}

template <>
Object to_ruby<Index1ContextProxy*>(Index1ContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<Index1ContextProxy>(x, rb_cIndex1Context, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::Index2Context*>(ExpressParser::Index2Context* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::Index2Context>(x, rb_cIndex2Context, nullptr, nullptr);
}

template <>
Object to_ruby<Index2ContextProxy*>(Index2ContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<Index2ContextProxy>(x, rb_cIndex2Context, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IndexQualifierContext*>(ExpressParser::IndexQualifierContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IndexQualifierContext>(x, rb_cIndexQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<IndexQualifierContextProxy*>(IndexQualifierContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IndexQualifierContextProxy>(x, rb_cIndexQualifierContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntegerTypeContext*>(ExpressParser::IntegerTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntegerTypeContext>(x, rb_cIntegerTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntegerTypeContextProxy*>(IntegerTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntegerTypeContextProxy>(x, rb_cIntegerTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::InterfaceSpecificationContext*>(ExpressParser::InterfaceSpecificationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::InterfaceSpecificationContext>(x, rb_cInterfaceSpecificationContext, nullptr, nullptr);
}

template <>
Object to_ruby<InterfaceSpecificationContextProxy*>(InterfaceSpecificationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<InterfaceSpecificationContextProxy>(x, rb_cInterfaceSpecificationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ReferenceClauseContext*>(ExpressParser::ReferenceClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ReferenceClauseContext>(x, rb_cReferenceClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ReferenceClauseContextProxy*>(ReferenceClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ReferenceClauseContextProxy>(x, rb_cReferenceClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UseClauseContext*>(ExpressParser::UseClauseContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UseClauseContext>(x, rb_cUseClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<UseClauseContextProxy*>(UseClauseContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UseClauseContextProxy>(x, rb_cUseClauseContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntervalContext*>(ExpressParser::IntervalContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntervalContext>(x, rb_cIntervalContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntervalContextProxy*>(IntervalContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntervalContextProxy>(x, rb_cIntervalContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntervalLowContext*>(ExpressParser::IntervalLowContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntervalLowContext>(x, rb_cIntervalLowContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntervalLowContextProxy*>(IntervalLowContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntervalLowContextProxy>(x, rb_cIntervalLowContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntervalOpContext*>(ExpressParser::IntervalOpContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntervalOpContext>(x, rb_cIntervalOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntervalOpContextProxy*>(IntervalOpContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntervalOpContextProxy>(x, rb_cIntervalOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntervalItemContext*>(ExpressParser::IntervalItemContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntervalItemContext>(x, rb_cIntervalItemContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntervalItemContextProxy*>(IntervalItemContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntervalItemContextProxy>(x, rb_cIntervalItemContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::IntervalHighContext*>(ExpressParser::IntervalHighContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::IntervalHighContext>(x, rb_cIntervalHighContext, nullptr, nullptr);
}

template <>
Object to_ruby<IntervalHighContextProxy*>(IntervalHighContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<IntervalHighContextProxy>(x, rb_cIntervalHighContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::InverseAttrContext*>(ExpressParser::InverseAttrContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::InverseAttrContext>(x, rb_cInverseAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<InverseAttrContextProxy*>(InverseAttrContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<InverseAttrContextProxy>(x, rb_cInverseAttrContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::InverseAttrTypeContext*>(ExpressParser::InverseAttrTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::InverseAttrTypeContext>(x, rb_cInverseAttrTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<InverseAttrTypeContextProxy*>(InverseAttrTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<InverseAttrTypeContextProxy>(x, rb_cInverseAttrTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LiteralContext*>(ExpressParser::LiteralContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LiteralContext>(x, rb_cLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<LiteralContextProxy*>(LiteralContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LiteralContextProxy>(x, rb_cLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LogicalLiteralContext*>(ExpressParser::LogicalLiteralContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LogicalLiteralContext>(x, rb_cLogicalLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<LogicalLiteralContextProxy*>(LogicalLiteralContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LogicalLiteralContextProxy>(x, rb_cLogicalLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::StringLiteralContext*>(ExpressParser::StringLiteralContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::StringLiteralContext>(x, rb_cStringLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<StringLiteralContextProxy*>(StringLiteralContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<StringLiteralContextProxy>(x, rb_cStringLiteralContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LocalVariableContext*>(ExpressParser::LocalVariableContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LocalVariableContext>(x, rb_cLocalVariableContext, nullptr, nullptr);
}

template <>
Object to_ruby<LocalVariableContextProxy*>(LocalVariableContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LocalVariableContextProxy>(x, rb_cLocalVariableContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::LogicalTypeContext*>(ExpressParser::LogicalTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::LogicalTypeContext>(x, rb_cLogicalTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<LogicalTypeContextProxy*>(LogicalTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<LogicalTypeContextProxy>(x, rb_cLogicalTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::MultiplicationLikeOpContext*>(ExpressParser::MultiplicationLikeOpContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::MultiplicationLikeOpContext>(x, rb_cMultiplicationLikeOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<MultiplicationLikeOpContextProxy*>(MultiplicationLikeOpContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<MultiplicationLikeOpContextProxy>(x, rb_cMultiplicationLikeOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::NamedTypesContext*>(ExpressParser::NamedTypesContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::NamedTypesContext>(x, rb_cNamedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<NamedTypesContextProxy*>(NamedTypesContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<NamedTypesContextProxy>(x, rb_cNamedTypesContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::NamedTypeOrRenameContext*>(ExpressParser::NamedTypeOrRenameContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::NamedTypeOrRenameContext>(x, rb_cNamedTypeOrRenameContext, nullptr, nullptr);
}

template <>
Object to_ruby<NamedTypeOrRenameContextProxy*>(NamedTypeOrRenameContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<NamedTypeOrRenameContextProxy>(x, rb_cNamedTypeOrRenameContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::NullStmtContext*>(ExpressParser::NullStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::NullStmtContext>(x, rb_cNullStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<NullStmtContextProxy*>(NullStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<NullStmtContextProxy>(x, rb_cNullStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::NumberTypeContext*>(ExpressParser::NumberTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::NumberTypeContext>(x, rb_cNumberTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<NumberTypeContextProxy*>(NumberTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<NumberTypeContextProxy>(x, rb_cNumberTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::OneOfContext*>(ExpressParser::OneOfContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::OneOfContext>(x, rb_cOneOfContext, nullptr, nullptr);
}

template <>
Object to_ruby<OneOfContextProxy*>(OneOfContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<OneOfContextProxy>(x, rb_cOneOfContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SupertypeExpressionContext*>(ExpressParser::SupertypeExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SupertypeExpressionContext>(x, rb_cSupertypeExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<SupertypeExpressionContextProxy*>(SupertypeExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SupertypeExpressionContextProxy>(x, rb_cSupertypeExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::PopulationContext*>(ExpressParser::PopulationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::PopulationContext>(x, rb_cPopulationContext, nullptr, nullptr);
}

template <>
Object to_ruby<PopulationContextProxy*>(PopulationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<PopulationContextProxy>(x, rb_cPopulationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::PrecisionSpecContext*>(ExpressParser::PrecisionSpecContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::PrecisionSpecContext>(x, rb_cPrecisionSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<PrecisionSpecContextProxy*>(PrecisionSpecContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<PrecisionSpecContextProxy>(x, rb_cPrecisionSpecContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::PrimaryContext*>(ExpressParser::PrimaryContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::PrimaryContext>(x, rb_cPrimaryContext, nullptr, nullptr);
}

template <>
Object to_ruby<PrimaryContextProxy*>(PrimaryContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<PrimaryContextProxy>(x, rb_cPrimaryContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::QualifiableFactorContext*>(ExpressParser::QualifiableFactorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::QualifiableFactorContext>(x, rb_cQualifiableFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<QualifiableFactorContextProxy*>(QualifiableFactorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<QualifiableFactorContextProxy>(x, rb_cQualifiableFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureCallStmtContext*>(ExpressParser::ProcedureCallStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureCallStmtContext>(x, rb_cProcedureCallStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureCallStmtContextProxy*>(ProcedureCallStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureCallStmtContextProxy>(x, rb_cProcedureCallStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureHeadContext*>(ExpressParser::ProcedureHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureHeadContext>(x, rb_cProcedureHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureHeadContextProxy*>(ProcedureHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureHeadContextProxy>(x, rb_cProcedureHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ProcedureHeadParameterContext*>(ExpressParser::ProcedureHeadParameterContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ProcedureHeadParameterContext>(x, rb_cProcedureHeadParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<ProcedureHeadParameterContextProxy*>(ProcedureHeadParameterContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ProcedureHeadParameterContextProxy>(x, rb_cProcedureHeadParameterContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::QualifiedAttributeContext*>(ExpressParser::QualifiedAttributeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::QualifiedAttributeContext>(x, rb_cQualifiedAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<QualifiedAttributeContextProxy*>(QualifiedAttributeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<QualifiedAttributeContextProxy>(x, rb_cQualifiedAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::QueryExpressionContext*>(ExpressParser::QueryExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::QueryExpressionContext>(x, rb_cQueryExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<QueryExpressionContextProxy*>(QueryExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<QueryExpressionContextProxy>(x, rb_cQueryExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RealTypeContext*>(ExpressParser::RealTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RealTypeContext>(x, rb_cRealTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<RealTypeContextProxy*>(RealTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RealTypeContextProxy>(x, rb_cRealTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ReferencedAttributeContext*>(ExpressParser::ReferencedAttributeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ReferencedAttributeContext>(x, rb_cReferencedAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ReferencedAttributeContextProxy*>(ReferencedAttributeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ReferencedAttributeContextProxy>(x, rb_cReferencedAttributeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ResourceOrRenameContext*>(ExpressParser::ResourceOrRenameContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ResourceOrRenameContext>(x, rb_cResourceOrRenameContext, nullptr, nullptr);
}

template <>
Object to_ruby<ResourceOrRenameContextProxy*>(ResourceOrRenameContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ResourceOrRenameContextProxy>(x, rb_cResourceOrRenameContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RelOpContext*>(ExpressParser::RelOpContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RelOpContext>(x, rb_cRelOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<RelOpContextProxy*>(RelOpContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RelOpContextProxy>(x, rb_cRelOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RenameIdContext*>(ExpressParser::RenameIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RenameIdContext>(x, rb_cRenameIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<RenameIdContextProxy*>(RenameIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RenameIdContextProxy>(x, rb_cRenameIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RepeatControlContext*>(ExpressParser::RepeatControlContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RepeatControlContext>(x, rb_cRepeatControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<RepeatControlContextProxy*>(RepeatControlContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RepeatControlContextProxy>(x, rb_cRepeatControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::WhileControlContext*>(ExpressParser::WhileControlContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::WhileControlContext>(x, rb_cWhileControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<WhileControlContextProxy*>(WhileControlContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<WhileControlContextProxy>(x, rb_cWhileControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UntilControlContext*>(ExpressParser::UntilControlContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UntilControlContext>(x, rb_cUntilControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<UntilControlContextProxy*>(UntilControlContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UntilControlContextProxy>(x, rb_cUntilControlContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RepeatStmtContext*>(ExpressParser::RepeatStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RepeatStmtContext>(x, rb_cRepeatStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<RepeatStmtContextProxy*>(RepeatStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RepeatStmtContextProxy>(x, rb_cRepeatStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ResourceRefContext*>(ExpressParser::ResourceRefContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ResourceRefContext>(x, rb_cResourceRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ResourceRefContextProxy*>(ResourceRefContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ResourceRefContextProxy>(x, rb_cResourceRefContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::ReturnStmtContext*>(ExpressParser::ReturnStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::ReturnStmtContext>(x, rb_cReturnStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ReturnStmtContextProxy*>(ReturnStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ReturnStmtContextProxy>(x, rb_cReturnStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleDeclContext*>(ExpressParser::RuleDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleDeclContext>(x, rb_cRuleDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleDeclContextProxy*>(RuleDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleDeclContextProxy>(x, rb_cRuleDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::RuleHeadContext*>(ExpressParser::RuleHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::RuleHeadContext>(x, rb_cRuleHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<RuleHeadContextProxy*>(RuleHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<RuleHeadContextProxy>(x, rb_cRuleHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaBodyContext*>(ExpressParser::SchemaBodyContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaBodyContext>(x, rb_cSchemaBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaBodyContextProxy*>(SchemaBodyContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaBodyContextProxy>(x, rb_cSchemaBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaBodyDeclarationContext*>(ExpressParser::SchemaBodyDeclarationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaBodyDeclarationContext>(x, rb_cSchemaBodyDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaBodyDeclarationContextProxy*>(SchemaBodyDeclarationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaBodyDeclarationContextProxy>(x, rb_cSchemaBodyDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaDeclContext*>(ExpressParser::SchemaDeclContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaDeclContext>(x, rb_cSchemaDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaDeclContextProxy*>(SchemaDeclContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaDeclContextProxy>(x, rb_cSchemaDeclContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SchemaVersionIdContext*>(ExpressParser::SchemaVersionIdContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SchemaVersionIdContext>(x, rb_cSchemaVersionIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<SchemaVersionIdContextProxy*>(SchemaVersionIdContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SchemaVersionIdContextProxy>(x, rb_cSchemaVersionIdContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SelectExtensionContext*>(ExpressParser::SelectExtensionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SelectExtensionContext>(x, rb_cSelectExtensionContext, nullptr, nullptr);
}

template <>
Object to_ruby<SelectExtensionContextProxy*>(SelectExtensionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SelectExtensionContextProxy>(x, rb_cSelectExtensionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SelectListContext*>(ExpressParser::SelectListContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SelectListContext>(x, rb_cSelectListContext, nullptr, nullptr);
}

template <>
Object to_ruby<SelectListContextProxy*>(SelectListContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SelectListContextProxy>(x, rb_cSelectListContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TermContext*>(ExpressParser::TermContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TermContext>(x, rb_cTermContext, nullptr, nullptr);
}

template <>
Object to_ruby<TermContextProxy*>(TermContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TermContextProxy>(x, rb_cTermContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SimpleFactorExpressionContext*>(ExpressParser::SimpleFactorExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SimpleFactorExpressionContext>(x, rb_cSimpleFactorExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<SimpleFactorExpressionContextProxy*>(SimpleFactorExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SimpleFactorExpressionContextProxy>(x, rb_cSimpleFactorExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SimpleFactorUnaryExpressionContext*>(ExpressParser::SimpleFactorUnaryExpressionContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SimpleFactorUnaryExpressionContext>(x, rb_cSimpleFactorUnaryExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<SimpleFactorUnaryExpressionContextProxy*>(SimpleFactorUnaryExpressionContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SimpleFactorUnaryExpressionContextProxy>(x, rb_cSimpleFactorUnaryExpressionContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UnaryOpContext*>(ExpressParser::UnaryOpContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UnaryOpContext>(x, rb_cUnaryOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<UnaryOpContextProxy*>(UnaryOpContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UnaryOpContextProxy>(x, rb_cUnaryOpContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::StringTypeContext*>(ExpressParser::StringTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::StringTypeContext>(x, rb_cStringTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<StringTypeContextProxy*>(StringTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<StringTypeContextProxy>(x, rb_cStringTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SkipStmtContext*>(ExpressParser::SkipStmtContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SkipStmtContext>(x, rb_cSkipStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<SkipStmtContextProxy*>(SkipStmtContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SkipStmtContextProxy>(x, rb_cSkipStmtContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SupertypeConstraintContext*>(ExpressParser::SupertypeConstraintContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SupertypeConstraintContext>(x, rb_cSupertypeConstraintContext, nullptr, nullptr);
}

template <>
Object to_ruby<SupertypeConstraintContextProxy*>(SupertypeConstraintContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SupertypeConstraintContextProxy>(x, rb_cSupertypeConstraintContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeDeclarationContext*>(ExpressParser::SubtypeDeclarationContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeDeclarationContext>(x, rb_cSubtypeDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeDeclarationContextProxy*>(SubtypeDeclarationContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeDeclarationContextProxy>(x, rb_cSubtypeDeclarationContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintBodyContext*>(ExpressParser::SubtypeConstraintBodyContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintBodyContext>(x, rb_cSubtypeConstraintBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintBodyContextProxy*>(SubtypeConstraintBodyContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintBodyContextProxy>(x, rb_cSubtypeConstraintBodyContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::TotalOverContext*>(ExpressParser::TotalOverContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::TotalOverContext>(x, rb_cTotalOverContext, nullptr, nullptr);
}

template <>
Object to_ruby<TotalOverContextProxy*>(TotalOverContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<TotalOverContextProxy>(x, rb_cTotalOverContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SubtypeConstraintHeadContext*>(ExpressParser::SubtypeConstraintHeadContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SubtypeConstraintHeadContext>(x, rb_cSubtypeConstraintHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<SubtypeConstraintHeadContextProxy*>(SubtypeConstraintHeadContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SubtypeConstraintHeadContextProxy>(x, rb_cSubtypeConstraintHeadContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SupertypeRuleContext*>(ExpressParser::SupertypeRuleContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SupertypeRuleContext>(x, rb_cSupertypeRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<SupertypeRuleContextProxy*>(SupertypeRuleContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SupertypeRuleContextProxy>(x, rb_cSupertypeRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SupertypeFactorContext*>(ExpressParser::SupertypeFactorContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SupertypeFactorContext>(x, rb_cSupertypeFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<SupertypeFactorContextProxy*>(SupertypeFactorContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SupertypeFactorContextProxy>(x, rb_cSupertypeFactorContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SupertypeTermContext*>(ExpressParser::SupertypeTermContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SupertypeTermContext>(x, rb_cSupertypeTermContext, nullptr, nullptr);
}

template <>
Object to_ruby<SupertypeTermContextProxy*>(SupertypeTermContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SupertypeTermContextProxy>(x, rb_cSupertypeTermContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::SyntaxContext*>(ExpressParser::SyntaxContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::SyntaxContext>(x, rb_cSyntaxContext, nullptr, nullptr);
}

template <>
Object to_ruby<SyntaxContextProxy*>(SyntaxContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<SyntaxContextProxy>(x, rb_cSyntaxContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UnderlyingTypeContext*>(ExpressParser::UnderlyingTypeContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UnderlyingTypeContext>(x, rb_cUnderlyingTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<UnderlyingTypeContextProxy*>(UnderlyingTypeContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UnderlyingTypeContextProxy>(x, rb_cUnderlyingTypeContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::UniqueRuleContext*>(ExpressParser::UniqueRuleContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::UniqueRuleContext>(x, rb_cUniqueRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<UniqueRuleContextProxy*>(UniqueRuleContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<UniqueRuleContextProxy>(x, rb_cUniqueRuleContext, nullptr, nullptr);
}

template <>
Object to_ruby<ExpressParser::WidthContext*>(ExpressParser::WidthContext* const &x) {
  if (!x) return Nil;
  return Data_Object<ExpressParser::WidthContext>(x, rb_cWidthContext, nullptr, nullptr);
}

template <>
Object to_ruby<WidthContextProxy*>(WidthContextProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<WidthContextProxy>(x, rb_cWidthContext, nullptr, nullptr);
}



Object AttributeRefContextProxy::attributeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AttributeRefContext*)orig) -> attributeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AttributeIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AttributeIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ConstantRefContextProxy::constantId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantRefContext*)orig) -> constantId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ConstantIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EntityRefContextProxy::entityId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityRefContext*)orig) -> entityId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EntityIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EnumerationRefContextProxy::enumerationId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationRefContext*)orig) -> enumerationId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object FunctionRefContextProxy::functionId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionRefContext*)orig) -> functionId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::FunctionIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ParameterRefContextProxy::parameterId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ParameterRefContext*)orig) -> parameterId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ParameterIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ParameterIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ProcedureRefContextProxy::procedureId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureRefContext*)orig) -> procedureId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ProcedureIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RuleLabelRefContextProxy::ruleLabelId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleLabelRefContext*)orig) -> ruleLabelId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleLabelIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RuleLabelIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RuleRefContextProxy::ruleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleRefContext*)orig) -> ruleId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RuleIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SchemaRefContextProxy::schemaId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaRefContext*)orig) -> schemaId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SchemaIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintRefContextProxy::subtypeConstraintId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintRefContext*)orig) -> subtypeConstraintId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeConstraintIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object TypeLabelRefContextProxy::typeLabelId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeLabelRefContext*)orig) -> typeLabelId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeLabelIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::TypeLabelIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object TypeRefContextProxy::typeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeRefContext*)orig) -> typeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::TypeIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object VariableRefContextProxy::variableId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::VariableRefContext*)orig) -> variableId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object VariableIdContextProxy::SimpleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::VariableIdContext*)orig) -> SimpleId();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AbstractEntityDeclarationContextProxy::ABSTRACT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AbstractEntityDeclarationContext*)orig) -> ABSTRACT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AbstractSupertypeContextProxy::ABSTRACT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AbstractSupertypeContext*)orig) -> ABSTRACT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AbstractSupertypeContextProxy::SUPERTYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AbstractSupertypeContext*)orig) -> SUPERTYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AbstractSupertypeDeclarationContextProxy::subtypeConstraint() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AbstractSupertypeDeclarationContext*)orig) -> subtypeConstraint();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AbstractSupertypeDeclarationContextProxy::ABSTRACT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AbstractSupertypeDeclarationContext*)orig) -> ABSTRACT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AbstractSupertypeDeclarationContextProxy::SUPERTYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AbstractSupertypeDeclarationContext*)orig) -> SUPERTYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintContextProxy::supertypeExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintContext*)orig) -> supertypeExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeConstraintContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ActualParameterListContextProxy::parameter() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ActualParameterListContext*)orig) -> parameter().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(parameterAt(i));
    }
  }

  return a;
}

Object ActualParameterListContextProxy::parameterAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ActualParameterListContext*)orig) -> parameter(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ParameterContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ParameterContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AddLikeOpContextProxy::OR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AddLikeOpContext*)orig) -> OR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AddLikeOpContextProxy::XOR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AddLikeOpContext*)orig) -> XOR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AggregateInitializerContextProxy::element() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::AggregateInitializerContext*)orig) -> element().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(elementAt(i));
    }
  }

  return a;
}

Object AggregateInitializerContextProxy::elementAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregateInitializerContext*)orig) -> element(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ElementContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ElementContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ElementContextProxy::repetition() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ElementContext*)orig) -> repetition();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregateSourceContextProxy::simpleExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregateSourceContext*)orig) -> simpleExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleExpressionContextProxy::term() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SimpleExpressionContext*)orig) -> term().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(termAt(i));
    }
  }

  return a;
}

Object SimpleExpressionContextProxy::termAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleExpressionContext*)orig) -> term(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleExpressionContextProxy::addLikeOp() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SimpleExpressionContext*)orig) -> addLikeOp().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(addLikeOpAt(i));
    }
  }

  return a;
}

Object SimpleExpressionContextProxy::addLikeOpAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleExpressionContext*)orig) -> addLikeOp(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregateTypeContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregateTypeContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregateTypeContextProxy::typeLabel() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregateTypeContext*)orig) -> typeLabel();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregateTypeContextProxy::AGGREGATE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AggregateTypeContext*)orig) -> AGGREGATE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AggregateTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AggregateTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ParameterTypeContextProxy::generalizedTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ParameterTypeContext*)orig) -> generalizedTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ParameterTypeContextProxy::namedTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ParameterTypeContext*)orig) -> namedTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ParameterTypeContextProxy::simpleTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ParameterTypeContext*)orig) -> simpleTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeLabelContextProxy::typeLabelId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeLabelContext*)orig) -> typeLabelId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeLabelContextProxy::typeLabelRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeLabelContext*)orig) -> typeLabelRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregationTypesContextProxy::arrayType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregationTypesContext*)orig) -> arrayType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregationTypesContextProxy::bagType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregationTypesContext*)orig) -> bagType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregationTypesContextProxy::listType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregationTypesContext*)orig) -> listType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AggregationTypesContextProxy::setType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AggregationTypesContext*)orig) -> setType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ArrayTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ArrayTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ArrayTypeContextProxy::instantiableType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ArrayTypeContext*)orig) -> instantiableType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ArrayTypeContextProxy::ARRAY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ArrayTypeContext*)orig) -> ARRAY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ArrayTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ArrayTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ArrayTypeContextProxy::OPTIONAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ArrayTypeContext*)orig) -> OPTIONAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ArrayTypeContextProxy::UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ArrayTypeContext*)orig) -> UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BagTypeContextProxy::instantiableType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::BagTypeContext*)orig) -> instantiableType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BagTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::BagTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BagTypeContextProxy::BAG() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BagTypeContext*)orig) -> BAG();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BagTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BagTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ListTypeContextProxy::instantiableType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ListTypeContext*)orig) -> instantiableType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ListTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ListTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ListTypeContextProxy::LIST() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ListTypeContext*)orig) -> LIST();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ListTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ListTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ListTypeContextProxy::UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ListTypeContext*)orig) -> UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SetTypeContextProxy::instantiableType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SetTypeContext*)orig) -> instantiableType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SetTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SetTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SetTypeContextProxy::SET() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SetTypeContext*)orig) -> SET();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SetTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SetTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AlgorithmHeadContextProxy::declaration() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::AlgorithmHeadContext*)orig) -> declaration().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(declarationAt(i));
    }
  }

  return a;
}

Object AlgorithmHeadContextProxy::declarationAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AlgorithmHeadContext*)orig) -> declaration(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AlgorithmHeadContextProxy::constantDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AlgorithmHeadContext*)orig) -> constantDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AlgorithmHeadContextProxy::localDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AlgorithmHeadContext*)orig) -> localDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeclarationContextProxy::entityDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeclarationContext*)orig) -> entityDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeclarationContextProxy::functionDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeclarationContext*)orig) -> functionDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeclarationContextProxy::procedureDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeclarationContext*)orig) -> procedureDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeclarationContextProxy::subtypeConstraintDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeclarationContext*)orig) -> subtypeConstraintDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeclarationContextProxy::typeDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeclarationContext*)orig) -> typeDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantDeclContextProxy::constantBody() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ConstantDeclContext*)orig) -> constantBody().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(constantBodyAt(i));
    }
  }

  return a;
}

Object ConstantDeclContextProxy::constantBodyAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantDeclContext*)orig) -> constantBody(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantDeclContextProxy::CONSTANT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ConstantDeclContext*)orig) -> CONSTANT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ConstantDeclContextProxy::END_CONSTANT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ConstantDeclContext*)orig) -> END_CONSTANT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LocalDeclContextProxy::localVariable() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::LocalDeclContext*)orig) -> localVariable().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(localVariableAt(i));
    }
  }

  return a;
}

Object LocalDeclContextProxy::localVariableAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LocalDeclContext*)orig) -> localVariable(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LocalDeclContextProxy::LOCAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LocalDeclContext*)orig) -> LOCAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LocalDeclContextProxy::END_LOCAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LocalDeclContext*)orig) -> END_LOCAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AliasStmtContextProxy::variableId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AliasStmtContext*)orig) -> variableId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AliasStmtContextProxy::generalRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AliasStmtContext*)orig) -> generalRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AliasStmtContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::AliasStmtContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object AliasStmtContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AliasStmtContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AliasStmtContextProxy::qualifier() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::AliasStmtContext*)orig) -> qualifier().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(qualifierAt(i));
    }
  }

  return a;
}

Object AliasStmtContextProxy::qualifierAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AliasStmtContext*)orig) -> qualifier(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AliasStmtContextProxy::ALIAS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AliasStmtContext*)orig) -> ALIAS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AliasStmtContextProxy::FOR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AliasStmtContext*)orig) -> FOR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AliasStmtContextProxy::END_ALIAS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::AliasStmtContext*)orig) -> END_ALIAS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralRefContextProxy::parameterRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralRefContext*)orig) -> parameterRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralRefContextProxy::variableId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralRefContext*)orig) -> variableId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::aliasStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> aliasStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::assignmentStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> assignmentStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::caseStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> caseStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::compoundStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> compoundStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::escapeStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> escapeStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::ifStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> ifStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::nullStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> nullStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::procedureCallStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> procedureCallStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::repeatStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> repeatStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::returnStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> returnStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StmtContextProxy::skipStmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StmtContext*)orig) -> skipStmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifierContextProxy::attributeQualifier() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifierContext*)orig) -> attributeQualifier();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifierContextProxy::groupQualifier() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifierContext*)orig) -> groupQualifier();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifierContextProxy::indexQualifier() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifierContext*)orig) -> indexQualifier();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BoundSpecContextProxy::bound1() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::BoundSpecContext*)orig) -> bound1();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BoundSpecContextProxy::bound2() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::BoundSpecContext*)orig) -> bound2();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InstantiableTypeContextProxy::concreteTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InstantiableTypeContext*)orig) -> concreteTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InstantiableTypeContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InstantiableTypeContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AssignmentStmtContextProxy::generalRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AssignmentStmtContext*)orig) -> generalRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AssignmentStmtContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AssignmentStmtContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AssignmentStmtContextProxy::qualifier() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::AssignmentStmtContext*)orig) -> qualifier().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(qualifierAt(i));
    }
  }

  return a;
}

Object AssignmentStmtContextProxy::qualifierAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AssignmentStmtContext*)orig) -> qualifier(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ExpressionContextProxy::simpleExpression() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ExpressionContext*)orig) -> simpleExpression().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(simpleExpressionAt(i));
    }
  }

  return a;
}

Object ExpressionContextProxy::simpleExpressionAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ExpressionContext*)orig) -> simpleExpression(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ExpressionContextProxy::relOpExtended() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ExpressionContext*)orig) -> relOpExtended();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AttributeDeclContextProxy::attributeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AttributeDeclContext*)orig) -> attributeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object AttributeDeclContextProxy::redeclaredAttribute() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AttributeDeclContext*)orig) -> redeclaredAttribute();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RedeclaredAttributeContextProxy::qualifiedAttribute() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RedeclaredAttributeContext*)orig) -> qualifiedAttribute();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RedeclaredAttributeContextProxy::attributeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RedeclaredAttributeContext*)orig) -> attributeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RedeclaredAttributeContextProxy::RENAMED() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RedeclaredAttributeContext*)orig) -> RENAMED();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object AttributeQualifierContextProxy::attributeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::AttributeQualifierContext*)orig) -> attributeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BinaryTypeContextProxy::widthSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::BinaryTypeContext*)orig) -> widthSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BinaryTypeContextProxy::BINARY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BinaryTypeContext*)orig) -> BINARY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object WidthSpecContextProxy::width() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::WidthSpecContext*)orig) -> width();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object WidthSpecContextProxy::FIXED() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::WidthSpecContext*)orig) -> FIXED();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BooleanTypeContextProxy::BOOLEAN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BooleanTypeContext*)orig) -> BOOLEAN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object Bound1ContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::Bound1Context*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NumericExpressionContextProxy::simpleExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NumericExpressionContext*)orig) -> simpleExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object Bound2ContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::Bound2Context*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object BuiltInConstantContextProxy::CONST_E() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInConstantContext*)orig) -> CONST_E();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInConstantContextProxy::PI() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInConstantContext*)orig) -> PI();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInConstantContextProxy::SELF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInConstantContext*)orig) -> SELF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ABS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ABS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ACOS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ACOS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ASIN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ASIN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ATAN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ATAN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::BLENGTH() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> BLENGTH();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::COS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> COS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::EXISTS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> EXISTS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::EXP() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> EXP();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::FORMAT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> FORMAT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::HIBOUND() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> HIBOUND();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::HIINDEX() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> HIINDEX();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LENGTH() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LENGTH();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LOBOUND() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LOBOUND();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LOINDEX() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LOINDEX();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LOG() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LOG();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LOG2() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LOG2();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::LOG10() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> LOG10();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::NVL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> NVL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ODD() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ODD();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::ROLESOF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> ROLESOF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::SIN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> SIN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::SIZEOF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> SIZEOF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::SQRT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> SQRT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::TAN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> TAN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::TYPEOF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> TYPEOF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::USEDIN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> USEDIN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::VALUE_() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> VALUE_();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::VALUE_IN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> VALUE_IN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInFunctionContextProxy::VALUE_UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInFunctionContext*)orig) -> VALUE_UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInProcedureContextProxy::INSERT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInProcedureContext*)orig) -> INSERT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object BuiltInProcedureContextProxy::REMOVE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::BuiltInProcedureContext*)orig) -> REMOVE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object CaseActionContextProxy::caseLabel() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::CaseActionContext*)orig) -> caseLabel().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(caseLabelAt(i));
    }
  }

  return a;
}

Object CaseActionContextProxy::caseLabelAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseActionContext*)orig) -> caseLabel(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseActionContextProxy::stmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseActionContext*)orig) -> stmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseLabelContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseLabelContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseStmtContextProxy::selector() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseStmtContext*)orig) -> selector();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseStmtContextProxy::caseAction() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::CaseStmtContext*)orig) -> caseAction().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(caseActionAt(i));
    }
  }

  return a;
}

Object CaseStmtContextProxy::caseActionAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseStmtContext*)orig) -> caseAction(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseStmtContextProxy::stmt() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CaseStmtContext*)orig) -> stmt();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CaseStmtContextProxy::CASE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CaseStmtContext*)orig) -> CASE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object CaseStmtContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CaseStmtContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object CaseStmtContextProxy::END_CASE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CaseStmtContext*)orig) -> END_CASE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object CaseStmtContextProxy::OTHERWISE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CaseStmtContext*)orig) -> OTHERWISE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectorContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectorContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CompoundStmtContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::CompoundStmtContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object CompoundStmtContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::CompoundStmtContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object CompoundStmtContextProxy::BEGIN_() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CompoundStmtContext*)orig) -> BEGIN_();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object CompoundStmtContextProxy::END_() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::CompoundStmtContext*)orig) -> END_();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ConcreteTypesContextProxy::aggregationTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConcreteTypesContext*)orig) -> aggregationTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConcreteTypesContextProxy::simpleTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConcreteTypesContext*)orig) -> simpleTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConcreteTypesContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConcreteTypesContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::binaryType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> binaryType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::booleanType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> booleanType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::integerType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> integerType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::logicalType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> logicalType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::numberType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> numberType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::realType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> realType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleTypesContextProxy::stringType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleTypesContext*)orig) -> stringType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantBodyContextProxy::constantId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantBodyContext*)orig) -> constantId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantBodyContextProxy::instantiableType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantBodyContext*)orig) -> instantiableType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantBodyContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantBodyContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantFactorContextProxy::builtInConstant() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantFactorContext*)orig) -> builtInConstant();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstantFactorContextProxy::constantRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstantFactorContext*)orig) -> constantRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstructedTypesContextProxy::enumerationType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstructedTypesContext*)orig) -> enumerationType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ConstructedTypesContextProxy::selectType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ConstructedTypesContext*)orig) -> selectType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationTypeContextProxy::enumerationItems() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationTypeContext*)orig) -> enumerationItems();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationTypeContextProxy::enumerationExtension() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationTypeContext*)orig) -> enumerationExtension();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationTypeContextProxy::ENUMERATION() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationTypeContext*)orig) -> ENUMERATION();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EnumerationTypeContextProxy::EXTENSIBLE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationTypeContext*)orig) -> EXTENSIBLE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EnumerationTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectTypeContextProxy::selectList() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectTypeContext*)orig) -> selectList();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SelectTypeContextProxy::selectExtension() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectTypeContext*)orig) -> selectExtension();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SelectTypeContextProxy::SELECT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SelectTypeContext*)orig) -> SELECT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectTypeContextProxy::EXTENSIBLE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SelectTypeContext*)orig) -> EXTENSIBLE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectTypeContextProxy::GENERIC_ENTITY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SelectTypeContext*)orig) -> GENERIC_ENTITY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EntityDeclContextProxy::entityHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityDeclContext*)orig) -> entityHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityDeclContextProxy::entityBody() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityDeclContext*)orig) -> entityBody();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityDeclContextProxy::END_ENTITY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EntityDeclContext*)orig) -> END_ENTITY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object FunctionDeclContextProxy::functionHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionDeclContext*)orig) -> functionHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionDeclContextProxy::algorithmHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionDeclContext*)orig) -> algorithmHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionDeclContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::FunctionDeclContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object FunctionDeclContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionDeclContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionDeclContextProxy::END_FUNCTION() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::FunctionDeclContext*)orig) -> END_FUNCTION();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ProcedureDeclContextProxy::procedureHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureDeclContext*)orig) -> procedureHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureDeclContextProxy::algorithmHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureDeclContext*)orig) -> algorithmHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureDeclContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ProcedureDeclContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object ProcedureDeclContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureDeclContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureDeclContextProxy::END_PROCEDURE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ProcedureDeclContext*)orig) -> END_PROCEDURE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintDeclContextProxy::subtypeConstraintHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintDeclContext*)orig) -> subtypeConstraintHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintDeclContextProxy::subtypeConstraintBody() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintDeclContext*)orig) -> subtypeConstraintBody();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintDeclContextProxy::END_SUBTYPE_CONSTRAINT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeConstraintDeclContext*)orig) -> END_SUBTYPE_CONSTRAINT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object TypeDeclContextProxy::typeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeDeclContext*)orig) -> typeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeDeclContextProxy::underlyingType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeDeclContext*)orig) -> underlyingType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeDeclContextProxy::whereClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TypeDeclContext*)orig) -> whereClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TypeDeclContextProxy::TYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::TypeDeclContext*)orig) -> TYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object TypeDeclContextProxy::END_TYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::TypeDeclContext*)orig) -> END_TYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object DerivedAttrContextProxy::attributeDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DerivedAttrContext*)orig) -> attributeDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DerivedAttrContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DerivedAttrContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DerivedAttrContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DerivedAttrContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeriveClauseContextProxy::derivedAttr() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::DeriveClauseContext*)orig) -> derivedAttr().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(derivedAttrAt(i));
    }
  }

  return a;
}

Object DeriveClauseContextProxy::derivedAttrAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DeriveClauseContext*)orig) -> derivedAttr(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DeriveClauseContextProxy::DERIVE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::DeriveClauseContext*)orig) -> DERIVE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object DomainRuleContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DomainRuleContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object DomainRuleContextProxy::ruleLabelId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::DomainRuleContext*)orig) -> ruleLabelId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepetitionContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepetitionContext*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityBodyContextProxy::explicitAttr() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::EntityBodyContext*)orig) -> explicitAttr().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(explicitAttrAt(i));
    }
  }

  return a;
}

Object EntityBodyContextProxy::explicitAttrAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityBodyContext*)orig) -> explicitAttr(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityBodyContextProxy::deriveClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityBodyContext*)orig) -> deriveClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityBodyContextProxy::inverseClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityBodyContext*)orig) -> inverseClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityBodyContextProxy::uniqueClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityBodyContext*)orig) -> uniqueClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityBodyContextProxy::whereClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityBodyContext*)orig) -> whereClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ExplicitAttrContextProxy::attributeDecl() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ExplicitAttrContext*)orig) -> attributeDecl().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(attributeDeclAt(i));
    }
  }

  return a;
}

Object ExplicitAttrContextProxy::attributeDeclAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ExplicitAttrContext*)orig) -> attributeDecl(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ExplicitAttrContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ExplicitAttrContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ExplicitAttrContextProxy::OPTIONAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ExplicitAttrContext*)orig) -> OPTIONAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object InverseClauseContextProxy::inverseAttr() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::InverseClauseContext*)orig) -> inverseAttr().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(inverseAttrAt(i));
    }
  }

  return a;
}

Object InverseClauseContextProxy::inverseAttrAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseClauseContext*)orig) -> inverseAttr(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseClauseContextProxy::INVERSE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::InverseClauseContext*)orig) -> INVERSE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object UniqueClauseContextProxy::uniqueRule() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::UniqueClauseContext*)orig) -> uniqueRule().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(uniqueRuleAt(i));
    }
  }

  return a;
}

Object UniqueClauseContextProxy::uniqueRuleAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UniqueClauseContext*)orig) -> uniqueRule(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UniqueClauseContextProxy::UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::UniqueClauseContext*)orig) -> UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object WhereClauseContextProxy::domainRule() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::WhereClauseContext*)orig) -> domainRule().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(domainRuleAt(i));
    }
  }

  return a;
}

Object WhereClauseContextProxy::domainRuleAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::WhereClauseContext*)orig) -> domainRule(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object WhereClauseContextProxy::WHERE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::WhereClauseContext*)orig) -> WHERE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EntityConstructorContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityConstructorContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityConstructorContextProxy::expression() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::EntityConstructorContext*)orig) -> expression().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(expressionAt(i));
    }
  }

  return a;
}

Object EntityConstructorContextProxy::expressionAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityConstructorContext*)orig) -> expression(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityHeadContextProxy::entityId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityHeadContext*)orig) -> entityId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityHeadContextProxy::subsuper() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EntityHeadContext*)orig) -> subsuper();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EntityHeadContextProxy::ENTITY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EntityHeadContext*)orig) -> ENTITY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubsuperContextProxy::supertypeConstraint() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubsuperContext*)orig) -> supertypeConstraint();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubsuperContextProxy::subtypeDeclaration() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubsuperContext*)orig) -> subtypeDeclaration();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationExtensionContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationExtensionContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationExtensionContextProxy::enumerationItems() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationExtensionContext*)orig) -> enumerationItems();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationExtensionContextProxy::BASED_ON() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationExtensionContext*)orig) -> BASED_ON();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EnumerationExtensionContextProxy::WITH() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EnumerationExtensionContext*)orig) -> WITH();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object EnumerationItemsContextProxy::enumerationItem() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::EnumerationItemsContext*)orig) -> enumerationItem().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(enumerationItemAt(i));
    }
  }

  return a;
}

Object EnumerationItemsContextProxy::enumerationItemAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationItemsContext*)orig) -> enumerationItem(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationItemContextProxy::enumerationId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationItemContext*)orig) -> enumerationId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationReferenceContextProxy::enumerationRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationReferenceContext*)orig) -> enumerationRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EnumerationReferenceContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::EnumerationReferenceContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object EscapeStmtContextProxy::ESCAPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::EscapeStmtContext*)orig) -> ESCAPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RelOpExtendedContextProxy::relOp() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RelOpExtendedContext*)orig) -> relOp();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RelOpExtendedContextProxy::IN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RelOpExtendedContext*)orig) -> IN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RelOpExtendedContextProxy::LIKE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RelOpExtendedContext*)orig) -> LIKE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object FactorContextProxy::simpleFactor() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::FactorContext*)orig) -> simpleFactor().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(simpleFactorAt(i));
    }
  }

  return a;
}

Object FactorContextProxy::simpleFactorAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FactorContext*)orig) -> simpleFactor(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::aggregateInitializer() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> aggregateInitializer();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::entityConstructor() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> entityConstructor();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::enumerationReference() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> enumerationReference();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::interval() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> interval();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::queryExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> queryExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::simpleFactorExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> simpleFactorExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorContextProxy::simpleFactorUnaryExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorContext*)orig) -> simpleFactorUnaryExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FormalParameterContextProxy::parameterId() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::FormalParameterContext*)orig) -> parameterId().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(parameterIdAt(i));
    }
  }

  return a;
}

Object FormalParameterContextProxy::parameterIdAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FormalParameterContext*)orig) -> parameterId(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FormalParameterContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FormalParameterContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionCallContextProxy::builtInFunction() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionCallContext*)orig) -> builtInFunction();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionCallContextProxy::functionRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionCallContext*)orig) -> functionRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionCallContextProxy::actualParameterList() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionCallContext*)orig) -> actualParameterList();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionHeadContextProxy::functionId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionHeadContext*)orig) -> functionId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionHeadContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionHeadContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionHeadContextProxy::formalParameter() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::FunctionHeadContext*)orig) -> formalParameter().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(formalParameterAt(i));
    }
  }

  return a;
}

Object FunctionHeadContextProxy::formalParameterAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::FunctionHeadContext*)orig) -> formalParameter(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object FunctionHeadContextProxy::FUNCTION() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::FunctionHeadContext*)orig) -> FUNCTION();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralizedTypesContextProxy::aggregateType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralizedTypesContext*)orig) -> aggregateType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralizedTypesContextProxy::generalAggregationTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralizedTypesContext*)orig) -> generalAggregationTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralizedTypesContextProxy::genericEntityType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralizedTypesContext*)orig) -> genericEntityType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralizedTypesContextProxy::genericType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralizedTypesContext*)orig) -> genericType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralAggregationTypesContextProxy::generalArrayType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralAggregationTypesContext*)orig) -> generalArrayType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralAggregationTypesContextProxy::generalBagType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralAggregationTypesContext*)orig) -> generalBagType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralAggregationTypesContextProxy::generalListType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralAggregationTypesContext*)orig) -> generalListType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralAggregationTypesContextProxy::generalSetType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralAggregationTypesContext*)orig) -> generalSetType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GenericEntityTypeContextProxy::typeLabel() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GenericEntityTypeContext*)orig) -> typeLabel();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GenericEntityTypeContextProxy::GENERIC_ENTITY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GenericEntityTypeContext*)orig) -> GENERIC_ENTITY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GenericTypeContextProxy::typeLabel() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GenericTypeContext*)orig) -> typeLabel();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GenericTypeContextProxy::GENERIC() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GenericTypeContext*)orig) -> GENERIC();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralArrayTypeContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralArrayTypeContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralArrayTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralArrayTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralArrayTypeContextProxy::ARRAY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralArrayTypeContext*)orig) -> ARRAY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralArrayTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralArrayTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralArrayTypeContextProxy::OPTIONAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralArrayTypeContext*)orig) -> OPTIONAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralArrayTypeContextProxy::UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralArrayTypeContext*)orig) -> UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralBagTypeContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralBagTypeContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralBagTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralBagTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralBagTypeContextProxy::BAG() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralBagTypeContext*)orig) -> BAG();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralBagTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralBagTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralListTypeContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralListTypeContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralListTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralListTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralListTypeContextProxy::LIST() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralListTypeContext*)orig) -> LIST();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralListTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralListTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralListTypeContextProxy::UNIQUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralListTypeContext*)orig) -> UNIQUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralSetTypeContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralSetTypeContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralSetTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GeneralSetTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object GeneralSetTypeContextProxy::SET() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralSetTypeContext*)orig) -> SET();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GeneralSetTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::GeneralSetTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object GroupQualifierContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::GroupQualifierContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtContextProxy::logicalExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IfStmtContext*)orig) -> logicalExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtContextProxy::ifStmtStatements() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IfStmtContext*)orig) -> ifStmtStatements();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtContextProxy::ifStmtElseStatements() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IfStmtContext*)orig) -> ifStmtElseStatements();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtContextProxy::IF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IfStmtContext*)orig) -> IF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IfStmtContextProxy::THEN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IfStmtContext*)orig) -> THEN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IfStmtContextProxy::END_IF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IfStmtContext*)orig) -> END_IF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IfStmtContextProxy::ELSE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IfStmtContext*)orig) -> ELSE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LogicalExpressionContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LogicalExpressionContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtStatementsContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::IfStmtStatementsContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object IfStmtStatementsContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IfStmtStatementsContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IfStmtElseStatementsContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::IfStmtElseStatementsContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object IfStmtElseStatementsContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IfStmtElseStatementsContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IncrementContext*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementControlContextProxy::variableId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IncrementControlContext*)orig) -> variableId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementControlContextProxy::bound1() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IncrementControlContext*)orig) -> bound1();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementControlContextProxy::bound2() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IncrementControlContext*)orig) -> bound2();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementControlContextProxy::increment() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IncrementControlContext*)orig) -> increment();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IncrementControlContextProxy::TO() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IncrementControlContext*)orig) -> TO();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IncrementControlContextProxy::BY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IncrementControlContext*)orig) -> BY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IndexContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IndexContext*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object Index1ContextProxy::index() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::Index1Context*)orig) -> index();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object Index2ContextProxy::index() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::Index2Context*)orig) -> index();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IndexQualifierContextProxy::index1() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IndexQualifierContext*)orig) -> index1();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IndexQualifierContextProxy::index2() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IndexQualifierContext*)orig) -> index2();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntegerTypeContextProxy::INTEGER() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::IntegerTypeContext*)orig) -> INTEGER();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object InterfaceSpecificationContextProxy::referenceClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InterfaceSpecificationContext*)orig) -> referenceClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InterfaceSpecificationContextProxy::useClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InterfaceSpecificationContext*)orig) -> useClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReferenceClauseContextProxy::schemaRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ReferenceClauseContext*)orig) -> schemaRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReferenceClauseContextProxy::resourceOrRename() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ReferenceClauseContext*)orig) -> resourceOrRename().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(resourceOrRenameAt(i));
    }
  }

  return a;
}

Object ReferenceClauseContextProxy::resourceOrRenameAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ReferenceClauseContext*)orig) -> resourceOrRename(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReferenceClauseContextProxy::REFERENCE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ReferenceClauseContext*)orig) -> REFERENCE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ReferenceClauseContextProxy::FROM() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ReferenceClauseContext*)orig) -> FROM();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object UseClauseContextProxy::schemaRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UseClauseContext*)orig) -> schemaRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UseClauseContextProxy::namedTypeOrRename() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::UseClauseContext*)orig) -> namedTypeOrRename().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(namedTypeOrRenameAt(i));
    }
  }

  return a;
}

Object UseClauseContextProxy::namedTypeOrRenameAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UseClauseContext*)orig) -> namedTypeOrRename(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UseClauseContextProxy::USE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::UseClauseContext*)orig) -> USE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object UseClauseContextProxy::FROM() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::UseClauseContext*)orig) -> FROM();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object IntervalContextProxy::intervalLow() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalContext*)orig) -> intervalLow();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalContextProxy::intervalOp() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::IntervalContext*)orig) -> intervalOp().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(intervalOpAt(i));
    }
  }

  return a;
}

Object IntervalContextProxy::intervalOpAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalContext*)orig) -> intervalOp(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalContextProxy::intervalItem() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalContext*)orig) -> intervalItem();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalContextProxy::intervalHigh() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalContext*)orig) -> intervalHigh();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalLowContextProxy::simpleExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalLowContext*)orig) -> simpleExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalItemContextProxy::simpleExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalItemContext*)orig) -> simpleExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object IntervalHighContextProxy::simpleExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::IntervalHighContext*)orig) -> simpleExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrContextProxy::attributeDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrContext*)orig) -> attributeDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrContextProxy::inverseAttrType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrContext*)orig) -> inverseAttrType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrContextProxy::attributeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrContext*)orig) -> attributeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrContextProxy::FOR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::InverseAttrContext*)orig) -> FOR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object InverseAttrTypeContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrTypeContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrTypeContextProxy::boundSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::InverseAttrTypeContext*)orig) -> boundSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object InverseAttrTypeContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::InverseAttrTypeContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object InverseAttrTypeContextProxy::SET() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::InverseAttrTypeContext*)orig) -> SET();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object InverseAttrTypeContextProxy::BAG() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::InverseAttrTypeContext*)orig) -> BAG();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LiteralContextProxy::logicalLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LiteralContext*)orig) -> logicalLiteral();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LiteralContextProxy::stringLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LiteralContext*)orig) -> stringLiteral();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LiteralContextProxy::BinaryLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LiteralContext*)orig) -> BinaryLiteral();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LiteralContextProxy::IntegerLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LiteralContext*)orig) -> IntegerLiteral();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LiteralContextProxy::RealLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LiteralContext*)orig) -> RealLiteral();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LogicalLiteralContextProxy::FALSE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LogicalLiteralContext*)orig) -> FALSE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LogicalLiteralContextProxy::TRUE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LogicalLiteralContext*)orig) -> TRUE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LogicalLiteralContextProxy::UNKNOWN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LogicalLiteralContext*)orig) -> UNKNOWN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object StringLiteralContextProxy::SimpleStringLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::StringLiteralContext*)orig) -> SimpleStringLiteral();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object StringLiteralContextProxy::EncodedStringLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::StringLiteralContext*)orig) -> EncodedStringLiteral();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object LocalVariableContextProxy::variableId() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::LocalVariableContext*)orig) -> variableId().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(variableIdAt(i));
    }
  }

  return a;
}

Object LocalVariableContextProxy::variableIdAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LocalVariableContext*)orig) -> variableId(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LocalVariableContextProxy::parameterType() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LocalVariableContext*)orig) -> parameterType();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LocalVariableContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::LocalVariableContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object LogicalTypeContextProxy::LOGICAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::LogicalTypeContext*)orig) -> LOGICAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object MultiplicationLikeOpContextProxy::DIV() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::MultiplicationLikeOpContext*)orig) -> DIV();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object MultiplicationLikeOpContextProxy::MOD() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::MultiplicationLikeOpContext*)orig) -> MOD();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object MultiplicationLikeOpContextProxy::AND() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::MultiplicationLikeOpContext*)orig) -> AND();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object NamedTypesContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NamedTypesContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NamedTypesContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NamedTypesContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NamedTypeOrRenameContextProxy::namedTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NamedTypeOrRenameContext*)orig) -> namedTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NamedTypeOrRenameContextProxy::entityId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NamedTypeOrRenameContext*)orig) -> entityId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NamedTypeOrRenameContextProxy::typeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::NamedTypeOrRenameContext*)orig) -> typeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object NamedTypeOrRenameContextProxy::AS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::NamedTypeOrRenameContext*)orig) -> AS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object NumberTypeContextProxy::NUMBER() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::NumberTypeContext*)orig) -> NUMBER();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object OneOfContextProxy::supertypeExpression() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::OneOfContext*)orig) -> supertypeExpression().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(supertypeExpressionAt(i));
    }
  }

  return a;
}

Object OneOfContextProxy::supertypeExpressionAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::OneOfContext*)orig) -> supertypeExpression(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object OneOfContextProxy::ONEOF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::OneOfContext*)orig) -> ONEOF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SupertypeExpressionContextProxy::supertypeFactor() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SupertypeExpressionContext*)orig) -> supertypeFactor().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(supertypeFactorAt(i));
    }
  }

  return a;
}

Object SupertypeExpressionContextProxy::supertypeFactorAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeExpressionContext*)orig) -> supertypeFactor(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeExpressionContextProxy::ANDOR() {
  Array a;

  if (orig == nullptr) {
    return a;
  }

  auto vec = ((ExpressParser::SupertypeExpressionContext*)orig) -> ANDOR();

  for (auto it = vec.begin(); it != vec.end(); it ++) {
    TerminalNodeProxy proxy(*it);
    a.push(proxy);
  }

  return a;
}

Object SupertypeExpressionContextProxy::ANDORAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SupertypeExpressionContext*)orig) -> ANDOR(i);

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object PopulationContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::PopulationContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object PrecisionSpecContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::PrecisionSpecContext*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object PrimaryContextProxy::literal() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::PrimaryContext*)orig) -> literal();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object PrimaryContextProxy::qualifiableFactor() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::PrimaryContext*)orig) -> qualifiableFactor();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object PrimaryContextProxy::qualifier() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::PrimaryContext*)orig) -> qualifier().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(qualifierAt(i));
    }
  }

  return a;
}

Object PrimaryContextProxy::qualifierAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::PrimaryContext*)orig) -> qualifier(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiableFactorContextProxy::attributeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiableFactorContext*)orig) -> attributeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiableFactorContextProxy::constantFactor() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiableFactorContext*)orig) -> constantFactor();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiableFactorContextProxy::functionCall() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiableFactorContext*)orig) -> functionCall();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiableFactorContextProxy::generalRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiableFactorContext*)orig) -> generalRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiableFactorContextProxy::population() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiableFactorContext*)orig) -> population();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureCallStmtContextProxy::builtInProcedure() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureCallStmtContext*)orig) -> builtInProcedure();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureCallStmtContextProxy::procedureRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureCallStmtContext*)orig) -> procedureRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureCallStmtContextProxy::actualParameterList() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureCallStmtContext*)orig) -> actualParameterList();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureHeadContextProxy::procedureId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureHeadContext*)orig) -> procedureId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureHeadContextProxy::procedureHeadParameter() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::ProcedureHeadContext*)orig) -> procedureHeadParameter().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(procedureHeadParameterAt(i));
    }
  }

  return a;
}

Object ProcedureHeadContextProxy::procedureHeadParameterAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureHeadContext*)orig) -> procedureHeadParameter(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureHeadContextProxy::PROCEDURE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ProcedureHeadContext*)orig) -> PROCEDURE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ProcedureHeadParameterContextProxy::formalParameter() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ProcedureHeadParameterContext*)orig) -> formalParameter();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ProcedureHeadParameterContextProxy::VAR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ProcedureHeadParameterContext*)orig) -> VAR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object QualifiedAttributeContextProxy::groupQualifier() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiedAttributeContext*)orig) -> groupQualifier();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiedAttributeContextProxy::attributeQualifier() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QualifiedAttributeContext*)orig) -> attributeQualifier();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QualifiedAttributeContextProxy::SELF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::QualifiedAttributeContext*)orig) -> SELF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object QueryExpressionContextProxy::variableId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QueryExpressionContext*)orig) -> variableId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QueryExpressionContextProxy::aggregateSource() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QueryExpressionContext*)orig) -> aggregateSource();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QueryExpressionContextProxy::logicalExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::QueryExpressionContext*)orig) -> logicalExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object QueryExpressionContextProxy::QUERY() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::QueryExpressionContext*)orig) -> QUERY();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RealTypeContextProxy::precisionSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RealTypeContext*)orig) -> precisionSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RealTypeContextProxy::REAL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RealTypeContext*)orig) -> REAL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ReferencedAttributeContextProxy::attributeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ReferencedAttributeContext*)orig) -> attributeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReferencedAttributeContextProxy::qualifiedAttribute() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ReferencedAttributeContext*)orig) -> qualifiedAttribute();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceOrRenameContextProxy::resourceRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceOrRenameContext*)orig) -> resourceRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceOrRenameContextProxy::renameId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceOrRenameContext*)orig) -> renameId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceOrRenameContextProxy::AS() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ResourceOrRenameContext*)orig) -> AS();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RenameIdContextProxy::constantId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RenameIdContext*)orig) -> constantId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RenameIdContextProxy::entityId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RenameIdContext*)orig) -> entityId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RenameIdContextProxy::functionId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RenameIdContext*)orig) -> functionId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RenameIdContextProxy::procedureId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RenameIdContext*)orig) -> procedureId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RenameIdContextProxy::typeId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RenameIdContext*)orig) -> typeId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepeatControlContextProxy::incrementControl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepeatControlContext*)orig) -> incrementControl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepeatControlContextProxy::whileControl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepeatControlContext*)orig) -> whileControl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepeatControlContextProxy::untilControl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepeatControlContext*)orig) -> untilControl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object WhileControlContextProxy::logicalExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::WhileControlContext*)orig) -> logicalExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object WhileControlContextProxy::WHILE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::WhileControlContext*)orig) -> WHILE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object UntilControlContextProxy::logicalExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UntilControlContext*)orig) -> logicalExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UntilControlContextProxy::UNTIL() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::UntilControlContext*)orig) -> UNTIL();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RepeatStmtContextProxy::repeatControl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepeatStmtContext*)orig) -> repeatControl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepeatStmtContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::RepeatStmtContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object RepeatStmtContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RepeatStmtContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RepeatStmtContextProxy::REPEAT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RepeatStmtContext*)orig) -> REPEAT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RepeatStmtContextProxy::END_REPEAT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RepeatStmtContext*)orig) -> END_REPEAT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object ResourceRefContextProxy::constantRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceRefContext*)orig) -> constantRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceRefContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceRefContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceRefContextProxy::functionRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceRefContext*)orig) -> functionRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceRefContextProxy::procedureRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceRefContext*)orig) -> procedureRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ResourceRefContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ResourceRefContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReturnStmtContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::ReturnStmtContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object ReturnStmtContextProxy::RETURN() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::ReturnStmtContext*)orig) -> RETURN();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RuleDeclContextProxy::ruleHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleDeclContext*)orig) -> ruleHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleDeclContextProxy::algorithmHead() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleDeclContext*)orig) -> algorithmHead();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleDeclContextProxy::whereClause() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleDeclContext*)orig) -> whereClause();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleDeclContextProxy::stmt() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::RuleDeclContext*)orig) -> stmt().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(stmtAt(i));
    }
  }

  return a;
}

Object RuleDeclContextProxy::stmtAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleDeclContext*)orig) -> stmt(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleDeclContextProxy::END_RULE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RuleDeclContext*)orig) -> END_RULE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RuleHeadContextProxy::ruleId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleHeadContext*)orig) -> ruleId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleHeadContextProxy::entityRef() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::RuleHeadContext*)orig) -> entityRef().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(entityRefAt(i));
    }
  }

  return a;
}

Object RuleHeadContextProxy::entityRefAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::RuleHeadContext*)orig) -> entityRef(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object RuleHeadContextProxy::RULE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RuleHeadContext*)orig) -> RULE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object RuleHeadContextProxy::FOR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::RuleHeadContext*)orig) -> FOR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SchemaBodyContextProxy::interfaceSpecification() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SchemaBodyContext*)orig) -> interfaceSpecification().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(interfaceSpecificationAt(i));
    }
  }

  return a;
}

Object SchemaBodyContextProxy::interfaceSpecificationAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaBodyContext*)orig) -> interfaceSpecification(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaBodyContextProxy::constantDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaBodyContext*)orig) -> constantDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaBodyContextProxy::schemaBodyDeclaration() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SchemaBodyContext*)orig) -> schemaBodyDeclaration().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(schemaBodyDeclarationAt(i));
    }
  }

  return a;
}

Object SchemaBodyContextProxy::schemaBodyDeclarationAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaBodyContext*)orig) -> schemaBodyDeclaration(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaBodyDeclarationContextProxy::declaration() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaBodyDeclarationContext*)orig) -> declaration();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaBodyDeclarationContextProxy::ruleDecl() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaBodyDeclarationContext*)orig) -> ruleDecl();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaDeclContextProxy::schemaId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaDeclContext*)orig) -> schemaId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaDeclContextProxy::schemaBody() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaDeclContext*)orig) -> schemaBody();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaDeclContextProxy::schemaVersionId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaDeclContext*)orig) -> schemaVersionId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SchemaDeclContextProxy::SCHEMA() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SchemaDeclContext*)orig) -> SCHEMA();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SchemaDeclContextProxy::END_SCHEMA() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SchemaDeclContext*)orig) -> END_SCHEMA();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SchemaVersionIdContextProxy::stringLiteral() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SchemaVersionIdContext*)orig) -> stringLiteral();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SelectExtensionContextProxy::typeRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectExtensionContext*)orig) -> typeRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SelectExtensionContextProxy::selectList() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectExtensionContext*)orig) -> selectList();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SelectExtensionContextProxy::BASED_ON() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SelectExtensionContext*)orig) -> BASED_ON();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectExtensionContextProxy::WITH() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SelectExtensionContext*)orig) -> WITH();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SelectListContextProxy::namedTypes() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SelectListContext*)orig) -> namedTypes().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(namedTypesAt(i));
    }
  }

  return a;
}

Object SelectListContextProxy::namedTypesAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SelectListContext*)orig) -> namedTypes(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TermContextProxy::factor() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::TermContext*)orig) -> factor().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(factorAt(i));
    }
  }

  return a;
}

Object TermContextProxy::factorAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TermContext*)orig) -> factor(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TermContextProxy::multiplicationLikeOp() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::TermContext*)orig) -> multiplicationLikeOp().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(multiplicationLikeOpAt(i));
    }
  }

  return a;
}

Object TermContextProxy::multiplicationLikeOpAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TermContext*)orig) -> multiplicationLikeOp(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorExpressionContextProxy::expression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorExpressionContext*)orig) -> expression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorExpressionContextProxy::primary() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorExpressionContext*)orig) -> primary();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorUnaryExpressionContextProxy::unaryOp() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorUnaryExpressionContext*)orig) -> unaryOp();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SimpleFactorUnaryExpressionContextProxy::simpleFactorExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SimpleFactorUnaryExpressionContext*)orig) -> simpleFactorExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UnaryOpContextProxy::NOT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::UnaryOpContext*)orig) -> NOT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object StringTypeContextProxy::widthSpec() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::StringTypeContext*)orig) -> widthSpec();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object StringTypeContextProxy::STRING() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::StringTypeContext*)orig) -> STRING();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SkipStmtContextProxy::SKIP_() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SkipStmtContext*)orig) -> SKIP_();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SupertypeConstraintContextProxy::abstractEntityDeclaration() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeConstraintContext*)orig) -> abstractEntityDeclaration();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeConstraintContextProxy::abstractSupertypeDeclaration() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeConstraintContext*)orig) -> abstractSupertypeDeclaration();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeConstraintContextProxy::supertypeRule() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeConstraintContext*)orig) -> supertypeRule();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeDeclarationContextProxy::entityRef() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SubtypeDeclarationContext*)orig) -> entityRef().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(entityRefAt(i));
    }
  }

  return a;
}

Object SubtypeDeclarationContextProxy::entityRefAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeDeclarationContext*)orig) -> entityRef(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeDeclarationContextProxy::SUBTYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeDeclarationContext*)orig) -> SUBTYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeDeclarationContextProxy::OF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeDeclarationContext*)orig) -> OF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintBodyContextProxy::abstractSupertype() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintBodyContext*)orig) -> abstractSupertype();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintBodyContextProxy::totalOver() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintBodyContext*)orig) -> totalOver();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintBodyContextProxy::supertypeExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintBodyContext*)orig) -> supertypeExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TotalOverContextProxy::entityRef() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::TotalOverContext*)orig) -> entityRef().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(entityRefAt(i));
    }
  }

  return a;
}

Object TotalOverContextProxy::entityRefAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::TotalOverContext*)orig) -> entityRef(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object TotalOverContextProxy::TOTAL_OVER() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::TotalOverContext*)orig) -> TOTAL_OVER();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintHeadContextProxy::subtypeConstraintId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintHeadContext*)orig) -> subtypeConstraintId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintHeadContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SubtypeConstraintHeadContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SubtypeConstraintHeadContextProxy::SUBTYPE_CONSTRAINT() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeConstraintHeadContext*)orig) -> SUBTYPE_CONSTRAINT();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SubtypeConstraintHeadContextProxy::FOR() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SubtypeConstraintHeadContext*)orig) -> FOR();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SupertypeRuleContextProxy::subtypeConstraint() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeRuleContext*)orig) -> subtypeConstraint();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeRuleContextProxy::SUPERTYPE() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SupertypeRuleContext*)orig) -> SUPERTYPE();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SupertypeFactorContextProxy::supertypeTerm() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SupertypeFactorContext*)orig) -> supertypeTerm().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(supertypeTermAt(i));
    }
  }

  return a;
}

Object SupertypeFactorContextProxy::supertypeTermAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeFactorContext*)orig) -> supertypeTerm(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeFactorContextProxy::AND() {
  Array a;

  if (orig == nullptr) {
    return a;
  }

  auto vec = ((ExpressParser::SupertypeFactorContext*)orig) -> AND();

  for (auto it = vec.begin(); it != vec.end(); it ++) {
    TerminalNodeProxy proxy(*it);
    a.push(proxy);
  }

  return a;
}

Object SupertypeFactorContextProxy::ANDAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SupertypeFactorContext*)orig) -> AND(i);

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object SupertypeTermContextProxy::entityRef() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeTermContext*)orig) -> entityRef();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeTermContextProxy::oneOf() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeTermContext*)orig) -> oneOf();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SupertypeTermContextProxy::supertypeExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SupertypeTermContext*)orig) -> supertypeExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SyntaxContextProxy::schemaDecl() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::SyntaxContext*)orig) -> schemaDecl().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(schemaDeclAt(i));
    }
  }

  return a;
}

Object SyntaxContextProxy::schemaDeclAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::SyntaxContext*)orig) -> schemaDecl(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object SyntaxContextProxy::EOF() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto token = ((ExpressParser::SyntaxContext*)orig) -> EOF();

  if (token == nullptr) {
    return Qnil;
  }

  TerminalNodeProxy proxy(token);
  return to_ruby(proxy);
}

Object UnderlyingTypeContextProxy::concreteTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UnderlyingTypeContext*)orig) -> concreteTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UnderlyingTypeContextProxy::constructedTypes() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UnderlyingTypeContext*)orig) -> constructedTypes();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UniqueRuleContextProxy::referencedAttribute() {
  Array a;

  if (orig != nullptr) {
    size_t count = ((ExpressParser::UniqueRuleContext*)orig) -> referencedAttribute().size();

    for (size_t i = 0; i < count; i ++) {
      a.push(referencedAttributeAt(i));
    }
  }

  return a;
}

Object UniqueRuleContextProxy::referencedAttributeAt(size_t i) {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UniqueRuleContext*)orig) -> referencedAttribute(i);

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object UniqueRuleContextProxy::ruleLabelId() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::UniqueRuleContext*)orig) -> ruleLabelId();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}

Object WidthContextProxy::numericExpression() {
  if (orig == nullptr) {
    return Qnil;
  }

  auto ctx = ((ExpressParser::WidthContext*)orig) -> numericExpression();

  if (ctx == nullptr) {
    return Qnil;
  }

  for (auto child : getChildren()) {
    if (ctx == from_ruby<ContextProxy>(child).getOriginal()) {
      return child;
    }
  }

  return Nil;
}


class VisitorProxy : public ExpressBaseVisitor, public Director {
public:
  VisitorProxy(Object self) : Director(self) { }

  Object ruby_visit(ContextProxy* proxy) {
    auto result = visit(proxy -> getOriginal());
    return result.as<Object>();
  }

  Object ruby_visitChildren(ContextProxy* proxy) {
    auto result = visitChildren(proxy -> getOriginal());
    return result.as<Object>();
  }

  virtual antlrcpp::Any visitAttributeRef(ExpressParser::AttributeRefContext *ctx) override {
    AttributeRefContextProxy proxy(ctx);
    return getSelf().call("visit_attribute_ref", &proxy);
  }

  virtual antlrcpp::Any visitConstantRef(ExpressParser::ConstantRefContext *ctx) override {
    ConstantRefContextProxy proxy(ctx);
    return getSelf().call("visit_constant_ref", &proxy);
  }

  virtual antlrcpp::Any visitEntityRef(ExpressParser::EntityRefContext *ctx) override {
    EntityRefContextProxy proxy(ctx);
    return getSelf().call("visit_entity_ref", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationRef(ExpressParser::EnumerationRefContext *ctx) override {
    EnumerationRefContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_ref", &proxy);
  }

  virtual antlrcpp::Any visitFunctionRef(ExpressParser::FunctionRefContext *ctx) override {
    FunctionRefContextProxy proxy(ctx);
    return getSelf().call("visit_function_ref", &proxy);
  }

  virtual antlrcpp::Any visitParameterRef(ExpressParser::ParameterRefContext *ctx) override {
    ParameterRefContextProxy proxy(ctx);
    return getSelf().call("visit_parameter_ref", &proxy);
  }

  virtual antlrcpp::Any visitProcedureRef(ExpressParser::ProcedureRefContext *ctx) override {
    ProcedureRefContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_ref", &proxy);
  }

  virtual antlrcpp::Any visitRuleLabelRef(ExpressParser::RuleLabelRefContext *ctx) override {
    RuleLabelRefContextProxy proxy(ctx);
    return getSelf().call("visit_rule_label_ref", &proxy);
  }

  virtual antlrcpp::Any visitRuleRef(ExpressParser::RuleRefContext *ctx) override {
    RuleRefContextProxy proxy(ctx);
    return getSelf().call("visit_rule_ref", &proxy);
  }

  virtual antlrcpp::Any visitSchemaRef(ExpressParser::SchemaRefContext *ctx) override {
    SchemaRefContextProxy proxy(ctx);
    return getSelf().call("visit_schema_ref", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraintRef(ExpressParser::SubtypeConstraintRefContext *ctx) override {
    SubtypeConstraintRefContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint_ref", &proxy);
  }

  virtual antlrcpp::Any visitTypeLabelRef(ExpressParser::TypeLabelRefContext *ctx) override {
    TypeLabelRefContextProxy proxy(ctx);
    return getSelf().call("visit_type_label_ref", &proxy);
  }

  virtual antlrcpp::Any visitTypeRef(ExpressParser::TypeRefContext *ctx) override {
    TypeRefContextProxy proxy(ctx);
    return getSelf().call("visit_type_ref", &proxy);
  }

  virtual antlrcpp::Any visitVariableRef(ExpressParser::VariableRefContext *ctx) override {
    VariableRefContextProxy proxy(ctx);
    return getSelf().call("visit_variable_ref", &proxy);
  }

  virtual antlrcpp::Any visitAbstractEntityDeclaration(ExpressParser::AbstractEntityDeclarationContext *ctx) override {
    AbstractEntityDeclarationContextProxy proxy(ctx);
    return getSelf().call("visit_abstract_entity_declaration", &proxy);
  }

  virtual antlrcpp::Any visitAbstractSupertype(ExpressParser::AbstractSupertypeContext *ctx) override {
    AbstractSupertypeContextProxy proxy(ctx);
    return getSelf().call("visit_abstract_supertype", &proxy);
  }

  virtual antlrcpp::Any visitAbstractSupertypeDeclaration(ExpressParser::AbstractSupertypeDeclarationContext *ctx) override {
    AbstractSupertypeDeclarationContextProxy proxy(ctx);
    return getSelf().call("visit_abstract_supertype_declaration", &proxy);
  }

  virtual antlrcpp::Any visitActualParameterList(ExpressParser::ActualParameterListContext *ctx) override {
    ActualParameterListContextProxy proxy(ctx);
    return getSelf().call("visit_actual_parameter_list", &proxy);
  }

  virtual antlrcpp::Any visitAddLikeOp(ExpressParser::AddLikeOpContext *ctx) override {
    AddLikeOpContextProxy proxy(ctx);
    return getSelf().call("visit_add_like_op", &proxy);
  }

  virtual antlrcpp::Any visitAggregateInitializer(ExpressParser::AggregateInitializerContext *ctx) override {
    AggregateInitializerContextProxy proxy(ctx);
    return getSelf().call("visit_aggregate_initializer", &proxy);
  }

  virtual antlrcpp::Any visitAggregateSource(ExpressParser::AggregateSourceContext *ctx) override {
    AggregateSourceContextProxy proxy(ctx);
    return getSelf().call("visit_aggregate_source", &proxy);
  }

  virtual antlrcpp::Any visitAggregateType(ExpressParser::AggregateTypeContext *ctx) override {
    AggregateTypeContextProxy proxy(ctx);
    return getSelf().call("visit_aggregate_type", &proxy);
  }

  virtual antlrcpp::Any visitAggregationTypes(ExpressParser::AggregationTypesContext *ctx) override {
    AggregationTypesContextProxy proxy(ctx);
    return getSelf().call("visit_aggregation_types", &proxy);
  }

  virtual antlrcpp::Any visitAlgorithmHead(ExpressParser::AlgorithmHeadContext *ctx) override {
    AlgorithmHeadContextProxy proxy(ctx);
    return getSelf().call("visit_algorithm_head", &proxy);
  }

  virtual antlrcpp::Any visitAliasStmt(ExpressParser::AliasStmtContext *ctx) override {
    AliasStmtContextProxy proxy(ctx);
    return getSelf().call("visit_alias_stmt", &proxy);
  }

  virtual antlrcpp::Any visitArrayType(ExpressParser::ArrayTypeContext *ctx) override {
    ArrayTypeContextProxy proxy(ctx);
    return getSelf().call("visit_array_type", &proxy);
  }

  virtual antlrcpp::Any visitAssignmentStmt(ExpressParser::AssignmentStmtContext *ctx) override {
    AssignmentStmtContextProxy proxy(ctx);
    return getSelf().call("visit_assignment_stmt", &proxy);
  }

  virtual antlrcpp::Any visitAttributeDecl(ExpressParser::AttributeDeclContext *ctx) override {
    AttributeDeclContextProxy proxy(ctx);
    return getSelf().call("visit_attribute_decl", &proxy);
  }

  virtual antlrcpp::Any visitAttributeId(ExpressParser::AttributeIdContext *ctx) override {
    AttributeIdContextProxy proxy(ctx);
    return getSelf().call("visit_attribute_id", &proxy);
  }

  virtual antlrcpp::Any visitAttributeQualifier(ExpressParser::AttributeQualifierContext *ctx) override {
    AttributeQualifierContextProxy proxy(ctx);
    return getSelf().call("visit_attribute_qualifier", &proxy);
  }

  virtual antlrcpp::Any visitBagType(ExpressParser::BagTypeContext *ctx) override {
    BagTypeContextProxy proxy(ctx);
    return getSelf().call("visit_bag_type", &proxy);
  }

  virtual antlrcpp::Any visitBinaryType(ExpressParser::BinaryTypeContext *ctx) override {
    BinaryTypeContextProxy proxy(ctx);
    return getSelf().call("visit_binary_type", &proxy);
  }

  virtual antlrcpp::Any visitBooleanType(ExpressParser::BooleanTypeContext *ctx) override {
    BooleanTypeContextProxy proxy(ctx);
    return getSelf().call("visit_boolean_type", &proxy);
  }

  virtual antlrcpp::Any visitBound1(ExpressParser::Bound1Context *ctx) override {
    Bound1ContextProxy proxy(ctx);
    return getSelf().call("visit_bound1", &proxy);
  }

  virtual antlrcpp::Any visitBound2(ExpressParser::Bound2Context *ctx) override {
    Bound2ContextProxy proxy(ctx);
    return getSelf().call("visit_bound2", &proxy);
  }

  virtual antlrcpp::Any visitBoundSpec(ExpressParser::BoundSpecContext *ctx) override {
    BoundSpecContextProxy proxy(ctx);
    return getSelf().call("visit_bound_spec", &proxy);
  }

  virtual antlrcpp::Any visitBuiltInConstant(ExpressParser::BuiltInConstantContext *ctx) override {
    BuiltInConstantContextProxy proxy(ctx);
    return getSelf().call("visit_built_in_constant", &proxy);
  }

  virtual antlrcpp::Any visitBuiltInFunction(ExpressParser::BuiltInFunctionContext *ctx) override {
    BuiltInFunctionContextProxy proxy(ctx);
    return getSelf().call("visit_built_in_function", &proxy);
  }

  virtual antlrcpp::Any visitBuiltInProcedure(ExpressParser::BuiltInProcedureContext *ctx) override {
    BuiltInProcedureContextProxy proxy(ctx);
    return getSelf().call("visit_built_in_procedure", &proxy);
  }

  virtual antlrcpp::Any visitCaseAction(ExpressParser::CaseActionContext *ctx) override {
    CaseActionContextProxy proxy(ctx);
    return getSelf().call("visit_case_action", &proxy);
  }

  virtual antlrcpp::Any visitCaseLabel(ExpressParser::CaseLabelContext *ctx) override {
    CaseLabelContextProxy proxy(ctx);
    return getSelf().call("visit_case_label", &proxy);
  }

  virtual antlrcpp::Any visitCaseStmt(ExpressParser::CaseStmtContext *ctx) override {
    CaseStmtContextProxy proxy(ctx);
    return getSelf().call("visit_case_stmt", &proxy);
  }

  virtual antlrcpp::Any visitCompoundStmt(ExpressParser::CompoundStmtContext *ctx) override {
    CompoundStmtContextProxy proxy(ctx);
    return getSelf().call("visit_compound_stmt", &proxy);
  }

  virtual antlrcpp::Any visitConcreteTypes(ExpressParser::ConcreteTypesContext *ctx) override {
    ConcreteTypesContextProxy proxy(ctx);
    return getSelf().call("visit_concrete_types", &proxy);
  }

  virtual antlrcpp::Any visitConstantBody(ExpressParser::ConstantBodyContext *ctx) override {
    ConstantBodyContextProxy proxy(ctx);
    return getSelf().call("visit_constant_body", &proxy);
  }

  virtual antlrcpp::Any visitConstantDecl(ExpressParser::ConstantDeclContext *ctx) override {
    ConstantDeclContextProxy proxy(ctx);
    return getSelf().call("visit_constant_decl", &proxy);
  }

  virtual antlrcpp::Any visitConstantFactor(ExpressParser::ConstantFactorContext *ctx) override {
    ConstantFactorContextProxy proxy(ctx);
    return getSelf().call("visit_constant_factor", &proxy);
  }

  virtual antlrcpp::Any visitConstantId(ExpressParser::ConstantIdContext *ctx) override {
    ConstantIdContextProxy proxy(ctx);
    return getSelf().call("visit_constant_id", &proxy);
  }

  virtual antlrcpp::Any visitConstructedTypes(ExpressParser::ConstructedTypesContext *ctx) override {
    ConstructedTypesContextProxy proxy(ctx);
    return getSelf().call("visit_constructed_types", &proxy);
  }

  virtual antlrcpp::Any visitDeclaration(ExpressParser::DeclarationContext *ctx) override {
    DeclarationContextProxy proxy(ctx);
    return getSelf().call("visit_declaration", &proxy);
  }

  virtual antlrcpp::Any visitDerivedAttr(ExpressParser::DerivedAttrContext *ctx) override {
    DerivedAttrContextProxy proxy(ctx);
    return getSelf().call("visit_derived_attr", &proxy);
  }

  virtual antlrcpp::Any visitDeriveClause(ExpressParser::DeriveClauseContext *ctx) override {
    DeriveClauseContextProxy proxy(ctx);
    return getSelf().call("visit_derive_clause", &proxy);
  }

  virtual antlrcpp::Any visitDomainRule(ExpressParser::DomainRuleContext *ctx) override {
    DomainRuleContextProxy proxy(ctx);
    return getSelf().call("visit_domain_rule", &proxy);
  }

  virtual antlrcpp::Any visitElement(ExpressParser::ElementContext *ctx) override {
    ElementContextProxy proxy(ctx);
    return getSelf().call("visit_element", &proxy);
  }

  virtual antlrcpp::Any visitEntityBody(ExpressParser::EntityBodyContext *ctx) override {
    EntityBodyContextProxy proxy(ctx);
    return getSelf().call("visit_entity_body", &proxy);
  }

  virtual antlrcpp::Any visitEntityConstructor(ExpressParser::EntityConstructorContext *ctx) override {
    EntityConstructorContextProxy proxy(ctx);
    return getSelf().call("visit_entity_constructor", &proxy);
  }

  virtual antlrcpp::Any visitEntityDecl(ExpressParser::EntityDeclContext *ctx) override {
    EntityDeclContextProxy proxy(ctx);
    return getSelf().call("visit_entity_decl", &proxy);
  }

  virtual antlrcpp::Any visitEntityHead(ExpressParser::EntityHeadContext *ctx) override {
    EntityHeadContextProxy proxy(ctx);
    return getSelf().call("visit_entity_head", &proxy);
  }

  virtual antlrcpp::Any visitEntityId(ExpressParser::EntityIdContext *ctx) override {
    EntityIdContextProxy proxy(ctx);
    return getSelf().call("visit_entity_id", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationExtension(ExpressParser::EnumerationExtensionContext *ctx) override {
    EnumerationExtensionContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_extension", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationId(ExpressParser::EnumerationIdContext *ctx) override {
    EnumerationIdContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_id", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationItems(ExpressParser::EnumerationItemsContext *ctx) override {
    EnumerationItemsContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_items", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationItem(ExpressParser::EnumerationItemContext *ctx) override {
    EnumerationItemContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_item", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationReference(ExpressParser::EnumerationReferenceContext *ctx) override {
    EnumerationReferenceContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_reference", &proxy);
  }

  virtual antlrcpp::Any visitEnumerationType(ExpressParser::EnumerationTypeContext *ctx) override {
    EnumerationTypeContextProxy proxy(ctx);
    return getSelf().call("visit_enumeration_type", &proxy);
  }

  virtual antlrcpp::Any visitEscapeStmt(ExpressParser::EscapeStmtContext *ctx) override {
    EscapeStmtContextProxy proxy(ctx);
    return getSelf().call("visit_escape_stmt", &proxy);
  }

  virtual antlrcpp::Any visitExplicitAttr(ExpressParser::ExplicitAttrContext *ctx) override {
    ExplicitAttrContextProxy proxy(ctx);
    return getSelf().call("visit_explicit_attr", &proxy);
  }

  virtual antlrcpp::Any visitExpression(ExpressParser::ExpressionContext *ctx) override {
    ExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_expression", &proxy);
  }

  virtual antlrcpp::Any visitFactor(ExpressParser::FactorContext *ctx) override {
    FactorContextProxy proxy(ctx);
    return getSelf().call("visit_factor", &proxy);
  }

  virtual antlrcpp::Any visitFormalParameter(ExpressParser::FormalParameterContext *ctx) override {
    FormalParameterContextProxy proxy(ctx);
    return getSelf().call("visit_formal_parameter", &proxy);
  }

  virtual antlrcpp::Any visitFunctionCall(ExpressParser::FunctionCallContext *ctx) override {
    FunctionCallContextProxy proxy(ctx);
    return getSelf().call("visit_function_call", &proxy);
  }

  virtual antlrcpp::Any visitFunctionDecl(ExpressParser::FunctionDeclContext *ctx) override {
    FunctionDeclContextProxy proxy(ctx);
    return getSelf().call("visit_function_decl", &proxy);
  }

  virtual antlrcpp::Any visitFunctionHead(ExpressParser::FunctionHeadContext *ctx) override {
    FunctionHeadContextProxy proxy(ctx);
    return getSelf().call("visit_function_head", &proxy);
  }

  virtual antlrcpp::Any visitFunctionId(ExpressParser::FunctionIdContext *ctx) override {
    FunctionIdContextProxy proxy(ctx);
    return getSelf().call("visit_function_id", &proxy);
  }

  virtual antlrcpp::Any visitGeneralizedTypes(ExpressParser::GeneralizedTypesContext *ctx) override {
    GeneralizedTypesContextProxy proxy(ctx);
    return getSelf().call("visit_generalized_types", &proxy);
  }

  virtual antlrcpp::Any visitGeneralAggregationTypes(ExpressParser::GeneralAggregationTypesContext *ctx) override {
    GeneralAggregationTypesContextProxy proxy(ctx);
    return getSelf().call("visit_general_aggregation_types", &proxy);
  }

  virtual antlrcpp::Any visitGeneralArrayType(ExpressParser::GeneralArrayTypeContext *ctx) override {
    GeneralArrayTypeContextProxy proxy(ctx);
    return getSelf().call("visit_general_array_type", &proxy);
  }

  virtual antlrcpp::Any visitGeneralBagType(ExpressParser::GeneralBagTypeContext *ctx) override {
    GeneralBagTypeContextProxy proxy(ctx);
    return getSelf().call("visit_general_bag_type", &proxy);
  }

  virtual antlrcpp::Any visitGeneralListType(ExpressParser::GeneralListTypeContext *ctx) override {
    GeneralListTypeContextProxy proxy(ctx);
    return getSelf().call("visit_general_list_type", &proxy);
  }

  virtual antlrcpp::Any visitGeneralRef(ExpressParser::GeneralRefContext *ctx) override {
    GeneralRefContextProxy proxy(ctx);
    return getSelf().call("visit_general_ref", &proxy);
  }

  virtual antlrcpp::Any visitGeneralSetType(ExpressParser::GeneralSetTypeContext *ctx) override {
    GeneralSetTypeContextProxy proxy(ctx);
    return getSelf().call("visit_general_set_type", &proxy);
  }

  virtual antlrcpp::Any visitGenericEntityType(ExpressParser::GenericEntityTypeContext *ctx) override {
    GenericEntityTypeContextProxy proxy(ctx);
    return getSelf().call("visit_generic_entity_type", &proxy);
  }

  virtual antlrcpp::Any visitGenericType(ExpressParser::GenericTypeContext *ctx) override {
    GenericTypeContextProxy proxy(ctx);
    return getSelf().call("visit_generic_type", &proxy);
  }

  virtual antlrcpp::Any visitGroupQualifier(ExpressParser::GroupQualifierContext *ctx) override {
    GroupQualifierContextProxy proxy(ctx);
    return getSelf().call("visit_group_qualifier", &proxy);
  }

  virtual antlrcpp::Any visitIfStmt(ExpressParser::IfStmtContext *ctx) override {
    IfStmtContextProxy proxy(ctx);
    return getSelf().call("visit_if_stmt", &proxy);
  }

  virtual antlrcpp::Any visitIfStmtStatements(ExpressParser::IfStmtStatementsContext *ctx) override {
    IfStmtStatementsContextProxy proxy(ctx);
    return getSelf().call("visit_if_stmt_statements", &proxy);
  }

  virtual antlrcpp::Any visitIfStmtElseStatements(ExpressParser::IfStmtElseStatementsContext *ctx) override {
    IfStmtElseStatementsContextProxy proxy(ctx);
    return getSelf().call("visit_if_stmt_else_statements", &proxy);
  }

  virtual antlrcpp::Any visitIncrement(ExpressParser::IncrementContext *ctx) override {
    IncrementContextProxy proxy(ctx);
    return getSelf().call("visit_increment", &proxy);
  }

  virtual antlrcpp::Any visitIncrementControl(ExpressParser::IncrementControlContext *ctx) override {
    IncrementControlContextProxy proxy(ctx);
    return getSelf().call("visit_increment_control", &proxy);
  }

  virtual antlrcpp::Any visitIndex(ExpressParser::IndexContext *ctx) override {
    IndexContextProxy proxy(ctx);
    return getSelf().call("visit_index", &proxy);
  }

  virtual antlrcpp::Any visitIndex1(ExpressParser::Index1Context *ctx) override {
    Index1ContextProxy proxy(ctx);
    return getSelf().call("visit_index1", &proxy);
  }

  virtual antlrcpp::Any visitIndex2(ExpressParser::Index2Context *ctx) override {
    Index2ContextProxy proxy(ctx);
    return getSelf().call("visit_index2", &proxy);
  }

  virtual antlrcpp::Any visitIndexQualifier(ExpressParser::IndexQualifierContext *ctx) override {
    IndexQualifierContextProxy proxy(ctx);
    return getSelf().call("visit_index_qualifier", &proxy);
  }

  virtual antlrcpp::Any visitInstantiableType(ExpressParser::InstantiableTypeContext *ctx) override {
    InstantiableTypeContextProxy proxy(ctx);
    return getSelf().call("visit_instantiable_type", &proxy);
  }

  virtual antlrcpp::Any visitIntegerType(ExpressParser::IntegerTypeContext *ctx) override {
    IntegerTypeContextProxy proxy(ctx);
    return getSelf().call("visit_integer_type", &proxy);
  }

  virtual antlrcpp::Any visitInterfaceSpecification(ExpressParser::InterfaceSpecificationContext *ctx) override {
    InterfaceSpecificationContextProxy proxy(ctx);
    return getSelf().call("visit_interface_specification", &proxy);
  }

  virtual antlrcpp::Any visitInterval(ExpressParser::IntervalContext *ctx) override {
    IntervalContextProxy proxy(ctx);
    return getSelf().call("visit_interval", &proxy);
  }

  virtual antlrcpp::Any visitIntervalHigh(ExpressParser::IntervalHighContext *ctx) override {
    IntervalHighContextProxy proxy(ctx);
    return getSelf().call("visit_interval_high", &proxy);
  }

  virtual antlrcpp::Any visitIntervalItem(ExpressParser::IntervalItemContext *ctx) override {
    IntervalItemContextProxy proxy(ctx);
    return getSelf().call("visit_interval_item", &proxy);
  }

  virtual antlrcpp::Any visitIntervalLow(ExpressParser::IntervalLowContext *ctx) override {
    IntervalLowContextProxy proxy(ctx);
    return getSelf().call("visit_interval_low", &proxy);
  }

  virtual antlrcpp::Any visitIntervalOp(ExpressParser::IntervalOpContext *ctx) override {
    IntervalOpContextProxy proxy(ctx);
    return getSelf().call("visit_interval_op", &proxy);
  }

  virtual antlrcpp::Any visitInverseAttr(ExpressParser::InverseAttrContext *ctx) override {
    InverseAttrContextProxy proxy(ctx);
    return getSelf().call("visit_inverse_attr", &proxy);
  }

  virtual antlrcpp::Any visitInverseAttrType(ExpressParser::InverseAttrTypeContext *ctx) override {
    InverseAttrTypeContextProxy proxy(ctx);
    return getSelf().call("visit_inverse_attr_type", &proxy);
  }

  virtual antlrcpp::Any visitInverseClause(ExpressParser::InverseClauseContext *ctx) override {
    InverseClauseContextProxy proxy(ctx);
    return getSelf().call("visit_inverse_clause", &proxy);
  }

  virtual antlrcpp::Any visitListType(ExpressParser::ListTypeContext *ctx) override {
    ListTypeContextProxy proxy(ctx);
    return getSelf().call("visit_list_type", &proxy);
  }

  virtual antlrcpp::Any visitLiteral(ExpressParser::LiteralContext *ctx) override {
    LiteralContextProxy proxy(ctx);
    return getSelf().call("visit_literal", &proxy);
  }

  virtual antlrcpp::Any visitLocalDecl(ExpressParser::LocalDeclContext *ctx) override {
    LocalDeclContextProxy proxy(ctx);
    return getSelf().call("visit_local_decl", &proxy);
  }

  virtual antlrcpp::Any visitLocalVariable(ExpressParser::LocalVariableContext *ctx) override {
    LocalVariableContextProxy proxy(ctx);
    return getSelf().call("visit_local_variable", &proxy);
  }

  virtual antlrcpp::Any visitLogicalExpression(ExpressParser::LogicalExpressionContext *ctx) override {
    LogicalExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_logical_expression", &proxy);
  }

  virtual antlrcpp::Any visitLogicalLiteral(ExpressParser::LogicalLiteralContext *ctx) override {
    LogicalLiteralContextProxy proxy(ctx);
    return getSelf().call("visit_logical_literal", &proxy);
  }

  virtual antlrcpp::Any visitLogicalType(ExpressParser::LogicalTypeContext *ctx) override {
    LogicalTypeContextProxy proxy(ctx);
    return getSelf().call("visit_logical_type", &proxy);
  }

  virtual antlrcpp::Any visitMultiplicationLikeOp(ExpressParser::MultiplicationLikeOpContext *ctx) override {
    MultiplicationLikeOpContextProxy proxy(ctx);
    return getSelf().call("visit_multiplication_like_op", &proxy);
  }

  virtual antlrcpp::Any visitNamedTypes(ExpressParser::NamedTypesContext *ctx) override {
    NamedTypesContextProxy proxy(ctx);
    return getSelf().call("visit_named_types", &proxy);
  }

  virtual antlrcpp::Any visitNamedTypeOrRename(ExpressParser::NamedTypeOrRenameContext *ctx) override {
    NamedTypeOrRenameContextProxy proxy(ctx);
    return getSelf().call("visit_named_type_or_rename", &proxy);
  }

  virtual antlrcpp::Any visitNullStmt(ExpressParser::NullStmtContext *ctx) override {
    NullStmtContextProxy proxy(ctx);
    return getSelf().call("visit_null_stmt", &proxy);
  }

  virtual antlrcpp::Any visitNumberType(ExpressParser::NumberTypeContext *ctx) override {
    NumberTypeContextProxy proxy(ctx);
    return getSelf().call("visit_number_type", &proxy);
  }

  virtual antlrcpp::Any visitNumericExpression(ExpressParser::NumericExpressionContext *ctx) override {
    NumericExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_numeric_expression", &proxy);
  }

  virtual antlrcpp::Any visitOneOf(ExpressParser::OneOfContext *ctx) override {
    OneOfContextProxy proxy(ctx);
    return getSelf().call("visit_one_of", &proxy);
  }

  virtual antlrcpp::Any visitParameter(ExpressParser::ParameterContext *ctx) override {
    ParameterContextProxy proxy(ctx);
    return getSelf().call("visit_parameter", &proxy);
  }

  virtual antlrcpp::Any visitParameterId(ExpressParser::ParameterIdContext *ctx) override {
    ParameterIdContextProxy proxy(ctx);
    return getSelf().call("visit_parameter_id", &proxy);
  }

  virtual antlrcpp::Any visitParameterType(ExpressParser::ParameterTypeContext *ctx) override {
    ParameterTypeContextProxy proxy(ctx);
    return getSelf().call("visit_parameter_type", &proxy);
  }

  virtual antlrcpp::Any visitPopulation(ExpressParser::PopulationContext *ctx) override {
    PopulationContextProxy proxy(ctx);
    return getSelf().call("visit_population", &proxy);
  }

  virtual antlrcpp::Any visitPrecisionSpec(ExpressParser::PrecisionSpecContext *ctx) override {
    PrecisionSpecContextProxy proxy(ctx);
    return getSelf().call("visit_precision_spec", &proxy);
  }

  virtual antlrcpp::Any visitPrimary(ExpressParser::PrimaryContext *ctx) override {
    PrimaryContextProxy proxy(ctx);
    return getSelf().call("visit_primary", &proxy);
  }

  virtual antlrcpp::Any visitProcedureCallStmt(ExpressParser::ProcedureCallStmtContext *ctx) override {
    ProcedureCallStmtContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_call_stmt", &proxy);
  }

  virtual antlrcpp::Any visitProcedureDecl(ExpressParser::ProcedureDeclContext *ctx) override {
    ProcedureDeclContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_decl", &proxy);
  }

  virtual antlrcpp::Any visitProcedureHead(ExpressParser::ProcedureHeadContext *ctx) override {
    ProcedureHeadContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_head", &proxy);
  }

  virtual antlrcpp::Any visitProcedureHeadParameter(ExpressParser::ProcedureHeadParameterContext *ctx) override {
    ProcedureHeadParameterContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_head_parameter", &proxy);
  }

  virtual antlrcpp::Any visitProcedureId(ExpressParser::ProcedureIdContext *ctx) override {
    ProcedureIdContextProxy proxy(ctx);
    return getSelf().call("visit_procedure_id", &proxy);
  }

  virtual antlrcpp::Any visitQualifiableFactor(ExpressParser::QualifiableFactorContext *ctx) override {
    QualifiableFactorContextProxy proxy(ctx);
    return getSelf().call("visit_qualifiable_factor", &proxy);
  }

  virtual antlrcpp::Any visitQualifiedAttribute(ExpressParser::QualifiedAttributeContext *ctx) override {
    QualifiedAttributeContextProxy proxy(ctx);
    return getSelf().call("visit_qualified_attribute", &proxy);
  }

  virtual antlrcpp::Any visitQualifier(ExpressParser::QualifierContext *ctx) override {
    QualifierContextProxy proxy(ctx);
    return getSelf().call("visit_qualifier", &proxy);
  }

  virtual antlrcpp::Any visitQueryExpression(ExpressParser::QueryExpressionContext *ctx) override {
    QueryExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_query_expression", &proxy);
  }

  virtual antlrcpp::Any visitRealType(ExpressParser::RealTypeContext *ctx) override {
    RealTypeContextProxy proxy(ctx);
    return getSelf().call("visit_real_type", &proxy);
  }

  virtual antlrcpp::Any visitRedeclaredAttribute(ExpressParser::RedeclaredAttributeContext *ctx) override {
    RedeclaredAttributeContextProxy proxy(ctx);
    return getSelf().call("visit_redeclared_attribute", &proxy);
  }

  virtual antlrcpp::Any visitReferencedAttribute(ExpressParser::ReferencedAttributeContext *ctx) override {
    ReferencedAttributeContextProxy proxy(ctx);
    return getSelf().call("visit_referenced_attribute", &proxy);
  }

  virtual antlrcpp::Any visitReferenceClause(ExpressParser::ReferenceClauseContext *ctx) override {
    ReferenceClauseContextProxy proxy(ctx);
    return getSelf().call("visit_reference_clause", &proxy);
  }

  virtual antlrcpp::Any visitRelOp(ExpressParser::RelOpContext *ctx) override {
    RelOpContextProxy proxy(ctx);
    return getSelf().call("visit_rel_op", &proxy);
  }

  virtual antlrcpp::Any visitRelOpExtended(ExpressParser::RelOpExtendedContext *ctx) override {
    RelOpExtendedContextProxy proxy(ctx);
    return getSelf().call("visit_rel_op_extended", &proxy);
  }

  virtual antlrcpp::Any visitRenameId(ExpressParser::RenameIdContext *ctx) override {
    RenameIdContextProxy proxy(ctx);
    return getSelf().call("visit_rename_id", &proxy);
  }

  virtual antlrcpp::Any visitRepeatControl(ExpressParser::RepeatControlContext *ctx) override {
    RepeatControlContextProxy proxy(ctx);
    return getSelf().call("visit_repeat_control", &proxy);
  }

  virtual antlrcpp::Any visitRepeatStmt(ExpressParser::RepeatStmtContext *ctx) override {
    RepeatStmtContextProxy proxy(ctx);
    return getSelf().call("visit_repeat_stmt", &proxy);
  }

  virtual antlrcpp::Any visitRepetition(ExpressParser::RepetitionContext *ctx) override {
    RepetitionContextProxy proxy(ctx);
    return getSelf().call("visit_repetition", &proxy);
  }

  virtual antlrcpp::Any visitResourceOrRename(ExpressParser::ResourceOrRenameContext *ctx) override {
    ResourceOrRenameContextProxy proxy(ctx);
    return getSelf().call("visit_resource_or_rename", &proxy);
  }

  virtual antlrcpp::Any visitResourceRef(ExpressParser::ResourceRefContext *ctx) override {
    ResourceRefContextProxy proxy(ctx);
    return getSelf().call("visit_resource_ref", &proxy);
  }

  virtual antlrcpp::Any visitReturnStmt(ExpressParser::ReturnStmtContext *ctx) override {
    ReturnStmtContextProxy proxy(ctx);
    return getSelf().call("visit_return_stmt", &proxy);
  }

  virtual antlrcpp::Any visitRuleDecl(ExpressParser::RuleDeclContext *ctx) override {
    RuleDeclContextProxy proxy(ctx);
    return getSelf().call("visit_rule_decl", &proxy);
  }

  virtual antlrcpp::Any visitRuleHead(ExpressParser::RuleHeadContext *ctx) override {
    RuleHeadContextProxy proxy(ctx);
    return getSelf().call("visit_rule_head", &proxy);
  }

  virtual antlrcpp::Any visitRuleId(ExpressParser::RuleIdContext *ctx) override {
    RuleIdContextProxy proxy(ctx);
    return getSelf().call("visit_rule_id", &proxy);
  }

  virtual antlrcpp::Any visitRuleLabelId(ExpressParser::RuleLabelIdContext *ctx) override {
    RuleLabelIdContextProxy proxy(ctx);
    return getSelf().call("visit_rule_label_id", &proxy);
  }

  virtual antlrcpp::Any visitSchemaBody(ExpressParser::SchemaBodyContext *ctx) override {
    SchemaBodyContextProxy proxy(ctx);
    return getSelf().call("visit_schema_body", &proxy);
  }

  virtual antlrcpp::Any visitSchemaBodyDeclaration(ExpressParser::SchemaBodyDeclarationContext *ctx) override {
    SchemaBodyDeclarationContextProxy proxy(ctx);
    return getSelf().call("visit_schema_body_declaration", &proxy);
  }

  virtual antlrcpp::Any visitSchemaDecl(ExpressParser::SchemaDeclContext *ctx) override {
    SchemaDeclContextProxy proxy(ctx);
    return getSelf().call("visit_schema_decl", &proxy);
  }

  virtual antlrcpp::Any visitSchemaId(ExpressParser::SchemaIdContext *ctx) override {
    SchemaIdContextProxy proxy(ctx);
    return getSelf().call("visit_schema_id", &proxy);
  }

  virtual antlrcpp::Any visitSchemaVersionId(ExpressParser::SchemaVersionIdContext *ctx) override {
    SchemaVersionIdContextProxy proxy(ctx);
    return getSelf().call("visit_schema_version_id", &proxy);
  }

  virtual antlrcpp::Any visitSelector(ExpressParser::SelectorContext *ctx) override {
    SelectorContextProxy proxy(ctx);
    return getSelf().call("visit_selector", &proxy);
  }

  virtual antlrcpp::Any visitSelectExtension(ExpressParser::SelectExtensionContext *ctx) override {
    SelectExtensionContextProxy proxy(ctx);
    return getSelf().call("visit_select_extension", &proxy);
  }

  virtual antlrcpp::Any visitSelectList(ExpressParser::SelectListContext *ctx) override {
    SelectListContextProxy proxy(ctx);
    return getSelf().call("visit_select_list", &proxy);
  }

  virtual antlrcpp::Any visitSelectType(ExpressParser::SelectTypeContext *ctx) override {
    SelectTypeContextProxy proxy(ctx);
    return getSelf().call("visit_select_type", &proxy);
  }

  virtual antlrcpp::Any visitSetType(ExpressParser::SetTypeContext *ctx) override {
    SetTypeContextProxy proxy(ctx);
    return getSelf().call("visit_set_type", &proxy);
  }

  virtual antlrcpp::Any visitSimpleExpression(ExpressParser::SimpleExpressionContext *ctx) override {
    SimpleExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_simple_expression", &proxy);
  }

  virtual antlrcpp::Any visitSimpleFactor(ExpressParser::SimpleFactorContext *ctx) override {
    SimpleFactorContextProxy proxy(ctx);
    return getSelf().call("visit_simple_factor", &proxy);
  }

  virtual antlrcpp::Any visitSimpleFactorExpression(ExpressParser::SimpleFactorExpressionContext *ctx) override {
    SimpleFactorExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_simple_factor_expression", &proxy);
  }

  virtual antlrcpp::Any visitSimpleFactorUnaryExpression(ExpressParser::SimpleFactorUnaryExpressionContext *ctx) override {
    SimpleFactorUnaryExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_simple_factor_unary_expression", &proxy);
  }

  virtual antlrcpp::Any visitSimpleTypes(ExpressParser::SimpleTypesContext *ctx) override {
    SimpleTypesContextProxy proxy(ctx);
    return getSelf().call("visit_simple_types", &proxy);
  }

  virtual antlrcpp::Any visitSkipStmt(ExpressParser::SkipStmtContext *ctx) override {
    SkipStmtContextProxy proxy(ctx);
    return getSelf().call("visit_skip_stmt", &proxy);
  }

  virtual antlrcpp::Any visitStmt(ExpressParser::StmtContext *ctx) override {
    StmtContextProxy proxy(ctx);
    return getSelf().call("visit_stmt", &proxy);
  }

  virtual antlrcpp::Any visitStringLiteral(ExpressParser::StringLiteralContext *ctx) override {
    StringLiteralContextProxy proxy(ctx);
    return getSelf().call("visit_string_literal", &proxy);
  }

  virtual antlrcpp::Any visitStringType(ExpressParser::StringTypeContext *ctx) override {
    StringTypeContextProxy proxy(ctx);
    return getSelf().call("visit_string_type", &proxy);
  }

  virtual antlrcpp::Any visitSubsuper(ExpressParser::SubsuperContext *ctx) override {
    SubsuperContextProxy proxy(ctx);
    return getSelf().call("visit_subsuper", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraint(ExpressParser::SubtypeConstraintContext *ctx) override {
    SubtypeConstraintContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraintBody(ExpressParser::SubtypeConstraintBodyContext *ctx) override {
    SubtypeConstraintBodyContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint_body", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraintDecl(ExpressParser::SubtypeConstraintDeclContext *ctx) override {
    SubtypeConstraintDeclContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint_decl", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraintHead(ExpressParser::SubtypeConstraintHeadContext *ctx) override {
    SubtypeConstraintHeadContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint_head", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeConstraintId(ExpressParser::SubtypeConstraintIdContext *ctx) override {
    SubtypeConstraintIdContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_constraint_id", &proxy);
  }

  virtual antlrcpp::Any visitSubtypeDeclaration(ExpressParser::SubtypeDeclarationContext *ctx) override {
    SubtypeDeclarationContextProxy proxy(ctx);
    return getSelf().call("visit_subtype_declaration", &proxy);
  }

  virtual antlrcpp::Any visitSupertypeConstraint(ExpressParser::SupertypeConstraintContext *ctx) override {
    SupertypeConstraintContextProxy proxy(ctx);
    return getSelf().call("visit_supertype_constraint", &proxy);
  }

  virtual antlrcpp::Any visitSupertypeExpression(ExpressParser::SupertypeExpressionContext *ctx) override {
    SupertypeExpressionContextProxy proxy(ctx);
    return getSelf().call("visit_supertype_expression", &proxy);
  }

  virtual antlrcpp::Any visitSupertypeFactor(ExpressParser::SupertypeFactorContext *ctx) override {
    SupertypeFactorContextProxy proxy(ctx);
    return getSelf().call("visit_supertype_factor", &proxy);
  }

  virtual antlrcpp::Any visitSupertypeRule(ExpressParser::SupertypeRuleContext *ctx) override {
    SupertypeRuleContextProxy proxy(ctx);
    return getSelf().call("visit_supertype_rule", &proxy);
  }

  virtual antlrcpp::Any visitSupertypeTerm(ExpressParser::SupertypeTermContext *ctx) override {
    SupertypeTermContextProxy proxy(ctx);
    return getSelf().call("visit_supertype_term", &proxy);
  }

  virtual antlrcpp::Any visitSyntax(ExpressParser::SyntaxContext *ctx) override {
    SyntaxContextProxy proxy(ctx);
    return getSelf().call("visit_syntax", &proxy);
  }

  virtual antlrcpp::Any visitTerm(ExpressParser::TermContext *ctx) override {
    TermContextProxy proxy(ctx);
    return getSelf().call("visit_term", &proxy);
  }

  virtual antlrcpp::Any visitTotalOver(ExpressParser::TotalOverContext *ctx) override {
    TotalOverContextProxy proxy(ctx);
    return getSelf().call("visit_total_over", &proxy);
  }

  virtual antlrcpp::Any visitTypeDecl(ExpressParser::TypeDeclContext *ctx) override {
    TypeDeclContextProxy proxy(ctx);
    return getSelf().call("visit_type_decl", &proxy);
  }

  virtual antlrcpp::Any visitTypeId(ExpressParser::TypeIdContext *ctx) override {
    TypeIdContextProxy proxy(ctx);
    return getSelf().call("visit_type_id", &proxy);
  }

  virtual antlrcpp::Any visitTypeLabel(ExpressParser::TypeLabelContext *ctx) override {
    TypeLabelContextProxy proxy(ctx);
    return getSelf().call("visit_type_label", &proxy);
  }

  virtual antlrcpp::Any visitTypeLabelId(ExpressParser::TypeLabelIdContext *ctx) override {
    TypeLabelIdContextProxy proxy(ctx);
    return getSelf().call("visit_type_label_id", &proxy);
  }

  virtual antlrcpp::Any visitUnaryOp(ExpressParser::UnaryOpContext *ctx) override {
    UnaryOpContextProxy proxy(ctx);
    return getSelf().call("visit_unary_op", &proxy);
  }

  virtual antlrcpp::Any visitUnderlyingType(ExpressParser::UnderlyingTypeContext *ctx) override {
    UnderlyingTypeContextProxy proxy(ctx);
    return getSelf().call("visit_underlying_type", &proxy);
  }

  virtual antlrcpp::Any visitUniqueClause(ExpressParser::UniqueClauseContext *ctx) override {
    UniqueClauseContextProxy proxy(ctx);
    return getSelf().call("visit_unique_clause", &proxy);
  }

  virtual antlrcpp::Any visitUniqueRule(ExpressParser::UniqueRuleContext *ctx) override {
    UniqueRuleContextProxy proxy(ctx);
    return getSelf().call("visit_unique_rule", &proxy);
  }

  virtual antlrcpp::Any visitUntilControl(ExpressParser::UntilControlContext *ctx) override {
    UntilControlContextProxy proxy(ctx);
    return getSelf().call("visit_until_control", &proxy);
  }

  virtual antlrcpp::Any visitUseClause(ExpressParser::UseClauseContext *ctx) override {
    UseClauseContextProxy proxy(ctx);
    return getSelf().call("visit_use_clause", &proxy);
  }

  virtual antlrcpp::Any visitVariableId(ExpressParser::VariableIdContext *ctx) override {
    VariableIdContextProxy proxy(ctx);
    return getSelf().call("visit_variable_id", &proxy);
  }

  virtual antlrcpp::Any visitWhereClause(ExpressParser::WhereClauseContext *ctx) override {
    WhereClauseContextProxy proxy(ctx);
    return getSelf().call("visit_where_clause", &proxy);
  }

  virtual antlrcpp::Any visitWhileControl(ExpressParser::WhileControlContext *ctx) override {
    WhileControlContextProxy proxy(ctx);
    return getSelf().call("visit_while_control", &proxy);
  }

  virtual antlrcpp::Any visitWidth(ExpressParser::WidthContext *ctx) override {
    WidthContextProxy proxy(ctx);
    return getSelf().call("visit_width", &proxy);
  }

  virtual antlrcpp::Any visitWidthSpec(ExpressParser::WidthSpecContext *ctx) override {
    WidthSpecContextProxy proxy(ctx);
    return getSelf().call("visit_width_spec", &proxy);
  }

};


class ParserProxy {
public:
  static ParserProxy* parse(string code) {
    auto input = new ANTLRInputStream(code);
    return parseStream(input);
  }

  static ParserProxy* parseFile(string file) {
    ifstream stream;
    stream.open(file);

    auto input = new ANTLRInputStream(stream);
    auto parser = parseStream(input);

    stream.close();

    return parser;
  }

  Object visit(VisitorProxy* visitor) {
    auto result = visitor -> visit(this -> parser -> syntax());

    // reset for the next visit call
    this -> lexer -> reset();
    this -> parser -> reset();

    return result.as<Object>();
  }

  ~ParserProxy() {
    delete this -> parser;
    delete this -> tokens;
    delete this -> lexer;
    delete this -> input;
  }

private:
  static ParserProxy* parseStream(ANTLRInputStream* input) {
    ParserProxy* parser = new ParserProxy();

    parser -> input = input;
    parser -> lexer = new ExpressLexer(parser -> input);
    parser -> tokens = new CommonTokenStream(parser -> lexer);
    parser -> parser = new ExpressParser(parser -> tokens);

    return parser;
  }

  ParserProxy() {};

  ANTLRInputStream* input;
  ExpressLexer* lexer;
  CommonTokenStream* tokens;
  ExpressParser* parser;
};

template <>
Object to_ruby<ParserProxy*>(ParserProxy* const &x) {
  if (!x) return Nil;
  return Data_Object<ParserProxy>(x, rb_cParser, nullptr, nullptr);
}


Object ContextProxy::wrapParseTree(tree::ParseTree* node) {
  if (antlrcpp::is<ExpressParser::AttributeRefContext*>(node)) {
    AttributeRefContextProxy proxy((ExpressParser::AttributeRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AttributeIdContext*>(node)) {
    AttributeIdContextProxy proxy((ExpressParser::AttributeIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstantRefContext*>(node)) {
    ConstantRefContextProxy proxy((ExpressParser::ConstantRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstantIdContext*>(node)) {
    ConstantIdContextProxy proxy((ExpressParser::ConstantIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityRefContext*>(node)) {
    EntityRefContextProxy proxy((ExpressParser::EntityRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityIdContext*>(node)) {
    EntityIdContextProxy proxy((ExpressParser::EntityIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationRefContext*>(node)) {
    EnumerationRefContextProxy proxy((ExpressParser::EnumerationRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationIdContext*>(node)) {
    EnumerationIdContextProxy proxy((ExpressParser::EnumerationIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FunctionRefContext*>(node)) {
    FunctionRefContextProxy proxy((ExpressParser::FunctionRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FunctionIdContext*>(node)) {
    FunctionIdContextProxy proxy((ExpressParser::FunctionIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ParameterRefContext*>(node)) {
    ParameterRefContextProxy proxy((ExpressParser::ParameterRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ParameterIdContext*>(node)) {
    ParameterIdContextProxy proxy((ExpressParser::ParameterIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureRefContext*>(node)) {
    ProcedureRefContextProxy proxy((ExpressParser::ProcedureRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureIdContext*>(node)) {
    ProcedureIdContextProxy proxy((ExpressParser::ProcedureIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleLabelRefContext*>(node)) {
    RuleLabelRefContextProxy proxy((ExpressParser::RuleLabelRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleLabelIdContext*>(node)) {
    RuleLabelIdContextProxy proxy((ExpressParser::RuleLabelIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleRefContext*>(node)) {
    RuleRefContextProxy proxy((ExpressParser::RuleRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleIdContext*>(node)) {
    RuleIdContextProxy proxy((ExpressParser::RuleIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaRefContext*>(node)) {
    SchemaRefContextProxy proxy((ExpressParser::SchemaRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaIdContext*>(node)) {
    SchemaIdContextProxy proxy((ExpressParser::SchemaIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintRefContext*>(node)) {
    SubtypeConstraintRefContextProxy proxy((ExpressParser::SubtypeConstraintRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintIdContext*>(node)) {
    SubtypeConstraintIdContextProxy proxy((ExpressParser::SubtypeConstraintIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeLabelRefContext*>(node)) {
    TypeLabelRefContextProxy proxy((ExpressParser::TypeLabelRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeLabelIdContext*>(node)) {
    TypeLabelIdContextProxy proxy((ExpressParser::TypeLabelIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeRefContext*>(node)) {
    TypeRefContextProxy proxy((ExpressParser::TypeRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeIdContext*>(node)) {
    TypeIdContextProxy proxy((ExpressParser::TypeIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::VariableRefContext*>(node)) {
    VariableRefContextProxy proxy((ExpressParser::VariableRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::VariableIdContext*>(node)) {
    VariableIdContextProxy proxy((ExpressParser::VariableIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AbstractEntityDeclarationContext*>(node)) {
    AbstractEntityDeclarationContextProxy proxy((ExpressParser::AbstractEntityDeclarationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AbstractSupertypeContext*>(node)) {
    AbstractSupertypeContextProxy proxy((ExpressParser::AbstractSupertypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AbstractSupertypeDeclarationContext*>(node)) {
    AbstractSupertypeDeclarationContextProxy proxy((ExpressParser::AbstractSupertypeDeclarationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintContext*>(node)) {
    SubtypeConstraintContextProxy proxy((ExpressParser::SubtypeConstraintContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ActualParameterListContext*>(node)) {
    ActualParameterListContextProxy proxy((ExpressParser::ActualParameterListContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ParameterContext*>(node)) {
    ParameterContextProxy proxy((ExpressParser::ParameterContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AddLikeOpContext*>(node)) {
    AddLikeOpContextProxy proxy((ExpressParser::AddLikeOpContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AggregateInitializerContext*>(node)) {
    AggregateInitializerContextProxy proxy((ExpressParser::AggregateInitializerContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ElementContext*>(node)) {
    ElementContextProxy proxy((ExpressParser::ElementContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AggregateSourceContext*>(node)) {
    AggregateSourceContextProxy proxy((ExpressParser::AggregateSourceContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SimpleExpressionContext*>(node)) {
    SimpleExpressionContextProxy proxy((ExpressParser::SimpleExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AggregateTypeContext*>(node)) {
    AggregateTypeContextProxy proxy((ExpressParser::AggregateTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ParameterTypeContext*>(node)) {
    ParameterTypeContextProxy proxy((ExpressParser::ParameterTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeLabelContext*>(node)) {
    TypeLabelContextProxy proxy((ExpressParser::TypeLabelContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AggregationTypesContext*>(node)) {
    AggregationTypesContextProxy proxy((ExpressParser::AggregationTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ArrayTypeContext*>(node)) {
    ArrayTypeContextProxy proxy((ExpressParser::ArrayTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BagTypeContext*>(node)) {
    BagTypeContextProxy proxy((ExpressParser::BagTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ListTypeContext*>(node)) {
    ListTypeContextProxy proxy((ExpressParser::ListTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SetTypeContext*>(node)) {
    SetTypeContextProxy proxy((ExpressParser::SetTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AlgorithmHeadContext*>(node)) {
    AlgorithmHeadContextProxy proxy((ExpressParser::AlgorithmHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::DeclarationContext*>(node)) {
    DeclarationContextProxy proxy((ExpressParser::DeclarationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstantDeclContext*>(node)) {
    ConstantDeclContextProxy proxy((ExpressParser::ConstantDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LocalDeclContext*>(node)) {
    LocalDeclContextProxy proxy((ExpressParser::LocalDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AliasStmtContext*>(node)) {
    AliasStmtContextProxy proxy((ExpressParser::AliasStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralRefContext*>(node)) {
    GeneralRefContextProxy proxy((ExpressParser::GeneralRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::StmtContext*>(node)) {
    StmtContextProxy proxy((ExpressParser::StmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::QualifierContext*>(node)) {
    QualifierContextProxy proxy((ExpressParser::QualifierContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BoundSpecContext*>(node)) {
    BoundSpecContextProxy proxy((ExpressParser::BoundSpecContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::InstantiableTypeContext*>(node)) {
    InstantiableTypeContextProxy proxy((ExpressParser::InstantiableTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AssignmentStmtContext*>(node)) {
    AssignmentStmtContextProxy proxy((ExpressParser::AssignmentStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ExpressionContext*>(node)) {
    ExpressionContextProxy proxy((ExpressParser::ExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AttributeDeclContext*>(node)) {
    AttributeDeclContextProxy proxy((ExpressParser::AttributeDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RedeclaredAttributeContext*>(node)) {
    RedeclaredAttributeContextProxy proxy((ExpressParser::RedeclaredAttributeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::AttributeQualifierContext*>(node)) {
    AttributeQualifierContextProxy proxy((ExpressParser::AttributeQualifierContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BinaryTypeContext*>(node)) {
    BinaryTypeContextProxy proxy((ExpressParser::BinaryTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::WidthSpecContext*>(node)) {
    WidthSpecContextProxy proxy((ExpressParser::WidthSpecContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BooleanTypeContext*>(node)) {
    BooleanTypeContextProxy proxy((ExpressParser::BooleanTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::Bound1Context*>(node)) {
    Bound1ContextProxy proxy((ExpressParser::Bound1Context*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::NumericExpressionContext*>(node)) {
    NumericExpressionContextProxy proxy((ExpressParser::NumericExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::Bound2Context*>(node)) {
    Bound2ContextProxy proxy((ExpressParser::Bound2Context*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BuiltInConstantContext*>(node)) {
    BuiltInConstantContextProxy proxy((ExpressParser::BuiltInConstantContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BuiltInFunctionContext*>(node)) {
    BuiltInFunctionContextProxy proxy((ExpressParser::BuiltInFunctionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::BuiltInProcedureContext*>(node)) {
    BuiltInProcedureContextProxy proxy((ExpressParser::BuiltInProcedureContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::CaseActionContext*>(node)) {
    CaseActionContextProxy proxy((ExpressParser::CaseActionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::CaseLabelContext*>(node)) {
    CaseLabelContextProxy proxy((ExpressParser::CaseLabelContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::CaseStmtContext*>(node)) {
    CaseStmtContextProxy proxy((ExpressParser::CaseStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SelectorContext*>(node)) {
    SelectorContextProxy proxy((ExpressParser::SelectorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::CompoundStmtContext*>(node)) {
    CompoundStmtContextProxy proxy((ExpressParser::CompoundStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConcreteTypesContext*>(node)) {
    ConcreteTypesContextProxy proxy((ExpressParser::ConcreteTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SimpleTypesContext*>(node)) {
    SimpleTypesContextProxy proxy((ExpressParser::SimpleTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstantBodyContext*>(node)) {
    ConstantBodyContextProxy proxy((ExpressParser::ConstantBodyContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstantFactorContext*>(node)) {
    ConstantFactorContextProxy proxy((ExpressParser::ConstantFactorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ConstructedTypesContext*>(node)) {
    ConstructedTypesContextProxy proxy((ExpressParser::ConstructedTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationTypeContext*>(node)) {
    EnumerationTypeContextProxy proxy((ExpressParser::EnumerationTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SelectTypeContext*>(node)) {
    SelectTypeContextProxy proxy((ExpressParser::SelectTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityDeclContext*>(node)) {
    EntityDeclContextProxy proxy((ExpressParser::EntityDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FunctionDeclContext*>(node)) {
    FunctionDeclContextProxy proxy((ExpressParser::FunctionDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureDeclContext*>(node)) {
    ProcedureDeclContextProxy proxy((ExpressParser::ProcedureDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintDeclContext*>(node)) {
    SubtypeConstraintDeclContextProxy proxy((ExpressParser::SubtypeConstraintDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TypeDeclContext*>(node)) {
    TypeDeclContextProxy proxy((ExpressParser::TypeDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::DerivedAttrContext*>(node)) {
    DerivedAttrContextProxy proxy((ExpressParser::DerivedAttrContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::DeriveClauseContext*>(node)) {
    DeriveClauseContextProxy proxy((ExpressParser::DeriveClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::DomainRuleContext*>(node)) {
    DomainRuleContextProxy proxy((ExpressParser::DomainRuleContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RepetitionContext*>(node)) {
    RepetitionContextProxy proxy((ExpressParser::RepetitionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityBodyContext*>(node)) {
    EntityBodyContextProxy proxy((ExpressParser::EntityBodyContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ExplicitAttrContext*>(node)) {
    ExplicitAttrContextProxy proxy((ExpressParser::ExplicitAttrContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::InverseClauseContext*>(node)) {
    InverseClauseContextProxy proxy((ExpressParser::InverseClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UniqueClauseContext*>(node)) {
    UniqueClauseContextProxy proxy((ExpressParser::UniqueClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::WhereClauseContext*>(node)) {
    WhereClauseContextProxy proxy((ExpressParser::WhereClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityConstructorContext*>(node)) {
    EntityConstructorContextProxy proxy((ExpressParser::EntityConstructorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EntityHeadContext*>(node)) {
    EntityHeadContextProxy proxy((ExpressParser::EntityHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubsuperContext*>(node)) {
    SubsuperContextProxy proxy((ExpressParser::SubsuperContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationExtensionContext*>(node)) {
    EnumerationExtensionContextProxy proxy((ExpressParser::EnumerationExtensionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationItemsContext*>(node)) {
    EnumerationItemsContextProxy proxy((ExpressParser::EnumerationItemsContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationItemContext*>(node)) {
    EnumerationItemContextProxy proxy((ExpressParser::EnumerationItemContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EnumerationReferenceContext*>(node)) {
    EnumerationReferenceContextProxy proxy((ExpressParser::EnumerationReferenceContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::EscapeStmtContext*>(node)) {
    EscapeStmtContextProxy proxy((ExpressParser::EscapeStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RelOpExtendedContext*>(node)) {
    RelOpExtendedContextProxy proxy((ExpressParser::RelOpExtendedContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FactorContext*>(node)) {
    FactorContextProxy proxy((ExpressParser::FactorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SimpleFactorContext*>(node)) {
    SimpleFactorContextProxy proxy((ExpressParser::SimpleFactorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FormalParameterContext*>(node)) {
    FormalParameterContextProxy proxy((ExpressParser::FormalParameterContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FunctionCallContext*>(node)) {
    FunctionCallContextProxy proxy((ExpressParser::FunctionCallContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::FunctionHeadContext*>(node)) {
    FunctionHeadContextProxy proxy((ExpressParser::FunctionHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralizedTypesContext*>(node)) {
    GeneralizedTypesContextProxy proxy((ExpressParser::GeneralizedTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralAggregationTypesContext*>(node)) {
    GeneralAggregationTypesContextProxy proxy((ExpressParser::GeneralAggregationTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GenericEntityTypeContext*>(node)) {
    GenericEntityTypeContextProxy proxy((ExpressParser::GenericEntityTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GenericTypeContext*>(node)) {
    GenericTypeContextProxy proxy((ExpressParser::GenericTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralArrayTypeContext*>(node)) {
    GeneralArrayTypeContextProxy proxy((ExpressParser::GeneralArrayTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralBagTypeContext*>(node)) {
    GeneralBagTypeContextProxy proxy((ExpressParser::GeneralBagTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralListTypeContext*>(node)) {
    GeneralListTypeContextProxy proxy((ExpressParser::GeneralListTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GeneralSetTypeContext*>(node)) {
    GeneralSetTypeContextProxy proxy((ExpressParser::GeneralSetTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::GroupQualifierContext*>(node)) {
    GroupQualifierContextProxy proxy((ExpressParser::GroupQualifierContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IfStmtContext*>(node)) {
    IfStmtContextProxy proxy((ExpressParser::IfStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LogicalExpressionContext*>(node)) {
    LogicalExpressionContextProxy proxy((ExpressParser::LogicalExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IfStmtStatementsContext*>(node)) {
    IfStmtStatementsContextProxy proxy((ExpressParser::IfStmtStatementsContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IfStmtElseStatementsContext*>(node)) {
    IfStmtElseStatementsContextProxy proxy((ExpressParser::IfStmtElseStatementsContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IncrementContext*>(node)) {
    IncrementContextProxy proxy((ExpressParser::IncrementContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IncrementControlContext*>(node)) {
    IncrementControlContextProxy proxy((ExpressParser::IncrementControlContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IndexContext*>(node)) {
    IndexContextProxy proxy((ExpressParser::IndexContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::Index1Context*>(node)) {
    Index1ContextProxy proxy((ExpressParser::Index1Context*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::Index2Context*>(node)) {
    Index2ContextProxy proxy((ExpressParser::Index2Context*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IndexQualifierContext*>(node)) {
    IndexQualifierContextProxy proxy((ExpressParser::IndexQualifierContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntegerTypeContext*>(node)) {
    IntegerTypeContextProxy proxy((ExpressParser::IntegerTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::InterfaceSpecificationContext*>(node)) {
    InterfaceSpecificationContextProxy proxy((ExpressParser::InterfaceSpecificationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ReferenceClauseContext*>(node)) {
    ReferenceClauseContextProxy proxy((ExpressParser::ReferenceClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UseClauseContext*>(node)) {
    UseClauseContextProxy proxy((ExpressParser::UseClauseContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntervalContext*>(node)) {
    IntervalContextProxy proxy((ExpressParser::IntervalContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntervalLowContext*>(node)) {
    IntervalLowContextProxy proxy((ExpressParser::IntervalLowContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntervalOpContext*>(node)) {
    IntervalOpContextProxy proxy((ExpressParser::IntervalOpContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntervalItemContext*>(node)) {
    IntervalItemContextProxy proxy((ExpressParser::IntervalItemContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::IntervalHighContext*>(node)) {
    IntervalHighContextProxy proxy((ExpressParser::IntervalHighContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::InverseAttrContext*>(node)) {
    InverseAttrContextProxy proxy((ExpressParser::InverseAttrContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::InverseAttrTypeContext*>(node)) {
    InverseAttrTypeContextProxy proxy((ExpressParser::InverseAttrTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LiteralContext*>(node)) {
    LiteralContextProxy proxy((ExpressParser::LiteralContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LogicalLiteralContext*>(node)) {
    LogicalLiteralContextProxy proxy((ExpressParser::LogicalLiteralContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::StringLiteralContext*>(node)) {
    StringLiteralContextProxy proxy((ExpressParser::StringLiteralContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LocalVariableContext*>(node)) {
    LocalVariableContextProxy proxy((ExpressParser::LocalVariableContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::LogicalTypeContext*>(node)) {
    LogicalTypeContextProxy proxy((ExpressParser::LogicalTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::MultiplicationLikeOpContext*>(node)) {
    MultiplicationLikeOpContextProxy proxy((ExpressParser::MultiplicationLikeOpContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::NamedTypesContext*>(node)) {
    NamedTypesContextProxy proxy((ExpressParser::NamedTypesContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::NamedTypeOrRenameContext*>(node)) {
    NamedTypeOrRenameContextProxy proxy((ExpressParser::NamedTypeOrRenameContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::NullStmtContext*>(node)) {
    NullStmtContextProxy proxy((ExpressParser::NullStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::NumberTypeContext*>(node)) {
    NumberTypeContextProxy proxy((ExpressParser::NumberTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::OneOfContext*>(node)) {
    OneOfContextProxy proxy((ExpressParser::OneOfContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SupertypeExpressionContext*>(node)) {
    SupertypeExpressionContextProxy proxy((ExpressParser::SupertypeExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::PopulationContext*>(node)) {
    PopulationContextProxy proxy((ExpressParser::PopulationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::PrecisionSpecContext*>(node)) {
    PrecisionSpecContextProxy proxy((ExpressParser::PrecisionSpecContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::PrimaryContext*>(node)) {
    PrimaryContextProxy proxy((ExpressParser::PrimaryContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::QualifiableFactorContext*>(node)) {
    QualifiableFactorContextProxy proxy((ExpressParser::QualifiableFactorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureCallStmtContext*>(node)) {
    ProcedureCallStmtContextProxy proxy((ExpressParser::ProcedureCallStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureHeadContext*>(node)) {
    ProcedureHeadContextProxy proxy((ExpressParser::ProcedureHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ProcedureHeadParameterContext*>(node)) {
    ProcedureHeadParameterContextProxy proxy((ExpressParser::ProcedureHeadParameterContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::QualifiedAttributeContext*>(node)) {
    QualifiedAttributeContextProxy proxy((ExpressParser::QualifiedAttributeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::QueryExpressionContext*>(node)) {
    QueryExpressionContextProxy proxy((ExpressParser::QueryExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RealTypeContext*>(node)) {
    RealTypeContextProxy proxy((ExpressParser::RealTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ReferencedAttributeContext*>(node)) {
    ReferencedAttributeContextProxy proxy((ExpressParser::ReferencedAttributeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ResourceOrRenameContext*>(node)) {
    ResourceOrRenameContextProxy proxy((ExpressParser::ResourceOrRenameContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RelOpContext*>(node)) {
    RelOpContextProxy proxy((ExpressParser::RelOpContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RenameIdContext*>(node)) {
    RenameIdContextProxy proxy((ExpressParser::RenameIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RepeatControlContext*>(node)) {
    RepeatControlContextProxy proxy((ExpressParser::RepeatControlContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::WhileControlContext*>(node)) {
    WhileControlContextProxy proxy((ExpressParser::WhileControlContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UntilControlContext*>(node)) {
    UntilControlContextProxy proxy((ExpressParser::UntilControlContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RepeatStmtContext*>(node)) {
    RepeatStmtContextProxy proxy((ExpressParser::RepeatStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ResourceRefContext*>(node)) {
    ResourceRefContextProxy proxy((ExpressParser::ResourceRefContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::ReturnStmtContext*>(node)) {
    ReturnStmtContextProxy proxy((ExpressParser::ReturnStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleDeclContext*>(node)) {
    RuleDeclContextProxy proxy((ExpressParser::RuleDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::RuleHeadContext*>(node)) {
    RuleHeadContextProxy proxy((ExpressParser::RuleHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaBodyContext*>(node)) {
    SchemaBodyContextProxy proxy((ExpressParser::SchemaBodyContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaBodyDeclarationContext*>(node)) {
    SchemaBodyDeclarationContextProxy proxy((ExpressParser::SchemaBodyDeclarationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaDeclContext*>(node)) {
    SchemaDeclContextProxy proxy((ExpressParser::SchemaDeclContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SchemaVersionIdContext*>(node)) {
    SchemaVersionIdContextProxy proxy((ExpressParser::SchemaVersionIdContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SelectExtensionContext*>(node)) {
    SelectExtensionContextProxy proxy((ExpressParser::SelectExtensionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SelectListContext*>(node)) {
    SelectListContextProxy proxy((ExpressParser::SelectListContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TermContext*>(node)) {
    TermContextProxy proxy((ExpressParser::TermContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SimpleFactorExpressionContext*>(node)) {
    SimpleFactorExpressionContextProxy proxy((ExpressParser::SimpleFactorExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SimpleFactorUnaryExpressionContext*>(node)) {
    SimpleFactorUnaryExpressionContextProxy proxy((ExpressParser::SimpleFactorUnaryExpressionContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UnaryOpContext*>(node)) {
    UnaryOpContextProxy proxy((ExpressParser::UnaryOpContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::StringTypeContext*>(node)) {
    StringTypeContextProxy proxy((ExpressParser::StringTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SkipStmtContext*>(node)) {
    SkipStmtContextProxy proxy((ExpressParser::SkipStmtContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SupertypeConstraintContext*>(node)) {
    SupertypeConstraintContextProxy proxy((ExpressParser::SupertypeConstraintContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeDeclarationContext*>(node)) {
    SubtypeDeclarationContextProxy proxy((ExpressParser::SubtypeDeclarationContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintBodyContext*>(node)) {
    SubtypeConstraintBodyContextProxy proxy((ExpressParser::SubtypeConstraintBodyContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::TotalOverContext*>(node)) {
    TotalOverContextProxy proxy((ExpressParser::TotalOverContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SubtypeConstraintHeadContext*>(node)) {
    SubtypeConstraintHeadContextProxy proxy((ExpressParser::SubtypeConstraintHeadContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SupertypeRuleContext*>(node)) {
    SupertypeRuleContextProxy proxy((ExpressParser::SupertypeRuleContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SupertypeFactorContext*>(node)) {
    SupertypeFactorContextProxy proxy((ExpressParser::SupertypeFactorContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SupertypeTermContext*>(node)) {
    SupertypeTermContextProxy proxy((ExpressParser::SupertypeTermContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::SyntaxContext*>(node)) {
    SyntaxContextProxy proxy((ExpressParser::SyntaxContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UnderlyingTypeContext*>(node)) {
    UnderlyingTypeContextProxy proxy((ExpressParser::UnderlyingTypeContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::UniqueRuleContext*>(node)) {
    UniqueRuleContextProxy proxy((ExpressParser::UniqueRuleContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<ExpressParser::WidthContext*>(node)) {
    WidthContextProxy proxy((ExpressParser::WidthContext*)node);
    return to_ruby(proxy);
  }
  else if (antlrcpp::is<tree::TerminalNodeImpl*>(node)) {
    TerminalNodeProxy proxy(node);
    return to_ruby(proxy);
  } else {
    return Nil;
  }
}


extern "C"
void Init_express_parser() {
  Module rb_mExpressParser = define_module("ExpressParser");

  rb_cToken = rb_mExpressParser
    .define_class<Token>("Token")
    .define_method("text", &Token::getText);

  rb_cParser = rb_mExpressParser
    .define_class<ParserProxy>("Parser")
    .define_singleton_method("parse", &ParserProxy::parse)
    .define_singleton_method("parse_file", &ParserProxy::parseFile)
    .define_method("visit", &ParserProxy::visit);

  rb_cParseTree = rb_mExpressParser
    .define_class<tree::ParseTree>("ParseTree");

  rb_cContextProxy = rb_mExpressParser
    .define_class<ContextProxy>("Context")
    .define_method("children", &ContextProxy::getChildren)
    .define_method("child_count", &ContextProxy::childCount)
    .define_method("text", &ContextProxy::getText)
    .define_method("parent", &ContextProxy::getParent)
    .define_method("==", &ContextProxy::doubleEquals);

  rb_cTerminalNode = rb_mExpressParser
    .define_class<TerminalNodeProxy, ContextProxy>("TerminalNodeImpl");

  rb_mExpressParser
    .define_class<VisitorProxy>("Visitor")
    .define_director<VisitorProxy>()
    .define_constructor(Constructor<VisitorProxy, Object>())
    .define_method("visit", &VisitorProxy::ruby_visit)
    .define_method("visit_children", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_attribute_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constant_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_function_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_parameter_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_label_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_label_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_variable_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_abstract_entity_declaration", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_abstract_supertype", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_abstract_supertype_declaration", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_actual_parameter_list", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_add_like_op", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_aggregate_initializer", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_aggregate_source", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_aggregate_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_aggregation_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_algorithm_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_alias_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_array_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_assignment_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_attribute_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_attribute_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_attribute_qualifier", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_bag_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_binary_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_boolean_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_bound1", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_bound2", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_bound_spec", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_built_in_constant", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_built_in_function", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_built_in_procedure", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_case_action", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_case_label", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_case_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_compound_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_concrete_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constant_body", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constant_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constant_factor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constant_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_constructed_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_declaration", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_derived_attr", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_derive_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_domain_rule", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_element", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_body", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_constructor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_entity_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_extension", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_items", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_item", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_reference", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_enumeration_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_escape_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_explicit_attr", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_factor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_formal_parameter", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_function_call", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_function_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_function_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_function_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_generalized_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_aggregation_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_array_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_bag_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_list_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_general_set_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_generic_entity_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_generic_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_group_qualifier", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_if_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_if_stmt_statements", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_if_stmt_else_statements", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_increment", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_increment_control", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_index", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_index1", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_index2", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_index_qualifier", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_instantiable_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_integer_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interface_specification", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interval", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interval_high", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interval_item", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interval_low", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_interval_op", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_inverse_attr", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_inverse_attr_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_inverse_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_list_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_literal", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_local_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_local_variable", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_logical_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_logical_literal", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_logical_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_multiplication_like_op", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_named_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_named_type_or_rename", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_null_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_number_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_numeric_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_one_of", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_parameter", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_parameter_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_parameter_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_population", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_precision_spec", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_primary", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_call_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_head_parameter", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_procedure_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_qualifiable_factor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_qualified_attribute", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_qualifier", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_query_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_real_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_redeclared_attribute", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_referenced_attribute", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_reference_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rel_op", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rel_op_extended", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rename_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_repeat_control", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_repeat_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_repetition", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_resource_or_rename", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_resource_ref", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_return_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_rule_label_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_body", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_body_declaration", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_schema_version_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_selector", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_select_extension", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_select_list", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_select_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_set_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_simple_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_simple_factor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_simple_factor_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_simple_factor_unary_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_simple_types", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_skip_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_stmt", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_string_literal", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_string_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subsuper", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint_body", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint_head", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_constraint_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_subtype_declaration", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_supertype_constraint", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_supertype_expression", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_supertype_factor", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_supertype_rule", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_supertype_term", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_syntax", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_term", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_total_over", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_decl", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_label", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_type_label_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_unary_op", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_underlying_type", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_unique_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_unique_rule", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_until_control", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_use_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_variable_id", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_where_clause", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_while_control", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_width", &VisitorProxy::ruby_visitChildren)
    .define_method("visit_width_spec", &VisitorProxy::ruby_visitChildren);

  rb_cAttributeRefContext = rb_mExpressParser
    .define_class<AttributeRefContextProxy, ContextProxy>("AttributeRefContext")
    .define_method("attribute_id", &AttributeRefContextProxy::attributeId);

  rb_cAttributeIdContext = rb_mExpressParser
    .define_class<AttributeIdContextProxy, ContextProxy>("AttributeIdContext")
    .define_method("SimpleId", &AttributeIdContextProxy::SimpleId);

  rb_cConstantRefContext = rb_mExpressParser
    .define_class<ConstantRefContextProxy, ContextProxy>("ConstantRefContext")
    .define_method("constant_id", &ConstantRefContextProxy::constantId);

  rb_cConstantIdContext = rb_mExpressParser
    .define_class<ConstantIdContextProxy, ContextProxy>("ConstantIdContext")
    .define_method("SimpleId", &ConstantIdContextProxy::SimpleId);

  rb_cEntityRefContext = rb_mExpressParser
    .define_class<EntityRefContextProxy, ContextProxy>("EntityRefContext")
    .define_method("entity_id", &EntityRefContextProxy::entityId);

  rb_cEntityIdContext = rb_mExpressParser
    .define_class<EntityIdContextProxy, ContextProxy>("EntityIdContext")
    .define_method("SimpleId", &EntityIdContextProxy::SimpleId);

  rb_cEnumerationRefContext = rb_mExpressParser
    .define_class<EnumerationRefContextProxy, ContextProxy>("EnumerationRefContext")
    .define_method("enumeration_id", &EnumerationRefContextProxy::enumerationId);

  rb_cEnumerationIdContext = rb_mExpressParser
    .define_class<EnumerationIdContextProxy, ContextProxy>("EnumerationIdContext")
    .define_method("SimpleId", &EnumerationIdContextProxy::SimpleId);

  rb_cFunctionRefContext = rb_mExpressParser
    .define_class<FunctionRefContextProxy, ContextProxy>("FunctionRefContext")
    .define_method("function_id", &FunctionRefContextProxy::functionId);

  rb_cFunctionIdContext = rb_mExpressParser
    .define_class<FunctionIdContextProxy, ContextProxy>("FunctionIdContext")
    .define_method("SimpleId", &FunctionIdContextProxy::SimpleId);

  rb_cParameterRefContext = rb_mExpressParser
    .define_class<ParameterRefContextProxy, ContextProxy>("ParameterRefContext")
    .define_method("parameter_id", &ParameterRefContextProxy::parameterId);

  rb_cParameterIdContext = rb_mExpressParser
    .define_class<ParameterIdContextProxy, ContextProxy>("ParameterIdContext")
    .define_method("SimpleId", &ParameterIdContextProxy::SimpleId);

  rb_cProcedureRefContext = rb_mExpressParser
    .define_class<ProcedureRefContextProxy, ContextProxy>("ProcedureRefContext")
    .define_method("procedure_id", &ProcedureRefContextProxy::procedureId);

  rb_cProcedureIdContext = rb_mExpressParser
    .define_class<ProcedureIdContextProxy, ContextProxy>("ProcedureIdContext")
    .define_method("SimpleId", &ProcedureIdContextProxy::SimpleId);

  rb_cRuleLabelRefContext = rb_mExpressParser
    .define_class<RuleLabelRefContextProxy, ContextProxy>("RuleLabelRefContext")
    .define_method("rule_label_id", &RuleLabelRefContextProxy::ruleLabelId);

  rb_cRuleLabelIdContext = rb_mExpressParser
    .define_class<RuleLabelIdContextProxy, ContextProxy>("RuleLabelIdContext")
    .define_method("SimpleId", &RuleLabelIdContextProxy::SimpleId);

  rb_cRuleRefContext = rb_mExpressParser
    .define_class<RuleRefContextProxy, ContextProxy>("RuleRefContext")
    .define_method("rule_id", &RuleRefContextProxy::ruleId);

  rb_cRuleIdContext = rb_mExpressParser
    .define_class<RuleIdContextProxy, ContextProxy>("RuleIdContext")
    .define_method("SimpleId", &RuleIdContextProxy::SimpleId);

  rb_cSchemaRefContext = rb_mExpressParser
    .define_class<SchemaRefContextProxy, ContextProxy>("SchemaRefContext")
    .define_method("schema_id", &SchemaRefContextProxy::schemaId);

  rb_cSchemaIdContext = rb_mExpressParser
    .define_class<SchemaIdContextProxy, ContextProxy>("SchemaIdContext")
    .define_method("SimpleId", &SchemaIdContextProxy::SimpleId);

  rb_cSubtypeConstraintRefContext = rb_mExpressParser
    .define_class<SubtypeConstraintRefContextProxy, ContextProxy>("SubtypeConstraintRefContext")
    .define_method("subtype_constraint_id", &SubtypeConstraintRefContextProxy::subtypeConstraintId);

  rb_cSubtypeConstraintIdContext = rb_mExpressParser
    .define_class<SubtypeConstraintIdContextProxy, ContextProxy>("SubtypeConstraintIdContext")
    .define_method("SimpleId", &SubtypeConstraintIdContextProxy::SimpleId);

  rb_cTypeLabelRefContext = rb_mExpressParser
    .define_class<TypeLabelRefContextProxy, ContextProxy>("TypeLabelRefContext")
    .define_method("type_label_id", &TypeLabelRefContextProxy::typeLabelId);

  rb_cTypeLabelIdContext = rb_mExpressParser
    .define_class<TypeLabelIdContextProxy, ContextProxy>("TypeLabelIdContext")
    .define_method("SimpleId", &TypeLabelIdContextProxy::SimpleId);

  rb_cTypeRefContext = rb_mExpressParser
    .define_class<TypeRefContextProxy, ContextProxy>("TypeRefContext")
    .define_method("type_id", &TypeRefContextProxy::typeId);

  rb_cTypeIdContext = rb_mExpressParser
    .define_class<TypeIdContextProxy, ContextProxy>("TypeIdContext")
    .define_method("SimpleId", &TypeIdContextProxy::SimpleId);

  rb_cVariableRefContext = rb_mExpressParser
    .define_class<VariableRefContextProxy, ContextProxy>("VariableRefContext")
    .define_method("variable_id", &VariableRefContextProxy::variableId);

  rb_cVariableIdContext = rb_mExpressParser
    .define_class<VariableIdContextProxy, ContextProxy>("VariableIdContext")
    .define_method("SimpleId", &VariableIdContextProxy::SimpleId);

  rb_cAbstractEntityDeclarationContext = rb_mExpressParser
    .define_class<AbstractEntityDeclarationContextProxy, ContextProxy>("AbstractEntityDeclarationContext")
    .define_method("ABSTRACT", &AbstractEntityDeclarationContextProxy::ABSTRACT);

  rb_cAbstractSupertypeContext = rb_mExpressParser
    .define_class<AbstractSupertypeContextProxy, ContextProxy>("AbstractSupertypeContext")
    .define_method("ABSTRACT", &AbstractSupertypeContextProxy::ABSTRACT)
    .define_method("SUPERTYPE", &AbstractSupertypeContextProxy::SUPERTYPE);

  rb_cAbstractSupertypeDeclarationContext = rb_mExpressParser
    .define_class<AbstractSupertypeDeclarationContextProxy, ContextProxy>("AbstractSupertypeDeclarationContext")
    .define_method("subtype_constraint", &AbstractSupertypeDeclarationContextProxy::subtypeConstraint)
    .define_method("ABSTRACT", &AbstractSupertypeDeclarationContextProxy::ABSTRACT)
    .define_method("SUPERTYPE", &AbstractSupertypeDeclarationContextProxy::SUPERTYPE);

  rb_cSubtypeConstraintContext = rb_mExpressParser
    .define_class<SubtypeConstraintContextProxy, ContextProxy>("SubtypeConstraintContext")
    .define_method("supertype_expression", &SubtypeConstraintContextProxy::supertypeExpression)
    .define_method("OF", &SubtypeConstraintContextProxy::OF);

  rb_cActualParameterListContext = rb_mExpressParser
    .define_class<ActualParameterListContextProxy, ContextProxy>("ActualParameterListContext")
    .define_method("parameter", &ActualParameterListContextProxy::parameter)
    .define_method("parameter_at", &ActualParameterListContextProxy::parameterAt);

  rb_cParameterContext = rb_mExpressParser
    .define_class<ParameterContextProxy, ContextProxy>("ParameterContext")
    .define_method("expression", &ParameterContextProxy::expression);

  rb_cAddLikeOpContext = rb_mExpressParser
    .define_class<AddLikeOpContextProxy, ContextProxy>("AddLikeOpContext")
    .define_method("OR", &AddLikeOpContextProxy::OR)
    .define_method("XOR", &AddLikeOpContextProxy::XOR);

  rb_cAggregateInitializerContext = rb_mExpressParser
    .define_class<AggregateInitializerContextProxy, ContextProxy>("AggregateInitializerContext")
    .define_method("element", &AggregateInitializerContextProxy::element)
    .define_method("element_at", &AggregateInitializerContextProxy::elementAt);

  rb_cElementContext = rb_mExpressParser
    .define_class<ElementContextProxy, ContextProxy>("ElementContext")
    .define_method("expression", &ElementContextProxy::expression)
    .define_method("repetition", &ElementContextProxy::repetition);

  rb_cAggregateSourceContext = rb_mExpressParser
    .define_class<AggregateSourceContextProxy, ContextProxy>("AggregateSourceContext")
    .define_method("simple_expression", &AggregateSourceContextProxy::simpleExpression);

  rb_cSimpleExpressionContext = rb_mExpressParser
    .define_class<SimpleExpressionContextProxy, ContextProxy>("SimpleExpressionContext")
    .define_method("term", &SimpleExpressionContextProxy::term)
    .define_method("term_at", &SimpleExpressionContextProxy::termAt)
    .define_method("add_like_op", &SimpleExpressionContextProxy::addLikeOp)
    .define_method("add_like_op_at", &SimpleExpressionContextProxy::addLikeOpAt);

  rb_cAggregateTypeContext = rb_mExpressParser
    .define_class<AggregateTypeContextProxy, ContextProxy>("AggregateTypeContext")
    .define_method("parameter_type", &AggregateTypeContextProxy::parameterType)
    .define_method("type_label", &AggregateTypeContextProxy::typeLabel)
    .define_method("AGGREGATE", &AggregateTypeContextProxy::AGGREGATE)
    .define_method("OF", &AggregateTypeContextProxy::OF);

  rb_cParameterTypeContext = rb_mExpressParser
    .define_class<ParameterTypeContextProxy, ContextProxy>("ParameterTypeContext")
    .define_method("generalized_types", &ParameterTypeContextProxy::generalizedTypes)
    .define_method("named_types", &ParameterTypeContextProxy::namedTypes)
    .define_method("simple_types", &ParameterTypeContextProxy::simpleTypes);

  rb_cTypeLabelContext = rb_mExpressParser
    .define_class<TypeLabelContextProxy, ContextProxy>("TypeLabelContext")
    .define_method("type_label_id", &TypeLabelContextProxy::typeLabelId)
    .define_method("type_label_ref", &TypeLabelContextProxy::typeLabelRef);

  rb_cAggregationTypesContext = rb_mExpressParser
    .define_class<AggregationTypesContextProxy, ContextProxy>("AggregationTypesContext")
    .define_method("array_type", &AggregationTypesContextProxy::arrayType)
    .define_method("bag_type", &AggregationTypesContextProxy::bagType)
    .define_method("list_type", &AggregationTypesContextProxy::listType)
    .define_method("set_type", &AggregationTypesContextProxy::setType);

  rb_cArrayTypeContext = rb_mExpressParser
    .define_class<ArrayTypeContextProxy, ContextProxy>("ArrayTypeContext")
    .define_method("bound_spec", &ArrayTypeContextProxy::boundSpec)
    .define_method("instantiable_type", &ArrayTypeContextProxy::instantiableType)
    .define_method("ARRAY", &ArrayTypeContextProxy::ARRAY)
    .define_method("OF", &ArrayTypeContextProxy::OF)
    .define_method("OPTIONAL", &ArrayTypeContextProxy::OPTIONAL)
    .define_method("UNIQUE", &ArrayTypeContextProxy::UNIQUE);

  rb_cBagTypeContext = rb_mExpressParser
    .define_class<BagTypeContextProxy, ContextProxy>("BagTypeContext")
    .define_method("instantiable_type", &BagTypeContextProxy::instantiableType)
    .define_method("bound_spec", &BagTypeContextProxy::boundSpec)
    .define_method("BAG", &BagTypeContextProxy::BAG)
    .define_method("OF", &BagTypeContextProxy::OF);

  rb_cListTypeContext = rb_mExpressParser
    .define_class<ListTypeContextProxy, ContextProxy>("ListTypeContext")
    .define_method("instantiable_type", &ListTypeContextProxy::instantiableType)
    .define_method("bound_spec", &ListTypeContextProxy::boundSpec)
    .define_method("LIST", &ListTypeContextProxy::LIST)
    .define_method("OF", &ListTypeContextProxy::OF)
    .define_method("UNIQUE", &ListTypeContextProxy::UNIQUE);

  rb_cSetTypeContext = rb_mExpressParser
    .define_class<SetTypeContextProxy, ContextProxy>("SetTypeContext")
    .define_method("instantiable_type", &SetTypeContextProxy::instantiableType)
    .define_method("bound_spec", &SetTypeContextProxy::boundSpec)
    .define_method("SET", &SetTypeContextProxy::SET)
    .define_method("OF", &SetTypeContextProxy::OF);

  rb_cAlgorithmHeadContext = rb_mExpressParser
    .define_class<AlgorithmHeadContextProxy, ContextProxy>("AlgorithmHeadContext")
    .define_method("declaration", &AlgorithmHeadContextProxy::declaration)
    .define_method("declaration_at", &AlgorithmHeadContextProxy::declarationAt)
    .define_method("constant_decl", &AlgorithmHeadContextProxy::constantDecl)
    .define_method("local_decl", &AlgorithmHeadContextProxy::localDecl);

  rb_cDeclarationContext = rb_mExpressParser
    .define_class<DeclarationContextProxy, ContextProxy>("DeclarationContext")
    .define_method("entity_decl", &DeclarationContextProxy::entityDecl)
    .define_method("function_decl", &DeclarationContextProxy::functionDecl)
    .define_method("procedure_decl", &DeclarationContextProxy::procedureDecl)
    .define_method("subtype_constraint_decl", &DeclarationContextProxy::subtypeConstraintDecl)
    .define_method("type_decl", &DeclarationContextProxy::typeDecl);

  rb_cConstantDeclContext = rb_mExpressParser
    .define_class<ConstantDeclContextProxy, ContextProxy>("ConstantDeclContext")
    .define_method("constant_body", &ConstantDeclContextProxy::constantBody)
    .define_method("constant_body_at", &ConstantDeclContextProxy::constantBodyAt)
    .define_method("CONSTANT", &ConstantDeclContextProxy::CONSTANT)
    .define_method("END_CONSTANT", &ConstantDeclContextProxy::END_CONSTANT);

  rb_cLocalDeclContext = rb_mExpressParser
    .define_class<LocalDeclContextProxy, ContextProxy>("LocalDeclContext")
    .define_method("local_variable", &LocalDeclContextProxy::localVariable)
    .define_method("local_variable_at", &LocalDeclContextProxy::localVariableAt)
    .define_method("LOCAL", &LocalDeclContextProxy::LOCAL)
    .define_method("END_LOCAL", &LocalDeclContextProxy::END_LOCAL);

  rb_cAliasStmtContext = rb_mExpressParser
    .define_class<AliasStmtContextProxy, ContextProxy>("AliasStmtContext")
    .define_method("variable_id", &AliasStmtContextProxy::variableId)
    .define_method("general_ref", &AliasStmtContextProxy::generalRef)
    .define_method("stmt", &AliasStmtContextProxy::stmt)
    .define_method("stmt_at", &AliasStmtContextProxy::stmtAt)
    .define_method("qualifier", &AliasStmtContextProxy::qualifier)
    .define_method("qualifier_at", &AliasStmtContextProxy::qualifierAt)
    .define_method("ALIAS", &AliasStmtContextProxy::ALIAS)
    .define_method("FOR", &AliasStmtContextProxy::FOR)
    .define_method("END_ALIAS", &AliasStmtContextProxy::END_ALIAS);

  rb_cGeneralRefContext = rb_mExpressParser
    .define_class<GeneralRefContextProxy, ContextProxy>("GeneralRefContext")
    .define_method("parameter_ref", &GeneralRefContextProxy::parameterRef)
    .define_method("variable_id", &GeneralRefContextProxy::variableId);

  rb_cStmtContext = rb_mExpressParser
    .define_class<StmtContextProxy, ContextProxy>("StmtContext")
    .define_method("alias_stmt", &StmtContextProxy::aliasStmt)
    .define_method("assignment_stmt", &StmtContextProxy::assignmentStmt)
    .define_method("case_stmt", &StmtContextProxy::caseStmt)
    .define_method("compound_stmt", &StmtContextProxy::compoundStmt)
    .define_method("escape_stmt", &StmtContextProxy::escapeStmt)
    .define_method("if_stmt", &StmtContextProxy::ifStmt)
    .define_method("null_stmt", &StmtContextProxy::nullStmt)
    .define_method("procedure_call_stmt", &StmtContextProxy::procedureCallStmt)
    .define_method("repeat_stmt", &StmtContextProxy::repeatStmt)
    .define_method("return_stmt", &StmtContextProxy::returnStmt)
    .define_method("skip_stmt", &StmtContextProxy::skipStmt);

  rb_cQualifierContext = rb_mExpressParser
    .define_class<QualifierContextProxy, ContextProxy>("QualifierContext")
    .define_method("attribute_qualifier", &QualifierContextProxy::attributeQualifier)
    .define_method("group_qualifier", &QualifierContextProxy::groupQualifier)
    .define_method("index_qualifier", &QualifierContextProxy::indexQualifier);

  rb_cBoundSpecContext = rb_mExpressParser
    .define_class<BoundSpecContextProxy, ContextProxy>("BoundSpecContext")
    .define_method("bound1", &BoundSpecContextProxy::bound1)
    .define_method("bound2", &BoundSpecContextProxy::bound2);

  rb_cInstantiableTypeContext = rb_mExpressParser
    .define_class<InstantiableTypeContextProxy, ContextProxy>("InstantiableTypeContext")
    .define_method("concrete_types", &InstantiableTypeContextProxy::concreteTypes)
    .define_method("entity_ref", &InstantiableTypeContextProxy::entityRef);

  rb_cAssignmentStmtContext = rb_mExpressParser
    .define_class<AssignmentStmtContextProxy, ContextProxy>("AssignmentStmtContext")
    .define_method("general_ref", &AssignmentStmtContextProxy::generalRef)
    .define_method("expression", &AssignmentStmtContextProxy::expression)
    .define_method("qualifier", &AssignmentStmtContextProxy::qualifier)
    .define_method("qualifier_at", &AssignmentStmtContextProxy::qualifierAt);

  rb_cExpressionContext = rb_mExpressParser
    .define_class<ExpressionContextProxy, ContextProxy>("ExpressionContext")
    .define_method("simple_expression", &ExpressionContextProxy::simpleExpression)
    .define_method("simple_expression_at", &ExpressionContextProxy::simpleExpressionAt)
    .define_method("rel_op_extended", &ExpressionContextProxy::relOpExtended);

  rb_cAttributeDeclContext = rb_mExpressParser
    .define_class<AttributeDeclContextProxy, ContextProxy>("AttributeDeclContext")
    .define_method("attribute_id", &AttributeDeclContextProxy::attributeId)
    .define_method("redeclared_attribute", &AttributeDeclContextProxy::redeclaredAttribute);

  rb_cRedeclaredAttributeContext = rb_mExpressParser
    .define_class<RedeclaredAttributeContextProxy, ContextProxy>("RedeclaredAttributeContext")
    .define_method("qualified_attribute", &RedeclaredAttributeContextProxy::qualifiedAttribute)
    .define_method("attribute_id", &RedeclaredAttributeContextProxy::attributeId)
    .define_method("RENAMED", &RedeclaredAttributeContextProxy::RENAMED);

  rb_cAttributeQualifierContext = rb_mExpressParser
    .define_class<AttributeQualifierContextProxy, ContextProxy>("AttributeQualifierContext")
    .define_method("attribute_ref", &AttributeQualifierContextProxy::attributeRef);

  rb_cBinaryTypeContext = rb_mExpressParser
    .define_class<BinaryTypeContextProxy, ContextProxy>("BinaryTypeContext")
    .define_method("width_spec", &BinaryTypeContextProxy::widthSpec)
    .define_method("BINARY", &BinaryTypeContextProxy::BINARY);

  rb_cWidthSpecContext = rb_mExpressParser
    .define_class<WidthSpecContextProxy, ContextProxy>("WidthSpecContext")
    .define_method("width", &WidthSpecContextProxy::width)
    .define_method("FIXED", &WidthSpecContextProxy::FIXED);

  rb_cBooleanTypeContext = rb_mExpressParser
    .define_class<BooleanTypeContextProxy, ContextProxy>("BooleanTypeContext")
    .define_method("BOOLEAN", &BooleanTypeContextProxy::BOOLEAN);

  rb_cBound1Context = rb_mExpressParser
    .define_class<Bound1ContextProxy, ContextProxy>("Bound1Context")
    .define_method("numeric_expression", &Bound1ContextProxy::numericExpression);

  rb_cNumericExpressionContext = rb_mExpressParser
    .define_class<NumericExpressionContextProxy, ContextProxy>("NumericExpressionContext")
    .define_method("simple_expression", &NumericExpressionContextProxy::simpleExpression);

  rb_cBound2Context = rb_mExpressParser
    .define_class<Bound2ContextProxy, ContextProxy>("Bound2Context")
    .define_method("numeric_expression", &Bound2ContextProxy::numericExpression);

  rb_cBuiltInConstantContext = rb_mExpressParser
    .define_class<BuiltInConstantContextProxy, ContextProxy>("BuiltInConstantContext")
    .define_method("CONST_E", &BuiltInConstantContextProxy::CONST_E)
    .define_method("PI", &BuiltInConstantContextProxy::PI)
    .define_method("SELF", &BuiltInConstantContextProxy::SELF);

  rb_cBuiltInFunctionContext = rb_mExpressParser
    .define_class<BuiltInFunctionContextProxy, ContextProxy>("BuiltInFunctionContext")
    .define_method("ABS", &BuiltInFunctionContextProxy::ABS)
    .define_method("ACOS", &BuiltInFunctionContextProxy::ACOS)
    .define_method("ASIN", &BuiltInFunctionContextProxy::ASIN)
    .define_method("ATAN", &BuiltInFunctionContextProxy::ATAN)
    .define_method("BLENGTH", &BuiltInFunctionContextProxy::BLENGTH)
    .define_method("COS", &BuiltInFunctionContextProxy::COS)
    .define_method("EXISTS", &BuiltInFunctionContextProxy::EXISTS)
    .define_method("EXP", &BuiltInFunctionContextProxy::EXP)
    .define_method("FORMAT", &BuiltInFunctionContextProxy::FORMAT)
    .define_method("HIBOUND", &BuiltInFunctionContextProxy::HIBOUND)
    .define_method("HIINDEX", &BuiltInFunctionContextProxy::HIINDEX)
    .define_method("LENGTH", &BuiltInFunctionContextProxy::LENGTH)
    .define_method("LOBOUND", &BuiltInFunctionContextProxy::LOBOUND)
    .define_method("LOINDEX", &BuiltInFunctionContextProxy::LOINDEX)
    .define_method("LOG", &BuiltInFunctionContextProxy::LOG)
    .define_method("LOG2", &BuiltInFunctionContextProxy::LOG2)
    .define_method("LOG10", &BuiltInFunctionContextProxy::LOG10)
    .define_method("NVL", &BuiltInFunctionContextProxy::NVL)
    .define_method("ODD", &BuiltInFunctionContextProxy::ODD)
    .define_method("ROLESOF", &BuiltInFunctionContextProxy::ROLESOF)
    .define_method("SIN", &BuiltInFunctionContextProxy::SIN)
    .define_method("SIZEOF", &BuiltInFunctionContextProxy::SIZEOF)
    .define_method("SQRT", &BuiltInFunctionContextProxy::SQRT)
    .define_method("TAN", &BuiltInFunctionContextProxy::TAN)
    .define_method("TYPEOF", &BuiltInFunctionContextProxy::TYPEOF)
    .define_method("USEDIN", &BuiltInFunctionContextProxy::USEDIN)
    .define_method("VALUE_", &BuiltInFunctionContextProxy::VALUE_)
    .define_method("VALUE_IN", &BuiltInFunctionContextProxy::VALUE_IN)
    .define_method("VALUE_UNIQUE", &BuiltInFunctionContextProxy::VALUE_UNIQUE);

  rb_cBuiltInProcedureContext = rb_mExpressParser
    .define_class<BuiltInProcedureContextProxy, ContextProxy>("BuiltInProcedureContext")
    .define_method("INSERT", &BuiltInProcedureContextProxy::INSERT)
    .define_method("REMOVE", &BuiltInProcedureContextProxy::REMOVE);

  rb_cCaseActionContext = rb_mExpressParser
    .define_class<CaseActionContextProxy, ContextProxy>("CaseActionContext")
    .define_method("case_label", &CaseActionContextProxy::caseLabel)
    .define_method("case_label_at", &CaseActionContextProxy::caseLabelAt)
    .define_method("stmt", &CaseActionContextProxy::stmt);

  rb_cCaseLabelContext = rb_mExpressParser
    .define_class<CaseLabelContextProxy, ContextProxy>("CaseLabelContext")
    .define_method("expression", &CaseLabelContextProxy::expression);

  rb_cCaseStmtContext = rb_mExpressParser
    .define_class<CaseStmtContextProxy, ContextProxy>("CaseStmtContext")
    .define_method("selector", &CaseStmtContextProxy::selector)
    .define_method("case_action", &CaseStmtContextProxy::caseAction)
    .define_method("case_action_at", &CaseStmtContextProxy::caseActionAt)
    .define_method("stmt", &CaseStmtContextProxy::stmt)
    .define_method("CASE", &CaseStmtContextProxy::CASE)
    .define_method("OF", &CaseStmtContextProxy::OF)
    .define_method("END_CASE", &CaseStmtContextProxy::END_CASE)
    .define_method("OTHERWISE", &CaseStmtContextProxy::OTHERWISE);

  rb_cSelectorContext = rb_mExpressParser
    .define_class<SelectorContextProxy, ContextProxy>("SelectorContext")
    .define_method("expression", &SelectorContextProxy::expression);

  rb_cCompoundStmtContext = rb_mExpressParser
    .define_class<CompoundStmtContextProxy, ContextProxy>("CompoundStmtContext")
    .define_method("stmt", &CompoundStmtContextProxy::stmt)
    .define_method("stmt_at", &CompoundStmtContextProxy::stmtAt)
    .define_method("BEGIN_", &CompoundStmtContextProxy::BEGIN_)
    .define_method("END_", &CompoundStmtContextProxy::END_);

  rb_cConcreteTypesContext = rb_mExpressParser
    .define_class<ConcreteTypesContextProxy, ContextProxy>("ConcreteTypesContext")
    .define_method("aggregation_types", &ConcreteTypesContextProxy::aggregationTypes)
    .define_method("simple_types", &ConcreteTypesContextProxy::simpleTypes)
    .define_method("type_ref", &ConcreteTypesContextProxy::typeRef);

  rb_cSimpleTypesContext = rb_mExpressParser
    .define_class<SimpleTypesContextProxy, ContextProxy>("SimpleTypesContext")
    .define_method("binary_type", &SimpleTypesContextProxy::binaryType)
    .define_method("boolean_type", &SimpleTypesContextProxy::booleanType)
    .define_method("integer_type", &SimpleTypesContextProxy::integerType)
    .define_method("logical_type", &SimpleTypesContextProxy::logicalType)
    .define_method("number_type", &SimpleTypesContextProxy::numberType)
    .define_method("real_type", &SimpleTypesContextProxy::realType)
    .define_method("string_type", &SimpleTypesContextProxy::stringType);

  rb_cConstantBodyContext = rb_mExpressParser
    .define_class<ConstantBodyContextProxy, ContextProxy>("ConstantBodyContext")
    .define_method("constant_id", &ConstantBodyContextProxy::constantId)
    .define_method("instantiable_type", &ConstantBodyContextProxy::instantiableType)
    .define_method("expression", &ConstantBodyContextProxy::expression);

  rb_cConstantFactorContext = rb_mExpressParser
    .define_class<ConstantFactorContextProxy, ContextProxy>("ConstantFactorContext")
    .define_method("built_in_constant", &ConstantFactorContextProxy::builtInConstant)
    .define_method("constant_ref", &ConstantFactorContextProxy::constantRef);

  rb_cConstructedTypesContext = rb_mExpressParser
    .define_class<ConstructedTypesContextProxy, ContextProxy>("ConstructedTypesContext")
    .define_method("enumeration_type", &ConstructedTypesContextProxy::enumerationType)
    .define_method("select_type", &ConstructedTypesContextProxy::selectType);

  rb_cEnumerationTypeContext = rb_mExpressParser
    .define_class<EnumerationTypeContextProxy, ContextProxy>("EnumerationTypeContext")
    .define_method("enumeration_items", &EnumerationTypeContextProxy::enumerationItems)
    .define_method("enumeration_extension", &EnumerationTypeContextProxy::enumerationExtension)
    .define_method("ENUMERATION", &EnumerationTypeContextProxy::ENUMERATION)
    .define_method("EXTENSIBLE", &EnumerationTypeContextProxy::EXTENSIBLE)
    .define_method("OF", &EnumerationTypeContextProxy::OF);

  rb_cSelectTypeContext = rb_mExpressParser
    .define_class<SelectTypeContextProxy, ContextProxy>("SelectTypeContext")
    .define_method("select_list", &SelectTypeContextProxy::selectList)
    .define_method("select_extension", &SelectTypeContextProxy::selectExtension)
    .define_method("SELECT", &SelectTypeContextProxy::SELECT)
    .define_method("EXTENSIBLE", &SelectTypeContextProxy::EXTENSIBLE)
    .define_method("GENERIC_ENTITY", &SelectTypeContextProxy::GENERIC_ENTITY);

  rb_cEntityDeclContext = rb_mExpressParser
    .define_class<EntityDeclContextProxy, ContextProxy>("EntityDeclContext")
    .define_method("entity_head", &EntityDeclContextProxy::entityHead)
    .define_method("entity_body", &EntityDeclContextProxy::entityBody)
    .define_method("END_ENTITY", &EntityDeclContextProxy::END_ENTITY);

  rb_cFunctionDeclContext = rb_mExpressParser
    .define_class<FunctionDeclContextProxy, ContextProxy>("FunctionDeclContext")
    .define_method("function_head", &FunctionDeclContextProxy::functionHead)
    .define_method("algorithm_head", &FunctionDeclContextProxy::algorithmHead)
    .define_method("stmt", &FunctionDeclContextProxy::stmt)
    .define_method("stmt_at", &FunctionDeclContextProxy::stmtAt)
    .define_method("END_FUNCTION", &FunctionDeclContextProxy::END_FUNCTION);

  rb_cProcedureDeclContext = rb_mExpressParser
    .define_class<ProcedureDeclContextProxy, ContextProxy>("ProcedureDeclContext")
    .define_method("procedure_head", &ProcedureDeclContextProxy::procedureHead)
    .define_method("algorithm_head", &ProcedureDeclContextProxy::algorithmHead)
    .define_method("stmt", &ProcedureDeclContextProxy::stmt)
    .define_method("stmt_at", &ProcedureDeclContextProxy::stmtAt)
    .define_method("END_PROCEDURE", &ProcedureDeclContextProxy::END_PROCEDURE);

  rb_cSubtypeConstraintDeclContext = rb_mExpressParser
    .define_class<SubtypeConstraintDeclContextProxy, ContextProxy>("SubtypeConstraintDeclContext")
    .define_method("subtype_constraint_head", &SubtypeConstraintDeclContextProxy::subtypeConstraintHead)
    .define_method("subtype_constraint_body", &SubtypeConstraintDeclContextProxy::subtypeConstraintBody)
    .define_method("END_SUBTYPE_CONSTRAINT", &SubtypeConstraintDeclContextProxy::END_SUBTYPE_CONSTRAINT);

  rb_cTypeDeclContext = rb_mExpressParser
    .define_class<TypeDeclContextProxy, ContextProxy>("TypeDeclContext")
    .define_method("type_id", &TypeDeclContextProxy::typeId)
    .define_method("underlying_type", &TypeDeclContextProxy::underlyingType)
    .define_method("where_clause", &TypeDeclContextProxy::whereClause)
    .define_method("TYPE", &TypeDeclContextProxy::TYPE)
    .define_method("END_TYPE", &TypeDeclContextProxy::END_TYPE);

  rb_cDerivedAttrContext = rb_mExpressParser
    .define_class<DerivedAttrContextProxy, ContextProxy>("DerivedAttrContext")
    .define_method("attribute_decl", &DerivedAttrContextProxy::attributeDecl)
    .define_method("parameter_type", &DerivedAttrContextProxy::parameterType)
    .define_method("expression", &DerivedAttrContextProxy::expression);

  rb_cDeriveClauseContext = rb_mExpressParser
    .define_class<DeriveClauseContextProxy, ContextProxy>("DeriveClauseContext")
    .define_method("derived_attr", &DeriveClauseContextProxy::derivedAttr)
    .define_method("derived_attr_at", &DeriveClauseContextProxy::derivedAttrAt)
    .define_method("DERIVE", &DeriveClauseContextProxy::DERIVE);

  rb_cDomainRuleContext = rb_mExpressParser
    .define_class<DomainRuleContextProxy, ContextProxy>("DomainRuleContext")
    .define_method("expression", &DomainRuleContextProxy::expression)
    .define_method("rule_label_id", &DomainRuleContextProxy::ruleLabelId);

  rb_cRepetitionContext = rb_mExpressParser
    .define_class<RepetitionContextProxy, ContextProxy>("RepetitionContext")
    .define_method("numeric_expression", &RepetitionContextProxy::numericExpression);

  rb_cEntityBodyContext = rb_mExpressParser
    .define_class<EntityBodyContextProxy, ContextProxy>("EntityBodyContext")
    .define_method("explicit_attr", &EntityBodyContextProxy::explicitAttr)
    .define_method("explicit_attr_at", &EntityBodyContextProxy::explicitAttrAt)
    .define_method("derive_clause", &EntityBodyContextProxy::deriveClause)
    .define_method("inverse_clause", &EntityBodyContextProxy::inverseClause)
    .define_method("unique_clause", &EntityBodyContextProxy::uniqueClause)
    .define_method("where_clause", &EntityBodyContextProxy::whereClause);

  rb_cExplicitAttrContext = rb_mExpressParser
    .define_class<ExplicitAttrContextProxy, ContextProxy>("ExplicitAttrContext")
    .define_method("attribute_decl", &ExplicitAttrContextProxy::attributeDecl)
    .define_method("attribute_decl_at", &ExplicitAttrContextProxy::attributeDeclAt)
    .define_method("parameter_type", &ExplicitAttrContextProxy::parameterType)
    .define_method("OPTIONAL", &ExplicitAttrContextProxy::OPTIONAL);

  rb_cInverseClauseContext = rb_mExpressParser
    .define_class<InverseClauseContextProxy, ContextProxy>("InverseClauseContext")
    .define_method("inverse_attr", &InverseClauseContextProxy::inverseAttr)
    .define_method("inverse_attr_at", &InverseClauseContextProxy::inverseAttrAt)
    .define_method("INVERSE", &InverseClauseContextProxy::INVERSE);

  rb_cUniqueClauseContext = rb_mExpressParser
    .define_class<UniqueClauseContextProxy, ContextProxy>("UniqueClauseContext")
    .define_method("unique_rule", &UniqueClauseContextProxy::uniqueRule)
    .define_method("unique_rule_at", &UniqueClauseContextProxy::uniqueRuleAt)
    .define_method("UNIQUE", &UniqueClauseContextProxy::UNIQUE);

  rb_cWhereClauseContext = rb_mExpressParser
    .define_class<WhereClauseContextProxy, ContextProxy>("WhereClauseContext")
    .define_method("domain_rule", &WhereClauseContextProxy::domainRule)
    .define_method("domain_rule_at", &WhereClauseContextProxy::domainRuleAt)
    .define_method("WHERE", &WhereClauseContextProxy::WHERE);

  rb_cEntityConstructorContext = rb_mExpressParser
    .define_class<EntityConstructorContextProxy, ContextProxy>("EntityConstructorContext")
    .define_method("entity_ref", &EntityConstructorContextProxy::entityRef)
    .define_method("expression", &EntityConstructorContextProxy::expression)
    .define_method("expression_at", &EntityConstructorContextProxy::expressionAt);

  rb_cEntityHeadContext = rb_mExpressParser
    .define_class<EntityHeadContextProxy, ContextProxy>("EntityHeadContext")
    .define_method("entity_id", &EntityHeadContextProxy::entityId)
    .define_method("subsuper", &EntityHeadContextProxy::subsuper)
    .define_method("ENTITY", &EntityHeadContextProxy::ENTITY);

  rb_cSubsuperContext = rb_mExpressParser
    .define_class<SubsuperContextProxy, ContextProxy>("SubsuperContext")
    .define_method("supertype_constraint", &SubsuperContextProxy::supertypeConstraint)
    .define_method("subtype_declaration", &SubsuperContextProxy::subtypeDeclaration);

  rb_cEnumerationExtensionContext = rb_mExpressParser
    .define_class<EnumerationExtensionContextProxy, ContextProxy>("EnumerationExtensionContext")
    .define_method("type_ref", &EnumerationExtensionContextProxy::typeRef)
    .define_method("enumeration_items", &EnumerationExtensionContextProxy::enumerationItems)
    .define_method("BASED_ON", &EnumerationExtensionContextProxy::BASED_ON)
    .define_method("WITH", &EnumerationExtensionContextProxy::WITH);

  rb_cEnumerationItemsContext = rb_mExpressParser
    .define_class<EnumerationItemsContextProxy, ContextProxy>("EnumerationItemsContext")
    .define_method("enumeration_item", &EnumerationItemsContextProxy::enumerationItem)
    .define_method("enumeration_item_at", &EnumerationItemsContextProxy::enumerationItemAt);

  rb_cEnumerationItemContext = rb_mExpressParser
    .define_class<EnumerationItemContextProxy, ContextProxy>("EnumerationItemContext")
    .define_method("enumeration_id", &EnumerationItemContextProxy::enumerationId);

  rb_cEnumerationReferenceContext = rb_mExpressParser
    .define_class<EnumerationReferenceContextProxy, ContextProxy>("EnumerationReferenceContext")
    .define_method("enumeration_ref", &EnumerationReferenceContextProxy::enumerationRef)
    .define_method("type_ref", &EnumerationReferenceContextProxy::typeRef);

  rb_cEscapeStmtContext = rb_mExpressParser
    .define_class<EscapeStmtContextProxy, ContextProxy>("EscapeStmtContext")
    .define_method("ESCAPE", &EscapeStmtContextProxy::ESCAPE);

  rb_cRelOpExtendedContext = rb_mExpressParser
    .define_class<RelOpExtendedContextProxy, ContextProxy>("RelOpExtendedContext")
    .define_method("rel_op", &RelOpExtendedContextProxy::relOp)
    .define_method("IN", &RelOpExtendedContextProxy::IN)
    .define_method("LIKE", &RelOpExtendedContextProxy::LIKE);

  rb_cFactorContext = rb_mExpressParser
    .define_class<FactorContextProxy, ContextProxy>("FactorContext")
    .define_method("simple_factor", &FactorContextProxy::simpleFactor)
    .define_method("simple_factor_at", &FactorContextProxy::simpleFactorAt);

  rb_cSimpleFactorContext = rb_mExpressParser
    .define_class<SimpleFactorContextProxy, ContextProxy>("SimpleFactorContext")
    .define_method("aggregate_initializer", &SimpleFactorContextProxy::aggregateInitializer)
    .define_method("entity_constructor", &SimpleFactorContextProxy::entityConstructor)
    .define_method("enumeration_reference", &SimpleFactorContextProxy::enumerationReference)
    .define_method("interval", &SimpleFactorContextProxy::interval)
    .define_method("query_expression", &SimpleFactorContextProxy::queryExpression)
    .define_method("simple_factor_expression", &SimpleFactorContextProxy::simpleFactorExpression)
    .define_method("simple_factor_unary_expression", &SimpleFactorContextProxy::simpleFactorUnaryExpression);

  rb_cFormalParameterContext = rb_mExpressParser
    .define_class<FormalParameterContextProxy, ContextProxy>("FormalParameterContext")
    .define_method("parameter_id", &FormalParameterContextProxy::parameterId)
    .define_method("parameter_id_at", &FormalParameterContextProxy::parameterIdAt)
    .define_method("parameter_type", &FormalParameterContextProxy::parameterType);

  rb_cFunctionCallContext = rb_mExpressParser
    .define_class<FunctionCallContextProxy, ContextProxy>("FunctionCallContext")
    .define_method("built_in_function", &FunctionCallContextProxy::builtInFunction)
    .define_method("function_ref", &FunctionCallContextProxy::functionRef)
    .define_method("actual_parameter_list", &FunctionCallContextProxy::actualParameterList);

  rb_cFunctionHeadContext = rb_mExpressParser
    .define_class<FunctionHeadContextProxy, ContextProxy>("FunctionHeadContext")
    .define_method("function_id", &FunctionHeadContextProxy::functionId)
    .define_method("parameter_type", &FunctionHeadContextProxy::parameterType)
    .define_method("formal_parameter", &FunctionHeadContextProxy::formalParameter)
    .define_method("formal_parameter_at", &FunctionHeadContextProxy::formalParameterAt)
    .define_method("FUNCTION", &FunctionHeadContextProxy::FUNCTION);

  rb_cGeneralizedTypesContext = rb_mExpressParser
    .define_class<GeneralizedTypesContextProxy, ContextProxy>("GeneralizedTypesContext")
    .define_method("aggregate_type", &GeneralizedTypesContextProxy::aggregateType)
    .define_method("general_aggregation_types", &GeneralizedTypesContextProxy::generalAggregationTypes)
    .define_method("generic_entity_type", &GeneralizedTypesContextProxy::genericEntityType)
    .define_method("generic_type", &GeneralizedTypesContextProxy::genericType);

  rb_cGeneralAggregationTypesContext = rb_mExpressParser
    .define_class<GeneralAggregationTypesContextProxy, ContextProxy>("GeneralAggregationTypesContext")
    .define_method("general_array_type", &GeneralAggregationTypesContextProxy::generalArrayType)
    .define_method("general_bag_type", &GeneralAggregationTypesContextProxy::generalBagType)
    .define_method("general_list_type", &GeneralAggregationTypesContextProxy::generalListType)
    .define_method("general_set_type", &GeneralAggregationTypesContextProxy::generalSetType);

  rb_cGenericEntityTypeContext = rb_mExpressParser
    .define_class<GenericEntityTypeContextProxy, ContextProxy>("GenericEntityTypeContext")
    .define_method("type_label", &GenericEntityTypeContextProxy::typeLabel)
    .define_method("GENERIC_ENTITY", &GenericEntityTypeContextProxy::GENERIC_ENTITY);

  rb_cGenericTypeContext = rb_mExpressParser
    .define_class<GenericTypeContextProxy, ContextProxy>("GenericTypeContext")
    .define_method("type_label", &GenericTypeContextProxy::typeLabel)
    .define_method("GENERIC", &GenericTypeContextProxy::GENERIC);

  rb_cGeneralArrayTypeContext = rb_mExpressParser
    .define_class<GeneralArrayTypeContextProxy, ContextProxy>("GeneralArrayTypeContext")
    .define_method("parameter_type", &GeneralArrayTypeContextProxy::parameterType)
    .define_method("bound_spec", &GeneralArrayTypeContextProxy::boundSpec)
    .define_method("ARRAY", &GeneralArrayTypeContextProxy::ARRAY)
    .define_method("OF", &GeneralArrayTypeContextProxy::OF)
    .define_method("OPTIONAL", &GeneralArrayTypeContextProxy::OPTIONAL)
    .define_method("UNIQUE", &GeneralArrayTypeContextProxy::UNIQUE);

  rb_cGeneralBagTypeContext = rb_mExpressParser
    .define_class<GeneralBagTypeContextProxy, ContextProxy>("GeneralBagTypeContext")
    .define_method("parameter_type", &GeneralBagTypeContextProxy::parameterType)
    .define_method("bound_spec", &GeneralBagTypeContextProxy::boundSpec)
    .define_method("BAG", &GeneralBagTypeContextProxy::BAG)
    .define_method("OF", &GeneralBagTypeContextProxy::OF);

  rb_cGeneralListTypeContext = rb_mExpressParser
    .define_class<GeneralListTypeContextProxy, ContextProxy>("GeneralListTypeContext")
    .define_method("parameter_type", &GeneralListTypeContextProxy::parameterType)
    .define_method("bound_spec", &GeneralListTypeContextProxy::boundSpec)
    .define_method("LIST", &GeneralListTypeContextProxy::LIST)
    .define_method("OF", &GeneralListTypeContextProxy::OF)
    .define_method("UNIQUE", &GeneralListTypeContextProxy::UNIQUE);

  rb_cGeneralSetTypeContext = rb_mExpressParser
    .define_class<GeneralSetTypeContextProxy, ContextProxy>("GeneralSetTypeContext")
    .define_method("parameter_type", &GeneralSetTypeContextProxy::parameterType)
    .define_method("bound_spec", &GeneralSetTypeContextProxy::boundSpec)
    .define_method("SET", &GeneralSetTypeContextProxy::SET)
    .define_method("OF", &GeneralSetTypeContextProxy::OF);

  rb_cGroupQualifierContext = rb_mExpressParser
    .define_class<GroupQualifierContextProxy, ContextProxy>("GroupQualifierContext")
    .define_method("entity_ref", &GroupQualifierContextProxy::entityRef);

  rb_cIfStmtContext = rb_mExpressParser
    .define_class<IfStmtContextProxy, ContextProxy>("IfStmtContext")
    .define_method("logical_expression", &IfStmtContextProxy::logicalExpression)
    .define_method("if_stmt_statements", &IfStmtContextProxy::ifStmtStatements)
    .define_method("if_stmt_else_statements", &IfStmtContextProxy::ifStmtElseStatements)
    .define_method("IF", &IfStmtContextProxy::IF)
    .define_method("THEN", &IfStmtContextProxy::THEN)
    .define_method("END_IF", &IfStmtContextProxy::END_IF)
    .define_method("ELSE", &IfStmtContextProxy::ELSE);

  rb_cLogicalExpressionContext = rb_mExpressParser
    .define_class<LogicalExpressionContextProxy, ContextProxy>("LogicalExpressionContext")
    .define_method("expression", &LogicalExpressionContextProxy::expression);

  rb_cIfStmtStatementsContext = rb_mExpressParser
    .define_class<IfStmtStatementsContextProxy, ContextProxy>("IfStmtStatementsContext")
    .define_method("stmt", &IfStmtStatementsContextProxy::stmt)
    .define_method("stmt_at", &IfStmtStatementsContextProxy::stmtAt);

  rb_cIfStmtElseStatementsContext = rb_mExpressParser
    .define_class<IfStmtElseStatementsContextProxy, ContextProxy>("IfStmtElseStatementsContext")
    .define_method("stmt", &IfStmtElseStatementsContextProxy::stmt)
    .define_method("stmt_at", &IfStmtElseStatementsContextProxy::stmtAt);

  rb_cIncrementContext = rb_mExpressParser
    .define_class<IncrementContextProxy, ContextProxy>("IncrementContext")
    .define_method("numeric_expression", &IncrementContextProxy::numericExpression);

  rb_cIncrementControlContext = rb_mExpressParser
    .define_class<IncrementControlContextProxy, ContextProxy>("IncrementControlContext")
    .define_method("variable_id", &IncrementControlContextProxy::variableId)
    .define_method("bound1", &IncrementControlContextProxy::bound1)
    .define_method("bound2", &IncrementControlContextProxy::bound2)
    .define_method("increment", &IncrementControlContextProxy::increment)
    .define_method("TO", &IncrementControlContextProxy::TO)
    .define_method("BY", &IncrementControlContextProxy::BY);

  rb_cIndexContext = rb_mExpressParser
    .define_class<IndexContextProxy, ContextProxy>("IndexContext")
    .define_method("numeric_expression", &IndexContextProxy::numericExpression);

  rb_cIndex1Context = rb_mExpressParser
    .define_class<Index1ContextProxy, ContextProxy>("Index1Context")
    .define_method("index", &Index1ContextProxy::index);

  rb_cIndex2Context = rb_mExpressParser
    .define_class<Index2ContextProxy, ContextProxy>("Index2Context")
    .define_method("index", &Index2ContextProxy::index);

  rb_cIndexQualifierContext = rb_mExpressParser
    .define_class<IndexQualifierContextProxy, ContextProxy>("IndexQualifierContext")
    .define_method("index1", &IndexQualifierContextProxy::index1)
    .define_method("index2", &IndexQualifierContextProxy::index2);

  rb_cIntegerTypeContext = rb_mExpressParser
    .define_class<IntegerTypeContextProxy, ContextProxy>("IntegerTypeContext")
    .define_method("INTEGER", &IntegerTypeContextProxy::INTEGER);

  rb_cInterfaceSpecificationContext = rb_mExpressParser
    .define_class<InterfaceSpecificationContextProxy, ContextProxy>("InterfaceSpecificationContext")
    .define_method("reference_clause", &InterfaceSpecificationContextProxy::referenceClause)
    .define_method("use_clause", &InterfaceSpecificationContextProxy::useClause);

  rb_cReferenceClauseContext = rb_mExpressParser
    .define_class<ReferenceClauseContextProxy, ContextProxy>("ReferenceClauseContext")
    .define_method("schema_ref", &ReferenceClauseContextProxy::schemaRef)
    .define_method("resource_or_rename", &ReferenceClauseContextProxy::resourceOrRename)
    .define_method("resource_or_rename_at", &ReferenceClauseContextProxy::resourceOrRenameAt)
    .define_method("REFERENCE", &ReferenceClauseContextProxy::REFERENCE)
    .define_method("FROM", &ReferenceClauseContextProxy::FROM);

  rb_cUseClauseContext = rb_mExpressParser
    .define_class<UseClauseContextProxy, ContextProxy>("UseClauseContext")
    .define_method("schema_ref", &UseClauseContextProxy::schemaRef)
    .define_method("named_type_or_rename", &UseClauseContextProxy::namedTypeOrRename)
    .define_method("named_type_or_rename_at", &UseClauseContextProxy::namedTypeOrRenameAt)
    .define_method("USE", &UseClauseContextProxy::USE)
    .define_method("FROM", &UseClauseContextProxy::FROM);

  rb_cIntervalContext = rb_mExpressParser
    .define_class<IntervalContextProxy, ContextProxy>("IntervalContext")
    .define_method("interval_low", &IntervalContextProxy::intervalLow)
    .define_method("interval_op", &IntervalContextProxy::intervalOp)
    .define_method("interval_op_at", &IntervalContextProxy::intervalOpAt)
    .define_method("interval_item", &IntervalContextProxy::intervalItem)
    .define_method("interval_high", &IntervalContextProxy::intervalHigh);

  rb_cIntervalLowContext = rb_mExpressParser
    .define_class<IntervalLowContextProxy, ContextProxy>("IntervalLowContext")
    .define_method("simple_expression", &IntervalLowContextProxy::simpleExpression);

  rb_cIntervalOpContext = rb_mExpressParser
    .define_class<IntervalOpContextProxy, ContextProxy>("IntervalOpContext");

  rb_cIntervalItemContext = rb_mExpressParser
    .define_class<IntervalItemContextProxy, ContextProxy>("IntervalItemContext")
    .define_method("simple_expression", &IntervalItemContextProxy::simpleExpression);

  rb_cIntervalHighContext = rb_mExpressParser
    .define_class<IntervalHighContextProxy, ContextProxy>("IntervalHighContext")
    .define_method("simple_expression", &IntervalHighContextProxy::simpleExpression);

  rb_cInverseAttrContext = rb_mExpressParser
    .define_class<InverseAttrContextProxy, ContextProxy>("InverseAttrContext")
    .define_method("attribute_decl", &InverseAttrContextProxy::attributeDecl)
    .define_method("inverse_attr_type", &InverseAttrContextProxy::inverseAttrType)
    .define_method("attribute_ref", &InverseAttrContextProxy::attributeRef)
    .define_method("entity_ref", &InverseAttrContextProxy::entityRef)
    .define_method("FOR", &InverseAttrContextProxy::FOR);

  rb_cInverseAttrTypeContext = rb_mExpressParser
    .define_class<InverseAttrTypeContextProxy, ContextProxy>("InverseAttrTypeContext")
    .define_method("entity_ref", &InverseAttrTypeContextProxy::entityRef)
    .define_method("bound_spec", &InverseAttrTypeContextProxy::boundSpec)
    .define_method("OF", &InverseAttrTypeContextProxy::OF)
    .define_method("SET", &InverseAttrTypeContextProxy::SET)
    .define_method("BAG", &InverseAttrTypeContextProxy::BAG);

  rb_cLiteralContext = rb_mExpressParser
    .define_class<LiteralContextProxy, ContextProxy>("LiteralContext")
    .define_method("logical_literal", &LiteralContextProxy::logicalLiteral)
    .define_method("string_literal", &LiteralContextProxy::stringLiteral)
    .define_method("BinaryLiteral", &LiteralContextProxy::BinaryLiteral)
    .define_method("IntegerLiteral", &LiteralContextProxy::IntegerLiteral)
    .define_method("RealLiteral", &LiteralContextProxy::RealLiteral);

  rb_cLogicalLiteralContext = rb_mExpressParser
    .define_class<LogicalLiteralContextProxy, ContextProxy>("LogicalLiteralContext")
    .define_method("FALSE", &LogicalLiteralContextProxy::FALSE)
    .define_method("TRUE", &LogicalLiteralContextProxy::TRUE)
    .define_method("UNKNOWN", &LogicalLiteralContextProxy::UNKNOWN);

  rb_cStringLiteralContext = rb_mExpressParser
    .define_class<StringLiteralContextProxy, ContextProxy>("StringLiteralContext")
    .define_method("SimpleStringLiteral", &StringLiteralContextProxy::SimpleStringLiteral)
    .define_method("EncodedStringLiteral", &StringLiteralContextProxy::EncodedStringLiteral);

  rb_cLocalVariableContext = rb_mExpressParser
    .define_class<LocalVariableContextProxy, ContextProxy>("LocalVariableContext")
    .define_method("variable_id", &LocalVariableContextProxy::variableId)
    .define_method("variable_id_at", &LocalVariableContextProxy::variableIdAt)
    .define_method("parameter_type", &LocalVariableContextProxy::parameterType)
    .define_method("expression", &LocalVariableContextProxy::expression);

  rb_cLogicalTypeContext = rb_mExpressParser
    .define_class<LogicalTypeContextProxy, ContextProxy>("LogicalTypeContext")
    .define_method("LOGICAL", &LogicalTypeContextProxy::LOGICAL);

  rb_cMultiplicationLikeOpContext = rb_mExpressParser
    .define_class<MultiplicationLikeOpContextProxy, ContextProxy>("MultiplicationLikeOpContext")
    .define_method("DIV", &MultiplicationLikeOpContextProxy::DIV)
    .define_method("MOD", &MultiplicationLikeOpContextProxy::MOD)
    .define_method("AND", &MultiplicationLikeOpContextProxy::AND);

  rb_cNamedTypesContext = rb_mExpressParser
    .define_class<NamedTypesContextProxy, ContextProxy>("NamedTypesContext")
    .define_method("entity_ref", &NamedTypesContextProxy::entityRef)
    .define_method("type_ref", &NamedTypesContextProxy::typeRef);

  rb_cNamedTypeOrRenameContext = rb_mExpressParser
    .define_class<NamedTypeOrRenameContextProxy, ContextProxy>("NamedTypeOrRenameContext")
    .define_method("named_types", &NamedTypeOrRenameContextProxy::namedTypes)
    .define_method("entity_id", &NamedTypeOrRenameContextProxy::entityId)
    .define_method("type_id", &NamedTypeOrRenameContextProxy::typeId)
    .define_method("AS", &NamedTypeOrRenameContextProxy::AS);

  rb_cNullStmtContext = rb_mExpressParser
    .define_class<NullStmtContextProxy, ContextProxy>("NullStmtContext");

  rb_cNumberTypeContext = rb_mExpressParser
    .define_class<NumberTypeContextProxy, ContextProxy>("NumberTypeContext")
    .define_method("NUMBER", &NumberTypeContextProxy::NUMBER);

  rb_cOneOfContext = rb_mExpressParser
    .define_class<OneOfContextProxy, ContextProxy>("OneOfContext")
    .define_method("supertype_expression", &OneOfContextProxy::supertypeExpression)
    .define_method("supertype_expression_at", &OneOfContextProxy::supertypeExpressionAt)
    .define_method("ONEOF", &OneOfContextProxy::ONEOF);

  rb_cSupertypeExpressionContext = rb_mExpressParser
    .define_class<SupertypeExpressionContextProxy, ContextProxy>("SupertypeExpressionContext")
    .define_method("supertype_factor", &SupertypeExpressionContextProxy::supertypeFactor)
    .define_method("supertype_factor_at", &SupertypeExpressionContextProxy::supertypeFactorAt)
    .define_method("ANDOR", &SupertypeExpressionContextProxy::ANDOR)
    .define_method("ANDORAt", &SupertypeExpressionContextProxy::ANDOR);

  rb_cPopulationContext = rb_mExpressParser
    .define_class<PopulationContextProxy, ContextProxy>("PopulationContext")
    .define_method("entity_ref", &PopulationContextProxy::entityRef);

  rb_cPrecisionSpecContext = rb_mExpressParser
    .define_class<PrecisionSpecContextProxy, ContextProxy>("PrecisionSpecContext")
    .define_method("numeric_expression", &PrecisionSpecContextProxy::numericExpression);

  rb_cPrimaryContext = rb_mExpressParser
    .define_class<PrimaryContextProxy, ContextProxy>("PrimaryContext")
    .define_method("literal", &PrimaryContextProxy::literal)
    .define_method("qualifiable_factor", &PrimaryContextProxy::qualifiableFactor)
    .define_method("qualifier", &PrimaryContextProxy::qualifier)
    .define_method("qualifier_at", &PrimaryContextProxy::qualifierAt);

  rb_cQualifiableFactorContext = rb_mExpressParser
    .define_class<QualifiableFactorContextProxy, ContextProxy>("QualifiableFactorContext")
    .define_method("attribute_ref", &QualifiableFactorContextProxy::attributeRef)
    .define_method("constant_factor", &QualifiableFactorContextProxy::constantFactor)
    .define_method("function_call", &QualifiableFactorContextProxy::functionCall)
    .define_method("general_ref", &QualifiableFactorContextProxy::generalRef)
    .define_method("population", &QualifiableFactorContextProxy::population);

  rb_cProcedureCallStmtContext = rb_mExpressParser
    .define_class<ProcedureCallStmtContextProxy, ContextProxy>("ProcedureCallStmtContext")
    .define_method("built_in_procedure", &ProcedureCallStmtContextProxy::builtInProcedure)
    .define_method("procedure_ref", &ProcedureCallStmtContextProxy::procedureRef)
    .define_method("actual_parameter_list", &ProcedureCallStmtContextProxy::actualParameterList);

  rb_cProcedureHeadContext = rb_mExpressParser
    .define_class<ProcedureHeadContextProxy, ContextProxy>("ProcedureHeadContext")
    .define_method("procedure_id", &ProcedureHeadContextProxy::procedureId)
    .define_method("procedure_head_parameter", &ProcedureHeadContextProxy::procedureHeadParameter)
    .define_method("procedure_head_parameter_at", &ProcedureHeadContextProxy::procedureHeadParameterAt)
    .define_method("PROCEDURE", &ProcedureHeadContextProxy::PROCEDURE);

  rb_cProcedureHeadParameterContext = rb_mExpressParser
    .define_class<ProcedureHeadParameterContextProxy, ContextProxy>("ProcedureHeadParameterContext")
    .define_method("formal_parameter", &ProcedureHeadParameterContextProxy::formalParameter)
    .define_method("VAR", &ProcedureHeadParameterContextProxy::VAR);

  rb_cQualifiedAttributeContext = rb_mExpressParser
    .define_class<QualifiedAttributeContextProxy, ContextProxy>("QualifiedAttributeContext")
    .define_method("group_qualifier", &QualifiedAttributeContextProxy::groupQualifier)
    .define_method("attribute_qualifier", &QualifiedAttributeContextProxy::attributeQualifier)
    .define_method("SELF", &QualifiedAttributeContextProxy::SELF);

  rb_cQueryExpressionContext = rb_mExpressParser
    .define_class<QueryExpressionContextProxy, ContextProxy>("QueryExpressionContext")
    .define_method("variable_id", &QueryExpressionContextProxy::variableId)
    .define_method("aggregate_source", &QueryExpressionContextProxy::aggregateSource)
    .define_method("logical_expression", &QueryExpressionContextProxy::logicalExpression)
    .define_method("QUERY", &QueryExpressionContextProxy::QUERY);

  rb_cRealTypeContext = rb_mExpressParser
    .define_class<RealTypeContextProxy, ContextProxy>("RealTypeContext")
    .define_method("precision_spec", &RealTypeContextProxy::precisionSpec)
    .define_method("REAL", &RealTypeContextProxy::REAL);

  rb_cReferencedAttributeContext = rb_mExpressParser
    .define_class<ReferencedAttributeContextProxy, ContextProxy>("ReferencedAttributeContext")
    .define_method("attribute_ref", &ReferencedAttributeContextProxy::attributeRef)
    .define_method("qualified_attribute", &ReferencedAttributeContextProxy::qualifiedAttribute);

  rb_cResourceOrRenameContext = rb_mExpressParser
    .define_class<ResourceOrRenameContextProxy, ContextProxy>("ResourceOrRenameContext")
    .define_method("resource_ref", &ResourceOrRenameContextProxy::resourceRef)
    .define_method("rename_id", &ResourceOrRenameContextProxy::renameId)
    .define_method("AS", &ResourceOrRenameContextProxy::AS);

  rb_cRelOpContext = rb_mExpressParser
    .define_class<RelOpContextProxy, ContextProxy>("RelOpContext");

  rb_cRenameIdContext = rb_mExpressParser
    .define_class<RenameIdContextProxy, ContextProxy>("RenameIdContext")
    .define_method("constant_id", &RenameIdContextProxy::constantId)
    .define_method("entity_id", &RenameIdContextProxy::entityId)
    .define_method("function_id", &RenameIdContextProxy::functionId)
    .define_method("procedure_id", &RenameIdContextProxy::procedureId)
    .define_method("type_id", &RenameIdContextProxy::typeId);

  rb_cRepeatControlContext = rb_mExpressParser
    .define_class<RepeatControlContextProxy, ContextProxy>("RepeatControlContext")
    .define_method("increment_control", &RepeatControlContextProxy::incrementControl)
    .define_method("while_control", &RepeatControlContextProxy::whileControl)
    .define_method("until_control", &RepeatControlContextProxy::untilControl);

  rb_cWhileControlContext = rb_mExpressParser
    .define_class<WhileControlContextProxy, ContextProxy>("WhileControlContext")
    .define_method("logical_expression", &WhileControlContextProxy::logicalExpression)
    .define_method("WHILE", &WhileControlContextProxy::WHILE);

  rb_cUntilControlContext = rb_mExpressParser
    .define_class<UntilControlContextProxy, ContextProxy>("UntilControlContext")
    .define_method("logical_expression", &UntilControlContextProxy::logicalExpression)
    .define_method("UNTIL", &UntilControlContextProxy::UNTIL);

  rb_cRepeatStmtContext = rb_mExpressParser
    .define_class<RepeatStmtContextProxy, ContextProxy>("RepeatStmtContext")
    .define_method("repeat_control", &RepeatStmtContextProxy::repeatControl)
    .define_method("stmt", &RepeatStmtContextProxy::stmt)
    .define_method("stmt_at", &RepeatStmtContextProxy::stmtAt)
    .define_method("REPEAT", &RepeatStmtContextProxy::REPEAT)
    .define_method("END_REPEAT", &RepeatStmtContextProxy::END_REPEAT);

  rb_cResourceRefContext = rb_mExpressParser
    .define_class<ResourceRefContextProxy, ContextProxy>("ResourceRefContext")
    .define_method("constant_ref", &ResourceRefContextProxy::constantRef)
    .define_method("entity_ref", &ResourceRefContextProxy::entityRef)
    .define_method("function_ref", &ResourceRefContextProxy::functionRef)
    .define_method("procedure_ref", &ResourceRefContextProxy::procedureRef)
    .define_method("type_ref", &ResourceRefContextProxy::typeRef);

  rb_cReturnStmtContext = rb_mExpressParser
    .define_class<ReturnStmtContextProxy, ContextProxy>("ReturnStmtContext")
    .define_method("expression", &ReturnStmtContextProxy::expression)
    .define_method("RETURN", &ReturnStmtContextProxy::RETURN);

  rb_cRuleDeclContext = rb_mExpressParser
    .define_class<RuleDeclContextProxy, ContextProxy>("RuleDeclContext")
    .define_method("rule_head", &RuleDeclContextProxy::ruleHead)
    .define_method("algorithm_head", &RuleDeclContextProxy::algorithmHead)
    .define_method("where_clause", &RuleDeclContextProxy::whereClause)
    .define_method("stmt", &RuleDeclContextProxy::stmt)
    .define_method("stmt_at", &RuleDeclContextProxy::stmtAt)
    .define_method("END_RULE", &RuleDeclContextProxy::END_RULE);

  rb_cRuleHeadContext = rb_mExpressParser
    .define_class<RuleHeadContextProxy, ContextProxy>("RuleHeadContext")
    .define_method("rule_id", &RuleHeadContextProxy::ruleId)
    .define_method("entity_ref", &RuleHeadContextProxy::entityRef)
    .define_method("entity_ref_at", &RuleHeadContextProxy::entityRefAt)
    .define_method("RULE", &RuleHeadContextProxy::RULE)
    .define_method("FOR", &RuleHeadContextProxy::FOR);

  rb_cSchemaBodyContext = rb_mExpressParser
    .define_class<SchemaBodyContextProxy, ContextProxy>("SchemaBodyContext")
    .define_method("interface_specification", &SchemaBodyContextProxy::interfaceSpecification)
    .define_method("interface_specification_at", &SchemaBodyContextProxy::interfaceSpecificationAt)
    .define_method("constant_decl", &SchemaBodyContextProxy::constantDecl)
    .define_method("schema_body_declaration", &SchemaBodyContextProxy::schemaBodyDeclaration)
    .define_method("schema_body_declaration_at", &SchemaBodyContextProxy::schemaBodyDeclarationAt);

  rb_cSchemaBodyDeclarationContext = rb_mExpressParser
    .define_class<SchemaBodyDeclarationContextProxy, ContextProxy>("SchemaBodyDeclarationContext")
    .define_method("declaration", &SchemaBodyDeclarationContextProxy::declaration)
    .define_method("rule_decl", &SchemaBodyDeclarationContextProxy::ruleDecl);

  rb_cSchemaDeclContext = rb_mExpressParser
    .define_class<SchemaDeclContextProxy, ContextProxy>("SchemaDeclContext")
    .define_method("schema_id", &SchemaDeclContextProxy::schemaId)
    .define_method("schema_body", &SchemaDeclContextProxy::schemaBody)
    .define_method("schema_version_id", &SchemaDeclContextProxy::schemaVersionId)
    .define_method("SCHEMA", &SchemaDeclContextProxy::SCHEMA)
    .define_method("END_SCHEMA", &SchemaDeclContextProxy::END_SCHEMA);

  rb_cSchemaVersionIdContext = rb_mExpressParser
    .define_class<SchemaVersionIdContextProxy, ContextProxy>("SchemaVersionIdContext")
    .define_method("string_literal", &SchemaVersionIdContextProxy::stringLiteral);

  rb_cSelectExtensionContext = rb_mExpressParser
    .define_class<SelectExtensionContextProxy, ContextProxy>("SelectExtensionContext")
    .define_method("type_ref", &SelectExtensionContextProxy::typeRef)
    .define_method("select_list", &SelectExtensionContextProxy::selectList)
    .define_method("BASED_ON", &SelectExtensionContextProxy::BASED_ON)
    .define_method("WITH", &SelectExtensionContextProxy::WITH);

  rb_cSelectListContext = rb_mExpressParser
    .define_class<SelectListContextProxy, ContextProxy>("SelectListContext")
    .define_method("named_types", &SelectListContextProxy::namedTypes)
    .define_method("named_types_at", &SelectListContextProxy::namedTypesAt);

  rb_cTermContext = rb_mExpressParser
    .define_class<TermContextProxy, ContextProxy>("TermContext")
    .define_method("factor", &TermContextProxy::factor)
    .define_method("factor_at", &TermContextProxy::factorAt)
    .define_method("multiplication_like_op", &TermContextProxy::multiplicationLikeOp)
    .define_method("multiplication_like_op_at", &TermContextProxy::multiplicationLikeOpAt);

  rb_cSimpleFactorExpressionContext = rb_mExpressParser
    .define_class<SimpleFactorExpressionContextProxy, ContextProxy>("SimpleFactorExpressionContext")
    .define_method("expression", &SimpleFactorExpressionContextProxy::expression)
    .define_method("primary", &SimpleFactorExpressionContextProxy::primary);

  rb_cSimpleFactorUnaryExpressionContext = rb_mExpressParser
    .define_class<SimpleFactorUnaryExpressionContextProxy, ContextProxy>("SimpleFactorUnaryExpressionContext")
    .define_method("unary_op", &SimpleFactorUnaryExpressionContextProxy::unaryOp)
    .define_method("simple_factor_expression", &SimpleFactorUnaryExpressionContextProxy::simpleFactorExpression);

  rb_cUnaryOpContext = rb_mExpressParser
    .define_class<UnaryOpContextProxy, ContextProxy>("UnaryOpContext")
    .define_method("NOT", &UnaryOpContextProxy::NOT);

  rb_cStringTypeContext = rb_mExpressParser
    .define_class<StringTypeContextProxy, ContextProxy>("StringTypeContext")
    .define_method("width_spec", &StringTypeContextProxy::widthSpec)
    .define_method("STRING", &StringTypeContextProxy::STRING);

  rb_cSkipStmtContext = rb_mExpressParser
    .define_class<SkipStmtContextProxy, ContextProxy>("SkipStmtContext")
    .define_method("SKIP_", &SkipStmtContextProxy::SKIP_);

  rb_cSupertypeConstraintContext = rb_mExpressParser
    .define_class<SupertypeConstraintContextProxy, ContextProxy>("SupertypeConstraintContext")
    .define_method("abstract_entity_declaration", &SupertypeConstraintContextProxy::abstractEntityDeclaration)
    .define_method("abstract_supertype_declaration", &SupertypeConstraintContextProxy::abstractSupertypeDeclaration)
    .define_method("supertype_rule", &SupertypeConstraintContextProxy::supertypeRule);

  rb_cSubtypeDeclarationContext = rb_mExpressParser
    .define_class<SubtypeDeclarationContextProxy, ContextProxy>("SubtypeDeclarationContext")
    .define_method("entity_ref", &SubtypeDeclarationContextProxy::entityRef)
    .define_method("entity_ref_at", &SubtypeDeclarationContextProxy::entityRefAt)
    .define_method("SUBTYPE", &SubtypeDeclarationContextProxy::SUBTYPE)
    .define_method("OF", &SubtypeDeclarationContextProxy::OF);

  rb_cSubtypeConstraintBodyContext = rb_mExpressParser
    .define_class<SubtypeConstraintBodyContextProxy, ContextProxy>("SubtypeConstraintBodyContext")
    .define_method("abstract_supertype", &SubtypeConstraintBodyContextProxy::abstractSupertype)
    .define_method("total_over", &SubtypeConstraintBodyContextProxy::totalOver)
    .define_method("supertype_expression", &SubtypeConstraintBodyContextProxy::supertypeExpression);

  rb_cTotalOverContext = rb_mExpressParser
    .define_class<TotalOverContextProxy, ContextProxy>("TotalOverContext")
    .define_method("entity_ref", &TotalOverContextProxy::entityRef)
    .define_method("entity_ref_at", &TotalOverContextProxy::entityRefAt)
    .define_method("TOTAL_OVER", &TotalOverContextProxy::TOTAL_OVER);

  rb_cSubtypeConstraintHeadContext = rb_mExpressParser
    .define_class<SubtypeConstraintHeadContextProxy, ContextProxy>("SubtypeConstraintHeadContext")
    .define_method("subtype_constraint_id", &SubtypeConstraintHeadContextProxy::subtypeConstraintId)
    .define_method("entity_ref", &SubtypeConstraintHeadContextProxy::entityRef)
    .define_method("SUBTYPE_CONSTRAINT", &SubtypeConstraintHeadContextProxy::SUBTYPE_CONSTRAINT)
    .define_method("FOR", &SubtypeConstraintHeadContextProxy::FOR);

  rb_cSupertypeRuleContext = rb_mExpressParser
    .define_class<SupertypeRuleContextProxy, ContextProxy>("SupertypeRuleContext")
    .define_method("subtype_constraint", &SupertypeRuleContextProxy::subtypeConstraint)
    .define_method("SUPERTYPE", &SupertypeRuleContextProxy::SUPERTYPE);

  rb_cSupertypeFactorContext = rb_mExpressParser
    .define_class<SupertypeFactorContextProxy, ContextProxy>("SupertypeFactorContext")
    .define_method("supertype_term", &SupertypeFactorContextProxy::supertypeTerm)
    .define_method("supertype_term_at", &SupertypeFactorContextProxy::supertypeTermAt)
    .define_method("AND", &SupertypeFactorContextProxy::AND)
    .define_method("ANDAt", &SupertypeFactorContextProxy::AND);

  rb_cSupertypeTermContext = rb_mExpressParser
    .define_class<SupertypeTermContextProxy, ContextProxy>("SupertypeTermContext")
    .define_method("entity_ref", &SupertypeTermContextProxy::entityRef)
    .define_method("one_of", &SupertypeTermContextProxy::oneOf)
    .define_method("supertype_expression", &SupertypeTermContextProxy::supertypeExpression);

  rb_cSyntaxContext = rb_mExpressParser
    .define_class<SyntaxContextProxy, ContextProxy>("SyntaxContext")
    .define_method("schema_decl", &SyntaxContextProxy::schemaDecl)
    .define_method("schema_decl_at", &SyntaxContextProxy::schemaDeclAt)
    .define_method("EOF", &SyntaxContextProxy::EOF);

  rb_cUnderlyingTypeContext = rb_mExpressParser
    .define_class<UnderlyingTypeContextProxy, ContextProxy>("UnderlyingTypeContext")
    .define_method("concrete_types", &UnderlyingTypeContextProxy::concreteTypes)
    .define_method("constructed_types", &UnderlyingTypeContextProxy::constructedTypes);

  rb_cUniqueRuleContext = rb_mExpressParser
    .define_class<UniqueRuleContextProxy, ContextProxy>("UniqueRuleContext")
    .define_method("referenced_attribute", &UniqueRuleContextProxy::referencedAttribute)
    .define_method("referenced_attribute_at", &UniqueRuleContextProxy::referencedAttributeAt)
    .define_method("rule_label_id", &UniqueRuleContextProxy::ruleLabelId);

  rb_cWidthContext = rb_mExpressParser
    .define_class<WidthContextProxy, ContextProxy>("WidthContext")
    .define_method("numeric_expression", &WidthContextProxy::numericExpression);
}
