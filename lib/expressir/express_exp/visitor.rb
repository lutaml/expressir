require 'expressir/express_exp/generated/ExpressBaseVisitor'
require 'expressir/model/constant'
require 'expressir/model/derived'
require 'expressir/model/entity'
require 'expressir/model/explicit'
require 'expressir/model/function'
require 'expressir/model/inverse'
require 'expressir/model/local'
require 'expressir/model/parameter'
require 'expressir/model/procedure'
require 'expressir/model/ref'
require 'expressir/model/reference'
require 'expressir/model/renamed_ref'
require 'expressir/model/repository'
require 'expressir/model/rule'
require 'expressir/model/schema'
require 'expressir/model/subtype_constraint'
require 'expressir/model/type'
require 'expressir/model/unique'
require 'expressir/model/use'
require 'expressir/model/where'
require 'expressir/model/expressions/aggregate_element'
require 'expressir/model/expressions/attribute_qualifier'
require 'expressir/model/expressions/entity_constructor'
require 'expressir/model/expressions/expression'
require 'expressir/model/expressions/function_call'
require 'expressir/model/expressions/group_qualifier'
require 'expressir/model/expressions/index_qualifier'
require 'expressir/model/expressions/interval'
require 'expressir/model/expressions/qualified_ref'
require 'expressir/model/expressions/query'
require 'expressir/model/expressions/unknown'
require 'expressir/model/operators/addition'
require 'expressir/model/operators/and'
require 'expressir/model/operators/andor'
require 'expressir/model/operators/combine'
require 'expressir/model/operators/equal'
require 'expressir/model/operators/exponentiation'
require 'expressir/model/operators/greater_than'
require 'expressir/model/operators/greater_than_or_equal'
require 'expressir/model/operators/in'
require 'expressir/model/operators/instance_equal'
require 'expressir/model/operators/instance_not_equal'
require 'expressir/model/operators/integer_division'
require 'expressir/model/operators/less_than'
require 'expressir/model/operators/less_than_or_equal'
require 'expressir/model/operators/like'
require 'expressir/model/operators/modulo'
require 'expressir/model/operators/multiplication'
require 'expressir/model/operators/not'
require 'expressir/model/operators/not_equal'
require 'expressir/model/operators/oneof'
require 'expressir/model/operators/or'
require 'expressir/model/operators/real_division'
require 'expressir/model/operators/subtraction'
require 'expressir/model/operators/unary_plus'
require 'expressir/model/operators/unary_minus'
require 'expressir/model/operators/xor'
require 'expressir/model/statements/alias'
require 'expressir/model/statements/assignment'
require 'expressir/model/statements/case'
require 'expressir/model/statements/case_action'
require 'expressir/model/statements/compound'
require 'expressir/model/statements/escape'
require 'expressir/model/statements/if'
require 'expressir/model/statements/null'
require 'expressir/model/statements/procedure_call'
require 'expressir/model/statements/repeat'
require 'expressir/model/statements/return'
require 'expressir/model/statements/skip'
require 'expressir/model/types/aggregate'
require 'expressir/model/types/array'
require 'expressir/model/types/bag'
require 'expressir/model/types/binary'
require 'expressir/model/types/boolean'
require 'expressir/model/types/enumeration'
require 'expressir/model/types/generic_entity'
require 'expressir/model/types/generic'
require 'expressir/model/types/integer'
require 'expressir/model/types/list'
require 'expressir/model/types/logical'
require 'expressir/model/types/number'
require 'expressir/model/types/real'
require 'expressir/model/types/set'
require 'expressir/model/types/select'
require 'expressir/model/types/string'

# issues:
#
# reference type is not recognized
# see note in A.1.5 Interpreted identifiers
# > It is expected that identifiers matching these syntax rules are known to an implementation.
# > How the implementation obtains this information is of no concern to the definition of the language. One
# > method of gaining this information is multi-pass parsing: the first pass collects the identifiers from their
# > declarations, so that subsequent passes are then able to distinguish a veriable_ref from a function_ref,
# > for example.
#
# - xxxRef - merged to Ref
# - entityConstructor, functionCall, procedureCall
# 
# difference between generalized and instantiable types is not recognized
# see note in 8.6.2 Parameter data types
# > A syntactic construct such as ARRAY[1:3] OF REAL satisfies two syntactic productions —
# > aggregation_type and general_aggregation_type. It is considered to be instantiable no matter which
# > production it is required to satisfy in the syntax.

module Expressir
  module ExpressExp
    class Visitor < Generated::ExpressBaseVisitor
      def visitAttributeRef(ctx)
        id = visit(ctx.attributeId())

        Model::Ref.new({
          id: id
        })
      end

      def visitConstantRef(ctx)
        id = visit(ctx.constantId())

        Model::Ref.new({
          id: id
        })
      end

      def visitEntityRef(ctx)
        id = visit(ctx.entityId())

        Model::Ref.new({
          id: id
        })
      end

      def visitEnumerationRef(ctx)
        id = visit(ctx.enumerationId())

        Model::Ref.new({
          id: id
        })
      end

      def visitFunctionRef(ctx)
        id = visit(ctx.functionId())

        Model::Ref.new({
          id: id
        })
      end

      def visitParameterRef(ctx)
        id = visit(ctx.parameterId())

        Model::Ref.new({
          id: id
        })
      end

      def visitProcedureRef(ctx)
        id = visit(ctx.procedureId())

        Model::Ref.new({
          id: id
        })
      end

      def visitRuleLabelRef(ctx)
        id = visit(ctx.ruleLabelId())

        Model::Ref.new({
          id: id
        })
      end

      def visitRuleRef(ctx)
        id = visit(ctx.ruleId())

        Model::Ref.new({
          id: id
        })
      end

      def visitSchemaRef(ctx)
        id = visit(ctx.schemaId())

        Model::Ref.new({
          id: id
        })
      end

      def visitSubtypeConstraintRef(ctx)
        id = visit(ctx.subtypeConstraintId())

        Model::Ref.new({
          id: id
        })
      end

      def visitTypeLabelRef(ctx)
        id = visit(ctx.typeLabelId())

        Model::Ref.new({
          id: id
        })
      end

      def visitTypeRef(ctx)
        id = visit(ctx.typeId())

        Model::Ref.new({
          id: id
        })
      end

      def visitVariableRef(ctx)
        id = visit(ctx.variableId())

        Model::Ref.new({
          id: id
        })
      end

      def visitAbstractEntityDeclaration(ctx)
        raise 'Invalid state'
      end

      def visitAbstractSupertype(ctx)
        raise 'Invalid state'
      end

      def visitAbstractSupertypeDeclaration(ctx)
        raise 'Invalid state'
      end

      def visitActualParameterList(ctx)
        raise 'Invalid state'
      end

      def visitAddLikeOp(ctx)
        if ctx.text == '+'
          Model::Operators::Addition.new()
        elsif ctx.text == '-'
          Model::Operators::Subtraction.new()
        elsif ctx.OR()
          Model::Operators::Or.new()
        elsif ctx.XOR()
          Model::Operators::Xor.new()
        else
          raise 'Invalid state'
        end
      end

      def visitAggregateInitializer(ctx)
        ctx.element().map{|ctx| visit(ctx)}
      end

      def visitAggregateSource(ctx)
        raise 'Invalid state'
      end

      def visitAggregateType(ctx)
        label = if ctx.typeLabel()
          visit(ctx.typeLabel())
        end
        base_type = visit(ctx.parameterType())

        Model::Types::Aggregate.new({
          label: label,
          base_type: base_type
        })
      end

      def visitAggregationTypes(ctx)
        if ctx.arrayType()
          visit(ctx.arrayType())
        elsif ctx.bagType()
          visit(ctx.bagType())
        elsif ctx.listType()
          visit(ctx.listType())
        elsif ctx.setType()
          visit(ctx.setType())
        else
          raise 'Invalid state'
        end
      end

      def visitAlgorithmHead(ctx)
        raise 'Invalid state'
      end

      def visitAliasStmt(ctx)
        id = visit(ctx.variableId())
        expression = if ctx.qualifier().length > 0
          ref = visit(ctx.generalRef())
          qualifiers = ctx.qualifier().map{|ctx| visit(ctx)}

          Model::Expressions::QualifiedRef.new({
            ref: ref,
            qualifiers: qualifiers
          })
        else
          visit(ctx.generalRef())
        end
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Statements::Alias.new({
          id: id,
          expression: expression,
          statements: statements
        })
      end

      def visitArrayType(ctx)
        bound1 = visit(ctx.boundSpec().bound1().numericExpression().simpleExpression())
        bound2 = visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
        optional = !!ctx.OPTIONAL()
        unique = !!ctx.UNIQUE()
        base_type = visit(ctx.instantiableType())
        
        Model::Types::Array.new({
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type
        })
      end

      def visitAssignmentStmt(ctx)
        expression = visit(ctx.expression())

        ref = if ctx.qualifier().length > 0
          ref = visit(ctx.generalRef())
          qualifiers = ctx.qualifier().map{|ctx| visit(ctx)}

          Model::Expressions::QualifiedRef.new({
            ref: ref,
            qualifiers: qualifiers
          })
        else
          visit(ctx.generalRef())
        end

        Model::Statements::Assignment.new({
          ref: ref,
          expression: expression
        })
      end

      def visitAttributeDecl(ctx)
        if ctx.attributeId()
          visit(ctx.attributeId())
        elsif ctx.redeclaredAttribute()
          visit(ctx.redeclaredAttribute())
        else
          raise 'Invalid state'
        end
      end

      def visitAttributeId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitAttributeQualifier(ctx)
        attribute = visit(ctx.attributeRef())

        Model::Expressions::AttributeQualifier.new({
          attribute: attribute
        })
      end

      def visitBagType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        base_type = visit(ctx.instantiableType())
        
        Model::Types::Bag.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visitBinaryType(ctx)
        width = if ctx.widthSpec()
          visit(ctx.widthSpec().width().numericExpression().simpleExpression())
        end
        fixed = if ctx.widthSpec()
          !!ctx.widthSpec().FIXED()
        end

        Model::Types::Binary.new({
          width: width,
          fixed: fixed
        })
      end

      def visitBooleanType(ctx)
        Model::Types::Boolean.new()
      end

      def visitBound1(ctx)
        raise 'Invalid state'
      end

      def visitBound2(ctx)
        raise 'Invalid state'
      end

      def visitBoundSpec(ctx)
        raise 'Invalid state'
      end

      def visitBuiltInConstant(ctx)
        id = ctx.text

        Model::Ref.new({
          id: id
        })
      end

      def visitBuiltInFunction(ctx)
        id = ctx.text

        Model::Ref.new({
          id: id
        })
      end

      def visitBuiltInProcedure(ctx)
        id = ctx.text

        Model::Ref.new({
          id: id
        })
      end

      def visitCaseAction(ctx)
        labels = ctx.caseLabel().map{|ctx| visit(ctx.expression())}
        statement = visit(ctx.stmt())

        labels.map do |label|
          Model::Statements::CaseAction.new({
            label: label,
            statement: statement
          })
        end
      end

      def visitCaseLabel(ctx)
        raise 'Invalid state'
      end

      def visitCaseStmt(ctx)
        selector = visit(ctx.selector().expression())
        actions = ctx.caseAction().map{|ctx| visit(ctx)}.flatten
        otherwise_statement = if ctx.stmt()
          visit(ctx.stmt())
        end

        Model::Statements::Case.new({
          selector: selector,
          actions: actions,
          otherwise_statement: otherwise_statement
        })
      end

      def visitCompoundStmt(ctx)
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Statements::Compound.new({
          statements: statements
        })
      end

      def visitConcreteTypes(ctx)
        if ctx.aggregationTypes()
          visit(ctx.aggregationTypes())
        elsif ctx.simpleTypes()
          visit(ctx.simpleTypes())
        elsif ctx.typeRef()
          visit(ctx.typeRef())
        else
          raise 'Invalid state'
        end
      end

      def visitConstantBody(ctx)
        id = visit(ctx.constantId())
        type = visit(ctx.instantiableType())
        expression = visit(ctx.expression())

        Model::Constant.new({
          id: id,
          type: type,
          expression: expression
        })
      end

      def visitConstantDecl(ctx)
        raise 'Invalid state'
      end

      def visitConstantFactor(ctx)
        if ctx.builtInConstant()
          visit(ctx.builtInConstant())
        elsif ctx.constantRef()
          visit(ctx.constantRef())
        else
          raise 'Invalid state'
        end
      end

      def visitConstantId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitConstructedTypes(ctx)
        if ctx.enumerationType()
          visit(ctx.enumerationType())
        elsif ctx.selectType()
          visit(ctx.selectType())
        else
          raise 'Invalid state'
        end
      end

      def visitDeclaration(ctx)
        if ctx.entityDecl()
          visit(ctx.entityDecl())
        elsif ctx.functionDecl()
          visit(ctx.functionDecl())
        elsif ctx.procedureDecl()
          visit(ctx.procedureDecl())
        elsif ctx.subtypeConstraintDecl()
          visit(ctx.subtypeConstraintDecl())
        elsif ctx.typeDecl()
          visit(ctx.typeDecl())
        else
          raise 'Invalid state'
        end
      end

      def visitDerivedAttr(ctx)
        id = visit(ctx.attributeDecl())
        type = visit(ctx.parameterType())
        expression = visit(ctx.expression())

        Model::Derived.new({
          id: id,
          type: type,
          expression: expression
        })
      end

      def visitDeriveClause(ctx)
        raise 'Invalid state'
      end

      def visitDomainRule(ctx)
        id = if ctx.ruleLabelId()
          visit(ctx.ruleLabelId())
        end
        expression = visit(ctx.expression())

        Model::Where.new({
          id: id,
          expression: expression
        })
      end

      def visitElement(ctx)
        if ctx.repetition()
          expression = visit(ctx.expression())
          repetition = visit(ctx.repetition().numericExpression().simpleExpression())

          Model::Expressions::AggregateElement.new({
            expression: expression,
            repetition: repetition
          })
        else
          visit(ctx.expression())
        end
      end

      def visitEntityBody(ctx)
        raise 'Invalid state'
      end

      def visitEntityConstructor(ctx)
        entity = visit(ctx.entityRef())
        parameters = ctx.expression().map{|ctx| visit(ctx)}

        Model::Expressions::EntityConstructor.new({
          entity: entity,
          parameters: parameters
        })
      end

      def visitEntityDecl(ctx)
        id = visit(ctx.entityHead().entityId())
        abstract = if ctx.entityHead().subsuper().supertypeConstraint()
          !!ctx.entityHead().subsuper().supertypeConstraint().abstractEntityDeclaration()
        end
        abstract_supertype = if ctx.entityHead().subsuper().supertypeConstraint()
          !!ctx.entityHead().subsuper().supertypeConstraint().abstractSupertypeDeclaration()
        end
        supertypes = if ctx.entityHead().subsuper().subtypeDeclaration()
          ctx.entityHead().subsuper().subtypeDeclaration().entityRef().map{|ctx| visit(ctx)}
        end
        subtype_expression = if ctx.entityHead().subsuper().supertypeConstraint() && ctx.entityHead().subsuper().supertypeConstraint().abstractSupertypeDeclaration() && ctx.entityHead().subsuper().supertypeConstraint().abstractSupertypeDeclaration().subtypeConstraint()
          visit(ctx.entityHead().subsuper().supertypeConstraint().abstractSupertypeDeclaration().subtypeConstraint().supertypeExpression())
        elsif ctx.entityHead().subsuper().supertypeConstraint() && ctx.entityHead().subsuper().supertypeConstraint().supertypeRule()
          visit(ctx.entityHead().subsuper().supertypeConstraint().supertypeRule().subtypeConstraint().supertypeExpression())
        end
        explicit = ctx.entityBody().explicitAttr().map{|ctx| visit(ctx)}.flatten
        derived = if ctx.entityBody().deriveClause()
          ctx.entityBody().deriveClause().derivedAttr().map{|ctx| visit(ctx)}
        end
        inverse = if ctx.entityBody().inverseClause()
          ctx.entityBody().inverseClause().inverseAttr().map{|ctx| visit(ctx)}
        end
        unique = if ctx.entityBody().uniqueClause()
          ctx.entityBody().uniqueClause().uniqueRule().map{|ctx| visit(ctx)}
        end
        where = if ctx.entityBody().whereClause()
          ctx.entityBody().whereClause().domainRule().map{|ctx| visit(ctx)}
        end

        Model::Entity.new({
          id: id,
          abstract: abstract,
          abstract_supertype: abstract_supertype,
          supertypes: supertypes,
          subtype_expression: subtype_expression,
          explicit: explicit,
          derived: derived,
          inverse: inverse,
          unique: unique,
          where: where
        })
      end

      def visitEntityHead(ctx)
        raise 'Invalid state'
      end

      def visitEntityId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitEnumerationExtension(ctx)
        raise 'Invalid state'
      end

      def visitEnumerationId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitEnumerationItems(ctx)
        raise 'Invalid state'
      end

      def visitEnumerationReference(ctx)
        if ctx.typeRef()
          ref = visit(ctx.typeRef())
          attribute = visit(ctx.enumerationRef())
          attribute_qualifier = Model::Expressions::AttributeQualifier.new({
            attribute: attribute
          })
          qualifiers = [attribute_qualifier]
  
          Model::Expressions::QualifiedRef.new({
            ref: ref,
            qualifiers: qualifiers
          })
        else
          visit(ctx.enumerationRef())
        end
      end

      def visitEnumerationType(ctx)
        extensible = !!ctx.EXTENSIBLE()
        list = if ctx.enumerationItems()
          ctx.enumerationItems().enumerationId().map{|ctx| visit(ctx)}
        end
        extension_type = if ctx.enumerationExtension()
          visit(ctx.enumerationExtension().typeRef())
        end
        extension_list = if ctx.enumerationExtension() && ctx.enumerationExtension().enumerationItems()
          ctx.enumerationExtension().enumerationItems().enumerationId().map{|ctx| visit(ctx)}
        end

        Model::Types::Enumeration.new({
          extensible: extensible,
          list: list,
          extension_type: extension_type,
          extension_list: extension_list
        })
      end

      def visitEscapeStmt(ctx)
        Model::Statements::Escape.new()
      end

      def visitExplicitAttr(ctx)
        ids = ctx.attributeDecl().map{|ctx| visit(ctx)}
        optional = !!ctx.OPTIONAL()
        type = visit(ctx.parameterType())

        ids.map do |id|
          Model::Explicit.new({
            id: id,
            optional: optional,
            type: type
          })
        end
      end

      def visitExpression(ctx)
        if ctx.relOpExtended()
          operator = visit(ctx.relOpExtended())
          operands = ctx.simpleExpression().map{|ctx| visit(ctx)}

          Model::Expressions::Expression.new({
            operator: operator,
            operands: operands
          })
        else
          visit(ctx.simpleExpression()[0])
        end
      end

      def visitFactor(ctx)
        if ctx.child_at(1) && ctx.child_at(1).text == '**'
          operator = Model::Operators::Exponentiation.new()
          operands = ctx.simpleFactor().map{|ctx| visit(ctx)}

          Model::Expressions::Expression.new({
            operator: operator,
            operands: operands
          })
        else
          visit(ctx.simpleFactor()[0])
        end
      end

      def visitFormalParameter(ctx)
        ids = ctx.parameterId().map{|ctx| visit(ctx)}
        type = visit(ctx.parameterType())

        ids.map do |id|
          Model::Parameter.new({
            id: id,
            type: type
          })
        end
      end

      def visitFunctionCall(ctx)
        function = if ctx.builtInFunction()
          visit(ctx.builtInFunction())
        elsif ctx.functionRef()
          visit(ctx.functionRef())
        else
          raise 'Invalid state'
        end
        parameters = if ctx.actualParameterList()
          ctx.actualParameterList().parameter().map{|ctx| visit(ctx.expression)}
        end

        Model::Expressions::FunctionCall.new({
          function: function,
          parameters: parameters
        })
      end

      def visitFunctionDecl(ctx)
        id = visit(ctx.functionHead().functionId())
        parameters = ctx.functionHead().formalParameter().map{|ctx| visit(ctx)}.flatten
        return_type = visit(ctx.functionHead().parameterType())
        declarations = ctx.algorithmHead().declaration().map{|ctx| visit(ctx)}
        constants = if ctx.algorithmHead().constantDecl()
          ctx.algorithmHead().constantDecl().constantBody().map{|ctx| visit(ctx)}
        end
        locals = if ctx.algorithmHead().localDecl()
          ctx.algorithmHead().localDecl().localVariable().map{|ctx| visit(ctx)}.flatten
        end
        declarations = ctx.algorithmHead().declaration().map{|ctx| visit(ctx)}
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Function.new({
          id: id,
          parameters: parameters,
          return_type: return_type,
          declarations: declarations,
          constants: constants,
          locals: locals,
          statements: statements
        })
      end

      def visitFunctionHead(ctx)
        raise 'Invalid state'
      end

      def visitFunctionId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitGeneralizedTypes(ctx)
        if ctx.aggregateType()
          visit(ctx.aggregateType())
        elsif ctx.generalAggregationTypes()
          visit(ctx.generalAggregationTypes())
        elsif ctx.genericEntityType()
          visit(ctx.genericEntityType())
        elsif ctx.genericType()
          visit(ctx.genericType())
        else
          raise 'Invalid state'
        end
      end

      def visitGeneralAggregationTypes(ctx)
        if ctx.generalArrayType()
          visit(ctx.generalArrayType())
        elsif ctx.generalBagType()
          visit(ctx.generalBagType())
        elsif ctx.generalListType()
          visit(ctx.generalListType())
        elsif ctx.generalSetType()
          visit(ctx.generalSetType())
        else
          raise 'Invalid state'
        end
      end

      def visitGeneralArrayType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        optional = !!ctx.OPTIONAL()
        unique = !!ctx.UNIQUE()
        base_type = visit(ctx.parameterType())
        
        Model::Types::Array.new({
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type
        })
      end

      def visitGeneralBagType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        base_type = visit(ctx.parameterType())
        
        Model::Types::Bag.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visitGeneralListType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        unique = !!ctx.UNIQUE()
        base_type = visit(ctx.parameterType())
        
        Model::Types::List.new({
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type
        })
      end

      def visitGeneralRef(ctx)
        if ctx.parameterRef()
          visit(ctx.parameterRef())
        elsif ctx.variableId()
          visit(ctx.variableId())
        else
          raise 'Invalid state'
        end
      end

      def visitGeneralSetType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        base_type = visit(ctx.parameterType())
        
        Model::Types::Set.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visitGenericEntityType(ctx)
        label = if ctx.typeLabel()
          visit(ctx.typeLabel())
        end

        Model::Types::GenericEntity.new({
          label: label
        })
      end

      def visitGenericType(ctx)
        label = if ctx.typeLabel()
          visit(ctx.typeLabel())
        end

        Model::Types::Generic.new({
          label: label
        })
      end

      def visitGroupQualifier(ctx)
        entity = visit(ctx.entityRef())

        Model::Expressions::GroupQualifier.new({
          entity: entity
        })
      end

      def visitIfStmt(ctx)
        condition = visit(ctx.logicalExpression().expression())
        else_index = if ctx.ELSE()
          ctx.children.find_index{|x| x == ctx.ELSE()}
        end
        else_statement_index = if else_index
          else_index - ctx.children.find_index{|x| x == ctx.stmt()[0]}
        end
        statements = if else_statement_index
          ctx.stmt()[0..(else_statement_index - 1)].map{|ctx| visit(ctx)}
        else
          ctx.stmt().map{|ctx| visit(ctx)}
        end
        else_statements = if else_statement_index
          ctx.stmt()[else_statement_index..(ctx.stmt().length - 1)].map{|ctx| visit(ctx)}
        end

        Model::Statements::If.new({
          condition: condition,
          statements: statements,
          else_statements: else_statements
        })
      end

      def visitIncrement(ctx)
        raise 'Invalid state'
      end

      def visitIncrementControl(ctx)
        raise 'Invalid state'
      end

      def visitIndex(ctx)
        raise 'Invalid state'
      end

      def visitIndex1(ctx)
        raise 'Invalid state'
      end

      def visitIndex2(ctx)
        raise 'Invalid state'
      end

      def visitIndexQualifier(ctx)
        index1 = visit(ctx.index1().index().numericExpression().simpleExpression())
        index2 = if ctx.index2()
          visit(ctx.index2().index().numericExpression().simpleExpression())
        end

        Model::Expressions::IndexQualifier.new({
          index1: index1,
          index2: index2
        })
      end

      def visitInstantiableType(ctx)
        if ctx.concreteTypes()
          visit(ctx.concreteTypes())
        elsif ctx.entityRef()
          visit(ctx.entityRef())
        else
          raise 'Invalid state'
        end
      end

      def visitIntegerType(ctx)
        Model::Types::Integer.new()
      end

      def visitInterfaceSpecification(ctx)
        if ctx.referenceClause()
          visit(ctx.referenceClause())
        elsif ctx.useClause()
          visit(ctx.useClause())
        else
          raise 'Invalid state'
        end
      end

      def visitInterval(ctx)
        low = visit(ctx.intervalLow().simpleExpression())
        operator1 = visit(ctx.intervalOp()[0])
        item = visit(ctx.intervalItem().simpleExpression())
        operator2 = visit(ctx.intervalOp()[1])
        high = visit(ctx.intervalHigh().simpleExpression())

        Model::Expressions::Interval.new({
          low: low,
          operator1: operator1,
          item: item,
          operator2: operator2,
          high: high
        })
      end

      def visitIntervalHigh(ctx)
        raise 'Invalid state'
      end

      def visitIntervalItem(ctx)
        raise 'Invalid state'
      end

      def visitIntervalLow(ctx)
        raise 'Invalid state'
      end

      def visitIntervalOp(ctx)
        if ctx.text == '<'
          Model::Operators::LessThan.new()
        elsif ctx.text == '<='
          Model::Operators::LessThanOrEqual.new()
        else
          raise 'Invalid state'
        end
      end

      def visitInverseAttr(ctx)
        id = visit(ctx.attributeDecl())
        type = if ctx.SET()
          bound1, bound2 = if ctx.boundSpec()
            [
              visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
              visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
            ]
          end
          base_type = visit(ctx.entityRef()[0])

          Model::Types::Set.new({
            bound1: bound1,
            bound2: bound2,
            base_type: base_type
          })
        elsif ctx.BAG()
          bound1, bound2 = if ctx.boundSpec()
            [
              visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
              visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
            ]
          end
          base_type = visit(ctx.entityRef()[0])

          Model::Types::Bag.new({
            bound1: bound1,
            bound2: bound2,
            base_type: base_type
          })
        else
          visit(ctx.entityRef()[0])
        end
        attribute = if ctx.entityRef()[1]
          ref = visit(ctx.entityRef()[1])
          attribute = visit(ctx.attributeRef())
          attribute_qualifier = Model::Expressions::AttributeQualifier.new({
            attribute: attribute
          })
          qualifiers = [attribute_qualifier]

          Model::Expressions::QualifiedRef.new({
            ref: ref,
            qualifiers: qualifiers
          })
        else
          visit(ctx.attributeRef())
        end

        Model::Inverse.new({
          id: id,
          type: type,
          attribute: attribute
        })
      end

      def visitInverseClause(ctx)
        raise 'Invalid state'
      end

      def visitListType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        unique = !!ctx.UNIQUE()
        base_type = visit(ctx.instantiableType())
        
        Model::Types::List.new({
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type
        })
      end

      def visitLiteral(ctx)
        if ctx.BinaryLiteral()
          handleBinaryLiteral(ctx.BinaryLiteral())
        elsif ctx.IntegerLiteral()
          handleIntegerLiteral(ctx.IntegerLiteral())
        elsif ctx.logicalLiteral()
          visit(ctx.logicalLiteral())
        elsif ctx.RealLiteral()
          handleRealLiteral(ctx.RealLiteral())
        elsif ctx.stringLiteral()
          visit(ctx.stringLiteral())
        else
          raise 'Invalid state'
        end
      end

      def visitLocalDecl(ctx)
        raise 'Invalid state'
      end

      def visitLocalVariable(ctx)
        ids = ctx.variableId().map{|ctx| visit(ctx)}
        type = visit(ctx.parameterType())
        expression = if ctx.expression()
          visit(ctx.expression())
        end

        ids.map do |id|
          Model::Local.new({
            id: id,
            type: type,
            expression: expression
          })
        end
      end

      def visitLogicalExpression(ctx)
        raise 'Invalid state'
      end

      def visitLogicalLiteral(ctx)
        if ctx.TRUE()
          true
        elsif ctx.FALSE()
          false
        elsif ctx.UNKNOWN()
          Model::Expressions::Unknown.new()
        else
          raise 'Invalid state'
        end
      end

      def visitLogicalType(ctx)
        Model::Types::Logical.new()
      end

      def visitMultiplicationLikeOp(ctx)
        if ctx.text == '*'
          Model::Operators::Multiplication.new()
        elsif ctx.text == '/'
          Model::Operators::RealDivision.new()
        elsif ctx.DIV()
          Model::Operators::IntegerDivision.new()
        elsif ctx.MOD()
          Model::Operators::Modulo.new()
        elsif ctx.AND()
          Model::Operators::And.new()
        elsif ctx.text == '||'
          Model::Operators::Combine.new()
        else
          raise 'Invalid state'
        end
      end

      def visitNamedTypes(ctx)
        if ctx.entityRef()
          visit(ctx.entityRef())
        elsif ctx.typeRef()
          visit(ctx.typeRef())
        else
          raise 'Invalid state'
        end
      end

      def visitNamedTypeOrRename(ctx)
        if ctx.entityId() || ctx.typeId()
          ref = visit(ctx.namedTypes())
          id = if ctx.entityId()
            visit(ctx.entityId())
          elsif ctx.typeId()
            visit(ctx.typeId())
          end

          Model::RenamedRef.new({
            ref: ref,
            id: id
          })
        else
          visit(ctx.namedTypes())
        end
      end

      def visitNullStmt(ctx)
        Model::Statements::Null.new()
      end

      def visitNumberType(ctx)
        Model::Types::Number.new()
      end

      def visitNumericExpression(ctx)
        raise 'Invalid state'
      end

      def visitOneOf(ctx)
        operator = Model::Operators::Oneof.new()
        operands = ctx.supertypeExpression().map{|ctx| visit(ctx)}

        Model::Expressions::Expression.new({
          operator: operator,
          operands: operands
        })
      end

      def visitParameter(ctx)
        raise 'Invalid state'
      end

      def visitParameterId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitParameterType(ctx)
        if ctx.generalizedTypes()
          visit(ctx.generalizedTypes())
        elsif ctx.namedTypes()
          visit(ctx.namedTypes())
        elsif ctx.simpleTypes()
          visit(ctx.simpleTypes())
        else
          raise 'Invalid state'
        end
      end

      def visitPopulation(ctx)
        raise 'Invalid state'
      end

      def visitPrecisionSpec(ctx)
        raise 'Invalid state'
      end

      def visitPrimary(ctx)
        if ctx.literal()
          visit(ctx.literal())
        elsif ctx.qualifiableFactor()
          visit(ctx.qualifiableFactor())
        else
          raise 'Invalid state'
        end
      end

      def visitProcedureCallStmt(ctx)
        procedure = if ctx.builtInProcedure()
          visit(ctx.builtInProcedure())
        elsif ctx.procedureRef()
          visit(ctx.procedureRef())
        else
          raise 'Invalid state'
        end
        parameters = if ctx.actualParameterList()
          ctx.actualParameterList().parameter().map{|ctx| visit(ctx.expression)}
        end

        Model::Statements::ProcedureCall.new({
          procedure: procedure,
          parameters: parameters
        })
      end

      def visitProcedureDecl(ctx)
        id = visit(ctx.procedureHead().procedureId())
        parameters = ctx.procedureHead().formalParameter().map do |ctx|
          parameters = visit(ctx)
          parameters_index = ctx.parent.children.find_index{|x| x == ctx}
          var = ctx.parent.child_at(parameters_index - 1)
          if var.text == 'VAR'
            parameters.map do |parameter|
              Model::Parameter.new({
                id: parameter.id,
                type: parameter.type,
                var: true
              })
            end
          else
            parameters
          end
        end.flatten
        declarations = ctx.algorithmHead().declaration().map{|ctx| visit(ctx)}
        constants = if ctx.algorithmHead().constantDecl()
          ctx.algorithmHead().constantDecl().constantBody().map{|ctx| visit(ctx)}
        end
        locals = if ctx.algorithmHead().localDecl()
          ctx.algorithmHead().localDecl().localVariable().map{|ctx| visit(ctx)}.flatten
        end
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Procedure.new({
          id: id,
          parameters: parameters,
          declarations: declarations,
          constants: constants,
          locals: locals,
          statements: statements
        })
      end

      def visitProcedureHead(ctx)
        raise 'Invalid state'
      end

      def visitProcedureId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitQualifiableFactor(ctx)
        if ctx.attributeRef()
          visit(ctx.attributeRef())
        elsif ctx.constantFactor()
          visit(ctx.constantFactor())
        elsif ctx.functionCall()
          visit(ctx.functionCall())
        elsif ctx.generalRef()
          visit(ctx.generalRef())
        elsif ctx.population()
          visit(ctx.population().entityRef())
        else
          raise 'Invalid state'
        end
      end

      def visitQualifiedAttribute(ctx)
        id = ctx.SELF().text

        ref = Model::Ref.new({
          id: id
        })

        group_qualifier = visit(ctx.groupQualifier())
        attribute_qualifier = visit(ctx.attributeQualifier())
        qualifiers = [group_qualifier, attribute_qualifier]

        Model::Expressions::QualifiedRef.new({
          ref: ref,
          qualifiers: qualifiers
        })
      end

      def visitQualifier(ctx)
        if ctx.attributeQualifier()
          visit(ctx.attributeQualifier())
        elsif ctx.groupQualifier()
          visit(ctx.groupQualifier())
        elsif ctx.indexQualifier()
          visit(ctx.indexQualifier())
        else
          raise 'Invalid state'
        end
      end

      def visitQueryExpression(ctx)
        id = visit(ctx.variableId())
        source = visit(ctx.aggregateSource().simpleExpression())
        expression = visit(ctx.logicalExpression().expression())

        Model::Expressions::Query.new({
          id: id,
          source: source,
          expression: expression
        })
      end

      def visitRealType(ctx)
        precision = if ctx.precisionSpec()
          visit(ctx.precisionSpec().numericExpression().simpleExpression())
        end

        Model::Types::Real.new({
          precision: precision
        })
      end

      def visitRedeclaredAttribute(ctx)
        if ctx.attributeId()
          ref = visit(ctx.qualifiedAttribute())
          id = visit(ctx.attributeId())

          Model::RenamedRef.new({
            ref: ref,
            id: id
          })
        else
          visit(ctx.qualifiedAttribute())
        end
      end

      def visitReferencedAttribute(ctx)
        if ctx.attributeRef()
          visit(ctx.attributeRef())
        elsif ctx.qualifiedAttribute()
          visit(ctx.qualifiedAttribute())
        else
          raise 'Invalid state'
        end
      end

      def visitReferenceClause(ctx)
        schema = visit(ctx.schemaRef())
        items = ctx.resourceOrRename().map{|ctx| visit(ctx)}

        Model::Reference.new({
          schema: schema,
          items: items
        })
      end

      def visitRelOp(ctx)
        if ctx.text == '<'
          Model::Operators::LessThan.new()
        elsif ctx.text == '>'
          Model::Operators::GreaterThan.new()
        elsif ctx.text == '<='
          Model::Operators::LessThanOrEqual.new()
        elsif ctx.text == '>='
          Model::Operators::GreaterThanOrEqual.new()
        elsif ctx.text == '<>'
          Model::Operators::NotEqual.new()
        elsif ctx.text == '='
          Model::Operators::Equal.new()
        elsif ctx.text == ':<>:'
          Model::Operators::InstanceNotEqual.new()
        elsif ctx.text == ':=:'
          Model::Operators::InstanceEqual.new()
        else
          raise 'Invalid state'
        end
      end

      def visitRelOpExtended(ctx)
        if ctx.relOp()
          visit(ctx.relOp())
        elsif ctx.IN()
          Model::Operators::In.new()
        elsif ctx.LIKE()
          Model::Operators::Like.new()
        else
          raise 'Invalid state'
        end
      end

      def visitRenameId(ctx)
        if ctx.constantId()
          visit(ctx.constantId())
        elsif ctx.entityId()
          visit(ctx.entityId())
        elsif ctx.functionId()
          visit(ctx.functionId())
        elsif ctx.procedureId()
          visit(ctx.procedureId())
        elsif ctx.typeId()
          visit(ctx.typeId())
        else
          raise 'Invalid state'
        end
      end

      def visitRepeatControl(ctx)
        raise 'Invalid state'
      end

      def visitRepeatStmt(ctx)
        variable = if ctx.repeatControl().incrementControl()
          visit(ctx.repeatControl().incrementControl().variableId())
        end
        bound1, bound2 = if ctx.repeatControl().incrementControl()
          [
            visit(ctx.repeatControl().incrementControl().bound1().numericExpression().simpleExpression()),
            visit(ctx.repeatControl().incrementControl().bound2().numericExpression().simpleExpression())
          ]
        end
        increment = if ctx.repeatControl().incrementControl() && ctx.repeatControl().incrementControl().increment()
          visit(ctx.repeatControl().incrementControl().increment().numericExpression().simpleExpression())
        end
        while_expression = if ctx.repeatControl().whileControl()
          visit(ctx.repeatControl().whileControl().logicalExpression().expression())
        end
        until_expression = if ctx.repeatControl().untilControl()
          visit(ctx.repeatControl().untilControl().logicalExpression().expression())
        end
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Statements::Repeat.new({
          variable: variable,
          bound1: bound1,
          bound2: bound2,
          increment: increment,
          while_expression: while_expression,
          until_expression: until_expression,
          statements: statements
        })
      end

      def visitRepetition(ctx)
        raise 'Invalid state'
      end

      def visitResourceOrRename(ctx)
        if ctx.renameId()
          ref = visit(ctx.resourceRef())
          id = visit(ctx.renameId())

          Model::RenamedRef.new({
            ref: ref,
            id: id
          })
        else
          visit(ctx.resourceRef())
        end
      end

      def visitResourceRef(ctx)
        if ctx.constantRef()
          visit(ctx.constantRef())
        elsif ctx.entityRef()
          visit(ctx.entityRef())
        elsif ctx.functionRef()
          visit(ctx.functionRef())
        elsif ctx.procedureRef()
          visit(ctx.procedureRef())
        elsif ctx.typeRef()
          visit(ctx.typeRef())
        else
          raise 'Invalid state'
        end
      end

      def visitReturnStmt(ctx)
        expression = visit(ctx.expression())

        Model::Statements::Return.new({
          expression: expression
        })
      end

      def visitRuleDecl(ctx)
        id = visit(ctx.ruleHead().ruleId())
        applies_to = ctx.ruleHead().entityRef().map{|ctx| visit(ctx)}
        declarations = ctx.algorithmHead().declaration().map{|ctx| visit(ctx)}
        constants = if ctx.algorithmHead().constantDecl()
          ctx.algorithmHead().constantDecl().constantBody().map{|ctx| visit(ctx)}
        end
        locals = if ctx.algorithmHead().localDecl()
          ctx.algorithmHead().localDecl().localVariable().map{|ctx| visit(ctx)}.flatten
        end
        where = ctx.whereClause().domainRule().map{|ctx| visit(ctx)}
        statements = ctx.stmt().map{|ctx| visit(ctx)}

        Model::Rule.new({
          id: id,
          applies_to: applies_to,
          declarations: declarations,
          constants: constants,
          locals: locals,
          where: where,
          statements: statements
        })
      end

      def visitRuleHead(ctx)
        raise 'Invalid state'
      end

      def visitRuleId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitRuleLabelId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitSchemaBody(ctx)
        raise 'Invalid state'
      end

      def visitSchemaDecl(ctx)
        id = visit(ctx.schemaId())
        version = if ctx.schemaVersionId()
          visit(ctx.schemaVersionId().stringLiteral())
        end
        interfaces = ctx.schemaBody().interfaceSpecification().map{|ctx| visit(ctx)}
        constants = if ctx.schemaBody().constantDecl()
          ctx.schemaBody().constantDecl().constantBody().map{|ctx| visit(ctx)}
        end
        declarations = ctx.schemaBody().declaration().map{|ctx| visit(ctx)}
        rules = ctx.schemaBody().ruleDecl().map{|ctx| visit(ctx)}

        Model::Schema.new({
          id: id,
          version: version,
          interfaces: interfaces,
          constants: constants,
          declarations: declarations,
          rules: rules
        })
      end

      def visitSchemaId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitSchemaVersionId(ctx)
        raise 'Invalid state'
      end

      def visitSelector(ctx)
        raise 'Invalid state'
      end

      def visitSelectExtension(ctx)
        raise 'Invalid state'
      end

      def visitSelectList(ctx)
        raise 'Invalid state'
      end

      def visitSelectType(ctx)
        extensible = !!ctx.EXTENSIBLE()
        generic_entity = !!ctx.GENERIC_ENTITY()
        list = if ctx.selectList()
          ctx.selectList().namedTypes().map{|ctx| visit(ctx)}
        end
        extension_type = if ctx.selectExtension()
          visit(ctx.selectExtension().typeRef())
        end
        extension_list = if ctx.selectExtension() && ctx.selectExtension().selectList()
          ctx.selectExtension().selectList().namedTypes().map{|ctx| visit(ctx)}
        end

        Model::Types::Select.new({
          extensible: extensible,
          generic_entity: generic_entity,
          list: list,
          extension_type: extension_type,
          extension_list: extension_list
        })
      end

      def visitSetType(ctx)
        bound1, bound2 = if ctx.boundSpec()
          [
            visit(ctx.boundSpec().bound1().numericExpression().simpleExpression()),
            visit(ctx.boundSpec().bound2().numericExpression().simpleExpression())
          ]
        end
        base_type = visit(ctx.instantiableType())
        
        Model::Types::Set.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visitSimpleExpression(ctx)
        if ctx.term().length >= 2
          operands = ctx.term().map{|ctx| visit(ctx)}
          operators = ctx.addLikeOp().map{|ctx| visit(ctx)}

          handleBinaryExpression(operands, operators)
        else
          visit(ctx.term()[0])
        end
      end

      def visitSimpleFactor(ctx)
        if ctx.aggregateInitializer()
          visit(ctx.aggregateInitializer())
        elsif ctx.entityConstructor()
          visit(ctx.entityConstructor())
        elsif ctx.enumerationReference()
          visit(ctx.enumerationReference())
        elsif ctx.interval()
          visit(ctx.interval())
        elsif ctx.queryExpression()
          visit(ctx.queryExpression())
        elsif !ctx.unaryOp() && ctx.expression()
          visit(ctx.expression())
        elsif !ctx.unaryOp() && ctx.primary()
          visit(ctx.primary())
        elsif ctx.unaryOp() && ctx.expression()
          operator = visit(ctx.unaryOp())
          operand = visit(ctx.expression())

          Model::Expressions::Expression.new({
            operator: operator,
            operands: [operand]
          })
        elsif ctx.unaryOp() && ctx.primary()
          operator = visit(ctx.unaryOp())
          operand = visit(ctx.primary())

          Model::Expressions::Expression.new({
            operator: operator,
            operands: [operand]
          })
        else
          raise 'Invalid state'
        end
      end

      def visitSimpleTypes(ctx)
        if ctx.binaryType()
          visit(ctx.binaryType())
        elsif ctx.booleanType()
          visit(ctx.booleanType())
        elsif ctx.integerType()
          visit(ctx.integerType())
        elsif ctx.logicalType()
          visit(ctx.logicalType())
        elsif ctx.numberType()
          visit(ctx.numberType())
        elsif ctx.realType()
          visit(ctx.realType())
        elsif ctx.stringType()
          visit(ctx.stringType())
        else
          raise 'Invalid state'
        end
      end

      def visitSkipStmt(ctx)
        Model::Statements::Skip.new()
      end

      def visitStmt(ctx)
        if ctx.aliasStmt()
          visit(ctx.aliasStmt())
        elsif ctx.assignmentStmt()
          visit(ctx.assignmentStmt())
        elsif ctx.caseStmt()
          visit(ctx.caseStmt())
        elsif ctx.compoundStmt()
          visit(ctx.compoundStmt())
        elsif ctx.escapeStmt()
          visit(ctx.escapeStmt())
        elsif ctx.ifStmt()
          visit(ctx.ifStmt())
        elsif ctx.nullStmt()
          visit(ctx.nullStmt())
        elsif ctx.procedureCallStmt()
          visit(ctx.procedureCallStmt())
        elsif ctx.repeatStmt()
          visit(ctx.repeatStmt())
        elsif ctx.returnStmt()
          visit(ctx.returnStmt())
        elsif ctx.skipStmt()
          visit(ctx.skipStmt())
        else
          raise 'Invalid state'
        end
      end

      def visitStringLiteral(ctx)
        if ctx.SimpleStringLiteral()
          handleSimpleStringLiteral(ctx.SimpleStringLiteral())
        elsif ctx.EncodedStringLiteral()
          handleEncodedStringLiteral(ctx.EncodedStringLiteral())
        else
          raise 'Invalid state'
        end
      end

      def visitStringType(ctx)
        width = if ctx.widthSpec()
          visit(ctx.widthSpec().width().numericExpression().simpleExpression())
        end
        fixed = if ctx.widthSpec()
          !!ctx.widthSpec().FIXED()
        end

        Model::Types::String.new({
          width: width,
          fixed: fixed
        })
      end

      def visitSubsuper(ctx)
        raise 'Invalid state'
      end

      def visitSubtypeConstraint(ctx)
        raise 'Invalid state'
      end

      def visitSubtypeConstraintBody(ctx)
        raise 'Invalid state'
      end

      def visitSubtypeConstraintDecl(ctx)
        id = visit(ctx.subtypeConstraintHead().subtypeConstraintId())
        applies_to = visit(ctx.subtypeConstraintHead().entityRef())
        abstract_supertype = !!ctx.subtypeConstraintBody().abstractSupertype()
        total_over = if ctx.subtypeConstraintBody().totalOver()
          ctx.subtypeConstraintBody().totalOver().entityRef().map{|ctx| visit(ctx)}
        end
        subtype_expression = if ctx.subtypeConstraintBody().supertypeExpression()
          visit(ctx.subtypeConstraintBody().supertypeExpression())
        end

        Model::SubtypeConstraint.new({
          id: id,
          applies_to: applies_to,
          abstract_supertype: abstract_supertype,
          total_over: total_over,
          subtype_expression: subtype_expression
        })
      end

      def visitSubtypeConstraintHead(ctx)
        raise 'Invalid state'
      end

      def visitSubtypeConstraintId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitSubtypeDeclaration(ctx)
        raise 'Invalid state'
      end

      def visitSupertypeConstraint(ctx)
        raise 'Invalid state'
      end

      def visitSupertypeExpression(ctx)
        if ctx.supertypeFactor().length >= 2
          operands = ctx.supertypeFactor().map{|ctx| visit(ctx)}
          operators = ctx.ANDOR().map{|ctx| Model::Operators::Andor.new()}

          handleBinaryExpression(operands, operators)
        else
          visit(ctx.supertypeFactor()[0])
        end
      end

      def visitSupertypeFactor(ctx)
        if ctx.supertypeTerm().length >= 2
          operands = ctx.supertypeTerm().map{|ctx| visit(ctx)}
          operators = ctx.AND().map{|ctx| Model::Operators::And.new()}

          handleBinaryExpression(operands, operators)
        else
          visit(ctx.supertypeTerm()[0])
        end
      end

      def visitSupertypeRule(ctx)
        raise 'Invalid state'
      end

      def visitSupertypeTerm(ctx)
        if ctx.entityRef()
          visit(ctx.entityRef())
        elsif ctx.oneOf()
          visit(ctx.oneOf())
        elsif ctx.supertypeExpression()
          visit(ctx.supertypeExpression())
        else
          raise 'Invalid state'
        end
      end

      def visitSyntax(ctx)
        schemas = ctx.schemaDecl().map{|ctx| visit(ctx)}

        Model::Repository.new({
          schemas: schemas
        })
      end

      def visitTerm(ctx)
        if ctx.factor().length >= 2
          operands = ctx.factor().map{|ctx| visit(ctx)}
          operators = ctx.multiplicationLikeOp().map{|ctx| visit(ctx)}

          handleBinaryExpression(operands, operators)
        else
          visit(ctx.factor()[0])
        end
      end

      def visitTotalOver(ctx)
        raise 'Invalid state'
      end

      def visitTypeDecl(ctx)
        id = visit(ctx.typeId())
        type = visit(ctx.underlyingType())
        where = if ctx.whereClause()
          ctx.whereClause().domainRule().map{|ctx| visit(ctx)}
        end

        Model::Type.new({
          id: id,
          type: type,
          where: where
        })
      end

      def visitTypeId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitTypeLabel(ctx)
        if ctx.typeLabelId()
          visit(ctx.typeLabelId())
        elsif ctx.typeLabelRef()
          visit(ctx.typeLabelRef())
        else
          raise 'Invalid state'
        end
      end

      def visitTypeLabelId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitUnaryOp(ctx)
        if ctx.text == '+'
          Model::Operators::UnaryPlus.new()
        elsif ctx.text == '-'
          Model::Operators::UnaryMinus.new()
        elsif ctx.NOT()
          Model::Operators::Not.new()
        else
          raise 'Invalid state'
        end
      end

      def visitUnderlyingType(ctx)
        if ctx.concreteTypes()
          visit(ctx.concreteTypes())
        elsif ctx.constructedTypes()
          visit(ctx.constructedTypes())
        else
          raise 'Invalid state'
        end
      end

      def visitUniqueClause(ctx)
        raise 'Invalid state'
      end

      def visitUniqueRule(ctx)
        id = if ctx.ruleLabelId()
          visit(ctx.ruleLabelId())
        end
        attributes = ctx.referencedAttribute().map{|ctx| visit(ctx)}

        Model::Unique.new({
          id: id,
          attributes: attributes
        })
      end

      def visitUntilControl(ctx)
        raise 'Invalid state'
      end

      def visitUseClause(ctx)
        schema = visit(ctx.schemaRef())
        items = ctx.namedTypeOrRename().map{|ctx| visit(ctx)}

        Model::Use.new({
          schema: schema,
          items: items
        })
      end

      def visitVariableId(ctx)
        handleSimpleId(ctx.SimpleId())
      end

      def visitWhereClause(ctx)
        raise 'Invalid state'
      end

      def visitWhileControl(ctx)
        raise 'Invalid state'
      end

      def visitWidth(ctx)
        raise 'Invalid state'
      end

      def visitWidthSpec(ctx)
        raise 'Invalid state'
      end

      def handleBinaryExpression(operands, operators)
        if operands.length != operators.length + 1
          raise 'Invalid state'
        end

        expression = Model::Expressions::Expression.new({
          operator: operators[0],
          operands: [operands[0], operands[1]]
        })
        operators[1..(operators.length - 1)].each_with_index do |operator, i|
          expression = Model::Expressions::Expression.new({
            operator: operator,
            operands: [expression, operands[i + 2]]
          })
        end
        expression
      end

      def handleBinaryLiteral(ctx)
        bin = ctx.text[1..(ctx.text.length - 1)]
        [bin].pack('B*')
      end

      def handleIntegerLiteral(ctx)
        ctx.text.to_i
      end

      def handleRealLiteral(ctx)
        ctx.text.to_f
      end

      def handleSimpleId(ctx)
        ctx.text
      end

      def handleSimpleStringLiteral(ctx)
        ctx.text[1..(ctx.text.length - 2)]
      end

      def handleEncodedStringLiteral(ctx)
        hex = ctx.text[1..(ctx.text.length - 2)]
        str = [hex].pack('H*')
        str.force_encoding('UCS-4BE')
        str.encode('ASCII-8BIT')
      end
    end
  end
end