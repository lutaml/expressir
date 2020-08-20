// Generated from Express.g4 by ANTLR 4.7.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ExpressParser}.
 */
public interface ExpressListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ExpressParser#attributeRef}.
	 * @param ctx the parse tree
	 */
	void enterAttributeRef(ExpressParser.AttributeRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#attributeRef}.
	 * @param ctx the parse tree
	 */
	void exitAttributeRef(ExpressParser.AttributeRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constantRef}.
	 * @param ctx the parse tree
	 */
	void enterConstantRef(ExpressParser.ConstantRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constantRef}.
	 * @param ctx the parse tree
	 */
	void exitConstantRef(ExpressParser.ConstantRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityRef}.
	 * @param ctx the parse tree
	 */
	void enterEntityRef(ExpressParser.EntityRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityRef}.
	 * @param ctx the parse tree
	 */
	void exitEntityRef(ExpressParser.EntityRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationRef}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationRef(ExpressParser.EnumerationRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationRef}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationRef(ExpressParser.EnumerationRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#functionRef}.
	 * @param ctx the parse tree
	 */
	void enterFunctionRef(ExpressParser.FunctionRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#functionRef}.
	 * @param ctx the parse tree
	 */
	void exitFunctionRef(ExpressParser.FunctionRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#parameterRef}.
	 * @param ctx the parse tree
	 */
	void enterParameterRef(ExpressParser.ParameterRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#parameterRef}.
	 * @param ctx the parse tree
	 */
	void exitParameterRef(ExpressParser.ParameterRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#procedureRef}.
	 * @param ctx the parse tree
	 */
	void enterProcedureRef(ExpressParser.ProcedureRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#procedureRef}.
	 * @param ctx the parse tree
	 */
	void exitProcedureRef(ExpressParser.ProcedureRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleLabelRef}.
	 * @param ctx the parse tree
	 */
	void enterRuleLabelRef(ExpressParser.RuleLabelRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleLabelRef}.
	 * @param ctx the parse tree
	 */
	void exitRuleLabelRef(ExpressParser.RuleLabelRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleRef}.
	 * @param ctx the parse tree
	 */
	void enterRuleRef(ExpressParser.RuleRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleRef}.
	 * @param ctx the parse tree
	 */
	void exitRuleRef(ExpressParser.RuleRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#schemaRef}.
	 * @param ctx the parse tree
	 */
	void enterSchemaRef(ExpressParser.SchemaRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#schemaRef}.
	 * @param ctx the parse tree
	 */
	void exitSchemaRef(ExpressParser.SchemaRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraintRef}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraintRef(ExpressParser.SubtypeConstraintRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraintRef}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraintRef(ExpressParser.SubtypeConstraintRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeLabelRef}.
	 * @param ctx the parse tree
	 */
	void enterTypeLabelRef(ExpressParser.TypeLabelRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeLabelRef}.
	 * @param ctx the parse tree
	 */
	void exitTypeLabelRef(ExpressParser.TypeLabelRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeRef}.
	 * @param ctx the parse tree
	 */
	void enterTypeRef(ExpressParser.TypeRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeRef}.
	 * @param ctx the parse tree
	 */
	void exitTypeRef(ExpressParser.TypeRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#variableRef}.
	 * @param ctx the parse tree
	 */
	void enterVariableRef(ExpressParser.VariableRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#variableRef}.
	 * @param ctx the parse tree
	 */
	void exitVariableRef(ExpressParser.VariableRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#abstractEntityDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterAbstractEntityDeclaration(ExpressParser.AbstractEntityDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#abstractEntityDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitAbstractEntityDeclaration(ExpressParser.AbstractEntityDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#abstractSupertype}.
	 * @param ctx the parse tree
	 */
	void enterAbstractSupertype(ExpressParser.AbstractSupertypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#abstractSupertype}.
	 * @param ctx the parse tree
	 */
	void exitAbstractSupertype(ExpressParser.AbstractSupertypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#abstractSupertypeDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterAbstractSupertypeDeclaration(ExpressParser.AbstractSupertypeDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#abstractSupertypeDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitAbstractSupertypeDeclaration(ExpressParser.AbstractSupertypeDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#actualParameterList}.
	 * @param ctx the parse tree
	 */
	void enterActualParameterList(ExpressParser.ActualParameterListContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#actualParameterList}.
	 * @param ctx the parse tree
	 */
	void exitActualParameterList(ExpressParser.ActualParameterListContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#addLikeOp}.
	 * @param ctx the parse tree
	 */
	void enterAddLikeOp(ExpressParser.AddLikeOpContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#addLikeOp}.
	 * @param ctx the parse tree
	 */
	void exitAddLikeOp(ExpressParser.AddLikeOpContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#aggregateInitializer}.
	 * @param ctx the parse tree
	 */
	void enterAggregateInitializer(ExpressParser.AggregateInitializerContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#aggregateInitializer}.
	 * @param ctx the parse tree
	 */
	void exitAggregateInitializer(ExpressParser.AggregateInitializerContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#aggregateSource}.
	 * @param ctx the parse tree
	 */
	void enterAggregateSource(ExpressParser.AggregateSourceContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#aggregateSource}.
	 * @param ctx the parse tree
	 */
	void exitAggregateSource(ExpressParser.AggregateSourceContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#aggregateType}.
	 * @param ctx the parse tree
	 */
	void enterAggregateType(ExpressParser.AggregateTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#aggregateType}.
	 * @param ctx the parse tree
	 */
	void exitAggregateType(ExpressParser.AggregateTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#aggregationTypes}.
	 * @param ctx the parse tree
	 */
	void enterAggregationTypes(ExpressParser.AggregationTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#aggregationTypes}.
	 * @param ctx the parse tree
	 */
	void exitAggregationTypes(ExpressParser.AggregationTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#algorithmHead}.
	 * @param ctx the parse tree
	 */
	void enterAlgorithmHead(ExpressParser.AlgorithmHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#algorithmHead}.
	 * @param ctx the parse tree
	 */
	void exitAlgorithmHead(ExpressParser.AlgorithmHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#aliasStmt}.
	 * @param ctx the parse tree
	 */
	void enterAliasStmt(ExpressParser.AliasStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#aliasStmt}.
	 * @param ctx the parse tree
	 */
	void exitAliasStmt(ExpressParser.AliasStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#arrayType}.
	 * @param ctx the parse tree
	 */
	void enterArrayType(ExpressParser.ArrayTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#arrayType}.
	 * @param ctx the parse tree
	 */
	void exitArrayType(ExpressParser.ArrayTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#assignmentStmt}.
	 * @param ctx the parse tree
	 */
	void enterAssignmentStmt(ExpressParser.AssignmentStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#assignmentStmt}.
	 * @param ctx the parse tree
	 */
	void exitAssignmentStmt(ExpressParser.AssignmentStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#attributeDecl}.
	 * @param ctx the parse tree
	 */
	void enterAttributeDecl(ExpressParser.AttributeDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#attributeDecl}.
	 * @param ctx the parse tree
	 */
	void exitAttributeDecl(ExpressParser.AttributeDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#attributeId}.
	 * @param ctx the parse tree
	 */
	void enterAttributeId(ExpressParser.AttributeIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#attributeId}.
	 * @param ctx the parse tree
	 */
	void exitAttributeId(ExpressParser.AttributeIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#attributeQualifier}.
	 * @param ctx the parse tree
	 */
	void enterAttributeQualifier(ExpressParser.AttributeQualifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#attributeQualifier}.
	 * @param ctx the parse tree
	 */
	void exitAttributeQualifier(ExpressParser.AttributeQualifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#bagType}.
	 * @param ctx the parse tree
	 */
	void enterBagType(ExpressParser.BagTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#bagType}.
	 * @param ctx the parse tree
	 */
	void exitBagType(ExpressParser.BagTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#binaryType}.
	 * @param ctx the parse tree
	 */
	void enterBinaryType(ExpressParser.BinaryTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#binaryType}.
	 * @param ctx the parse tree
	 */
	void exitBinaryType(ExpressParser.BinaryTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#booleanType}.
	 * @param ctx the parse tree
	 */
	void enterBooleanType(ExpressParser.BooleanTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#booleanType}.
	 * @param ctx the parse tree
	 */
	void exitBooleanType(ExpressParser.BooleanTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#bound1}.
	 * @param ctx the parse tree
	 */
	void enterBound1(ExpressParser.Bound1Context ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#bound1}.
	 * @param ctx the parse tree
	 */
	void exitBound1(ExpressParser.Bound1Context ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#bound2}.
	 * @param ctx the parse tree
	 */
	void enterBound2(ExpressParser.Bound2Context ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#bound2}.
	 * @param ctx the parse tree
	 */
	void exitBound2(ExpressParser.Bound2Context ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#boundSpec}.
	 * @param ctx the parse tree
	 */
	void enterBoundSpec(ExpressParser.BoundSpecContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#boundSpec}.
	 * @param ctx the parse tree
	 */
	void exitBoundSpec(ExpressParser.BoundSpecContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#builtInConstant}.
	 * @param ctx the parse tree
	 */
	void enterBuiltInConstant(ExpressParser.BuiltInConstantContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#builtInConstant}.
	 * @param ctx the parse tree
	 */
	void exitBuiltInConstant(ExpressParser.BuiltInConstantContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#builtInFunction}.
	 * @param ctx the parse tree
	 */
	void enterBuiltInFunction(ExpressParser.BuiltInFunctionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#builtInFunction}.
	 * @param ctx the parse tree
	 */
	void exitBuiltInFunction(ExpressParser.BuiltInFunctionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#builtInProcedure}.
	 * @param ctx the parse tree
	 */
	void enterBuiltInProcedure(ExpressParser.BuiltInProcedureContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#builtInProcedure}.
	 * @param ctx the parse tree
	 */
	void exitBuiltInProcedure(ExpressParser.BuiltInProcedureContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#caseAction}.
	 * @param ctx the parse tree
	 */
	void enterCaseAction(ExpressParser.CaseActionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#caseAction}.
	 * @param ctx the parse tree
	 */
	void exitCaseAction(ExpressParser.CaseActionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#caseLabel}.
	 * @param ctx the parse tree
	 */
	void enterCaseLabel(ExpressParser.CaseLabelContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#caseLabel}.
	 * @param ctx the parse tree
	 */
	void exitCaseLabel(ExpressParser.CaseLabelContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#caseStmt}.
	 * @param ctx the parse tree
	 */
	void enterCaseStmt(ExpressParser.CaseStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#caseStmt}.
	 * @param ctx the parse tree
	 */
	void exitCaseStmt(ExpressParser.CaseStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#compoundStmt}.
	 * @param ctx the parse tree
	 */
	void enterCompoundStmt(ExpressParser.CompoundStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#compoundStmt}.
	 * @param ctx the parse tree
	 */
	void exitCompoundStmt(ExpressParser.CompoundStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#concreteTypes}.
	 * @param ctx the parse tree
	 */
	void enterConcreteTypes(ExpressParser.ConcreteTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#concreteTypes}.
	 * @param ctx the parse tree
	 */
	void exitConcreteTypes(ExpressParser.ConcreteTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constantBody}.
	 * @param ctx the parse tree
	 */
	void enterConstantBody(ExpressParser.ConstantBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constantBody}.
	 * @param ctx the parse tree
	 */
	void exitConstantBody(ExpressParser.ConstantBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constantDecl}.
	 * @param ctx the parse tree
	 */
	void enterConstantDecl(ExpressParser.ConstantDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constantDecl}.
	 * @param ctx the parse tree
	 */
	void exitConstantDecl(ExpressParser.ConstantDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constantFactor}.
	 * @param ctx the parse tree
	 */
	void enterConstantFactor(ExpressParser.ConstantFactorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constantFactor}.
	 * @param ctx the parse tree
	 */
	void exitConstantFactor(ExpressParser.ConstantFactorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constantId}.
	 * @param ctx the parse tree
	 */
	void enterConstantId(ExpressParser.ConstantIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constantId}.
	 * @param ctx the parse tree
	 */
	void exitConstantId(ExpressParser.ConstantIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#constructedTypes}.
	 * @param ctx the parse tree
	 */
	void enterConstructedTypes(ExpressParser.ConstructedTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#constructedTypes}.
	 * @param ctx the parse tree
	 */
	void exitConstructedTypes(ExpressParser.ConstructedTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#declaration}.
	 * @param ctx the parse tree
	 */
	void enterDeclaration(ExpressParser.DeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#declaration}.
	 * @param ctx the parse tree
	 */
	void exitDeclaration(ExpressParser.DeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#derivedAttr}.
	 * @param ctx the parse tree
	 */
	void enterDerivedAttr(ExpressParser.DerivedAttrContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#derivedAttr}.
	 * @param ctx the parse tree
	 */
	void exitDerivedAttr(ExpressParser.DerivedAttrContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#deriveClause}.
	 * @param ctx the parse tree
	 */
	void enterDeriveClause(ExpressParser.DeriveClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#deriveClause}.
	 * @param ctx the parse tree
	 */
	void exitDeriveClause(ExpressParser.DeriveClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#domainRule}.
	 * @param ctx the parse tree
	 */
	void enterDomainRule(ExpressParser.DomainRuleContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#domainRule}.
	 * @param ctx the parse tree
	 */
	void exitDomainRule(ExpressParser.DomainRuleContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#element}.
	 * @param ctx the parse tree
	 */
	void enterElement(ExpressParser.ElementContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#element}.
	 * @param ctx the parse tree
	 */
	void exitElement(ExpressParser.ElementContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityBody}.
	 * @param ctx the parse tree
	 */
	void enterEntityBody(ExpressParser.EntityBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityBody}.
	 * @param ctx the parse tree
	 */
	void exitEntityBody(ExpressParser.EntityBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityConstructor}.
	 * @param ctx the parse tree
	 */
	void enterEntityConstructor(ExpressParser.EntityConstructorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityConstructor}.
	 * @param ctx the parse tree
	 */
	void exitEntityConstructor(ExpressParser.EntityConstructorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityDecl}.
	 * @param ctx the parse tree
	 */
	void enterEntityDecl(ExpressParser.EntityDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityDecl}.
	 * @param ctx the parse tree
	 */
	void exitEntityDecl(ExpressParser.EntityDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityHead}.
	 * @param ctx the parse tree
	 */
	void enterEntityHead(ExpressParser.EntityHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityHead}.
	 * @param ctx the parse tree
	 */
	void exitEntityHead(ExpressParser.EntityHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#entityId}.
	 * @param ctx the parse tree
	 */
	void enterEntityId(ExpressParser.EntityIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#entityId}.
	 * @param ctx the parse tree
	 */
	void exitEntityId(ExpressParser.EntityIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationExtension}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationExtension(ExpressParser.EnumerationExtensionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationExtension}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationExtension(ExpressParser.EnumerationExtensionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationId}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationId(ExpressParser.EnumerationIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationId}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationId(ExpressParser.EnumerationIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationItems}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationItems(ExpressParser.EnumerationItemsContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationItems}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationItems(ExpressParser.EnumerationItemsContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationReference}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationReference(ExpressParser.EnumerationReferenceContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationReference}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationReference(ExpressParser.EnumerationReferenceContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#enumerationType}.
	 * @param ctx the parse tree
	 */
	void enterEnumerationType(ExpressParser.EnumerationTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#enumerationType}.
	 * @param ctx the parse tree
	 */
	void exitEnumerationType(ExpressParser.EnumerationTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#escapeStmt}.
	 * @param ctx the parse tree
	 */
	void enterEscapeStmt(ExpressParser.EscapeStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#escapeStmt}.
	 * @param ctx the parse tree
	 */
	void exitEscapeStmt(ExpressParser.EscapeStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#explicitAttr}.
	 * @param ctx the parse tree
	 */
	void enterExplicitAttr(ExpressParser.ExplicitAttrContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#explicitAttr}.
	 * @param ctx the parse tree
	 */
	void exitExplicitAttr(ExpressParser.ExplicitAttrContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterExpression(ExpressParser.ExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitExpression(ExpressParser.ExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#factor}.
	 * @param ctx the parse tree
	 */
	void enterFactor(ExpressParser.FactorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#factor}.
	 * @param ctx the parse tree
	 */
	void exitFactor(ExpressParser.FactorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#formalParameter}.
	 * @param ctx the parse tree
	 */
	void enterFormalParameter(ExpressParser.FormalParameterContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#formalParameter}.
	 * @param ctx the parse tree
	 */
	void exitFormalParameter(ExpressParser.FormalParameterContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#functionCall}.
	 * @param ctx the parse tree
	 */
	void enterFunctionCall(ExpressParser.FunctionCallContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#functionCall}.
	 * @param ctx the parse tree
	 */
	void exitFunctionCall(ExpressParser.FunctionCallContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#functionDecl}.
	 * @param ctx the parse tree
	 */
	void enterFunctionDecl(ExpressParser.FunctionDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#functionDecl}.
	 * @param ctx the parse tree
	 */
	void exitFunctionDecl(ExpressParser.FunctionDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#functionHead}.
	 * @param ctx the parse tree
	 */
	void enterFunctionHead(ExpressParser.FunctionHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#functionHead}.
	 * @param ctx the parse tree
	 */
	void exitFunctionHead(ExpressParser.FunctionHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#functionId}.
	 * @param ctx the parse tree
	 */
	void enterFunctionId(ExpressParser.FunctionIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#functionId}.
	 * @param ctx the parse tree
	 */
	void exitFunctionId(ExpressParser.FunctionIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalizedTypes}.
	 * @param ctx the parse tree
	 */
	void enterGeneralizedTypes(ExpressParser.GeneralizedTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalizedTypes}.
	 * @param ctx the parse tree
	 */
	void exitGeneralizedTypes(ExpressParser.GeneralizedTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalAggregationTypes}.
	 * @param ctx the parse tree
	 */
	void enterGeneralAggregationTypes(ExpressParser.GeneralAggregationTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalAggregationTypes}.
	 * @param ctx the parse tree
	 */
	void exitGeneralAggregationTypes(ExpressParser.GeneralAggregationTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalArrayType}.
	 * @param ctx the parse tree
	 */
	void enterGeneralArrayType(ExpressParser.GeneralArrayTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalArrayType}.
	 * @param ctx the parse tree
	 */
	void exitGeneralArrayType(ExpressParser.GeneralArrayTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalBagType}.
	 * @param ctx the parse tree
	 */
	void enterGeneralBagType(ExpressParser.GeneralBagTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalBagType}.
	 * @param ctx the parse tree
	 */
	void exitGeneralBagType(ExpressParser.GeneralBagTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalListType}.
	 * @param ctx the parse tree
	 */
	void enterGeneralListType(ExpressParser.GeneralListTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalListType}.
	 * @param ctx the parse tree
	 */
	void exitGeneralListType(ExpressParser.GeneralListTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalRef}.
	 * @param ctx the parse tree
	 */
	void enterGeneralRef(ExpressParser.GeneralRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalRef}.
	 * @param ctx the parse tree
	 */
	void exitGeneralRef(ExpressParser.GeneralRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#generalSetType}.
	 * @param ctx the parse tree
	 */
	void enterGeneralSetType(ExpressParser.GeneralSetTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#generalSetType}.
	 * @param ctx the parse tree
	 */
	void exitGeneralSetType(ExpressParser.GeneralSetTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#genericEntityType}.
	 * @param ctx the parse tree
	 */
	void enterGenericEntityType(ExpressParser.GenericEntityTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#genericEntityType}.
	 * @param ctx the parse tree
	 */
	void exitGenericEntityType(ExpressParser.GenericEntityTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#genericType}.
	 * @param ctx the parse tree
	 */
	void enterGenericType(ExpressParser.GenericTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#genericType}.
	 * @param ctx the parse tree
	 */
	void exitGenericType(ExpressParser.GenericTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#groupQualifier}.
	 * @param ctx the parse tree
	 */
	void enterGroupQualifier(ExpressParser.GroupQualifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#groupQualifier}.
	 * @param ctx the parse tree
	 */
	void exitGroupQualifier(ExpressParser.GroupQualifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ifStmt}.
	 * @param ctx the parse tree
	 */
	void enterIfStmt(ExpressParser.IfStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ifStmt}.
	 * @param ctx the parse tree
	 */
	void exitIfStmt(ExpressParser.IfStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#increment}.
	 * @param ctx the parse tree
	 */
	void enterIncrement(ExpressParser.IncrementContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#increment}.
	 * @param ctx the parse tree
	 */
	void exitIncrement(ExpressParser.IncrementContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#incrementControl}.
	 * @param ctx the parse tree
	 */
	void enterIncrementControl(ExpressParser.IncrementControlContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#incrementControl}.
	 * @param ctx the parse tree
	 */
	void exitIncrementControl(ExpressParser.IncrementControlContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#index}.
	 * @param ctx the parse tree
	 */
	void enterIndex(ExpressParser.IndexContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#index}.
	 * @param ctx the parse tree
	 */
	void exitIndex(ExpressParser.IndexContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#index1}.
	 * @param ctx the parse tree
	 */
	void enterIndex1(ExpressParser.Index1Context ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#index1}.
	 * @param ctx the parse tree
	 */
	void exitIndex1(ExpressParser.Index1Context ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#index2}.
	 * @param ctx the parse tree
	 */
	void enterIndex2(ExpressParser.Index2Context ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#index2}.
	 * @param ctx the parse tree
	 */
	void exitIndex2(ExpressParser.Index2Context ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#indexQualifier}.
	 * @param ctx the parse tree
	 */
	void enterIndexQualifier(ExpressParser.IndexQualifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#indexQualifier}.
	 * @param ctx the parse tree
	 */
	void exitIndexQualifier(ExpressParser.IndexQualifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#instantiableType}.
	 * @param ctx the parse tree
	 */
	void enterInstantiableType(ExpressParser.InstantiableTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#instantiableType}.
	 * @param ctx the parse tree
	 */
	void exitInstantiableType(ExpressParser.InstantiableTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#integerType}.
	 * @param ctx the parse tree
	 */
	void enterIntegerType(ExpressParser.IntegerTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#integerType}.
	 * @param ctx the parse tree
	 */
	void exitIntegerType(ExpressParser.IntegerTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#interfaceSpecification}.
	 * @param ctx the parse tree
	 */
	void enterInterfaceSpecification(ExpressParser.InterfaceSpecificationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#interfaceSpecification}.
	 * @param ctx the parse tree
	 */
	void exitInterfaceSpecification(ExpressParser.InterfaceSpecificationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#interval}.
	 * @param ctx the parse tree
	 */
	void enterInterval(ExpressParser.IntervalContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#interval}.
	 * @param ctx the parse tree
	 */
	void exitInterval(ExpressParser.IntervalContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#intervalHigh}.
	 * @param ctx the parse tree
	 */
	void enterIntervalHigh(ExpressParser.IntervalHighContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#intervalHigh}.
	 * @param ctx the parse tree
	 */
	void exitIntervalHigh(ExpressParser.IntervalHighContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#intervalItem}.
	 * @param ctx the parse tree
	 */
	void enterIntervalItem(ExpressParser.IntervalItemContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#intervalItem}.
	 * @param ctx the parse tree
	 */
	void exitIntervalItem(ExpressParser.IntervalItemContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#intervalLow}.
	 * @param ctx the parse tree
	 */
	void enterIntervalLow(ExpressParser.IntervalLowContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#intervalLow}.
	 * @param ctx the parse tree
	 */
	void exitIntervalLow(ExpressParser.IntervalLowContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#intervalOp}.
	 * @param ctx the parse tree
	 */
	void enterIntervalOp(ExpressParser.IntervalOpContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#intervalOp}.
	 * @param ctx the parse tree
	 */
	void exitIntervalOp(ExpressParser.IntervalOpContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#inverseAttr}.
	 * @param ctx the parse tree
	 */
	void enterInverseAttr(ExpressParser.InverseAttrContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#inverseAttr}.
	 * @param ctx the parse tree
	 */
	void exitInverseAttr(ExpressParser.InverseAttrContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#inverseClause}.
	 * @param ctx the parse tree
	 */
	void enterInverseClause(ExpressParser.InverseClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#inverseClause}.
	 * @param ctx the parse tree
	 */
	void exitInverseClause(ExpressParser.InverseClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#listType}.
	 * @param ctx the parse tree
	 */
	void enterListType(ExpressParser.ListTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#listType}.
	 * @param ctx the parse tree
	 */
	void exitListType(ExpressParser.ListTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#literal}.
	 * @param ctx the parse tree
	 */
	void enterLiteral(ExpressParser.LiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#literal}.
	 * @param ctx the parse tree
	 */
	void exitLiteral(ExpressParser.LiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#localDecl}.
	 * @param ctx the parse tree
	 */
	void enterLocalDecl(ExpressParser.LocalDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#localDecl}.
	 * @param ctx the parse tree
	 */
	void exitLocalDecl(ExpressParser.LocalDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#localVariable}.
	 * @param ctx the parse tree
	 */
	void enterLocalVariable(ExpressParser.LocalVariableContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#localVariable}.
	 * @param ctx the parse tree
	 */
	void exitLocalVariable(ExpressParser.LocalVariableContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#logicalExpression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalExpression(ExpressParser.LogicalExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#logicalExpression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalExpression(ExpressParser.LogicalExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#logicalLiteral}.
	 * @param ctx the parse tree
	 */
	void enterLogicalLiteral(ExpressParser.LogicalLiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#logicalLiteral}.
	 * @param ctx the parse tree
	 */
	void exitLogicalLiteral(ExpressParser.LogicalLiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#logicalType}.
	 * @param ctx the parse tree
	 */
	void enterLogicalType(ExpressParser.LogicalTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#logicalType}.
	 * @param ctx the parse tree
	 */
	void exitLogicalType(ExpressParser.LogicalTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#multiplicationLikeOp}.
	 * @param ctx the parse tree
	 */
	void enterMultiplicationLikeOp(ExpressParser.MultiplicationLikeOpContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#multiplicationLikeOp}.
	 * @param ctx the parse tree
	 */
	void exitMultiplicationLikeOp(ExpressParser.MultiplicationLikeOpContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#namedTypes}.
	 * @param ctx the parse tree
	 */
	void enterNamedTypes(ExpressParser.NamedTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#namedTypes}.
	 * @param ctx the parse tree
	 */
	void exitNamedTypes(ExpressParser.NamedTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#namedTypeOrRename}.
	 * @param ctx the parse tree
	 */
	void enterNamedTypeOrRename(ExpressParser.NamedTypeOrRenameContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#namedTypeOrRename}.
	 * @param ctx the parse tree
	 */
	void exitNamedTypeOrRename(ExpressParser.NamedTypeOrRenameContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#nullStmt}.
	 * @param ctx the parse tree
	 */
	void enterNullStmt(ExpressParser.NullStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#nullStmt}.
	 * @param ctx the parse tree
	 */
	void exitNullStmt(ExpressParser.NullStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#numberType}.
	 * @param ctx the parse tree
	 */
	void enterNumberType(ExpressParser.NumberTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#numberType}.
	 * @param ctx the parse tree
	 */
	void exitNumberType(ExpressParser.NumberTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#numericExpression}.
	 * @param ctx the parse tree
	 */
	void enterNumericExpression(ExpressParser.NumericExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#numericExpression}.
	 * @param ctx the parse tree
	 */
	void exitNumericExpression(ExpressParser.NumericExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#oneOf}.
	 * @param ctx the parse tree
	 */
	void enterOneOf(ExpressParser.OneOfContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#oneOf}.
	 * @param ctx the parse tree
	 */
	void exitOneOf(ExpressParser.OneOfContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#parameter}.
	 * @param ctx the parse tree
	 */
	void enterParameter(ExpressParser.ParameterContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#parameter}.
	 * @param ctx the parse tree
	 */
	void exitParameter(ExpressParser.ParameterContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#parameterId}.
	 * @param ctx the parse tree
	 */
	void enterParameterId(ExpressParser.ParameterIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#parameterId}.
	 * @param ctx the parse tree
	 */
	void exitParameterId(ExpressParser.ParameterIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#parameterType}.
	 * @param ctx the parse tree
	 */
	void enterParameterType(ExpressParser.ParameterTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#parameterType}.
	 * @param ctx the parse tree
	 */
	void exitParameterType(ExpressParser.ParameterTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#population}.
	 * @param ctx the parse tree
	 */
	void enterPopulation(ExpressParser.PopulationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#population}.
	 * @param ctx the parse tree
	 */
	void exitPopulation(ExpressParser.PopulationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#precisionSpec}.
	 * @param ctx the parse tree
	 */
	void enterPrecisionSpec(ExpressParser.PrecisionSpecContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#precisionSpec}.
	 * @param ctx the parse tree
	 */
	void exitPrecisionSpec(ExpressParser.PrecisionSpecContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#primary}.
	 * @param ctx the parse tree
	 */
	void enterPrimary(ExpressParser.PrimaryContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#primary}.
	 * @param ctx the parse tree
	 */
	void exitPrimary(ExpressParser.PrimaryContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#procedureCallStmt}.
	 * @param ctx the parse tree
	 */
	void enterProcedureCallStmt(ExpressParser.ProcedureCallStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#procedureCallStmt}.
	 * @param ctx the parse tree
	 */
	void exitProcedureCallStmt(ExpressParser.ProcedureCallStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#procedureDecl}.
	 * @param ctx the parse tree
	 */
	void enterProcedureDecl(ExpressParser.ProcedureDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#procedureDecl}.
	 * @param ctx the parse tree
	 */
	void exitProcedureDecl(ExpressParser.ProcedureDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#procedureHead}.
	 * @param ctx the parse tree
	 */
	void enterProcedureHead(ExpressParser.ProcedureHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#procedureHead}.
	 * @param ctx the parse tree
	 */
	void exitProcedureHead(ExpressParser.ProcedureHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#procedureId}.
	 * @param ctx the parse tree
	 */
	void enterProcedureId(ExpressParser.ProcedureIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#procedureId}.
	 * @param ctx the parse tree
	 */
	void exitProcedureId(ExpressParser.ProcedureIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#qualifiableFactor}.
	 * @param ctx the parse tree
	 */
	void enterQualifiableFactor(ExpressParser.QualifiableFactorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#qualifiableFactor}.
	 * @param ctx the parse tree
	 */
	void exitQualifiableFactor(ExpressParser.QualifiableFactorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#qualifiedAttribute}.
	 * @param ctx the parse tree
	 */
	void enterQualifiedAttribute(ExpressParser.QualifiedAttributeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#qualifiedAttribute}.
	 * @param ctx the parse tree
	 */
	void exitQualifiedAttribute(ExpressParser.QualifiedAttributeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#qualifier}.
	 * @param ctx the parse tree
	 */
	void enterQualifier(ExpressParser.QualifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#qualifier}.
	 * @param ctx the parse tree
	 */
	void exitQualifier(ExpressParser.QualifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#queryExpression}.
	 * @param ctx the parse tree
	 */
	void enterQueryExpression(ExpressParser.QueryExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#queryExpression}.
	 * @param ctx the parse tree
	 */
	void exitQueryExpression(ExpressParser.QueryExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#realType}.
	 * @param ctx the parse tree
	 */
	void enterRealType(ExpressParser.RealTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#realType}.
	 * @param ctx the parse tree
	 */
	void exitRealType(ExpressParser.RealTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#redeclaredAttribute}.
	 * @param ctx the parse tree
	 */
	void enterRedeclaredAttribute(ExpressParser.RedeclaredAttributeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#redeclaredAttribute}.
	 * @param ctx the parse tree
	 */
	void exitRedeclaredAttribute(ExpressParser.RedeclaredAttributeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#referencedAttribute}.
	 * @param ctx the parse tree
	 */
	void enterReferencedAttribute(ExpressParser.ReferencedAttributeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#referencedAttribute}.
	 * @param ctx the parse tree
	 */
	void exitReferencedAttribute(ExpressParser.ReferencedAttributeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#referenceClause}.
	 * @param ctx the parse tree
	 */
	void enterReferenceClause(ExpressParser.ReferenceClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#referenceClause}.
	 * @param ctx the parse tree
	 */
	void exitReferenceClause(ExpressParser.ReferenceClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#relOp}.
	 * @param ctx the parse tree
	 */
	void enterRelOp(ExpressParser.RelOpContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#relOp}.
	 * @param ctx the parse tree
	 */
	void exitRelOp(ExpressParser.RelOpContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#relOpExtended}.
	 * @param ctx the parse tree
	 */
	void enterRelOpExtended(ExpressParser.RelOpExtendedContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#relOpExtended}.
	 * @param ctx the parse tree
	 */
	void exitRelOpExtended(ExpressParser.RelOpExtendedContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#renameId}.
	 * @param ctx the parse tree
	 */
	void enterRenameId(ExpressParser.RenameIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#renameId}.
	 * @param ctx the parse tree
	 */
	void exitRenameId(ExpressParser.RenameIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#repeatControl}.
	 * @param ctx the parse tree
	 */
	void enterRepeatControl(ExpressParser.RepeatControlContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#repeatControl}.
	 * @param ctx the parse tree
	 */
	void exitRepeatControl(ExpressParser.RepeatControlContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#repeatStmt}.
	 * @param ctx the parse tree
	 */
	void enterRepeatStmt(ExpressParser.RepeatStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#repeatStmt}.
	 * @param ctx the parse tree
	 */
	void exitRepeatStmt(ExpressParser.RepeatStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#repetition}.
	 * @param ctx the parse tree
	 */
	void enterRepetition(ExpressParser.RepetitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#repetition}.
	 * @param ctx the parse tree
	 */
	void exitRepetition(ExpressParser.RepetitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#resourceOrRename}.
	 * @param ctx the parse tree
	 */
	void enterResourceOrRename(ExpressParser.ResourceOrRenameContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#resourceOrRename}.
	 * @param ctx the parse tree
	 */
	void exitResourceOrRename(ExpressParser.ResourceOrRenameContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#resourceRef}.
	 * @param ctx the parse tree
	 */
	void enterResourceRef(ExpressParser.ResourceRefContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#resourceRef}.
	 * @param ctx the parse tree
	 */
	void exitResourceRef(ExpressParser.ResourceRefContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#returnStmt}.
	 * @param ctx the parse tree
	 */
	void enterReturnStmt(ExpressParser.ReturnStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#returnStmt}.
	 * @param ctx the parse tree
	 */
	void exitReturnStmt(ExpressParser.ReturnStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleDecl}.
	 * @param ctx the parse tree
	 */
	void enterRuleDecl(ExpressParser.RuleDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleDecl}.
	 * @param ctx the parse tree
	 */
	void exitRuleDecl(ExpressParser.RuleDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleHead}.
	 * @param ctx the parse tree
	 */
	void enterRuleHead(ExpressParser.RuleHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleHead}.
	 * @param ctx the parse tree
	 */
	void exitRuleHead(ExpressParser.RuleHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleId}.
	 * @param ctx the parse tree
	 */
	void enterRuleId(ExpressParser.RuleIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleId}.
	 * @param ctx the parse tree
	 */
	void exitRuleId(ExpressParser.RuleIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#ruleLabelId}.
	 * @param ctx the parse tree
	 */
	void enterRuleLabelId(ExpressParser.RuleLabelIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#ruleLabelId}.
	 * @param ctx the parse tree
	 */
	void exitRuleLabelId(ExpressParser.RuleLabelIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#schemaBody}.
	 * @param ctx the parse tree
	 */
	void enterSchemaBody(ExpressParser.SchemaBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#schemaBody}.
	 * @param ctx the parse tree
	 */
	void exitSchemaBody(ExpressParser.SchemaBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#schemaDecl}.
	 * @param ctx the parse tree
	 */
	void enterSchemaDecl(ExpressParser.SchemaDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#schemaDecl}.
	 * @param ctx the parse tree
	 */
	void exitSchemaDecl(ExpressParser.SchemaDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#schemaId}.
	 * @param ctx the parse tree
	 */
	void enterSchemaId(ExpressParser.SchemaIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#schemaId}.
	 * @param ctx the parse tree
	 */
	void exitSchemaId(ExpressParser.SchemaIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#schemaVersionId}.
	 * @param ctx the parse tree
	 */
	void enterSchemaVersionId(ExpressParser.SchemaVersionIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#schemaVersionId}.
	 * @param ctx the parse tree
	 */
	void exitSchemaVersionId(ExpressParser.SchemaVersionIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#selector}.
	 * @param ctx the parse tree
	 */
	void enterSelector(ExpressParser.SelectorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#selector}.
	 * @param ctx the parse tree
	 */
	void exitSelector(ExpressParser.SelectorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#selectExtension}.
	 * @param ctx the parse tree
	 */
	void enterSelectExtension(ExpressParser.SelectExtensionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#selectExtension}.
	 * @param ctx the parse tree
	 */
	void exitSelectExtension(ExpressParser.SelectExtensionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#selectList}.
	 * @param ctx the parse tree
	 */
	void enterSelectList(ExpressParser.SelectListContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#selectList}.
	 * @param ctx the parse tree
	 */
	void exitSelectList(ExpressParser.SelectListContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#selectType}.
	 * @param ctx the parse tree
	 */
	void enterSelectType(ExpressParser.SelectTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#selectType}.
	 * @param ctx the parse tree
	 */
	void exitSelectType(ExpressParser.SelectTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#setType}.
	 * @param ctx the parse tree
	 */
	void enterSetType(ExpressParser.SetTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#setType}.
	 * @param ctx the parse tree
	 */
	void exitSetType(ExpressParser.SetTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#simpleExpression}.
	 * @param ctx the parse tree
	 */
	void enterSimpleExpression(ExpressParser.SimpleExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#simpleExpression}.
	 * @param ctx the parse tree
	 */
	void exitSimpleExpression(ExpressParser.SimpleExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#simpleFactor}.
	 * @param ctx the parse tree
	 */
	void enterSimpleFactor(ExpressParser.SimpleFactorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#simpleFactor}.
	 * @param ctx the parse tree
	 */
	void exitSimpleFactor(ExpressParser.SimpleFactorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#simpleTypes}.
	 * @param ctx the parse tree
	 */
	void enterSimpleTypes(ExpressParser.SimpleTypesContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#simpleTypes}.
	 * @param ctx the parse tree
	 */
	void exitSimpleTypes(ExpressParser.SimpleTypesContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#skipStmt}.
	 * @param ctx the parse tree
	 */
	void enterSkipStmt(ExpressParser.SkipStmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#skipStmt}.
	 * @param ctx the parse tree
	 */
	void exitSkipStmt(ExpressParser.SkipStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterStmt(ExpressParser.StmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitStmt(ExpressParser.StmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#stringLiteral}.
	 * @param ctx the parse tree
	 */
	void enterStringLiteral(ExpressParser.StringLiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#stringLiteral}.
	 * @param ctx the parse tree
	 */
	void exitStringLiteral(ExpressParser.StringLiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#stringType}.
	 * @param ctx the parse tree
	 */
	void enterStringType(ExpressParser.StringTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#stringType}.
	 * @param ctx the parse tree
	 */
	void exitStringType(ExpressParser.StringTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subsuper}.
	 * @param ctx the parse tree
	 */
	void enterSubsuper(ExpressParser.SubsuperContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subsuper}.
	 * @param ctx the parse tree
	 */
	void exitSubsuper(ExpressParser.SubsuperContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraint}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraint(ExpressParser.SubtypeConstraintContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraint}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraint(ExpressParser.SubtypeConstraintContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraintBody}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraintBody(ExpressParser.SubtypeConstraintBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraintBody}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraintBody(ExpressParser.SubtypeConstraintBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraintDecl}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraintDecl(ExpressParser.SubtypeConstraintDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraintDecl}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraintDecl(ExpressParser.SubtypeConstraintDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraintHead}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraintHead(ExpressParser.SubtypeConstraintHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraintHead}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraintHead(ExpressParser.SubtypeConstraintHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeConstraintId}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeConstraintId(ExpressParser.SubtypeConstraintIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeConstraintId}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeConstraintId(ExpressParser.SubtypeConstraintIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#subtypeDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterSubtypeDeclaration(ExpressParser.SubtypeDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#subtypeDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitSubtypeDeclaration(ExpressParser.SubtypeDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#supertypeConstraint}.
	 * @param ctx the parse tree
	 */
	void enterSupertypeConstraint(ExpressParser.SupertypeConstraintContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#supertypeConstraint}.
	 * @param ctx the parse tree
	 */
	void exitSupertypeConstraint(ExpressParser.SupertypeConstraintContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#supertypeExpression}.
	 * @param ctx the parse tree
	 */
	void enterSupertypeExpression(ExpressParser.SupertypeExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#supertypeExpression}.
	 * @param ctx the parse tree
	 */
	void exitSupertypeExpression(ExpressParser.SupertypeExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#supertypeFactor}.
	 * @param ctx the parse tree
	 */
	void enterSupertypeFactor(ExpressParser.SupertypeFactorContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#supertypeFactor}.
	 * @param ctx the parse tree
	 */
	void exitSupertypeFactor(ExpressParser.SupertypeFactorContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#supertypeRule}.
	 * @param ctx the parse tree
	 */
	void enterSupertypeRule(ExpressParser.SupertypeRuleContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#supertypeRule}.
	 * @param ctx the parse tree
	 */
	void exitSupertypeRule(ExpressParser.SupertypeRuleContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#supertypeTerm}.
	 * @param ctx the parse tree
	 */
	void enterSupertypeTerm(ExpressParser.SupertypeTermContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#supertypeTerm}.
	 * @param ctx the parse tree
	 */
	void exitSupertypeTerm(ExpressParser.SupertypeTermContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#syntax}.
	 * @param ctx the parse tree
	 */
	void enterSyntax(ExpressParser.SyntaxContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#syntax}.
	 * @param ctx the parse tree
	 */
	void exitSyntax(ExpressParser.SyntaxContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#term}.
	 * @param ctx the parse tree
	 */
	void enterTerm(ExpressParser.TermContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#term}.
	 * @param ctx the parse tree
	 */
	void exitTerm(ExpressParser.TermContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#totalOver}.
	 * @param ctx the parse tree
	 */
	void enterTotalOver(ExpressParser.TotalOverContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#totalOver}.
	 * @param ctx the parse tree
	 */
	void exitTotalOver(ExpressParser.TotalOverContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeDecl}.
	 * @param ctx the parse tree
	 */
	void enterTypeDecl(ExpressParser.TypeDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeDecl}.
	 * @param ctx the parse tree
	 */
	void exitTypeDecl(ExpressParser.TypeDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeId}.
	 * @param ctx the parse tree
	 */
	void enterTypeId(ExpressParser.TypeIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeId}.
	 * @param ctx the parse tree
	 */
	void exitTypeId(ExpressParser.TypeIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeLabel}.
	 * @param ctx the parse tree
	 */
	void enterTypeLabel(ExpressParser.TypeLabelContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeLabel}.
	 * @param ctx the parse tree
	 */
	void exitTypeLabel(ExpressParser.TypeLabelContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#typeLabelId}.
	 * @param ctx the parse tree
	 */
	void enterTypeLabelId(ExpressParser.TypeLabelIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#typeLabelId}.
	 * @param ctx the parse tree
	 */
	void exitTypeLabelId(ExpressParser.TypeLabelIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#unaryOp}.
	 * @param ctx the parse tree
	 */
	void enterUnaryOp(ExpressParser.UnaryOpContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#unaryOp}.
	 * @param ctx the parse tree
	 */
	void exitUnaryOp(ExpressParser.UnaryOpContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#underlyingType}.
	 * @param ctx the parse tree
	 */
	void enterUnderlyingType(ExpressParser.UnderlyingTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#underlyingType}.
	 * @param ctx the parse tree
	 */
	void exitUnderlyingType(ExpressParser.UnderlyingTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#uniqueClause}.
	 * @param ctx the parse tree
	 */
	void enterUniqueClause(ExpressParser.UniqueClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#uniqueClause}.
	 * @param ctx the parse tree
	 */
	void exitUniqueClause(ExpressParser.UniqueClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#uniqueRule}.
	 * @param ctx the parse tree
	 */
	void enterUniqueRule(ExpressParser.UniqueRuleContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#uniqueRule}.
	 * @param ctx the parse tree
	 */
	void exitUniqueRule(ExpressParser.UniqueRuleContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#untilControl}.
	 * @param ctx the parse tree
	 */
	void enterUntilControl(ExpressParser.UntilControlContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#untilControl}.
	 * @param ctx the parse tree
	 */
	void exitUntilControl(ExpressParser.UntilControlContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#useClause}.
	 * @param ctx the parse tree
	 */
	void enterUseClause(ExpressParser.UseClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#useClause}.
	 * @param ctx the parse tree
	 */
	void exitUseClause(ExpressParser.UseClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#variableId}.
	 * @param ctx the parse tree
	 */
	void enterVariableId(ExpressParser.VariableIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#variableId}.
	 * @param ctx the parse tree
	 */
	void exitVariableId(ExpressParser.VariableIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#whereClause}.
	 * @param ctx the parse tree
	 */
	void enterWhereClause(ExpressParser.WhereClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#whereClause}.
	 * @param ctx the parse tree
	 */
	void exitWhereClause(ExpressParser.WhereClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#whileControl}.
	 * @param ctx the parse tree
	 */
	void enterWhileControl(ExpressParser.WhileControlContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#whileControl}.
	 * @param ctx the parse tree
	 */
	void exitWhileControl(ExpressParser.WhileControlContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#width}.
	 * @param ctx the parse tree
	 */
	void enterWidth(ExpressParser.WidthContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#width}.
	 * @param ctx the parse tree
	 */
	void exitWidth(ExpressParser.WidthContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExpressParser#widthSpec}.
	 * @param ctx the parse tree
	 */
	void enterWidthSpec(ExpressParser.WidthSpecContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExpressParser#widthSpec}.
	 * @param ctx the parse tree
	 */
	void exitWidthSpec(ExpressParser.WidthSpecContext ctx);
}