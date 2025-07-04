require "parslet"
require_relative "error"

module Expressir
  module Express
    class Parser
      class Parser < Parslet::Parser
        root(:syntax)

        def cts(atom)
          spaces >> atom
        end

        def cstr(atom)
          cts(str(atom).as(:str))
        end

        KEYWORDS = %i[
          ABS ABSTRACT ACOS AGGREGATE ALIAS AND ANDOR ARRAY AS ASIN ATAN BAG BASED_ON
          BEGIN BINARY BLENGTH BOOLEAN BY CASE CONSTANT CONST_E COS DERIVE DIV ELSE
          END END_ALIAS END_CASE END_CONSTANT END_ENTITY END_FUNCTION END_IF
          END_LOCAL END_PROCEDURE END_REPEAT END_RULE END_SCHEMA
          END_SUBTYPE_CONSTRAINT END_TYPE ENTITY ENUMERATION ESCAPE EXISTS EXP
          EXTENSIBLE FALSE FIXED FOR FORMAT FROM FUNCTION GENERIC GENERIC_ENTITY
          HIBOUND HIINDEX IF IN INSERT INTEGER INVERSE LENGTH LIKE LIST LOBOUND LOCAL
          LOG LOG10 LOG2 LOGICAL LOINDEX MOD NOT NUMBER NVL ODD OF ONEOF OPTIONAL OR
          OTHERWISE PI PROCEDURE QUERY REAL REFERENCE REMOVE RENAMED REPEAT RETURN
          ROLESOF RULE SCHEMA SELECT SELF SET SIN SIZEOF SKIP SQRT STRING SUBTYPE
          SUBTYPE_CONSTRAINT SUPERTYPE TAN THEN TO TRUE TYPE TYPEOF TOTAL_OVER UNIQUE
          UNKNOWN UNTIL USE USEDIN VALUE VALUE_IN VALUE_UNIQUE VAR WITH WHERE WHILE
          XOR
        ].freeze

        def keyword_rule(str)
          key_chars = str.to_s.chars
          key_chars
            .collect! { |char| match("[#{char}#{char.downcase}]") }
            .reduce(:>>) >> match["a-zA-Z0-9_"].absent?
        end

        KEYWORDS.each do |keyword|
          sym = :"t#{keyword}"
          rule(sym) { cts(keyword_rule(keyword).as(:str)).as(sym) }
        end

        rule(:abstractEntityDeclaration) do
          tABSTRACT.as(:abstractEntityDeclaration)
        end
        rule(:abstractSupertypeDeclaration) do
          (tABSTRACT >> tSUPERTYPE >> subtypeConstraint.maybe).as(:abstractSupertypeDeclaration)
        end
        rule(:abstractSupertype) do
          (tABSTRACT >> tSUPERTYPE >> op_delim).as(:abstractSupertype)
        end
        rule(:actualParameterList) do
          (op_leftparen >> (parameter >> (op_comma >> parameter).repeat).as(:listOf_parameter).maybe >> op_rightparen)
            .as(:actualParameterList)
        end
        rule(:addLikeOp) { (op_plus | op_minus | tOR | tXOR).as(:addLikeOp) }
        rule(:aggregateInitializer) do
          (op_leftbracket >> (element >> (op_comma >> element).repeat).as(:listOf_element).maybe >> op_rightbracket)
            .as(:aggregateInitializer)
        end
        rule(:aggregateSource) { simpleExpression.as(:aggregateSource) }
        rule(:aggregateType) do
          (tAGGREGATE >> (op_colon >> typeLabel).maybe >> tOF >> parameterType).as(:aggregateType)
        end
        rule(:aggregationTypes) do
          (arrayType | bagType | listType | setType).as(:aggregationTypes)
        end
        rule(:algorithmHead) do
          (declaration.repeat.as(:declaration) >> constantDecl.maybe >> localDecl.maybe).as(:algorithmHead)
        end
        rule(:aliasStmt) do
          (tALIAS >> variableId >> tFOR >> generalRef >> qualifier.repeat.as(:qualifier) >>
           op_delim >> stmt.repeat(1).as(:stmt) >> tEND_ALIAS >> op_delim.as(:op_delim2)).as(:aliasStmt)
        end
        rule(:anyKeyword) { KEYWORDS.map { |kw| send("t#{kw}") }.inject(:|) }
        rule(:arrayType) do
          (tARRAY >> boundSpec >> tOF >> tOPTIONAL.maybe >> tUNIQUE.maybe >> instantiableType).as(:arrayType)
        end
        rule(:assignmentStmt) do
          (generalRef >> qualifier.repeat.as(:qualifier) >> op_decl >> expression >> op_delim).as(:assignmentStmt)
        end
        rule(:attributeDecl) do
          (attributeId | redeclaredAttribute).as(:attributeDecl)
        end
        rule(:attributeId) { simpleId.as(:attributeId) }
        rule(:attributeQualifier) do
          (op_period >> attributeRef).as(:attributeQualifier)
        end
        rule(:attributeRef) { attributeId.as(:attributeRef) }
        rule(:bagType) do
          (tBAG >> boundSpec.maybe >> tOF >> instantiableType).as(:bagType)
        end
        rule(:binaryLiteral) do
          cts((str("%") >> bit.repeat(1)).as(:str)).as(:binaryLiteral)
        end
        rule(:binaryType) { (tBINARY >> widthSpec.maybe).as(:binaryType) }
        rule(:bit) { match["0-1"] }
        rule(:booleanType) { tBOOLEAN.as(:booleanType) }
        rule(:bound1) { numericExpression.as(:bound1) }
        rule(:bound2) { numericExpression.as(:bound2) }
        rule(:boundSpec) do
          (op_leftbracket >> bound1 >> op_colon >> bound2 >> op_rightbracket).as(:boundSpec)
        end
        rule(:builtInConstant) do
          (tCONST_E | tPI | tSELF | op_question_mark).as(:builtInConstant)
        end
        rule(:builtInFunction) do
          (tABS | tACOS | tASIN | tATAN | tBLENGTH | tCOS | tEXISTS | tEXP | tFORMAT | tHIBOUND | tHIINDEX | tLENGTH |
           tLOBOUND | tLOINDEX | tLOG2 | tLOG10 | tLOG | tNVL | tODD | tROLESOF | tSIN | tSIZEOF | tSQRT | tTAN |
           tTYPEOF | tUSEDIN | tVALUE_IN | tVALUE_UNIQUE | tVALUE).as(:builtInFunction)
        end
        rule(:builtInProcedure) { (tINSERT | tREMOVE).as(:builtInProcedure) }
        rule(:caseAction) do
          ((caseLabel >> (op_comma >> caseLabel).repeat).as(:listOf_caseLabel) >> op_colon >> stmt).as(:caseAction)
        end
        rule(:caseLabel) { expression.as(:caseLabel) }
        rule(:caseStmt) do
          (tCASE >> selector >> tOF >> caseAction.repeat.as(:caseAction) >> (tOTHERWISE >> op_colon >> stmt).maybe >> tEND_CASE >> op_delim).as(:caseStmt)
        end
        rule(:compoundStmt) do
          (tBEGIN >> stmt.repeat(1).as(:stmt) >> tEND >> op_delim).as(:compoundStmt)
        end
        rule(:concreteTypes) do
          (aggregationTypes | simpleTypes | typeRef).as(:concreteTypes)
        end
        rule(:constantBody) do
          (constantId >> op_colon >> instantiableType >> op_decl >> expression >> op_delim).as(:constantBody)
        end
        rule(:constantDecl) do
          (tCONSTANT >> constantBody.repeat(1).as(:constantBody) >> tEND_CONSTANT >> op_delim).as(:constantDecl)
        end
        rule(:constantFactor) do
          (builtInConstant | constantRef).as(:constantFactor)
        end
        rule(:constantId) { simpleId.as(:constantId) }
        rule(:constantRef) { constantId.as(:constantRef) }
        rule(:constructedTypes) do
          (enumerationType | selectType).as(:constructedTypes)
        end
        rule(:declaration) do
          (entityDecl | functionDecl | procedureDecl | subtypeConstraintDecl | typeDecl).as(:declaration)
        end
        rule(:delim) { cts(str(";").as(:delim)) }
        rule(:deriveClause) do
          (tDERIVE >> derivedAttr.repeat(1).as(:derivedAttr)).as(:deriveClause)
        end
        rule(:derivedAttr) do
          (attributeDecl >> op_colon >> parameterType >> op_decl >> expression >> op_delim).as(:derivedAttr)
        end
        rule(:digit) { match["0-9"] }
        rule(:digits) { (digit >> digit.repeat) }
        rule(:domainRule) do
          ((ruleLabelId >> op_colon).maybe >> expression).as(:domainRule)
        end
        rule(:element) do
          (expression >> (op_colon >> repetition).maybe).as(:element)
        end
        rule(:embeddedRemark) do
          (str("(*") >> (str("*)").absent? >> (embeddedRemark | any)).repeat >> str("*)")).as(:embeddedRemark)
        end
        rule(:encodedCharacter) { (octet >> octet >> octet >> octet) }
        rule(:encodedStringLiteral) do
          cts((str('"') >> encodedCharacter.repeat(1) >> str('"')).as(:str)).as(:encodedStringLiteral)
        end
        rule(:entityBody) do
          (explicitAttr.repeat.as(:explicitAttr) >> deriveClause.maybe >> inverseClause.maybe >> uniqueClause.maybe >> whereClause.maybe).as(:entityBody)
        end
        rule(:entityConstructor) do
          (entityRef >> op_leftparen >> (expression >> (op_comma >> expression).repeat).as(:listOf_expression).maybe >> op_rightparen).as(:entityConstructor)
        end
        rule(:entityDecl) do
          (entityHead >> entityBody >> tEND_ENTITY >> op_delim).as(:entityDecl)
        end
        rule(:entityHead) do
          (tENTITY >> entityId >> subsuper >> op_delim).as(:entityHead)
        end
        rule(:entityId) { simpleId.as(:entityId) }
        rule(:entityRef) { entityId.as(:entityRef) }
        rule(:enumerationExtension) do
          (tBASED_ON >> typeRef >> (tWITH >> enumerationItems).maybe).as(:enumerationExtension)
        end
        rule(:enumerationId) { simpleId.as(:enumerationId) }
        rule(:enumerationItem) { enumerationId.as(:enumerationItem) }
        rule(:enumerationItems) do
          (op_leftparen >> (enumerationItem >> (op_comma >> enumerationItem).repeat).as(:listOf_enumerationItem) >> op_rightparen).as(:enumerationItems)
        end
        rule(:enumerationRef) { enumerationId.as(:enumerationRef) }
        rule(:enumerationReference) do
          ((typeRef >> op_period).maybe >> enumerationRef).as(:enumerationReference)
        end
        rule(:enumerationType) do
          (tEXTENSIBLE.maybe >> tENUMERATION >> ((tOF >> enumerationItems) | enumerationExtension).maybe).as(:enumerationType)
        end
        rule(:escapeStmt) { (tESCAPE >> op_delim).as(:escapeStmt) }
        rule(:explicitAttr) do
          ((attributeDecl >> (op_comma >> attributeDecl).repeat).as(:listOf_attributeDecl) >> op_colon >>
           tOPTIONAL.maybe >> parameterType >> op_delim).as(:explicitAttr)
        end
        rule(:expression) do
          (simpleExpression >> (relOpExtended >> simpleExpression.as(:rhs)).maybe).as(:expression)
        end
        rule(:factor) do
          (simpleFactor >> (op_double_asterisk >> simpleFactor.as(:rhs)).maybe).as(:factor)
        end
        rule(:formalParameter) do
          ((parameterId >> (op_comma >> parameterId).repeat).as(:listOf_parameterId) >> op_colon >> parameterType).as(:formalParameter)
        end
        rule(:functionCall) do
          ((builtInFunction | functionRef) >> actualParameterList.maybe).as(:functionCall)
        end
        rule(:functionDecl) do
          (functionHead >> algorithmHead >> stmt.repeat(1).as(:stmt) >> tEND_FUNCTION >> op_delim).as(:functionDecl)
        end
        rule(:functionHead) do
          (tFUNCTION >> functionId >>
           (op_leftparen >> (formalParameter >> (op_delim >> formalParameter).repeat).as(:listOf_formalParameter) >> op_rightparen).maybe >>
           op_colon >> parameterType >> op_delim.as(:op_delim2)).as(:functionHead)
        end
        rule(:functionId) { simpleId.as(:functionId) }
        rule(:functionRef) { functionId.as(:functionRef) }
        rule(:generalAggregationTypes) do
          (generalArrayType | generalBagType | generalListType | generalSetType).as(:generalAggregationTypes)
        end
        rule(:generalArrayType) do
          (tARRAY >> boundSpec.maybe >> tOF >> tOPTIONAL.maybe >> tUNIQUE.maybe >> parameterType).as(:generalArrayType)
        end
        rule(:generalBagType) do
          (tBAG >> boundSpec.maybe >> tOF >> parameterType).as(:generalBagType)
        end
        rule(:generalizedTypes) do
          (aggregateType | generalAggregationTypes | genericEntityType | genericType).as(:generalizedTypes)
        end
        rule(:generalListType) do
          (tLIST >> boundSpec.maybe >> tOF >> tUNIQUE.maybe >> parameterType).as(:generalListType)
        end
        rule(:generalRef) { (parameterRef | variableId).as(:generalRef) }
        rule(:generalSetType) do
          (tSET >> boundSpec.maybe >> tOF >> parameterType).as(:generalSetType)
        end
        rule(:genericEntityType) do
          (tGENERIC_ENTITY >> (op_colon >> typeLabel).maybe).as(:genericEntityType)
        end
        rule(:genericType) do
          (tGENERIC >> (op_colon >> typeLabel).maybe).as(:genericType)
        end
        rule(:groupQualifier) do
          (op_double_backslash >> entityRef).as(:groupQualifier)
        end
        rule(:hexDigit) { match["0-9a-fA-F"] }
        rule(:ifStmtElseStatements) do
          stmt.repeat(1).as(:stmt).as(:ifStmtElseStatements)
        end
        rule(:ifStmtStatements) do
          stmt.repeat(1).as(:stmt).as(:ifStmtStatements)
        end
        rule(:ifStmt) do
          (tIF >> logicalExpression >> tTHEN >> ifStmtStatements >> (tELSE >> ifStmtElseStatements).maybe >> tEND_IF >> op_delim).as(:ifStmt)
        end
        rule(:incrementControl) do
          (variableId >> op_decl >> bound1 >> tTO >> bound2 >> (tBY >> increment).maybe).as(:incrementControl)
        end
        rule(:increment) { numericExpression.as(:increment) }
        rule(:index1) { index.as(:index1) }
        rule(:index2) { index.as(:index2) }
        rule(:index) { numericExpression.as(:index) }
        rule(:indexQualifier) do
          (op_leftbracket >> index1 >> (op_colon >> index2).maybe >> op_rightbracket).as(:indexQualifier)
        end
        rule(:instantiableType) do
          (concreteTypes | entityRef).as(:instantiableType)
        end
        rule(:integerLiteral) { cts(digits.as(:str)).as(:integerLiteral) }
        rule(:integerType) { tINTEGER.as(:integerType) }
        rule(:interfaceSpecification) do
          (referenceClause | useClause).as(:interfaceSpecification)
        end
        rule(:intervalHigh) { simpleExpression.as(:intervalHigh) }
        rule(:intervalItem) { simpleExpression.as(:intervalItem) }
        rule(:intervalLow) { simpleExpression.as(:intervalLow) }
        rule(:interval) do
          (op_left_curly_brace >> intervalLow >> intervalOp >> intervalItem >> intervalOp.as(:intervalOp2) >>
           intervalHigh >> op_right_curly_brace).as(:interval)
        end
        rule(:intervalOp) { (op_less_equal | op_less_than).as(:intervalOp) }
        rule(:inverseAttr) do
          (attributeDecl >> op_colon >> inverseAttrType >> tFOR >> (entityRef >> op_period).maybe >> attributeRef >> op_delim).as(:inverseAttr)
        end
        rule(:inverseAttrType) do
          (((tSET | tBAG) >> boundSpec.maybe >> tOF).maybe >> entityRef).as(:inverseAttrType)
        end
        rule(:inverseClause) do
          (tINVERSE >> inverseAttr.repeat(1).as(:inverseAttr)).as(:inverseClause)
        end
        rule(:letter) { match["a-zA-Z"] }
        rule(:listType) do
          (tLIST >> boundSpec.maybe >> tOF >> tUNIQUE.maybe >> instantiableType).as(:listType)
        end
        rule(:literal) do
          (binaryLiteral | logicalLiteral | realLiteral | integerLiteral | stringLiteral).as(:literal)
        end
        rule(:localDecl) do
          (tLOCAL >> localVariable.repeat(1).as(:localVariable) >> tEND_LOCAL >> op_delim).as(:localDecl)
        end
        rule(:localVariable) do
          ((variableId >> (op_comma >> variableId).repeat).as(:listOf_variableId) >>
           op_colon >> parameterType >>
           (op_decl >> expression).maybe >> op_delim).as(:localVariable)
        end
        rule(:logicalExpression) { expression.as(:logicalExpression) }
        rule(:logicalLiteral) do
          (tFALSE | tTRUE | tUNKNOWN).as(:logicalLiteral)
        end
        rule(:logicalType) { tLOGICAL.as(:logicalType) }
        rule(:multiplicationLikeOp) do
          (op_asterisk | op_slash | tDIV | tMOD | tAND | op_double_pipe).as(:multiplicationLikeOp)
        end
        rule(:namedTypeOrRename) do
          (namedTypes >> (tAS >> (entityId | typeId)).maybe).as(:namedTypeOrRename)
        end
        rule(:namedTypes) { (entityRef | typeRef).as(:namedTypes) }
        rule(:nullStmt) { op_delim.as(:nullStmt) }
        rule(:numberType) { tNUMBER.as(:numberType) }
        rule(:numericExpression) { simpleExpression.as(:numericExpression) }
        rule(:octet) { hexDigit >> hexDigit }
        rule(:oneOf) do
          (tONEOF >> op_leftparen >> (supertypeExpression >>
                                      (op_comma >> supertypeExpression).repeat).as(:listOf_supertypeExpression) >> op_rightparen).as(:oneOf)
        end
        rule(:op_asterisk) { cstr("*").as(:op_asterisk) }
        rule(:op_colon) { cstr(":").as(:op_colon) }
        rule(:op_colon_equals_colon) { cstr(":=:").as(:op_colon_equals_colon) }
        rule(:op_colon_less_greater_colon) do
          cstr(":<>:").as(:op_colon_less_greater_colon)
        end
        rule(:op_comma) { cstr(",").as(:op_comma) }
        rule(:op_decl) { cstr(":=").as(:op_decl) }
        rule(:op_delim) { cstr(";").as(:op_delim) }
        rule(:op_double_asterisk) { cstr("**").as(:op_double_asterisk) }
        rule(:op_double_backslash) { cstr("\\").as(:op_double_backslash) }
        rule(:op_double_pipe) { cstr("||").as(:op_double_pipe) }
        rule(:op_equals) { cstr("=").as(:op_equals) }
        rule(:op_greater_equal) { cstr(">=").as(:op_greater_equal) }
        rule(:op_greater_than) { cstr(">").as(:op_greater_than) }
        rule(:op_leftbracket) { cstr("[").as(:op_leftbracket) }
        rule(:op_left_curly_brace) { cstr("{").as(:op_left_curly_brace) }
        rule(:op_leftparen) { cstr("(").as(:op_leftparen) }
        rule(:op_less_equal) { cstr("<=").as(:op_less_equal) }
        rule(:op_less_greater) { cstr("<>").as(:op_less_greater) }
        rule(:op_less_than) { cstr("<").as(:op_less_than) }
        rule(:op_minus) { cstr("-").as(:op_minus) }
        rule(:op_period) { cstr(".").as(:op_period) }
        rule(:op_pipe) { cstr("|").as(:op_pipe) }
        rule(:op_plus) { cstr("+").as(:op_plus) }
        rule(:op_query_begin) { cstr("<*").as(:op_query_begin) }
        rule(:op_query_end) { cstr("*>").as(:op_query_end) }
        rule(:op_question_mark) { cstr("?").as(:op_question_mark) }
        rule(:op_rightbracket) { cstr("]").as(:op_rightbracket) }
        rule(:op_right_curly_brace) { cstr("}").as(:op_right_curly_brace) }
        rule(:op_rightparen) { cstr(")").as(:op_rightparen) }
        rule(:op_slash) { cstr("/").as(:op_slash) }
        rule(:parameter) { expression.as(:parameter) }
        rule(:parameterId) { simpleId.as(:parameterId) }
        rule(:parameterRef) { parameterId.as(:parameterRef) }
        rule(:parameterType) do
          (generalizedTypes | namedTypes | simpleTypes).as(:parameterType)
        end
        rule(:population) { entityRef.as(:population) }
        rule(:precisionSpec) { numericExpression.as(:precisionSpec) }
        rule(:primary) do
          (literal | (qualifiableFactor >> qualifier.repeat.as(:qualifier))).as(:primary)
        end
        rule(:procedureCallStmt) do
          ((builtInProcedure | procedureRef) >> actualParameterList.maybe >> op_delim).as(:procedureCallStmt)
        end
        rule(:procedureDecl) do
          (procedureHead >> algorithmHead >> stmt.repeat.as(:stmt) >> tEND_PROCEDURE >> op_delim).as(:procedureDecl)
        end
        rule(:procedureHeadParameter) do
          (tVAR.maybe >> formalParameter).as(:procedureHeadParameter)
        end
        rule(:procedureHead) do
          (tPROCEDURE >> procedureId >>
           (op_leftparen >> (procedureHeadParameter >>
                             (op_delim >> procedureHeadParameter).repeat).as(:listOf_procedureHeadParameter) >> op_rightparen).maybe >> op_delim.as(:op_delim2)).as(:procedureHead)
        end
        rule(:procedureId) { simpleId.as(:procedureId) }
        rule(:procedureRef) { procedureId.as(:procedureRef) }
        rule(:qualifiableFactor) do
          (functionCall | attributeRef | constantFactor | generalRef | population).as(:qualifiableFactor)
        end
        rule(:qualifiedAttribute) do
          (tSELF >> groupQualifier >> attributeQualifier).as(:qualifiedAttribute)
        end
        rule(:qualifier) do
          (attributeQualifier | groupQualifier | indexQualifier).as(:qualifier)
        end
        rule(:queryExpression) do
          (tQUERY >> op_leftparen >> variableId >> op_query_begin >> aggregateSource >> op_pipe >> logicalExpression >> op_rightparen).as(:queryExpression)
        end
        rule(:realLiteral) do
          cts((digits >> str(".") >> digits.maybe >> (match["eE"] >> sign.maybe >> digits).maybe).as(:str)).as(:realLiteral)
        end
        rule(:realType) do
          (tREAL >> (op_leftparen >> precisionSpec >> op_rightparen).maybe).as(:realType)
        end
        rule(:redeclaredAttribute) do
          (qualifiedAttribute >> (tRENAMED >> attributeId).maybe).as(:redeclaredAttribute)
        end
        rule(:referenceClause) do
          (tREFERENCE >> tFROM >> schemaRef >>
           (op_leftparen >> (resourceOrRename >> (op_comma >> resourceOrRename).repeat).as(:listOf_resourceOrRename) >> op_rightparen).maybe >> op_delim).as(:referenceClause)
        end
        rule(:referencedAttribute) do
          (attributeRef | qualifiedAttribute).as(:referencedAttribute)
        end
        rule(:relOpExtended) { (relOp | tIN | tLIKE).as(:relOpExtended) }
        rule(:relOp) do
          (op_less_equal | op_greater_equal | op_less_greater | op_less_than | op_greater_than | op_equals |
           op_colon_less_greater_colon | op_colon_equals_colon).as(:relOp)
        end
        rule(:renameId) do
          (constantId | entityId | functionId | procedureId | typeId).as(:renameId)
        end
        rule(:repeatControl) do
          (incrementControl.maybe >> whileControl.maybe >> untilControl.maybe).as(:repeatControl)
        end
        rule(:repeatStmt) do
          (tREPEAT >> repeatControl >> op_delim >> stmt.repeat(1).as(:stmt) >> tEND_REPEAT >> op_delim.as(:op_delim2)).as(:repeatStmt)
        end
        rule(:repetition) { numericExpression.as(:repetition) }
        rule(:resourceOrRename) do
          (resourceRef >> (tAS >> renameId).maybe).as(:resourceOrRename)
        end
        rule(:resourceRef) do
          (constantRef | entityRef | functionRef | procedureRef | typeRef).as(:resourceRef)
        end
        rule(:returnStmt) do
          (tRETURN >> (op_leftparen >> expression >> op_rightparen).maybe >> op_delim).as(:returnStmt)
        end
        rule(:ruleDecl) do
          (ruleHead >> algorithmHead >> stmt.repeat.as(:stmt) >> whereClause >> tEND_RULE >> op_delim).as(:ruleDecl)
        end
        rule(:ruleHead) do
          (tRULE >> ruleId >> tFOR >> op_leftparen >>
           (entityRef >> (op_comma >> entityRef).repeat).as(:listOf_entityRef) >> op_rightparen >> op_delim).as(:ruleHead)
        end
        rule(:ruleId) { simpleId.as(:ruleId) }
        rule(:ruleLabelId) { simpleId.as(:ruleLabelId) }
        rule(:ruleLabelRef) { ruleLabelId.as(:ruleLabelRef) }
        rule(:ruleRef) { ruleId.as(:ruleRef) }
        rule(:schemaBodyDeclaration) do
          (declaration | ruleDecl).as(:schemaBodyDeclaration)
        end
        rule(:schemaBody) do
          (interfaceSpecification.repeat.as(:interfaceSpecification) >> constantDecl.maybe >>
           schemaBodyDeclaration.repeat.as(:schemaBodyDeclaration)).as(:schemaBody)
        end
        rule(:schemaDecl) do
          (tSCHEMA >> schemaId >> schemaVersionId.maybe >> op_delim >> schemaBody >> tEND_SCHEMA >> op_delim.as(:op_delim2)).as(:schemaDecl)
        end
        rule(:schemaId) { simpleId.as(:schemaId) }
        rule(:schemaRef) { schemaId.as(:schemaRef) }
        rule(:schemaVersionId) { stringLiteral.as(:schemaVersionId) }
        rule(:selectExtension) do
          (tBASED_ON >> typeRef >> (tWITH >> selectList).maybe).as(:selectExtension)
        end
        rule(:selectList) do
          (op_leftparen >> (namedTypes >> (op_comma >> namedTypes).repeat).as(:listOf_namedTypes) >> op_rightparen).as(:selectList)
        end
        rule(:selector) { expression.as(:selector) }
        rule(:selectType) do
          ((tEXTENSIBLE >> tGENERIC_ENTITY.maybe).maybe >> tSELECT >> (selectList | selectExtension).maybe).as(:selectType)
        end
        rule(:setType) do
          (tSET >> boundSpec.maybe >> tOF >> instantiableType).as(:setType)
        end
        rule(:sign) { match["+-"] }
        rule(:simpleExpression) do
          (term >> (addLikeOp.as(:operator) >> term).as(:item).repeat.as(:rhs)).as(:simpleExpression)
        end
        rule(:simpleFactor) do
          (simpleFactorExpression | aggregateInitializer | entityConstructor | interval | queryExpression | stringLiteral |
           simpleFactorUnaryExpression | enumerationReference).as(:simpleFactor)
        end
        rule(:simpleFactorExpression) do
          ((op_leftparen >> expression >> op_rightparen) | primary).as(:simpleFactorExpression)
        end
        rule(:simpleFactorUnaryExpression) do
          (unaryOp >> simpleFactorExpression).as(:simpleFactorUnaryExpression)
        end
        rule(:simpleId) do
          anyKeyword.absent? >> cts((match["a-zA-Z_"] >> match["a-zA-Z0-9_"].repeat).as(:str)).as(:simpleId)
        end
        rule(:simpleStringLiteral) do
          cts((str("'") >> (str("'").absent? >> any).repeat >> str("'")).as(:str)).as(:simpleStringLiteral)
        end
        rule(:simpleTypes) do
          (binaryType | booleanType | integerType | logicalType | numberType | realType | stringType).as(:simpleTypes)
        end
        rule(:skipStmt) { (tSKIP >> op_delim).as(:skipStmt) }
        rule(:space) { match[" \r\n\t\f"] | embeddedRemark | tailRemark }
        rule(:spaces) { space.repeat.as(:spaces) }
        rule(:stmt) do
          (aliasStmt | assignmentStmt | caseStmt | compoundStmt | escapeStmt | ifStmt |
           nullStmt | procedureCallStmt | repeatStmt | returnStmt | skipStmt).as(:stmt)
        end
        rule(:stringLiteral) do
          (simpleStringLiteral | encodedStringLiteral).as(:stringLiteral)
        end
        rule(:stringType) { (tSTRING >> widthSpec.maybe).as(:stringType) }
        rule(:subsuper) do
          (supertypeConstraint.maybe >> subtypeDeclaration.maybe).as(:subsuper)
        end
        rule(:subtypeConstraintBody) do
          (abstractSupertype.maybe >> totalOver.maybe >> (supertypeExpression >> op_delim).maybe).as(:subtypeConstraintBody)
        end
        rule(:subtypeConstraintDecl) do
          (subtypeConstraintHead >> subtypeConstraintBody >> tEND_SUBTYPE_CONSTRAINT >> op_delim).as(:subtypeConstraintDecl)
        end
        rule(:subtypeConstraintHead) do
          (tSUBTYPE_CONSTRAINT >> subtypeConstraintId >> tFOR >> entityRef >> op_delim).as(:subtypeConstraintHead)
        end
        rule(:subtypeConstraintId) { simpleId.as(:subtypeConstraintId) }
        rule(:subtypeConstraintRef) do
          subtypeConstraintId.as(:subtypeConstraintRef)
        end
        rule(:subtypeConstraint) do
          (tOF >> op_leftparen >> supertypeExpression >> op_rightparen).as(:subtypeConstraint)
        end
        rule(:subtypeDeclaration) do
          (tSUBTYPE >> tOF >> op_leftparen >> entityRef >> (op_comma >> entityRef).repeat >> op_rightparen).as(:listOf_entityRef).as(:subtypeDeclaration)
        end
        rule(:supertypeConstraint) do
          (abstractSupertypeDeclaration | abstractEntityDeclaration | supertypeRule).as(:supertypeConstraint)
        end
        rule(:supertypeExpression) do
          (supertypeFactor >> (tANDOR.as(:operator) >> supertypeFactor).as(:item).repeat.as(:rhs)).as(:supertypeExpression)
        end
        rule(:supertypeFactor) do
          (supertypeTerm >> (tAND.as(:operator) >> supertypeTerm).as(:item).repeat.as(:rhs)).as(:supertypeFactor)
        end
        rule(:supertypeRule) do
          (tSUPERTYPE >> subtypeConstraint).as(:supertypeRule)
        end
        rule(:supertypeTerm) do
          (entityRef | oneOf | (op_leftparen >> supertypeExpression >> op_rightparen)).as(:supertypeTerm)
        end
        rule(:syntax) do
          (spaces.as(:spaces) >> schemaDecl.repeat(1).as(:schemaDecl) >> spaces.as(:trailer)).as(:syntax)
        end
        rule(:tailRemark) do
          (str("--") >> (str("\n").absent? >> any).repeat >> str("\n").maybe).as(:tailRemark)
        end
        rule(:term) do
          (factor >> (multiplicationLikeOp >> factor).as(:item).repeat.as(:rhs)).as(:term)
        end
        rule(:totalOver) do
          (tTOTAL_OVER >> op_leftparen >> (entityRef >> (op_comma >> entityRef).repeat).as(:listOf_entityRef) >> op_rightparen >> op_delim).as(:totalOver)
        end
        rule(:typeDecl) do
          (tTYPE >> typeId >> op_equals >> underlyingType >> op_delim >> whereClause.maybe >> tEND_TYPE >> op_delim.as(:op_delim2)).as(:typeDecl)
        end
        rule(:typeId) { simpleId.as(:typeId) }
        rule(:typeLabelId) { simpleId.as(:typeLabelId) }
        rule(:typeLabelRef) { typeLabelId.as(:typeLabelRef) }
        rule(:typeLabel) { (typeLabelId | typeLabelRef).as(:typeLabel) }
        rule(:typeRef) { typeId.as(:typeRef) }
        rule(:unaryOp) { (op_plus | op_minus | tNOT).as(:unaryOp) }
        rule(:underlyingType) do
          (concreteTypes | constructedTypes).as(:underlyingType)
        end
        rule(:uniqueClause) do
          (tUNIQUE >> (uniqueRule >> op_delim >> (uniqueRule >> op_delim.as(:op_delim2)).repeat).as(:listOf_uniqueRule)).as(:uniqueClause)
        end
        rule(:uniqueRule) do
          ((ruleLabelId >> op_colon).maybe >> (referencedAttribute >> (op_comma >> referencedAttribute).repeat).as(:listOf_referencedAttribute)).as(:uniqueRule)
        end
        rule(:untilControl) { (tUNTIL >> logicalExpression).as(:untilControl) }
        rule(:useClause) do
          (tUSE >> tFROM >> schemaRef >>
           (op_leftparen >> (namedTypeOrRename >> (op_comma >>
                                                   namedTypeOrRename).repeat).as(:listOf_namedTypeOrRename) >> op_rightparen).maybe >> op_delim).as(:useClause)
        end
        rule(:variableId) { simpleId.as(:variableId) }
        rule(:variableRef) { variableId.as(:variableRef) }
        rule(:whereClause) do
          (tWHERE >> (domainRule >> op_delim).repeat.as(:listOf_domainRule)).as(:whereClause)
        end
        rule(:whileControl) { (tWHILE >> logicalExpression).as(:whileControl) }
        rule(:width) { numericExpression.as(:width) }
        rule(:widthSpec) do
          (op_leftparen >> width >> op_rightparen >> tFIXED.maybe).as(:widthSpec)
        end
      end

      # Parses Express file into an Express model
      # @param [String] file Express file path
      # @param [Boolean] skip_references skip resolving references
      # @param [Boolean] include_source attach original source code to model elements
      # @return [Model::Repository]
      # @raise [SchemaParseFailure] if the schema file fails to parse
      def self.from_file(file, skip_references: nil, include_source: nil, root_path: nil) # rubocop:disable Metrics/AbcSize
        Expressir::Benchmark.measure_file(file) do
          source = File.read file

          # remove root path from file path
          schema_file = root_path ? Pathname.new(file.to_s).relative_path_from(root_path).to_s : file.to_s

          begin
            ast = Parser.new.parse source
          rescue Parslet::ParseFailed => e
            # Instead of just printing, raise a proper error with file context
            raise Error::SchemaParseFailure.new(schema_file, e)
          end

          visitor = Expressir::Express::Visitor.new(source,
                                                    include_source: include_source)
          @repository = visitor.visit_ast ast, :top

          @repository.schemas.each do |schema|
            schema.file = schema_file
            schema.file_basename = File.basename(schema_file, ".exp")
            schema.formatted = schema.to_s(no_remarks: true)
          end

          unless skip_references
            Expressir::Benchmark.measure_references do
              @resolve_references_model_visitor = ResolveReferencesModelVisitor.new
              @resolve_references_model_visitor.visit(@repository)
            end
          end

          @repository
        end
      end

      # Parses Express files into an Express model
      # @param [Array<String>] files Express file paths
      # @param [Boolean] skip_references skip resolving references
      # @param [Boolean] include_source attach original source code to model elements
      # @yield [filename, schemas, error] Optional block called for each file processed
      # @yieldparam filename [String] Name of the file being processed
      # @yieldparam schemas [Array, nil] Array of parsed schemas (nil if parsing failed)
      # @yieldparam error [Exception, nil] Error that occurred (nil if parsing succeeded)
      # @return [Model::Repository]
      def self.from_files(files, skip_references: nil, include_source: nil,
root_path: nil)
        all_schemas = []

        files.each do |file|
          repository = from_file(file, skip_references: true,
                                       root_path: root_path)
          file_schemas = repository.schemas
          all_schemas.concat(file_schemas)

          # Call the progress block if provided
          yield(file, file_schemas, nil) if block_given?
        rescue StandardError => e
          # Call the progress block with the error if provided
          yield(file, nil, e) if block_given?

          # Re-raise the error if it's not a schema parse failure
          # This allows handling of specific schema parse failures while still propagating other errors
          raise unless e.is_a?(Error::SchemaParseFailure)
        end

        @repository = Model::Repository.new(
          schemas: all_schemas,
        )

        unless skip_references
          Expressir::Benchmark.measure_references do
            @resolve_references_model_visitor = ResolveReferencesModelVisitor.new
            @resolve_references_model_visitor.visit(@repository)
          end
        end

        @repository
      end
    end
  end
end
