// Generated from Express.g4 by ANTLR 4.7.2
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link ExpressParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface ExpressVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link ExpressParser#attributeRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttributeRef(ExpressParser.AttributeRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constantRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstantRef(ExpressParser.ConstantRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityRef(ExpressParser.EntityRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationRef(ExpressParser.EnumerationRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#functionRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionRef(ExpressParser.FunctionRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#parameterRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameterRef(ExpressParser.ParameterRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#procedureRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedureRef(ExpressParser.ProcedureRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleLabelRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleLabelRef(ExpressParser.RuleLabelRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleRef(ExpressParser.RuleRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#schemaRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSchemaRef(ExpressParser.SchemaRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraintRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraintRef(ExpressParser.SubtypeConstraintRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeLabelRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeLabelRef(ExpressParser.TypeLabelRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeRef(ExpressParser.TypeRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#variableRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableRef(ExpressParser.VariableRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#abstractEntityDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAbstractEntityDeclaration(ExpressParser.AbstractEntityDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#abstractSupertype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAbstractSupertype(ExpressParser.AbstractSupertypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#abstractSupertypeDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAbstractSupertypeDeclaration(ExpressParser.AbstractSupertypeDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#actualParameterList}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitActualParameterList(ExpressParser.ActualParameterListContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#addLikeOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAddLikeOp(ExpressParser.AddLikeOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#aggregateInitializer}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAggregateInitializer(ExpressParser.AggregateInitializerContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#aggregateSource}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAggregateSource(ExpressParser.AggregateSourceContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#aggregateType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAggregateType(ExpressParser.AggregateTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#aggregationTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAggregationTypes(ExpressParser.AggregationTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#algorithmHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAlgorithmHead(ExpressParser.AlgorithmHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#aliasStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAliasStmt(ExpressParser.AliasStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#arrayType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArrayType(ExpressParser.ArrayTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#assignmentStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignmentStmt(ExpressParser.AssignmentStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#attributeDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttributeDecl(ExpressParser.AttributeDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#attributeId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttributeId(ExpressParser.AttributeIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#attributeQualifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttributeQualifier(ExpressParser.AttributeQualifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#bagType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBagType(ExpressParser.BagTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#binaryType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinaryType(ExpressParser.BinaryTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#booleanType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBooleanType(ExpressParser.BooleanTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#bound1}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBound1(ExpressParser.Bound1Context ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#bound2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBound2(ExpressParser.Bound2Context ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#boundSpec}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBoundSpec(ExpressParser.BoundSpecContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#builtInConstant}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBuiltInConstant(ExpressParser.BuiltInConstantContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#builtInFunction}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBuiltInFunction(ExpressParser.BuiltInFunctionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#builtInProcedure}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBuiltInProcedure(ExpressParser.BuiltInProcedureContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#caseAction}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCaseAction(ExpressParser.CaseActionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#caseLabel}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCaseLabel(ExpressParser.CaseLabelContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#caseStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCaseStmt(ExpressParser.CaseStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#compoundStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCompoundStmt(ExpressParser.CompoundStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#concreteTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConcreteTypes(ExpressParser.ConcreteTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constantBody}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstantBody(ExpressParser.ConstantBodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constantDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstantDecl(ExpressParser.ConstantDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constantFactor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstantFactor(ExpressParser.ConstantFactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constantId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstantId(ExpressParser.ConstantIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#constructedTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstructedTypes(ExpressParser.ConstructedTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#declaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeclaration(ExpressParser.DeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#derivedAttr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDerivedAttr(ExpressParser.DerivedAttrContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#deriveClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeriveClause(ExpressParser.DeriveClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#domainRule}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDomainRule(ExpressParser.DomainRuleContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#element}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElement(ExpressParser.ElementContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityBody}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityBody(ExpressParser.EntityBodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityConstructor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityConstructor(ExpressParser.EntityConstructorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityDecl(ExpressParser.EntityDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityHead(ExpressParser.EntityHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#entityId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEntityId(ExpressParser.EntityIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationExtension}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationExtension(ExpressParser.EnumerationExtensionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationId(ExpressParser.EnumerationIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationItems}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationItems(ExpressParser.EnumerationItemsContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationReference}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationReference(ExpressParser.EnumerationReferenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#enumerationType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEnumerationType(ExpressParser.EnumerationTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#escapeStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEscapeStmt(ExpressParser.EscapeStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#explicitAttr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExplicitAttr(ExpressParser.ExplicitAttrContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpression(ExpressParser.ExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#factor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFactor(ExpressParser.FactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#formalParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFormalParameter(ExpressParser.FormalParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#functionCall}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionCall(ExpressParser.FunctionCallContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#functionDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionDecl(ExpressParser.FunctionDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#functionHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionHead(ExpressParser.FunctionHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#functionId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionId(ExpressParser.FunctionIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalizedTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralizedTypes(ExpressParser.GeneralizedTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalAggregationTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralAggregationTypes(ExpressParser.GeneralAggregationTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalArrayType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralArrayType(ExpressParser.GeneralArrayTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalBagType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralBagType(ExpressParser.GeneralBagTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalListType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralListType(ExpressParser.GeneralListTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralRef(ExpressParser.GeneralRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#generalSetType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneralSetType(ExpressParser.GeneralSetTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#genericEntityType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGenericEntityType(ExpressParser.GenericEntityTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#genericType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGenericType(ExpressParser.GenericTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#groupQualifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGroupQualifier(ExpressParser.GroupQualifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ifStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfStmt(ExpressParser.IfStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#increment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncrement(ExpressParser.IncrementContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#incrementControl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncrementControl(ExpressParser.IncrementControlContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#index}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndex(ExpressParser.IndexContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#index1}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndex1(ExpressParser.Index1Context ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#index2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndex2(ExpressParser.Index2Context ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#indexQualifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndexQualifier(ExpressParser.IndexQualifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#instantiableType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstantiableType(ExpressParser.InstantiableTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#integerType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntegerType(ExpressParser.IntegerTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#interfaceSpecification}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInterfaceSpecification(ExpressParser.InterfaceSpecificationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#interval}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInterval(ExpressParser.IntervalContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#intervalHigh}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntervalHigh(ExpressParser.IntervalHighContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#intervalItem}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntervalItem(ExpressParser.IntervalItemContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#intervalLow}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntervalLow(ExpressParser.IntervalLowContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#intervalOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntervalOp(ExpressParser.IntervalOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#inverseAttr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInverseAttr(ExpressParser.InverseAttrContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#inverseClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInverseClause(ExpressParser.InverseClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#listType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListType(ExpressParser.ListTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteral(ExpressParser.LiteralContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#localDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLocalDecl(ExpressParser.LocalDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#localVariable}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLocalVariable(ExpressParser.LocalVariableContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#logicalExpression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLogicalExpression(ExpressParser.LogicalExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#logicalLiteral}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLogicalLiteral(ExpressParser.LogicalLiteralContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#logicalType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLogicalType(ExpressParser.LogicalTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#multiplicationLikeOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiplicationLikeOp(ExpressParser.MultiplicationLikeOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#namedTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNamedTypes(ExpressParser.NamedTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#namedTypeOrRename}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNamedTypeOrRename(ExpressParser.NamedTypeOrRenameContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#nullStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNullStmt(ExpressParser.NullStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#numberType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNumberType(ExpressParser.NumberTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#numericExpression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNumericExpression(ExpressParser.NumericExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#oneOf}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOneOf(ExpressParser.OneOfContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#parameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameter(ExpressParser.ParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#parameterId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameterId(ExpressParser.ParameterIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#parameterType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameterType(ExpressParser.ParameterTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#population}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPopulation(ExpressParser.PopulationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#precisionSpec}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrecisionSpec(ExpressParser.PrecisionSpecContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#primary}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrimary(ExpressParser.PrimaryContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#procedureCallStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedureCallStmt(ExpressParser.ProcedureCallStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#procedureDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedureDecl(ExpressParser.ProcedureDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#procedureHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedureHead(ExpressParser.ProcedureHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#procedureId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedureId(ExpressParser.ProcedureIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#qualifiableFactor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQualifiableFactor(ExpressParser.QualifiableFactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#qualifiedAttribute}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQualifiedAttribute(ExpressParser.QualifiedAttributeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#qualifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQualifier(ExpressParser.QualifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#queryExpression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQueryExpression(ExpressParser.QueryExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#realType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRealType(ExpressParser.RealTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#redeclaredAttribute}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRedeclaredAttribute(ExpressParser.RedeclaredAttributeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#referencedAttribute}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReferencedAttribute(ExpressParser.ReferencedAttributeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#referenceClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReferenceClause(ExpressParser.ReferenceClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#relOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRelOp(ExpressParser.RelOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#relOpExtended}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRelOpExtended(ExpressParser.RelOpExtendedContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#renameId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRenameId(ExpressParser.RenameIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#repeatControl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRepeatControl(ExpressParser.RepeatControlContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#repeatStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRepeatStmt(ExpressParser.RepeatStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#repetition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRepetition(ExpressParser.RepetitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#resourceOrRename}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitResourceOrRename(ExpressParser.ResourceOrRenameContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#resourceRef}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitResourceRef(ExpressParser.ResourceRefContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#returnStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturnStmt(ExpressParser.ReturnStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleDecl(ExpressParser.RuleDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleHead(ExpressParser.RuleHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleId(ExpressParser.RuleIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#ruleLabelId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuleLabelId(ExpressParser.RuleLabelIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#schemaBody}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSchemaBody(ExpressParser.SchemaBodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#schemaDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSchemaDecl(ExpressParser.SchemaDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#schemaId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSchemaId(ExpressParser.SchemaIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#schemaVersionId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSchemaVersionId(ExpressParser.SchemaVersionIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#selector}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSelector(ExpressParser.SelectorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#selectExtension}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSelectExtension(ExpressParser.SelectExtensionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#selectList}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSelectList(ExpressParser.SelectListContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#selectType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSelectType(ExpressParser.SelectTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#setType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetType(ExpressParser.SetTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#simpleExpression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSimpleExpression(ExpressParser.SimpleExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#simpleFactor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSimpleFactor(ExpressParser.SimpleFactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#simpleTypes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSimpleTypes(ExpressParser.SimpleTypesContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#skipStmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSkipStmt(ExpressParser.SkipStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStmt(ExpressParser.StmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#stringLiteral}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStringLiteral(ExpressParser.StringLiteralContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#stringType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStringType(ExpressParser.StringTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subsuper}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubsuper(ExpressParser.SubsuperContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraint}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraint(ExpressParser.SubtypeConstraintContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraintBody}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraintBody(ExpressParser.SubtypeConstraintBodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraintDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraintDecl(ExpressParser.SubtypeConstraintDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraintHead}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraintHead(ExpressParser.SubtypeConstraintHeadContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeConstraintId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeConstraintId(ExpressParser.SubtypeConstraintIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#subtypeDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubtypeDeclaration(ExpressParser.SubtypeDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#supertypeConstraint}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSupertypeConstraint(ExpressParser.SupertypeConstraintContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#supertypeExpression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSupertypeExpression(ExpressParser.SupertypeExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#supertypeFactor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSupertypeFactor(ExpressParser.SupertypeFactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#supertypeRule}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSupertypeRule(ExpressParser.SupertypeRuleContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#supertypeTerm}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSupertypeTerm(ExpressParser.SupertypeTermContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#syntax}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSyntax(ExpressParser.SyntaxContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#term}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTerm(ExpressParser.TermContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#totalOver}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTotalOver(ExpressParser.TotalOverContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeDecl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeDecl(ExpressParser.TypeDeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeId(ExpressParser.TypeIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeLabel}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeLabel(ExpressParser.TypeLabelContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#typeLabelId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeLabelId(ExpressParser.TypeLabelIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#unaryOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnaryOp(ExpressParser.UnaryOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#underlyingType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnderlyingType(ExpressParser.UnderlyingTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#uniqueClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUniqueClause(ExpressParser.UniqueClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#uniqueRule}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUniqueRule(ExpressParser.UniqueRuleContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#untilControl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUntilControl(ExpressParser.UntilControlContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#useClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUseClause(ExpressParser.UseClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#variableId}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableId(ExpressParser.VariableIdContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#whereClause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhereClause(ExpressParser.WhereClauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#whileControl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhileControl(ExpressParser.WhileControlContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#width}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWidth(ExpressParser.WidthContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExpressParser#widthSpec}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWidthSpec(ExpressParser.WidthSpecContext ctx);
}