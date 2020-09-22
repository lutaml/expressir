# Generated from ../express-grammar/Express.g4 by ANTLR 4.7.2

require 'antlr4/runtime'

module Expressir
module ExpressExp
module Generated

@@theExpressVisitor = ExpressVisitor.new



class ExpressParser < Antlr4::Runtime::Parser

	class << self
		@@_decisionToDFA = []
	end
	@@_sharedContextCache = Antlr4::Runtime::PredictionContextCache.new()
		T__0=1
		T__1=2
		T__2=3
		T__3=4
		T__4=5
		T__5=6
		T__6=7
		T__7=8
		T__8=9
		T__9=10
		T__10=11
		T__11=12
		T__12=13
		T__13=14
		T__14=15
		T__15=16
		T__16=17
		T__17=18
		T__18=19
		T__19=20
		T__20=21
		T__21=22
		T__22=23
		T__23=24
		T__24=25
		T__25=26
		T__26=27
		T__27=28
		T__28=29
		ABS=30
		ABSTRACT=31
		ACOS=32
		AGGREGATE=33
		ALIAS=34
		AND=35
		ANDOR=36
		ARRAY=37
		AS=38
		ASIN=39
		ATAN=40
		BAG=41
		BASED_ON=42
		BEGIN_=43
		BINARY=44
		BLENGTH=45
		BOOLEAN=46
		BY=47
		CASE=48
		CONSTANT=49
		CONST_E=50
		COS=51
		DERIVE=52
		DIV=53
		ELSE=54
		END_=55
		END_ALIAS=56
		END_CASE=57
		END_CONSTANT=58
		END_ENTITY=59
		END_FUNCTION=60
		END_IF=61
		END_LOCAL=62
		END_PROCEDURE=63
		END_REPEAT=64
		END_RULE=65
		END_SCHEMA=66
		END_SUBTYPE_CONSTRAINT=67
		END_TYPE=68
		ENTITY=69
		ENUMERATION=70
		ESCAPE=71
		EXISTS=72
		EXP=73
		EXTENSIBLE=74
		FALSE=75
		FIXED=76
		FOR=77
		FORMAT=78
		FROM=79
		FUNCTION=80
		GENERIC=81
		GENERIC_ENTITY=82
		HIBOUND=83
		HIINDEX=84
		IF=85
		IN=86
		INSERT=87
		INTEGER=88
		INVERSE=89
		LENGTH=90
		LIKE=91
		LIST=92
		LOBOUND=93
		LOCAL=94
		LOG=95
		LOG10=96
		LOG2=97
		LOGICAL=98
		LOINDEX=99
		MOD=100
		NOT=101
		NUMBER=102
		NVL=103
		ODD=104
		OF=105
		ONEOF=106
		OPTIONAL=107
		OR=108
		OTHERWISE=109
		PI=110
		PROCEDURE=111
		QUERY=112
		REAL=113
		REFERENCE=114
		REMOVE=115
		RENAMED=116
		REPEAT=117
		RETURN=118
		ROLESOF=119
		RULE=120
		SCHEMA=121
		SELECT=122
		SELF=123
		SET=124
		SIN=125
		SIZEOF=126
		SKIP_=127
		SQRT=128
		STRING=129
		SUBTYPE=130
		SUBTYPE_CONSTRAINT=131
		SUPERTYPE=132
		TAN=133
		THEN=134
		TO=135
		TRUE=136
		TYPE=137
		TYPEOF=138
		TOTAL_OVER=139
		UNIQUE=140
		UNKNOWN=141
		UNTIL=142
		USE=143
		USEDIN=144
		VALUE=145
		VALUE_IN=146
		VALUE_UNIQUE=147
		VAR=148
		WITH=149
		WHERE=150
		WHILE=151
		XOR=152
		BinaryLiteral=153
		EncodedStringLiteral=154
		IntegerLiteral=155
		RealLiteral=156
		SimpleId=157
		SimpleStringLiteral=158
		EmbeddedRemark=159
		TailRemark=160
		Whitespace=161
		RULE_attributeRef = 0
		RULE_constantRef = 1
		RULE_entityRef = 2
		RULE_enumerationRef = 3
		RULE_functionRef = 4
		RULE_parameterRef = 5
		RULE_procedureRef = 6
		RULE_ruleLabelRef = 7
		RULE_ruleRef = 8
		RULE_schemaRef = 9
		RULE_subtypeConstraintRef = 10
		RULE_typeLabelRef = 11
		RULE_typeRef = 12
		RULE_variableRef = 13
		RULE_abstractEntityDeclaration = 14
		RULE_abstractSupertype = 15
		RULE_abstractSupertypeDeclaration = 16
		RULE_actualParameterList = 17
		RULE_addLikeOp = 18
		RULE_aggregateInitializer = 19
		RULE_aggregateSource = 20
		RULE_aggregateType = 21
		RULE_aggregationTypes = 22
		RULE_algorithmHead = 23
		RULE_aliasStmt = 24
		RULE_arrayType = 25
		RULE_assignmentStmt = 26
		RULE_attributeDecl = 27
		RULE_attributeId = 28
		RULE_attributeQualifier = 29
		RULE_bagType = 30
		RULE_binaryType = 31
		RULE_booleanType = 32
		RULE_bound1 = 33
		RULE_bound2 = 34
		RULE_boundSpec = 35
		RULE_builtInConstant = 36
		RULE_builtInFunction = 37
		RULE_builtInProcedure = 38
		RULE_caseAction = 39
		RULE_caseLabel = 40
		RULE_caseStmt = 41
		RULE_compoundStmt = 42
		RULE_concreteTypes = 43
		RULE_constantBody = 44
		RULE_constantDecl = 45
		RULE_constantFactor = 46
		RULE_constantId = 47
		RULE_constructedTypes = 48
		RULE_declaration = 49
		RULE_derivedAttr = 50
		RULE_deriveClause = 51
		RULE_domainRule = 52
		RULE_element = 53
		RULE_entityBody = 54
		RULE_entityConstructor = 55
		RULE_entityDecl = 56
		RULE_entityHead = 57
		RULE_entityId = 58
		RULE_enumerationExtension = 59
		RULE_enumerationId = 60
		RULE_enumerationItems = 61
		RULE_enumerationReference = 62
		RULE_enumerationType = 63
		RULE_escapeStmt = 64
		RULE_explicitAttr = 65
		RULE_expression = 66
		RULE_factor = 67
		RULE_formalParameter = 68
		RULE_functionCall = 69
		RULE_functionDecl = 70
		RULE_functionHead = 71
		RULE_functionId = 72
		RULE_generalizedTypes = 73
		RULE_generalAggregationTypes = 74
		RULE_generalArrayType = 75
		RULE_generalBagType = 76
		RULE_generalListType = 77
		RULE_generalRef = 78
		RULE_generalSetType = 79
		RULE_genericEntityType = 80
		RULE_genericType = 81
		RULE_groupQualifier = 82
		RULE_ifStmt = 83
		RULE_increment = 84
		RULE_incrementControl = 85
		RULE_index = 86
		RULE_index1 = 87
		RULE_index2 = 88
		RULE_indexQualifier = 89
		RULE_instantiableType = 90
		RULE_integerType = 91
		RULE_interfaceSpecification = 92
		RULE_interval = 93
		RULE_intervalHigh = 94
		RULE_intervalItem = 95
		RULE_intervalLow = 96
		RULE_intervalOp = 97
		RULE_inverseAttr = 98
		RULE_inverseClause = 99
		RULE_listType = 100
		RULE_literal = 101
		RULE_localDecl = 102
		RULE_localVariable = 103
		RULE_logicalExpression = 104
		RULE_logicalLiteral = 105
		RULE_logicalType = 106
		RULE_multiplicationLikeOp = 107
		RULE_namedTypes = 108
		RULE_namedTypeOrRename = 109
		RULE_nullStmt = 110
		RULE_numberType = 111
		RULE_numericExpression = 112
		RULE_oneOf = 113
		RULE_parameter = 114
		RULE_parameterId = 115
		RULE_parameterType = 116
		RULE_population = 117
		RULE_precisionSpec = 118
		RULE_primary = 119
		RULE_procedureCallStmt = 120
		RULE_procedureDecl = 121
		RULE_procedureHead = 122
		RULE_procedureId = 123
		RULE_qualifiableFactor = 124
		RULE_qualifiedAttribute = 125
		RULE_qualifier = 126
		RULE_queryExpression = 127
		RULE_realType = 128
		RULE_redeclaredAttribute = 129
		RULE_referencedAttribute = 130
		RULE_referenceClause = 131
		RULE_relOp = 132
		RULE_relOpExtended = 133
		RULE_renameId = 134
		RULE_repeatControl = 135
		RULE_repeatStmt = 136
		RULE_repetition = 137
		RULE_resourceOrRename = 138
		RULE_resourceRef = 139
		RULE_returnStmt = 140
		RULE_ruleDecl = 141
		RULE_ruleHead = 142
		RULE_ruleId = 143
		RULE_ruleLabelId = 144
		RULE_schemaBody = 145
		RULE_schemaDecl = 146
		RULE_schemaId = 147
		RULE_schemaVersionId = 148
		RULE_selector = 149
		RULE_selectExtension = 150
		RULE_selectList = 151
		RULE_selectType = 152
		RULE_setType = 153
		RULE_simpleExpression = 154
		RULE_simpleFactor = 155
		RULE_simpleTypes = 156
		RULE_skipStmt = 157
		RULE_stmt = 158
		RULE_stringLiteral = 159
		RULE_stringType = 160
		RULE_subsuper = 161
		RULE_subtypeConstraint = 162
		RULE_subtypeConstraintBody = 163
		RULE_subtypeConstraintDecl = 164
		RULE_subtypeConstraintHead = 165
		RULE_subtypeConstraintId = 166
		RULE_subtypeDeclaration = 167
		RULE_supertypeConstraint = 168
		RULE_supertypeExpression = 169
		RULE_supertypeFactor = 170
		RULE_supertypeRule = 171
		RULE_supertypeTerm = 172
		RULE_syntax = 173
		RULE_term = 174
		RULE_totalOver = 175
		RULE_typeDecl = 176
		RULE_typeId = 177
		RULE_typeLabel = 178
		RULE_typeLabelId = 179
		RULE_unaryOp = 180
		RULE_underlyingType = 181
		RULE_uniqueClause = 182
		RULE_uniqueRule = 183
		RULE_untilControl = 184
		RULE_useClause = 185
		RULE_variableId = 186
		RULE_whereClause = 187
		RULE_whileControl = 188
		RULE_width = 189
		RULE_widthSpec = 190

	@@ruleNames = [
			"attributeRef", "constantRef", "entityRef", "enumerationRef", "functionRef", 
			"parameterRef", "procedureRef", "ruleLabelRef", "ruleRef", "schemaRef", 
			"subtypeConstraintRef", "typeLabelRef", "typeRef", "variableRef", "abstractEntityDeclaration", 
			"abstractSupertype", "abstractSupertypeDeclaration", "actualParameterList", 
			"addLikeOp", "aggregateInitializer", "aggregateSource", "aggregateType", 
			"aggregationTypes", "algorithmHead", "aliasStmt", "arrayType", "assignmentStmt", 
			"attributeDecl", "attributeId", "attributeQualifier", "bagType", "binaryType", 
			"booleanType", "bound1", "bound2", "boundSpec", "builtInConstant", "builtInFunction", 
			"builtInProcedure", "caseAction", "caseLabel", "caseStmt", "compoundStmt", 
			"concreteTypes", "constantBody", "constantDecl", "constantFactor", "constantId", 
			"constructedTypes", "declaration", "derivedAttr", "deriveClause", "domainRule", 
			"element", "entityBody", "entityConstructor", "entityDecl", "entityHead", 
			"entityId", "enumerationExtension", "enumerationId", "enumerationItems", 
			"enumerationReference", "enumerationType", "escapeStmt", "explicitAttr", 
			"expression", "factor", "formalParameter", "functionCall", "functionDecl", 
			"functionHead", "functionId", "generalizedTypes", "generalAggregationTypes", 
			"generalArrayType", "generalBagType", "generalListType", "generalRef", 
			"generalSetType", "genericEntityType", "genericType", "groupQualifier", 
			"ifStmt", "increment", "incrementControl", "index", "index1", "index2", 
			"indexQualifier", "instantiableType", "integerType", "interfaceSpecification", 
			"interval", "intervalHigh", "intervalItem", "intervalLow", "intervalOp", 
			"inverseAttr", "inverseClause", "listType", "literal", "localDecl", "localVariable", 
			"logicalExpression", "logicalLiteral", "logicalType", "multiplicationLikeOp", 
			"namedTypes", "namedTypeOrRename", "nullStmt", "numberType", "numericExpression", 
			"oneOf", "parameter", "parameterId", "parameterType", "population", "precisionSpec", 
			"primary", "procedureCallStmt", "procedureDecl", "procedureHead", "procedureId", 
			"qualifiableFactor", "qualifiedAttribute", "qualifier", "queryExpression", 
			"realType", "redeclaredAttribute", "referencedAttribute", "referenceClause", 
			"relOp", "relOpExtended", "renameId", "repeatControl", "repeatStmt", 
			"repetition", "resourceOrRename", "resourceRef", "returnStmt", "ruleDecl", 
			"ruleHead", "ruleId", "ruleLabelId", "schemaBody", "schemaDecl", "schemaId", 
			"schemaVersionId", "selector", "selectExtension", "selectList", "selectType", 
			"setType", "simpleExpression", "simpleFactor", "simpleTypes", "skipStmt", 
			"stmt", "stringLiteral", "stringType", "subsuper", "subtypeConstraint", 
			"subtypeConstraintBody", "subtypeConstraintDecl", "subtypeConstraintHead", 
			"subtypeConstraintId", "subtypeDeclaration", "supertypeConstraint", "supertypeExpression", 
			"supertypeFactor", "supertypeRule", "supertypeTerm", "syntax", "term", 
			"totalOver", "typeDecl", "typeId", "typeLabel", "typeLabelId", "unaryOp", 
			"underlyingType", "uniqueClause", "uniqueRule", "untilControl", "useClause", 
			"variableId", "whereClause", "whileControl", "width", "widthSpec"
	]

	@@_LITERAL_NAMES = [
			nil, "';'", "'('", "','", "')'", "'+'", "'-'", "'['", "']'", "':'", "':='", 
			"'.'", "'?'", "'**'", "'\\'", "'{'", "'}'", "'<'", "'<='", "'*'", "'/'", 
			"'||'", "'<*'", "'|'", "'>'", "'>='", "'<>'", "'='", "':<>:'", "':=:'"
	]

	@@_SYMBOLIC_NAMES = [
			nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
			nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
			nil, nil, "ABS", "ABSTRACT", "ACOS", "AGGREGATE", "ALIAS", "AND", "ANDOR", 
			"ARRAY", "AS", "ASIN", "ATAN", "BAG", "BASED_ON", "BEGIN_", "BINARY", 
			"BLENGTH", "BOOLEAN", "BY", "CASE", "CONSTANT", "CONST_E", "COS", "DERIVE", 
			"DIV", "ELSE", "END_", "END_ALIAS", "END_CASE", "END_CONSTANT", "END_ENTITY", 
			"END_FUNCTION", "END_IF", "END_LOCAL", "END_PROCEDURE", "END_REPEAT", 
			"END_RULE", "END_SCHEMA", "END_SUBTYPE_CONSTRAINT", "END_TYPE", "ENTITY", 
			"ENUMERATION", "ESCAPE", "EXISTS", "EXP", "EXTENSIBLE", "FALSE", "FIXED", 
			"FOR", "FORMAT", "FROM", "FUNCTION", "GENERIC", "GENERIC_ENTITY", "HIBOUND", 
			"HIINDEX", "IF", "IN", "INSERT", "INTEGER", "INVERSE", "LENGTH", "LIKE", 
			"LIST", "LOBOUND", "LOCAL", "LOG", "LOG10", "LOG2", "LOGICAL", "LOINDEX", 
			"MOD", "NOT", "NUMBER", "NVL", "ODD", "OF", "ONEOF", "OPTIONAL", "OR", 
			"OTHERWISE", "PI", "PROCEDURE", "QUERY", "REAL", "REFERENCE", "REMOVE", 
			"RENAMED", "REPEAT", "RETURN", "ROLESOF", "RULE", "SCHEMA", "SELECT", 
			"SELF", "SET", "SIN", "SIZEOF", "SKIP_", "SQRT", "STRING", "SUBTYPE", 
			"SUBTYPE_CONSTRAINT", "SUPERTYPE", "TAN", "THEN", "TO", "TRUE", "TYPE", 
			"TYPEOF", "TOTAL_OVER", "UNIQUE", "UNKNOWN", "UNTIL", "USE", "USEDIN", 
			"VALUE", "VALUE_IN", "VALUE_UNIQUE", "VAR", "WITH", "WHERE", "WHILE", 
			"XOR", "BinaryLiteral", "EncodedStringLiteral", "IntegerLiteral", "RealLiteral", 
			"SimpleId", "SimpleStringLiteral", "EmbeddedRemark", "TailRemark", "Whitespace"
	]

	@@VOCABULARY =  Antlr4::Runtime::VocabularyImpl.new(@@_LITERAL_NAMES, @@_SYMBOLIC_NAMES)

	def get_vocabulary
		@@VOCABULARY
	end

	def getGrammarFileName()
	 return "Express.g4"
	end

	def rule_names()
	 return @@ruleNames
	end

	def serialized_atn()
	 return @@_serializedATN
	end

	def atn()
	 return @@_ATN
	end

	def initialize( input)
		super(input)
		i = 0
		while i < @@_ATN.number_of_decisions()
			@@_decisionToDFA[i] = Antlr4::Runtime::DFA.new(@@_ATN.decision_state(i), i)
			i+=1
		end

		@_interp =  Antlr4::Runtime::ParserATNSimulator.new(self,@@_ATN,@@_decisionToDFA,@@_sharedContextCache)
	end

	 class AttributeRefContext < Antlr4::Runtime::ParserRuleContext
		def attributeId()
			return rule_context("AttributeIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_attributeRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAttributeRef) )
			  return visitor.visitAttributeRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def attributeRef()
		_localctx =  AttributeRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 0, RULE_attributeRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 382
			attributeId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstantRefContext < Antlr4::Runtime::ParserRuleContext
		def constantId()
			return rule_context("ConstantIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constantRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstantRef) )
			  return visitor.visitConstantRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constantRef()
		_localctx =  ConstantRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 2, RULE_constantRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 384
			constantId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityRefContext < Antlr4::Runtime::ParserRuleContext
		def entityId()
			return rule_context("EntityIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityRef) )
			  return visitor.visitEntityRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityRef()
		_localctx =  EntityRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 4, RULE_entityRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 386
			entityId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationRefContext < Antlr4::Runtime::ParserRuleContext
		def enumerationId()
			return rule_context("EnumerationIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationRef) )
			  return visitor.visitEnumerationRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationRef()
		_localctx =  EnumerationRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 6, RULE_enumerationRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 388
			enumerationId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FunctionRefContext < Antlr4::Runtime::ParserRuleContext
		def functionId()
			return rule_context("FunctionIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_functionRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFunctionRef) )
			  return visitor.visitFunctionRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def functionRef()
		_localctx =  FunctionRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 8, RULE_functionRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 390
			functionId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ParameterRefContext < Antlr4::Runtime::ParserRuleContext
		def parameterId()
			return rule_context("ParameterIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_parameterRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitParameterRef) )
			  return visitor.visitParameterRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def parameterRef()
		_localctx =  ParameterRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 10, RULE_parameterRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 392
			parameterId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ProcedureRefContext < Antlr4::Runtime::ParserRuleContext
		def procedureId()
			return rule_context("ProcedureIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_procedureRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitProcedureRef) )
			  return visitor.visitProcedureRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def procedureRef()
		_localctx =  ProcedureRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 12, RULE_procedureRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 394
			procedureId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleLabelRefContext < Antlr4::Runtime::ParserRuleContext
		def ruleLabelId()
			return rule_context("RuleLabelIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleLabelRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleLabelRef) )
			  return visitor.visitRuleLabelRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleLabelRef()
		_localctx =  RuleLabelRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 14, RULE_ruleLabelRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 396
			ruleLabelId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleRefContext < Antlr4::Runtime::ParserRuleContext
		def ruleId()
			return rule_context("RuleIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleRef) )
			  return visitor.visitRuleRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleRef()
		_localctx =  RuleRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 16, RULE_ruleRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 398
			ruleId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SchemaRefContext < Antlr4::Runtime::ParserRuleContext
		def schemaId()
			return rule_context("SchemaIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_schemaRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSchemaRef) )
			  return visitor.visitSchemaRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def schemaRef()
		_localctx =  SchemaRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 18, RULE_schemaRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 400
			schemaId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintRefContext < Antlr4::Runtime::ParserRuleContext
		def subtypeConstraintId()
			return rule_context("SubtypeConstraintIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraintRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraintRef) )
			  return visitor.visitSubtypeConstraintRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraintRef()
		_localctx =  SubtypeConstraintRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 20, RULE_subtypeConstraintRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 402
			subtypeConstraintId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeLabelRefContext < Antlr4::Runtime::ParserRuleContext
		def typeLabelId()
			return rule_context("TypeLabelIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeLabelRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeLabelRef) )
			  return visitor.visitTypeLabelRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeLabelRef()
		_localctx =  TypeLabelRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 22, RULE_typeLabelRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 404
			typeLabelId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeRefContext < Antlr4::Runtime::ParserRuleContext
		def typeId()
			return rule_context("TypeIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeRef) )
			  return visitor.visitTypeRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeRef()
		_localctx =  TypeRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 24, RULE_typeRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 406
			typeId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class VariableRefContext < Antlr4::Runtime::ParserRuleContext
		def variableId()
			return rule_context("VariableIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_variableRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitVariableRef) )
			  return visitor.visitVariableRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def variableRef()
		_localctx =  VariableRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 26, RULE_variableRef)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 408
			variableId()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AbstractEntityDeclarationContext < Antlr4::Runtime::ParserRuleContext
		def ABSTRACT()
		  return token(ExpressParser::ABSTRACT, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_abstractEntityDeclaration
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAbstractEntityDeclaration) )
			  return visitor.visitAbstractEntityDeclaration(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def abstractEntityDeclaration()
		_localctx =  AbstractEntityDeclarationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 28, RULE_abstractEntityDeclaration)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 410
			match(ABSTRACT)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AbstractSupertypeContext < Antlr4::Runtime::ParserRuleContext
		def ABSTRACT()
		  return token(ExpressParser::ABSTRACT, 0)
		end
		def SUPERTYPE()
		  return token(ExpressParser::SUPERTYPE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_abstractSupertype
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAbstractSupertype) )
			  return visitor.visitAbstractSupertype(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def abstractSupertype()
		_localctx =  AbstractSupertypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 30, RULE_abstractSupertype)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 412
			match(ABSTRACT)
			@_state_number = 413
			match(SUPERTYPE)
			@_state_number = 414
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AbstractSupertypeDeclarationContext < Antlr4::Runtime::ParserRuleContext
		def ABSTRACT()
		  return token(ExpressParser::ABSTRACT, 0)
		end
		def SUPERTYPE()
		  return token(ExpressParser::SUPERTYPE, 0)
		end
		def subtypeConstraint()
			return rule_context("SubtypeConstraintContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_abstractSupertypeDeclaration
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAbstractSupertypeDeclaration) )
			  return visitor.visitAbstractSupertypeDeclaration(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def abstractSupertypeDeclaration()
		_localctx =  AbstractSupertypeDeclarationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 32, RULE_abstractSupertypeDeclaration)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 416
			match(ABSTRACT)
			@_state_number = 417
			match(SUPERTYPE)
			@_state_number = 419
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==OF)

				@_state_number = 418
				subtypeConstraint()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ActualParameterListContext < Antlr4::Runtime::ParserRuleContext
		def parameter()
			return rule_contexts("ParameterContext")
		end
		def parameter_i( i)
			return rule_context("ParameterContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_actualParameterList
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitActualParameterList) )
			  return visitor.visitActualParameterList(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def actualParameterList()
		_localctx =  ActualParameterListContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 34, RULE_actualParameterList)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 421
			match(T__1)
			@_state_number = 422
			parameter()
			@_state_number = 427
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 423
				match(T__2)
				@_state_number = 424
				parameter()
				@_state_number = 429
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 430
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AddLikeOpContext < Antlr4::Runtime::ParserRuleContext
		def OR()
		  return token(ExpressParser::OR, 0)
		end
		def XOR()
		  return token(ExpressParser::XOR, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_addLikeOp
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAddLikeOp) )
			  return visitor.visitAddLikeOp(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def addLikeOp()
		_localctx =  AddLikeOpContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 36, RULE_addLikeOp)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 432
			_la = @_input.la(1)
			if ( !(_la==T__4 || _la==T__5 || _la==OR || _la==XOR) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AggregateInitializerContext < Antlr4::Runtime::ParserRuleContext
		def element()
			return rule_contexts("ElementContext")
		end
		def element_i( i)
			return rule_context("ElementContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_aggregateInitializer
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAggregateInitializer) )
			  return visitor.visitAggregateInitializer(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def aggregateInitializer()
		_localctx =  AggregateInitializerContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 38, RULE_aggregateInitializer)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 434
			match(T__6)
			@_state_number = 443
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__1) | (1 << T__4) | (1 << T__5) | (1 << T__6) | (1 << T__11) | (1 << T__14) | (1 << ABS) | (1 << ACOS) | (1 << ASIN) | (1 << ATAN) | (1 << BLENGTH) | (1 << CONST_E) | (1 << COS))) != 0) || ((((_la - 72)) & ~0x3f) == 0 && ((1 << (_la - 72)) & ((1 << (EXISTS - 72)) | (1 << (EXP - 72)) | (1 << (FALSE - 72)) | (1 << (FORMAT - 72)) | (1 << (HIBOUND - 72)) | (1 << (HIINDEX - 72)) | (1 << (LENGTH - 72)) | (1 << (LOBOUND - 72)) | (1 << (LOG - 72)) | (1 << (LOG10 - 72)) | (1 << (LOG2 - 72)) | (1 << (LOINDEX - 72)) | (1 << (NOT - 72)) | (1 << (NVL - 72)) | (1 << (ODD - 72)) | (1 << (PI - 72)) | (1 << (QUERY - 72)) | (1 << (ROLESOF - 72)) | (1 << (SELF - 72)) | (1 << (SIN - 72)) | (1 << (SIZEOF - 72)) | (1 << (SQRT - 72)) | (1 << (TAN - 72)))) != 0) || ((((_la - 136)) & ~0x3f) == 0 && ((1 << (_la - 136)) & ((1 << (TRUE - 136)) | (1 << (TYPEOF - 136)) | (1 << (UNKNOWN - 136)) | (1 << (USEDIN - 136)) | (1 << (VALUE - 136)) | (1 << (VALUE_IN - 136)) | (1 << (VALUE_UNIQUE - 136)) | (1 << (BinaryLiteral - 136)) | (1 << (EncodedStringLiteral - 136)) | (1 << (IntegerLiteral - 136)) | (1 << (RealLiteral - 136)) | (1 << (SimpleId - 136)) | (1 << (SimpleStringLiteral - 136)))) != 0))

				@_state_number = 435
				element()
				@_state_number = 440
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__2)


					@_state_number = 436
					match(T__2)
					@_state_number = 437
					element()
					@_state_number = 442
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			end

			@_state_number = 445
			match(T__7)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AggregateSourceContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_context("SimpleExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_aggregateSource
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAggregateSource) )
			  return visitor.visitAggregateSource(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def aggregateSource()
		_localctx =  AggregateSourceContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 40, RULE_aggregateSource)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 447
			simpleExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AggregateTypeContext < Antlr4::Runtime::ParserRuleContext
		def AGGREGATE()
		  return token(ExpressParser::AGGREGATE, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def typeLabel()
			return rule_context("TypeLabelContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_aggregateType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAggregateType) )
			  return visitor.visitAggregateType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def aggregateType()
		_localctx =  AggregateTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 42, RULE_aggregateType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 449
			match(AGGREGATE)
			@_state_number = 452
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__8)

				@_state_number = 450
				match(T__8)
				@_state_number = 451
				typeLabel()
			end

			@_state_number = 454
			match(OF)
			@_state_number = 455
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AggregationTypesContext < Antlr4::Runtime::ParserRuleContext
		def arrayType()
			return rule_context("ArrayTypeContext",0)
		end
		def bagType()
			return rule_context("BagTypeContext",0)
		end
		def listType()
			return rule_context("ListTypeContext",0)
		end
		def setType()
			return rule_context("SetTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_aggregationTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAggregationTypes) )
			  return visitor.visitAggregationTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def aggregationTypes()
		_localctx =  AggregationTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 44, RULE_aggregationTypes)
		begin
			@_state_number = 461
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ARRAY
				enter_outer_alt(_localctx, 1)

				@_state_number = 457
				arrayType()

			when ExpressParser::BAG
				enter_outer_alt(_localctx, 2)

				@_state_number = 458
				bagType()

			when ExpressParser::LIST
				enter_outer_alt(_localctx, 3)

				@_state_number = 459
				listType()

			when ExpressParser::SET
				enter_outer_alt(_localctx, 4)

				@_state_number = 460
				setType()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AlgorithmHeadContext < Antlr4::Runtime::ParserRuleContext
		def declaration()
			return rule_contexts("DeclarationContext")
		end
		def declaration_i( i)
			return rule_context("DeclarationContext",i)
		end
		def constantDecl()
			return rule_context("ConstantDeclContext",0)
		end
		def localDecl()
			return rule_context("LocalDeclContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_algorithmHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAlgorithmHead) )
			  return visitor.visitAlgorithmHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def algorithmHead()
		_localctx =  AlgorithmHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 46, RULE_algorithmHead)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 466
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (((((_la - 69)) & ~0x3f) == 0 && ((1 << (_la - 69)) & ((1 << (ENTITY - 69)) | (1 << (FUNCTION - 69)) | (1 << (PROCEDURE - 69)) | (1 << (SUBTYPE_CONSTRAINT - 69)))) != 0) || _la==TYPE)


				@_state_number = 463
				declaration()
				@_state_number = 468
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 470
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==CONSTANT)

				@_state_number = 469
				constantDecl()
			end

			@_state_number = 473
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==LOCAL)

				@_state_number = 472
				localDecl()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AliasStmtContext < Antlr4::Runtime::ParserRuleContext
		def ALIAS()
		  return token(ExpressParser::ALIAS, 0)
		end
		def variableId()
			return rule_context("VariableIdContext",0)
		end
		def FOR()
		  return token(ExpressParser::FOR, 0)
		end
		def generalRef()
			return rule_context("GeneralRefContext",0)
		end
		def END_ALIAS()
		  return token(ExpressParser::END_ALIAS, 0)
		end
		def qualifier()
			return rule_contexts("QualifierContext")
		end
		def qualifier_i( i)
			return rule_context("QualifierContext",i)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_aliasStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAliasStmt) )
			  return visitor.visitAliasStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def aliasStmt()
		_localctx =  AliasStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 48, RULE_aliasStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 475
			match(ALIAS)
			@_state_number = 476
			variableId()
			@_state_number = 477
			match(FOR)
			@_state_number = 478
			generalRef()
			@_state_number = 482
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__6) | (1 << T__10) | (1 << T__13))) != 0))


				@_state_number = 479
				qualifier()
				@_state_number = 484
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 485
			match(T__0)
			@_state_number = 487 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 486
				stmt()
				@_state_number = 489 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
			end
			@_state_number = 491
			match(END_ALIAS)
			@_state_number = 492
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ArrayTypeContext < Antlr4::Runtime::ParserRuleContext
		def ARRAY()
		  return token(ExpressParser::ARRAY, 0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def instantiableType()
			return rule_context("InstantiableTypeContext",0)
		end
		def OPTIONAL()
		  return token(ExpressParser::OPTIONAL, 0)
		end
		def UNIQUE()
		  return token(ExpressParser::UNIQUE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_arrayType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitArrayType) )
			  return visitor.visitArrayType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def arrayType()
		_localctx =  ArrayTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 50, RULE_arrayType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 494
			match(ARRAY)
			@_state_number = 495
			boundSpec()
			@_state_number = 496
			match(OF)
			@_state_number = 498
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==OPTIONAL)

				@_state_number = 497
				match(OPTIONAL)
			end

			@_state_number = 501
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNIQUE)

				@_state_number = 500
				match(UNIQUE)
			end

			@_state_number = 503
			instantiableType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AssignmentStmtContext < Antlr4::Runtime::ParserRuleContext
		def generalRef()
			return rule_context("GeneralRefContext",0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def qualifier()
			return rule_contexts("QualifierContext")
		end
		def qualifier_i( i)
			return rule_context("QualifierContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_assignmentStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAssignmentStmt) )
			  return visitor.visitAssignmentStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def assignmentStmt()
		_localctx =  AssignmentStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 52, RULE_assignmentStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 505
			generalRef()
			@_state_number = 509
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__6) | (1 << T__10) | (1 << T__13))) != 0))


				@_state_number = 506
				qualifier()
				@_state_number = 511
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 512
			match(T__9)
			@_state_number = 513
			expression()
			@_state_number = 514
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AttributeDeclContext < Antlr4::Runtime::ParserRuleContext
		def attributeId()
			return rule_context("AttributeIdContext",0)
		end
		def redeclaredAttribute()
			return rule_context("RedeclaredAttributeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_attributeDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAttributeDecl) )
			  return visitor.visitAttributeDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def attributeDecl()
		_localctx =  AttributeDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 54, RULE_attributeDecl)
		begin
			@_state_number = 518
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 1)

				@_state_number = 516
				attributeId()

			when ExpressParser::SELF
				enter_outer_alt(_localctx, 2)

				@_state_number = 517
				redeclaredAttribute()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AttributeIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_attributeId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAttributeId) )
			  return visitor.visitAttributeId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def attributeId()
		_localctx =  AttributeIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 56, RULE_attributeId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 520
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class AttributeQualifierContext < Antlr4::Runtime::ParserRuleContext
		def attributeRef()
			return rule_context("AttributeRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_attributeQualifier
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitAttributeQualifier) )
			  return visitor.visitAttributeQualifier(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def attributeQualifier()
		_localctx =  AttributeQualifierContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 58, RULE_attributeQualifier)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 522
			match(T__10)
			@_state_number = 523
			attributeRef()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BagTypeContext < Antlr4::Runtime::ParserRuleContext
		def BAG()
		  return token(ExpressParser::BAG, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def instantiableType()
			return rule_context("InstantiableTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_bagType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBagType) )
			  return visitor.visitBagType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def bagType()
		_localctx =  BagTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 60, RULE_bagType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 525
			match(BAG)
			@_state_number = 527
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 526
				boundSpec()
			end

			@_state_number = 529
			match(OF)
			@_state_number = 530
			instantiableType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BinaryTypeContext < Antlr4::Runtime::ParserRuleContext
		def BINARY()
		  return token(ExpressParser::BINARY, 0)
		end
		def widthSpec()
			return rule_context("WidthSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_binaryType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBinaryType) )
			  return visitor.visitBinaryType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def binaryType()
		_localctx =  BinaryTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 62, RULE_binaryType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 532
			match(BINARY)
			@_state_number = 534
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 533
				widthSpec()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BooleanTypeContext < Antlr4::Runtime::ParserRuleContext
		def BOOLEAN()
		  return token(ExpressParser::BOOLEAN, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_booleanType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBooleanType) )
			  return visitor.visitBooleanType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def booleanType()
		_localctx =  BooleanTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 64, RULE_booleanType)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 536
			match(BOOLEAN)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Bound1Context < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_bound1
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBound1) )
			  return visitor.visitBound1(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def bound1()
		_localctx =  Bound1Context.new(@_ctx, @_state_number)
		enter_rule(_localctx, 66, RULE_bound1)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 538
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Bound2Context < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_bound2
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBound2) )
			  return visitor.visitBound2(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def bound2()
		_localctx =  Bound2Context.new(@_ctx, @_state_number)
		enter_rule(_localctx, 68, RULE_bound2)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 540
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BoundSpecContext < Antlr4::Runtime::ParserRuleContext
		def bound1()
			return rule_context("Bound1Context",0)
		end
		def bound2()
			return rule_context("Bound2Context",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_boundSpec
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBoundSpec) )
			  return visitor.visitBoundSpec(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def boundSpec()
		_localctx =  BoundSpecContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 70, RULE_boundSpec)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 542
			match(T__6)
			@_state_number = 543
			bound1()
			@_state_number = 544
			match(T__8)
			@_state_number = 545
			bound2()
			@_state_number = 546
			match(T__7)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BuiltInConstantContext < Antlr4::Runtime::ParserRuleContext
		def CONST_E()
		  return token(ExpressParser::CONST_E, 0)
		end
		def PI()
		  return token(ExpressParser::PI, 0)
		end
		def SELF()
		  return token(ExpressParser::SELF, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_builtInConstant
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBuiltInConstant) )
			  return visitor.visitBuiltInConstant(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def builtInConstant()
		_localctx =  BuiltInConstantContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 72, RULE_builtInConstant)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 548
			_la = @_input.la(1)
			if ( !(_la==T__11 || _la==CONST_E || _la==PI || _la==SELF) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BuiltInFunctionContext < Antlr4::Runtime::ParserRuleContext
		def ABS()
		  return token(ExpressParser::ABS, 0)
		end
		def ACOS()
		  return token(ExpressParser::ACOS, 0)
		end
		def ASIN()
		  return token(ExpressParser::ASIN, 0)
		end
		def ATAN()
		  return token(ExpressParser::ATAN, 0)
		end
		def BLENGTH()
		  return token(ExpressParser::BLENGTH, 0)
		end
		def COS()
		  return token(ExpressParser::COS, 0)
		end
		def EXISTS()
		  return token(ExpressParser::EXISTS, 0)
		end
		def EXP()
		  return token(ExpressParser::EXP, 0)
		end
		def FORMAT()
		  return token(ExpressParser::FORMAT, 0)
		end
		def HIBOUND()
		  return token(ExpressParser::HIBOUND, 0)
		end
		def HIINDEX()
		  return token(ExpressParser::HIINDEX, 0)
		end
		def LENGTH()
		  return token(ExpressParser::LENGTH, 0)
		end
		def LOBOUND()
		  return token(ExpressParser::LOBOUND, 0)
		end
		def LOINDEX()
		  return token(ExpressParser::LOINDEX, 0)
		end
		def LOG()
		  return token(ExpressParser::LOG, 0)
		end
		def LOG2()
		  return token(ExpressParser::LOG2, 0)
		end
		def LOG10()
		  return token(ExpressParser::LOG10, 0)
		end
		def NVL()
		  return token(ExpressParser::NVL, 0)
		end
		def ODD()
		  return token(ExpressParser::ODD, 0)
		end
		def ROLESOF()
		  return token(ExpressParser::ROLESOF, 0)
		end
		def SIN()
		  return token(ExpressParser::SIN, 0)
		end
		def SIZEOF()
		  return token(ExpressParser::SIZEOF, 0)
		end
		def SQRT()
		  return token(ExpressParser::SQRT, 0)
		end
		def TAN()
		  return token(ExpressParser::TAN, 0)
		end
		def TYPEOF()
		  return token(ExpressParser::TYPEOF, 0)
		end
		def USEDIN()
		  return token(ExpressParser::USEDIN, 0)
		end
		def VALUE()
		  return token(ExpressParser::VALUE, 0)
		end
		def VALUE_IN()
		  return token(ExpressParser::VALUE_IN, 0)
		end
		def VALUE_UNIQUE()
		  return token(ExpressParser::VALUE_UNIQUE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_builtInFunction
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBuiltInFunction) )
			  return visitor.visitBuiltInFunction(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def builtInFunction()
		_localctx =  BuiltInFunctionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 74, RULE_builtInFunction)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 550
			_la = @_input.la(1)
			if ( !(((((_la - 30)) & ~0x3f) == 0 && ((1 << (_la - 30)) & ((1 << (ABS - 30)) | (1 << (ACOS - 30)) | (1 << (ASIN - 30)) | (1 << (ATAN - 30)) | (1 << (BLENGTH - 30)) | (1 << (COS - 30)) | (1 << (EXISTS - 30)) | (1 << (EXP - 30)) | (1 << (FORMAT - 30)) | (1 << (HIBOUND - 30)) | (1 << (HIINDEX - 30)) | (1 << (LENGTH - 30)) | (1 << (LOBOUND - 30)))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1 << (_la - 95)) & ((1 << (LOG - 95)) | (1 << (LOG10 - 95)) | (1 << (LOG2 - 95)) | (1 << (LOINDEX - 95)) | (1 << (NVL - 95)) | (1 << (ODD - 95)) | (1 << (ROLESOF - 95)) | (1 << (SIN - 95)) | (1 << (SIZEOF - 95)) | (1 << (SQRT - 95)) | (1 << (TAN - 95)) | (1 << (TYPEOF - 95)) | (1 << (USEDIN - 95)) | (1 << (VALUE - 95)) | (1 << (VALUE_IN - 95)) | (1 << (VALUE_UNIQUE - 95)))) != 0)) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class BuiltInProcedureContext < Antlr4::Runtime::ParserRuleContext
		def INSERT()
		  return token(ExpressParser::INSERT, 0)
		end
		def REMOVE()
		  return token(ExpressParser::REMOVE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_builtInProcedure
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitBuiltInProcedure) )
			  return visitor.visitBuiltInProcedure(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def builtInProcedure()
		_localctx =  BuiltInProcedureContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 76, RULE_builtInProcedure)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 552
			_la = @_input.la(1)
			if ( !(_la==INSERT || _la==REMOVE) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class CaseActionContext < Antlr4::Runtime::ParserRuleContext
		def caseLabel()
			return rule_contexts("CaseLabelContext")
		end
		def caseLabel_i( i)
			return rule_context("CaseLabelContext",i)
		end
		def stmt()
			return rule_context("StmtContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_caseAction
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitCaseAction) )
			  return visitor.visitCaseAction(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def caseAction()
		_localctx =  CaseActionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 78, RULE_caseAction)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 554
			caseLabel()
			@_state_number = 559
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 555
				match(T__2)
				@_state_number = 556
				caseLabel()
				@_state_number = 561
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 562
			match(T__8)
			@_state_number = 563
			stmt()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class CaseLabelContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_caseLabel
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitCaseLabel) )
			  return visitor.visitCaseLabel(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def caseLabel()
		_localctx =  CaseLabelContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 80, RULE_caseLabel)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 565
			expression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class CaseStmtContext < Antlr4::Runtime::ParserRuleContext
		def CASE()
		  return token(ExpressParser::CASE, 0)
		end
		def selector()
			return rule_context("SelectorContext",0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def END_CASE()
		  return token(ExpressParser::END_CASE, 0)
		end
		def caseAction()
			return rule_contexts("CaseActionContext")
		end
		def caseAction_i( i)
			return rule_context("CaseActionContext",i)
		end
		def OTHERWISE()
		  return token(ExpressParser::OTHERWISE, 0)
		end
		def stmt()
			return rule_context("StmtContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_caseStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitCaseStmt) )
			  return visitor.visitCaseStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def caseStmt()
		_localctx =  CaseStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 82, RULE_caseStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 567
			match(CASE)
			@_state_number = 568
			selector()
			@_state_number = 569
			match(OF)
			@_state_number = 573
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__1) | (1 << T__4) | (1 << T__5) | (1 << T__6) | (1 << T__11) | (1 << T__14) | (1 << ABS) | (1 << ACOS) | (1 << ASIN) | (1 << ATAN) | (1 << BLENGTH) | (1 << CONST_E) | (1 << COS))) != 0) || ((((_la - 72)) & ~0x3f) == 0 && ((1 << (_la - 72)) & ((1 << (EXISTS - 72)) | (1 << (EXP - 72)) | (1 << (FALSE - 72)) | (1 << (FORMAT - 72)) | (1 << (HIBOUND - 72)) | (1 << (HIINDEX - 72)) | (1 << (LENGTH - 72)) | (1 << (LOBOUND - 72)) | (1 << (LOG - 72)) | (1 << (LOG10 - 72)) | (1 << (LOG2 - 72)) | (1 << (LOINDEX - 72)) | (1 << (NOT - 72)) | (1 << (NVL - 72)) | (1 << (ODD - 72)) | (1 << (PI - 72)) | (1 << (QUERY - 72)) | (1 << (ROLESOF - 72)) | (1 << (SELF - 72)) | (1 << (SIN - 72)) | (1 << (SIZEOF - 72)) | (1 << (SQRT - 72)) | (1 << (TAN - 72)))) != 0) || ((((_la - 136)) & ~0x3f) == 0 && ((1 << (_la - 136)) & ((1 << (TRUE - 136)) | (1 << (TYPEOF - 136)) | (1 << (UNKNOWN - 136)) | (1 << (USEDIN - 136)) | (1 << (VALUE - 136)) | (1 << (VALUE_IN - 136)) | (1 << (VALUE_UNIQUE - 136)) | (1 << (BinaryLiteral - 136)) | (1 << (EncodedStringLiteral - 136)) | (1 << (IntegerLiteral - 136)) | (1 << (RealLiteral - 136)) | (1 << (SimpleId - 136)) | (1 << (SimpleStringLiteral - 136)))) != 0))


				@_state_number = 570
				caseAction()
				@_state_number = 575
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 579
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==OTHERWISE)

				@_state_number = 576
				match(OTHERWISE)
				@_state_number = 577
				match(T__8)
				@_state_number = 578
				stmt()
			end

			@_state_number = 581
			match(END_CASE)
			@_state_number = 582
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class CompoundStmtContext < Antlr4::Runtime::ParserRuleContext
		def BEGIN_()
		  return token(ExpressParser::BEGIN_, 0)
		end
		def END_()
		  return token(ExpressParser::END_, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_compoundStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitCompoundStmt) )
			  return visitor.visitCompoundStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def compoundStmt()
		_localctx =  CompoundStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 84, RULE_compoundStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 584
			match(BEGIN_)
			@_state_number = 586 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 585
				stmt()
				@_state_number = 588 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
			end
			@_state_number = 590
			match(END_)
			@_state_number = 591
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConcreteTypesContext < Antlr4::Runtime::ParserRuleContext
		def aggregationTypes()
			return rule_context("AggregationTypesContext",0)
		end
		def simpleTypes()
			return rule_context("SimpleTypesContext",0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_concreteTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConcreteTypes) )
			  return visitor.visitConcreteTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def concreteTypes()
		_localctx =  ConcreteTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 86, RULE_concreteTypes)
		begin
			@_state_number = 596
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ARRAY, ExpressParser::BAG, ExpressParser::LIST, ExpressParser::SET
				enter_outer_alt(_localctx, 1)

				@_state_number = 593
				aggregationTypes()

			when ExpressParser::BINARY, ExpressParser::BOOLEAN, ExpressParser::INTEGER, ExpressParser::LOGICAL, ExpressParser::NUMBER, ExpressParser::REAL, ExpressParser::STRING
				enter_outer_alt(_localctx, 2)

				@_state_number = 594
				simpleTypes()

			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 3)

				@_state_number = 595
				typeRef()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstantBodyContext < Antlr4::Runtime::ParserRuleContext
		def constantId()
			return rule_context("ConstantIdContext",0)
		end
		def instantiableType()
			return rule_context("InstantiableTypeContext",0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constantBody
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstantBody) )
			  return visitor.visitConstantBody(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constantBody()
		_localctx =  ConstantBodyContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 88, RULE_constantBody)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 598
			constantId()
			@_state_number = 599
			match(T__8)
			@_state_number = 600
			instantiableType()
			@_state_number = 601
			match(T__9)
			@_state_number = 602
			expression()
			@_state_number = 603
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstantDeclContext < Antlr4::Runtime::ParserRuleContext
		def CONSTANT()
		  return token(ExpressParser::CONSTANT, 0)
		end
		def END_CONSTANT()
		  return token(ExpressParser::END_CONSTANT, 0)
		end
		def constantBody()
			return rule_contexts("ConstantBodyContext")
		end
		def constantBody_i( i)
			return rule_context("ConstantBodyContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constantDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstantDecl) )
			  return visitor.visitConstantDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constantDecl()
		_localctx =  ConstantDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 90, RULE_constantDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 605
			match(CONSTANT)
			@_state_number = 607 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 606
				constantBody()
				@_state_number = 609 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( _la==SimpleId) )
			end
			@_state_number = 611
			match(END_CONSTANT)
			@_state_number = 612
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstantFactorContext < Antlr4::Runtime::ParserRuleContext
		def builtInConstant()
			return rule_context("BuiltInConstantContext",0)
		end
		def constantRef()
			return rule_context("ConstantRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constantFactor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstantFactor) )
			  return visitor.visitConstantFactor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constantFactor()
		_localctx =  ConstantFactorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 92, RULE_constantFactor)
		begin
			@_state_number = 616
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::T__11, ExpressParser::CONST_E, ExpressParser::PI, ExpressParser::SELF
				enter_outer_alt(_localctx, 1)

				@_state_number = 614
				builtInConstant()

			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 2)

				@_state_number = 615
				constantRef()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstantIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constantId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstantId) )
			  return visitor.visitConstantId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constantId()
		_localctx =  ConstantIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 94, RULE_constantId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 618
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ConstructedTypesContext < Antlr4::Runtime::ParserRuleContext
		def enumerationType()
			return rule_context("EnumerationTypeContext",0)
		end
		def selectType()
			return rule_context("SelectTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_constructedTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitConstructedTypes) )
			  return visitor.visitConstructedTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def constructedTypes()
		_localctx =  ConstructedTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 96, RULE_constructedTypes)
		begin
			@_state_number = 622
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,24,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 620
				enumerationType()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 621
				selectType()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class DeclarationContext < Antlr4::Runtime::ParserRuleContext
		def entityDecl()
			return rule_context("EntityDeclContext",0)
		end
		def functionDecl()
			return rule_context("FunctionDeclContext",0)
		end
		def procedureDecl()
			return rule_context("ProcedureDeclContext",0)
		end
		def subtypeConstraintDecl()
			return rule_context("SubtypeConstraintDeclContext",0)
		end
		def typeDecl()
			return rule_context("TypeDeclContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_declaration
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitDeclaration) )
			  return visitor.visitDeclaration(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def declaration()
		_localctx =  DeclarationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 98, RULE_declaration)
		begin
			@_state_number = 629
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ENTITY
				enter_outer_alt(_localctx, 1)

				@_state_number = 624
				entityDecl()

			when ExpressParser::FUNCTION
				enter_outer_alt(_localctx, 2)

				@_state_number = 625
				functionDecl()

			when ExpressParser::PROCEDURE
				enter_outer_alt(_localctx, 3)

				@_state_number = 626
				procedureDecl()

			when ExpressParser::SUBTYPE_CONSTRAINT
				enter_outer_alt(_localctx, 4)

				@_state_number = 627
				subtypeConstraintDecl()

			when ExpressParser::TYPE
				enter_outer_alt(_localctx, 5)

				@_state_number = 628
				typeDecl()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class DerivedAttrContext < Antlr4::Runtime::ParserRuleContext
		def attributeDecl()
			return rule_context("AttributeDeclContext",0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_derivedAttr
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitDerivedAttr) )
			  return visitor.visitDerivedAttr(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def derivedAttr()
		_localctx =  DerivedAttrContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 100, RULE_derivedAttr)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 631
			attributeDecl()
			@_state_number = 632
			match(T__8)
			@_state_number = 633
			parameterType()
			@_state_number = 634
			match(T__9)
			@_state_number = 635
			expression()
			@_state_number = 636
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class DeriveClauseContext < Antlr4::Runtime::ParserRuleContext
		def DERIVE()
		  return token(ExpressParser::DERIVE, 0)
		end
		def derivedAttr()
			return rule_contexts("DerivedAttrContext")
		end
		def derivedAttr_i( i)
			return rule_context("DerivedAttrContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_deriveClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitDeriveClause) )
			  return visitor.visitDeriveClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def deriveClause()
		_localctx =  DeriveClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 102, RULE_deriveClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 638
			match(DERIVE)
			@_state_number = 640 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 639
				derivedAttr()
				@_state_number = 642 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( _la==SELF || _la==SimpleId) )
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class DomainRuleContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def ruleLabelId()
			return rule_context("RuleLabelIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_domainRule
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitDomainRule) )
			  return visitor.visitDomainRule(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def domainRule()
		_localctx =  DomainRuleContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 104, RULE_domainRule)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 647
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,27,@_ctx) )
			when 1

				@_state_number = 644
				ruleLabelId()
				@_state_number = 645
				match(T__8)

			end
			@_state_number = 649
			expression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ElementContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def repetition()
			return rule_context("RepetitionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_element
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitElement) )
			  return visitor.visitElement(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def element()
		_localctx =  ElementContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 106, RULE_element)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 651
			expression()
			@_state_number = 654
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__8)

				@_state_number = 652
				match(T__8)
				@_state_number = 653
				repetition()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityBodyContext < Antlr4::Runtime::ParserRuleContext
		def explicitAttr()
			return rule_contexts("ExplicitAttrContext")
		end
		def explicitAttr_i( i)
			return rule_context("ExplicitAttrContext",i)
		end
		def deriveClause()
			return rule_context("DeriveClauseContext",0)
		end
		def inverseClause()
			return rule_context("InverseClauseContext",0)
		end
		def uniqueClause()
			return rule_context("UniqueClauseContext",0)
		end
		def whereClause()
			return rule_context("WhereClauseContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityBody
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityBody) )
			  return visitor.visitEntityBody(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityBody()
		_localctx =  EntityBodyContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 108, RULE_entityBody)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 659
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==SELF || _la==SimpleId)


				@_state_number = 656
				explicitAttr()
				@_state_number = 661
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 663
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==DERIVE)

				@_state_number = 662
				deriveClause()
			end

			@_state_number = 666
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==INVERSE)

				@_state_number = 665
				inverseClause()
			end

			@_state_number = 669
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNIQUE)

				@_state_number = 668
				uniqueClause()
			end

			@_state_number = 672
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==WHERE)

				@_state_number = 671
				whereClause()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityConstructorContext < Antlr4::Runtime::ParserRuleContext
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def expression()
			return rule_contexts("ExpressionContext")
		end
		def expression_i( i)
			return rule_context("ExpressionContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityConstructor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityConstructor) )
			  return visitor.visitEntityConstructor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityConstructor()
		_localctx =  EntityConstructorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 110, RULE_entityConstructor)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 674
			entityRef()
			@_state_number = 675
			match(T__1)
			@_state_number = 684
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__1) | (1 << T__4) | (1 << T__5) | (1 << T__6) | (1 << T__11) | (1 << T__14) | (1 << ABS) | (1 << ACOS) | (1 << ASIN) | (1 << ATAN) | (1 << BLENGTH) | (1 << CONST_E) | (1 << COS))) != 0) || ((((_la - 72)) & ~0x3f) == 0 && ((1 << (_la - 72)) & ((1 << (EXISTS - 72)) | (1 << (EXP - 72)) | (1 << (FALSE - 72)) | (1 << (FORMAT - 72)) | (1 << (HIBOUND - 72)) | (1 << (HIINDEX - 72)) | (1 << (LENGTH - 72)) | (1 << (LOBOUND - 72)) | (1 << (LOG - 72)) | (1 << (LOG10 - 72)) | (1 << (LOG2 - 72)) | (1 << (LOINDEX - 72)) | (1 << (NOT - 72)) | (1 << (NVL - 72)) | (1 << (ODD - 72)) | (1 << (PI - 72)) | (1 << (QUERY - 72)) | (1 << (ROLESOF - 72)) | (1 << (SELF - 72)) | (1 << (SIN - 72)) | (1 << (SIZEOF - 72)) | (1 << (SQRT - 72)) | (1 << (TAN - 72)))) != 0) || ((((_la - 136)) & ~0x3f) == 0 && ((1 << (_la - 136)) & ((1 << (TRUE - 136)) | (1 << (TYPEOF - 136)) | (1 << (UNKNOWN - 136)) | (1 << (USEDIN - 136)) | (1 << (VALUE - 136)) | (1 << (VALUE_IN - 136)) | (1 << (VALUE_UNIQUE - 136)) | (1 << (BinaryLiteral - 136)) | (1 << (EncodedStringLiteral - 136)) | (1 << (IntegerLiteral - 136)) | (1 << (RealLiteral - 136)) | (1 << (SimpleId - 136)) | (1 << (SimpleStringLiteral - 136)))) != 0))

				@_state_number = 676
				expression()
				@_state_number = 681
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__2)


					@_state_number = 677
					match(T__2)
					@_state_number = 678
					expression()
					@_state_number = 683
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			end

			@_state_number = 686
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityDeclContext < Antlr4::Runtime::ParserRuleContext
		def entityHead()
			return rule_context("EntityHeadContext",0)
		end
		def entityBody()
			return rule_context("EntityBodyContext",0)
		end
		def END_ENTITY()
		  return token(ExpressParser::END_ENTITY, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityDecl) )
			  return visitor.visitEntityDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityDecl()
		_localctx =  EntityDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 112, RULE_entityDecl)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 688
			entityHead()
			@_state_number = 689
			entityBody()
			@_state_number = 690
			match(END_ENTITY)
			@_state_number = 691
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityHeadContext < Antlr4::Runtime::ParserRuleContext
		def ENTITY()
		  return token(ExpressParser::ENTITY, 0)
		end
		def entityId()
			return rule_context("EntityIdContext",0)
		end
		def subsuper()
			return rule_context("SubsuperContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityHead) )
			  return visitor.visitEntityHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityHead()
		_localctx =  EntityHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 114, RULE_entityHead)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 693
			match(ENTITY)
			@_state_number = 694
			entityId()
			@_state_number = 695
			subsuper()
			@_state_number = 696
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EntityIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_entityId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEntityId) )
			  return visitor.visitEntityId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def entityId()
		_localctx =  EntityIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 116, RULE_entityId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 698
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationExtensionContext < Antlr4::Runtime::ParserRuleContext
		def BASED_ON()
		  return token(ExpressParser::BASED_ON, 0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def WITH()
		  return token(ExpressParser::WITH, 0)
		end
		def enumerationItems()
			return rule_context("EnumerationItemsContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationExtension
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationExtension) )
			  return visitor.visitEnumerationExtension(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationExtension()
		_localctx =  EnumerationExtensionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 118, RULE_enumerationExtension)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 700
			match(BASED_ON)
			@_state_number = 701
			typeRef()
			@_state_number = 704
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==WITH)

				@_state_number = 702
				match(WITH)
				@_state_number = 703
				enumerationItems()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationId) )
			  return visitor.visitEnumerationId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationId()
		_localctx =  EnumerationIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 120, RULE_enumerationId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 706
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationItemsContext < Antlr4::Runtime::ParserRuleContext
		def enumerationId()
			return rule_contexts("EnumerationIdContext")
		end
		def enumerationId_i( i)
			return rule_context("EnumerationIdContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationItems
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationItems) )
			  return visitor.visitEnumerationItems(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationItems()
		_localctx =  EnumerationItemsContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 122, RULE_enumerationItems)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 708
			match(T__1)
			@_state_number = 709
			enumerationId()
			@_state_number = 714
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 710
				match(T__2)
				@_state_number = 711
				enumerationId()
				@_state_number = 716
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 717
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationReferenceContext < Antlr4::Runtime::ParserRuleContext
		def enumerationRef()
			return rule_context("EnumerationRefContext",0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationReference
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationReference) )
			  return visitor.visitEnumerationReference(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationReference()
		_localctx =  EnumerationReferenceContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 124, RULE_enumerationReference)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 722
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,38,@_ctx) )
			when 1

				@_state_number = 719
				typeRef()
				@_state_number = 720
				match(T__10)

			end
			@_state_number = 724
			enumerationRef()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EnumerationTypeContext < Antlr4::Runtime::ParserRuleContext
		def ENUMERATION()
		  return token(ExpressParser::ENUMERATION, 0)
		end
		def EXTENSIBLE()
		  return token(ExpressParser::EXTENSIBLE, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def enumerationItems()
			return rule_context("EnumerationItemsContext",0)
		end
		def enumerationExtension()
			return rule_context("EnumerationExtensionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_enumerationType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEnumerationType) )
			  return visitor.visitEnumerationType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def enumerationType()
		_localctx =  EnumerationTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 126, RULE_enumerationType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 727
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==EXTENSIBLE)

				@_state_number = 726
				match(EXTENSIBLE)
			end

			@_state_number = 729
			match(ENUMERATION)
			@_state_number = 733
			@_err_handler.sync(self)
			case (@_input.la(1))
			when OF

				@_state_number = 730
				match(OF)
				@_state_number = 731
				enumerationItems()

			when BASED_ON

				@_state_number = 732
				enumerationExtension()

			when T__0

			else
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class EscapeStmtContext < Antlr4::Runtime::ParserRuleContext
		def ESCAPE()
		  return token(ExpressParser::ESCAPE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_escapeStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitEscapeStmt) )
			  return visitor.visitEscapeStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def escapeStmt()
		_localctx =  EscapeStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 128, RULE_escapeStmt)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 735
			match(ESCAPE)
			@_state_number = 736
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ExplicitAttrContext < Antlr4::Runtime::ParserRuleContext
		def attributeDecl()
			return rule_contexts("AttributeDeclContext")
		end
		def attributeDecl_i( i)
			return rule_context("AttributeDeclContext",i)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def OPTIONAL()
		  return token(ExpressParser::OPTIONAL, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_explicitAttr
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitExplicitAttr) )
			  return visitor.visitExplicitAttr(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def explicitAttr()
		_localctx =  ExplicitAttrContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 130, RULE_explicitAttr)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 738
			attributeDecl()
			@_state_number = 743
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 739
				match(T__2)
				@_state_number = 740
				attributeDecl()
				@_state_number = 745
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 746
			match(T__8)
			@_state_number = 748
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==OPTIONAL)

				@_state_number = 747
				match(OPTIONAL)
			end

			@_state_number = 750
			parameterType()
			@_state_number = 751
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ExpressionContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_contexts("SimpleExpressionContext")
		end
		def simpleExpression_i( i)
			return rule_context("SimpleExpressionContext",i)
		end
		def relOpExtended()
			return rule_context("RelOpExtendedContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_expression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitExpression) )
			  return visitor.visitExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def expression()
		_localctx =  ExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 132, RULE_expression)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 753
			simpleExpression()
			@_state_number = 757
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__16) | (1 << T__17) | (1 << T__23) | (1 << T__24) | (1 << T__25) | (1 << T__26) | (1 << T__27) | (1 << T__28))) != 0) || _la==IN || _la==LIKE)

				@_state_number = 754
				relOpExtended()
				@_state_number = 755
				simpleExpression()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FactorContext < Antlr4::Runtime::ParserRuleContext
		def simpleFactor()
			return rule_contexts("SimpleFactorContext")
		end
		def simpleFactor_i( i)
			return rule_context("SimpleFactorContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_factor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFactor) )
			  return visitor.visitFactor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def factor()
		_localctx =  FactorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 134, RULE_factor)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 759
			simpleFactor()
			@_state_number = 762
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__12)

				@_state_number = 760
				match(T__12)
				@_state_number = 761
				simpleFactor()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FormalParameterContext < Antlr4::Runtime::ParserRuleContext
		def parameterId()
			return rule_contexts("ParameterIdContext")
		end
		def parameterId_i( i)
			return rule_context("ParameterIdContext",i)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_formalParameter
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFormalParameter) )
			  return visitor.visitFormalParameter(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def formalParameter()
		_localctx =  FormalParameterContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 136, RULE_formalParameter)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 764
			parameterId()
			@_state_number = 769
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 765
				match(T__2)
				@_state_number = 766
				parameterId()
				@_state_number = 771
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 772
			match(T__8)
			@_state_number = 773
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FunctionCallContext < Antlr4::Runtime::ParserRuleContext
		def builtInFunction()
			return rule_context("BuiltInFunctionContext",0)
		end
		def functionRef()
			return rule_context("FunctionRefContext",0)
		end
		def actualParameterList()
			return rule_context("ActualParameterListContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_functionCall
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFunctionCall) )
			  return visitor.visitFunctionCall(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def functionCall()
		_localctx =  FunctionCallContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 138, RULE_functionCall)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 777
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ABS, ExpressParser::ACOS, ExpressParser::ASIN, ExpressParser::ATAN, ExpressParser::BLENGTH, ExpressParser::COS, ExpressParser::EXISTS, ExpressParser::EXP, ExpressParser::FORMAT, ExpressParser::HIBOUND, ExpressParser::HIINDEX, ExpressParser::LENGTH, ExpressParser::LOBOUND, ExpressParser::LOG, ExpressParser::LOG10, ExpressParser::LOG2, ExpressParser::LOINDEX, ExpressParser::NVL, ExpressParser::ODD, ExpressParser::ROLESOF, ExpressParser::SIN, ExpressParser::SIZEOF, ExpressParser::SQRT, ExpressParser::TAN, ExpressParser::TYPEOF, ExpressParser::USEDIN, ExpressParser::VALUE, ExpressParser::VALUE_IN, ExpressParser::VALUE_UNIQUE

				@_state_number = 775
				builtInFunction()

			when ExpressParser::SimpleId

				@_state_number = 776
				functionRef()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
			@_state_number = 780
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 779
				actualParameterList()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FunctionDeclContext < Antlr4::Runtime::ParserRuleContext
		def functionHead()
			return rule_context("FunctionHeadContext",0)
		end
		def algorithmHead()
			return rule_context("AlgorithmHeadContext",0)
		end
		def END_FUNCTION()
		  return token(ExpressParser::END_FUNCTION, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_functionDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFunctionDecl) )
			  return visitor.visitFunctionDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def functionDecl()
		_localctx =  FunctionDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 140, RULE_functionDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 782
			functionHead()
			@_state_number = 783
			algorithmHead()
			@_state_number = 785 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 784
				stmt()
				@_state_number = 787 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
			end
			@_state_number = 789
			match(END_FUNCTION)
			@_state_number = 790
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FunctionHeadContext < Antlr4::Runtime::ParserRuleContext
		def FUNCTION()
		  return token(ExpressParser::FUNCTION, 0)
		end
		def functionId()
			return rule_context("FunctionIdContext",0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def formalParameter()
			return rule_contexts("FormalParameterContext")
		end
		def formalParameter_i( i)
			return rule_context("FormalParameterContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_functionHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFunctionHead) )
			  return visitor.visitFunctionHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def functionHead()
		_localctx =  FunctionHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 142, RULE_functionHead)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 792
			match(FUNCTION)
			@_state_number = 793
			functionId()
			@_state_number = 805
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 794
				match(T__1)
				@_state_number = 795
				formalParameter()
				@_state_number = 800
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__0)


					@_state_number = 796
					match(T__0)
					@_state_number = 797
					formalParameter()
					@_state_number = 802
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
				@_state_number = 803
				match(T__3)
			end

			@_state_number = 807
			match(T__8)
			@_state_number = 808
			parameterType()
			@_state_number = 809
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class FunctionIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_functionId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitFunctionId) )
			  return visitor.visitFunctionId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def functionId()
		_localctx =  FunctionIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 144, RULE_functionId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 811
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralizedTypesContext < Antlr4::Runtime::ParserRuleContext
		def aggregateType()
			return rule_context("AggregateTypeContext",0)
		end
		def generalAggregationTypes()
			return rule_context("GeneralAggregationTypesContext",0)
		end
		def genericEntityType()
			return rule_context("GenericEntityTypeContext",0)
		end
		def genericType()
			return rule_context("GenericTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalizedTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralizedTypes) )
			  return visitor.visitGeneralizedTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalizedTypes()
		_localctx =  GeneralizedTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 146, RULE_generalizedTypes)
		begin
			@_state_number = 817
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::AGGREGATE
				enter_outer_alt(_localctx, 1)

				@_state_number = 813
				aggregateType()

			when ExpressParser::ARRAY, ExpressParser::BAG, ExpressParser::LIST, ExpressParser::SET
				enter_outer_alt(_localctx, 2)

				@_state_number = 814
				generalAggregationTypes()

			when ExpressParser::GENERIC_ENTITY
				enter_outer_alt(_localctx, 3)

				@_state_number = 815
				genericEntityType()

			when ExpressParser::GENERIC
				enter_outer_alt(_localctx, 4)

				@_state_number = 816
				genericType()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralAggregationTypesContext < Antlr4::Runtime::ParserRuleContext
		def generalArrayType()
			return rule_context("GeneralArrayTypeContext",0)
		end
		def generalBagType()
			return rule_context("GeneralBagTypeContext",0)
		end
		def generalListType()
			return rule_context("GeneralListTypeContext",0)
		end
		def generalSetType()
			return rule_context("GeneralSetTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalAggregationTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralAggregationTypes) )
			  return visitor.visitGeneralAggregationTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalAggregationTypes()
		_localctx =  GeneralAggregationTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 148, RULE_generalAggregationTypes)
		begin
			@_state_number = 823
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ARRAY
				enter_outer_alt(_localctx, 1)

				@_state_number = 819
				generalArrayType()

			when ExpressParser::BAG
				enter_outer_alt(_localctx, 2)

				@_state_number = 820
				generalBagType()

			when ExpressParser::LIST
				enter_outer_alt(_localctx, 3)

				@_state_number = 821
				generalListType()

			when ExpressParser::SET
				enter_outer_alt(_localctx, 4)

				@_state_number = 822
				generalSetType()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralArrayTypeContext < Antlr4::Runtime::ParserRuleContext
		def ARRAY()
		  return token(ExpressParser::ARRAY, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def OPTIONAL()
		  return token(ExpressParser::OPTIONAL, 0)
		end
		def UNIQUE()
		  return token(ExpressParser::UNIQUE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalArrayType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralArrayType) )
			  return visitor.visitGeneralArrayType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalArrayType()
		_localctx =  GeneralArrayTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 150, RULE_generalArrayType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 825
			match(ARRAY)
			@_state_number = 827
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 826
				boundSpec()
			end

			@_state_number = 829
			match(OF)
			@_state_number = 831
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==OPTIONAL)

				@_state_number = 830
				match(OPTIONAL)
			end

			@_state_number = 834
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNIQUE)

				@_state_number = 833
				match(UNIQUE)
			end

			@_state_number = 836
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralBagTypeContext < Antlr4::Runtime::ParserRuleContext
		def BAG()
		  return token(ExpressParser::BAG, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalBagType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralBagType) )
			  return visitor.visitGeneralBagType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalBagType()
		_localctx =  GeneralBagTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 152, RULE_generalBagType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 838
			match(BAG)
			@_state_number = 840
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 839
				boundSpec()
			end

			@_state_number = 842
			match(OF)
			@_state_number = 843
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralListTypeContext < Antlr4::Runtime::ParserRuleContext
		def LIST()
		  return token(ExpressParser::LIST, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def UNIQUE()
		  return token(ExpressParser::UNIQUE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalListType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralListType) )
			  return visitor.visitGeneralListType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalListType()
		_localctx =  GeneralListTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 154, RULE_generalListType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 845
			match(LIST)
			@_state_number = 847
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 846
				boundSpec()
			end

			@_state_number = 849
			match(OF)
			@_state_number = 851
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNIQUE)

				@_state_number = 850
				match(UNIQUE)
			end

			@_state_number = 853
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralRefContext < Antlr4::Runtime::ParserRuleContext
		def parameterRef()
			return rule_context("ParameterRefContext",0)
		end
		def variableId()
			return rule_context("VariableIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralRef) )
			  return visitor.visitGeneralRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalRef()
		_localctx =  GeneralRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 156, RULE_generalRef)
		begin
			@_state_number = 857
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,59,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 855
				parameterRef()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 856
				variableId()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GeneralSetTypeContext < Antlr4::Runtime::ParserRuleContext
		def SET()
		  return token(ExpressParser::SET, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_generalSetType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGeneralSetType) )
			  return visitor.visitGeneralSetType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def generalSetType()
		_localctx =  GeneralSetTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 158, RULE_generalSetType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 859
			match(SET)
			@_state_number = 861
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 860
				boundSpec()
			end

			@_state_number = 863
			match(OF)
			@_state_number = 864
			parameterType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GenericEntityTypeContext < Antlr4::Runtime::ParserRuleContext
		def GENERIC_ENTITY()
		  return token(ExpressParser::GENERIC_ENTITY, 0)
		end
		def typeLabel()
			return rule_context("TypeLabelContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_genericEntityType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGenericEntityType) )
			  return visitor.visitGenericEntityType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def genericEntityType()
		_localctx =  GenericEntityTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 160, RULE_genericEntityType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 866
			match(GENERIC_ENTITY)
			@_state_number = 869
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__8)

				@_state_number = 867
				match(T__8)
				@_state_number = 868
				typeLabel()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GenericTypeContext < Antlr4::Runtime::ParserRuleContext
		def GENERIC()
		  return token(ExpressParser::GENERIC, 0)
		end
		def typeLabel()
			return rule_context("TypeLabelContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_genericType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGenericType) )
			  return visitor.visitGenericType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def genericType()
		_localctx =  GenericTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 162, RULE_genericType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 871
			match(GENERIC)
			@_state_number = 874
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__8)

				@_state_number = 872
				match(T__8)
				@_state_number = 873
				typeLabel()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class GroupQualifierContext < Antlr4::Runtime::ParserRuleContext
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_groupQualifier
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitGroupQualifier) )
			  return visitor.visitGroupQualifier(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def groupQualifier()
		_localctx =  GroupQualifierContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 164, RULE_groupQualifier)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 876
			match(T__13)
			@_state_number = 877
			entityRef()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IfStmtContext < Antlr4::Runtime::ParserRuleContext
		def IF()
		  return token(ExpressParser::IF, 0)
		end
		def logicalExpression()
			return rule_context("LogicalExpressionContext",0)
		end
		def THEN()
		  return token(ExpressParser::THEN, 0)
		end
		def END_IF()
		  return token(ExpressParser::END_IF, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def ELSE()
		  return token(ExpressParser::ELSE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ifStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIfStmt) )
			  return visitor.visitIfStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ifStmt()
		_localctx =  IfStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 166, RULE_ifStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 879
			match(IF)
			@_state_number = 880
			logicalExpression()
			@_state_number = 881
			match(THEN)
			@_state_number = 883 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 882
				stmt()
				@_state_number = 885 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
			end
			@_state_number = 893
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==ELSE)

				@_state_number = 887
				match(ELSE)
				@_state_number = 889 
				@_err_handler.sync(self)
				_la = @_input.la(1)
				loop do


					@_state_number = 888
					stmt()
					@_state_number = 891 
					@_err_handler.sync(self)
					_la = @_input.la(1)
				 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
				end
			end

			@_state_number = 895
			match(END_IF)
			@_state_number = 896
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IncrementContext < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_increment
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIncrement) )
			  return visitor.visitIncrement(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def increment()
		_localctx =  IncrementContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 168, RULE_increment)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 898
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IncrementControlContext < Antlr4::Runtime::ParserRuleContext
		def variableId()
			return rule_context("VariableIdContext",0)
		end
		def bound1()
			return rule_context("Bound1Context",0)
		end
		def TO()
		  return token(ExpressParser::TO, 0)
		end
		def bound2()
			return rule_context("Bound2Context",0)
		end
		def BY()
		  return token(ExpressParser::BY, 0)
		end
		def increment()
			return rule_context("IncrementContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_incrementControl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIncrementControl) )
			  return visitor.visitIncrementControl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def incrementControl()
		_localctx =  IncrementControlContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 170, RULE_incrementControl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 900
			variableId()
			@_state_number = 901
			match(T__9)
			@_state_number = 902
			bound1()
			@_state_number = 903
			match(TO)
			@_state_number = 904
			bound2()
			@_state_number = 907
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==BY)

				@_state_number = 905
				match(BY)
				@_state_number = 906
				increment()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IndexContext < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_index
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIndex) )
			  return visitor.visitIndex(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def index()
		_localctx =  IndexContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 172, RULE_index)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 909
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Index1Context < Antlr4::Runtime::ParserRuleContext
		def index()
			return rule_context("IndexContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_index1
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIndex1) )
			  return visitor.visitIndex1(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def index1()
		_localctx =  Index1Context.new(@_ctx, @_state_number)
		enter_rule(_localctx, 174, RULE_index1)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 911
			index()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Index2Context < Antlr4::Runtime::ParserRuleContext
		def index()
			return rule_context("IndexContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_index2
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIndex2) )
			  return visitor.visitIndex2(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def index2()
		_localctx =  Index2Context.new(@_ctx, @_state_number)
		enter_rule(_localctx, 176, RULE_index2)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 913
			index()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IndexQualifierContext < Antlr4::Runtime::ParserRuleContext
		def index1()
			return rule_context("Index1Context",0)
		end
		def index2()
			return rule_context("Index2Context",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_indexQualifier
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIndexQualifier) )
			  return visitor.visitIndexQualifier(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def indexQualifier()
		_localctx =  IndexQualifierContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 178, RULE_indexQualifier)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 915
			match(T__6)
			@_state_number = 916
			index1()
			@_state_number = 919
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__8)

				@_state_number = 917
				match(T__8)
				@_state_number = 918
				index2()
			end

			@_state_number = 921
			match(T__7)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class InstantiableTypeContext < Antlr4::Runtime::ParserRuleContext
		def concreteTypes()
			return rule_context("ConcreteTypesContext",0)
		end
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_instantiableType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitInstantiableType) )
			  return visitor.visitInstantiableType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def instantiableType()
		_localctx =  InstantiableTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 180, RULE_instantiableType)
		begin
			@_state_number = 925
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,68,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 923
				concreteTypes()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 924
				entityRef()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntegerTypeContext < Antlr4::Runtime::ParserRuleContext
		def INTEGER()
		  return token(ExpressParser::INTEGER, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_integerType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIntegerType) )
			  return visitor.visitIntegerType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def integerType()
		_localctx =  IntegerTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 182, RULE_integerType)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 927
			match(INTEGER)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class InterfaceSpecificationContext < Antlr4::Runtime::ParserRuleContext
		def referenceClause()
			return rule_context("ReferenceClauseContext",0)
		end
		def useClause()
			return rule_context("UseClauseContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_interfaceSpecification
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitInterfaceSpecification) )
			  return visitor.visitInterfaceSpecification(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def interfaceSpecification()
		_localctx =  InterfaceSpecificationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 184, RULE_interfaceSpecification)
		begin
			@_state_number = 931
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::REFERENCE
				enter_outer_alt(_localctx, 1)

				@_state_number = 929
				referenceClause()

			when ExpressParser::USE
				enter_outer_alt(_localctx, 2)

				@_state_number = 930
				useClause()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntervalContext < Antlr4::Runtime::ParserRuleContext
		def intervalLow()
			return rule_context("IntervalLowContext",0)
		end
		def intervalOp()
			return rule_contexts("IntervalOpContext")
		end
		def intervalOp_i( i)
			return rule_context("IntervalOpContext",i)
		end
		def intervalItem()
			return rule_context("IntervalItemContext",0)
		end
		def intervalHigh()
			return rule_context("IntervalHighContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_interval
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitInterval) )
			  return visitor.visitInterval(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def interval()
		_localctx =  IntervalContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 186, RULE_interval)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 933
			match(T__14)
			@_state_number = 934
			intervalLow()
			@_state_number = 935
			intervalOp()
			@_state_number = 936
			intervalItem()
			@_state_number = 937
			intervalOp()
			@_state_number = 938
			intervalHigh()
			@_state_number = 939
			match(T__15)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntervalHighContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_context("SimpleExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_intervalHigh
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIntervalHigh) )
			  return visitor.visitIntervalHigh(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def intervalHigh()
		_localctx =  IntervalHighContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 188, RULE_intervalHigh)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 941
			simpleExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntervalItemContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_context("SimpleExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_intervalItem
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIntervalItem) )
			  return visitor.visitIntervalItem(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def intervalItem()
		_localctx =  IntervalItemContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 190, RULE_intervalItem)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 943
			simpleExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntervalLowContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_context("SimpleExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_intervalLow
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIntervalLow) )
			  return visitor.visitIntervalLow(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def intervalLow()
		_localctx =  IntervalLowContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 192, RULE_intervalLow)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 945
			simpleExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class IntervalOpContext < Antlr4::Runtime::ParserRuleContext
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_intervalOp
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitIntervalOp) )
			  return visitor.visitIntervalOp(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def intervalOp()
		_localctx =  IntervalOpContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 194, RULE_intervalOp)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 947
			_la = @_input.la(1)
			if ( !(_la==T__16 || _la==T__17) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class InverseAttrContext < Antlr4::Runtime::ParserRuleContext
		def attributeDecl()
			return rule_context("AttributeDeclContext",0)
		end
		def entityRef()
			return rule_contexts("EntityRefContext")
		end
		def entityRef_i( i)
			return rule_context("EntityRefContext",i)
		end
		def FOR()
		  return token(ExpressParser::FOR, 0)
		end
		def attributeRef()
			return rule_context("AttributeRefContext",0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def SET()
		  return token(ExpressParser::SET, 0)
		end
		def BAG()
		  return token(ExpressParser::BAG, 0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_inverseAttr
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitInverseAttr) )
			  return visitor.visitInverseAttr(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def inverseAttr()
		_localctx =  InverseAttrContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 196, RULE_inverseAttr)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 949
			attributeDecl()
			@_state_number = 950
			match(T__8)
			@_state_number = 956
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==BAG || _la==SET)

				@_state_number = 951
				_la = @_input.la(1)
				if ( !(_la==BAG || _la==SET) )
				@_err_handler.recover_in_line(self)

				else
					if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
					  @matchedEOF = true
					end
					@_err_handler.report_match(self)
					consume()
				end
				@_state_number = 953
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if (_la==T__6)

					@_state_number = 952
					boundSpec()
				end

				@_state_number = 955
				match(OF)
			end

			@_state_number = 958
			entityRef()
			@_state_number = 959
			match(FOR)
			@_state_number = 963
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,72,@_ctx) )
			when 1

				@_state_number = 960
				entityRef()
				@_state_number = 961
				match(T__10)

			end
			@_state_number = 965
			attributeRef()
			@_state_number = 966
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class InverseClauseContext < Antlr4::Runtime::ParserRuleContext
		def INVERSE()
		  return token(ExpressParser::INVERSE, 0)
		end
		def inverseAttr()
			return rule_contexts("InverseAttrContext")
		end
		def inverseAttr_i( i)
			return rule_context("InverseAttrContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_inverseClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitInverseClause) )
			  return visitor.visitInverseClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def inverseClause()
		_localctx =  InverseClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 198, RULE_inverseClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 968
			match(INVERSE)
			@_state_number = 970 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 969
				inverseAttr()
				@_state_number = 972 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( _la==SELF || _la==SimpleId) )
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ListTypeContext < Antlr4::Runtime::ParserRuleContext
		def LIST()
		  return token(ExpressParser::LIST, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def instantiableType()
			return rule_context("InstantiableTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def UNIQUE()
		  return token(ExpressParser::UNIQUE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_listType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitListType) )
			  return visitor.visitListType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def listType()
		_localctx =  ListTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 200, RULE_listType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 974
			match(LIST)
			@_state_number = 976
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 975
				boundSpec()
			end

			@_state_number = 978
			match(OF)
			@_state_number = 980
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNIQUE)

				@_state_number = 979
				match(UNIQUE)
			end

			@_state_number = 982
			instantiableType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LiteralContext < Antlr4::Runtime::ParserRuleContext
		def BinaryLiteral()
		  return token(ExpressParser::BinaryLiteral, 0)
		end
		def IntegerLiteral()
		  return token(ExpressParser::IntegerLiteral, 0)
		end
		def logicalLiteral()
			return rule_context("LogicalLiteralContext",0)
		end
		def RealLiteral()
		  return token(ExpressParser::RealLiteral, 0)
		end
		def stringLiteral()
			return rule_context("StringLiteralContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_literal
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLiteral) )
			  return visitor.visitLiteral(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def literal()
		_localctx =  LiteralContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 202, RULE_literal)
		begin
			@_state_number = 989
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::BinaryLiteral
				enter_outer_alt(_localctx, 1)

				@_state_number = 984
				match(BinaryLiteral)

			when ExpressParser::IntegerLiteral
				enter_outer_alt(_localctx, 2)

				@_state_number = 985
				match(IntegerLiteral)

			when ExpressParser::FALSE, ExpressParser::TRUE, ExpressParser::UNKNOWN
				enter_outer_alt(_localctx, 3)

				@_state_number = 986
				logicalLiteral()

			when ExpressParser::RealLiteral
				enter_outer_alt(_localctx, 4)

				@_state_number = 987
				match(RealLiteral)

			when ExpressParser::EncodedStringLiteral, ExpressParser::SimpleStringLiteral
				enter_outer_alt(_localctx, 5)

				@_state_number = 988
				stringLiteral()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LocalDeclContext < Antlr4::Runtime::ParserRuleContext
		def LOCAL()
		  return token(ExpressParser::LOCAL, 0)
		end
		def END_LOCAL()
		  return token(ExpressParser::END_LOCAL, 0)
		end
		def localVariable()
			return rule_contexts("LocalVariableContext")
		end
		def localVariable_i( i)
			return rule_context("LocalVariableContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_localDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLocalDecl) )
			  return visitor.visitLocalDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def localDecl()
		_localctx =  LocalDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 204, RULE_localDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 991
			match(LOCAL)
			@_state_number = 993 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 992
				localVariable()
				@_state_number = 995 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( _la==SimpleId) )
			end
			@_state_number = 997
			match(END_LOCAL)
			@_state_number = 998
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LocalVariableContext < Antlr4::Runtime::ParserRuleContext
		def variableId()
			return rule_contexts("VariableIdContext")
		end
		def variableId_i( i)
			return rule_context("VariableIdContext",i)
		end
		def parameterType()
			return rule_context("ParameterTypeContext",0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_localVariable
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLocalVariable) )
			  return visitor.visitLocalVariable(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def localVariable()
		_localctx =  LocalVariableContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 206, RULE_localVariable)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1000
			variableId()
			@_state_number = 1005
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1001
				match(T__2)
				@_state_number = 1002
				variableId()
				@_state_number = 1007
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1008
			match(T__8)
			@_state_number = 1009
			parameterType()
			@_state_number = 1012
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__9)

				@_state_number = 1010
				match(T__9)
				@_state_number = 1011
				expression()
			end

			@_state_number = 1014
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LogicalExpressionContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_logicalExpression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLogicalExpression) )
			  return visitor.visitLogicalExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def logicalExpression()
		_localctx =  LogicalExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 208, RULE_logicalExpression)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1016
			expression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LogicalLiteralContext < Antlr4::Runtime::ParserRuleContext
		def FALSE()
		  return token(ExpressParser::FALSE, 0)
		end
		def TRUE()
		  return token(ExpressParser::TRUE, 0)
		end
		def UNKNOWN()
		  return token(ExpressParser::UNKNOWN, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_logicalLiteral
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLogicalLiteral) )
			  return visitor.visitLogicalLiteral(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def logicalLiteral()
		_localctx =  LogicalLiteralContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 210, RULE_logicalLiteral)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1018
			_la = @_input.la(1)
			if ( !(_la==FALSE || _la==TRUE || _la==UNKNOWN) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class LogicalTypeContext < Antlr4::Runtime::ParserRuleContext
		def LOGICAL()
		  return token(ExpressParser::LOGICAL, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_logicalType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitLogicalType) )
			  return visitor.visitLogicalType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def logicalType()
		_localctx =  LogicalTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 212, RULE_logicalType)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1020
			match(LOGICAL)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class MultiplicationLikeOpContext < Antlr4::Runtime::ParserRuleContext
		def DIV()
		  return token(ExpressParser::DIV, 0)
		end
		def MOD()
		  return token(ExpressParser::MOD, 0)
		end
		def AND()
		  return token(ExpressParser::AND, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_multiplicationLikeOp
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitMultiplicationLikeOp) )
			  return visitor.visitMultiplicationLikeOp(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def multiplicationLikeOp()
		_localctx =  MultiplicationLikeOpContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 214, RULE_multiplicationLikeOp)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1022
			_la = @_input.la(1)
			if ( !((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__18) | (1 << T__19) | (1 << T__20) | (1 << AND) | (1 << DIV))) != 0) || _la==MOD) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class NamedTypesContext < Antlr4::Runtime::ParserRuleContext
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_namedTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitNamedTypes) )
			  return visitor.visitNamedTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def namedTypes()
		_localctx =  NamedTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 216, RULE_namedTypes)
		begin
			@_state_number = 1026
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,80,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1024
				entityRef()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1025
				typeRef()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class NamedTypeOrRenameContext < Antlr4::Runtime::ParserRuleContext
		def namedTypes()
			return rule_context("NamedTypesContext",0)
		end
		def AS()
		  return token(ExpressParser::AS, 0)
		end
		def entityId()
			return rule_context("EntityIdContext",0)
		end
		def typeId()
			return rule_context("TypeIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_namedTypeOrRename
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitNamedTypeOrRename) )
			  return visitor.visitNamedTypeOrRename(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def namedTypeOrRename()
		_localctx =  NamedTypeOrRenameContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 218, RULE_namedTypeOrRename)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1028
			namedTypes()
			@_state_number = 1034
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==AS)

				@_state_number = 1029
				match(AS)
				@_state_number = 1032
				@_err_handler.sync(self)
				case ( @_interp.adaptive_predict(@_input,81,@_ctx) )
				when 1

					@_state_number = 1030
					entityId()

				when 2

					@_state_number = 1031
					typeId()

				end
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class NullStmtContext < Antlr4::Runtime::ParserRuleContext
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_nullStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitNullStmt) )
			  return visitor.visitNullStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def nullStmt()
		_localctx =  NullStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 220, RULE_nullStmt)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1036
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class NumberTypeContext < Antlr4::Runtime::ParserRuleContext
		def NUMBER()
		  return token(ExpressParser::NUMBER, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_numberType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitNumberType) )
			  return visitor.visitNumberType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def numberType()
		_localctx =  NumberTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 222, RULE_numberType)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1038
			match(NUMBER)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class NumericExpressionContext < Antlr4::Runtime::ParserRuleContext
		def simpleExpression()
			return rule_context("SimpleExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_numericExpression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitNumericExpression) )
			  return visitor.visitNumericExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def numericExpression()
		_localctx =  NumericExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 224, RULE_numericExpression)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1040
			simpleExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class OneOfContext < Antlr4::Runtime::ParserRuleContext
		def ONEOF()
		  return token(ExpressParser::ONEOF, 0)
		end
		def supertypeExpression()
			return rule_contexts("SupertypeExpressionContext")
		end
		def supertypeExpression_i( i)
			return rule_context("SupertypeExpressionContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_oneOf
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitOneOf) )
			  return visitor.visitOneOf(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def oneOf()
		_localctx =  OneOfContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 226, RULE_oneOf)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1042
			match(ONEOF)
			@_state_number = 1043
			match(T__1)
			@_state_number = 1044
			supertypeExpression()
			@_state_number = 1049
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1045
				match(T__2)
				@_state_number = 1046
				supertypeExpression()
				@_state_number = 1051
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1052
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ParameterContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_parameter
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitParameter) )
			  return visitor.visitParameter(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def parameter()
		_localctx =  ParameterContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 228, RULE_parameter)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1054
			expression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ParameterIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_parameterId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitParameterId) )
			  return visitor.visitParameterId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def parameterId()
		_localctx =  ParameterIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 230, RULE_parameterId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1056
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ParameterTypeContext < Antlr4::Runtime::ParserRuleContext
		def generalizedTypes()
			return rule_context("GeneralizedTypesContext",0)
		end
		def namedTypes()
			return rule_context("NamedTypesContext",0)
		end
		def simpleTypes()
			return rule_context("SimpleTypesContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_parameterType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitParameterType) )
			  return visitor.visitParameterType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def parameterType()
		_localctx =  ParameterTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 232, RULE_parameterType)
		begin
			@_state_number = 1061
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::AGGREGATE, ExpressParser::ARRAY, ExpressParser::BAG, ExpressParser::GENERIC, ExpressParser::GENERIC_ENTITY, ExpressParser::LIST, ExpressParser::SET
				enter_outer_alt(_localctx, 1)

				@_state_number = 1058
				generalizedTypes()

			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 2)

				@_state_number = 1059
				namedTypes()

			when ExpressParser::BINARY, ExpressParser::BOOLEAN, ExpressParser::INTEGER, ExpressParser::LOGICAL, ExpressParser::NUMBER, ExpressParser::REAL, ExpressParser::STRING
				enter_outer_alt(_localctx, 3)

				@_state_number = 1060
				simpleTypes()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class PopulationContext < Antlr4::Runtime::ParserRuleContext
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_population
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitPopulation) )
			  return visitor.visitPopulation(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def population()
		_localctx =  PopulationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 234, RULE_population)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1063
			entityRef()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class PrecisionSpecContext < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_precisionSpec
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitPrecisionSpec) )
			  return visitor.visitPrecisionSpec(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def precisionSpec()
		_localctx =  PrecisionSpecContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 236, RULE_precisionSpec)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1065
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class PrimaryContext < Antlr4::Runtime::ParserRuleContext
		def literal()
			return rule_context("LiteralContext",0)
		end
		def qualifiableFactor()
			return rule_context("QualifiableFactorContext",0)
		end
		def qualifier()
			return rule_contexts("QualifierContext")
		end
		def qualifier_i( i)
			return rule_context("QualifierContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_primary
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitPrimary) )
			  return visitor.visitPrimary(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def primary()
		_localctx =  PrimaryContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 238, RULE_primary)
		_la = 0
		begin
			@_state_number = 1075
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::FALSE, ExpressParser::TRUE, ExpressParser::UNKNOWN, ExpressParser::BinaryLiteral, ExpressParser::EncodedStringLiteral, ExpressParser::IntegerLiteral, ExpressParser::RealLiteral, ExpressParser::SimpleStringLiteral
				enter_outer_alt(_localctx, 1)

				@_state_number = 1067
				literal()

			when ExpressParser::T__11, ExpressParser::ABS, ExpressParser::ACOS, ExpressParser::ASIN, ExpressParser::ATAN, ExpressParser::BLENGTH, ExpressParser::CONST_E, ExpressParser::COS, ExpressParser::EXISTS, ExpressParser::EXP, ExpressParser::FORMAT, ExpressParser::HIBOUND, ExpressParser::HIINDEX, ExpressParser::LENGTH, ExpressParser::LOBOUND, ExpressParser::LOG, ExpressParser::LOG10, ExpressParser::LOG2, ExpressParser::LOINDEX, ExpressParser::NVL, ExpressParser::ODD, ExpressParser::PI, ExpressParser::ROLESOF, ExpressParser::SELF, ExpressParser::SIN, ExpressParser::SIZEOF, ExpressParser::SQRT, ExpressParser::TAN, ExpressParser::TYPEOF, ExpressParser::USEDIN, ExpressParser::VALUE, ExpressParser::VALUE_IN, ExpressParser::VALUE_UNIQUE, ExpressParser::SimpleId
				enter_outer_alt(_localctx, 2)

				@_state_number = 1068
				qualifiableFactor()
				@_state_number = 1072
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__6) | (1 << T__10) | (1 << T__13))) != 0))


					@_state_number = 1069
					qualifier()
					@_state_number = 1074
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ProcedureCallStmtContext < Antlr4::Runtime::ParserRuleContext
		def builtInProcedure()
			return rule_context("BuiltInProcedureContext",0)
		end
		def procedureRef()
			return rule_context("ProcedureRefContext",0)
		end
		def actualParameterList()
			return rule_context("ActualParameterListContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_procedureCallStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitProcedureCallStmt) )
			  return visitor.visitProcedureCallStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def procedureCallStmt()
		_localctx =  ProcedureCallStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 240, RULE_procedureCallStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1079
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::INSERT, ExpressParser::REMOVE

				@_state_number = 1077
				builtInProcedure()

			when ExpressParser::SimpleId

				@_state_number = 1078
				procedureRef()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
			@_state_number = 1082
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1081
				actualParameterList()
			end

			@_state_number = 1084
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ProcedureDeclContext < Antlr4::Runtime::ParserRuleContext
		def procedureHead()
			return rule_context("ProcedureHeadContext",0)
		end
		def algorithmHead()
			return rule_context("AlgorithmHeadContext",0)
		end
		def END_PROCEDURE()
		  return token(ExpressParser::END_PROCEDURE, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_procedureDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitProcedureDecl) )
			  return visitor.visitProcedureDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def procedureDecl()
		_localctx =  ProcedureDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 242, RULE_procedureDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1086
			procedureHead()
			@_state_number = 1087
			algorithmHead()
			@_state_number = 1091
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId)


				@_state_number = 1088
				stmt()
				@_state_number = 1093
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1094
			match(END_PROCEDURE)
			@_state_number = 1095
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ProcedureHeadContext < Antlr4::Runtime::ParserRuleContext
		def PROCEDURE()
		  return token(ExpressParser::PROCEDURE, 0)
		end
		def procedureId()
			return rule_context("ProcedureIdContext",0)
		end
		def formalParameter()
			return rule_contexts("FormalParameterContext")
		end
		def formalParameter_i( i)
			return rule_context("FormalParameterContext",i)
		end
		def VAR()
		 return tokens(ExpressParser::VAR)
		end
		def VAR_i( i)
			return token(ExpressParser::VAR, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_procedureHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitProcedureHead) )
			  return visitor.visitProcedureHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def procedureHead()
		_localctx =  ProcedureHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 244, RULE_procedureHead)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1097
			match(PROCEDURE)
			@_state_number = 1098
			procedureId()
			@_state_number = 1116
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1099
				match(T__1)
				@_state_number = 1101
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if (_la==VAR)

					@_state_number = 1100
					match(VAR)
				end

				@_state_number = 1103
				formalParameter()
				@_state_number = 1111
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__0)


					@_state_number = 1104
					match(T__0)
					@_state_number = 1106
					@_err_handler.sync(self)
					_la = @_input.la(1)
					if (_la==VAR)

						@_state_number = 1105
						match(VAR)
					end

					@_state_number = 1108
					formalParameter()
					@_state_number = 1113
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
				@_state_number = 1114
				match(T__3)
			end

			@_state_number = 1118
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ProcedureIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_procedureId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitProcedureId) )
			  return visitor.visitProcedureId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def procedureId()
		_localctx =  ProcedureIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 246, RULE_procedureId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1120
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class QualifiableFactorContext < Antlr4::Runtime::ParserRuleContext
		def attributeRef()
			return rule_context("AttributeRefContext",0)
		end
		def constantFactor()
			return rule_context("ConstantFactorContext",0)
		end
		def functionCall()
			return rule_context("FunctionCallContext",0)
		end
		def generalRef()
			return rule_context("GeneralRefContext",0)
		end
		def population()
			return rule_context("PopulationContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_qualifiableFactor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitQualifiableFactor) )
			  return visitor.visitQualifiableFactor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def qualifiableFactor()
		_localctx =  QualifiableFactorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 248, RULE_qualifiableFactor)
		begin
			@_state_number = 1127
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,94,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1122
				attributeRef()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1123
				constantFactor()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1124
				functionCall()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 1125
				generalRef()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 1126
				population()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class QualifiedAttributeContext < Antlr4::Runtime::ParserRuleContext
		def SELF()
		  return token(ExpressParser::SELF, 0)
		end
		def groupQualifier()
			return rule_context("GroupQualifierContext",0)
		end
		def attributeQualifier()
			return rule_context("AttributeQualifierContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_qualifiedAttribute
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitQualifiedAttribute) )
			  return visitor.visitQualifiedAttribute(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def qualifiedAttribute()
		_localctx =  QualifiedAttributeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 250, RULE_qualifiedAttribute)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1129
			match(SELF)
			@_state_number = 1130
			groupQualifier()
			@_state_number = 1131
			attributeQualifier()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class QualifierContext < Antlr4::Runtime::ParserRuleContext
		def attributeQualifier()
			return rule_context("AttributeQualifierContext",0)
		end
		def groupQualifier()
			return rule_context("GroupQualifierContext",0)
		end
		def indexQualifier()
			return rule_context("IndexQualifierContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_qualifier
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitQualifier) )
			  return visitor.visitQualifier(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def qualifier()
		_localctx =  QualifierContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 252, RULE_qualifier)
		begin
			@_state_number = 1136
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::T__10
				enter_outer_alt(_localctx, 1)

				@_state_number = 1133
				attributeQualifier()

			when ExpressParser::T__13
				enter_outer_alt(_localctx, 2)

				@_state_number = 1134
				groupQualifier()

			when ExpressParser::T__6
				enter_outer_alt(_localctx, 3)

				@_state_number = 1135
				indexQualifier()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class QueryExpressionContext < Antlr4::Runtime::ParserRuleContext
		def QUERY()
		  return token(ExpressParser::QUERY, 0)
		end
		def variableId()
			return rule_context("VariableIdContext",0)
		end
		def aggregateSource()
			return rule_context("AggregateSourceContext",0)
		end
		def logicalExpression()
			return rule_context("LogicalExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_queryExpression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitQueryExpression) )
			  return visitor.visitQueryExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def queryExpression()
		_localctx =  QueryExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 254, RULE_queryExpression)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1138
			match(QUERY)
			@_state_number = 1139
			match(T__1)
			@_state_number = 1140
			variableId()
			@_state_number = 1141
			match(T__21)
			@_state_number = 1142
			aggregateSource()
			@_state_number = 1143
			match(T__22)
			@_state_number = 1144
			logicalExpression()
			@_state_number = 1145
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RealTypeContext < Antlr4::Runtime::ParserRuleContext
		def REAL()
		  return token(ExpressParser::REAL, 0)
		end
		def precisionSpec()
			return rule_context("PrecisionSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_realType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRealType) )
			  return visitor.visitRealType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def realType()
		_localctx =  RealTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 256, RULE_realType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1147
			match(REAL)
			@_state_number = 1152
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1148
				match(T__1)
				@_state_number = 1149
				precisionSpec()
				@_state_number = 1150
				match(T__3)
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RedeclaredAttributeContext < Antlr4::Runtime::ParserRuleContext
		def qualifiedAttribute()
			return rule_context("QualifiedAttributeContext",0)
		end
		def RENAMED()
		  return token(ExpressParser::RENAMED, 0)
		end
		def attributeId()
			return rule_context("AttributeIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_redeclaredAttribute
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRedeclaredAttribute) )
			  return visitor.visitRedeclaredAttribute(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def redeclaredAttribute()
		_localctx =  RedeclaredAttributeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 258, RULE_redeclaredAttribute)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1154
			qualifiedAttribute()
			@_state_number = 1157
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==RENAMED)

				@_state_number = 1155
				match(RENAMED)
				@_state_number = 1156
				attributeId()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ReferencedAttributeContext < Antlr4::Runtime::ParserRuleContext
		def attributeRef()
			return rule_context("AttributeRefContext",0)
		end
		def qualifiedAttribute()
			return rule_context("QualifiedAttributeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_referencedAttribute
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitReferencedAttribute) )
			  return visitor.visitReferencedAttribute(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def referencedAttribute()
		_localctx =  ReferencedAttributeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 260, RULE_referencedAttribute)
		begin
			@_state_number = 1161
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 1)

				@_state_number = 1159
				attributeRef()

			when ExpressParser::SELF
				enter_outer_alt(_localctx, 2)

				@_state_number = 1160
				qualifiedAttribute()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ReferenceClauseContext < Antlr4::Runtime::ParserRuleContext
		def REFERENCE()
		  return token(ExpressParser::REFERENCE, 0)
		end
		def FROM()
		  return token(ExpressParser::FROM, 0)
		end
		def schemaRef()
			return rule_context("SchemaRefContext",0)
		end
		def resourceOrRename()
			return rule_contexts("ResourceOrRenameContext")
		end
		def resourceOrRename_i( i)
			return rule_context("ResourceOrRenameContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_referenceClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitReferenceClause) )
			  return visitor.visitReferenceClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def referenceClause()
		_localctx =  ReferenceClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 262, RULE_referenceClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1163
			match(REFERENCE)
			@_state_number = 1164
			match(FROM)
			@_state_number = 1165
			schemaRef()
			@_state_number = 1177
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1166
				match(T__1)
				@_state_number = 1167
				resourceOrRename()
				@_state_number = 1172
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__2)


					@_state_number = 1168
					match(T__2)
					@_state_number = 1169
					resourceOrRename()
					@_state_number = 1174
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
				@_state_number = 1175
				match(T__3)
			end

			@_state_number = 1179
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RelOpContext < Antlr4::Runtime::ParserRuleContext
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_relOp
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRelOp) )
			  return visitor.visitRelOp(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def relOp()
		_localctx =  RelOpContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 264, RULE_relOp)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1181
			_la = @_input.la(1)
			if ( !((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__16) | (1 << T__17) | (1 << T__23) | (1 << T__24) | (1 << T__25) | (1 << T__26) | (1 << T__27) | (1 << T__28))) != 0)) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RelOpExtendedContext < Antlr4::Runtime::ParserRuleContext
		def relOp()
			return rule_context("RelOpContext",0)
		end
		def IN()
		  return token(ExpressParser::IN, 0)
		end
		def LIKE()
		  return token(ExpressParser::LIKE, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_relOpExtended
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRelOpExtended) )
			  return visitor.visitRelOpExtended(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def relOpExtended()
		_localctx =  RelOpExtendedContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 266, RULE_relOpExtended)
		begin
			@_state_number = 1186
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::T__16, ExpressParser::T__17, ExpressParser::T__23, ExpressParser::T__24, ExpressParser::T__25, ExpressParser::T__26, ExpressParser::T__27, ExpressParser::T__28
				enter_outer_alt(_localctx, 1)

				@_state_number = 1183
				relOp()

			when ExpressParser::IN
				enter_outer_alt(_localctx, 2)

				@_state_number = 1184
				match(IN)

			when ExpressParser::LIKE
				enter_outer_alt(_localctx, 3)

				@_state_number = 1185
				match(LIKE)
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RenameIdContext < Antlr4::Runtime::ParserRuleContext
		def constantId()
			return rule_context("ConstantIdContext",0)
		end
		def entityId()
			return rule_context("EntityIdContext",0)
		end
		def functionId()
			return rule_context("FunctionIdContext",0)
		end
		def procedureId()
			return rule_context("ProcedureIdContext",0)
		end
		def typeId()
			return rule_context("TypeIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_renameId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRenameId) )
			  return visitor.visitRenameId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def renameId()
		_localctx =  RenameIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 268, RULE_renameId)
		begin
			@_state_number = 1193
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,102,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1188
				constantId()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1189
				entityId()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1190
				functionId()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 1191
				procedureId()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 1192
				typeId()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RepeatControlContext < Antlr4::Runtime::ParserRuleContext
		def incrementControl()
			return rule_context("IncrementControlContext",0)
		end
		def whileControl()
			return rule_context("WhileControlContext",0)
		end
		def untilControl()
			return rule_context("UntilControlContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_repeatControl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRepeatControl) )
			  return visitor.visitRepeatControl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def repeatControl()
		_localctx =  RepeatControlContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 270, RULE_repeatControl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1196
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==SimpleId)

				@_state_number = 1195
				incrementControl()
			end

			@_state_number = 1199
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==WHILE)

				@_state_number = 1198
				whileControl()
			end

			@_state_number = 1202
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==UNTIL)

				@_state_number = 1201
				untilControl()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RepeatStmtContext < Antlr4::Runtime::ParserRuleContext
		def REPEAT()
		  return token(ExpressParser::REPEAT, 0)
		end
		def repeatControl()
			return rule_context("RepeatControlContext",0)
		end
		def END_REPEAT()
		  return token(ExpressParser::END_REPEAT, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_repeatStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRepeatStmt) )
			  return visitor.visitRepeatStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def repeatStmt()
		_localctx =  RepeatStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 272, RULE_repeatStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1204
			match(REPEAT)
			@_state_number = 1205
			repeatControl()
			@_state_number = 1206
			match(T__0)
			@_state_number = 1208 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 1207
				stmt()
				@_state_number = 1210 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( (((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId) )
			end
			@_state_number = 1212
			match(END_REPEAT)
			@_state_number = 1213
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RepetitionContext < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_repetition
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRepetition) )
			  return visitor.visitRepetition(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def repetition()
		_localctx =  RepetitionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 274, RULE_repetition)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1215
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ResourceOrRenameContext < Antlr4::Runtime::ParserRuleContext
		def resourceRef()
			return rule_context("ResourceRefContext",0)
		end
		def AS()
		  return token(ExpressParser::AS, 0)
		end
		def renameId()
			return rule_context("RenameIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_resourceOrRename
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitResourceOrRename) )
			  return visitor.visitResourceOrRename(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def resourceOrRename()
		_localctx =  ResourceOrRenameContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 276, RULE_resourceOrRename)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1217
			resourceRef()
			@_state_number = 1220
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==AS)

				@_state_number = 1218
				match(AS)
				@_state_number = 1219
				renameId()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ResourceRefContext < Antlr4::Runtime::ParserRuleContext
		def constantRef()
			return rule_context("ConstantRefContext",0)
		end
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def functionRef()
			return rule_context("FunctionRefContext",0)
		end
		def procedureRef()
			return rule_context("ProcedureRefContext",0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_resourceRef
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitResourceRef) )
			  return visitor.visitResourceRef(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def resourceRef()
		_localctx =  ResourceRefContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 278, RULE_resourceRef)
		begin
			@_state_number = 1227
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,108,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1222
				constantRef()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1223
				entityRef()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1224
				functionRef()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 1225
				procedureRef()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 1226
				typeRef()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class ReturnStmtContext < Antlr4::Runtime::ParserRuleContext
		def RETURN()
		  return token(ExpressParser::RETURN, 0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_returnStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitReturnStmt) )
			  return visitor.visitReturnStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def returnStmt()
		_localctx =  ReturnStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 280, RULE_returnStmt)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1229
			match(RETURN)
			@_state_number = 1234
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1230
				match(T__1)
				@_state_number = 1231
				expression()
				@_state_number = 1232
				match(T__3)
			end

			@_state_number = 1236
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleDeclContext < Antlr4::Runtime::ParserRuleContext
		def ruleHead()
			return rule_context("RuleHeadContext",0)
		end
		def algorithmHead()
			return rule_context("AlgorithmHeadContext",0)
		end
		def whereClause()
			return rule_context("WhereClauseContext",0)
		end
		def END_RULE()
		  return token(ExpressParser::END_RULE, 0)
		end
		def stmt()
			return rule_contexts("StmtContext")
		end
		def stmt_i( i)
			return rule_context("StmtContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleDecl) )
			  return visitor.visitRuleDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleDecl()
		_localctx =  RuleDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 282, RULE_ruleDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1238
			ruleHead()
			@_state_number = 1239
			algorithmHead()
			@_state_number = 1243
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__0) | (1 << ALIAS) | (1 << BEGIN_) | (1 << CASE))) != 0) || ((((_la - 71)) & ~0x3f) == 0 && ((1 << (_la - 71)) & ((1 << (ESCAPE - 71)) | (1 << (IF - 71)) | (1 << (INSERT - 71)) | (1 << (REMOVE - 71)) | (1 << (REPEAT - 71)) | (1 << (RETURN - 71)) | (1 << (SKIP_ - 71)))) != 0) || _la==SimpleId)


				@_state_number = 1240
				stmt()
				@_state_number = 1245
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1246
			whereClause()
			@_state_number = 1247
			match(END_RULE)
			@_state_number = 1248
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleHeadContext < Antlr4::Runtime::ParserRuleContext
		def RULE()
		  return token(ExpressParser::RULE, 0)
		end
		def ruleId()
			return rule_context("RuleIdContext",0)
		end
		def FOR()
		  return token(ExpressParser::FOR, 0)
		end
		def entityRef()
			return rule_contexts("EntityRefContext")
		end
		def entityRef_i( i)
			return rule_context("EntityRefContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleHead) )
			  return visitor.visitRuleHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleHead()
		_localctx =  RuleHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 284, RULE_ruleHead)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1250
			match(RULE)
			@_state_number = 1251
			ruleId()
			@_state_number = 1252
			match(FOR)
			@_state_number = 1253
			match(T__1)
			@_state_number = 1254
			entityRef()
			@_state_number = 1259
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1255
				match(T__2)
				@_state_number = 1256
				entityRef()
				@_state_number = 1261
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1262
			match(T__3)
			@_state_number = 1263
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleId) )
			  return visitor.visitRuleId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleId()
		_localctx =  RuleIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 286, RULE_ruleId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1265
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class RuleLabelIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_ruleLabelId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitRuleLabelId) )
			  return visitor.visitRuleLabelId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def ruleLabelId()
		_localctx =  RuleLabelIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 288, RULE_ruleLabelId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1267
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SchemaBodyContext < Antlr4::Runtime::ParserRuleContext
		def interfaceSpecification()
			return rule_contexts("InterfaceSpecificationContext")
		end
		def interfaceSpecification_i( i)
			return rule_context("InterfaceSpecificationContext",i)
		end
		def constantDecl()
			return rule_context("ConstantDeclContext",0)
		end
		def declaration()
			return rule_contexts("DeclarationContext")
		end
		def declaration_i( i)
			return rule_context("DeclarationContext",i)
		end
		def ruleDecl()
			return rule_contexts("RuleDeclContext")
		end
		def ruleDecl_i( i)
			return rule_context("RuleDeclContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_schemaBody
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSchemaBody) )
			  return visitor.visitSchemaBody(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def schemaBody()
		_localctx =  SchemaBodyContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 290, RULE_schemaBody)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1272
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==REFERENCE || _la==USE)


				@_state_number = 1269
				interfaceSpecification()
				@_state_number = 1274
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1276
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==CONSTANT)

				@_state_number = 1275
				constantDecl()
			end

			@_state_number = 1282
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (((((_la - 69)) & ~0x3f) == 0 && ((1 << (_la - 69)) & ((1 << (ENTITY - 69)) | (1 << (FUNCTION - 69)) | (1 << (PROCEDURE - 69)) | (1 << (RULE - 69)) | (1 << (SUBTYPE_CONSTRAINT - 69)))) != 0) || _la==TYPE)

				@_state_number = 1280
				@_err_handler.sync(self)
				case (@_input.la(1))
				when ExpressParser::ENTITY, ExpressParser::FUNCTION, ExpressParser::PROCEDURE, ExpressParser::SUBTYPE_CONSTRAINT, ExpressParser::TYPE

					@_state_number = 1278
					declaration()

				when ExpressParser::RULE

					@_state_number = 1279
					ruleDecl()
				else
					raise Antlr4::Runtime::NoViableAltException, self
				end
				@_state_number = 1284
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SchemaDeclContext < Antlr4::Runtime::ParserRuleContext
		def SCHEMA()
		  return token(ExpressParser::SCHEMA, 0)
		end
		def schemaId()
			return rule_context("SchemaIdContext",0)
		end
		def schemaBody()
			return rule_context("SchemaBodyContext",0)
		end
		def END_SCHEMA()
		  return token(ExpressParser::END_SCHEMA, 0)
		end
		def schemaVersionId()
			return rule_context("SchemaVersionIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_schemaDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSchemaDecl) )
			  return visitor.visitSchemaDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def schemaDecl()
		_localctx =  SchemaDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 292, RULE_schemaDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1285
			match(SCHEMA)
			@_state_number = 1286
			schemaId()
			@_state_number = 1288
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==EncodedStringLiteral || _la==SimpleStringLiteral)

				@_state_number = 1287
				schemaVersionId()
			end

			@_state_number = 1290
			match(T__0)
			@_state_number = 1291
			schemaBody()
			@_state_number = 1292
			match(END_SCHEMA)
			@_state_number = 1293
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SchemaIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_schemaId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSchemaId) )
			  return visitor.visitSchemaId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def schemaId()
		_localctx =  SchemaIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 294, RULE_schemaId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1295
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SchemaVersionIdContext < Antlr4::Runtime::ParserRuleContext
		def stringLiteral()
			return rule_context("StringLiteralContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_schemaVersionId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSchemaVersionId) )
			  return visitor.visitSchemaVersionId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def schemaVersionId()
		_localctx =  SchemaVersionIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 296, RULE_schemaVersionId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1297
			stringLiteral()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SelectorContext < Antlr4::Runtime::ParserRuleContext
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_selector
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSelector) )
			  return visitor.visitSelector(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def selector()
		_localctx =  SelectorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 298, RULE_selector)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1299
			expression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SelectExtensionContext < Antlr4::Runtime::ParserRuleContext
		def BASED_ON()
		  return token(ExpressParser::BASED_ON, 0)
		end
		def typeRef()
			return rule_context("TypeRefContext",0)
		end
		def WITH()
		  return token(ExpressParser::WITH, 0)
		end
		def selectList()
			return rule_context("SelectListContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_selectExtension
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSelectExtension) )
			  return visitor.visitSelectExtension(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def selectExtension()
		_localctx =  SelectExtensionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 300, RULE_selectExtension)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1301
			match(BASED_ON)
			@_state_number = 1302
			typeRef()
			@_state_number = 1305
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==WITH)

				@_state_number = 1303
				match(WITH)
				@_state_number = 1304
				selectList()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SelectListContext < Antlr4::Runtime::ParserRuleContext
		def namedTypes()
			return rule_contexts("NamedTypesContext")
		end
		def namedTypes_i( i)
			return rule_context("NamedTypesContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_selectList
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSelectList) )
			  return visitor.visitSelectList(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def selectList()
		_localctx =  SelectListContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 302, RULE_selectList)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1307
			match(T__1)
			@_state_number = 1308
			namedTypes()
			@_state_number = 1313
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1309
				match(T__2)
				@_state_number = 1310
				namedTypes()
				@_state_number = 1315
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1316
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SelectTypeContext < Antlr4::Runtime::ParserRuleContext
		def SELECT()
		  return token(ExpressParser::SELECT, 0)
		end
		def EXTENSIBLE()
		  return token(ExpressParser::EXTENSIBLE, 0)
		end
		def selectList()
			return rule_context("SelectListContext",0)
		end
		def selectExtension()
			return rule_context("SelectExtensionContext",0)
		end
		def GENERIC_ENTITY()
		  return token(ExpressParser::GENERIC_ENTITY, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_selectType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSelectType) )
			  return visitor.visitSelectType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def selectType()
		_localctx =  SelectTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 304, RULE_selectType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1322
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==EXTENSIBLE)

				@_state_number = 1318
				match(EXTENSIBLE)
				@_state_number = 1320
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if (_la==GENERIC_ENTITY)

					@_state_number = 1319
					match(GENERIC_ENTITY)
				end

			end

			@_state_number = 1324
			match(SELECT)
			@_state_number = 1327
			@_err_handler.sync(self)
			case (@_input.la(1))
			when T__1

				@_state_number = 1325
				selectList()

			when BASED_ON

				@_state_number = 1326
				selectExtension()

			when T__0

			else
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SetTypeContext < Antlr4::Runtime::ParserRuleContext
		def SET()
		  return token(ExpressParser::SET, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def instantiableType()
			return rule_context("InstantiableTypeContext",0)
		end
		def boundSpec()
			return rule_context("BoundSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_setType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSetType) )
			  return visitor.visitSetType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def setType()
		_localctx =  SetTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 306, RULE_setType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1329
			match(SET)
			@_state_number = 1331
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__6)

				@_state_number = 1330
				boundSpec()
			end

			@_state_number = 1333
			match(OF)
			@_state_number = 1334
			instantiableType()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SimpleExpressionContext < Antlr4::Runtime::ParserRuleContext
		def term()
			return rule_contexts("TermContext")
		end
		def term_i( i)
			return rule_context("TermContext",i)
		end
		def addLikeOp()
			return rule_contexts("AddLikeOpContext")
		end
		def addLikeOp_i( i)
			return rule_context("AddLikeOpContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_simpleExpression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSimpleExpression) )
			  return visitor.visitSimpleExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def simpleExpression()
		_localctx =  SimpleExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 308, RULE_simpleExpression)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1336
			term()
			@_state_number = 1342
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__4 || _la==T__5 || _la==OR || _la==XOR)


				@_state_number = 1337
				addLikeOp()
				@_state_number = 1338
				term()
				@_state_number = 1344
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SimpleFactorContext < Antlr4::Runtime::ParserRuleContext
		def aggregateInitializer()
			return rule_context("AggregateInitializerContext",0)
		end
		def entityConstructor()
			return rule_context("EntityConstructorContext",0)
		end
		def enumerationReference()
			return rule_context("EnumerationReferenceContext",0)
		end
		def interval()
			return rule_context("IntervalContext",0)
		end
		def queryExpression()
			return rule_context("QueryExpressionContext",0)
		end
		def expression()
			return rule_context("ExpressionContext",0)
		end
		def primary()
			return rule_context("PrimaryContext",0)
		end
		def unaryOp()
			return rule_context("UnaryOpContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_simpleFactor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSimpleFactor) )
			  return visitor.visitSimpleFactor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def simpleFactor()
		_localctx =  SimpleFactorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 310, RULE_simpleFactor)
		_la = 0
		begin
			@_state_number = 1360
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,126,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1345
				aggregateInitializer()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1346
				entityConstructor()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1347
				enumerationReference()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 1348
				interval()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 1349
				queryExpression()

			when 6
				enter_outer_alt(_localctx, 6)


				@_state_number = 1351
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if (_la==T__4 || _la==T__5 || _la==NOT)

					@_state_number = 1350
					unaryOp()
				end

				@_state_number = 1358
				@_err_handler.sync(self)
				case (@_input.la(1))
				when ExpressParser::T__1

					@_state_number = 1353
					match(T__1)
					@_state_number = 1354
					expression()
					@_state_number = 1355
					match(T__3)

				when ExpressParser::T__11, ExpressParser::ABS, ExpressParser::ACOS, ExpressParser::ASIN, ExpressParser::ATAN, ExpressParser::BLENGTH, ExpressParser::CONST_E, ExpressParser::COS, ExpressParser::EXISTS, ExpressParser::EXP, ExpressParser::FALSE, ExpressParser::FORMAT, ExpressParser::HIBOUND, ExpressParser::HIINDEX, ExpressParser::LENGTH, ExpressParser::LOBOUND, ExpressParser::LOG, ExpressParser::LOG10, ExpressParser::LOG2, ExpressParser::LOINDEX, ExpressParser::NVL, ExpressParser::ODD, ExpressParser::PI, ExpressParser::ROLESOF, ExpressParser::SELF, ExpressParser::SIN, ExpressParser::SIZEOF, ExpressParser::SQRT, ExpressParser::TAN, ExpressParser::TRUE, ExpressParser::TYPEOF, ExpressParser::UNKNOWN, ExpressParser::USEDIN, ExpressParser::VALUE, ExpressParser::VALUE_IN, ExpressParser::VALUE_UNIQUE, ExpressParser::BinaryLiteral, ExpressParser::EncodedStringLiteral, ExpressParser::IntegerLiteral, ExpressParser::RealLiteral, ExpressParser::SimpleId, ExpressParser::SimpleStringLiteral

					@_state_number = 1357
					primary()
				else
					raise Antlr4::Runtime::NoViableAltException, self
				end

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SimpleTypesContext < Antlr4::Runtime::ParserRuleContext
		def binaryType()
			return rule_context("BinaryTypeContext",0)
		end
		def booleanType()
			return rule_context("BooleanTypeContext",0)
		end
		def integerType()
			return rule_context("IntegerTypeContext",0)
		end
		def logicalType()
			return rule_context("LogicalTypeContext",0)
		end
		def numberType()
			return rule_context("NumberTypeContext",0)
		end
		def realType()
			return rule_context("RealTypeContext",0)
		end
		def stringType()
			return rule_context("StringTypeContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_simpleTypes
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSimpleTypes) )
			  return visitor.visitSimpleTypes(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def simpleTypes()
		_localctx =  SimpleTypesContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 312, RULE_simpleTypes)
		begin
			@_state_number = 1369
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::BINARY
				enter_outer_alt(_localctx, 1)

				@_state_number = 1362
				binaryType()

			when ExpressParser::BOOLEAN
				enter_outer_alt(_localctx, 2)

				@_state_number = 1363
				booleanType()

			when ExpressParser::INTEGER
				enter_outer_alt(_localctx, 3)

				@_state_number = 1364
				integerType()

			when ExpressParser::LOGICAL
				enter_outer_alt(_localctx, 4)

				@_state_number = 1365
				logicalType()

			when ExpressParser::NUMBER
				enter_outer_alt(_localctx, 5)

				@_state_number = 1366
				numberType()

			when ExpressParser::REAL
				enter_outer_alt(_localctx, 6)

				@_state_number = 1367
				realType()

			when ExpressParser::STRING
				enter_outer_alt(_localctx, 7)

				@_state_number = 1368
				stringType()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SkipStmtContext < Antlr4::Runtime::ParserRuleContext
		def SKIP_()
		  return token(ExpressParser::SKIP_, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_skipStmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSkipStmt) )
			  return visitor.visitSkipStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def skipStmt()
		_localctx =  SkipStmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 314, RULE_skipStmt)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1371
			match(SKIP_)
			@_state_number = 1372
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class StmtContext < Antlr4::Runtime::ParserRuleContext
		def aliasStmt()
			return rule_context("AliasStmtContext",0)
		end
		def assignmentStmt()
			return rule_context("AssignmentStmtContext",0)
		end
		def caseStmt()
			return rule_context("CaseStmtContext",0)
		end
		def compoundStmt()
			return rule_context("CompoundStmtContext",0)
		end
		def escapeStmt()
			return rule_context("EscapeStmtContext",0)
		end
		def ifStmt()
			return rule_context("IfStmtContext",0)
		end
		def nullStmt()
			return rule_context("NullStmtContext",0)
		end
		def procedureCallStmt()
			return rule_context("ProcedureCallStmtContext",0)
		end
		def repeatStmt()
			return rule_context("RepeatStmtContext",0)
		end
		def returnStmt()
			return rule_context("ReturnStmtContext",0)
		end
		def skipStmt()
			return rule_context("SkipStmtContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_stmt
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitStmt) )
			  return visitor.visitStmt(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def stmt()
		_localctx =  StmtContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 316, RULE_stmt)
		begin
			@_state_number = 1385
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,128,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1374
				aliasStmt()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1375
				assignmentStmt()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1376
				caseStmt()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 1377
				compoundStmt()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 1378
				escapeStmt()

			when 6
				enter_outer_alt(_localctx, 6)

				@_state_number = 1379
				ifStmt()

			when 7
				enter_outer_alt(_localctx, 7)

				@_state_number = 1380
				nullStmt()

			when 8
				enter_outer_alt(_localctx, 8)

				@_state_number = 1381
				procedureCallStmt()

			when 9
				enter_outer_alt(_localctx, 9)

				@_state_number = 1382
				repeatStmt()

			when 10
				enter_outer_alt(_localctx, 10)

				@_state_number = 1383
				returnStmt()

			when 11
				enter_outer_alt(_localctx, 11)

				@_state_number = 1384
				skipStmt()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class StringLiteralContext < Antlr4::Runtime::ParserRuleContext
		def SimpleStringLiteral()
		  return token(ExpressParser::SimpleStringLiteral, 0)
		end
		def EncodedStringLiteral()
		  return token(ExpressParser::EncodedStringLiteral, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_stringLiteral
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitStringLiteral) )
			  return visitor.visitStringLiteral(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def stringLiteral()
		_localctx =  StringLiteralContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 318, RULE_stringLiteral)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1387
			_la = @_input.la(1)
			if ( !(_la==EncodedStringLiteral || _la==SimpleStringLiteral) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class StringTypeContext < Antlr4::Runtime::ParserRuleContext
		def STRING()
		  return token(ExpressParser::STRING, 0)
		end
		def widthSpec()
			return rule_context("WidthSpecContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_stringType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitStringType) )
			  return visitor.visitStringType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def stringType()
		_localctx =  StringTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 320, RULE_stringType)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1389
			match(STRING)
			@_state_number = 1391
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1390
				widthSpec()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubsuperContext < Antlr4::Runtime::ParserRuleContext
		def supertypeConstraint()
			return rule_context("SupertypeConstraintContext",0)
		end
		def subtypeDeclaration()
			return rule_context("SubtypeDeclarationContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subsuper
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubsuper) )
			  return visitor.visitSubsuper(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subsuper()
		_localctx =  SubsuperContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 322, RULE_subsuper)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1394
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==ABSTRACT || _la==SUPERTYPE)

				@_state_number = 1393
				supertypeConstraint()
			end

			@_state_number = 1397
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==SUBTYPE)

				@_state_number = 1396
				subtypeDeclaration()
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintContext < Antlr4::Runtime::ParserRuleContext
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def supertypeExpression()
			return rule_context("SupertypeExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraint
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraint) )
			  return visitor.visitSubtypeConstraint(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraint()
		_localctx =  SubtypeConstraintContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 324, RULE_subtypeConstraint)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1399
			match(OF)
			@_state_number = 1400
			match(T__1)
			@_state_number = 1401
			supertypeExpression()
			@_state_number = 1402
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintBodyContext < Antlr4::Runtime::ParserRuleContext
		def abstractSupertype()
			return rule_context("AbstractSupertypeContext",0)
		end
		def totalOver()
			return rule_context("TotalOverContext",0)
		end
		def supertypeExpression()
			return rule_context("SupertypeExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraintBody
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraintBody) )
			  return visitor.visitSubtypeConstraintBody(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraintBody()
		_localctx =  SubtypeConstraintBodyContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 326, RULE_subtypeConstraintBody)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1405
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==ABSTRACT)

				@_state_number = 1404
				abstractSupertype()
			end

			@_state_number = 1408
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==TOTAL_OVER)

				@_state_number = 1407
				totalOver()
			end

			@_state_number = 1413
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1 || _la==ONEOF || _la==SimpleId)

				@_state_number = 1410
				supertypeExpression()
				@_state_number = 1411
				match(T__0)
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintDeclContext < Antlr4::Runtime::ParserRuleContext
		def subtypeConstraintHead()
			return rule_context("SubtypeConstraintHeadContext",0)
		end
		def subtypeConstraintBody()
			return rule_context("SubtypeConstraintBodyContext",0)
		end
		def END_SUBTYPE_CONSTRAINT()
		  return token(ExpressParser::END_SUBTYPE_CONSTRAINT, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraintDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraintDecl) )
			  return visitor.visitSubtypeConstraintDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraintDecl()
		_localctx =  SubtypeConstraintDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 328, RULE_subtypeConstraintDecl)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1415
			subtypeConstraintHead()
			@_state_number = 1416
			subtypeConstraintBody()
			@_state_number = 1417
			match(END_SUBTYPE_CONSTRAINT)
			@_state_number = 1418
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintHeadContext < Antlr4::Runtime::ParserRuleContext
		def SUBTYPE_CONSTRAINT()
		  return token(ExpressParser::SUBTYPE_CONSTRAINT, 0)
		end
		def subtypeConstraintId()
			return rule_context("SubtypeConstraintIdContext",0)
		end
		def FOR()
		  return token(ExpressParser::FOR, 0)
		end
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraintHead
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraintHead) )
			  return visitor.visitSubtypeConstraintHead(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraintHead()
		_localctx =  SubtypeConstraintHeadContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 330, RULE_subtypeConstraintHead)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1420
			match(SUBTYPE_CONSTRAINT)
			@_state_number = 1421
			subtypeConstraintId()
			@_state_number = 1422
			match(FOR)
			@_state_number = 1423
			entityRef()
			@_state_number = 1424
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeConstraintIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeConstraintId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeConstraintId) )
			  return visitor.visitSubtypeConstraintId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeConstraintId()
		_localctx =  SubtypeConstraintIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 332, RULE_subtypeConstraintId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1426
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SubtypeDeclarationContext < Antlr4::Runtime::ParserRuleContext
		def SUBTYPE()
		  return token(ExpressParser::SUBTYPE, 0)
		end
		def OF()
		  return token(ExpressParser::OF, 0)
		end
		def entityRef()
			return rule_contexts("EntityRefContext")
		end
		def entityRef_i( i)
			return rule_context("EntityRefContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_subtypeDeclaration
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSubtypeDeclaration) )
			  return visitor.visitSubtypeDeclaration(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def subtypeDeclaration()
		_localctx =  SubtypeDeclarationContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 334, RULE_subtypeDeclaration)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1428
			match(SUBTYPE)
			@_state_number = 1429
			match(OF)
			@_state_number = 1430
			match(T__1)
			@_state_number = 1431
			entityRef()
			@_state_number = 1436
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1432
				match(T__2)
				@_state_number = 1433
				entityRef()
				@_state_number = 1438
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1439
			match(T__3)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SupertypeConstraintContext < Antlr4::Runtime::ParserRuleContext
		def abstractEntityDeclaration()
			return rule_context("AbstractEntityDeclarationContext",0)
		end
		def abstractSupertypeDeclaration()
			return rule_context("AbstractSupertypeDeclarationContext",0)
		end
		def supertypeRule()
			return rule_context("SupertypeRuleContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_supertypeConstraint
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSupertypeConstraint) )
			  return visitor.visitSupertypeConstraint(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def supertypeConstraint()
		_localctx =  SupertypeConstraintContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 336, RULE_supertypeConstraint)
		begin
			@_state_number = 1444
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,136,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1441
				abstractEntityDeclaration()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1442
				abstractSupertypeDeclaration()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 1443
				supertypeRule()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SupertypeExpressionContext < Antlr4::Runtime::ParserRuleContext
		def supertypeFactor()
			return rule_contexts("SupertypeFactorContext")
		end
		def supertypeFactor_i( i)
			return rule_context("SupertypeFactorContext",i)
		end
		def ANDOR()
		 return tokens(ExpressParser::ANDOR)
		end
		def ANDOR_i( i)
			return token(ExpressParser::ANDOR, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_supertypeExpression
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSupertypeExpression) )
			  return visitor.visitSupertypeExpression(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def supertypeExpression()
		_localctx =  SupertypeExpressionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 338, RULE_supertypeExpression)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1446
			supertypeFactor()
			@_state_number = 1451
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==ANDOR)


				@_state_number = 1447
				match(ANDOR)
				@_state_number = 1448
				supertypeFactor()
				@_state_number = 1453
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SupertypeFactorContext < Antlr4::Runtime::ParserRuleContext
		def supertypeTerm()
			return rule_contexts("SupertypeTermContext")
		end
		def supertypeTerm_i( i)
			return rule_context("SupertypeTermContext",i)
		end
		def AND()
		 return tokens(ExpressParser::AND)
		end
		def AND_i( i)
			return token(ExpressParser::AND, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_supertypeFactor
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSupertypeFactor) )
			  return visitor.visitSupertypeFactor(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def supertypeFactor()
		_localctx =  SupertypeFactorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 340, RULE_supertypeFactor)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1454
			supertypeTerm()
			@_state_number = 1459
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==AND)


				@_state_number = 1455
				match(AND)
				@_state_number = 1456
				supertypeTerm()
				@_state_number = 1461
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SupertypeRuleContext < Antlr4::Runtime::ParserRuleContext
		def SUPERTYPE()
		  return token(ExpressParser::SUPERTYPE, 0)
		end
		def subtypeConstraint()
			return rule_context("SubtypeConstraintContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_supertypeRule
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSupertypeRule) )
			  return visitor.visitSupertypeRule(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def supertypeRule()
		_localctx =  SupertypeRuleContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 342, RULE_supertypeRule)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1462
			match(SUPERTYPE)
			@_state_number = 1463
			subtypeConstraint()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SupertypeTermContext < Antlr4::Runtime::ParserRuleContext
		def entityRef()
			return rule_context("EntityRefContext",0)
		end
		def oneOf()
			return rule_context("OneOfContext",0)
		end
		def supertypeExpression()
			return rule_context("SupertypeExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_supertypeTerm
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSupertypeTerm) )
			  return visitor.visitSupertypeTerm(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def supertypeTerm()
		_localctx =  SupertypeTermContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 344, RULE_supertypeTerm)
		begin
			@_state_number = 1471
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::SimpleId
				enter_outer_alt(_localctx, 1)

				@_state_number = 1465
				entityRef()

			when ExpressParser::ONEOF
				enter_outer_alt(_localctx, 2)

				@_state_number = 1466
				oneOf()

			when ExpressParser::T__1
				enter_outer_alt(_localctx, 3)

				@_state_number = 1467
				match(T__1)
				@_state_number = 1468
				supertypeExpression()
				@_state_number = 1469
				match(T__3)
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class SyntaxContext < Antlr4::Runtime::ParserRuleContext
		def schemaDecl()
			return rule_contexts("SchemaDeclContext")
		end
		def schemaDecl_i( i)
			return rule_context("SchemaDeclContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_syntax
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitSyntax) )
			  return visitor.visitSyntax(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def syntax()
		_localctx =  SyntaxContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 346, RULE_syntax)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1474 
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 1473
				schemaDecl()
				@_state_number = 1476 
				@_err_handler.sync(self)
				_la = @_input.la(1)
			 break if (!( _la==SCHEMA) )
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TermContext < Antlr4::Runtime::ParserRuleContext
		def factor()
			return rule_contexts("FactorContext")
		end
		def factor_i( i)
			return rule_context("FactorContext",i)
		end
		def multiplicationLikeOp()
			return rule_contexts("MultiplicationLikeOpContext")
		end
		def multiplicationLikeOp_i( i)
			return rule_context("MultiplicationLikeOpContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_term
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTerm) )
			  return visitor.visitTerm(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def term()
		_localctx =  TermContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 348, RULE_term)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1478
			factor()
			@_state_number = 1484
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__18) | (1 << T__19) | (1 << T__20) | (1 << AND) | (1 << DIV))) != 0) || _la==MOD)


				@_state_number = 1479
				multiplicationLikeOp()
				@_state_number = 1480
				factor()
				@_state_number = 1486
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TotalOverContext < Antlr4::Runtime::ParserRuleContext
		def TOTAL_OVER()
		  return token(ExpressParser::TOTAL_OVER, 0)
		end
		def entityRef()
			return rule_contexts("EntityRefContext")
		end
		def entityRef_i( i)
			return rule_context("EntityRefContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_totalOver
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTotalOver) )
			  return visitor.visitTotalOver(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def totalOver()
		_localctx =  TotalOverContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 350, RULE_totalOver)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1487
			match(TOTAL_OVER)
			@_state_number = 1488
			match(T__1)
			@_state_number = 1489
			entityRef()
			@_state_number = 1494
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1490
				match(T__2)
				@_state_number = 1491
				entityRef()
				@_state_number = 1496
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 1497
			match(T__3)
			@_state_number = 1498
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeDeclContext < Antlr4::Runtime::ParserRuleContext
		def TYPE()
		  return token(ExpressParser::TYPE, 0)
		end
		def typeId()
			return rule_context("TypeIdContext",0)
		end
		def underlyingType()
			return rule_context("UnderlyingTypeContext",0)
		end
		def END_TYPE()
		  return token(ExpressParser::END_TYPE, 0)
		end
		def whereClause()
			return rule_context("WhereClauseContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeDecl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeDecl) )
			  return visitor.visitTypeDecl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeDecl()
		_localctx =  TypeDeclContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 352, RULE_typeDecl)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1500
			match(TYPE)
			@_state_number = 1501
			typeId()
			@_state_number = 1502
			match(T__26)
			@_state_number = 1503
			underlyingType()
			@_state_number = 1504
			match(T__0)
			@_state_number = 1506
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==WHERE)

				@_state_number = 1505
				whereClause()
			end

			@_state_number = 1508
			match(END_TYPE)
			@_state_number = 1509
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeId) )
			  return visitor.visitTypeId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeId()
		_localctx =  TypeIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 354, RULE_typeId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1511
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeLabelContext < Antlr4::Runtime::ParserRuleContext
		def typeLabelId()
			return rule_context("TypeLabelIdContext",0)
		end
		def typeLabelRef()
			return rule_context("TypeLabelRefContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeLabel
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeLabel) )
			  return visitor.visitTypeLabel(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeLabel()
		_localctx =  TypeLabelContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 356, RULE_typeLabel)
		begin
			@_state_number = 1515
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,144,@_ctx) )
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 1513
				typeLabelId()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 1514
				typeLabelRef()

			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class TypeLabelIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_typeLabelId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitTypeLabelId) )
			  return visitor.visitTypeLabelId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def typeLabelId()
		_localctx =  TypeLabelIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 358, RULE_typeLabelId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1517
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UnaryOpContext < Antlr4::Runtime::ParserRuleContext
		def NOT()
		  return token(ExpressParser::NOT, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_unaryOp
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUnaryOp) )
			  return visitor.visitUnaryOp(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def unaryOp()
		_localctx =  UnaryOpContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 360, RULE_unaryOp)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1519
			_la = @_input.la(1)
			if ( !(_la==T__4 || _la==T__5 || _la==NOT) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UnderlyingTypeContext < Antlr4::Runtime::ParserRuleContext
		def concreteTypes()
			return rule_context("ConcreteTypesContext",0)
		end
		def constructedTypes()
			return rule_context("ConstructedTypesContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_underlyingType
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUnderlyingType) )
			  return visitor.visitUnderlyingType(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def underlyingType()
		_localctx =  UnderlyingTypeContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 362, RULE_underlyingType)
		begin
			@_state_number = 1523
			@_err_handler.sync(self)
			case (@_input.la(1))
			when ExpressParser::ARRAY, ExpressParser::BAG, ExpressParser::BINARY, ExpressParser::BOOLEAN, ExpressParser::INTEGER, ExpressParser::LIST, ExpressParser::LOGICAL, ExpressParser::NUMBER, ExpressParser::REAL, ExpressParser::SET, ExpressParser::STRING, ExpressParser::SimpleId
				enter_outer_alt(_localctx, 1)

				@_state_number = 1521
				concreteTypes()

			when ExpressParser::ENUMERATION, ExpressParser::EXTENSIBLE, ExpressParser::SELECT
				enter_outer_alt(_localctx, 2)

				@_state_number = 1522
				constructedTypes()
			else
				raise Antlr4::Runtime::NoViableAltException, self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UniqueClauseContext < Antlr4::Runtime::ParserRuleContext
		def UNIQUE()
		  return token(ExpressParser::UNIQUE, 0)
		end
		def uniqueRule()
			return rule_contexts("UniqueRuleContext")
		end
		def uniqueRule_i( i)
			return rule_context("UniqueRuleContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_uniqueClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUniqueClause) )
			  return visitor.visitUniqueClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def uniqueClause()
		_localctx =  UniqueClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 364, RULE_uniqueClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1525
			match(UNIQUE)
			@_state_number = 1526
			uniqueRule()
			@_state_number = 1527
			match(T__0)
			@_state_number = 1533
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==SELF || _la==SimpleId)


				@_state_number = 1528
				uniqueRule()
				@_state_number = 1529
				match(T__0)
				@_state_number = 1535
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UniqueRuleContext < Antlr4::Runtime::ParserRuleContext
		def referencedAttribute()
			return rule_contexts("ReferencedAttributeContext")
		end
		def referencedAttribute_i( i)
			return rule_context("ReferencedAttributeContext",i)
		end
		def ruleLabelId()
			return rule_context("RuleLabelIdContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_uniqueRule
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUniqueRule) )
			  return visitor.visitUniqueRule(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def uniqueRule()
		_localctx =  UniqueRuleContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 366, RULE_uniqueRule)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1539
			@_err_handler.sync(self)
			case ( @_interp.adaptive_predict(@_input,147,@_ctx) )
			when 1

				@_state_number = 1536
				ruleLabelId()
				@_state_number = 1537
				match(T__8)

			end
			@_state_number = 1541
			referencedAttribute()
			@_state_number = 1546
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==T__2)


				@_state_number = 1542
				match(T__2)
				@_state_number = 1543
				referencedAttribute()
				@_state_number = 1548
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UntilControlContext < Antlr4::Runtime::ParserRuleContext
		def UNTIL()
		  return token(ExpressParser::UNTIL, 0)
		end
		def logicalExpression()
			return rule_context("LogicalExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_untilControl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUntilControl) )
			  return visitor.visitUntilControl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def untilControl()
		_localctx =  UntilControlContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 368, RULE_untilControl)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1549
			match(UNTIL)
			@_state_number = 1550
			logicalExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class UseClauseContext < Antlr4::Runtime::ParserRuleContext
		def USE()
		  return token(ExpressParser::USE, 0)
		end
		def FROM()
		  return token(ExpressParser::FROM, 0)
		end
		def schemaRef()
			return rule_context("SchemaRefContext",0)
		end
		def namedTypeOrRename()
			return rule_contexts("NamedTypeOrRenameContext")
		end
		def namedTypeOrRename_i( i)
			return rule_context("NamedTypeOrRenameContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_useClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitUseClause) )
			  return visitor.visitUseClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def useClause()
		_localctx =  UseClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 370, RULE_useClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1552
			match(USE)
			@_state_number = 1553
			match(FROM)
			@_state_number = 1554
			schemaRef()
			@_state_number = 1566
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==T__1)

				@_state_number = 1555
				match(T__1)
				@_state_number = 1556
				namedTypeOrRename()
				@_state_number = 1561
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la==T__2)


					@_state_number = 1557
					match(T__2)
					@_state_number = 1558
					namedTypeOrRename()
					@_state_number = 1563
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
				@_state_number = 1564
				match(T__3)
			end

			@_state_number = 1568
			match(T__0)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class VariableIdContext < Antlr4::Runtime::ParserRuleContext
		def SimpleId()
		  return token(ExpressParser::SimpleId, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_variableId
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitVariableId) )
			  return visitor.visitVariableId(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def variableId()
		_localctx =  VariableIdContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 372, RULE_variableId)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1570
			match(SimpleId)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class WhereClauseContext < Antlr4::Runtime::ParserRuleContext
		def WHERE()
		  return token(ExpressParser::WHERE, 0)
		end
		def domainRule()
			return rule_contexts("DomainRuleContext")
		end
		def domainRule_i( i)
			return rule_context("DomainRuleContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_whereClause
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitWhereClause) )
			  return visitor.visitWhereClause(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def whereClause()
		_localctx =  WhereClauseContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 374, RULE_whereClause)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1572
			match(WHERE)
			@_state_number = 1573
			domainRule()
			@_state_number = 1574
			match(T__0)
			@_state_number = 1580
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << T__1) | (1 << T__4) | (1 << T__5) | (1 << T__6) | (1 << T__11) | (1 << T__14) | (1 << ABS) | (1 << ACOS) | (1 << ASIN) | (1 << ATAN) | (1 << BLENGTH) | (1 << CONST_E) | (1 << COS))) != 0) || ((((_la - 72)) & ~0x3f) == 0 && ((1 << (_la - 72)) & ((1 << (EXISTS - 72)) | (1 << (EXP - 72)) | (1 << (FALSE - 72)) | (1 << (FORMAT - 72)) | (1 << (HIBOUND - 72)) | (1 << (HIINDEX - 72)) | (1 << (LENGTH - 72)) | (1 << (LOBOUND - 72)) | (1 << (LOG - 72)) | (1 << (LOG10 - 72)) | (1 << (LOG2 - 72)) | (1 << (LOINDEX - 72)) | (1 << (NOT - 72)) | (1 << (NVL - 72)) | (1 << (ODD - 72)) | (1 << (PI - 72)) | (1 << (QUERY - 72)) | (1 << (ROLESOF - 72)) | (1 << (SELF - 72)) | (1 << (SIN - 72)) | (1 << (SIZEOF - 72)) | (1 << (SQRT - 72)) | (1 << (TAN - 72)))) != 0) || ((((_la - 136)) & ~0x3f) == 0 && ((1 << (_la - 136)) & ((1 << (TRUE - 136)) | (1 << (TYPEOF - 136)) | (1 << (UNKNOWN - 136)) | (1 << (USEDIN - 136)) | (1 << (VALUE - 136)) | (1 << (VALUE_IN - 136)) | (1 << (VALUE_UNIQUE - 136)) | (1 << (BinaryLiteral - 136)) | (1 << (EncodedStringLiteral - 136)) | (1 << (IntegerLiteral - 136)) | (1 << (RealLiteral - 136)) | (1 << (SimpleId - 136)) | (1 << (SimpleStringLiteral - 136)))) != 0))


				@_state_number = 1575
				domainRule()
				@_state_number = 1576
				match(T__0)
				@_state_number = 1582
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class WhileControlContext < Antlr4::Runtime::ParserRuleContext
		def WHILE()
		  return token(ExpressParser::WHILE, 0)
		end
		def logicalExpression()
			return rule_context("LogicalExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_whileControl
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitWhileControl) )
			  return visitor.visitWhileControl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def whileControl()
		_localctx =  WhileControlContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 376, RULE_whileControl)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1583
			match(WHILE)
			@_state_number = 1584
			logicalExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class WidthContext < Antlr4::Runtime::ParserRuleContext
		def numericExpression()
			return rule_context("NumericExpressionContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_width
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitWidth) )
			  return visitor.visitWidth(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def width()
		_localctx =  WidthContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 378, RULE_width)
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1586
			numericExpression()
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class WidthSpecContext < Antlr4::Runtime::ParserRuleContext
		def width()
			return rule_context("WidthContext",0)
		end
		def FIXED()
		  return token(ExpressParser::FIXED, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_widthSpec
		end

		def accept(visitor)
			if ( visitor.respond_to?(:visitWidthSpec) )
			  return visitor.visitWidthSpec(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def widthSpec()
		_localctx =  WidthSpecContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 380, RULE_widthSpec)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

			@_state_number = 1588
			match(T__1)
			@_state_number = 1589
			width()
			@_state_number = 1590
			match(T__3)
			@_state_number = 1592
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if (_la==FIXED)

				@_state_number = 1591
				match(FIXED)
			end

		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	@@_serializedATN = ["\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964",
	    "\3\u00a3\u063d\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b",
	    "\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17",
	    "\4\20\t\20\4\21\t\21\4\22\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t",
	    "\26\4\27\t\27\4\30\t\30\4\31\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35",
	    "\t\35\4\36\t\36\4\37\t\37\4 \t \4!\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&",
	    "\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4,\t,\4-\t-\4.\t.\4/\t/\4\60\t",
	    "\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t\64\4\65\t\65\4\66\t\66\4\67",
	    "\t\67\48\t8\49\t9\4:\t:\4;\t;\4<\t<\4=\t=\4>\t>\4?\t?\4@\t@\4A\tA\4",
	    "B\tB\4C\tC\4D\tD\4E\tE\4F\tF\4G\tG\4H\tH\4I\tI\4J\tJ\4K\tK\4L\tL\4",
	    "M\tM\4N\tN\4O\tO\4P\tP\4Q\tQ\4R\tR\4S\tS\4T\tT\4U\tU\4V\tV\4W\tW\4",
	    "X\tX\4Y\tY\4Z\tZ\4[\t[\4\\\t\\\4]\t]\4^\t^\4_\t_\4`\t`\4a\ta\4b\tb",
	    "\4c\tc\4d\td\4e\te\4f\tf\4g\tg\4h\th\4i\ti\4j\tj\4k\tk\4l\tl\4m\tm",
	    "\4n\tn\4o\to\4p\tp\4q\tq\4r\tr\4s\ts\4t\tt\4u\tu\4v\tv\4w\tw\4x\tx",
	    "\4y\ty\4z\tz\4{\t{\4|\t|\4}\t}\4~\t~\4\177\t\177\4\u0080\t\u0080\4",
	    "\u0081\t\u0081\4\u0082\t\u0082\4\u0083\t\u0083\4\u0084\t\u0084\4\u0085",
	    "\t\u0085\4\u0086\t\u0086\4\u0087\t\u0087\4\u0088\t\u0088\4\u0089\t",
	    "\u0089\4\u008a\t\u008a\4\u008b\t\u008b\4\u008c\t\u008c\4\u008d\t\u008d",
	    "\4\u008e\t\u008e\4\u008f\t\u008f\4\u0090\t\u0090\4\u0091\t\u0091\4",
	    "\u0092\t\u0092\4\u0093\t\u0093\4\u0094\t\u0094\4\u0095\t\u0095\4\u0096",
	    "\t\u0096\4\u0097\t\u0097\4\u0098\t\u0098\4\u0099\t\u0099\4\u009a\t",
	    "\u009a\4\u009b\t\u009b\4\u009c\t\u009c\4\u009d\t\u009d\4\u009e\t\u009e",
	    "\4\u009f\t\u009f\4\u00a0\t\u00a0\4\u00a1\t\u00a1\4\u00a2\t\u00a2\4",
	    "\u00a3\t\u00a3\4\u00a4\t\u00a4\4\u00a5\t\u00a5\4\u00a6\t\u00a6\4\u00a7",
	    "\t\u00a7\4\u00a8\t\u00a8\4\u00a9\t\u00a9\4\u00aa\t\u00aa\4\u00ab\t",
	    "\u00ab\4\u00ac\t\u00ac\4\u00ad\t\u00ad\4\u00ae\t\u00ae\4\u00af\t\u00af",
	    "\4\u00b0\t\u00b0\4\u00b1\t\u00b1\4\u00b2\t\u00b2\4\u00b3\t\u00b3\4",
	    "\u00b4\t\u00b4\4\u00b5\t\u00b5\4\u00b6\t\u00b6\4\u00b7\t\u00b7\4\u00b8",
	    "\t\u00b8\4\u00b9\t\u00b9\4\u00ba\t\u00ba\4\u00bb\t\u00bb\4\u00bc\t",
	    "\u00bc\4\u00bd\t\u00bd\4\u00be\t\u00be\4\u00bf\t\u00bf\4\u00c0\t\u00c0",
	    "\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3",
	    "\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20\3\20\3\21",
	    "\3\21\3\21\3\21\3\22\3\22\3\22\5\22\u01a6\n\22\3\23\3\23\3\23\3\23",
	    "\7\23\u01ac\n\23\f\23\16\23\u01af\13\23\3\23\3\23\3\24\3\24\3\25\3",
	    "\25\3\25\3\25\7\25\u01b9\n\25\f\25\16\25\u01bc\13\25\5\25\u01be\n\25",
	    "\3\25\3\25\3\26\3\26\3\27\3\27\3\27\5\27\u01c7\n\27\3\27\3\27\3\27",
	    "\3\30\3\30\3\30\3\30\5\30\u01d0\n\30\3\31\7\31\u01d3\n\31\f\31\16\31",
	    "\u01d6\13\31\3\31\5\31\u01d9\n\31\3\31\5\31\u01dc\n\31\3\32\3\32\3",
	    "\32\3\32\3\32\7\32\u01e3\n\32\f\32\16\32\u01e6\13\32\3\32\3\32\6\32",
	    "\u01ea\n\32\r\32\16\32\u01eb\3\32\3\32\3\32\3\33\3\33\3\33\3\33\5\33",
	    "\u01f5\n\33\3\33\5\33\u01f8\n\33\3\33\3\33\3\34\3\34\7\34\u01fe\n\34",
	    "\f\34\16\34\u0201\13\34\3\34\3\34\3\34\3\34\3\35\3\35\5\35\u0209\n",
	    "\35\3\36\3\36\3\37\3\37\3\37\3 \3 \5 \u0212\n \3 \3 \3 \3!\3!\5!\u0219",
	    "\n!\3\"\3\"\3#\3#\3$\3$\3%\3%\3%\3%\3%\3%\3&\3&\3\'\3\'\3(\3(\3)\3",
	    ")\3)\7)\u0230\n)\f)\16)\u0233\13)\3)\3)\3)\3*\3*\3+\3+\3+\3+\7+\u023e",
	    "\n+\f+\16+\u0241\13+\3+\3+\3+\5+\u0246\n+\3+\3+\3+\3,\3,\6,\u024d\n",
	    ",\r,\16,\u024e\3,\3,\3,\3-\3-\3-\5-\u0257\n-\3.\3.\3.\3.\3.\3.\3.\3",
	    "/\3/\6/\u0262\n/\r/\16/\u0263\3/\3/\3/\3\60\3\60\5\60\u026b\n\60\3",
	    "\61\3\61\3\62\3\62\5\62\u0271\n\62\3\63\3\63\3\63\3\63\3\63\5\63\u0278",
	    "\n\63\3\64\3\64\3\64\3\64\3\64\3\64\3\64\3\65\3\65\6\65\u0283\n\65",
	    "\r\65\16\65\u0284\3\66\3\66\3\66\5\66\u028a\n\66\3\66\3\66\3\67\3\67",
	    "\3\67\5\67\u0291\n\67\38\78\u0294\n8\f8\168\u0297\138\38\58\u029a\n",
	    "8\38\58\u029d\n8\38\58\u02a0\n8\38\58\u02a3\n8\39\39\39\39\39\79\u02aa",
	    "\n9\f9\169\u02ad\139\59\u02af\n9\39\39\3:\3:\3:\3:\3:\3;\3;\3;\3;\3",
	    ";\3<\3<\3=\3=\3=\3=\5=\u02c3\n=\3>\3>\3?\3?\3?\3?\7?\u02cb\n?\f?\16",
	    "?\u02ce\13?\3?\3?\3@\3@\3@\5@\u02d5\n@\3@\3@\3A\5A\u02da\nA\3A\3A\3",
	    "A\3A\5A\u02e0\nA\3B\3B\3B\3C\3C\3C\7C\u02e8\nC\fC\16C\u02eb\13C\3C",
	    "\3C\5C\u02ef\nC\3C\3C\3C\3D\3D\3D\3D\5D\u02f8\nD\3E\3E\3E\5E\u02fd",
	    "\nE\3F\3F\3F\7F\u0302\nF\fF\16F\u0305\13F\3F\3F\3F\3G\3G\5G\u030c\n",
	    "G\3G\5G\u030f\nG\3H\3H\3H\6H\u0314\nH\rH\16H\u0315\3H\3H\3H\3I\3I\3",
	    "I\3I\3I\3I\7I\u0321\nI\fI\16I\u0324\13I\3I\3I\5I\u0328\nI\3I\3I\3I",
	    "\3I\3J\3J\3K\3K\3K\3K\5K\u0334\nK\3L\3L\3L\3L\5L\u033a\nL\3M\3M\5M",
	    "\u033e\nM\3M\3M\5M\u0342\nM\3M\5M\u0345\nM\3M\3M\3N\3N\5N\u034b\nN",
	    "\3N\3N\3N\3O\3O\5O\u0352\nO\3O\3O\5O\u0356\nO\3O\3O\3P\3P\5P\u035c",
	    "\nP\3Q\3Q\5Q\u0360\nQ\3Q\3Q\3Q\3R\3R\3R\5R\u0368\nR\3S\3S\3S\5S\u036d",
	    "\nS\3T\3T\3T\3U\3U\3U\3U\6U\u0376\nU\rU\16U\u0377\3U\3U\6U\u037c\n",
	    "U\rU\16U\u037d\5U\u0380\nU\3U\3U\3U\3V\3V\3W\3W\3W\3W\3W\3W\3W\5W\u038e",
	    "\nW\3X\3X\3Y\3Y\3Z\3Z\3[\3[\3[\3[\5[\u039a\n[\3[\3[\3\\\3\\\5\\\u03a0",
	    "\n\\\3]\3]\3^\3^\5^\u03a6\n^\3_\3_\3_\3_\3_\3_\3_\3_\3`\3`\3a\3a\3",
	    "b\3b\3c\3c\3d\3d\3d\3d\5d\u03bc\nd\3d\5d\u03bf\nd\3d\3d\3d\3d\3d\5",
	    "d\u03c6\nd\3d\3d\3d\3e\3e\6e\u03cd\ne\re\16e\u03ce\3f\3f\5f\u03d3\n",
	    "f\3f\3f\5f\u03d7\nf\3f\3f\3g\3g\3g\3g\3g\5g\u03e0\ng\3h\3h\6h\u03e4",
	    "\nh\rh\16h\u03e5\3h\3h\3h\3i\3i\3i\7i\u03ee\ni\fi\16i\u03f1\13i\3i",
	    "\3i\3i\3i\5i\u03f7\ni\3i\3i\3j\3j\3k\3k\3l\3l\3m\3m\3n\3n\5n\u0405",
	    "\nn\3o\3o\3o\3o\5o\u040b\no\5o\u040d\no\3p\3p\3q\3q\3r\3r\3s\3s\3s",
	    "\3s\3s\7s\u041a\ns\fs\16s\u041d\13s\3s\3s\3t\3t\3u\3u\3v\3v\3v\5v\u0428",
	    "\nv\3w\3w\3x\3x\3y\3y\3y\7y\u0431\ny\fy\16y\u0434\13y\5y\u0436\ny\3",
	    "z\3z\5z\u043a\nz\3z\5z\u043d\nz\3z\3z\3{\3{\3{\7{\u0444\n{\f{\16{\u0447",
	    "\13{\3{\3{\3{\3|\3|\3|\3|\5|\u0450\n|\3|\3|\3|\5|\u0455\n|\3|\7|\u0458",
	    "\n|\f|\16|\u045b\13|\3|\3|\5|\u045f\n|\3|\3|\3}\3}\3~\3~\3~\3~\3~\5",
	    "~\u046a\n~\3\177\3\177\3\177\3\177\3\u0080\3\u0080\3\u0080\5\u0080",
	    "\u0473\n\u0080\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081",
	    "\3\u0081\3\u0081\3\u0082\3\u0082\3\u0082\3\u0082\3\u0082\5\u0082\u0483",
	    "\n\u0082\3\u0083\3\u0083\3\u0083\5\u0083\u0488\n\u0083\3\u0084\3\u0084",
	    "\5\u0084\u048c\n\u0084\3\u0085\3\u0085\3\u0085\3\u0085\3\u0085\3\u0085",
	    "\3\u0085\7\u0085\u0495\n\u0085\f\u0085\16\u0085\u0498\13\u0085\3\u0085",
	    "\3\u0085\5\u0085\u049c\n\u0085\3\u0085\3\u0085\3\u0086\3\u0086\3\u0087",
	    "\3\u0087\3\u0087\5\u0087\u04a5\n\u0087\3\u0088\3\u0088\3\u0088\3\u0088",
	    "\3\u0088\5\u0088\u04ac\n\u0088\3\u0089\5\u0089\u04af\n\u0089\3\u0089",
	    "\5\u0089\u04b2\n\u0089\3\u0089\5\u0089\u04b5\n\u0089\3\u008a\3\u008a",
	    "\3\u008a\3\u008a\6\u008a\u04bb\n\u008a\r\u008a\16\u008a\u04bc\3\u008a",
	    "\3\u008a\3\u008a\3\u008b\3\u008b\3\u008c\3\u008c\3\u008c\5\u008c\u04c7",
	    "\n\u008c\3\u008d\3\u008d\3\u008d\3\u008d\3\u008d\5\u008d\u04ce\n\u008d",
	    "\3\u008e\3\u008e\3\u008e\3\u008e\3\u008e\5\u008e\u04d5\n\u008e\3\u008e",
	    "\3\u008e\3\u008f\3\u008f\3\u008f\7\u008f\u04dc\n\u008f\f\u008f\16\u008f",
	    "\u04df\13\u008f\3\u008f\3\u008f\3\u008f\3\u008f\3\u0090\3\u0090\3\u0090",
	    "\3\u0090\3\u0090\3\u0090\3\u0090\7\u0090\u04ec\n\u0090\f\u0090\16\u0090",
	    "\u04ef\13\u0090\3\u0090\3\u0090\3\u0090\3\u0091\3\u0091\3\u0092\3\u0092",
	    "\3\u0093\7\u0093\u04f9\n\u0093\f\u0093\16\u0093\u04fc\13\u0093\3\u0093",
	    "\5\u0093\u04ff\n\u0093\3\u0093\3\u0093\7\u0093\u0503\n\u0093\f\u0093",
	    "\16\u0093\u0506\13\u0093\3\u0094\3\u0094\3\u0094\5\u0094\u050b\n\u0094",
	    "\3\u0094\3\u0094\3\u0094\3\u0094\3\u0094\3\u0095\3\u0095\3\u0096\3",
	    "\u0096\3\u0097\3\u0097\3\u0098\3\u0098\3\u0098\3\u0098\5\u0098\u051c",
	    "\n\u0098\3\u0099\3\u0099\3\u0099\3\u0099\7\u0099\u0522\n\u0099\f\u0099",
	    "\16\u0099\u0525\13\u0099\3\u0099\3\u0099\3\u009a\3\u009a\5\u009a\u052b",
	    "\n\u009a\5\u009a\u052d\n\u009a\3\u009a\3\u009a\3\u009a\5\u009a\u0532",
	    "\n\u009a\3\u009b\3\u009b\5\u009b\u0536\n\u009b\3\u009b\3\u009b\3\u009b",
	    "\3\u009c\3\u009c\3\u009c\3\u009c\7\u009c\u053f\n\u009c\f\u009c\16\u009c",
	    "\u0542\13\u009c\3\u009d\3\u009d\3\u009d\3\u009d\3\u009d\3\u009d\5\u009d",
	    "\u054a\n\u009d\3\u009d\3\u009d\3\u009d\3\u009d\3\u009d\5\u009d\u0551",
	    "\n\u009d\5\u009d\u0553\n\u009d\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e",
	    "\3\u009e\3\u009e\5\u009e\u055c\n\u009e\3\u009f\3\u009f\3\u009f\3\u00a0",
	    "\3\u00a0\3\u00a0\3\u00a0\3\u00a0\3\u00a0\3\u00a0\3\u00a0\3\u00a0\3",
	    "\u00a0\3\u00a0\5\u00a0\u056c\n\u00a0\3\u00a1\3\u00a1\3\u00a2\3\u00a2",
	    "\5\u00a2\u0572\n\u00a2\3\u00a3\5\u00a3\u0575\n\u00a3\3\u00a3\5\u00a3",
	    "\u0578\n\u00a3\3\u00a4\3\u00a4\3\u00a4\3\u00a4\3\u00a4\3\u00a5\5\u00a5",
	    "\u0580\n\u00a5\3\u00a5\5\u00a5\u0583\n\u00a5\3\u00a5\3\u00a5\3\u00a5",
	    "\5\u00a5\u0588\n\u00a5\3\u00a6\3\u00a6\3\u00a6\3\u00a6\3\u00a6\3\u00a7",
	    "\3\u00a7\3\u00a7\3\u00a7\3\u00a7\3\u00a7\3\u00a8\3\u00a8\3\u00a9\3",
	    "\u00a9\3\u00a9\3\u00a9\3\u00a9\3\u00a9\7\u00a9\u059d\n\u00a9\f\u00a9",
	    "\16\u00a9\u05a0\13\u00a9\3\u00a9\3\u00a9\3\u00aa\3\u00aa\3\u00aa\5",
	    "\u00aa\u05a7\n\u00aa\3\u00ab\3\u00ab\3\u00ab\7\u00ab\u05ac\n\u00ab",
	    "\f\u00ab\16\u00ab\u05af\13\u00ab\3\u00ac\3\u00ac\3\u00ac\7\u00ac\u05b4",
	    "\n\u00ac\f\u00ac\16\u00ac\u05b7\13\u00ac\3\u00ad\3\u00ad\3\u00ad\3",
	    "\u00ae\3\u00ae\3\u00ae\3\u00ae\3\u00ae\3\u00ae\5\u00ae\u05c2\n\u00ae",
	    "\3\u00af\6\u00af\u05c5\n\u00af\r\u00af\16\u00af\u05c6\3\u00b0\3\u00b0",
	    "\3\u00b0\3\u00b0\7\u00b0\u05cd\n\u00b0\f\u00b0\16\u00b0\u05d0\13\u00b0",
	    "\3\u00b1\3\u00b1\3\u00b1\3\u00b1\3\u00b1\7\u00b1\u05d7\n\u00b1\f\u00b1",
	    "\16\u00b1\u05da\13\u00b1\3\u00b1\3\u00b1\3\u00b1\3\u00b2\3\u00b2\3",
	    "\u00b2\3\u00b2\3\u00b2\3\u00b2\5\u00b2\u05e5\n\u00b2\3\u00b2\3\u00b2",
	    "\3\u00b2\3\u00b3\3\u00b3\3\u00b4\3\u00b4\5\u00b4\u05ee\n\u00b4\3\u00b5",
	    "\3\u00b5\3\u00b6\3\u00b6\3\u00b7\3\u00b7\5\u00b7\u05f6\n\u00b7\3\u00b8",
	    "\3\u00b8\3\u00b8\3\u00b8\3\u00b8\3\u00b8\7\u00b8\u05fe\n\u00b8\f\u00b8",
	    "\16\u00b8\u0601\13\u00b8\3\u00b9\3\u00b9\3\u00b9\5\u00b9\u0606\n\u00b9",
	    "\3\u00b9\3\u00b9\3\u00b9\7\u00b9\u060b\n\u00b9\f\u00b9\16\u00b9\u060e",
	    "\13\u00b9\3\u00ba\3\u00ba\3\u00ba\3\u00bb\3\u00bb\3\u00bb\3\u00bb\3",
	    "\u00bb\3\u00bb\3\u00bb\7\u00bb\u061a\n\u00bb\f\u00bb\16\u00bb\u061d",
	    "\13\u00bb\3\u00bb\3\u00bb\5\u00bb\u0621\n\u00bb\3\u00bb\3\u00bb\3\u00bc",
	    "\3\u00bc\3\u00bd\3\u00bd\3\u00bd\3\u00bd\3\u00bd\3\u00bd\7\u00bd\u062d",
	    "\n\u00bd\f\u00bd\16\u00bd\u0630\13\u00bd\3\u00be\3\u00be\3\u00be\3",
	    "\u00bf\3\u00bf\3\u00c0\3\u00c0\3\u00c0\3\u00c0\5\u00c0\u063b\n\u00c0",
	    "\3\u00c0\2\2\u00c1\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(*,.",
	    "\60\62\64\668:<>@BDFHJLNPRTVXZ\\^`bdfhjlnprtvxz|~\u0080\u0082\u0084",
	    "\u0086\u0088\u008a\u008c\u008e\u0090\u0092\u0094\u0096\u0098\u009a",
	    "\u009c\u009e\u00a0\u00a2\u00a4\u00a6\u00a8\u00aa\u00ac\u00ae\u00b0",
	    "\u00b2\u00b4\u00b6\u00b8\u00ba\u00bc\u00be\u00c0\u00c2\u00c4\u00c6",
	    "\u00c8\u00ca\u00cc\u00ce\u00d0\u00d2\u00d4\u00d6\u00d8\u00da\u00dc",
	    "\u00de\u00e0\u00e2\u00e4\u00e6\u00e8\u00ea\u00ec\u00ee\u00f0\u00f2",
	    "\u00f4\u00f6\u00f8\u00fa\u00fc\u00fe\u0100\u0102\u0104\u0106\u0108",
	    "\u010a\u010c\u010e\u0110\u0112\u0114\u0116\u0118\u011a\u011c\u011e",
	    "\u0120\u0122\u0124\u0126\u0128\u012a\u012c\u012e\u0130\u0132\u0134",
	    "\u0136\u0138\u013a\u013c\u013e\u0140\u0142\u0144\u0146\u0148\u014a",
	    "\u014c\u014e\u0150\u0152\u0154\u0156\u0158\u015a\u015c\u015e\u0160",
	    "\u0162\u0164\u0166\u0168\u016a\u016c\u016e\u0170\u0172\u0174\u0176",
	    "\u0178\u017a\u017c\u017e\2\r\5\2\7\bnn\u009a\u009a\6\2\16\16\64\64",
	    "pp}}\25\2  \"\")*//\65\65JKPPUV\\\\__aceeijyy\177\u0080\u0082\u0082",
	    "\u0087\u0087\u008c\u008c\u0092\u0095\4\2YYuu\3\2\23\24\4\2++~~\5\2",
	    "MM\u008a\u008a\u008f\u008f\6\2\25\27%%\67\67ff\4\2\23\24\32\37\4\2",
	    "\u009c\u009c\u00a0\u00a0\4\2\7\bgg\2\u0645\2\u0180\3\2\2\2\4\u0182",
	    "\3\2\2\2\6\u0184\3\2\2\2\b\u0186\3\2\2\2\n\u0188\3\2\2\2\f\u018a\3",
	    "\2\2\2\16\u018c\3\2\2\2\20\u018e\3\2\2\2\22\u0190\3\2\2\2\24\u0192",
	    "\3\2\2\2\26\u0194\3\2\2\2\30\u0196\3\2\2\2\32\u0198\3\2\2\2\34\u019a",
	    "\3\2\2\2\36\u019c\3\2\2\2 \u019e\3\2\2\2\"\u01a2\3\2\2\2$\u01a7\3\2",
	    "\2\2&\u01b2\3\2\2\2(\u01b4\3\2\2\2*\u01c1\3\2\2\2,\u01c3\3\2\2\2.\u01cf",
	    "\3\2\2\2\60\u01d4\3\2\2\2\62\u01dd\3\2\2\2\64\u01f0\3\2\2\2\66\u01fb",
	    "\3\2\2\28\u0208\3\2\2\2:\u020a\3\2\2\2<\u020c\3\2\2\2>\u020f\3\2\2",
	    "\2@\u0216\3\2\2\2B\u021a\3\2\2\2D\u021c\3\2\2\2F\u021e\3\2\2\2H\u0220",
	    "\3\2\2\2J\u0226\3\2\2\2L\u0228\3\2\2\2N\u022a\3\2\2\2P\u022c\3\2\2",
	    "\2R\u0237\3\2\2\2T\u0239\3\2\2\2V\u024a\3\2\2\2X\u0256\3\2\2\2Z\u0258",
	    "\3\2\2\2\\\u025f\3\2\2\2^\u026a\3\2\2\2`\u026c\3\2\2\2b\u0270\3\2\2",
	    "\2d\u0277\3\2\2\2f\u0279\3\2\2\2h\u0280\3\2\2\2j\u0289\3\2\2\2l\u028d",
	    "\3\2\2\2n\u0295\3\2\2\2p\u02a4\3\2\2\2r\u02b2\3\2\2\2t\u02b7\3\2\2",
	    "\2v\u02bc\3\2\2\2x\u02be\3\2\2\2z\u02c4\3\2\2\2|\u02c6\3\2\2\2~\u02d4",
	    "\3\2\2\2\u0080\u02d9\3\2\2\2\u0082\u02e1\3\2\2\2\u0084\u02e4\3\2\2",
	    "\2\u0086\u02f3\3\2\2\2\u0088\u02f9\3\2\2\2\u008a\u02fe\3\2\2\2\u008c",
	    "\u030b\3\2\2\2\u008e\u0310\3\2\2\2\u0090\u031a\3\2\2\2\u0092\u032d",
	    "\3\2\2\2\u0094\u0333\3\2\2\2\u0096\u0339\3\2\2\2\u0098\u033b\3\2\2",
	    "\2\u009a\u0348\3\2\2\2\u009c\u034f\3\2\2\2\u009e\u035b\3\2\2\2\u00a0",
	    "\u035d\3\2\2\2\u00a2\u0364\3\2\2\2\u00a4\u0369\3\2\2\2\u00a6\u036e",
	    "\3\2\2\2\u00a8\u0371\3\2\2\2\u00aa\u0384\3\2\2\2\u00ac\u0386\3\2\2",
	    "\2\u00ae\u038f\3\2\2\2\u00b0\u0391\3\2\2\2\u00b2\u0393\3\2\2\2\u00b4",
	    "\u0395\3\2\2\2\u00b6\u039f\3\2\2\2\u00b8\u03a1\3\2\2\2\u00ba\u03a5",
	    "\3\2\2\2\u00bc\u03a7\3\2\2\2\u00be\u03af\3\2\2\2\u00c0\u03b1\3\2\2",
	    "\2\u00c2\u03b3\3\2\2\2\u00c4\u03b5\3\2\2\2\u00c6\u03b7\3\2\2\2\u00c8",
	    "\u03ca\3\2\2\2\u00ca\u03d0\3\2\2\2\u00cc\u03df\3\2\2\2\u00ce\u03e1",
	    "\3\2\2\2\u00d0\u03ea\3\2\2\2\u00d2\u03fa\3\2\2\2\u00d4\u03fc\3\2\2",
	    "\2\u00d6\u03fe\3\2\2\2\u00d8\u0400\3\2\2\2\u00da\u0404\3\2\2\2\u00dc",
	    "\u0406\3\2\2\2\u00de\u040e\3\2\2\2\u00e0\u0410\3\2\2\2\u00e2\u0412",
	    "\3\2\2\2\u00e4\u0414\3\2\2\2\u00e6\u0420\3\2\2\2\u00e8\u0422\3\2\2",
	    "\2\u00ea\u0427\3\2\2\2\u00ec\u0429\3\2\2\2\u00ee\u042b\3\2\2\2\u00f0",
	    "\u0435\3\2\2\2\u00f2\u0439\3\2\2\2\u00f4\u0440\3\2\2\2\u00f6\u044b",
	    "\3\2\2\2\u00f8\u0462\3\2\2\2\u00fa\u0469\3\2\2\2\u00fc\u046b\3\2\2",
	    "\2\u00fe\u0472\3\2\2\2\u0100\u0474\3\2\2\2\u0102\u047d\3\2\2\2\u0104",
	    "\u0484\3\2\2\2\u0106\u048b\3\2\2\2\u0108\u048d\3\2\2\2\u010a\u049f",
	    "\3\2\2\2\u010c\u04a4\3\2\2\2\u010e\u04ab\3\2\2\2\u0110\u04ae\3\2\2",
	    "\2\u0112\u04b6\3\2\2\2\u0114\u04c1\3\2\2\2\u0116\u04c3\3\2\2\2\u0118",
	    "\u04cd\3\2\2\2\u011a\u04cf\3\2\2\2\u011c\u04d8\3\2\2\2\u011e\u04e4",
	    "\3\2\2\2\u0120\u04f3\3\2\2\2\u0122\u04f5\3\2\2\2\u0124\u04fa\3\2\2",
	    "\2\u0126\u0507\3\2\2\2\u0128\u0511\3\2\2\2\u012a\u0513\3\2\2\2\u012c",
	    "\u0515\3\2\2\2\u012e\u0517\3\2\2\2\u0130\u051d\3\2\2\2\u0132\u052c",
	    "\3\2\2\2\u0134\u0533\3\2\2\2\u0136\u053a\3\2\2\2\u0138\u0552\3\2\2",
	    "\2\u013a\u055b\3\2\2\2\u013c\u055d\3\2\2\2\u013e\u056b\3\2\2\2\u0140",
	    "\u056d\3\2\2\2\u0142\u056f\3\2\2\2\u0144\u0574\3\2\2\2\u0146\u0579",
	    "\3\2\2\2\u0148\u057f\3\2\2\2\u014a\u0589\3\2\2\2\u014c\u058e\3\2\2",
	    "\2\u014e\u0594\3\2\2\2\u0150\u0596\3\2\2\2\u0152\u05a6\3\2\2\2\u0154",
	    "\u05a8\3\2\2\2\u0156\u05b0\3\2\2\2\u0158\u05b8\3\2\2\2\u015a\u05c1",
	    "\3\2\2\2\u015c\u05c4\3\2\2\2\u015e\u05c8\3\2\2\2\u0160\u05d1\3\2\2",
	    "\2\u0162\u05de\3\2\2\2\u0164\u05e9\3\2\2\2\u0166\u05ed\3\2\2\2\u0168",
	    "\u05ef\3\2\2\2\u016a\u05f1\3\2\2\2\u016c\u05f5\3\2\2\2\u016e\u05f7",
	    "\3\2\2\2\u0170\u0605\3\2\2\2\u0172\u060f\3\2\2\2\u0174\u0612\3\2\2",
	    "\2\u0176\u0624\3\2\2\2\u0178\u0626\3\2\2\2\u017a\u0631\3\2\2\2\u017c",
	    "\u0634\3\2\2\2\u017e\u0636\3\2\2\2\u0180\u0181\5:\36\2\u0181\3\3\2",
	    "\2\2\u0182\u0183\5`\61\2\u0183\5\3\2\2\2\u0184\u0185\5v<\2\u0185\7",
	    "\3\2\2\2\u0186\u0187\5z>\2\u0187\t\3\2\2\2\u0188\u0189\5\u0092J\2\u0189",
	    "\13\3\2\2\2\u018a\u018b\5\u00e8u\2\u018b\r\3\2\2\2\u018c\u018d\5\u00f8",
	    "}\2\u018d\17\3\2\2\2\u018e\u018f\5\u0122\u0092\2\u018f\21\3\2\2\2\u0190",
	    "\u0191\5\u0120\u0091\2\u0191\23\3\2\2\2\u0192\u0193\5\u0128\u0095\2",
	    "\u0193\25\3\2\2\2\u0194\u0195\5\u014e\u00a8\2\u0195\27\3\2\2\2\u0196",
	    "\u0197\5\u0168\u00b5\2\u0197\31\3\2\2\2\u0198\u0199\5\u0164\u00b3\2",
	    "\u0199\33\3\2\2\2\u019a\u019b\5\u0176\u00bc\2\u019b\35\3\2\2\2\u019c",
	    "\u019d\7!\2\2\u019d\37\3\2\2\2\u019e\u019f\7!\2\2\u019f\u01a0\7\u0086",
	    "\2\2\u01a0\u01a1\7\3\2\2\u01a1!\3\2\2\2\u01a2\u01a3\7!\2\2\u01a3\u01a5",
	    "\7\u0086\2\2\u01a4\u01a6\5\u0146\u00a4\2\u01a5\u01a4\3\2\2\2\u01a5",
	    "\u01a6\3\2\2\2\u01a6#\3\2\2\2\u01a7\u01a8\7\4\2\2\u01a8\u01ad\5\u00e6",
	    "t\2\u01a9\u01aa\7\5\2\2\u01aa\u01ac\5\u00e6t\2\u01ab\u01a9\3\2\2\2",
	    "\u01ac\u01af\3\2\2\2\u01ad\u01ab\3\2\2\2\u01ad\u01ae\3\2\2\2\u01ae",
	    "\u01b0\3\2\2\2\u01af\u01ad\3\2\2\2\u01b0\u01b1\7\6\2\2\u01b1%\3\2\2",
	    "\2\u01b2\u01b3\t\2\2\2\u01b3\'\3\2\2\2\u01b4\u01bd\7\t\2\2\u01b5\u01ba",
	    "\5l\67\2\u01b6\u01b7\7\5\2\2\u01b7\u01b9\5l\67\2\u01b8\u01b6\3\2\2",
	    "\2\u01b9\u01bc\3\2\2\2\u01ba\u01b8\3\2\2\2\u01ba\u01bb\3\2\2\2\u01bb",
	    "\u01be\3\2\2\2\u01bc\u01ba\3\2\2\2\u01bd\u01b5\3\2\2\2\u01bd\u01be",
	    "\3\2\2\2\u01be\u01bf\3\2\2\2\u01bf\u01c0\7\n\2\2\u01c0)\3\2\2\2\u01c1",
	    "\u01c2\5\u0136\u009c\2\u01c2+\3\2\2\2\u01c3\u01c6\7#\2\2\u01c4\u01c5",
	    "\7\13\2\2\u01c5\u01c7\5\u0166\u00b4\2\u01c6\u01c4\3\2\2\2\u01c6\u01c7",
	    "\3\2\2\2\u01c7\u01c8\3\2\2\2\u01c8\u01c9\7k\2\2\u01c9\u01ca\5\u00ea",
	    "v\2\u01ca-\3\2\2\2\u01cb\u01d0\5\64\33\2\u01cc\u01d0\5> \2\u01cd\u01d0",
	    "\5\u00caf\2\u01ce\u01d0\5\u0134\u009b\2\u01cf\u01cb\3\2\2\2\u01cf\u01cc",
	    "\3\2\2\2\u01cf\u01cd\3\2\2\2\u01cf\u01ce\3\2\2\2\u01d0/\3\2\2\2\u01d1",
	    "\u01d3\5d\63\2\u01d2\u01d1\3\2\2\2\u01d3\u01d6\3\2\2\2\u01d4\u01d2",
	    "\3\2\2\2\u01d4\u01d5\3\2\2\2\u01d5\u01d8\3\2\2\2\u01d6\u01d4\3\2\2",
	    "\2\u01d7\u01d9\5\\/\2\u01d8\u01d7\3\2\2\2\u01d8\u01d9\3\2\2\2\u01d9",
	    "\u01db\3\2\2\2\u01da\u01dc\5\u00ceh\2\u01db\u01da\3\2\2\2\u01db\u01dc",
	    "\3\2\2\2\u01dc\61\3\2\2\2\u01dd\u01de\7$\2\2\u01de\u01df\5\u0176\u00bc",
	    "\2\u01df\u01e0\7O\2\2\u01e0\u01e4\5\u009eP\2\u01e1\u01e3\5\u00fe\u0080",
	    "\2\u01e2\u01e1\3\2\2\2\u01e3\u01e6\3\2\2\2\u01e4\u01e2\3\2\2\2\u01e4",
	    "\u01e5\3\2\2\2\u01e5\u01e7\3\2\2\2\u01e6\u01e4\3\2\2\2\u01e7\u01e9",
	    "\7\3\2\2\u01e8\u01ea\5\u013e\u00a0\2\u01e9\u01e8\3\2\2\2\u01ea\u01eb",
	    "\3\2\2\2\u01eb\u01e9\3\2\2\2\u01eb\u01ec\3\2\2\2\u01ec\u01ed\3\2\2",
	    "\2\u01ed\u01ee\7:\2\2\u01ee\u01ef\7\3\2\2\u01ef\63\3\2\2\2\u01f0\u01f1",
	    "\7\'\2\2\u01f1\u01f2\5H%\2\u01f2\u01f4\7k\2\2\u01f3\u01f5\7m\2\2\u01f4",
	    "\u01f3\3\2\2\2\u01f4\u01f5\3\2\2\2\u01f5\u01f7\3\2\2\2\u01f6\u01f8",
	    "\7\u008e\2\2\u01f7\u01f6\3\2\2\2\u01f7\u01f8\3\2\2\2\u01f8\u01f9\3",
	    "\2\2\2\u01f9\u01fa\5\u00b6\\\2\u01fa\65\3\2\2\2\u01fb\u01ff\5\u009e",
	    "P\2\u01fc\u01fe\5\u00fe\u0080\2\u01fd\u01fc\3\2\2\2\u01fe\u0201\3\2",
	    "\2\2\u01ff\u01fd\3\2\2\2\u01ff\u0200\3\2\2\2\u0200\u0202\3\2\2\2\u0201",
	    "\u01ff\3\2\2\2\u0202\u0203\7\f\2\2\u0203\u0204\5\u0086D\2\u0204\u0205",
	    "\7\3\2\2\u0205\67\3\2\2\2\u0206\u0209\5:\36\2\u0207\u0209\5\u0104\u0083",
	    "\2\u0208\u0206\3\2\2\2\u0208\u0207\3\2\2\2\u02099\3\2\2\2\u020a\u020b",
	    "\7\u009f\2\2\u020b;\3\2\2\2\u020c\u020d\7\r\2\2\u020d\u020e\5\2\2\2",
	    "\u020e=\3\2\2\2\u020f\u0211\7+\2\2\u0210\u0212\5H%\2\u0211\u0210\3",
	    "\2\2\2\u0211\u0212\3\2\2\2\u0212\u0213\3\2\2\2\u0213\u0214\7k\2\2\u0214",
	    "\u0215\5\u00b6\\\2\u0215?\3\2\2\2\u0216\u0218\7.\2\2\u0217\u0219\5",
	    "\u017e\u00c0\2\u0218\u0217\3\2\2\2\u0218\u0219\3\2\2\2\u0219A\3\2\2",
	    "\2\u021a\u021b\7\60\2\2\u021bC\3\2\2\2\u021c\u021d\5\u00e2r\2\u021d",
	    "E\3\2\2\2\u021e\u021f\5\u00e2r\2\u021fG\3\2\2\2\u0220\u0221\7\t\2\2",
	    "\u0221\u0222\5D#\2\u0222\u0223\7\13\2\2\u0223\u0224\5F$\2\u0224\u0225",
	    "\7\n\2\2\u0225I\3\2\2\2\u0226\u0227\t\3\2\2\u0227K\3\2\2\2\u0228\u0229",
	    "\t\4\2\2\u0229M\3\2\2\2\u022a\u022b\t\5\2\2\u022bO\3\2\2\2\u022c\u0231",
	    "\5R*\2\u022d\u022e\7\5\2\2\u022e\u0230\5R*\2\u022f\u022d\3\2\2\2\u0230",
	    "\u0233\3\2\2\2\u0231\u022f\3\2\2\2\u0231\u0232\3\2\2\2\u0232\u0234",
	    "\3\2\2\2\u0233\u0231\3\2\2\2\u0234\u0235\7\13\2\2\u0235\u0236\5\u013e",
	    "\u00a0\2\u0236Q\3\2\2\2\u0237\u0238\5\u0086D\2\u0238S\3\2\2\2\u0239",
	    "\u023a\7\62\2\2\u023a\u023b\5\u012c\u0097\2\u023b\u023f\7k\2\2\u023c",
	    "\u023e\5P)\2\u023d\u023c\3\2\2\2\u023e\u0241\3\2\2\2\u023f\u023d\3",
	    "\2\2\2\u023f\u0240\3\2\2\2\u0240\u0245\3\2\2\2\u0241\u023f\3\2\2\2",
	    "\u0242\u0243\7o\2\2\u0243\u0244\7\13\2\2\u0244\u0246\5\u013e\u00a0",
	    "\2\u0245\u0242\3\2\2\2\u0245\u0246\3\2\2\2\u0246\u0247\3\2\2\2\u0247",
	    "\u0248\7;\2\2\u0248\u0249\7\3\2\2\u0249U\3\2\2\2\u024a\u024c\7-\2\2",
	    "\u024b\u024d\5\u013e\u00a0\2\u024c\u024b\3\2\2\2\u024d\u024e\3\2\2",
	    "\2\u024e\u024c\3\2\2\2\u024e\u024f\3\2\2\2\u024f\u0250\3\2\2\2\u0250",
	    "\u0251\79\2\2\u0251\u0252\7\3\2\2\u0252W\3\2\2\2\u0253\u0257\5.\30",
	    "\2\u0254\u0257\5\u013a\u009e\2\u0255\u0257\5\32\16\2\u0256\u0253\3",
	    "\2\2\2\u0256\u0254\3\2\2\2\u0256\u0255\3\2\2\2\u0257Y\3\2\2\2\u0258",
	    "\u0259\5`\61\2\u0259\u025a\7\13\2\2\u025a\u025b\5\u00b6\\\2\u025b\u025c",
	    "\7\f\2\2\u025c\u025d\5\u0086D\2\u025d\u025e\7\3\2\2\u025e[\3\2\2\2",
	    "\u025f\u0261\7\63\2\2\u0260\u0262\5Z.\2\u0261\u0260\3\2\2\2\u0262\u0263",
	    "\3\2\2\2\u0263\u0261\3\2\2\2\u0263\u0264\3\2\2\2\u0264\u0265\3\2\2",
	    "\2\u0265\u0266\7<\2\2\u0266\u0267\7\3\2\2\u0267]\3\2\2\2\u0268\u026b",
	    "\5J&\2\u0269\u026b\5\4\3\2\u026a\u0268\3\2\2\2\u026a\u0269\3\2\2\2",
	    "\u026b_\3\2\2\2\u026c\u026d\7\u009f\2\2\u026da\3\2\2\2\u026e\u0271",
	    "\5\u0080A\2\u026f\u0271\5\u0132\u009a\2\u0270\u026e\3\2\2\2\u0270\u026f",
	    "\3\2\2\2\u0271c\3\2\2\2\u0272\u0278\5r:\2\u0273\u0278\5\u008eH\2\u0274",
	    "\u0278\5\u00f4{\2\u0275\u0278\5\u014a\u00a6\2\u0276\u0278\5\u0162\u00b2",
	    "\2\u0277\u0272\3\2\2\2\u0277\u0273\3\2\2\2\u0277\u0274\3\2\2\2\u0277",
	    "\u0275\3\2\2\2\u0277\u0276\3\2\2\2\u0278e\3\2\2\2\u0279\u027a\58\35",
	    "\2\u027a\u027b\7\13\2\2\u027b\u027c\5\u00eav\2\u027c\u027d\7\f\2\2",
	    "\u027d\u027e\5\u0086D\2\u027e\u027f\7\3\2\2\u027fg\3\2\2\2\u0280\u0282",
	    "\7\66\2\2\u0281\u0283\5f\64\2\u0282\u0281\3\2\2\2\u0283\u0284\3\2\2",
	    "\2\u0284\u0282\3\2\2\2\u0284\u0285\3\2\2\2\u0285i\3\2\2\2\u0286\u0287",
	    "\5\u0122\u0092\2\u0287\u0288\7\13\2\2\u0288\u028a\3\2\2\2\u0289\u0286",
	    "\3\2\2\2\u0289\u028a\3\2\2\2\u028a\u028b\3\2\2\2\u028b\u028c\5\u0086",
	    "D\2\u028ck\3\2\2\2\u028d\u0290\5\u0086D\2\u028e\u028f\7\13\2\2\u028f",
	    "\u0291\5\u0114\u008b\2\u0290\u028e\3\2\2\2\u0290\u0291\3\2\2\2\u0291",
	    "m\3\2\2\2\u0292\u0294\5\u0084C\2\u0293\u0292\3\2\2\2\u0294\u0297\3",
	    "\2\2\2\u0295\u0293\3\2\2\2\u0295\u0296\3\2\2\2\u0296\u0299\3\2\2\2",
	    "\u0297\u0295\3\2\2\2\u0298\u029a\5h\65\2\u0299\u0298\3\2\2\2\u0299",
	    "\u029a\3\2\2\2\u029a\u029c\3\2\2\2\u029b\u029d\5\u00c8e\2\u029c\u029b",
	    "\3\2\2\2\u029c\u029d\3\2\2\2\u029d\u029f\3\2\2\2\u029e\u02a0\5\u016e",
	    "\u00b8\2\u029f\u029e\3\2\2\2\u029f\u02a0\3\2\2\2\u02a0\u02a2\3\2\2",
	    "\2\u02a1\u02a3\5\u0178\u00bd\2\u02a2\u02a1\3\2\2\2\u02a2\u02a3\3\2",
	    "\2\2\u02a3o\3\2\2\2\u02a4\u02a5\5\6\4\2\u02a5\u02ae\7\4\2\2\u02a6\u02ab",
	    "\5\u0086D\2\u02a7\u02a8\7\5\2\2\u02a8\u02aa\5\u0086D\2\u02a9\u02a7",
	    "\3\2\2\2\u02aa\u02ad\3\2\2\2\u02ab\u02a9\3\2\2\2\u02ab\u02ac\3\2\2",
	    "\2\u02ac\u02af\3\2\2\2\u02ad\u02ab\3\2\2\2\u02ae\u02a6\3\2\2\2\u02ae",
	    "\u02af\3\2\2\2\u02af\u02b0\3\2\2\2\u02b0\u02b1\7\6\2\2\u02b1q\3\2\2",
	    "\2\u02b2\u02b3\5t;\2\u02b3\u02b4\5n8\2\u02b4\u02b5\7=\2\2\u02b5\u02b6",
	    "\7\3\2\2\u02b6s\3\2\2\2\u02b7\u02b8\7G\2\2\u02b8\u02b9\5v<\2\u02b9",
	    "\u02ba\5\u0144\u00a3\2\u02ba\u02bb\7\3\2\2\u02bbu\3\2\2\2\u02bc\u02bd",
	    "\7\u009f\2\2\u02bdw\3\2\2\2\u02be\u02bf\7,\2\2\u02bf\u02c2\5\32\16",
	    "\2\u02c0\u02c1\7\u0097\2\2\u02c1\u02c3\5|?\2\u02c2\u02c0\3\2\2\2\u02c2",
	    "\u02c3\3\2\2\2\u02c3y\3\2\2\2\u02c4\u02c5\7\u009f\2\2\u02c5{\3\2\2",
	    "\2\u02c6\u02c7\7\4\2\2\u02c7\u02cc\5z>\2\u02c8\u02c9\7\5\2\2\u02c9",
	    "\u02cb\5z>\2\u02ca\u02c8\3\2\2\2\u02cb\u02ce\3\2\2\2\u02cc\u02ca\3",
	    "\2\2\2\u02cc\u02cd\3\2\2\2\u02cd\u02cf\3\2\2\2\u02ce\u02cc\3\2\2\2",
	    "\u02cf\u02d0\7\6\2\2\u02d0}\3\2\2\2\u02d1\u02d2\5\32\16\2\u02d2\u02d3",
	    "\7\r\2\2\u02d3\u02d5\3\2\2\2\u02d4\u02d1\3\2\2\2\u02d4\u02d5\3\2\2",
	    "\2\u02d5\u02d6\3\2\2\2\u02d6\u02d7\5\b\5\2\u02d7\177\3\2\2\2\u02d8",
	    "\u02da\7L\2\2\u02d9\u02d8\3\2\2\2\u02d9\u02da\3\2\2\2\u02da\u02db\3",
	    "\2\2\2\u02db\u02df\7H\2\2\u02dc\u02dd\7k\2\2\u02dd\u02e0\5|?\2\u02de",
	    "\u02e0\5x=\2\u02df\u02dc\3\2\2\2\u02df\u02de\3\2\2\2\u02df\u02e0\3",
	    "\2\2\2\u02e0\u0081\3\2\2\2\u02e1\u02e2\7I\2\2\u02e2\u02e3\7\3\2\2\u02e3",
	    "\u0083\3\2\2\2\u02e4\u02e9\58\35\2\u02e5\u02e6\7\5\2\2\u02e6\u02e8",
	    "\58\35\2\u02e7\u02e5\3\2\2\2\u02e8\u02eb\3\2\2\2\u02e9\u02e7\3\2\2",
	    "\2\u02e9\u02ea\3\2\2\2\u02ea\u02ec\3\2\2\2\u02eb\u02e9\3\2\2\2\u02ec",
	    "\u02ee\7\13\2\2\u02ed\u02ef\7m\2\2\u02ee\u02ed\3\2\2\2\u02ee\u02ef",
	    "\3\2\2\2\u02ef\u02f0\3\2\2\2\u02f0\u02f1\5\u00eav\2\u02f1\u02f2\7\3",
	    "\2\2\u02f2\u0085\3\2\2\2\u02f3\u02f7\5\u0136\u009c\2\u02f4\u02f5\5",
	    "\u010c\u0087\2\u02f5\u02f6\5\u0136\u009c\2\u02f6\u02f8\3\2\2\2\u02f7",
	    "\u02f4\3\2\2\2\u02f7\u02f8\3\2\2\2\u02f8\u0087\3\2\2\2\u02f9\u02fc",
	    "\5\u0138\u009d\2\u02fa\u02fb\7\17\2\2\u02fb\u02fd\5\u0138\u009d\2\u02fc",
	    "\u02fa\3\2\2\2\u02fc\u02fd\3\2\2\2\u02fd\u0089\3\2\2\2\u02fe\u0303",
	    "\5\u00e8u\2\u02ff\u0300\7\5\2\2\u0300\u0302\5\u00e8u\2\u0301\u02ff",
	    "\3\2\2\2\u0302\u0305\3\2\2\2\u0303\u0301\3\2\2\2\u0303\u0304\3\2\2",
	    "\2\u0304\u0306\3\2\2\2\u0305\u0303\3\2\2\2\u0306\u0307\7\13\2\2\u0307",
	    "\u0308\5\u00eav\2\u0308\u008b\3\2\2\2\u0309\u030c\5L\'\2\u030a\u030c",
	    "\5\n\6\2\u030b\u0309\3\2\2\2\u030b\u030a\3\2\2\2\u030c\u030e\3\2\2",
	    "\2\u030d\u030f\5$\23\2\u030e\u030d\3\2\2\2\u030e\u030f\3\2\2\2\u030f",
	    "\u008d\3\2\2\2\u0310\u0311\5\u0090I\2\u0311\u0313\5\60\31\2\u0312\u0314",
	    "\5\u013e\u00a0\2\u0313\u0312\3\2\2\2\u0314\u0315\3\2\2\2\u0315\u0313",
	    "\3\2\2\2\u0315\u0316\3\2\2\2\u0316\u0317\3\2\2\2\u0317\u0318\7>\2\2",
	    "\u0318\u0319\7\3\2\2\u0319\u008f\3\2\2\2\u031a\u031b\7R\2\2\u031b\u0327",
	    "\5\u0092J\2\u031c\u031d\7\4\2\2\u031d\u0322\5\u008aF\2\u031e\u031f",
	    "\7\3\2\2\u031f\u0321\5\u008aF\2\u0320\u031e\3\2\2\2\u0321\u0324\3\2",
	    "\2\2\u0322\u0320\3\2\2\2\u0322\u0323\3\2\2\2\u0323\u0325\3\2\2\2\u0324",
	    "\u0322\3\2\2\2\u0325\u0326\7\6\2\2\u0326\u0328\3\2\2\2\u0327\u031c",
	    "\3\2\2\2\u0327\u0328\3\2\2\2\u0328\u0329\3\2\2\2\u0329\u032a\7\13\2",
	    "\2\u032a\u032b\5\u00eav\2\u032b\u032c\7\3\2\2\u032c\u0091\3\2\2\2\u032d",
	    "\u032e\7\u009f\2\2\u032e\u0093\3\2\2\2\u032f\u0334\5,\27\2\u0330\u0334",
	    "\5\u0096L\2\u0331\u0334\5\u00a2R\2\u0332\u0334\5\u00a4S\2\u0333\u032f",
	    "\3\2\2\2\u0333\u0330\3\2\2\2\u0333\u0331\3\2\2\2\u0333\u0332\3\2\2",
	    "\2\u0334\u0095\3\2\2\2\u0335\u033a\5\u0098M\2\u0336\u033a\5\u009aN",
	    "\2\u0337\u033a\5\u009cO\2\u0338\u033a\5\u00a0Q\2\u0339\u0335\3\2\2",
	    "\2\u0339\u0336\3\2\2\2\u0339\u0337\3\2\2\2\u0339\u0338\3\2\2\2\u033a",
	    "\u0097\3\2\2\2\u033b\u033d\7\'\2\2\u033c\u033e\5H%\2\u033d\u033c\3",
	    "\2\2\2\u033d\u033e\3\2\2\2\u033e\u033f\3\2\2\2\u033f\u0341\7k\2\2\u0340",
	    "\u0342\7m\2\2\u0341\u0340\3\2\2\2\u0341\u0342\3\2\2\2\u0342\u0344\3",
	    "\2\2\2\u0343\u0345\7\u008e\2\2\u0344\u0343\3\2\2\2\u0344\u0345\3\2",
	    "\2\2\u0345\u0346\3\2\2\2\u0346\u0347\5\u00eav\2\u0347\u0099\3\2\2\2",
	    "\u0348\u034a\7+\2\2\u0349\u034b\5H%\2\u034a\u0349\3\2\2\2\u034a\u034b",
	    "\3\2\2\2\u034b\u034c\3\2\2\2\u034c\u034d\7k\2\2\u034d\u034e\5\u00ea",
	    "v\2\u034e\u009b\3\2\2\2\u034f\u0351\7^\2\2\u0350\u0352\5H%\2\u0351",
	    "\u0350\3\2\2\2\u0351\u0352\3\2\2\2\u0352\u0353\3\2\2\2\u0353\u0355",
	    "\7k\2\2\u0354\u0356\7\u008e\2\2\u0355\u0354\3\2\2\2\u0355\u0356\3\2",
	    "\2\2\u0356\u0357\3\2\2\2\u0357\u0358\5\u00eav\2\u0358\u009d\3\2\2\2",
	    "\u0359\u035c\5\f\7\2\u035a\u035c\5\u0176\u00bc\2\u035b\u0359\3\2\2",
	    "\2\u035b\u035a\3\2\2\2\u035c\u009f\3\2\2\2\u035d\u035f\7~\2\2\u035e",
	    "\u0360\5H%\2\u035f\u035e\3\2\2\2\u035f\u0360\3\2\2\2\u0360\u0361\3",
	    "\2\2\2\u0361\u0362\7k\2\2\u0362\u0363\5\u00eav\2\u0363\u00a1\3\2\2",
	    "\2\u0364\u0367\7T\2\2\u0365\u0366\7\13\2\2\u0366\u0368\5\u0166\u00b4",
	    "\2\u0367\u0365\3\2\2\2\u0367\u0368\3\2\2\2\u0368\u00a3\3\2\2\2\u0369",
	    "\u036c\7S\2\2\u036a\u036b\7\13\2\2\u036b\u036d\5\u0166\u00b4\2\u036c",
	    "\u036a\3\2\2\2\u036c\u036d\3\2\2\2\u036d\u00a5\3\2\2\2\u036e\u036f",
	    "\7\20\2\2\u036f\u0370\5\6\4\2\u0370\u00a7\3\2\2\2\u0371\u0372\7W\2",
	    "\2\u0372\u0373\5\u00d2j\2\u0373\u0375\7\u0088\2\2\u0374\u0376\5\u013e",
	    "\u00a0\2\u0375\u0374\3\2\2\2\u0376\u0377\3\2\2\2\u0377\u0375\3\2\2",
	    "\2\u0377\u0378\3\2\2\2\u0378\u037f\3\2\2\2\u0379\u037b\78\2\2\u037a",
	    "\u037c\5\u013e\u00a0\2\u037b\u037a\3\2\2\2\u037c\u037d\3\2\2\2\u037d",
	    "\u037b\3\2\2\2\u037d\u037e\3\2\2\2\u037e\u0380\3\2\2\2\u037f\u0379",
	    "\3\2\2\2\u037f\u0380\3\2\2\2\u0380\u0381\3\2\2\2\u0381\u0382\7?\2\2",
	    "\u0382\u0383\7\3\2\2\u0383\u00a9\3\2\2\2\u0384\u0385\5\u00e2r\2\u0385",
	    "\u00ab\3\2\2\2\u0386\u0387\5\u0176\u00bc\2\u0387\u0388\7\f\2\2\u0388",
	    "\u0389\5D#\2\u0389\u038a\7\u0089\2\2\u038a\u038d\5F$\2\u038b\u038c",
	    "\7\61\2\2\u038c\u038e\5\u00aaV\2\u038d\u038b\3\2\2\2\u038d\u038e\3",
	    "\2\2\2\u038e\u00ad\3\2\2\2\u038f\u0390\5\u00e2r\2\u0390\u00af\3\2\2",
	    "\2\u0391\u0392\5\u00aeX\2\u0392\u00b1\3\2\2\2\u0393\u0394\5\u00aeX",
	    "\2\u0394\u00b3\3\2\2\2\u0395\u0396\7\t\2\2\u0396\u0399\5\u00b0Y\2\u0397",
	    "\u0398\7\13\2\2\u0398\u039a\5\u00b2Z\2\u0399\u0397\3\2\2\2\u0399\u039a",
	    "\3\2\2\2\u039a\u039b\3\2\2\2\u039b\u039c\7\n\2\2\u039c\u00b5\3\2\2",
	    "\2\u039d\u03a0\5X-\2\u039e\u03a0\5\6\4\2\u039f\u039d\3\2\2\2\u039f",
	    "\u039e\3\2\2\2\u03a0\u00b7\3\2\2\2\u03a1\u03a2\7Z\2\2\u03a2\u00b9\3",
	    "\2\2\2\u03a3\u03a6\5\u0108\u0085\2\u03a4\u03a6\5\u0174\u00bb\2\u03a5",
	    "\u03a3\3\2\2\2\u03a5\u03a4\3\2\2\2\u03a6\u00bb\3\2\2\2\u03a7\u03a8",
	    "\7\21\2\2\u03a8\u03a9\5\u00c2b\2\u03a9\u03aa\5\u00c4c\2\u03aa\u03ab",
	    "\5\u00c0a\2\u03ab\u03ac\5\u00c4c\2\u03ac\u03ad\5\u00be`\2\u03ad\u03ae",
	    "\7\22\2\2\u03ae\u00bd\3\2\2\2\u03af\u03b0\5\u0136\u009c\2\u03b0\u00bf",
	    "\3\2\2\2\u03b1\u03b2\5\u0136\u009c\2\u03b2\u00c1\3\2\2\2\u03b3\u03b4",
	    "\5\u0136\u009c\2\u03b4\u00c3\3\2\2\2\u03b5\u03b6\t\6\2\2\u03b6\u00c5",
	    "\3\2\2\2\u03b7\u03b8\58\35\2\u03b8\u03be\7\13\2\2\u03b9\u03bb\t\7\2",
	    "\2\u03ba\u03bc\5H%\2\u03bb\u03ba\3\2\2\2\u03bb\u03bc\3\2\2\2\u03bc",
	    "\u03bd\3\2\2\2\u03bd\u03bf\7k\2\2\u03be\u03b9\3\2\2\2\u03be\u03bf\3",
	    "\2\2\2\u03bf\u03c0\3\2\2\2\u03c0\u03c1\5\6\4\2\u03c1\u03c5\7O\2\2\u03c2",
	    "\u03c3\5\6\4\2\u03c3\u03c4\7\r\2\2\u03c4\u03c6\3\2\2\2\u03c5\u03c2",
	    "\3\2\2\2\u03c5\u03c6\3\2\2\2\u03c6\u03c7\3\2\2\2\u03c7\u03c8\5\2\2",
	    "\2\u03c8\u03c9\7\3\2\2\u03c9\u00c7\3\2\2\2\u03ca\u03cc\7[\2\2\u03cb",
	    "\u03cd\5\u00c6d\2\u03cc\u03cb\3\2\2\2\u03cd\u03ce\3\2\2\2\u03ce\u03cc",
	    "\3\2\2\2\u03ce\u03cf\3\2\2\2\u03cf\u00c9\3\2\2\2\u03d0\u03d2\7^\2\2",
	    "\u03d1\u03d3\5H%\2\u03d2\u03d1\3\2\2\2\u03d2\u03d3\3\2\2\2\u03d3\u03d4",
	    "\3\2\2\2\u03d4\u03d6\7k\2\2\u03d5\u03d7\7\u008e\2\2\u03d6\u03d5\3\2",
	    "\2\2\u03d6\u03d7\3\2\2\2\u03d7\u03d8\3\2\2\2\u03d8\u03d9\5\u00b6\\",
	    "\2\u03d9\u00cb\3\2\2\2\u03da\u03e0\7\u009b\2\2\u03db\u03e0\7\u009d",
	    "\2\2\u03dc\u03e0\5\u00d4k\2\u03dd\u03e0\7\u009e\2\2\u03de\u03e0\5\u0140",
	    "\u00a1\2\u03df\u03da\3\2\2\2\u03df\u03db\3\2\2\2\u03df\u03dc\3\2\2",
	    "\2\u03df\u03dd\3\2\2\2\u03df\u03de\3\2\2\2\u03e0\u00cd\3\2\2\2\u03e1",
	    "\u03e3\7`\2\2\u03e2\u03e4\5\u00d0i\2\u03e3\u03e2\3\2\2\2\u03e4\u03e5",
	    "\3\2\2\2\u03e5\u03e3\3\2\2\2\u03e5\u03e6\3\2\2\2\u03e6\u03e7\3\2\2",
	    "\2\u03e7\u03e8\7@\2\2\u03e8\u03e9\7\3\2\2\u03e9\u00cf\3\2\2\2\u03ea",
	    "\u03ef\5\u0176\u00bc\2\u03eb\u03ec\7\5\2\2\u03ec\u03ee\5\u0176\u00bc",
	    "\2\u03ed\u03eb\3\2\2\2\u03ee\u03f1\3\2\2\2\u03ef\u03ed\3\2\2\2\u03ef",
	    "\u03f0\3\2\2\2\u03f0\u03f2\3\2\2\2\u03f1\u03ef\3\2\2\2\u03f2\u03f3",
	    "\7\13\2\2\u03f3\u03f6\5\u00eav\2\u03f4\u03f5\7\f\2\2\u03f5\u03f7\5",
	    "\u0086D\2\u03f6\u03f4\3\2\2\2\u03f6\u03f7\3\2\2\2\u03f7\u03f8\3\2\2",
	    "\2\u03f8\u03f9\7\3\2\2\u03f9\u00d1\3\2\2\2\u03fa\u03fb\5\u0086D\2\u03fb",
	    "\u00d3\3\2\2\2\u03fc\u03fd\t\b\2\2\u03fd\u00d5\3\2\2\2\u03fe\u03ff",
	    "\7d\2\2\u03ff\u00d7\3\2\2\2\u0400\u0401\t\t\2\2\u0401\u00d9\3\2\2\2",
	    "\u0402\u0405\5\6\4\2\u0403\u0405\5\32\16\2\u0404\u0402\3\2\2\2\u0404",
	    "\u0403\3\2\2\2\u0405\u00db\3\2\2\2\u0406\u040c\5\u00dan\2\u0407\u040a",
	    "\7(\2\2\u0408\u040b\5v<\2\u0409\u040b\5\u0164\u00b3\2\u040a\u0408\3",
	    "\2\2\2\u040a\u0409\3\2\2\2\u040b\u040d\3\2\2\2\u040c\u0407\3\2\2\2",
	    "\u040c\u040d\3\2\2\2\u040d\u00dd\3\2\2\2\u040e\u040f\7\3\2\2\u040f",
	    "\u00df\3\2\2\2\u0410\u0411\7h\2\2\u0411\u00e1\3\2\2\2\u0412\u0413\5",
	    "\u0136\u009c\2\u0413\u00e3\3\2\2\2\u0414\u0415\7l\2\2\u0415\u0416\7",
	    "\4\2\2\u0416\u041b\5\u0154\u00ab\2\u0417\u0418\7\5\2\2\u0418\u041a",
	    "\5\u0154\u00ab\2\u0419\u0417\3\2\2\2\u041a\u041d\3\2\2\2\u041b\u0419",
	    "\3\2\2\2\u041b\u041c\3\2\2\2\u041c\u041e\3\2\2\2\u041d\u041b\3\2\2",
	    "\2\u041e\u041f\7\6\2\2\u041f\u00e5\3\2\2\2\u0420\u0421\5\u0086D\2\u0421",
	    "\u00e7\3\2\2\2\u0422\u0423\7\u009f\2\2\u0423\u00e9\3\2\2\2\u0424\u0428",
	    "\5\u0094K\2\u0425\u0428\5\u00dan\2\u0426\u0428\5\u013a\u009e\2\u0427",
	    "\u0424\3\2\2\2\u0427\u0425\3\2\2\2\u0427\u0426\3\2\2\2\u0428\u00eb",
	    "\3\2\2\2\u0429\u042a\5\6\4\2\u042a\u00ed\3\2\2\2\u042b\u042c\5\u00e2",
	    "r\2\u042c\u00ef\3\2\2\2\u042d\u0436\5\u00ccg\2\u042e\u0432\5\u00fa",
	    "~\2\u042f\u0431\5\u00fe\u0080\2\u0430\u042f\3\2\2\2\u0431\u0434\3\2",
	    "\2\2\u0432\u0430\3\2\2\2\u0432\u0433\3\2\2\2\u0433\u0436\3\2\2\2\u0434",
	    "\u0432\3\2\2\2\u0435\u042d\3\2\2\2\u0435\u042e\3\2\2\2\u0436\u00f1",
	    "\3\2\2\2\u0437\u043a\5N(\2\u0438\u043a\5\16\b\2\u0439\u0437\3\2\2\2",
	    "\u0439\u0438\3\2\2\2\u043a\u043c\3\2\2\2\u043b\u043d\5$\23\2\u043c",
	    "\u043b\3\2\2\2\u043c\u043d\3\2\2\2\u043d\u043e\3\2\2\2\u043e\u043f",
	    "\7\3\2\2\u043f\u00f3\3\2\2\2\u0440\u0441\5\u00f6|\2\u0441\u0445\5\60",
	    "\31\2\u0442\u0444\5\u013e\u00a0\2\u0443\u0442\3\2\2\2\u0444\u0447\3",
	    "\2\2\2\u0445\u0443\3\2\2\2\u0445\u0446\3\2\2\2\u0446\u0448\3\2\2\2",
	    "\u0447\u0445\3\2\2\2\u0448\u0449\7A\2\2\u0449\u044a\7\3\2\2\u044a\u00f5",
	    "\3\2\2\2\u044b\u044c\7q\2\2\u044c\u045e\5\u00f8}\2\u044d\u044f\7\4",
	    "\2\2\u044e\u0450\7\u0096\2\2\u044f\u044e\3\2\2\2\u044f\u0450\3\2\2",
	    "\2\u0450\u0451\3\2\2\2\u0451\u0459\5\u008aF\2\u0452\u0454\7\3\2\2\u0453",
	    "\u0455\7\u0096\2\2\u0454\u0453\3\2\2\2\u0454\u0455\3\2\2\2\u0455\u0456",
	    "\3\2\2\2\u0456\u0458\5\u008aF\2\u0457\u0452\3\2\2\2\u0458\u045b\3\2",
	    "\2\2\u0459\u0457\3\2\2\2\u0459\u045a\3\2\2\2\u045a\u045c\3\2\2\2\u045b",
	    "\u0459\3\2\2\2\u045c\u045d\7\6\2\2\u045d\u045f\3\2\2\2\u045e\u044d",
	    "\3\2\2\2\u045e\u045f\3\2\2\2\u045f\u0460\3\2\2\2\u0460\u0461\7\3\2",
	    "\2\u0461\u00f7\3\2\2\2\u0462\u0463\7\u009f\2\2\u0463\u00f9\3\2\2\2",
	    "\u0464\u046a\5\2\2\2\u0465\u046a\5^\60\2\u0466\u046a\5\u008cG\2\u0467",
	    "\u046a\5\u009eP\2\u0468\u046a\5\u00ecw\2\u0469\u0464\3\2\2\2\u0469",
	    "\u0465\3\2\2\2\u0469\u0466\3\2\2\2\u0469\u0467\3\2\2\2\u0469\u0468",
	    "\3\2\2\2\u046a\u00fb\3\2\2\2\u046b\u046c\7}\2\2\u046c\u046d\5\u00a6",
	    "T\2\u046d\u046e\5<\37\2\u046e\u00fd\3\2\2\2\u046f\u0473\5<\37\2\u0470",
	    "\u0473\5\u00a6T\2\u0471\u0473\5\u00b4[\2\u0472\u046f\3\2\2\2\u0472",
	    "\u0470\3\2\2\2\u0472\u0471\3\2\2\2\u0473\u00ff\3\2\2\2\u0474\u0475",
	    "\7r\2\2\u0475\u0476\7\4\2\2\u0476\u0477\5\u0176\u00bc\2\u0477\u0478",
	    "\7\30\2\2\u0478\u0479\5*\26\2\u0479\u047a\7\31\2\2\u047a\u047b\5\u00d2",
	    "j\2\u047b\u047c\7\6\2\2\u047c\u0101\3\2\2\2\u047d\u0482\7s\2\2\u047e",
	    "\u047f\7\4\2\2\u047f\u0480\5\u00eex\2\u0480\u0481\7\6\2\2\u0481\u0483",
	    "\3\2\2\2\u0482\u047e\3\2\2\2\u0482\u0483\3\2\2\2\u0483\u0103\3\2\2",
	    "\2\u0484\u0487\5\u00fc\177\2\u0485\u0486\7v\2\2\u0486\u0488\5:\36\2",
	    "\u0487\u0485\3\2\2\2\u0487\u0488\3\2\2\2\u0488\u0105\3\2\2\2\u0489",
	    "\u048c\5\2\2\2\u048a\u048c\5\u00fc\177\2\u048b\u0489\3\2\2\2\u048b",
	    "\u048a\3\2\2\2\u048c\u0107\3\2\2\2\u048d\u048e\7t\2\2\u048e\u048f\7",
	    "Q\2\2\u048f\u049b\5\24\13\2\u0490\u0491\7\4\2\2\u0491\u0496\5\u0116",
	    "\u008c\2\u0492\u0493\7\5\2\2\u0493\u0495\5\u0116\u008c\2\u0494\u0492",
	    "\3\2\2\2\u0495\u0498\3\2\2\2\u0496\u0494\3\2\2\2\u0496\u0497\3\2\2",
	    "\2\u0497\u0499\3\2\2\2\u0498\u0496\3\2\2\2\u0499\u049a\7\6\2\2\u049a",
	    "\u049c\3\2\2\2\u049b\u0490\3\2\2\2\u049b\u049c\3\2\2\2\u049c\u049d",
	    "\3\2\2\2\u049d\u049e\7\3\2\2\u049e\u0109\3\2\2\2\u049f\u04a0\t\n\2",
	    "\2\u04a0\u010b\3\2\2\2\u04a1\u04a5\5\u010a\u0086\2\u04a2\u04a5\7X\2",
	    "\2\u04a3\u04a5\7]\2\2\u04a4\u04a1\3\2\2\2\u04a4\u04a2\3\2\2\2\u04a4",
	    "\u04a3\3\2\2\2\u04a5\u010d\3\2\2\2\u04a6\u04ac\5`\61\2\u04a7\u04ac",
	    "\5v<\2\u04a8\u04ac\5\u0092J\2\u04a9\u04ac\5\u00f8}\2\u04aa\u04ac\5",
	    "\u0164\u00b3\2\u04ab\u04a6\3\2\2\2\u04ab\u04a7\3\2\2\2\u04ab\u04a8",
	    "\3\2\2\2\u04ab\u04a9\3\2\2\2\u04ab\u04aa\3\2\2\2\u04ac\u010f\3\2\2",
	    "\2\u04ad\u04af\5\u00acW\2\u04ae\u04ad\3\2\2\2\u04ae\u04af\3\2\2\2\u04af",
	    "\u04b1\3\2\2\2\u04b0\u04b2\5\u017a\u00be\2\u04b1\u04b0\3\2\2\2\u04b1",
	    "\u04b2\3\2\2\2\u04b2\u04b4\3\2\2\2\u04b3\u04b5\5\u0172\u00ba\2\u04b4",
	    "\u04b3\3\2\2\2\u04b4\u04b5\3\2\2\2\u04b5\u0111\3\2\2\2\u04b6\u04b7",
	    "\7w\2\2\u04b7\u04b8\5\u0110\u0089\2\u04b8\u04ba\7\3\2\2\u04b9\u04bb",
	    "\5\u013e\u00a0\2\u04ba\u04b9\3\2\2\2\u04bb\u04bc\3\2\2\2\u04bc\u04ba",
	    "\3\2\2\2\u04bc\u04bd\3\2\2\2\u04bd\u04be\3\2\2\2\u04be\u04bf\7B\2\2",
	    "\u04bf\u04c0\7\3\2\2\u04c0\u0113\3\2\2\2\u04c1\u04c2\5\u00e2r\2\u04c2",
	    "\u0115\3\2\2\2\u04c3\u04c6\5\u0118\u008d\2\u04c4\u04c5\7(\2\2\u04c5",
	    "\u04c7\5\u010e\u0088\2\u04c6\u04c4\3\2\2\2\u04c6\u04c7\3\2\2\2\u04c7",
	    "\u0117\3\2\2\2\u04c8\u04ce\5\4\3\2\u04c9\u04ce\5\6\4\2\u04ca\u04ce",
	    "\5\n\6\2\u04cb\u04ce\5\16\b\2\u04cc\u04ce\5\32\16\2\u04cd\u04c8\3\2",
	    "\2\2\u04cd\u04c9\3\2\2\2\u04cd\u04ca\3\2\2\2\u04cd\u04cb\3\2\2\2\u04cd",
	    "\u04cc\3\2\2\2\u04ce\u0119\3\2\2\2\u04cf\u04d4\7x\2\2\u04d0\u04d1\7",
	    "\4\2\2\u04d1\u04d2\5\u0086D\2\u04d2\u04d3\7\6\2\2\u04d3\u04d5\3\2\2",
	    "\2\u04d4\u04d0\3\2\2\2\u04d4\u04d5\3\2\2\2\u04d5\u04d6\3\2\2\2\u04d6",
	    "\u04d7\7\3\2\2\u04d7\u011b\3\2\2\2\u04d8\u04d9\5\u011e\u0090\2\u04d9",
	    "\u04dd\5\60\31\2\u04da\u04dc\5\u013e\u00a0\2\u04db\u04da\3\2\2\2\u04dc",
	    "\u04df\3\2\2\2\u04dd\u04db\3\2\2\2\u04dd\u04de\3\2\2\2\u04de\u04e0",
	    "\3\2\2\2\u04df\u04dd\3\2\2\2\u04e0\u04e1\5\u0178\u00bd\2\u04e1\u04e2",
	    "\7C\2\2\u04e2\u04e3\7\3\2\2\u04e3\u011d\3\2\2\2\u04e4\u04e5\7z\2\2",
	    "\u04e5\u04e6\5\u0120\u0091\2\u04e6\u04e7\7O\2\2\u04e7\u04e8\7\4\2\2",
	    "\u04e8\u04ed\5\6\4\2\u04e9\u04ea\7\5\2\2\u04ea\u04ec\5\6\4\2\u04eb",
	    "\u04e9\3\2\2\2\u04ec\u04ef\3\2\2\2\u04ed\u04eb\3\2\2\2\u04ed\u04ee",
	    "\3\2\2\2\u04ee\u04f0\3\2\2\2\u04ef\u04ed\3\2\2\2\u04f0\u04f1\7\6\2",
	    "\2\u04f1\u04f2\7\3\2\2\u04f2\u011f\3\2\2\2\u04f3\u04f4\7\u009f\2\2",
	    "\u04f4\u0121\3\2\2\2\u04f5\u04f6\7\u009f\2\2\u04f6\u0123\3\2\2\2\u04f7",
	    "\u04f9\5\u00ba^\2\u04f8\u04f7\3\2\2\2\u04f9\u04fc\3\2\2\2\u04fa\u04f8",
	    "\3\2\2\2\u04fa\u04fb\3\2\2\2\u04fb\u04fe\3\2\2\2\u04fc\u04fa\3\2\2",
	    "\2\u04fd\u04ff\5\\/\2\u04fe\u04fd\3\2\2\2\u04fe\u04ff\3\2\2\2\u04ff",
	    "\u0504\3\2\2\2\u0500\u0503\5d\63\2\u0501\u0503\5\u011c\u008f\2\u0502",
	    "\u0500\3\2\2\2\u0502\u0501\3\2\2\2\u0503\u0506\3\2\2\2\u0504\u0502",
	    "\3\2\2\2\u0504\u0505\3\2\2\2\u0505\u0125\3\2\2\2\u0506\u0504\3\2\2",
	    "\2\u0507\u0508\7{\2\2\u0508\u050a\5\u0128\u0095\2\u0509\u050b\5\u012a",
	    "\u0096\2\u050a\u0509\3\2\2\2\u050a\u050b\3\2\2\2\u050b\u050c\3\2\2",
	    "\2\u050c\u050d\7\3\2\2\u050d\u050e\5\u0124\u0093\2\u050e\u050f\7D\2",
	    "\2\u050f\u0510\7\3\2\2\u0510\u0127\3\2\2\2\u0511\u0512\7\u009f\2\2",
	    "\u0512\u0129\3\2\2\2\u0513\u0514\5\u0140\u00a1\2\u0514\u012b\3\2\2",
	    "\2\u0515\u0516\5\u0086D\2\u0516\u012d\3\2\2\2\u0517\u0518\7,\2\2\u0518",
	    "\u051b\5\32\16\2\u0519\u051a\7\u0097\2\2\u051a\u051c\5\u0130\u0099",
	    "\2\u051b\u0519\3\2\2\2\u051b\u051c\3\2\2\2\u051c\u012f\3\2\2\2\u051d",
	    "\u051e\7\4\2\2\u051e\u0523\5\u00dan\2\u051f\u0520\7\5\2\2\u0520\u0522",
	    "\5\u00dan\2\u0521\u051f\3\2\2\2\u0522\u0525\3\2\2\2\u0523\u0521\3\2",
	    "\2\2\u0523\u0524\3\2\2\2\u0524\u0526\3\2\2\2\u0525\u0523\3\2\2\2\u0526",
	    "\u0527\7\6\2\2\u0527\u0131\3\2\2\2\u0528\u052a\7L\2\2\u0529\u052b\7",
	    "T\2\2\u052a\u0529\3\2\2\2\u052a\u052b\3\2\2\2\u052b\u052d\3\2\2\2\u052c",
	    "\u0528\3\2\2\2\u052c\u052d\3\2\2\2\u052d\u052e\3\2\2\2\u052e\u0531",
	    "\7|\2\2\u052f\u0532\5\u0130\u0099\2\u0530\u0532\5\u012e\u0098\2\u0531",
	    "\u052f\3\2\2\2\u0531\u0530\3\2\2\2\u0531\u0532\3\2\2\2\u0532\u0133",
	    "\3\2\2\2\u0533\u0535\7~\2\2\u0534\u0536\5H%\2\u0535\u0534\3\2\2\2\u0535",
	    "\u0536\3\2\2\2\u0536\u0537\3\2\2\2\u0537\u0538\7k\2\2\u0538\u0539\5",
	    "\u00b6\\\2\u0539\u0135\3\2\2\2\u053a\u0540\5\u015e\u00b0\2\u053b\u053c",
	    "\5&\24\2\u053c\u053d\5\u015e\u00b0\2\u053d\u053f\3\2\2\2\u053e\u053b",
	    "\3\2\2\2\u053f\u0542\3\2\2\2\u0540\u053e\3\2\2\2\u0540\u0541\3\2\2",
	    "\2\u0541\u0137\3\2\2\2\u0542\u0540\3\2\2\2\u0543\u0553\5(\25\2\u0544",
	    "\u0553\5p9\2\u0545\u0553\5~@\2\u0546\u0553\5\u00bc_\2\u0547\u0553\5",
	    "\u0100\u0081\2\u0548\u054a\5\u016a\u00b6\2\u0549\u0548\3\2\2\2\u0549",
	    "\u054a\3\2\2\2\u054a\u0550\3\2\2\2\u054b\u054c\7\4\2\2\u054c\u054d",
	    "\5\u0086D\2\u054d\u054e\7\6\2\2\u054e\u0551\3\2\2\2\u054f\u0551\5\u00f0",
	    "y\2\u0550\u054b\3\2\2\2\u0550\u054f\3\2\2\2\u0551\u0553\3\2\2\2\u0552",
	    "\u0543\3\2\2\2\u0552\u0544\3\2\2\2\u0552\u0545\3\2\2\2\u0552\u0546",
	    "\3\2\2\2\u0552\u0547\3\2\2\2\u0552\u0549\3\2\2\2\u0553\u0139\3\2\2",
	    "\2\u0554\u055c\5@!\2\u0555\u055c\5B\"\2\u0556\u055c\5\u00b8]\2\u0557",
	    "\u055c\5\u00d6l\2\u0558\u055c\5\u00e0q\2\u0559\u055c\5\u0102\u0082",
	    "\2\u055a\u055c\5\u0142\u00a2\2\u055b\u0554\3\2\2\2\u055b\u0555\3\2",
	    "\2\2\u055b\u0556\3\2\2\2\u055b\u0557\3\2\2\2\u055b\u0558\3\2\2\2\u055b",
	    "\u0559\3\2\2\2\u055b\u055a\3\2\2\2\u055c\u013b\3\2\2\2\u055d\u055e",
	    "\7\u0081\2\2\u055e\u055f\7\3\2\2\u055f\u013d\3\2\2\2\u0560\u056c\5",
	    "\62\32\2\u0561\u056c\5\66\34\2\u0562\u056c\5T+\2\u0563\u056c\5V,\2",
	    "\u0564\u056c\5\u0082B\2\u0565\u056c\5\u00a8U\2\u0566\u056c\5\u00de",
	    "p\2\u0567\u056c\5\u00f2z\2\u0568\u056c\5\u0112\u008a\2\u0569\u056c",
	    "\5\u011a\u008e\2\u056a\u056c\5\u013c\u009f\2\u056b\u0560\3\2\2\2\u056b",
	    "\u0561\3\2\2\2\u056b\u0562\3\2\2\2\u056b\u0563\3\2\2\2\u056b\u0564",
	    "\3\2\2\2\u056b\u0565\3\2\2\2\u056b\u0566\3\2\2\2\u056b\u0567\3\2\2",
	    "\2\u056b\u0568\3\2\2\2\u056b\u0569\3\2\2\2\u056b\u056a\3\2\2\2\u056c",
	    "\u013f\3\2\2\2\u056d\u056e\t\13\2\2\u056e\u0141\3\2\2\2\u056f\u0571",
	    "\7\u0083\2\2\u0570\u0572\5\u017e\u00c0\2\u0571\u0570\3\2\2\2\u0571",
	    "\u0572\3\2\2\2\u0572\u0143\3\2\2\2\u0573\u0575\5\u0152\u00aa\2\u0574",
	    "\u0573\3\2\2\2\u0574\u0575\3\2\2\2\u0575\u0577\3\2\2\2\u0576\u0578",
	    "\5\u0150\u00a9\2\u0577\u0576\3\2\2\2\u0577\u0578\3\2\2\2\u0578\u0145",
	    "\3\2\2\2\u0579\u057a\7k\2\2\u057a\u057b\7\4\2\2\u057b\u057c\5\u0154",
	    "\u00ab\2\u057c\u057d\7\6\2\2\u057d\u0147\3\2\2\2\u057e\u0580\5 \21",
	    "\2\u057f\u057e\3\2\2\2\u057f\u0580\3\2\2\2\u0580\u0582\3\2\2\2\u0581",
	    "\u0583\5\u0160\u00b1\2\u0582\u0581\3\2\2\2\u0582\u0583\3\2\2\2\u0583",
	    "\u0587\3\2\2\2\u0584\u0585\5\u0154\u00ab\2\u0585\u0586\7\3\2\2\u0586",
	    "\u0588\3\2\2\2\u0587\u0584\3\2\2\2\u0587\u0588\3\2\2\2\u0588\u0149",
	    "\3\2\2\2\u0589\u058a\5\u014c\u00a7\2\u058a\u058b\5\u0148\u00a5\2\u058b",
	    "\u058c\7E\2\2\u058c\u058d\7\3\2\2\u058d\u014b\3\2\2\2\u058e\u058f\7",
	    "\u0085\2\2\u058f\u0590\5\u014e\u00a8\2\u0590\u0591\7O\2\2\u0591\u0592",
	    "\5\6\4\2\u0592\u0593\7\3\2\2\u0593\u014d\3\2\2\2\u0594\u0595\7\u009f",
	    "\2\2\u0595\u014f\3\2\2\2\u0596\u0597\7\u0084\2\2\u0597\u0598\7k\2\2",
	    "\u0598\u0599\7\4\2\2\u0599\u059e\5\6\4\2\u059a\u059b\7\5\2\2\u059b",
	    "\u059d\5\6\4\2\u059c\u059a\3\2\2\2\u059d\u05a0\3\2\2\2\u059e\u059c",
	    "\3\2\2\2\u059e\u059f\3\2\2\2\u059f\u05a1\3\2\2\2\u05a0\u059e\3\2\2",
	    "\2\u05a1\u05a2\7\6\2\2\u05a2\u0151\3\2\2\2\u05a3\u05a7\5\36\20\2\u05a4",
	    "\u05a7\5\"\22\2\u05a5\u05a7\5\u0158\u00ad\2\u05a6\u05a3\3\2\2\2\u05a6",
	    "\u05a4\3\2\2\2\u05a6\u05a5\3\2\2\2\u05a7\u0153\3\2\2\2\u05a8\u05ad",
	    "\5\u0156\u00ac\2\u05a9\u05aa\7&\2\2\u05aa\u05ac\5\u0156\u00ac\2\u05ab",
	    "\u05a9\3\2\2\2\u05ac\u05af\3\2\2\2\u05ad\u05ab\3\2\2\2\u05ad\u05ae",
	    "\3\2\2\2\u05ae\u0155\3\2\2\2\u05af\u05ad\3\2\2\2\u05b0\u05b5\5\u015a",
	    "\u00ae\2\u05b1\u05b2\7%\2\2\u05b2\u05b4\5\u015a\u00ae\2\u05b3\u05b1",
	    "\3\2\2\2\u05b4\u05b7\3\2\2\2\u05b5\u05b3\3\2\2\2\u05b5\u05b6\3\2\2",
	    "\2\u05b6\u0157\3\2\2\2\u05b7\u05b5\3\2\2\2\u05b8\u05b9\7\u0086\2\2",
	    "\u05b9\u05ba\5\u0146\u00a4\2\u05ba\u0159\3\2\2\2\u05bb\u05c2\5\6\4",
	    "\2\u05bc\u05c2\5\u00e4s\2\u05bd\u05be\7\4\2\2\u05be\u05bf\5\u0154\u00ab",
	    "\2\u05bf\u05c0\7\6\2\2\u05c0\u05c2\3\2\2\2\u05c1\u05bb\3\2\2\2\u05c1",
	    "\u05bc\3\2\2\2\u05c1\u05bd\3\2\2\2\u05c2\u015b\3\2\2\2\u05c3\u05c5",
	    "\5\u0126\u0094\2\u05c4\u05c3\3\2\2\2\u05c5\u05c6\3\2\2\2\u05c6\u05c4",
	    "\3\2\2\2\u05c6\u05c7\3\2\2\2\u05c7\u015d\3\2\2\2\u05c8\u05ce\5\u0088",
	    "E\2\u05c9\u05ca\5\u00d8m\2\u05ca\u05cb\5\u0088E\2\u05cb\u05cd\3\2\2",
	    "\2\u05cc\u05c9\3\2\2\2\u05cd\u05d0\3\2\2\2\u05ce\u05cc\3\2\2\2\u05ce",
	    "\u05cf\3\2\2\2\u05cf\u015f\3\2\2\2\u05d0\u05ce\3\2\2\2\u05d1\u05d2",
	    "\7\u008d\2\2\u05d2\u05d3\7\4\2\2\u05d3\u05d8\5\6\4\2\u05d4\u05d5\7",
	    "\5\2\2\u05d5\u05d7\5\6\4\2\u05d6\u05d4\3\2\2\2\u05d7\u05da\3\2\2\2",
	    "\u05d8\u05d6\3\2\2\2\u05d8\u05d9\3\2\2\2\u05d9\u05db\3\2\2\2\u05da",
	    "\u05d8\3\2\2\2\u05db\u05dc\7\6\2\2\u05dc\u05dd\7\3\2\2\u05dd\u0161",
	    "\3\2\2\2\u05de\u05df\7\u008b\2\2\u05df\u05e0\5\u0164\u00b3\2\u05e0",
	    "\u05e1\7\35\2\2\u05e1\u05e2\5\u016c\u00b7\2\u05e2\u05e4\7\3\2\2\u05e3",
	    "\u05e5\5\u0178\u00bd\2\u05e4\u05e3\3\2\2\2\u05e4\u05e5\3\2\2\2\u05e5",
	    "\u05e6\3\2\2\2\u05e6\u05e7\7F\2\2\u05e7\u05e8\7\3\2\2\u05e8\u0163\3",
	    "\2\2\2\u05e9\u05ea\7\u009f\2\2\u05ea\u0165\3\2\2\2\u05eb\u05ee\5\u0168",
	    "\u00b5\2\u05ec\u05ee\5\30\r\2\u05ed\u05eb\3\2\2\2\u05ed\u05ec\3\2\2",
	    "\2\u05ee\u0167\3\2\2\2\u05ef\u05f0\7\u009f\2\2\u05f0\u0169\3\2\2\2",
	    "\u05f1\u05f2\t\f\2\2\u05f2\u016b\3\2\2\2\u05f3\u05f6\5X-\2\u05f4\u05f6",
	    "\5b\62\2\u05f5\u05f3\3\2\2\2\u05f5\u05f4\3\2\2\2\u05f6\u016d\3\2\2",
	    "\2\u05f7\u05f8\7\u008e\2\2\u05f8\u05f9\5\u0170\u00b9\2\u05f9\u05ff",
	    "\7\3\2\2\u05fa\u05fb\5\u0170\u00b9\2\u05fb\u05fc\7\3\2\2\u05fc\u05fe",
	    "\3\2\2\2\u05fd\u05fa\3\2\2\2\u05fe\u0601\3\2\2\2\u05ff\u05fd\3\2\2",
	    "\2\u05ff\u0600\3\2\2\2\u0600\u016f\3\2\2\2\u0601\u05ff\3\2\2\2\u0602",
	    "\u0603\5\u0122\u0092\2\u0603\u0604\7\13\2\2\u0604\u0606\3\2\2\2\u0605",
	    "\u0602\3\2\2\2\u0605\u0606\3\2\2\2\u0606\u0607\3\2\2\2\u0607\u060c",
	    "\5\u0106\u0084\2\u0608\u0609\7\5\2\2\u0609\u060b\5\u0106\u0084\2\u060a",
	    "\u0608\3\2\2\2\u060b\u060e\3\2\2\2\u060c\u060a\3\2\2\2\u060c\u060d",
	    "\3\2\2\2\u060d\u0171\3\2\2\2\u060e\u060c\3\2\2\2\u060f\u0610\7\u0090",
	    "\2\2\u0610\u0611\5\u00d2j\2\u0611\u0173\3\2\2\2\u0612\u0613\7\u0091",
	    "\2\2\u0613\u0614\7Q\2\2\u0614\u0620\5\24\13\2\u0615\u0616\7\4\2\2\u0616",
	    "\u061b\5\u00dco\2\u0617\u0618\7\5\2\2\u0618\u061a\5\u00dco\2\u0619",
	    "\u0617\3\2\2\2\u061a\u061d\3\2\2\2\u061b\u0619\3\2\2\2\u061b\u061c",
	    "\3\2\2\2\u061c\u061e\3\2\2\2\u061d\u061b\3\2\2\2\u061e\u061f\7\6\2",
	    "\2\u061f\u0621\3\2\2\2\u0620\u0615\3\2\2\2\u0620\u0621\3\2\2\2\u0621",
	    "\u0622\3\2\2\2\u0622\u0623\7\3\2\2\u0623\u0175\3\2\2\2\u0624\u0625",
	    "\7\u009f\2\2\u0625\u0177\3\2\2\2\u0626\u0627\7\u0098\2\2\u0627\u0628",
	    "\5j\66\2\u0628\u062e\7\3\2\2\u0629\u062a\5j\66\2\u062a\u062b\7\3\2",
	    "\2\u062b\u062d\3\2\2\2\u062c\u0629\3\2\2\2\u062d\u0630\3\2\2\2\u062e",
	    "\u062c\3\2\2\2\u062e\u062f\3\2\2\2\u062f\u0179\3\2\2\2\u0630\u062e",
	    "\3\2\2\2\u0631\u0632\7\u0099\2\2\u0632\u0633\5\u00d2j\2\u0633\u017b",
	    "\3\2\2\2\u0634\u0635\5\u00e2r\2\u0635\u017d\3\2\2\2\u0636\u0637\7\4",
	    "\2\2\u0637\u0638\5\u017c\u00bf\2\u0638\u063a\7\6\2\2\u0639\u063b\7",
	    "N\2\2\u063a\u0639\3\2\2\2\u063a\u063b\3\2\2\2\u063b\u017f\3\2\2\2\u009b",
	    "\u01a5\u01ad\u01ba\u01bd\u01c6\u01cf\u01d4\u01d8\u01db\u01e4\u01eb",
	    "\u01f4\u01f7\u01ff\u0208\u0211\u0218\u0231\u023f\u0245\u024e\u0256",
	    "\u0263\u026a\u0270\u0277\u0284\u0289\u0290\u0295\u0299\u029c\u029f",
	    "\u02a2\u02ab\u02ae\u02c2\u02cc\u02d4\u02d9\u02df\u02e9\u02ee\u02f7",
	    "\u02fc\u0303\u030b\u030e\u0315\u0322\u0327\u0333\u0339\u033d\u0341",
	    "\u0344\u034a\u0351\u0355\u035b\u035f\u0367\u036c\u0377\u037d\u037f",
	    "\u038d\u0399\u039f\u03a5\u03bb\u03be\u03c5\u03ce\u03d2\u03d6\u03df",
	    "\u03e5\u03ef\u03f6\u0404\u040a\u040c\u041b\u0427\u0432\u0435\u0439",
	    "\u043c\u0445\u044f\u0454\u0459\u045e\u0469\u0472\u0482\u0487\u048b",
	    "\u0496\u049b\u04a4\u04ab\u04ae\u04b1\u04b4\u04bc\u04c6\u04cd\u04d4",
	    "\u04dd\u04ed\u04fa\u04fe\u0502\u0504\u050a\u051b\u0523\u052a\u052c",
	    "\u0531\u0535\u0540\u0549\u0550\u0552\u055b\u056b\u0571\u0574\u0577",
	    "\u057f\u0582\u0587\u059e\u05a6\u05ad\u05b5\u05c1\u05c6\u05ce\u05d8",
	    "\u05e4\u05ed\u05f5\u05ff\u0605\u060c\u061b\u0620\u062e\u063a"].join("")

	@@_ATN = Antlr4::Runtime::ATNDeserializer.new().deserialize(@@_serializedATN)

end

end
end
end
