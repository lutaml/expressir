
// Generated from Express.g4 by ANTLR 4.8


#include "ExpressListener.h"
#include "ExpressVisitor.h"

#include "ExpressParser.h"


using namespace antlrcpp;
using namespace antlr4;

ExpressParser::ExpressParser(TokenStream *input) : Parser(input) {
  _interpreter = new atn::ParserATNSimulator(this, _atn, _decisionToDFA, _sharedContextCache);
}

ExpressParser::~ExpressParser() {
  delete _interpreter;
}

std::string ExpressParser::getGrammarFileName() const {
  return "Express.g4";
}

const std::vector<std::string>& ExpressParser::getRuleNames() const {
  return _ruleNames;
}

dfa::Vocabulary& ExpressParser::getVocabulary() const {
  return _vocabulary;
}


//----------------- AttributeRefContext ------------------------------------------------------------------

ExpressParser::AttributeRefContext::AttributeRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeIdContext* ExpressParser::AttributeRefContext::attributeId() {
  return getRuleContext<ExpressParser::AttributeIdContext>(0);
}


size_t ExpressParser::AttributeRefContext::getRuleIndex() const {
  return ExpressParser::RuleAttributeRef;
}

void ExpressParser::AttributeRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAttributeRef(this);
}

void ExpressParser::AttributeRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAttributeRef(this);
}


antlrcpp::Any ExpressParser::AttributeRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAttributeRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AttributeRefContext* ExpressParser::attributeRef() {
  AttributeRefContext *_localctx = _tracker.createInstance<AttributeRefContext>(_ctx, getState());
  enterRule(_localctx, 0, ExpressParser::RuleAttributeRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(398);
    attributeId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstantRefContext ------------------------------------------------------------------

ExpressParser::ConstantRefContext::ConstantRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConstantIdContext* ExpressParser::ConstantRefContext::constantId() {
  return getRuleContext<ExpressParser::ConstantIdContext>(0);
}


size_t ExpressParser::ConstantRefContext::getRuleIndex() const {
  return ExpressParser::RuleConstantRef;
}

void ExpressParser::ConstantRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstantRef(this);
}

void ExpressParser::ConstantRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstantRef(this);
}


antlrcpp::Any ExpressParser::ConstantRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstantRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstantRefContext* ExpressParser::constantRef() {
  ConstantRefContext *_localctx = _tracker.createInstance<ConstantRefContext>(_ctx, getState());
  enterRule(_localctx, 2, ExpressParser::RuleConstantRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(400);
    constantId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityRefContext ------------------------------------------------------------------

ExpressParser::EntityRefContext::EntityRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityIdContext* ExpressParser::EntityRefContext::entityId() {
  return getRuleContext<ExpressParser::EntityIdContext>(0);
}


size_t ExpressParser::EntityRefContext::getRuleIndex() const {
  return ExpressParser::RuleEntityRef;
}

void ExpressParser::EntityRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityRef(this);
}

void ExpressParser::EntityRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityRef(this);
}


antlrcpp::Any ExpressParser::EntityRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityRefContext* ExpressParser::entityRef() {
  EntityRefContext *_localctx = _tracker.createInstance<EntityRefContext>(_ctx, getState());
  enterRule(_localctx, 4, ExpressParser::RuleEntityRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(402);
    entityId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationRefContext ------------------------------------------------------------------

ExpressParser::EnumerationRefContext::EnumerationRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EnumerationIdContext* ExpressParser::EnumerationRefContext::enumerationId() {
  return getRuleContext<ExpressParser::EnumerationIdContext>(0);
}


size_t ExpressParser::EnumerationRefContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationRef;
}

void ExpressParser::EnumerationRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationRef(this);
}

void ExpressParser::EnumerationRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationRef(this);
}


antlrcpp::Any ExpressParser::EnumerationRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationRefContext* ExpressParser::enumerationRef() {
  EnumerationRefContext *_localctx = _tracker.createInstance<EnumerationRefContext>(_ctx, getState());
  enterRule(_localctx, 6, ExpressParser::RuleEnumerationRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(404);
    enumerationId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionRefContext ------------------------------------------------------------------

ExpressParser::FunctionRefContext::FunctionRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::FunctionIdContext* ExpressParser::FunctionRefContext::functionId() {
  return getRuleContext<ExpressParser::FunctionIdContext>(0);
}


size_t ExpressParser::FunctionRefContext::getRuleIndex() const {
  return ExpressParser::RuleFunctionRef;
}

void ExpressParser::FunctionRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionRef(this);
}

void ExpressParser::FunctionRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionRef(this);
}


antlrcpp::Any ExpressParser::FunctionRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFunctionRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FunctionRefContext* ExpressParser::functionRef() {
  FunctionRefContext *_localctx = _tracker.createInstance<FunctionRefContext>(_ctx, getState());
  enterRule(_localctx, 8, ExpressParser::RuleFunctionRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(406);
    functionId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ParameterRefContext ------------------------------------------------------------------

ExpressParser::ParameterRefContext::ParameterRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ParameterIdContext* ExpressParser::ParameterRefContext::parameterId() {
  return getRuleContext<ExpressParser::ParameterIdContext>(0);
}


size_t ExpressParser::ParameterRefContext::getRuleIndex() const {
  return ExpressParser::RuleParameterRef;
}

void ExpressParser::ParameterRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterParameterRef(this);
}

void ExpressParser::ParameterRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitParameterRef(this);
}


antlrcpp::Any ExpressParser::ParameterRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitParameterRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ParameterRefContext* ExpressParser::parameterRef() {
  ParameterRefContext *_localctx = _tracker.createInstance<ParameterRefContext>(_ctx, getState());
  enterRule(_localctx, 10, ExpressParser::RuleParameterRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(408);
    parameterId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureRefContext ------------------------------------------------------------------

ExpressParser::ProcedureRefContext::ProcedureRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ProcedureIdContext* ExpressParser::ProcedureRefContext::procedureId() {
  return getRuleContext<ExpressParser::ProcedureIdContext>(0);
}


size_t ExpressParser::ProcedureRefContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureRef;
}

void ExpressParser::ProcedureRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureRef(this);
}

void ExpressParser::ProcedureRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureRef(this);
}


antlrcpp::Any ExpressParser::ProcedureRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureRefContext* ExpressParser::procedureRef() {
  ProcedureRefContext *_localctx = _tracker.createInstance<ProcedureRefContext>(_ctx, getState());
  enterRule(_localctx, 12, ExpressParser::RuleProcedureRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(410);
    procedureId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleLabelRefContext ------------------------------------------------------------------

ExpressParser::RuleLabelRefContext::RuleLabelRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::RuleLabelIdContext* ExpressParser::RuleLabelRefContext::ruleLabelId() {
  return getRuleContext<ExpressParser::RuleLabelIdContext>(0);
}


size_t ExpressParser::RuleLabelRefContext::getRuleIndex() const {
  return ExpressParser::RuleRuleLabelRef;
}

void ExpressParser::RuleLabelRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleLabelRef(this);
}

void ExpressParser::RuleLabelRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleLabelRef(this);
}


antlrcpp::Any ExpressParser::RuleLabelRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleLabelRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleLabelRefContext* ExpressParser::ruleLabelRef() {
  RuleLabelRefContext *_localctx = _tracker.createInstance<RuleLabelRefContext>(_ctx, getState());
  enterRule(_localctx, 14, ExpressParser::RuleRuleLabelRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(412);
    ruleLabelId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleRefContext ------------------------------------------------------------------

ExpressParser::RuleRefContext::RuleRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::RuleIdContext* ExpressParser::RuleRefContext::ruleId() {
  return getRuleContext<ExpressParser::RuleIdContext>(0);
}


size_t ExpressParser::RuleRefContext::getRuleIndex() const {
  return ExpressParser::RuleRuleRef;
}

void ExpressParser::RuleRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleRef(this);
}

void ExpressParser::RuleRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleRef(this);
}


antlrcpp::Any ExpressParser::RuleRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleRefContext* ExpressParser::ruleRef() {
  RuleRefContext *_localctx = _tracker.createInstance<RuleRefContext>(_ctx, getState());
  enterRule(_localctx, 16, ExpressParser::RuleRuleRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(414);
    ruleId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaRefContext ------------------------------------------------------------------

ExpressParser::SchemaRefContext::SchemaRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SchemaIdContext* ExpressParser::SchemaRefContext::schemaId() {
  return getRuleContext<ExpressParser::SchemaIdContext>(0);
}


size_t ExpressParser::SchemaRefContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaRef;
}

void ExpressParser::SchemaRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaRef(this);
}

void ExpressParser::SchemaRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaRef(this);
}


antlrcpp::Any ExpressParser::SchemaRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaRefContext* ExpressParser::schemaRef() {
  SchemaRefContext *_localctx = _tracker.createInstance<SchemaRefContext>(_ctx, getState());
  enterRule(_localctx, 18, ExpressParser::RuleSchemaRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(416);
    schemaId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintRefContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintRefContext::SubtypeConstraintRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SubtypeConstraintIdContext* ExpressParser::SubtypeConstraintRefContext::subtypeConstraintId() {
  return getRuleContext<ExpressParser::SubtypeConstraintIdContext>(0);
}


size_t ExpressParser::SubtypeConstraintRefContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraintRef;
}

void ExpressParser::SubtypeConstraintRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraintRef(this);
}

void ExpressParser::SubtypeConstraintRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraintRef(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraintRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintRefContext* ExpressParser::subtypeConstraintRef() {
  SubtypeConstraintRefContext *_localctx = _tracker.createInstance<SubtypeConstraintRefContext>(_ctx, getState());
  enterRule(_localctx, 20, ExpressParser::RuleSubtypeConstraintRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(418);
    subtypeConstraintId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeLabelRefContext ------------------------------------------------------------------

ExpressParser::TypeLabelRefContext::TypeLabelRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::TypeLabelIdContext* ExpressParser::TypeLabelRefContext::typeLabelId() {
  return getRuleContext<ExpressParser::TypeLabelIdContext>(0);
}


size_t ExpressParser::TypeLabelRefContext::getRuleIndex() const {
  return ExpressParser::RuleTypeLabelRef;
}

void ExpressParser::TypeLabelRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeLabelRef(this);
}

void ExpressParser::TypeLabelRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeLabelRef(this);
}


antlrcpp::Any ExpressParser::TypeLabelRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeLabelRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeLabelRefContext* ExpressParser::typeLabelRef() {
  TypeLabelRefContext *_localctx = _tracker.createInstance<TypeLabelRefContext>(_ctx, getState());
  enterRule(_localctx, 22, ExpressParser::RuleTypeLabelRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(420);
    typeLabelId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeRefContext ------------------------------------------------------------------

ExpressParser::TypeRefContext::TypeRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::TypeIdContext* ExpressParser::TypeRefContext::typeId() {
  return getRuleContext<ExpressParser::TypeIdContext>(0);
}


size_t ExpressParser::TypeRefContext::getRuleIndex() const {
  return ExpressParser::RuleTypeRef;
}

void ExpressParser::TypeRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeRef(this);
}

void ExpressParser::TypeRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeRef(this);
}


antlrcpp::Any ExpressParser::TypeRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeRefContext* ExpressParser::typeRef() {
  TypeRefContext *_localctx = _tracker.createInstance<TypeRefContext>(_ctx, getState());
  enterRule(_localctx, 24, ExpressParser::RuleTypeRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(422);
    typeId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- VariableRefContext ------------------------------------------------------------------

ExpressParser::VariableRefContext::VariableRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::VariableIdContext* ExpressParser::VariableRefContext::variableId() {
  return getRuleContext<ExpressParser::VariableIdContext>(0);
}


size_t ExpressParser::VariableRefContext::getRuleIndex() const {
  return ExpressParser::RuleVariableRef;
}

void ExpressParser::VariableRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterVariableRef(this);
}

void ExpressParser::VariableRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitVariableRef(this);
}


antlrcpp::Any ExpressParser::VariableRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitVariableRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::VariableRefContext* ExpressParser::variableRef() {
  VariableRefContext *_localctx = _tracker.createInstance<VariableRefContext>(_ctx, getState());
  enterRule(_localctx, 26, ExpressParser::RuleVariableRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(424);
    variableId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AbstractEntityDeclarationContext ------------------------------------------------------------------

ExpressParser::AbstractEntityDeclarationContext::AbstractEntityDeclarationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AbstractEntityDeclarationContext::ABSTRACT() {
  return getToken(ExpressParser::ABSTRACT, 0);
}


size_t ExpressParser::AbstractEntityDeclarationContext::getRuleIndex() const {
  return ExpressParser::RuleAbstractEntityDeclaration;
}

void ExpressParser::AbstractEntityDeclarationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAbstractEntityDeclaration(this);
}

void ExpressParser::AbstractEntityDeclarationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAbstractEntityDeclaration(this);
}


antlrcpp::Any ExpressParser::AbstractEntityDeclarationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAbstractEntityDeclaration(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AbstractEntityDeclarationContext* ExpressParser::abstractEntityDeclaration() {
  AbstractEntityDeclarationContext *_localctx = _tracker.createInstance<AbstractEntityDeclarationContext>(_ctx, getState());
  enterRule(_localctx, 28, ExpressParser::RuleAbstractEntityDeclaration);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(426);
    match(ExpressParser::ABSTRACT);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AbstractSupertypeContext ------------------------------------------------------------------

ExpressParser::AbstractSupertypeContext::AbstractSupertypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AbstractSupertypeContext::ABSTRACT() {
  return getToken(ExpressParser::ABSTRACT, 0);
}

tree::TerminalNode* ExpressParser::AbstractSupertypeContext::SUPERTYPE() {
  return getToken(ExpressParser::SUPERTYPE, 0);
}


size_t ExpressParser::AbstractSupertypeContext::getRuleIndex() const {
  return ExpressParser::RuleAbstractSupertype;
}

void ExpressParser::AbstractSupertypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAbstractSupertype(this);
}

void ExpressParser::AbstractSupertypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAbstractSupertype(this);
}


antlrcpp::Any ExpressParser::AbstractSupertypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAbstractSupertype(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AbstractSupertypeContext* ExpressParser::abstractSupertype() {
  AbstractSupertypeContext *_localctx = _tracker.createInstance<AbstractSupertypeContext>(_ctx, getState());
  enterRule(_localctx, 30, ExpressParser::RuleAbstractSupertype);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(428);
    match(ExpressParser::ABSTRACT);
    setState(429);
    match(ExpressParser::SUPERTYPE);
    setState(430);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AbstractSupertypeDeclarationContext ------------------------------------------------------------------

ExpressParser::AbstractSupertypeDeclarationContext::AbstractSupertypeDeclarationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AbstractSupertypeDeclarationContext::ABSTRACT() {
  return getToken(ExpressParser::ABSTRACT, 0);
}

tree::TerminalNode* ExpressParser::AbstractSupertypeDeclarationContext::SUPERTYPE() {
  return getToken(ExpressParser::SUPERTYPE, 0);
}

ExpressParser::SubtypeConstraintContext* ExpressParser::AbstractSupertypeDeclarationContext::subtypeConstraint() {
  return getRuleContext<ExpressParser::SubtypeConstraintContext>(0);
}


size_t ExpressParser::AbstractSupertypeDeclarationContext::getRuleIndex() const {
  return ExpressParser::RuleAbstractSupertypeDeclaration;
}

void ExpressParser::AbstractSupertypeDeclarationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAbstractSupertypeDeclaration(this);
}

void ExpressParser::AbstractSupertypeDeclarationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAbstractSupertypeDeclaration(this);
}


antlrcpp::Any ExpressParser::AbstractSupertypeDeclarationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAbstractSupertypeDeclaration(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AbstractSupertypeDeclarationContext* ExpressParser::abstractSupertypeDeclaration() {
  AbstractSupertypeDeclarationContext *_localctx = _tracker.createInstance<AbstractSupertypeDeclarationContext>(_ctx, getState());
  enterRule(_localctx, 32, ExpressParser::RuleAbstractSupertypeDeclaration);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(432);
    match(ExpressParser::ABSTRACT);
    setState(433);
    match(ExpressParser::SUPERTYPE);
    setState(435);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::OF) {
      setState(434);
      subtypeConstraint();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ActualParameterListContext ------------------------------------------------------------------

ExpressParser::ActualParameterListContext::ActualParameterListContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::ParameterContext *> ExpressParser::ActualParameterListContext::parameter() {
  return getRuleContexts<ExpressParser::ParameterContext>();
}

ExpressParser::ParameterContext* ExpressParser::ActualParameterListContext::parameter(size_t i) {
  return getRuleContext<ExpressParser::ParameterContext>(i);
}


size_t ExpressParser::ActualParameterListContext::getRuleIndex() const {
  return ExpressParser::RuleActualParameterList;
}

void ExpressParser::ActualParameterListContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterActualParameterList(this);
}

void ExpressParser::ActualParameterListContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitActualParameterList(this);
}


antlrcpp::Any ExpressParser::ActualParameterListContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitActualParameterList(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ActualParameterListContext* ExpressParser::actualParameterList() {
  ActualParameterListContext *_localctx = _tracker.createInstance<ActualParameterListContext>(_ctx, getState());
  enterRule(_localctx, 34, ExpressParser::RuleActualParameterList);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(437);
    match(ExpressParser::T__1);
    setState(438);
    parameter();
    setState(443);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(439);
      match(ExpressParser::T__2);
      setState(440);
      parameter();
      setState(445);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(446);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AddLikeOpContext ------------------------------------------------------------------

ExpressParser::AddLikeOpContext::AddLikeOpContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AddLikeOpContext::OR() {
  return getToken(ExpressParser::OR, 0);
}

tree::TerminalNode* ExpressParser::AddLikeOpContext::XOR() {
  return getToken(ExpressParser::XOR, 0);
}


size_t ExpressParser::AddLikeOpContext::getRuleIndex() const {
  return ExpressParser::RuleAddLikeOp;
}

void ExpressParser::AddLikeOpContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAddLikeOp(this);
}

void ExpressParser::AddLikeOpContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAddLikeOp(this);
}


antlrcpp::Any ExpressParser::AddLikeOpContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAddLikeOp(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AddLikeOpContext* ExpressParser::addLikeOp() {
  AddLikeOpContext *_localctx = _tracker.createInstance<AddLikeOpContext>(_ctx, getState());
  enterRule(_localctx, 36, ExpressParser::RuleAddLikeOp);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(448);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::T__4

    || _la == ExpressParser::T__5 || _la == ExpressParser::OR

    || _la == ExpressParser::XOR)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AggregateInitializerContext ------------------------------------------------------------------

ExpressParser::AggregateInitializerContext::AggregateInitializerContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::ElementContext *> ExpressParser::AggregateInitializerContext::element() {
  return getRuleContexts<ExpressParser::ElementContext>();
}

ExpressParser::ElementContext* ExpressParser::AggregateInitializerContext::element(size_t i) {
  return getRuleContext<ExpressParser::ElementContext>(i);
}


size_t ExpressParser::AggregateInitializerContext::getRuleIndex() const {
  return ExpressParser::RuleAggregateInitializer;
}

void ExpressParser::AggregateInitializerContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAggregateInitializer(this);
}

void ExpressParser::AggregateInitializerContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAggregateInitializer(this);
}


antlrcpp::Any ExpressParser::AggregateInitializerContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAggregateInitializer(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AggregateInitializerContext* ExpressParser::aggregateInitializer() {
  AggregateInitializerContext *_localctx = _tracker.createInstance<AggregateInitializerContext>(_ctx, getState());
  enterRule(_localctx, 38, ExpressParser::RuleAggregateInitializer);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(450);
    match(ExpressParser::T__6);
    setState(459);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__1)
      | (1ULL << ExpressParser::T__4)
      | (1ULL << ExpressParser::T__5)
      | (1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__11)
      | (1ULL << ExpressParser::T__14)
      | (1ULL << ExpressParser::ABS)
      | (1ULL << ExpressParser::ACOS)
      | (1ULL << ExpressParser::ASIN)
      | (1ULL << ExpressParser::ATAN)
      | (1ULL << ExpressParser::BLENGTH)
      | (1ULL << ExpressParser::CONST_E)
      | (1ULL << ExpressParser::COS))) != 0) || ((((_la - 72) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 72)) & ((1ULL << (ExpressParser::EXISTS - 72))
      | (1ULL << (ExpressParser::EXP - 72))
      | (1ULL << (ExpressParser::FALSE - 72))
      | (1ULL << (ExpressParser::FORMAT - 72))
      | (1ULL << (ExpressParser::HIBOUND - 72))
      | (1ULL << (ExpressParser::HIINDEX - 72))
      | (1ULL << (ExpressParser::LENGTH - 72))
      | (1ULL << (ExpressParser::LOBOUND - 72))
      | (1ULL << (ExpressParser::LOG - 72))
      | (1ULL << (ExpressParser::LOG10 - 72))
      | (1ULL << (ExpressParser::LOG2 - 72))
      | (1ULL << (ExpressParser::LOINDEX - 72))
      | (1ULL << (ExpressParser::NOT - 72))
      | (1ULL << (ExpressParser::NVL - 72))
      | (1ULL << (ExpressParser::ODD - 72))
      | (1ULL << (ExpressParser::PI - 72))
      | (1ULL << (ExpressParser::QUERY - 72))
      | (1ULL << (ExpressParser::ROLESOF - 72))
      | (1ULL << (ExpressParser::SELF - 72))
      | (1ULL << (ExpressParser::SIN - 72))
      | (1ULL << (ExpressParser::SIZEOF - 72))
      | (1ULL << (ExpressParser::SQRT - 72))
      | (1ULL << (ExpressParser::TAN - 72)))) != 0) || ((((_la - 136) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 136)) & ((1ULL << (ExpressParser::TRUE - 136))
      | (1ULL << (ExpressParser::TYPEOF - 136))
      | (1ULL << (ExpressParser::UNKNOWN - 136))
      | (1ULL << (ExpressParser::USEDIN - 136))
      | (1ULL << (ExpressParser::VALUE_ - 136))
      | (1ULL << (ExpressParser::VALUE_IN - 136))
      | (1ULL << (ExpressParser::VALUE_UNIQUE - 136))
      | (1ULL << (ExpressParser::BinaryLiteral - 136))
      | (1ULL << (ExpressParser::EncodedStringLiteral - 136))
      | (1ULL << (ExpressParser::IntegerLiteral - 136))
      | (1ULL << (ExpressParser::RealLiteral - 136))
      | (1ULL << (ExpressParser::SimpleId - 136))
      | (1ULL << (ExpressParser::SimpleStringLiteral - 136)))) != 0)) {
      setState(451);
      element();
      setState(456);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__2) {
        setState(452);
        match(ExpressParser::T__2);
        setState(453);
        element();
        setState(458);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
    }
    setState(461);
    match(ExpressParser::T__7);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AggregateSourceContext ------------------------------------------------------------------

ExpressParser::AggregateSourceContext::AggregateSourceContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SimpleExpressionContext* ExpressParser::AggregateSourceContext::simpleExpression() {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(0);
}


size_t ExpressParser::AggregateSourceContext::getRuleIndex() const {
  return ExpressParser::RuleAggregateSource;
}

void ExpressParser::AggregateSourceContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAggregateSource(this);
}

void ExpressParser::AggregateSourceContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAggregateSource(this);
}


antlrcpp::Any ExpressParser::AggregateSourceContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAggregateSource(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AggregateSourceContext* ExpressParser::aggregateSource() {
  AggregateSourceContext *_localctx = _tracker.createInstance<AggregateSourceContext>(_ctx, getState());
  enterRule(_localctx, 40, ExpressParser::RuleAggregateSource);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(463);
    simpleExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AggregateTypeContext ------------------------------------------------------------------

ExpressParser::AggregateTypeContext::AggregateTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AggregateTypeContext::AGGREGATE() {
  return getToken(ExpressParser::AGGREGATE, 0);
}

tree::TerminalNode* ExpressParser::AggregateTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::ParameterTypeContext* ExpressParser::AggregateTypeContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::TypeLabelContext* ExpressParser::AggregateTypeContext::typeLabel() {
  return getRuleContext<ExpressParser::TypeLabelContext>(0);
}


size_t ExpressParser::AggregateTypeContext::getRuleIndex() const {
  return ExpressParser::RuleAggregateType;
}

void ExpressParser::AggregateTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAggregateType(this);
}

void ExpressParser::AggregateTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAggregateType(this);
}


antlrcpp::Any ExpressParser::AggregateTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAggregateType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AggregateTypeContext* ExpressParser::aggregateType() {
  AggregateTypeContext *_localctx = _tracker.createInstance<AggregateTypeContext>(_ctx, getState());
  enterRule(_localctx, 42, ExpressParser::RuleAggregateType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(465);
    match(ExpressParser::AGGREGATE);
    setState(468);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__8) {
      setState(466);
      match(ExpressParser::T__8);
      setState(467);
      typeLabel();
    }
    setState(470);
    match(ExpressParser::OF);
    setState(471);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AggregationTypesContext ------------------------------------------------------------------

ExpressParser::AggregationTypesContext::AggregationTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ArrayTypeContext* ExpressParser::AggregationTypesContext::arrayType() {
  return getRuleContext<ExpressParser::ArrayTypeContext>(0);
}

ExpressParser::BagTypeContext* ExpressParser::AggregationTypesContext::bagType() {
  return getRuleContext<ExpressParser::BagTypeContext>(0);
}

ExpressParser::ListTypeContext* ExpressParser::AggregationTypesContext::listType() {
  return getRuleContext<ExpressParser::ListTypeContext>(0);
}

ExpressParser::SetTypeContext* ExpressParser::AggregationTypesContext::setType() {
  return getRuleContext<ExpressParser::SetTypeContext>(0);
}


size_t ExpressParser::AggregationTypesContext::getRuleIndex() const {
  return ExpressParser::RuleAggregationTypes;
}

void ExpressParser::AggregationTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAggregationTypes(this);
}

void ExpressParser::AggregationTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAggregationTypes(this);
}


antlrcpp::Any ExpressParser::AggregationTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAggregationTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AggregationTypesContext* ExpressParser::aggregationTypes() {
  AggregationTypesContext *_localctx = _tracker.createInstance<AggregationTypesContext>(_ctx, getState());
  enterRule(_localctx, 44, ExpressParser::RuleAggregationTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(477);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ARRAY: {
        enterOuterAlt(_localctx, 1);
        setState(473);
        arrayType();
        break;
      }

      case ExpressParser::BAG: {
        enterOuterAlt(_localctx, 2);
        setState(474);
        bagType();
        break;
      }

      case ExpressParser::LIST: {
        enterOuterAlt(_localctx, 3);
        setState(475);
        listType();
        break;
      }

      case ExpressParser::SET: {
        enterOuterAlt(_localctx, 4);
        setState(476);
        setType();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AlgorithmHeadContext ------------------------------------------------------------------

ExpressParser::AlgorithmHeadContext::AlgorithmHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::DeclarationContext *> ExpressParser::AlgorithmHeadContext::declaration() {
  return getRuleContexts<ExpressParser::DeclarationContext>();
}

ExpressParser::DeclarationContext* ExpressParser::AlgorithmHeadContext::declaration(size_t i) {
  return getRuleContext<ExpressParser::DeclarationContext>(i);
}

ExpressParser::ConstantDeclContext* ExpressParser::AlgorithmHeadContext::constantDecl() {
  return getRuleContext<ExpressParser::ConstantDeclContext>(0);
}

ExpressParser::LocalDeclContext* ExpressParser::AlgorithmHeadContext::localDecl() {
  return getRuleContext<ExpressParser::LocalDeclContext>(0);
}


size_t ExpressParser::AlgorithmHeadContext::getRuleIndex() const {
  return ExpressParser::RuleAlgorithmHead;
}

void ExpressParser::AlgorithmHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAlgorithmHead(this);
}

void ExpressParser::AlgorithmHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAlgorithmHead(this);
}


antlrcpp::Any ExpressParser::AlgorithmHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAlgorithmHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AlgorithmHeadContext* ExpressParser::algorithmHead() {
  AlgorithmHeadContext *_localctx = _tracker.createInstance<AlgorithmHeadContext>(_ctx, getState());
  enterRule(_localctx, 46, ExpressParser::RuleAlgorithmHead);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(482);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (((((_la - 69) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 69)) & ((1ULL << (ExpressParser::ENTITY - 69))
      | (1ULL << (ExpressParser::FUNCTION - 69))
      | (1ULL << (ExpressParser::PROCEDURE - 69))
      | (1ULL << (ExpressParser::SUBTYPE_CONSTRAINT - 69)))) != 0) || _la == ExpressParser::TYPE) {
      setState(479);
      declaration();
      setState(484);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(486);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::CONSTANT) {
      setState(485);
      constantDecl();
    }
    setState(489);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::LOCAL) {
      setState(488);
      localDecl();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AliasStmtContext ------------------------------------------------------------------

ExpressParser::AliasStmtContext::AliasStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AliasStmtContext::ALIAS() {
  return getToken(ExpressParser::ALIAS, 0);
}

ExpressParser::VariableIdContext* ExpressParser::AliasStmtContext::variableId() {
  return getRuleContext<ExpressParser::VariableIdContext>(0);
}

tree::TerminalNode* ExpressParser::AliasStmtContext::FOR() {
  return getToken(ExpressParser::FOR, 0);
}

ExpressParser::GeneralRefContext* ExpressParser::AliasStmtContext::generalRef() {
  return getRuleContext<ExpressParser::GeneralRefContext>(0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::AliasStmtContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::AliasStmtContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}

tree::TerminalNode* ExpressParser::AliasStmtContext::END_ALIAS() {
  return getToken(ExpressParser::END_ALIAS, 0);
}

std::vector<ExpressParser::QualifierContext *> ExpressParser::AliasStmtContext::qualifier() {
  return getRuleContexts<ExpressParser::QualifierContext>();
}

ExpressParser::QualifierContext* ExpressParser::AliasStmtContext::qualifier(size_t i) {
  return getRuleContext<ExpressParser::QualifierContext>(i);
}


size_t ExpressParser::AliasStmtContext::getRuleIndex() const {
  return ExpressParser::RuleAliasStmt;
}

void ExpressParser::AliasStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAliasStmt(this);
}

void ExpressParser::AliasStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAliasStmt(this);
}


antlrcpp::Any ExpressParser::AliasStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAliasStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AliasStmtContext* ExpressParser::aliasStmt() {
  AliasStmtContext *_localctx = _tracker.createInstance<AliasStmtContext>(_ctx, getState());
  enterRule(_localctx, 48, ExpressParser::RuleAliasStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(491);
    match(ExpressParser::ALIAS);
    setState(492);
    variableId();
    setState(493);
    match(ExpressParser::FOR);
    setState(494);
    generalRef();
    setState(498);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__10)
      | (1ULL << ExpressParser::T__13))) != 0)) {
      setState(495);
      qualifier();
      setState(500);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(501);
    match(ExpressParser::T__0);
    setState(502);
    stmt();
    setState(506);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(503);
      stmt();
      setState(508);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(509);
    match(ExpressParser::END_ALIAS);
    setState(510);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ArrayTypeContext ------------------------------------------------------------------

ExpressParser::ArrayTypeContext::ArrayTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ArrayTypeContext::ARRAY() {
  return getToken(ExpressParser::ARRAY, 0);
}

ExpressParser::BoundSpecContext* ExpressParser::ArrayTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}

tree::TerminalNode* ExpressParser::ArrayTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::InstantiableTypeContext* ExpressParser::ArrayTypeContext::instantiableType() {
  return getRuleContext<ExpressParser::InstantiableTypeContext>(0);
}

tree::TerminalNode* ExpressParser::ArrayTypeContext::OPTIONAL() {
  return getToken(ExpressParser::OPTIONAL, 0);
}

tree::TerminalNode* ExpressParser::ArrayTypeContext::UNIQUE() {
  return getToken(ExpressParser::UNIQUE, 0);
}


size_t ExpressParser::ArrayTypeContext::getRuleIndex() const {
  return ExpressParser::RuleArrayType;
}

void ExpressParser::ArrayTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterArrayType(this);
}

void ExpressParser::ArrayTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitArrayType(this);
}


antlrcpp::Any ExpressParser::ArrayTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitArrayType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ArrayTypeContext* ExpressParser::arrayType() {
  ArrayTypeContext *_localctx = _tracker.createInstance<ArrayTypeContext>(_ctx, getState());
  enterRule(_localctx, 50, ExpressParser::RuleArrayType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(512);
    match(ExpressParser::ARRAY);
    setState(513);
    boundSpec();
    setState(514);
    match(ExpressParser::OF);
    setState(516);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::OPTIONAL) {
      setState(515);
      match(ExpressParser::OPTIONAL);
    }
    setState(519);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNIQUE) {
      setState(518);
      match(ExpressParser::UNIQUE);
    }
    setState(521);
    instantiableType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AssignmentStmtContext ------------------------------------------------------------------

ExpressParser::AssignmentStmtContext::AssignmentStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::GeneralRefContext* ExpressParser::AssignmentStmtContext::generalRef() {
  return getRuleContext<ExpressParser::GeneralRefContext>(0);
}

ExpressParser::ExpressionContext* ExpressParser::AssignmentStmtContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}

std::vector<ExpressParser::QualifierContext *> ExpressParser::AssignmentStmtContext::qualifier() {
  return getRuleContexts<ExpressParser::QualifierContext>();
}

ExpressParser::QualifierContext* ExpressParser::AssignmentStmtContext::qualifier(size_t i) {
  return getRuleContext<ExpressParser::QualifierContext>(i);
}


size_t ExpressParser::AssignmentStmtContext::getRuleIndex() const {
  return ExpressParser::RuleAssignmentStmt;
}

void ExpressParser::AssignmentStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAssignmentStmt(this);
}

void ExpressParser::AssignmentStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAssignmentStmt(this);
}


antlrcpp::Any ExpressParser::AssignmentStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAssignmentStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AssignmentStmtContext* ExpressParser::assignmentStmt() {
  AssignmentStmtContext *_localctx = _tracker.createInstance<AssignmentStmtContext>(_ctx, getState());
  enterRule(_localctx, 52, ExpressParser::RuleAssignmentStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(523);
    generalRef();
    setState(527);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__10)
      | (1ULL << ExpressParser::T__13))) != 0)) {
      setState(524);
      qualifier();
      setState(529);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(530);
    match(ExpressParser::T__9);
    setState(531);
    expression();
    setState(532);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AttributeDeclContext ------------------------------------------------------------------

ExpressParser::AttributeDeclContext::AttributeDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeIdContext* ExpressParser::AttributeDeclContext::attributeId() {
  return getRuleContext<ExpressParser::AttributeIdContext>(0);
}

ExpressParser::RedeclaredAttributeContext* ExpressParser::AttributeDeclContext::redeclaredAttribute() {
  return getRuleContext<ExpressParser::RedeclaredAttributeContext>(0);
}


size_t ExpressParser::AttributeDeclContext::getRuleIndex() const {
  return ExpressParser::RuleAttributeDecl;
}

void ExpressParser::AttributeDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAttributeDecl(this);
}

void ExpressParser::AttributeDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAttributeDecl(this);
}


antlrcpp::Any ExpressParser::AttributeDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAttributeDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AttributeDeclContext* ExpressParser::attributeDecl() {
  AttributeDeclContext *_localctx = _tracker.createInstance<AttributeDeclContext>(_ctx, getState());
  enterRule(_localctx, 54, ExpressParser::RuleAttributeDecl);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(536);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 1);
        setState(534);
        attributeId();
        break;
      }

      case ExpressParser::SELF: {
        enterOuterAlt(_localctx, 2);
        setState(535);
        redeclaredAttribute();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AttributeIdContext ------------------------------------------------------------------

ExpressParser::AttributeIdContext::AttributeIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::AttributeIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::AttributeIdContext::getRuleIndex() const {
  return ExpressParser::RuleAttributeId;
}

void ExpressParser::AttributeIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAttributeId(this);
}

void ExpressParser::AttributeIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAttributeId(this);
}


antlrcpp::Any ExpressParser::AttributeIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAttributeId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AttributeIdContext* ExpressParser::attributeId() {
  AttributeIdContext *_localctx = _tracker.createInstance<AttributeIdContext>(_ctx, getState());
  enterRule(_localctx, 56, ExpressParser::RuleAttributeId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(538);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- AttributeQualifierContext ------------------------------------------------------------------

ExpressParser::AttributeQualifierContext::AttributeQualifierContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeRefContext* ExpressParser::AttributeQualifierContext::attributeRef() {
  return getRuleContext<ExpressParser::AttributeRefContext>(0);
}


size_t ExpressParser::AttributeQualifierContext::getRuleIndex() const {
  return ExpressParser::RuleAttributeQualifier;
}

void ExpressParser::AttributeQualifierContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterAttributeQualifier(this);
}

void ExpressParser::AttributeQualifierContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitAttributeQualifier(this);
}


antlrcpp::Any ExpressParser::AttributeQualifierContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitAttributeQualifier(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::AttributeQualifierContext* ExpressParser::attributeQualifier() {
  AttributeQualifierContext *_localctx = _tracker.createInstance<AttributeQualifierContext>(_ctx, getState());
  enterRule(_localctx, 58, ExpressParser::RuleAttributeQualifier);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(540);
    match(ExpressParser::T__10);
    setState(541);
    attributeRef();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BagTypeContext ------------------------------------------------------------------

ExpressParser::BagTypeContext::BagTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BagTypeContext::BAG() {
  return getToken(ExpressParser::BAG, 0);
}

tree::TerminalNode* ExpressParser::BagTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::InstantiableTypeContext* ExpressParser::BagTypeContext::instantiableType() {
  return getRuleContext<ExpressParser::InstantiableTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::BagTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}


size_t ExpressParser::BagTypeContext::getRuleIndex() const {
  return ExpressParser::RuleBagType;
}

void ExpressParser::BagTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBagType(this);
}

void ExpressParser::BagTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBagType(this);
}


antlrcpp::Any ExpressParser::BagTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBagType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BagTypeContext* ExpressParser::bagType() {
  BagTypeContext *_localctx = _tracker.createInstance<BagTypeContext>(_ctx, getState());
  enterRule(_localctx, 60, ExpressParser::RuleBagType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(543);
    match(ExpressParser::BAG);
    setState(545);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(544);
      boundSpec();
    }
    setState(547);
    match(ExpressParser::OF);
    setState(548);
    instantiableType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BinaryTypeContext ------------------------------------------------------------------

ExpressParser::BinaryTypeContext::BinaryTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BinaryTypeContext::BINARY() {
  return getToken(ExpressParser::BINARY, 0);
}

ExpressParser::WidthSpecContext* ExpressParser::BinaryTypeContext::widthSpec() {
  return getRuleContext<ExpressParser::WidthSpecContext>(0);
}


size_t ExpressParser::BinaryTypeContext::getRuleIndex() const {
  return ExpressParser::RuleBinaryType;
}

void ExpressParser::BinaryTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBinaryType(this);
}

void ExpressParser::BinaryTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBinaryType(this);
}


antlrcpp::Any ExpressParser::BinaryTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBinaryType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BinaryTypeContext* ExpressParser::binaryType() {
  BinaryTypeContext *_localctx = _tracker.createInstance<BinaryTypeContext>(_ctx, getState());
  enterRule(_localctx, 62, ExpressParser::RuleBinaryType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(550);
    match(ExpressParser::BINARY);
    setState(552);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(551);
      widthSpec();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BooleanTypeContext ------------------------------------------------------------------

ExpressParser::BooleanTypeContext::BooleanTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BooleanTypeContext::BOOLEAN() {
  return getToken(ExpressParser::BOOLEAN, 0);
}


size_t ExpressParser::BooleanTypeContext::getRuleIndex() const {
  return ExpressParser::RuleBooleanType;
}

void ExpressParser::BooleanTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBooleanType(this);
}

void ExpressParser::BooleanTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBooleanType(this);
}


antlrcpp::Any ExpressParser::BooleanTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBooleanType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BooleanTypeContext* ExpressParser::booleanType() {
  BooleanTypeContext *_localctx = _tracker.createInstance<BooleanTypeContext>(_ctx, getState());
  enterRule(_localctx, 64, ExpressParser::RuleBooleanType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(554);
    match(ExpressParser::BOOLEAN);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Bound1Context ------------------------------------------------------------------

ExpressParser::Bound1Context::Bound1Context(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::Bound1Context::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::Bound1Context::getRuleIndex() const {
  return ExpressParser::RuleBound1;
}

void ExpressParser::Bound1Context::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBound1(this);
}

void ExpressParser::Bound1Context::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBound1(this);
}


antlrcpp::Any ExpressParser::Bound1Context::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBound1(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::Bound1Context* ExpressParser::bound1() {
  Bound1Context *_localctx = _tracker.createInstance<Bound1Context>(_ctx, getState());
  enterRule(_localctx, 66, ExpressParser::RuleBound1);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(556);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Bound2Context ------------------------------------------------------------------

ExpressParser::Bound2Context::Bound2Context(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::Bound2Context::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::Bound2Context::getRuleIndex() const {
  return ExpressParser::RuleBound2;
}

void ExpressParser::Bound2Context::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBound2(this);
}

void ExpressParser::Bound2Context::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBound2(this);
}


antlrcpp::Any ExpressParser::Bound2Context::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBound2(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::Bound2Context* ExpressParser::bound2() {
  Bound2Context *_localctx = _tracker.createInstance<Bound2Context>(_ctx, getState());
  enterRule(_localctx, 68, ExpressParser::RuleBound2);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(558);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BoundSpecContext ------------------------------------------------------------------

ExpressParser::BoundSpecContext::BoundSpecContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::Bound1Context* ExpressParser::BoundSpecContext::bound1() {
  return getRuleContext<ExpressParser::Bound1Context>(0);
}

ExpressParser::Bound2Context* ExpressParser::BoundSpecContext::bound2() {
  return getRuleContext<ExpressParser::Bound2Context>(0);
}


size_t ExpressParser::BoundSpecContext::getRuleIndex() const {
  return ExpressParser::RuleBoundSpec;
}

void ExpressParser::BoundSpecContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBoundSpec(this);
}

void ExpressParser::BoundSpecContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBoundSpec(this);
}


antlrcpp::Any ExpressParser::BoundSpecContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBoundSpec(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BoundSpecContext* ExpressParser::boundSpec() {
  BoundSpecContext *_localctx = _tracker.createInstance<BoundSpecContext>(_ctx, getState());
  enterRule(_localctx, 70, ExpressParser::RuleBoundSpec);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(560);
    match(ExpressParser::T__6);
    setState(561);
    bound1();
    setState(562);
    match(ExpressParser::T__8);
    setState(563);
    bound2();
    setState(564);
    match(ExpressParser::T__7);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BuiltInConstantContext ------------------------------------------------------------------

ExpressParser::BuiltInConstantContext::BuiltInConstantContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BuiltInConstantContext::CONST_E() {
  return getToken(ExpressParser::CONST_E, 0);
}

tree::TerminalNode* ExpressParser::BuiltInConstantContext::PI() {
  return getToken(ExpressParser::PI, 0);
}

tree::TerminalNode* ExpressParser::BuiltInConstantContext::SELF() {
  return getToken(ExpressParser::SELF, 0);
}


size_t ExpressParser::BuiltInConstantContext::getRuleIndex() const {
  return ExpressParser::RuleBuiltInConstant;
}

void ExpressParser::BuiltInConstantContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBuiltInConstant(this);
}

void ExpressParser::BuiltInConstantContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBuiltInConstant(this);
}


antlrcpp::Any ExpressParser::BuiltInConstantContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBuiltInConstant(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BuiltInConstantContext* ExpressParser::builtInConstant() {
  BuiltInConstantContext *_localctx = _tracker.createInstance<BuiltInConstantContext>(_ctx, getState());
  enterRule(_localctx, 72, ExpressParser::RuleBuiltInConstant);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(566);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::T__11

    || _la == ExpressParser::CONST_E || _la == ExpressParser::PI

    || _la == ExpressParser::SELF)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BuiltInFunctionContext ------------------------------------------------------------------

ExpressParser::BuiltInFunctionContext::BuiltInFunctionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ABS() {
  return getToken(ExpressParser::ABS, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ACOS() {
  return getToken(ExpressParser::ACOS, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ASIN() {
  return getToken(ExpressParser::ASIN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ATAN() {
  return getToken(ExpressParser::ATAN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::BLENGTH() {
  return getToken(ExpressParser::BLENGTH, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::COS() {
  return getToken(ExpressParser::COS, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::EXISTS() {
  return getToken(ExpressParser::EXISTS, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::EXP() {
  return getToken(ExpressParser::EXP, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::FORMAT() {
  return getToken(ExpressParser::FORMAT, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::HIBOUND() {
  return getToken(ExpressParser::HIBOUND, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::HIINDEX() {
  return getToken(ExpressParser::HIINDEX, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LENGTH() {
  return getToken(ExpressParser::LENGTH, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LOBOUND() {
  return getToken(ExpressParser::LOBOUND, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LOINDEX() {
  return getToken(ExpressParser::LOINDEX, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LOG() {
  return getToken(ExpressParser::LOG, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LOG2() {
  return getToken(ExpressParser::LOG2, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::LOG10() {
  return getToken(ExpressParser::LOG10, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::NVL() {
  return getToken(ExpressParser::NVL, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ODD() {
  return getToken(ExpressParser::ODD, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::ROLESOF() {
  return getToken(ExpressParser::ROLESOF, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::SIN() {
  return getToken(ExpressParser::SIN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::SIZEOF() {
  return getToken(ExpressParser::SIZEOF, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::SQRT() {
  return getToken(ExpressParser::SQRT, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::TAN() {
  return getToken(ExpressParser::TAN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::TYPEOF() {
  return getToken(ExpressParser::TYPEOF, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::USEDIN() {
  return getToken(ExpressParser::USEDIN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::VALUE_() {
  return getToken(ExpressParser::VALUE_, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::VALUE_IN() {
  return getToken(ExpressParser::VALUE_IN, 0);
}

tree::TerminalNode* ExpressParser::BuiltInFunctionContext::VALUE_UNIQUE() {
  return getToken(ExpressParser::VALUE_UNIQUE, 0);
}


size_t ExpressParser::BuiltInFunctionContext::getRuleIndex() const {
  return ExpressParser::RuleBuiltInFunction;
}

void ExpressParser::BuiltInFunctionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBuiltInFunction(this);
}

void ExpressParser::BuiltInFunctionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBuiltInFunction(this);
}


antlrcpp::Any ExpressParser::BuiltInFunctionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBuiltInFunction(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BuiltInFunctionContext* ExpressParser::builtInFunction() {
  BuiltInFunctionContext *_localctx = _tracker.createInstance<BuiltInFunctionContext>(_ctx, getState());
  enterRule(_localctx, 74, ExpressParser::RuleBuiltInFunction);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(568);
    _la = _input->LA(1);
    if (!(((((_la - 30) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 30)) & ((1ULL << (ExpressParser::ABS - 30))
      | (1ULL << (ExpressParser::ACOS - 30))
      | (1ULL << (ExpressParser::ASIN - 30))
      | (1ULL << (ExpressParser::ATAN - 30))
      | (1ULL << (ExpressParser::BLENGTH - 30))
      | (1ULL << (ExpressParser::COS - 30))
      | (1ULL << (ExpressParser::EXISTS - 30))
      | (1ULL << (ExpressParser::EXP - 30))
      | (1ULL << (ExpressParser::FORMAT - 30))
      | (1ULL << (ExpressParser::HIBOUND - 30))
      | (1ULL << (ExpressParser::HIINDEX - 30))
      | (1ULL << (ExpressParser::LENGTH - 30))
      | (1ULL << (ExpressParser::LOBOUND - 30)))) != 0) || ((((_la - 95) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 95)) & ((1ULL << (ExpressParser::LOG - 95))
      | (1ULL << (ExpressParser::LOG10 - 95))
      | (1ULL << (ExpressParser::LOG2 - 95))
      | (1ULL << (ExpressParser::LOINDEX - 95))
      | (1ULL << (ExpressParser::NVL - 95))
      | (1ULL << (ExpressParser::ODD - 95))
      | (1ULL << (ExpressParser::ROLESOF - 95))
      | (1ULL << (ExpressParser::SIN - 95))
      | (1ULL << (ExpressParser::SIZEOF - 95))
      | (1ULL << (ExpressParser::SQRT - 95))
      | (1ULL << (ExpressParser::TAN - 95))
      | (1ULL << (ExpressParser::TYPEOF - 95))
      | (1ULL << (ExpressParser::USEDIN - 95))
      | (1ULL << (ExpressParser::VALUE_ - 95))
      | (1ULL << (ExpressParser::VALUE_IN - 95))
      | (1ULL << (ExpressParser::VALUE_UNIQUE - 95)))) != 0))) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BuiltInProcedureContext ------------------------------------------------------------------

ExpressParser::BuiltInProcedureContext::BuiltInProcedureContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::BuiltInProcedureContext::INSERT() {
  return getToken(ExpressParser::INSERT, 0);
}

tree::TerminalNode* ExpressParser::BuiltInProcedureContext::REMOVE() {
  return getToken(ExpressParser::REMOVE, 0);
}


size_t ExpressParser::BuiltInProcedureContext::getRuleIndex() const {
  return ExpressParser::RuleBuiltInProcedure;
}

void ExpressParser::BuiltInProcedureContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterBuiltInProcedure(this);
}

void ExpressParser::BuiltInProcedureContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitBuiltInProcedure(this);
}


antlrcpp::Any ExpressParser::BuiltInProcedureContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitBuiltInProcedure(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::BuiltInProcedureContext* ExpressParser::builtInProcedure() {
  BuiltInProcedureContext *_localctx = _tracker.createInstance<BuiltInProcedureContext>(_ctx, getState());
  enterRule(_localctx, 76, ExpressParser::RuleBuiltInProcedure);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(570);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::INSERT

    || _la == ExpressParser::REMOVE)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- CaseActionContext ------------------------------------------------------------------

ExpressParser::CaseActionContext::CaseActionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::CaseLabelContext *> ExpressParser::CaseActionContext::caseLabel() {
  return getRuleContexts<ExpressParser::CaseLabelContext>();
}

ExpressParser::CaseLabelContext* ExpressParser::CaseActionContext::caseLabel(size_t i) {
  return getRuleContext<ExpressParser::CaseLabelContext>(i);
}

ExpressParser::StmtContext* ExpressParser::CaseActionContext::stmt() {
  return getRuleContext<ExpressParser::StmtContext>(0);
}


size_t ExpressParser::CaseActionContext::getRuleIndex() const {
  return ExpressParser::RuleCaseAction;
}

void ExpressParser::CaseActionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterCaseAction(this);
}

void ExpressParser::CaseActionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitCaseAction(this);
}


antlrcpp::Any ExpressParser::CaseActionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitCaseAction(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::CaseActionContext* ExpressParser::caseAction() {
  CaseActionContext *_localctx = _tracker.createInstance<CaseActionContext>(_ctx, getState());
  enterRule(_localctx, 78, ExpressParser::RuleCaseAction);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(572);
    caseLabel();
    setState(577);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(573);
      match(ExpressParser::T__2);
      setState(574);
      caseLabel();
      setState(579);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(580);
    match(ExpressParser::T__8);
    setState(581);
    stmt();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- CaseLabelContext ------------------------------------------------------------------

ExpressParser::CaseLabelContext::CaseLabelContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::CaseLabelContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::CaseLabelContext::getRuleIndex() const {
  return ExpressParser::RuleCaseLabel;
}

void ExpressParser::CaseLabelContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterCaseLabel(this);
}

void ExpressParser::CaseLabelContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitCaseLabel(this);
}


antlrcpp::Any ExpressParser::CaseLabelContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitCaseLabel(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::CaseLabelContext* ExpressParser::caseLabel() {
  CaseLabelContext *_localctx = _tracker.createInstance<CaseLabelContext>(_ctx, getState());
  enterRule(_localctx, 80, ExpressParser::RuleCaseLabel);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(583);
    expression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- CaseStmtContext ------------------------------------------------------------------

ExpressParser::CaseStmtContext::CaseStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::CaseStmtContext::CASE() {
  return getToken(ExpressParser::CASE, 0);
}

ExpressParser::SelectorContext* ExpressParser::CaseStmtContext::selector() {
  return getRuleContext<ExpressParser::SelectorContext>(0);
}

tree::TerminalNode* ExpressParser::CaseStmtContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

tree::TerminalNode* ExpressParser::CaseStmtContext::END_CASE() {
  return getToken(ExpressParser::END_CASE, 0);
}

std::vector<ExpressParser::CaseActionContext *> ExpressParser::CaseStmtContext::caseAction() {
  return getRuleContexts<ExpressParser::CaseActionContext>();
}

ExpressParser::CaseActionContext* ExpressParser::CaseStmtContext::caseAction(size_t i) {
  return getRuleContext<ExpressParser::CaseActionContext>(i);
}

tree::TerminalNode* ExpressParser::CaseStmtContext::OTHERWISE() {
  return getToken(ExpressParser::OTHERWISE, 0);
}

ExpressParser::StmtContext* ExpressParser::CaseStmtContext::stmt() {
  return getRuleContext<ExpressParser::StmtContext>(0);
}


size_t ExpressParser::CaseStmtContext::getRuleIndex() const {
  return ExpressParser::RuleCaseStmt;
}

void ExpressParser::CaseStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterCaseStmt(this);
}

void ExpressParser::CaseStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitCaseStmt(this);
}


antlrcpp::Any ExpressParser::CaseStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitCaseStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::CaseStmtContext* ExpressParser::caseStmt() {
  CaseStmtContext *_localctx = _tracker.createInstance<CaseStmtContext>(_ctx, getState());
  enterRule(_localctx, 82, ExpressParser::RuleCaseStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(585);
    match(ExpressParser::CASE);
    setState(586);
    selector();
    setState(587);
    match(ExpressParser::OF);
    setState(591);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__1)
      | (1ULL << ExpressParser::T__4)
      | (1ULL << ExpressParser::T__5)
      | (1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__11)
      | (1ULL << ExpressParser::T__14)
      | (1ULL << ExpressParser::ABS)
      | (1ULL << ExpressParser::ACOS)
      | (1ULL << ExpressParser::ASIN)
      | (1ULL << ExpressParser::ATAN)
      | (1ULL << ExpressParser::BLENGTH)
      | (1ULL << ExpressParser::CONST_E)
      | (1ULL << ExpressParser::COS))) != 0) || ((((_la - 72) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 72)) & ((1ULL << (ExpressParser::EXISTS - 72))
      | (1ULL << (ExpressParser::EXP - 72))
      | (1ULL << (ExpressParser::FALSE - 72))
      | (1ULL << (ExpressParser::FORMAT - 72))
      | (1ULL << (ExpressParser::HIBOUND - 72))
      | (1ULL << (ExpressParser::HIINDEX - 72))
      | (1ULL << (ExpressParser::LENGTH - 72))
      | (1ULL << (ExpressParser::LOBOUND - 72))
      | (1ULL << (ExpressParser::LOG - 72))
      | (1ULL << (ExpressParser::LOG10 - 72))
      | (1ULL << (ExpressParser::LOG2 - 72))
      | (1ULL << (ExpressParser::LOINDEX - 72))
      | (1ULL << (ExpressParser::NOT - 72))
      | (1ULL << (ExpressParser::NVL - 72))
      | (1ULL << (ExpressParser::ODD - 72))
      | (1ULL << (ExpressParser::PI - 72))
      | (1ULL << (ExpressParser::QUERY - 72))
      | (1ULL << (ExpressParser::ROLESOF - 72))
      | (1ULL << (ExpressParser::SELF - 72))
      | (1ULL << (ExpressParser::SIN - 72))
      | (1ULL << (ExpressParser::SIZEOF - 72))
      | (1ULL << (ExpressParser::SQRT - 72))
      | (1ULL << (ExpressParser::TAN - 72)))) != 0) || ((((_la - 136) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 136)) & ((1ULL << (ExpressParser::TRUE - 136))
      | (1ULL << (ExpressParser::TYPEOF - 136))
      | (1ULL << (ExpressParser::UNKNOWN - 136))
      | (1ULL << (ExpressParser::USEDIN - 136))
      | (1ULL << (ExpressParser::VALUE_ - 136))
      | (1ULL << (ExpressParser::VALUE_IN - 136))
      | (1ULL << (ExpressParser::VALUE_UNIQUE - 136))
      | (1ULL << (ExpressParser::BinaryLiteral - 136))
      | (1ULL << (ExpressParser::EncodedStringLiteral - 136))
      | (1ULL << (ExpressParser::IntegerLiteral - 136))
      | (1ULL << (ExpressParser::RealLiteral - 136))
      | (1ULL << (ExpressParser::SimpleId - 136))
      | (1ULL << (ExpressParser::SimpleStringLiteral - 136)))) != 0)) {
      setState(588);
      caseAction();
      setState(593);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(597);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::OTHERWISE) {
      setState(594);
      match(ExpressParser::OTHERWISE);
      setState(595);
      match(ExpressParser::T__8);
      setState(596);
      stmt();
    }
    setState(599);
    match(ExpressParser::END_CASE);
    setState(600);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- CompoundStmtContext ------------------------------------------------------------------

ExpressParser::CompoundStmtContext::CompoundStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::CompoundStmtContext::BEGIN_() {
  return getToken(ExpressParser::BEGIN_, 0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::CompoundStmtContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::CompoundStmtContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}

tree::TerminalNode* ExpressParser::CompoundStmtContext::END_() {
  return getToken(ExpressParser::END_, 0);
}


size_t ExpressParser::CompoundStmtContext::getRuleIndex() const {
  return ExpressParser::RuleCompoundStmt;
}

void ExpressParser::CompoundStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterCompoundStmt(this);
}

void ExpressParser::CompoundStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitCompoundStmt(this);
}


antlrcpp::Any ExpressParser::CompoundStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitCompoundStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::CompoundStmtContext* ExpressParser::compoundStmt() {
  CompoundStmtContext *_localctx = _tracker.createInstance<CompoundStmtContext>(_ctx, getState());
  enterRule(_localctx, 84, ExpressParser::RuleCompoundStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(602);
    match(ExpressParser::BEGIN_);
    setState(603);
    stmt();
    setState(607);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(604);
      stmt();
      setState(609);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(610);
    match(ExpressParser::END_);
    setState(611);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConcreteTypesContext ------------------------------------------------------------------

ExpressParser::ConcreteTypesContext::ConcreteTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AggregationTypesContext* ExpressParser::ConcreteTypesContext::aggregationTypes() {
  return getRuleContext<ExpressParser::AggregationTypesContext>(0);
}

ExpressParser::SimpleTypesContext* ExpressParser::ConcreteTypesContext::simpleTypes() {
  return getRuleContext<ExpressParser::SimpleTypesContext>(0);
}

ExpressParser::TypeRefContext* ExpressParser::ConcreteTypesContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}


size_t ExpressParser::ConcreteTypesContext::getRuleIndex() const {
  return ExpressParser::RuleConcreteTypes;
}

void ExpressParser::ConcreteTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConcreteTypes(this);
}

void ExpressParser::ConcreteTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConcreteTypes(this);
}


antlrcpp::Any ExpressParser::ConcreteTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConcreteTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConcreteTypesContext* ExpressParser::concreteTypes() {
  ConcreteTypesContext *_localctx = _tracker.createInstance<ConcreteTypesContext>(_ctx, getState());
  enterRule(_localctx, 86, ExpressParser::RuleConcreteTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(616);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ARRAY:
      case ExpressParser::BAG:
      case ExpressParser::LIST:
      case ExpressParser::SET: {
        enterOuterAlt(_localctx, 1);
        setState(613);
        aggregationTypes();
        break;
      }

      case ExpressParser::BINARY:
      case ExpressParser::BOOLEAN:
      case ExpressParser::INTEGER:
      case ExpressParser::LOGICAL:
      case ExpressParser::NUMBER:
      case ExpressParser::REAL:
      case ExpressParser::STRING: {
        enterOuterAlt(_localctx, 2);
        setState(614);
        simpleTypes();
        break;
      }

      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 3);
        setState(615);
        typeRef();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstantBodyContext ------------------------------------------------------------------

ExpressParser::ConstantBodyContext::ConstantBodyContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConstantIdContext* ExpressParser::ConstantBodyContext::constantId() {
  return getRuleContext<ExpressParser::ConstantIdContext>(0);
}

ExpressParser::InstantiableTypeContext* ExpressParser::ConstantBodyContext::instantiableType() {
  return getRuleContext<ExpressParser::InstantiableTypeContext>(0);
}

ExpressParser::ExpressionContext* ExpressParser::ConstantBodyContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::ConstantBodyContext::getRuleIndex() const {
  return ExpressParser::RuleConstantBody;
}

void ExpressParser::ConstantBodyContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstantBody(this);
}

void ExpressParser::ConstantBodyContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstantBody(this);
}


antlrcpp::Any ExpressParser::ConstantBodyContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstantBody(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstantBodyContext* ExpressParser::constantBody() {
  ConstantBodyContext *_localctx = _tracker.createInstance<ConstantBodyContext>(_ctx, getState());
  enterRule(_localctx, 88, ExpressParser::RuleConstantBody);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(618);
    constantId();
    setState(619);
    match(ExpressParser::T__8);
    setState(620);
    instantiableType();
    setState(621);
    match(ExpressParser::T__9);
    setState(622);
    expression();
    setState(623);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstantDeclContext ------------------------------------------------------------------

ExpressParser::ConstantDeclContext::ConstantDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ConstantDeclContext::CONSTANT() {
  return getToken(ExpressParser::CONSTANT, 0);
}

std::vector<ExpressParser::ConstantBodyContext *> ExpressParser::ConstantDeclContext::constantBody() {
  return getRuleContexts<ExpressParser::ConstantBodyContext>();
}

ExpressParser::ConstantBodyContext* ExpressParser::ConstantDeclContext::constantBody(size_t i) {
  return getRuleContext<ExpressParser::ConstantBodyContext>(i);
}

tree::TerminalNode* ExpressParser::ConstantDeclContext::END_CONSTANT() {
  return getToken(ExpressParser::END_CONSTANT, 0);
}


size_t ExpressParser::ConstantDeclContext::getRuleIndex() const {
  return ExpressParser::RuleConstantDecl;
}

void ExpressParser::ConstantDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstantDecl(this);
}

void ExpressParser::ConstantDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstantDecl(this);
}


antlrcpp::Any ExpressParser::ConstantDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstantDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstantDeclContext* ExpressParser::constantDecl() {
  ConstantDeclContext *_localctx = _tracker.createInstance<ConstantDeclContext>(_ctx, getState());
  enterRule(_localctx, 90, ExpressParser::RuleConstantDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(625);
    match(ExpressParser::CONSTANT);
    setState(626);
    constantBody();
    setState(630);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SimpleId) {
      setState(627);
      constantBody();
      setState(632);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(633);
    match(ExpressParser::END_CONSTANT);
    setState(634);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstantFactorContext ------------------------------------------------------------------

ExpressParser::ConstantFactorContext::ConstantFactorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::BuiltInConstantContext* ExpressParser::ConstantFactorContext::builtInConstant() {
  return getRuleContext<ExpressParser::BuiltInConstantContext>(0);
}

ExpressParser::ConstantRefContext* ExpressParser::ConstantFactorContext::constantRef() {
  return getRuleContext<ExpressParser::ConstantRefContext>(0);
}


size_t ExpressParser::ConstantFactorContext::getRuleIndex() const {
  return ExpressParser::RuleConstantFactor;
}

void ExpressParser::ConstantFactorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstantFactor(this);
}

void ExpressParser::ConstantFactorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstantFactor(this);
}


antlrcpp::Any ExpressParser::ConstantFactorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstantFactor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstantFactorContext* ExpressParser::constantFactor() {
  ConstantFactorContext *_localctx = _tracker.createInstance<ConstantFactorContext>(_ctx, getState());
  enterRule(_localctx, 92, ExpressParser::RuleConstantFactor);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(638);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::T__11:
      case ExpressParser::CONST_E:
      case ExpressParser::PI:
      case ExpressParser::SELF: {
        enterOuterAlt(_localctx, 1);
        setState(636);
        builtInConstant();
        break;
      }

      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 2);
        setState(637);
        constantRef();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstantIdContext ------------------------------------------------------------------

ExpressParser::ConstantIdContext::ConstantIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ConstantIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::ConstantIdContext::getRuleIndex() const {
  return ExpressParser::RuleConstantId;
}

void ExpressParser::ConstantIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstantId(this);
}

void ExpressParser::ConstantIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstantId(this);
}


antlrcpp::Any ExpressParser::ConstantIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstantId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstantIdContext* ExpressParser::constantId() {
  ConstantIdContext *_localctx = _tracker.createInstance<ConstantIdContext>(_ctx, getState());
  enterRule(_localctx, 94, ExpressParser::RuleConstantId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(640);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ConstructedTypesContext ------------------------------------------------------------------

ExpressParser::ConstructedTypesContext::ConstructedTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EnumerationTypeContext* ExpressParser::ConstructedTypesContext::enumerationType() {
  return getRuleContext<ExpressParser::EnumerationTypeContext>(0);
}

ExpressParser::SelectTypeContext* ExpressParser::ConstructedTypesContext::selectType() {
  return getRuleContext<ExpressParser::SelectTypeContext>(0);
}


size_t ExpressParser::ConstructedTypesContext::getRuleIndex() const {
  return ExpressParser::RuleConstructedTypes;
}

void ExpressParser::ConstructedTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterConstructedTypes(this);
}

void ExpressParser::ConstructedTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitConstructedTypes(this);
}


antlrcpp::Any ExpressParser::ConstructedTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitConstructedTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ConstructedTypesContext* ExpressParser::constructedTypes() {
  ConstructedTypesContext *_localctx = _tracker.createInstance<ConstructedTypesContext>(_ctx, getState());
  enterRule(_localctx, 96, ExpressParser::RuleConstructedTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(644);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 24, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(642);
      enumerationType();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(643);
      selectType();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DeclarationContext ------------------------------------------------------------------

ExpressParser::DeclarationContext::DeclarationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityDeclContext* ExpressParser::DeclarationContext::entityDecl() {
  return getRuleContext<ExpressParser::EntityDeclContext>(0);
}

ExpressParser::FunctionDeclContext* ExpressParser::DeclarationContext::functionDecl() {
  return getRuleContext<ExpressParser::FunctionDeclContext>(0);
}

ExpressParser::ProcedureDeclContext* ExpressParser::DeclarationContext::procedureDecl() {
  return getRuleContext<ExpressParser::ProcedureDeclContext>(0);
}

ExpressParser::SubtypeConstraintDeclContext* ExpressParser::DeclarationContext::subtypeConstraintDecl() {
  return getRuleContext<ExpressParser::SubtypeConstraintDeclContext>(0);
}

ExpressParser::TypeDeclContext* ExpressParser::DeclarationContext::typeDecl() {
  return getRuleContext<ExpressParser::TypeDeclContext>(0);
}


size_t ExpressParser::DeclarationContext::getRuleIndex() const {
  return ExpressParser::RuleDeclaration;
}

void ExpressParser::DeclarationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterDeclaration(this);
}

void ExpressParser::DeclarationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitDeclaration(this);
}


antlrcpp::Any ExpressParser::DeclarationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitDeclaration(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::DeclarationContext* ExpressParser::declaration() {
  DeclarationContext *_localctx = _tracker.createInstance<DeclarationContext>(_ctx, getState());
  enterRule(_localctx, 98, ExpressParser::RuleDeclaration);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(651);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ENTITY: {
        enterOuterAlt(_localctx, 1);
        setState(646);
        entityDecl();
        break;
      }

      case ExpressParser::FUNCTION: {
        enterOuterAlt(_localctx, 2);
        setState(647);
        functionDecl();
        break;
      }

      case ExpressParser::PROCEDURE: {
        enterOuterAlt(_localctx, 3);
        setState(648);
        procedureDecl();
        break;
      }

      case ExpressParser::SUBTYPE_CONSTRAINT: {
        enterOuterAlt(_localctx, 4);
        setState(649);
        subtypeConstraintDecl();
        break;
      }

      case ExpressParser::TYPE: {
        enterOuterAlt(_localctx, 5);
        setState(650);
        typeDecl();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DerivedAttrContext ------------------------------------------------------------------

ExpressParser::DerivedAttrContext::DerivedAttrContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeDeclContext* ExpressParser::DerivedAttrContext::attributeDecl() {
  return getRuleContext<ExpressParser::AttributeDeclContext>(0);
}

ExpressParser::ParameterTypeContext* ExpressParser::DerivedAttrContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::ExpressionContext* ExpressParser::DerivedAttrContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::DerivedAttrContext::getRuleIndex() const {
  return ExpressParser::RuleDerivedAttr;
}

void ExpressParser::DerivedAttrContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterDerivedAttr(this);
}

void ExpressParser::DerivedAttrContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitDerivedAttr(this);
}


antlrcpp::Any ExpressParser::DerivedAttrContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitDerivedAttr(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::DerivedAttrContext* ExpressParser::derivedAttr() {
  DerivedAttrContext *_localctx = _tracker.createInstance<DerivedAttrContext>(_ctx, getState());
  enterRule(_localctx, 100, ExpressParser::RuleDerivedAttr);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(653);
    attributeDecl();
    setState(654);
    match(ExpressParser::T__8);
    setState(655);
    parameterType();
    setState(656);
    match(ExpressParser::T__9);
    setState(657);
    expression();
    setState(658);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DeriveClauseContext ------------------------------------------------------------------

ExpressParser::DeriveClauseContext::DeriveClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::DeriveClauseContext::DERIVE() {
  return getToken(ExpressParser::DERIVE, 0);
}

std::vector<ExpressParser::DerivedAttrContext *> ExpressParser::DeriveClauseContext::derivedAttr() {
  return getRuleContexts<ExpressParser::DerivedAttrContext>();
}

ExpressParser::DerivedAttrContext* ExpressParser::DeriveClauseContext::derivedAttr(size_t i) {
  return getRuleContext<ExpressParser::DerivedAttrContext>(i);
}


size_t ExpressParser::DeriveClauseContext::getRuleIndex() const {
  return ExpressParser::RuleDeriveClause;
}

void ExpressParser::DeriveClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterDeriveClause(this);
}

void ExpressParser::DeriveClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitDeriveClause(this);
}


antlrcpp::Any ExpressParser::DeriveClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitDeriveClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::DeriveClauseContext* ExpressParser::deriveClause() {
  DeriveClauseContext *_localctx = _tracker.createInstance<DeriveClauseContext>(_ctx, getState());
  enterRule(_localctx, 102, ExpressParser::RuleDeriveClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(660);
    match(ExpressParser::DERIVE);
    setState(661);
    derivedAttr();
    setState(665);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SELF

    || _la == ExpressParser::SimpleId) {
      setState(662);
      derivedAttr();
      setState(667);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DomainRuleContext ------------------------------------------------------------------

ExpressParser::DomainRuleContext::DomainRuleContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::DomainRuleContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}

ExpressParser::RuleLabelIdContext* ExpressParser::DomainRuleContext::ruleLabelId() {
  return getRuleContext<ExpressParser::RuleLabelIdContext>(0);
}


size_t ExpressParser::DomainRuleContext::getRuleIndex() const {
  return ExpressParser::RuleDomainRule;
}

void ExpressParser::DomainRuleContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterDomainRule(this);
}

void ExpressParser::DomainRuleContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitDomainRule(this);
}


antlrcpp::Any ExpressParser::DomainRuleContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitDomainRule(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::DomainRuleContext* ExpressParser::domainRule() {
  DomainRuleContext *_localctx = _tracker.createInstance<DomainRuleContext>(_ctx, getState());
  enterRule(_localctx, 104, ExpressParser::RuleDomainRule);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(671);
    _errHandler->sync(this);

    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 27, _ctx)) {
    case 1: {
      setState(668);
      ruleLabelId();
      setState(669);
      match(ExpressParser::T__8);
      break;
    }

    }
    setState(673);
    expression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ElementContext ------------------------------------------------------------------

ExpressParser::ElementContext::ElementContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::ElementContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}

ExpressParser::RepetitionContext* ExpressParser::ElementContext::repetition() {
  return getRuleContext<ExpressParser::RepetitionContext>(0);
}


size_t ExpressParser::ElementContext::getRuleIndex() const {
  return ExpressParser::RuleElement;
}

void ExpressParser::ElementContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterElement(this);
}

void ExpressParser::ElementContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitElement(this);
}


antlrcpp::Any ExpressParser::ElementContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitElement(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ElementContext* ExpressParser::element() {
  ElementContext *_localctx = _tracker.createInstance<ElementContext>(_ctx, getState());
  enterRule(_localctx, 106, ExpressParser::RuleElement);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(675);
    expression();
    setState(678);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__8) {
      setState(676);
      match(ExpressParser::T__8);
      setState(677);
      repetition();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityBodyContext ------------------------------------------------------------------

ExpressParser::EntityBodyContext::EntityBodyContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::ExplicitAttrContext *> ExpressParser::EntityBodyContext::explicitAttr() {
  return getRuleContexts<ExpressParser::ExplicitAttrContext>();
}

ExpressParser::ExplicitAttrContext* ExpressParser::EntityBodyContext::explicitAttr(size_t i) {
  return getRuleContext<ExpressParser::ExplicitAttrContext>(i);
}

ExpressParser::DeriveClauseContext* ExpressParser::EntityBodyContext::deriveClause() {
  return getRuleContext<ExpressParser::DeriveClauseContext>(0);
}

ExpressParser::InverseClauseContext* ExpressParser::EntityBodyContext::inverseClause() {
  return getRuleContext<ExpressParser::InverseClauseContext>(0);
}

ExpressParser::UniqueClauseContext* ExpressParser::EntityBodyContext::uniqueClause() {
  return getRuleContext<ExpressParser::UniqueClauseContext>(0);
}

ExpressParser::WhereClauseContext* ExpressParser::EntityBodyContext::whereClause() {
  return getRuleContext<ExpressParser::WhereClauseContext>(0);
}


size_t ExpressParser::EntityBodyContext::getRuleIndex() const {
  return ExpressParser::RuleEntityBody;
}

void ExpressParser::EntityBodyContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityBody(this);
}

void ExpressParser::EntityBodyContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityBody(this);
}


antlrcpp::Any ExpressParser::EntityBodyContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityBody(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityBodyContext* ExpressParser::entityBody() {
  EntityBodyContext *_localctx = _tracker.createInstance<EntityBodyContext>(_ctx, getState());
  enterRule(_localctx, 108, ExpressParser::RuleEntityBody);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(683);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SELF

    || _la == ExpressParser::SimpleId) {
      setState(680);
      explicitAttr();
      setState(685);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(687);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::DERIVE) {
      setState(686);
      deriveClause();
    }
    setState(690);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::INVERSE) {
      setState(689);
      inverseClause();
    }
    setState(693);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNIQUE) {
      setState(692);
      uniqueClause();
    }
    setState(696);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::WHERE) {
      setState(695);
      whereClause();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityConstructorContext ------------------------------------------------------------------

ExpressParser::EntityConstructorContext::EntityConstructorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::EntityConstructorContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}

std::vector<ExpressParser::ExpressionContext *> ExpressParser::EntityConstructorContext::expression() {
  return getRuleContexts<ExpressParser::ExpressionContext>();
}

ExpressParser::ExpressionContext* ExpressParser::EntityConstructorContext::expression(size_t i) {
  return getRuleContext<ExpressParser::ExpressionContext>(i);
}


size_t ExpressParser::EntityConstructorContext::getRuleIndex() const {
  return ExpressParser::RuleEntityConstructor;
}

void ExpressParser::EntityConstructorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityConstructor(this);
}

void ExpressParser::EntityConstructorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityConstructor(this);
}


antlrcpp::Any ExpressParser::EntityConstructorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityConstructor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityConstructorContext* ExpressParser::entityConstructor() {
  EntityConstructorContext *_localctx = _tracker.createInstance<EntityConstructorContext>(_ctx, getState());
  enterRule(_localctx, 110, ExpressParser::RuleEntityConstructor);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(698);
    entityRef();
    setState(699);
    match(ExpressParser::T__1);
    setState(708);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__1)
      | (1ULL << ExpressParser::T__4)
      | (1ULL << ExpressParser::T__5)
      | (1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__11)
      | (1ULL << ExpressParser::T__14)
      | (1ULL << ExpressParser::ABS)
      | (1ULL << ExpressParser::ACOS)
      | (1ULL << ExpressParser::ASIN)
      | (1ULL << ExpressParser::ATAN)
      | (1ULL << ExpressParser::BLENGTH)
      | (1ULL << ExpressParser::CONST_E)
      | (1ULL << ExpressParser::COS))) != 0) || ((((_la - 72) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 72)) & ((1ULL << (ExpressParser::EXISTS - 72))
      | (1ULL << (ExpressParser::EXP - 72))
      | (1ULL << (ExpressParser::FALSE - 72))
      | (1ULL << (ExpressParser::FORMAT - 72))
      | (1ULL << (ExpressParser::HIBOUND - 72))
      | (1ULL << (ExpressParser::HIINDEX - 72))
      | (1ULL << (ExpressParser::LENGTH - 72))
      | (1ULL << (ExpressParser::LOBOUND - 72))
      | (1ULL << (ExpressParser::LOG - 72))
      | (1ULL << (ExpressParser::LOG10 - 72))
      | (1ULL << (ExpressParser::LOG2 - 72))
      | (1ULL << (ExpressParser::LOINDEX - 72))
      | (1ULL << (ExpressParser::NOT - 72))
      | (1ULL << (ExpressParser::NVL - 72))
      | (1ULL << (ExpressParser::ODD - 72))
      | (1ULL << (ExpressParser::PI - 72))
      | (1ULL << (ExpressParser::QUERY - 72))
      | (1ULL << (ExpressParser::ROLESOF - 72))
      | (1ULL << (ExpressParser::SELF - 72))
      | (1ULL << (ExpressParser::SIN - 72))
      | (1ULL << (ExpressParser::SIZEOF - 72))
      | (1ULL << (ExpressParser::SQRT - 72))
      | (1ULL << (ExpressParser::TAN - 72)))) != 0) || ((((_la - 136) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 136)) & ((1ULL << (ExpressParser::TRUE - 136))
      | (1ULL << (ExpressParser::TYPEOF - 136))
      | (1ULL << (ExpressParser::UNKNOWN - 136))
      | (1ULL << (ExpressParser::USEDIN - 136))
      | (1ULL << (ExpressParser::VALUE_ - 136))
      | (1ULL << (ExpressParser::VALUE_IN - 136))
      | (1ULL << (ExpressParser::VALUE_UNIQUE - 136))
      | (1ULL << (ExpressParser::BinaryLiteral - 136))
      | (1ULL << (ExpressParser::EncodedStringLiteral - 136))
      | (1ULL << (ExpressParser::IntegerLiteral - 136))
      | (1ULL << (ExpressParser::RealLiteral - 136))
      | (1ULL << (ExpressParser::SimpleId - 136))
      | (1ULL << (ExpressParser::SimpleStringLiteral - 136)))) != 0)) {
      setState(700);
      expression();
      setState(705);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__2) {
        setState(701);
        match(ExpressParser::T__2);
        setState(702);
        expression();
        setState(707);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
    }
    setState(710);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityDeclContext ------------------------------------------------------------------

ExpressParser::EntityDeclContext::EntityDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityHeadContext* ExpressParser::EntityDeclContext::entityHead() {
  return getRuleContext<ExpressParser::EntityHeadContext>(0);
}

ExpressParser::EntityBodyContext* ExpressParser::EntityDeclContext::entityBody() {
  return getRuleContext<ExpressParser::EntityBodyContext>(0);
}

tree::TerminalNode* ExpressParser::EntityDeclContext::END_ENTITY() {
  return getToken(ExpressParser::END_ENTITY, 0);
}


size_t ExpressParser::EntityDeclContext::getRuleIndex() const {
  return ExpressParser::RuleEntityDecl;
}

void ExpressParser::EntityDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityDecl(this);
}

void ExpressParser::EntityDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityDecl(this);
}


antlrcpp::Any ExpressParser::EntityDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityDeclContext* ExpressParser::entityDecl() {
  EntityDeclContext *_localctx = _tracker.createInstance<EntityDeclContext>(_ctx, getState());
  enterRule(_localctx, 112, ExpressParser::RuleEntityDecl);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(712);
    entityHead();
    setState(713);
    entityBody();
    setState(714);
    match(ExpressParser::END_ENTITY);
    setState(715);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityHeadContext ------------------------------------------------------------------

ExpressParser::EntityHeadContext::EntityHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EntityHeadContext::ENTITY() {
  return getToken(ExpressParser::ENTITY, 0);
}

ExpressParser::EntityIdContext* ExpressParser::EntityHeadContext::entityId() {
  return getRuleContext<ExpressParser::EntityIdContext>(0);
}

ExpressParser::SubsuperContext* ExpressParser::EntityHeadContext::subsuper() {
  return getRuleContext<ExpressParser::SubsuperContext>(0);
}


size_t ExpressParser::EntityHeadContext::getRuleIndex() const {
  return ExpressParser::RuleEntityHead;
}

void ExpressParser::EntityHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityHead(this);
}

void ExpressParser::EntityHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityHead(this);
}


antlrcpp::Any ExpressParser::EntityHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityHeadContext* ExpressParser::entityHead() {
  EntityHeadContext *_localctx = _tracker.createInstance<EntityHeadContext>(_ctx, getState());
  enterRule(_localctx, 114, ExpressParser::RuleEntityHead);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(717);
    match(ExpressParser::ENTITY);
    setState(718);
    entityId();
    setState(719);
    subsuper();
    setState(720);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EntityIdContext ------------------------------------------------------------------

ExpressParser::EntityIdContext::EntityIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EntityIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::EntityIdContext::getRuleIndex() const {
  return ExpressParser::RuleEntityId;
}

void ExpressParser::EntityIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEntityId(this);
}

void ExpressParser::EntityIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEntityId(this);
}


antlrcpp::Any ExpressParser::EntityIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEntityId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EntityIdContext* ExpressParser::entityId() {
  EntityIdContext *_localctx = _tracker.createInstance<EntityIdContext>(_ctx, getState());
  enterRule(_localctx, 116, ExpressParser::RuleEntityId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(722);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationExtensionContext ------------------------------------------------------------------

ExpressParser::EnumerationExtensionContext::EnumerationExtensionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EnumerationExtensionContext::BASED_ON() {
  return getToken(ExpressParser::BASED_ON, 0);
}

ExpressParser::TypeRefContext* ExpressParser::EnumerationExtensionContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}

tree::TerminalNode* ExpressParser::EnumerationExtensionContext::WITH() {
  return getToken(ExpressParser::WITH, 0);
}

ExpressParser::EnumerationItemsContext* ExpressParser::EnumerationExtensionContext::enumerationItems() {
  return getRuleContext<ExpressParser::EnumerationItemsContext>(0);
}


size_t ExpressParser::EnumerationExtensionContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationExtension;
}

void ExpressParser::EnumerationExtensionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationExtension(this);
}

void ExpressParser::EnumerationExtensionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationExtension(this);
}


antlrcpp::Any ExpressParser::EnumerationExtensionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationExtension(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationExtensionContext* ExpressParser::enumerationExtension() {
  EnumerationExtensionContext *_localctx = _tracker.createInstance<EnumerationExtensionContext>(_ctx, getState());
  enterRule(_localctx, 118, ExpressParser::RuleEnumerationExtension);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(724);
    match(ExpressParser::BASED_ON);
    setState(725);
    typeRef();
    setState(728);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::WITH) {
      setState(726);
      match(ExpressParser::WITH);
      setState(727);
      enumerationItems();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationIdContext ------------------------------------------------------------------

ExpressParser::EnumerationIdContext::EnumerationIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EnumerationIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::EnumerationIdContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationId;
}

void ExpressParser::EnumerationIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationId(this);
}

void ExpressParser::EnumerationIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationId(this);
}


antlrcpp::Any ExpressParser::EnumerationIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationIdContext* ExpressParser::enumerationId() {
  EnumerationIdContext *_localctx = _tracker.createInstance<EnumerationIdContext>(_ctx, getState());
  enterRule(_localctx, 120, ExpressParser::RuleEnumerationId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(730);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationItemsContext ------------------------------------------------------------------

ExpressParser::EnumerationItemsContext::EnumerationItemsContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::EnumerationItemContext *> ExpressParser::EnumerationItemsContext::enumerationItem() {
  return getRuleContexts<ExpressParser::EnumerationItemContext>();
}

ExpressParser::EnumerationItemContext* ExpressParser::EnumerationItemsContext::enumerationItem(size_t i) {
  return getRuleContext<ExpressParser::EnumerationItemContext>(i);
}


size_t ExpressParser::EnumerationItemsContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationItems;
}

void ExpressParser::EnumerationItemsContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationItems(this);
}

void ExpressParser::EnumerationItemsContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationItems(this);
}


antlrcpp::Any ExpressParser::EnumerationItemsContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationItems(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationItemsContext* ExpressParser::enumerationItems() {
  EnumerationItemsContext *_localctx = _tracker.createInstance<EnumerationItemsContext>(_ctx, getState());
  enterRule(_localctx, 122, ExpressParser::RuleEnumerationItems);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(732);
    match(ExpressParser::T__1);
    setState(733);
    enumerationItem();
    setState(738);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(734);
      match(ExpressParser::T__2);
      setState(735);
      enumerationItem();
      setState(740);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(741);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationItemContext ------------------------------------------------------------------

ExpressParser::EnumerationItemContext::EnumerationItemContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EnumerationIdContext* ExpressParser::EnumerationItemContext::enumerationId() {
  return getRuleContext<ExpressParser::EnumerationIdContext>(0);
}


size_t ExpressParser::EnumerationItemContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationItem;
}

void ExpressParser::EnumerationItemContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationItem(this);
}

void ExpressParser::EnumerationItemContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationItem(this);
}


antlrcpp::Any ExpressParser::EnumerationItemContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationItem(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationItemContext* ExpressParser::enumerationItem() {
  EnumerationItemContext *_localctx = _tracker.createInstance<EnumerationItemContext>(_ctx, getState());
  enterRule(_localctx, 124, ExpressParser::RuleEnumerationItem);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(743);
    enumerationId();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationReferenceContext ------------------------------------------------------------------

ExpressParser::EnumerationReferenceContext::EnumerationReferenceContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EnumerationRefContext* ExpressParser::EnumerationReferenceContext::enumerationRef() {
  return getRuleContext<ExpressParser::EnumerationRefContext>(0);
}

ExpressParser::TypeRefContext* ExpressParser::EnumerationReferenceContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}


size_t ExpressParser::EnumerationReferenceContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationReference;
}

void ExpressParser::EnumerationReferenceContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationReference(this);
}

void ExpressParser::EnumerationReferenceContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationReference(this);
}


antlrcpp::Any ExpressParser::EnumerationReferenceContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationReference(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationReferenceContext* ExpressParser::enumerationReference() {
  EnumerationReferenceContext *_localctx = _tracker.createInstance<EnumerationReferenceContext>(_ctx, getState());
  enterRule(_localctx, 126, ExpressParser::RuleEnumerationReference);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(748);
    _errHandler->sync(this);

    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 38, _ctx)) {
    case 1: {
      setState(745);
      typeRef();
      setState(746);
      match(ExpressParser::T__10);
      break;
    }

    }
    setState(750);
    enumerationRef();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EnumerationTypeContext ------------------------------------------------------------------

ExpressParser::EnumerationTypeContext::EnumerationTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EnumerationTypeContext::ENUMERATION() {
  return getToken(ExpressParser::ENUMERATION, 0);
}

tree::TerminalNode* ExpressParser::EnumerationTypeContext::EXTENSIBLE() {
  return getToken(ExpressParser::EXTENSIBLE, 0);
}

tree::TerminalNode* ExpressParser::EnumerationTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::EnumerationItemsContext* ExpressParser::EnumerationTypeContext::enumerationItems() {
  return getRuleContext<ExpressParser::EnumerationItemsContext>(0);
}

ExpressParser::EnumerationExtensionContext* ExpressParser::EnumerationTypeContext::enumerationExtension() {
  return getRuleContext<ExpressParser::EnumerationExtensionContext>(0);
}


size_t ExpressParser::EnumerationTypeContext::getRuleIndex() const {
  return ExpressParser::RuleEnumerationType;
}

void ExpressParser::EnumerationTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEnumerationType(this);
}

void ExpressParser::EnumerationTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEnumerationType(this);
}


antlrcpp::Any ExpressParser::EnumerationTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEnumerationType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EnumerationTypeContext* ExpressParser::enumerationType() {
  EnumerationTypeContext *_localctx = _tracker.createInstance<EnumerationTypeContext>(_ctx, getState());
  enterRule(_localctx, 128, ExpressParser::RuleEnumerationType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(753);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::EXTENSIBLE) {
      setState(752);
      match(ExpressParser::EXTENSIBLE);
    }
    setState(755);
    match(ExpressParser::ENUMERATION);
    setState(759);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::OF: {
        setState(756);
        match(ExpressParser::OF);
        setState(757);
        enumerationItems();
        break;
      }

      case ExpressParser::BASED_ON: {
        setState(758);
        enumerationExtension();
        break;
      }

      case ExpressParser::T__0: {
        break;
      }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EscapeStmtContext ------------------------------------------------------------------

ExpressParser::EscapeStmtContext::EscapeStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::EscapeStmtContext::ESCAPE() {
  return getToken(ExpressParser::ESCAPE, 0);
}


size_t ExpressParser::EscapeStmtContext::getRuleIndex() const {
  return ExpressParser::RuleEscapeStmt;
}

void ExpressParser::EscapeStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEscapeStmt(this);
}

void ExpressParser::EscapeStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEscapeStmt(this);
}


antlrcpp::Any ExpressParser::EscapeStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitEscapeStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::EscapeStmtContext* ExpressParser::escapeStmt() {
  EscapeStmtContext *_localctx = _tracker.createInstance<EscapeStmtContext>(_ctx, getState());
  enterRule(_localctx, 130, ExpressParser::RuleEscapeStmt);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(761);
    match(ExpressParser::ESCAPE);
    setState(762);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ExplicitAttrContext ------------------------------------------------------------------

ExpressParser::ExplicitAttrContext::ExplicitAttrContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::AttributeDeclContext *> ExpressParser::ExplicitAttrContext::attributeDecl() {
  return getRuleContexts<ExpressParser::AttributeDeclContext>();
}

ExpressParser::AttributeDeclContext* ExpressParser::ExplicitAttrContext::attributeDecl(size_t i) {
  return getRuleContext<ExpressParser::AttributeDeclContext>(i);
}

ExpressParser::ParameterTypeContext* ExpressParser::ExplicitAttrContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

tree::TerminalNode* ExpressParser::ExplicitAttrContext::OPTIONAL() {
  return getToken(ExpressParser::OPTIONAL, 0);
}


size_t ExpressParser::ExplicitAttrContext::getRuleIndex() const {
  return ExpressParser::RuleExplicitAttr;
}

void ExpressParser::ExplicitAttrContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterExplicitAttr(this);
}

void ExpressParser::ExplicitAttrContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitExplicitAttr(this);
}


antlrcpp::Any ExpressParser::ExplicitAttrContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitExplicitAttr(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ExplicitAttrContext* ExpressParser::explicitAttr() {
  ExplicitAttrContext *_localctx = _tracker.createInstance<ExplicitAttrContext>(_ctx, getState());
  enterRule(_localctx, 132, ExpressParser::RuleExplicitAttr);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(764);
    attributeDecl();
    setState(769);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(765);
      match(ExpressParser::T__2);
      setState(766);
      attributeDecl();
      setState(771);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(772);
    match(ExpressParser::T__8);
    setState(774);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::OPTIONAL) {
      setState(773);
      match(ExpressParser::OPTIONAL);
    }
    setState(776);
    parameterType();
    setState(777);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ExpressionContext ------------------------------------------------------------------

ExpressParser::ExpressionContext::ExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::SimpleExpressionContext *> ExpressParser::ExpressionContext::simpleExpression() {
  return getRuleContexts<ExpressParser::SimpleExpressionContext>();
}

ExpressParser::SimpleExpressionContext* ExpressParser::ExpressionContext::simpleExpression(size_t i) {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(i);
}

ExpressParser::RelOpExtendedContext* ExpressParser::ExpressionContext::relOpExtended() {
  return getRuleContext<ExpressParser::RelOpExtendedContext>(0);
}


size_t ExpressParser::ExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleExpression;
}

void ExpressParser::ExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterExpression(this);
}

void ExpressParser::ExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitExpression(this);
}


antlrcpp::Any ExpressParser::ExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ExpressionContext* ExpressParser::expression() {
  ExpressionContext *_localctx = _tracker.createInstance<ExpressionContext>(_ctx, getState());
  enterRule(_localctx, 134, ExpressParser::RuleExpression);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(779);
    simpleExpression();
    setState(783);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__16)
      | (1ULL << ExpressParser::T__17)
      | (1ULL << ExpressParser::T__23)
      | (1ULL << ExpressParser::T__24)
      | (1ULL << ExpressParser::T__25)
      | (1ULL << ExpressParser::T__26)
      | (1ULL << ExpressParser::T__27)
      | (1ULL << ExpressParser::T__28))) != 0) || _la == ExpressParser::IN

    || _la == ExpressParser::LIKE) {
      setState(780);
      relOpExtended();
      setState(781);
      simpleExpression();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FactorContext ------------------------------------------------------------------

ExpressParser::FactorContext::FactorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::SimpleFactorContext *> ExpressParser::FactorContext::simpleFactor() {
  return getRuleContexts<ExpressParser::SimpleFactorContext>();
}

ExpressParser::SimpleFactorContext* ExpressParser::FactorContext::simpleFactor(size_t i) {
  return getRuleContext<ExpressParser::SimpleFactorContext>(i);
}


size_t ExpressParser::FactorContext::getRuleIndex() const {
  return ExpressParser::RuleFactor;
}

void ExpressParser::FactorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFactor(this);
}

void ExpressParser::FactorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFactor(this);
}


antlrcpp::Any ExpressParser::FactorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFactor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FactorContext* ExpressParser::factor() {
  FactorContext *_localctx = _tracker.createInstance<FactorContext>(_ctx, getState());
  enterRule(_localctx, 136, ExpressParser::RuleFactor);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(785);
    simpleFactor();
    setState(788);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__12) {
      setState(786);
      match(ExpressParser::T__12);
      setState(787);
      simpleFactor();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FormalParameterContext ------------------------------------------------------------------

ExpressParser::FormalParameterContext::FormalParameterContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::ParameterIdContext *> ExpressParser::FormalParameterContext::parameterId() {
  return getRuleContexts<ExpressParser::ParameterIdContext>();
}

ExpressParser::ParameterIdContext* ExpressParser::FormalParameterContext::parameterId(size_t i) {
  return getRuleContext<ExpressParser::ParameterIdContext>(i);
}

ExpressParser::ParameterTypeContext* ExpressParser::FormalParameterContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}


size_t ExpressParser::FormalParameterContext::getRuleIndex() const {
  return ExpressParser::RuleFormalParameter;
}

void ExpressParser::FormalParameterContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFormalParameter(this);
}

void ExpressParser::FormalParameterContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFormalParameter(this);
}


antlrcpp::Any ExpressParser::FormalParameterContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFormalParameter(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FormalParameterContext* ExpressParser::formalParameter() {
  FormalParameterContext *_localctx = _tracker.createInstance<FormalParameterContext>(_ctx, getState());
  enterRule(_localctx, 138, ExpressParser::RuleFormalParameter);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(790);
    parameterId();
    setState(795);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(791);
      match(ExpressParser::T__2);
      setState(792);
      parameterId();
      setState(797);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(798);
    match(ExpressParser::T__8);
    setState(799);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionCallContext ------------------------------------------------------------------

ExpressParser::FunctionCallContext::FunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::BuiltInFunctionContext* ExpressParser::FunctionCallContext::builtInFunction() {
  return getRuleContext<ExpressParser::BuiltInFunctionContext>(0);
}

ExpressParser::FunctionRefContext* ExpressParser::FunctionCallContext::functionRef() {
  return getRuleContext<ExpressParser::FunctionRefContext>(0);
}

ExpressParser::ActualParameterListContext* ExpressParser::FunctionCallContext::actualParameterList() {
  return getRuleContext<ExpressParser::ActualParameterListContext>(0);
}


size_t ExpressParser::FunctionCallContext::getRuleIndex() const {
  return ExpressParser::RuleFunctionCall;
}

void ExpressParser::FunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionCall(this);
}

void ExpressParser::FunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionCall(this);
}


antlrcpp::Any ExpressParser::FunctionCallContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFunctionCall(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FunctionCallContext* ExpressParser::functionCall() {
  FunctionCallContext *_localctx = _tracker.createInstance<FunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 140, ExpressParser::RuleFunctionCall);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(803);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ABS:
      case ExpressParser::ACOS:
      case ExpressParser::ASIN:
      case ExpressParser::ATAN:
      case ExpressParser::BLENGTH:
      case ExpressParser::COS:
      case ExpressParser::EXISTS:
      case ExpressParser::EXP:
      case ExpressParser::FORMAT:
      case ExpressParser::HIBOUND:
      case ExpressParser::HIINDEX:
      case ExpressParser::LENGTH:
      case ExpressParser::LOBOUND:
      case ExpressParser::LOG:
      case ExpressParser::LOG10:
      case ExpressParser::LOG2:
      case ExpressParser::LOINDEX:
      case ExpressParser::NVL:
      case ExpressParser::ODD:
      case ExpressParser::ROLESOF:
      case ExpressParser::SIN:
      case ExpressParser::SIZEOF:
      case ExpressParser::SQRT:
      case ExpressParser::TAN:
      case ExpressParser::TYPEOF:
      case ExpressParser::USEDIN:
      case ExpressParser::VALUE_:
      case ExpressParser::VALUE_IN:
      case ExpressParser::VALUE_UNIQUE: {
        setState(801);
        builtInFunction();
        break;
      }

      case ExpressParser::SimpleId: {
        setState(802);
        functionRef();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
    setState(806);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(805);
      actualParameterList();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionDeclContext ------------------------------------------------------------------

ExpressParser::FunctionDeclContext::FunctionDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::FunctionHeadContext* ExpressParser::FunctionDeclContext::functionHead() {
  return getRuleContext<ExpressParser::FunctionHeadContext>(0);
}

ExpressParser::AlgorithmHeadContext* ExpressParser::FunctionDeclContext::algorithmHead() {
  return getRuleContext<ExpressParser::AlgorithmHeadContext>(0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::FunctionDeclContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::FunctionDeclContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}

tree::TerminalNode* ExpressParser::FunctionDeclContext::END_FUNCTION() {
  return getToken(ExpressParser::END_FUNCTION, 0);
}


size_t ExpressParser::FunctionDeclContext::getRuleIndex() const {
  return ExpressParser::RuleFunctionDecl;
}

void ExpressParser::FunctionDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionDecl(this);
}

void ExpressParser::FunctionDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionDecl(this);
}


antlrcpp::Any ExpressParser::FunctionDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFunctionDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FunctionDeclContext* ExpressParser::functionDecl() {
  FunctionDeclContext *_localctx = _tracker.createInstance<FunctionDeclContext>(_ctx, getState());
  enterRule(_localctx, 142, ExpressParser::RuleFunctionDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(808);
    functionHead();
    setState(809);
    algorithmHead();
    setState(810);
    stmt();
    setState(814);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(811);
      stmt();
      setState(816);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(817);
    match(ExpressParser::END_FUNCTION);
    setState(818);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionHeadContext ------------------------------------------------------------------

ExpressParser::FunctionHeadContext::FunctionHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::FunctionHeadContext::FUNCTION() {
  return getToken(ExpressParser::FUNCTION, 0);
}

ExpressParser::FunctionIdContext* ExpressParser::FunctionHeadContext::functionId() {
  return getRuleContext<ExpressParser::FunctionIdContext>(0);
}

ExpressParser::ParameterTypeContext* ExpressParser::FunctionHeadContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

std::vector<ExpressParser::FormalParameterContext *> ExpressParser::FunctionHeadContext::formalParameter() {
  return getRuleContexts<ExpressParser::FormalParameterContext>();
}

ExpressParser::FormalParameterContext* ExpressParser::FunctionHeadContext::formalParameter(size_t i) {
  return getRuleContext<ExpressParser::FormalParameterContext>(i);
}


size_t ExpressParser::FunctionHeadContext::getRuleIndex() const {
  return ExpressParser::RuleFunctionHead;
}

void ExpressParser::FunctionHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionHead(this);
}

void ExpressParser::FunctionHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionHead(this);
}


antlrcpp::Any ExpressParser::FunctionHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFunctionHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FunctionHeadContext* ExpressParser::functionHead() {
  FunctionHeadContext *_localctx = _tracker.createInstance<FunctionHeadContext>(_ctx, getState());
  enterRule(_localctx, 144, ExpressParser::RuleFunctionHead);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(820);
    match(ExpressParser::FUNCTION);
    setState(821);
    functionId();
    setState(833);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(822);
      match(ExpressParser::T__1);
      setState(823);
      formalParameter();
      setState(828);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__0) {
        setState(824);
        match(ExpressParser::T__0);
        setState(825);
        formalParameter();
        setState(830);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(831);
      match(ExpressParser::T__3);
    }
    setState(835);
    match(ExpressParser::T__8);
    setState(836);
    parameterType();
    setState(837);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionIdContext ------------------------------------------------------------------

ExpressParser::FunctionIdContext::FunctionIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::FunctionIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::FunctionIdContext::getRuleIndex() const {
  return ExpressParser::RuleFunctionId;
}

void ExpressParser::FunctionIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionId(this);
}

void ExpressParser::FunctionIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionId(this);
}


antlrcpp::Any ExpressParser::FunctionIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitFunctionId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::FunctionIdContext* ExpressParser::functionId() {
  FunctionIdContext *_localctx = _tracker.createInstance<FunctionIdContext>(_ctx, getState());
  enterRule(_localctx, 146, ExpressParser::RuleFunctionId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(839);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralizedTypesContext ------------------------------------------------------------------

ExpressParser::GeneralizedTypesContext::GeneralizedTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AggregateTypeContext* ExpressParser::GeneralizedTypesContext::aggregateType() {
  return getRuleContext<ExpressParser::AggregateTypeContext>(0);
}

ExpressParser::GeneralAggregationTypesContext* ExpressParser::GeneralizedTypesContext::generalAggregationTypes() {
  return getRuleContext<ExpressParser::GeneralAggregationTypesContext>(0);
}

ExpressParser::GenericEntityTypeContext* ExpressParser::GeneralizedTypesContext::genericEntityType() {
  return getRuleContext<ExpressParser::GenericEntityTypeContext>(0);
}

ExpressParser::GenericTypeContext* ExpressParser::GeneralizedTypesContext::genericType() {
  return getRuleContext<ExpressParser::GenericTypeContext>(0);
}


size_t ExpressParser::GeneralizedTypesContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralizedTypes;
}

void ExpressParser::GeneralizedTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralizedTypes(this);
}

void ExpressParser::GeneralizedTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralizedTypes(this);
}


antlrcpp::Any ExpressParser::GeneralizedTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralizedTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralizedTypesContext* ExpressParser::generalizedTypes() {
  GeneralizedTypesContext *_localctx = _tracker.createInstance<GeneralizedTypesContext>(_ctx, getState());
  enterRule(_localctx, 148, ExpressParser::RuleGeneralizedTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(845);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::AGGREGATE: {
        enterOuterAlt(_localctx, 1);
        setState(841);
        aggregateType();
        break;
      }

      case ExpressParser::ARRAY:
      case ExpressParser::BAG:
      case ExpressParser::LIST:
      case ExpressParser::SET: {
        enterOuterAlt(_localctx, 2);
        setState(842);
        generalAggregationTypes();
        break;
      }

      case ExpressParser::GENERIC_ENTITY: {
        enterOuterAlt(_localctx, 3);
        setState(843);
        genericEntityType();
        break;
      }

      case ExpressParser::GENERIC: {
        enterOuterAlt(_localctx, 4);
        setState(844);
        genericType();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralAggregationTypesContext ------------------------------------------------------------------

ExpressParser::GeneralAggregationTypesContext::GeneralAggregationTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::GeneralArrayTypeContext* ExpressParser::GeneralAggregationTypesContext::generalArrayType() {
  return getRuleContext<ExpressParser::GeneralArrayTypeContext>(0);
}

ExpressParser::GeneralBagTypeContext* ExpressParser::GeneralAggregationTypesContext::generalBagType() {
  return getRuleContext<ExpressParser::GeneralBagTypeContext>(0);
}

ExpressParser::GeneralListTypeContext* ExpressParser::GeneralAggregationTypesContext::generalListType() {
  return getRuleContext<ExpressParser::GeneralListTypeContext>(0);
}

ExpressParser::GeneralSetTypeContext* ExpressParser::GeneralAggregationTypesContext::generalSetType() {
  return getRuleContext<ExpressParser::GeneralSetTypeContext>(0);
}


size_t ExpressParser::GeneralAggregationTypesContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralAggregationTypes;
}

void ExpressParser::GeneralAggregationTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralAggregationTypes(this);
}

void ExpressParser::GeneralAggregationTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralAggregationTypes(this);
}


antlrcpp::Any ExpressParser::GeneralAggregationTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralAggregationTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralAggregationTypesContext* ExpressParser::generalAggregationTypes() {
  GeneralAggregationTypesContext *_localctx = _tracker.createInstance<GeneralAggregationTypesContext>(_ctx, getState());
  enterRule(_localctx, 150, ExpressParser::RuleGeneralAggregationTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(851);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ARRAY: {
        enterOuterAlt(_localctx, 1);
        setState(847);
        generalArrayType();
        break;
      }

      case ExpressParser::BAG: {
        enterOuterAlt(_localctx, 2);
        setState(848);
        generalBagType();
        break;
      }

      case ExpressParser::LIST: {
        enterOuterAlt(_localctx, 3);
        setState(849);
        generalListType();
        break;
      }

      case ExpressParser::SET: {
        enterOuterAlt(_localctx, 4);
        setState(850);
        generalSetType();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralArrayTypeContext ------------------------------------------------------------------

ExpressParser::GeneralArrayTypeContext::GeneralArrayTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GeneralArrayTypeContext::ARRAY() {
  return getToken(ExpressParser::ARRAY, 0);
}

tree::TerminalNode* ExpressParser::GeneralArrayTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::ParameterTypeContext* ExpressParser::GeneralArrayTypeContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::GeneralArrayTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}

tree::TerminalNode* ExpressParser::GeneralArrayTypeContext::OPTIONAL() {
  return getToken(ExpressParser::OPTIONAL, 0);
}

tree::TerminalNode* ExpressParser::GeneralArrayTypeContext::UNIQUE() {
  return getToken(ExpressParser::UNIQUE, 0);
}


size_t ExpressParser::GeneralArrayTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralArrayType;
}

void ExpressParser::GeneralArrayTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralArrayType(this);
}

void ExpressParser::GeneralArrayTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralArrayType(this);
}


antlrcpp::Any ExpressParser::GeneralArrayTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralArrayType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralArrayTypeContext* ExpressParser::generalArrayType() {
  GeneralArrayTypeContext *_localctx = _tracker.createInstance<GeneralArrayTypeContext>(_ctx, getState());
  enterRule(_localctx, 152, ExpressParser::RuleGeneralArrayType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(853);
    match(ExpressParser::ARRAY);
    setState(855);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(854);
      boundSpec();
    }
    setState(857);
    match(ExpressParser::OF);
    setState(859);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::OPTIONAL) {
      setState(858);
      match(ExpressParser::OPTIONAL);
    }
    setState(862);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNIQUE) {
      setState(861);
      match(ExpressParser::UNIQUE);
    }
    setState(864);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralBagTypeContext ------------------------------------------------------------------

ExpressParser::GeneralBagTypeContext::GeneralBagTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GeneralBagTypeContext::BAG() {
  return getToken(ExpressParser::BAG, 0);
}

tree::TerminalNode* ExpressParser::GeneralBagTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::ParameterTypeContext* ExpressParser::GeneralBagTypeContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::GeneralBagTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}


size_t ExpressParser::GeneralBagTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralBagType;
}

void ExpressParser::GeneralBagTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralBagType(this);
}

void ExpressParser::GeneralBagTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralBagType(this);
}


antlrcpp::Any ExpressParser::GeneralBagTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralBagType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralBagTypeContext* ExpressParser::generalBagType() {
  GeneralBagTypeContext *_localctx = _tracker.createInstance<GeneralBagTypeContext>(_ctx, getState());
  enterRule(_localctx, 154, ExpressParser::RuleGeneralBagType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(866);
    match(ExpressParser::BAG);
    setState(868);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(867);
      boundSpec();
    }
    setState(870);
    match(ExpressParser::OF);
    setState(871);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralListTypeContext ------------------------------------------------------------------

ExpressParser::GeneralListTypeContext::GeneralListTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GeneralListTypeContext::LIST() {
  return getToken(ExpressParser::LIST, 0);
}

tree::TerminalNode* ExpressParser::GeneralListTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::ParameterTypeContext* ExpressParser::GeneralListTypeContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::GeneralListTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}

tree::TerminalNode* ExpressParser::GeneralListTypeContext::UNIQUE() {
  return getToken(ExpressParser::UNIQUE, 0);
}


size_t ExpressParser::GeneralListTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralListType;
}

void ExpressParser::GeneralListTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralListType(this);
}

void ExpressParser::GeneralListTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralListType(this);
}


antlrcpp::Any ExpressParser::GeneralListTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralListType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralListTypeContext* ExpressParser::generalListType() {
  GeneralListTypeContext *_localctx = _tracker.createInstance<GeneralListTypeContext>(_ctx, getState());
  enterRule(_localctx, 156, ExpressParser::RuleGeneralListType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(873);
    match(ExpressParser::LIST);
    setState(875);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(874);
      boundSpec();
    }
    setState(877);
    match(ExpressParser::OF);
    setState(879);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNIQUE) {
      setState(878);
      match(ExpressParser::UNIQUE);
    }
    setState(881);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralRefContext ------------------------------------------------------------------

ExpressParser::GeneralRefContext::GeneralRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ParameterRefContext* ExpressParser::GeneralRefContext::parameterRef() {
  return getRuleContext<ExpressParser::ParameterRefContext>(0);
}

ExpressParser::VariableIdContext* ExpressParser::GeneralRefContext::variableId() {
  return getRuleContext<ExpressParser::VariableIdContext>(0);
}


size_t ExpressParser::GeneralRefContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralRef;
}

void ExpressParser::GeneralRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralRef(this);
}

void ExpressParser::GeneralRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralRef(this);
}


antlrcpp::Any ExpressParser::GeneralRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralRefContext* ExpressParser::generalRef() {
  GeneralRefContext *_localctx = _tracker.createInstance<GeneralRefContext>(_ctx, getState());
  enterRule(_localctx, 158, ExpressParser::RuleGeneralRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(885);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 59, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(883);
      parameterRef();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(884);
      variableId();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GeneralSetTypeContext ------------------------------------------------------------------

ExpressParser::GeneralSetTypeContext::GeneralSetTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GeneralSetTypeContext::SET() {
  return getToken(ExpressParser::SET, 0);
}

tree::TerminalNode* ExpressParser::GeneralSetTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::ParameterTypeContext* ExpressParser::GeneralSetTypeContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::GeneralSetTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}


size_t ExpressParser::GeneralSetTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGeneralSetType;
}

void ExpressParser::GeneralSetTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGeneralSetType(this);
}

void ExpressParser::GeneralSetTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGeneralSetType(this);
}


antlrcpp::Any ExpressParser::GeneralSetTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGeneralSetType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GeneralSetTypeContext* ExpressParser::generalSetType() {
  GeneralSetTypeContext *_localctx = _tracker.createInstance<GeneralSetTypeContext>(_ctx, getState());
  enterRule(_localctx, 160, ExpressParser::RuleGeneralSetType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(887);
    match(ExpressParser::SET);
    setState(889);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(888);
      boundSpec();
    }
    setState(891);
    match(ExpressParser::OF);
    setState(892);
    parameterType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GenericEntityTypeContext ------------------------------------------------------------------

ExpressParser::GenericEntityTypeContext::GenericEntityTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GenericEntityTypeContext::GENERIC_ENTITY() {
  return getToken(ExpressParser::GENERIC_ENTITY, 0);
}

ExpressParser::TypeLabelContext* ExpressParser::GenericEntityTypeContext::typeLabel() {
  return getRuleContext<ExpressParser::TypeLabelContext>(0);
}


size_t ExpressParser::GenericEntityTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGenericEntityType;
}

void ExpressParser::GenericEntityTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGenericEntityType(this);
}

void ExpressParser::GenericEntityTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGenericEntityType(this);
}


antlrcpp::Any ExpressParser::GenericEntityTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGenericEntityType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GenericEntityTypeContext* ExpressParser::genericEntityType() {
  GenericEntityTypeContext *_localctx = _tracker.createInstance<GenericEntityTypeContext>(_ctx, getState());
  enterRule(_localctx, 162, ExpressParser::RuleGenericEntityType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(894);
    match(ExpressParser::GENERIC_ENTITY);
    setState(897);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__8) {
      setState(895);
      match(ExpressParser::T__8);
      setState(896);
      typeLabel();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GenericTypeContext ------------------------------------------------------------------

ExpressParser::GenericTypeContext::GenericTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::GenericTypeContext::GENERIC() {
  return getToken(ExpressParser::GENERIC, 0);
}

ExpressParser::TypeLabelContext* ExpressParser::GenericTypeContext::typeLabel() {
  return getRuleContext<ExpressParser::TypeLabelContext>(0);
}


size_t ExpressParser::GenericTypeContext::getRuleIndex() const {
  return ExpressParser::RuleGenericType;
}

void ExpressParser::GenericTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGenericType(this);
}

void ExpressParser::GenericTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGenericType(this);
}


antlrcpp::Any ExpressParser::GenericTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGenericType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GenericTypeContext* ExpressParser::genericType() {
  GenericTypeContext *_localctx = _tracker.createInstance<GenericTypeContext>(_ctx, getState());
  enterRule(_localctx, 164, ExpressParser::RuleGenericType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(899);
    match(ExpressParser::GENERIC);
    setState(902);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__8) {
      setState(900);
      match(ExpressParser::T__8);
      setState(901);
      typeLabel();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- GroupQualifierContext ------------------------------------------------------------------

ExpressParser::GroupQualifierContext::GroupQualifierContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::GroupQualifierContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}


size_t ExpressParser::GroupQualifierContext::getRuleIndex() const {
  return ExpressParser::RuleGroupQualifier;
}

void ExpressParser::GroupQualifierContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterGroupQualifier(this);
}

void ExpressParser::GroupQualifierContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitGroupQualifier(this);
}


antlrcpp::Any ExpressParser::GroupQualifierContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitGroupQualifier(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::GroupQualifierContext* ExpressParser::groupQualifier() {
  GroupQualifierContext *_localctx = _tracker.createInstance<GroupQualifierContext>(_ctx, getState());
  enterRule(_localctx, 166, ExpressParser::RuleGroupQualifier);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(904);
    match(ExpressParser::T__13);
    setState(905);
    entityRef();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IfStmtContext ------------------------------------------------------------------

ExpressParser::IfStmtContext::IfStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::IfStmtContext::IF() {
  return getToken(ExpressParser::IF, 0);
}

ExpressParser::LogicalExpressionContext* ExpressParser::IfStmtContext::logicalExpression() {
  return getRuleContext<ExpressParser::LogicalExpressionContext>(0);
}

tree::TerminalNode* ExpressParser::IfStmtContext::THEN() {
  return getToken(ExpressParser::THEN, 0);
}

ExpressParser::IfStmtStatementsContext* ExpressParser::IfStmtContext::ifStmtStatements() {
  return getRuleContext<ExpressParser::IfStmtStatementsContext>(0);
}

tree::TerminalNode* ExpressParser::IfStmtContext::END_IF() {
  return getToken(ExpressParser::END_IF, 0);
}

tree::TerminalNode* ExpressParser::IfStmtContext::ELSE() {
  return getToken(ExpressParser::ELSE, 0);
}

ExpressParser::IfStmtElseStatementsContext* ExpressParser::IfStmtContext::ifStmtElseStatements() {
  return getRuleContext<ExpressParser::IfStmtElseStatementsContext>(0);
}


size_t ExpressParser::IfStmtContext::getRuleIndex() const {
  return ExpressParser::RuleIfStmt;
}

void ExpressParser::IfStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIfStmt(this);
}

void ExpressParser::IfStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIfStmt(this);
}


antlrcpp::Any ExpressParser::IfStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIfStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IfStmtContext* ExpressParser::ifStmt() {
  IfStmtContext *_localctx = _tracker.createInstance<IfStmtContext>(_ctx, getState());
  enterRule(_localctx, 168, ExpressParser::RuleIfStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(907);
    match(ExpressParser::IF);
    setState(908);
    logicalExpression();
    setState(909);
    match(ExpressParser::THEN);
    setState(910);
    ifStmtStatements();
    setState(913);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::ELSE) {
      setState(911);
      match(ExpressParser::ELSE);
      setState(912);
      ifStmtElseStatements();
    }
    setState(915);
    match(ExpressParser::END_IF);
    setState(916);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IfStmtStatementsContext ------------------------------------------------------------------

ExpressParser::IfStmtStatementsContext::IfStmtStatementsContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::StmtContext *> ExpressParser::IfStmtStatementsContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::IfStmtStatementsContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}


size_t ExpressParser::IfStmtStatementsContext::getRuleIndex() const {
  return ExpressParser::RuleIfStmtStatements;
}

void ExpressParser::IfStmtStatementsContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIfStmtStatements(this);
}

void ExpressParser::IfStmtStatementsContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIfStmtStatements(this);
}


antlrcpp::Any ExpressParser::IfStmtStatementsContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIfStmtStatements(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IfStmtStatementsContext* ExpressParser::ifStmtStatements() {
  IfStmtStatementsContext *_localctx = _tracker.createInstance<IfStmtStatementsContext>(_ctx, getState());
  enterRule(_localctx, 170, ExpressParser::RuleIfStmtStatements);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(918);
    stmt();
    setState(922);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(919);
      stmt();
      setState(924);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IfStmtElseStatementsContext ------------------------------------------------------------------

ExpressParser::IfStmtElseStatementsContext::IfStmtElseStatementsContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::StmtContext *> ExpressParser::IfStmtElseStatementsContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::IfStmtElseStatementsContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}


size_t ExpressParser::IfStmtElseStatementsContext::getRuleIndex() const {
  return ExpressParser::RuleIfStmtElseStatements;
}

void ExpressParser::IfStmtElseStatementsContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIfStmtElseStatements(this);
}

void ExpressParser::IfStmtElseStatementsContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIfStmtElseStatements(this);
}


antlrcpp::Any ExpressParser::IfStmtElseStatementsContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIfStmtElseStatements(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IfStmtElseStatementsContext* ExpressParser::ifStmtElseStatements() {
  IfStmtElseStatementsContext *_localctx = _tracker.createInstance<IfStmtElseStatementsContext>(_ctx, getState());
  enterRule(_localctx, 172, ExpressParser::RuleIfStmtElseStatements);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(925);
    stmt();
    setState(929);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(926);
      stmt();
      setState(931);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IncrementContext ------------------------------------------------------------------

ExpressParser::IncrementContext::IncrementContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::IncrementContext::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::IncrementContext::getRuleIndex() const {
  return ExpressParser::RuleIncrement;
}

void ExpressParser::IncrementContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIncrement(this);
}

void ExpressParser::IncrementContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIncrement(this);
}


antlrcpp::Any ExpressParser::IncrementContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIncrement(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IncrementContext* ExpressParser::increment() {
  IncrementContext *_localctx = _tracker.createInstance<IncrementContext>(_ctx, getState());
  enterRule(_localctx, 174, ExpressParser::RuleIncrement);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(932);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IncrementControlContext ------------------------------------------------------------------

ExpressParser::IncrementControlContext::IncrementControlContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::VariableIdContext* ExpressParser::IncrementControlContext::variableId() {
  return getRuleContext<ExpressParser::VariableIdContext>(0);
}

ExpressParser::Bound1Context* ExpressParser::IncrementControlContext::bound1() {
  return getRuleContext<ExpressParser::Bound1Context>(0);
}

tree::TerminalNode* ExpressParser::IncrementControlContext::TO() {
  return getToken(ExpressParser::TO, 0);
}

ExpressParser::Bound2Context* ExpressParser::IncrementControlContext::bound2() {
  return getRuleContext<ExpressParser::Bound2Context>(0);
}

tree::TerminalNode* ExpressParser::IncrementControlContext::BY() {
  return getToken(ExpressParser::BY, 0);
}

ExpressParser::IncrementContext* ExpressParser::IncrementControlContext::increment() {
  return getRuleContext<ExpressParser::IncrementContext>(0);
}


size_t ExpressParser::IncrementControlContext::getRuleIndex() const {
  return ExpressParser::RuleIncrementControl;
}

void ExpressParser::IncrementControlContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIncrementControl(this);
}

void ExpressParser::IncrementControlContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIncrementControl(this);
}


antlrcpp::Any ExpressParser::IncrementControlContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIncrementControl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IncrementControlContext* ExpressParser::incrementControl() {
  IncrementControlContext *_localctx = _tracker.createInstance<IncrementControlContext>(_ctx, getState());
  enterRule(_localctx, 176, ExpressParser::RuleIncrementControl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(934);
    variableId();
    setState(935);
    match(ExpressParser::T__9);
    setState(936);
    bound1();
    setState(937);
    match(ExpressParser::TO);
    setState(938);
    bound2();
    setState(941);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::BY) {
      setState(939);
      match(ExpressParser::BY);
      setState(940);
      increment();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IndexContext ------------------------------------------------------------------

ExpressParser::IndexContext::IndexContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::IndexContext::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::IndexContext::getRuleIndex() const {
  return ExpressParser::RuleIndex;
}

void ExpressParser::IndexContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIndex(this);
}

void ExpressParser::IndexContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIndex(this);
}


antlrcpp::Any ExpressParser::IndexContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIndex(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IndexContext* ExpressParser::index() {
  IndexContext *_localctx = _tracker.createInstance<IndexContext>(_ctx, getState());
  enterRule(_localctx, 178, ExpressParser::RuleIndex);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(943);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Index1Context ------------------------------------------------------------------

ExpressParser::Index1Context::Index1Context(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::IndexContext* ExpressParser::Index1Context::index() {
  return getRuleContext<ExpressParser::IndexContext>(0);
}


size_t ExpressParser::Index1Context::getRuleIndex() const {
  return ExpressParser::RuleIndex1;
}

void ExpressParser::Index1Context::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIndex1(this);
}

void ExpressParser::Index1Context::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIndex1(this);
}


antlrcpp::Any ExpressParser::Index1Context::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIndex1(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::Index1Context* ExpressParser::index1() {
  Index1Context *_localctx = _tracker.createInstance<Index1Context>(_ctx, getState());
  enterRule(_localctx, 180, ExpressParser::RuleIndex1);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(945);
    index();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Index2Context ------------------------------------------------------------------

ExpressParser::Index2Context::Index2Context(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::IndexContext* ExpressParser::Index2Context::index() {
  return getRuleContext<ExpressParser::IndexContext>(0);
}


size_t ExpressParser::Index2Context::getRuleIndex() const {
  return ExpressParser::RuleIndex2;
}

void ExpressParser::Index2Context::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIndex2(this);
}

void ExpressParser::Index2Context::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIndex2(this);
}


antlrcpp::Any ExpressParser::Index2Context::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIndex2(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::Index2Context* ExpressParser::index2() {
  Index2Context *_localctx = _tracker.createInstance<Index2Context>(_ctx, getState());
  enterRule(_localctx, 182, ExpressParser::RuleIndex2);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(947);
    index();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IndexQualifierContext ------------------------------------------------------------------

ExpressParser::IndexQualifierContext::IndexQualifierContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::Index1Context* ExpressParser::IndexQualifierContext::index1() {
  return getRuleContext<ExpressParser::Index1Context>(0);
}

ExpressParser::Index2Context* ExpressParser::IndexQualifierContext::index2() {
  return getRuleContext<ExpressParser::Index2Context>(0);
}


size_t ExpressParser::IndexQualifierContext::getRuleIndex() const {
  return ExpressParser::RuleIndexQualifier;
}

void ExpressParser::IndexQualifierContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIndexQualifier(this);
}

void ExpressParser::IndexQualifierContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIndexQualifier(this);
}


antlrcpp::Any ExpressParser::IndexQualifierContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIndexQualifier(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IndexQualifierContext* ExpressParser::indexQualifier() {
  IndexQualifierContext *_localctx = _tracker.createInstance<IndexQualifierContext>(_ctx, getState());
  enterRule(_localctx, 184, ExpressParser::RuleIndexQualifier);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(949);
    match(ExpressParser::T__6);
    setState(950);
    index1();
    setState(953);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__8) {
      setState(951);
      match(ExpressParser::T__8);
      setState(952);
      index2();
    }
    setState(955);
    match(ExpressParser::T__7);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InstantiableTypeContext ------------------------------------------------------------------

ExpressParser::InstantiableTypeContext::InstantiableTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConcreteTypesContext* ExpressParser::InstantiableTypeContext::concreteTypes() {
  return getRuleContext<ExpressParser::ConcreteTypesContext>(0);
}

ExpressParser::EntityRefContext* ExpressParser::InstantiableTypeContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}


size_t ExpressParser::InstantiableTypeContext::getRuleIndex() const {
  return ExpressParser::RuleInstantiableType;
}

void ExpressParser::InstantiableTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInstantiableType(this);
}

void ExpressParser::InstantiableTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInstantiableType(this);
}


antlrcpp::Any ExpressParser::InstantiableTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInstantiableType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::InstantiableTypeContext* ExpressParser::instantiableType() {
  InstantiableTypeContext *_localctx = _tracker.createInstance<InstantiableTypeContext>(_ctx, getState());
  enterRule(_localctx, 186, ExpressParser::RuleInstantiableType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(959);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 68, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(957);
      concreteTypes();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(958);
      entityRef();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntegerTypeContext ------------------------------------------------------------------

ExpressParser::IntegerTypeContext::IntegerTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::IntegerTypeContext::INTEGER() {
  return getToken(ExpressParser::INTEGER, 0);
}


size_t ExpressParser::IntegerTypeContext::getRuleIndex() const {
  return ExpressParser::RuleIntegerType;
}

void ExpressParser::IntegerTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIntegerType(this);
}

void ExpressParser::IntegerTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIntegerType(this);
}


antlrcpp::Any ExpressParser::IntegerTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIntegerType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntegerTypeContext* ExpressParser::integerType() {
  IntegerTypeContext *_localctx = _tracker.createInstance<IntegerTypeContext>(_ctx, getState());
  enterRule(_localctx, 188, ExpressParser::RuleIntegerType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(961);
    match(ExpressParser::INTEGER);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InterfaceSpecificationContext ------------------------------------------------------------------

ExpressParser::InterfaceSpecificationContext::InterfaceSpecificationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ReferenceClauseContext* ExpressParser::InterfaceSpecificationContext::referenceClause() {
  return getRuleContext<ExpressParser::ReferenceClauseContext>(0);
}

ExpressParser::UseClauseContext* ExpressParser::InterfaceSpecificationContext::useClause() {
  return getRuleContext<ExpressParser::UseClauseContext>(0);
}


size_t ExpressParser::InterfaceSpecificationContext::getRuleIndex() const {
  return ExpressParser::RuleInterfaceSpecification;
}

void ExpressParser::InterfaceSpecificationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInterfaceSpecification(this);
}

void ExpressParser::InterfaceSpecificationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInterfaceSpecification(this);
}


antlrcpp::Any ExpressParser::InterfaceSpecificationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInterfaceSpecification(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::InterfaceSpecificationContext* ExpressParser::interfaceSpecification() {
  InterfaceSpecificationContext *_localctx = _tracker.createInstance<InterfaceSpecificationContext>(_ctx, getState());
  enterRule(_localctx, 190, ExpressParser::RuleInterfaceSpecification);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(965);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::REFERENCE: {
        enterOuterAlt(_localctx, 1);
        setState(963);
        referenceClause();
        break;
      }

      case ExpressParser::USE: {
        enterOuterAlt(_localctx, 2);
        setState(964);
        useClause();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntervalContext ------------------------------------------------------------------

ExpressParser::IntervalContext::IntervalContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::IntervalLowContext* ExpressParser::IntervalContext::intervalLow() {
  return getRuleContext<ExpressParser::IntervalLowContext>(0);
}

std::vector<ExpressParser::IntervalOpContext *> ExpressParser::IntervalContext::intervalOp() {
  return getRuleContexts<ExpressParser::IntervalOpContext>();
}

ExpressParser::IntervalOpContext* ExpressParser::IntervalContext::intervalOp(size_t i) {
  return getRuleContext<ExpressParser::IntervalOpContext>(i);
}

ExpressParser::IntervalItemContext* ExpressParser::IntervalContext::intervalItem() {
  return getRuleContext<ExpressParser::IntervalItemContext>(0);
}

ExpressParser::IntervalHighContext* ExpressParser::IntervalContext::intervalHigh() {
  return getRuleContext<ExpressParser::IntervalHighContext>(0);
}


size_t ExpressParser::IntervalContext::getRuleIndex() const {
  return ExpressParser::RuleInterval;
}

void ExpressParser::IntervalContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInterval(this);
}

void ExpressParser::IntervalContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInterval(this);
}


antlrcpp::Any ExpressParser::IntervalContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInterval(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntervalContext* ExpressParser::interval() {
  IntervalContext *_localctx = _tracker.createInstance<IntervalContext>(_ctx, getState());
  enterRule(_localctx, 192, ExpressParser::RuleInterval);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(967);
    match(ExpressParser::T__14);
    setState(968);
    intervalLow();
    setState(969);
    intervalOp();
    setState(970);
    intervalItem();
    setState(971);
    intervalOp();
    setState(972);
    intervalHigh();
    setState(973);
    match(ExpressParser::T__15);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntervalHighContext ------------------------------------------------------------------

ExpressParser::IntervalHighContext::IntervalHighContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SimpleExpressionContext* ExpressParser::IntervalHighContext::simpleExpression() {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(0);
}


size_t ExpressParser::IntervalHighContext::getRuleIndex() const {
  return ExpressParser::RuleIntervalHigh;
}

void ExpressParser::IntervalHighContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIntervalHigh(this);
}

void ExpressParser::IntervalHighContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIntervalHigh(this);
}


antlrcpp::Any ExpressParser::IntervalHighContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIntervalHigh(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntervalHighContext* ExpressParser::intervalHigh() {
  IntervalHighContext *_localctx = _tracker.createInstance<IntervalHighContext>(_ctx, getState());
  enterRule(_localctx, 194, ExpressParser::RuleIntervalHigh);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(975);
    simpleExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntervalItemContext ------------------------------------------------------------------

ExpressParser::IntervalItemContext::IntervalItemContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SimpleExpressionContext* ExpressParser::IntervalItemContext::simpleExpression() {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(0);
}


size_t ExpressParser::IntervalItemContext::getRuleIndex() const {
  return ExpressParser::RuleIntervalItem;
}

void ExpressParser::IntervalItemContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIntervalItem(this);
}

void ExpressParser::IntervalItemContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIntervalItem(this);
}


antlrcpp::Any ExpressParser::IntervalItemContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIntervalItem(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntervalItemContext* ExpressParser::intervalItem() {
  IntervalItemContext *_localctx = _tracker.createInstance<IntervalItemContext>(_ctx, getState());
  enterRule(_localctx, 196, ExpressParser::RuleIntervalItem);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(977);
    simpleExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntervalLowContext ------------------------------------------------------------------

ExpressParser::IntervalLowContext::IntervalLowContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SimpleExpressionContext* ExpressParser::IntervalLowContext::simpleExpression() {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(0);
}


size_t ExpressParser::IntervalLowContext::getRuleIndex() const {
  return ExpressParser::RuleIntervalLow;
}

void ExpressParser::IntervalLowContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIntervalLow(this);
}

void ExpressParser::IntervalLowContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIntervalLow(this);
}


antlrcpp::Any ExpressParser::IntervalLowContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIntervalLow(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntervalLowContext* ExpressParser::intervalLow() {
  IntervalLowContext *_localctx = _tracker.createInstance<IntervalLowContext>(_ctx, getState());
  enterRule(_localctx, 198, ExpressParser::RuleIntervalLow);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(979);
    simpleExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IntervalOpContext ------------------------------------------------------------------

ExpressParser::IntervalOpContext::IntervalOpContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t ExpressParser::IntervalOpContext::getRuleIndex() const {
  return ExpressParser::RuleIntervalOp;
}

void ExpressParser::IntervalOpContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterIntervalOp(this);
}

void ExpressParser::IntervalOpContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitIntervalOp(this);
}


antlrcpp::Any ExpressParser::IntervalOpContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitIntervalOp(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::IntervalOpContext* ExpressParser::intervalOp() {
  IntervalOpContext *_localctx = _tracker.createInstance<IntervalOpContext>(_ctx, getState());
  enterRule(_localctx, 200, ExpressParser::RuleIntervalOp);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(981);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::T__16

    || _la == ExpressParser::T__17)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InverseAttrContext ------------------------------------------------------------------

ExpressParser::InverseAttrContext::InverseAttrContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeDeclContext* ExpressParser::InverseAttrContext::attributeDecl() {
  return getRuleContext<ExpressParser::AttributeDeclContext>(0);
}

ExpressParser::InverseAttrTypeContext* ExpressParser::InverseAttrContext::inverseAttrType() {
  return getRuleContext<ExpressParser::InverseAttrTypeContext>(0);
}

tree::TerminalNode* ExpressParser::InverseAttrContext::FOR() {
  return getToken(ExpressParser::FOR, 0);
}

ExpressParser::AttributeRefContext* ExpressParser::InverseAttrContext::attributeRef() {
  return getRuleContext<ExpressParser::AttributeRefContext>(0);
}

ExpressParser::EntityRefContext* ExpressParser::InverseAttrContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}


size_t ExpressParser::InverseAttrContext::getRuleIndex() const {
  return ExpressParser::RuleInverseAttr;
}

void ExpressParser::InverseAttrContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInverseAttr(this);
}

void ExpressParser::InverseAttrContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInverseAttr(this);
}


antlrcpp::Any ExpressParser::InverseAttrContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInverseAttr(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::InverseAttrContext* ExpressParser::inverseAttr() {
  InverseAttrContext *_localctx = _tracker.createInstance<InverseAttrContext>(_ctx, getState());
  enterRule(_localctx, 202, ExpressParser::RuleInverseAttr);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(983);
    attributeDecl();
    setState(984);
    match(ExpressParser::T__8);
    setState(985);
    inverseAttrType();
    setState(986);
    match(ExpressParser::FOR);
    setState(990);
    _errHandler->sync(this);

    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 70, _ctx)) {
    case 1: {
      setState(987);
      entityRef();
      setState(988);
      match(ExpressParser::T__10);
      break;
    }

    }
    setState(992);
    attributeRef();
    setState(993);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InverseAttrTypeContext ------------------------------------------------------------------

ExpressParser::InverseAttrTypeContext::InverseAttrTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::InverseAttrTypeContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}

tree::TerminalNode* ExpressParser::InverseAttrTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

tree::TerminalNode* ExpressParser::InverseAttrTypeContext::SET() {
  return getToken(ExpressParser::SET, 0);
}

tree::TerminalNode* ExpressParser::InverseAttrTypeContext::BAG() {
  return getToken(ExpressParser::BAG, 0);
}

ExpressParser::BoundSpecContext* ExpressParser::InverseAttrTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}


size_t ExpressParser::InverseAttrTypeContext::getRuleIndex() const {
  return ExpressParser::RuleInverseAttrType;
}

void ExpressParser::InverseAttrTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInverseAttrType(this);
}

void ExpressParser::InverseAttrTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInverseAttrType(this);
}


antlrcpp::Any ExpressParser::InverseAttrTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInverseAttrType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::InverseAttrTypeContext* ExpressParser::inverseAttrType() {
  InverseAttrTypeContext *_localctx = _tracker.createInstance<InverseAttrTypeContext>(_ctx, getState());
  enterRule(_localctx, 204, ExpressParser::RuleInverseAttrType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1000);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::BAG || _la == ExpressParser::SET) {
      setState(995);
      _la = _input->LA(1);
      if (!(_la == ExpressParser::BAG || _la == ExpressParser::SET)) {
      _errHandler->recoverInline(this);
      }
      else {
        _errHandler->reportMatch(this);
        consume();
      }
      setState(997);
      _errHandler->sync(this);

      _la = _input->LA(1);
      if (_la == ExpressParser::T__6) {
        setState(996);
        boundSpec();
      }
      setState(999);
      match(ExpressParser::OF);
    }
    setState(1002);
    entityRef();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InverseClauseContext ------------------------------------------------------------------

ExpressParser::InverseClauseContext::InverseClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::InverseClauseContext::INVERSE() {
  return getToken(ExpressParser::INVERSE, 0);
}

std::vector<ExpressParser::InverseAttrContext *> ExpressParser::InverseClauseContext::inverseAttr() {
  return getRuleContexts<ExpressParser::InverseAttrContext>();
}

ExpressParser::InverseAttrContext* ExpressParser::InverseClauseContext::inverseAttr(size_t i) {
  return getRuleContext<ExpressParser::InverseAttrContext>(i);
}


size_t ExpressParser::InverseClauseContext::getRuleIndex() const {
  return ExpressParser::RuleInverseClause;
}

void ExpressParser::InverseClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterInverseClause(this);
}

void ExpressParser::InverseClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitInverseClause(this);
}


antlrcpp::Any ExpressParser::InverseClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitInverseClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::InverseClauseContext* ExpressParser::inverseClause() {
  InverseClauseContext *_localctx = _tracker.createInstance<InverseClauseContext>(_ctx, getState());
  enterRule(_localctx, 206, ExpressParser::RuleInverseClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1004);
    match(ExpressParser::INVERSE);
    setState(1005);
    inverseAttr();
    setState(1009);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SELF

    || _la == ExpressParser::SimpleId) {
      setState(1006);
      inverseAttr();
      setState(1011);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ListTypeContext ------------------------------------------------------------------

ExpressParser::ListTypeContext::ListTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ListTypeContext::LIST() {
  return getToken(ExpressParser::LIST, 0);
}

tree::TerminalNode* ExpressParser::ListTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::InstantiableTypeContext* ExpressParser::ListTypeContext::instantiableType() {
  return getRuleContext<ExpressParser::InstantiableTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::ListTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}

tree::TerminalNode* ExpressParser::ListTypeContext::UNIQUE() {
  return getToken(ExpressParser::UNIQUE, 0);
}


size_t ExpressParser::ListTypeContext::getRuleIndex() const {
  return ExpressParser::RuleListType;
}

void ExpressParser::ListTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterListType(this);
}

void ExpressParser::ListTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitListType(this);
}


antlrcpp::Any ExpressParser::ListTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitListType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ListTypeContext* ExpressParser::listType() {
  ListTypeContext *_localctx = _tracker.createInstance<ListTypeContext>(_ctx, getState());
  enterRule(_localctx, 208, ExpressParser::RuleListType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1012);
    match(ExpressParser::LIST);
    setState(1014);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(1013);
      boundSpec();
    }
    setState(1016);
    match(ExpressParser::OF);
    setState(1018);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNIQUE) {
      setState(1017);
      match(ExpressParser::UNIQUE);
    }
    setState(1020);
    instantiableType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LiteralContext ------------------------------------------------------------------

ExpressParser::LiteralContext::LiteralContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::LiteralContext::BinaryLiteral() {
  return getToken(ExpressParser::BinaryLiteral, 0);
}

tree::TerminalNode* ExpressParser::LiteralContext::IntegerLiteral() {
  return getToken(ExpressParser::IntegerLiteral, 0);
}

ExpressParser::LogicalLiteralContext* ExpressParser::LiteralContext::logicalLiteral() {
  return getRuleContext<ExpressParser::LogicalLiteralContext>(0);
}

tree::TerminalNode* ExpressParser::LiteralContext::RealLiteral() {
  return getToken(ExpressParser::RealLiteral, 0);
}

ExpressParser::StringLiteralContext* ExpressParser::LiteralContext::stringLiteral() {
  return getRuleContext<ExpressParser::StringLiteralContext>(0);
}


size_t ExpressParser::LiteralContext::getRuleIndex() const {
  return ExpressParser::RuleLiteral;
}

void ExpressParser::LiteralContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLiteral(this);
}

void ExpressParser::LiteralContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLiteral(this);
}


antlrcpp::Any ExpressParser::LiteralContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLiteral(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LiteralContext* ExpressParser::literal() {
  LiteralContext *_localctx = _tracker.createInstance<LiteralContext>(_ctx, getState());
  enterRule(_localctx, 210, ExpressParser::RuleLiteral);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1027);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::BinaryLiteral: {
        enterOuterAlt(_localctx, 1);
        setState(1022);
        match(ExpressParser::BinaryLiteral);
        break;
      }

      case ExpressParser::IntegerLiteral: {
        enterOuterAlt(_localctx, 2);
        setState(1023);
        match(ExpressParser::IntegerLiteral);
        break;
      }

      case ExpressParser::FALSE:
      case ExpressParser::TRUE:
      case ExpressParser::UNKNOWN: {
        enterOuterAlt(_localctx, 3);
        setState(1024);
        logicalLiteral();
        break;
      }

      case ExpressParser::RealLiteral: {
        enterOuterAlt(_localctx, 4);
        setState(1025);
        match(ExpressParser::RealLiteral);
        break;
      }

      case ExpressParser::EncodedStringLiteral:
      case ExpressParser::SimpleStringLiteral: {
        enterOuterAlt(_localctx, 5);
        setState(1026);
        stringLiteral();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LocalDeclContext ------------------------------------------------------------------

ExpressParser::LocalDeclContext::LocalDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::LocalDeclContext::LOCAL() {
  return getToken(ExpressParser::LOCAL, 0);
}

std::vector<ExpressParser::LocalVariableContext *> ExpressParser::LocalDeclContext::localVariable() {
  return getRuleContexts<ExpressParser::LocalVariableContext>();
}

ExpressParser::LocalVariableContext* ExpressParser::LocalDeclContext::localVariable(size_t i) {
  return getRuleContext<ExpressParser::LocalVariableContext>(i);
}

tree::TerminalNode* ExpressParser::LocalDeclContext::END_LOCAL() {
  return getToken(ExpressParser::END_LOCAL, 0);
}


size_t ExpressParser::LocalDeclContext::getRuleIndex() const {
  return ExpressParser::RuleLocalDecl;
}

void ExpressParser::LocalDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLocalDecl(this);
}

void ExpressParser::LocalDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLocalDecl(this);
}


antlrcpp::Any ExpressParser::LocalDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLocalDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LocalDeclContext* ExpressParser::localDecl() {
  LocalDeclContext *_localctx = _tracker.createInstance<LocalDeclContext>(_ctx, getState());
  enterRule(_localctx, 212, ExpressParser::RuleLocalDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1029);
    match(ExpressParser::LOCAL);
    setState(1030);
    localVariable();
    setState(1034);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SimpleId) {
      setState(1031);
      localVariable();
      setState(1036);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1037);
    match(ExpressParser::END_LOCAL);
    setState(1038);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LocalVariableContext ------------------------------------------------------------------

ExpressParser::LocalVariableContext::LocalVariableContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::VariableIdContext *> ExpressParser::LocalVariableContext::variableId() {
  return getRuleContexts<ExpressParser::VariableIdContext>();
}

ExpressParser::VariableIdContext* ExpressParser::LocalVariableContext::variableId(size_t i) {
  return getRuleContext<ExpressParser::VariableIdContext>(i);
}

ExpressParser::ParameterTypeContext* ExpressParser::LocalVariableContext::parameterType() {
  return getRuleContext<ExpressParser::ParameterTypeContext>(0);
}

ExpressParser::ExpressionContext* ExpressParser::LocalVariableContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::LocalVariableContext::getRuleIndex() const {
  return ExpressParser::RuleLocalVariable;
}

void ExpressParser::LocalVariableContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLocalVariable(this);
}

void ExpressParser::LocalVariableContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLocalVariable(this);
}


antlrcpp::Any ExpressParser::LocalVariableContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLocalVariable(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LocalVariableContext* ExpressParser::localVariable() {
  LocalVariableContext *_localctx = _tracker.createInstance<LocalVariableContext>(_ctx, getState());
  enterRule(_localctx, 214, ExpressParser::RuleLocalVariable);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1040);
    variableId();
    setState(1045);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1041);
      match(ExpressParser::T__2);
      setState(1042);
      variableId();
      setState(1047);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1048);
    match(ExpressParser::T__8);
    setState(1049);
    parameterType();
    setState(1052);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__9) {
      setState(1050);
      match(ExpressParser::T__9);
      setState(1051);
      expression();
    }
    setState(1054);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LogicalExpressionContext ------------------------------------------------------------------

ExpressParser::LogicalExpressionContext::LogicalExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::LogicalExpressionContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::LogicalExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleLogicalExpression;
}

void ExpressParser::LogicalExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLogicalExpression(this);
}

void ExpressParser::LogicalExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLogicalExpression(this);
}


antlrcpp::Any ExpressParser::LogicalExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLogicalExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LogicalExpressionContext* ExpressParser::logicalExpression() {
  LogicalExpressionContext *_localctx = _tracker.createInstance<LogicalExpressionContext>(_ctx, getState());
  enterRule(_localctx, 216, ExpressParser::RuleLogicalExpression);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1056);
    expression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LogicalLiteralContext ------------------------------------------------------------------

ExpressParser::LogicalLiteralContext::LogicalLiteralContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::LogicalLiteralContext::FALSE() {
  return getToken(ExpressParser::FALSE, 0);
}

tree::TerminalNode* ExpressParser::LogicalLiteralContext::TRUE() {
  return getToken(ExpressParser::TRUE, 0);
}

tree::TerminalNode* ExpressParser::LogicalLiteralContext::UNKNOWN() {
  return getToken(ExpressParser::UNKNOWN, 0);
}


size_t ExpressParser::LogicalLiteralContext::getRuleIndex() const {
  return ExpressParser::RuleLogicalLiteral;
}

void ExpressParser::LogicalLiteralContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLogicalLiteral(this);
}

void ExpressParser::LogicalLiteralContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLogicalLiteral(this);
}


antlrcpp::Any ExpressParser::LogicalLiteralContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLogicalLiteral(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LogicalLiteralContext* ExpressParser::logicalLiteral() {
  LogicalLiteralContext *_localctx = _tracker.createInstance<LogicalLiteralContext>(_ctx, getState());
  enterRule(_localctx, 218, ExpressParser::RuleLogicalLiteral);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1058);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::FALSE

    || _la == ExpressParser::TRUE || _la == ExpressParser::UNKNOWN)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- LogicalTypeContext ------------------------------------------------------------------

ExpressParser::LogicalTypeContext::LogicalTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::LogicalTypeContext::LOGICAL() {
  return getToken(ExpressParser::LOGICAL, 0);
}


size_t ExpressParser::LogicalTypeContext::getRuleIndex() const {
  return ExpressParser::RuleLogicalType;
}

void ExpressParser::LogicalTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterLogicalType(this);
}

void ExpressParser::LogicalTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitLogicalType(this);
}


antlrcpp::Any ExpressParser::LogicalTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitLogicalType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::LogicalTypeContext* ExpressParser::logicalType() {
  LogicalTypeContext *_localctx = _tracker.createInstance<LogicalTypeContext>(_ctx, getState());
  enterRule(_localctx, 220, ExpressParser::RuleLogicalType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1060);
    match(ExpressParser::LOGICAL);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- MultiplicationLikeOpContext ------------------------------------------------------------------

ExpressParser::MultiplicationLikeOpContext::MultiplicationLikeOpContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::MultiplicationLikeOpContext::DIV() {
  return getToken(ExpressParser::DIV, 0);
}

tree::TerminalNode* ExpressParser::MultiplicationLikeOpContext::MOD() {
  return getToken(ExpressParser::MOD, 0);
}

tree::TerminalNode* ExpressParser::MultiplicationLikeOpContext::AND() {
  return getToken(ExpressParser::AND, 0);
}


size_t ExpressParser::MultiplicationLikeOpContext::getRuleIndex() const {
  return ExpressParser::RuleMultiplicationLikeOp;
}

void ExpressParser::MultiplicationLikeOpContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterMultiplicationLikeOp(this);
}

void ExpressParser::MultiplicationLikeOpContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitMultiplicationLikeOp(this);
}


antlrcpp::Any ExpressParser::MultiplicationLikeOpContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitMultiplicationLikeOp(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::MultiplicationLikeOpContext* ExpressParser::multiplicationLikeOp() {
  MultiplicationLikeOpContext *_localctx = _tracker.createInstance<MultiplicationLikeOpContext>(_ctx, getState());
  enterRule(_localctx, 222, ExpressParser::RuleMultiplicationLikeOp);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1062);
    _la = _input->LA(1);
    if (!((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__18)
      | (1ULL << ExpressParser::T__19)
      | (1ULL << ExpressParser::T__20)
      | (1ULL << ExpressParser::AND)
      | (1ULL << ExpressParser::DIV))) != 0) || _la == ExpressParser::MOD)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NamedTypesContext ------------------------------------------------------------------

ExpressParser::NamedTypesContext::NamedTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::NamedTypesContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}

ExpressParser::TypeRefContext* ExpressParser::NamedTypesContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}


size_t ExpressParser::NamedTypesContext::getRuleIndex() const {
  return ExpressParser::RuleNamedTypes;
}

void ExpressParser::NamedTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterNamedTypes(this);
}

void ExpressParser::NamedTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitNamedTypes(this);
}


antlrcpp::Any ExpressParser::NamedTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitNamedTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::NamedTypesContext* ExpressParser::namedTypes() {
  NamedTypesContext *_localctx = _tracker.createInstance<NamedTypesContext>(_ctx, getState());
  enterRule(_localctx, 224, ExpressParser::RuleNamedTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1066);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 80, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1064);
      entityRef();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1065);
      typeRef();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NamedTypeOrRenameContext ------------------------------------------------------------------

ExpressParser::NamedTypeOrRenameContext::NamedTypeOrRenameContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NamedTypesContext* ExpressParser::NamedTypeOrRenameContext::namedTypes() {
  return getRuleContext<ExpressParser::NamedTypesContext>(0);
}

tree::TerminalNode* ExpressParser::NamedTypeOrRenameContext::AS() {
  return getToken(ExpressParser::AS, 0);
}

ExpressParser::EntityIdContext* ExpressParser::NamedTypeOrRenameContext::entityId() {
  return getRuleContext<ExpressParser::EntityIdContext>(0);
}

ExpressParser::TypeIdContext* ExpressParser::NamedTypeOrRenameContext::typeId() {
  return getRuleContext<ExpressParser::TypeIdContext>(0);
}


size_t ExpressParser::NamedTypeOrRenameContext::getRuleIndex() const {
  return ExpressParser::RuleNamedTypeOrRename;
}

void ExpressParser::NamedTypeOrRenameContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterNamedTypeOrRename(this);
}

void ExpressParser::NamedTypeOrRenameContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitNamedTypeOrRename(this);
}


antlrcpp::Any ExpressParser::NamedTypeOrRenameContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitNamedTypeOrRename(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::NamedTypeOrRenameContext* ExpressParser::namedTypeOrRename() {
  NamedTypeOrRenameContext *_localctx = _tracker.createInstance<NamedTypeOrRenameContext>(_ctx, getState());
  enterRule(_localctx, 226, ExpressParser::RuleNamedTypeOrRename);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1068);
    namedTypes();
    setState(1074);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::AS) {
      setState(1069);
      match(ExpressParser::AS);
      setState(1072);
      _errHandler->sync(this);
      switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 81, _ctx)) {
      case 1: {
        setState(1070);
        entityId();
        break;
      }

      case 2: {
        setState(1071);
        typeId();
        break;
      }

      }
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NullStmtContext ------------------------------------------------------------------

ExpressParser::NullStmtContext::NullStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t ExpressParser::NullStmtContext::getRuleIndex() const {
  return ExpressParser::RuleNullStmt;
}

void ExpressParser::NullStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterNullStmt(this);
}

void ExpressParser::NullStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitNullStmt(this);
}


antlrcpp::Any ExpressParser::NullStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitNullStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::NullStmtContext* ExpressParser::nullStmt() {
  NullStmtContext *_localctx = _tracker.createInstance<NullStmtContext>(_ctx, getState());
  enterRule(_localctx, 228, ExpressParser::RuleNullStmt);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1076);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NumberTypeContext ------------------------------------------------------------------

ExpressParser::NumberTypeContext::NumberTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::NumberTypeContext::NUMBER() {
  return getToken(ExpressParser::NUMBER, 0);
}


size_t ExpressParser::NumberTypeContext::getRuleIndex() const {
  return ExpressParser::RuleNumberType;
}

void ExpressParser::NumberTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterNumberType(this);
}

void ExpressParser::NumberTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitNumberType(this);
}


antlrcpp::Any ExpressParser::NumberTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitNumberType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::NumberTypeContext* ExpressParser::numberType() {
  NumberTypeContext *_localctx = _tracker.createInstance<NumberTypeContext>(_ctx, getState());
  enterRule(_localctx, 230, ExpressParser::RuleNumberType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1078);
    match(ExpressParser::NUMBER);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NumericExpressionContext ------------------------------------------------------------------

ExpressParser::NumericExpressionContext::NumericExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SimpleExpressionContext* ExpressParser::NumericExpressionContext::simpleExpression() {
  return getRuleContext<ExpressParser::SimpleExpressionContext>(0);
}


size_t ExpressParser::NumericExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleNumericExpression;
}

void ExpressParser::NumericExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterNumericExpression(this);
}

void ExpressParser::NumericExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitNumericExpression(this);
}


antlrcpp::Any ExpressParser::NumericExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitNumericExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::NumericExpressionContext* ExpressParser::numericExpression() {
  NumericExpressionContext *_localctx = _tracker.createInstance<NumericExpressionContext>(_ctx, getState());
  enterRule(_localctx, 232, ExpressParser::RuleNumericExpression);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1080);
    simpleExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- OneOfContext ------------------------------------------------------------------

ExpressParser::OneOfContext::OneOfContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::OneOfContext::ONEOF() {
  return getToken(ExpressParser::ONEOF, 0);
}

std::vector<ExpressParser::SupertypeExpressionContext *> ExpressParser::OneOfContext::supertypeExpression() {
  return getRuleContexts<ExpressParser::SupertypeExpressionContext>();
}

ExpressParser::SupertypeExpressionContext* ExpressParser::OneOfContext::supertypeExpression(size_t i) {
  return getRuleContext<ExpressParser::SupertypeExpressionContext>(i);
}


size_t ExpressParser::OneOfContext::getRuleIndex() const {
  return ExpressParser::RuleOneOf;
}

void ExpressParser::OneOfContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterOneOf(this);
}

void ExpressParser::OneOfContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitOneOf(this);
}


antlrcpp::Any ExpressParser::OneOfContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitOneOf(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::OneOfContext* ExpressParser::oneOf() {
  OneOfContext *_localctx = _tracker.createInstance<OneOfContext>(_ctx, getState());
  enterRule(_localctx, 234, ExpressParser::RuleOneOf);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1082);
    match(ExpressParser::ONEOF);
    setState(1083);
    match(ExpressParser::T__1);
    setState(1084);
    supertypeExpression();
    setState(1089);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1085);
      match(ExpressParser::T__2);
      setState(1086);
      supertypeExpression();
      setState(1091);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1092);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ParameterContext ------------------------------------------------------------------

ExpressParser::ParameterContext::ParameterContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::ParameterContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::ParameterContext::getRuleIndex() const {
  return ExpressParser::RuleParameter;
}

void ExpressParser::ParameterContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterParameter(this);
}

void ExpressParser::ParameterContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitParameter(this);
}


antlrcpp::Any ExpressParser::ParameterContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitParameter(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ParameterContext* ExpressParser::parameter() {
  ParameterContext *_localctx = _tracker.createInstance<ParameterContext>(_ctx, getState());
  enterRule(_localctx, 236, ExpressParser::RuleParameter);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1094);
    expression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ParameterIdContext ------------------------------------------------------------------

ExpressParser::ParameterIdContext::ParameterIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ParameterIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::ParameterIdContext::getRuleIndex() const {
  return ExpressParser::RuleParameterId;
}

void ExpressParser::ParameterIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterParameterId(this);
}

void ExpressParser::ParameterIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitParameterId(this);
}


antlrcpp::Any ExpressParser::ParameterIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitParameterId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ParameterIdContext* ExpressParser::parameterId() {
  ParameterIdContext *_localctx = _tracker.createInstance<ParameterIdContext>(_ctx, getState());
  enterRule(_localctx, 238, ExpressParser::RuleParameterId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1096);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ParameterTypeContext ------------------------------------------------------------------

ExpressParser::ParameterTypeContext::ParameterTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::GeneralizedTypesContext* ExpressParser::ParameterTypeContext::generalizedTypes() {
  return getRuleContext<ExpressParser::GeneralizedTypesContext>(0);
}

ExpressParser::NamedTypesContext* ExpressParser::ParameterTypeContext::namedTypes() {
  return getRuleContext<ExpressParser::NamedTypesContext>(0);
}

ExpressParser::SimpleTypesContext* ExpressParser::ParameterTypeContext::simpleTypes() {
  return getRuleContext<ExpressParser::SimpleTypesContext>(0);
}


size_t ExpressParser::ParameterTypeContext::getRuleIndex() const {
  return ExpressParser::RuleParameterType;
}

void ExpressParser::ParameterTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterParameterType(this);
}

void ExpressParser::ParameterTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitParameterType(this);
}


antlrcpp::Any ExpressParser::ParameterTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitParameterType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ParameterTypeContext* ExpressParser::parameterType() {
  ParameterTypeContext *_localctx = _tracker.createInstance<ParameterTypeContext>(_ctx, getState());
  enterRule(_localctx, 240, ExpressParser::RuleParameterType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1101);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::AGGREGATE:
      case ExpressParser::ARRAY:
      case ExpressParser::BAG:
      case ExpressParser::GENERIC:
      case ExpressParser::GENERIC_ENTITY:
      case ExpressParser::LIST:
      case ExpressParser::SET: {
        enterOuterAlt(_localctx, 1);
        setState(1098);
        generalizedTypes();
        break;
      }

      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 2);
        setState(1099);
        namedTypes();
        break;
      }

      case ExpressParser::BINARY:
      case ExpressParser::BOOLEAN:
      case ExpressParser::INTEGER:
      case ExpressParser::LOGICAL:
      case ExpressParser::NUMBER:
      case ExpressParser::REAL:
      case ExpressParser::STRING: {
        enterOuterAlt(_localctx, 3);
        setState(1100);
        simpleTypes();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- PopulationContext ------------------------------------------------------------------

ExpressParser::PopulationContext::PopulationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::PopulationContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}


size_t ExpressParser::PopulationContext::getRuleIndex() const {
  return ExpressParser::RulePopulation;
}

void ExpressParser::PopulationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterPopulation(this);
}

void ExpressParser::PopulationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitPopulation(this);
}


antlrcpp::Any ExpressParser::PopulationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitPopulation(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::PopulationContext* ExpressParser::population() {
  PopulationContext *_localctx = _tracker.createInstance<PopulationContext>(_ctx, getState());
  enterRule(_localctx, 242, ExpressParser::RulePopulation);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1103);
    entityRef();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- PrecisionSpecContext ------------------------------------------------------------------

ExpressParser::PrecisionSpecContext::PrecisionSpecContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::PrecisionSpecContext::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::PrecisionSpecContext::getRuleIndex() const {
  return ExpressParser::RulePrecisionSpec;
}

void ExpressParser::PrecisionSpecContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterPrecisionSpec(this);
}

void ExpressParser::PrecisionSpecContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitPrecisionSpec(this);
}


antlrcpp::Any ExpressParser::PrecisionSpecContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitPrecisionSpec(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::PrecisionSpecContext* ExpressParser::precisionSpec() {
  PrecisionSpecContext *_localctx = _tracker.createInstance<PrecisionSpecContext>(_ctx, getState());
  enterRule(_localctx, 244, ExpressParser::RulePrecisionSpec);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1105);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- PrimaryContext ------------------------------------------------------------------

ExpressParser::PrimaryContext::PrimaryContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::LiteralContext* ExpressParser::PrimaryContext::literal() {
  return getRuleContext<ExpressParser::LiteralContext>(0);
}

ExpressParser::QualifiableFactorContext* ExpressParser::PrimaryContext::qualifiableFactor() {
  return getRuleContext<ExpressParser::QualifiableFactorContext>(0);
}

std::vector<ExpressParser::QualifierContext *> ExpressParser::PrimaryContext::qualifier() {
  return getRuleContexts<ExpressParser::QualifierContext>();
}

ExpressParser::QualifierContext* ExpressParser::PrimaryContext::qualifier(size_t i) {
  return getRuleContext<ExpressParser::QualifierContext>(i);
}


size_t ExpressParser::PrimaryContext::getRuleIndex() const {
  return ExpressParser::RulePrimary;
}

void ExpressParser::PrimaryContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterPrimary(this);
}

void ExpressParser::PrimaryContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitPrimary(this);
}


antlrcpp::Any ExpressParser::PrimaryContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitPrimary(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::PrimaryContext* ExpressParser::primary() {
  PrimaryContext *_localctx = _tracker.createInstance<PrimaryContext>(_ctx, getState());
  enterRule(_localctx, 246, ExpressParser::RulePrimary);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1115);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::FALSE:
      case ExpressParser::TRUE:
      case ExpressParser::UNKNOWN:
      case ExpressParser::BinaryLiteral:
      case ExpressParser::EncodedStringLiteral:
      case ExpressParser::IntegerLiteral:
      case ExpressParser::RealLiteral:
      case ExpressParser::SimpleStringLiteral: {
        enterOuterAlt(_localctx, 1);
        setState(1107);
        literal();
        break;
      }

      case ExpressParser::T__11:
      case ExpressParser::ABS:
      case ExpressParser::ACOS:
      case ExpressParser::ASIN:
      case ExpressParser::ATAN:
      case ExpressParser::BLENGTH:
      case ExpressParser::CONST_E:
      case ExpressParser::COS:
      case ExpressParser::EXISTS:
      case ExpressParser::EXP:
      case ExpressParser::FORMAT:
      case ExpressParser::HIBOUND:
      case ExpressParser::HIINDEX:
      case ExpressParser::LENGTH:
      case ExpressParser::LOBOUND:
      case ExpressParser::LOG:
      case ExpressParser::LOG10:
      case ExpressParser::LOG2:
      case ExpressParser::LOINDEX:
      case ExpressParser::NVL:
      case ExpressParser::ODD:
      case ExpressParser::PI:
      case ExpressParser::ROLESOF:
      case ExpressParser::SELF:
      case ExpressParser::SIN:
      case ExpressParser::SIZEOF:
      case ExpressParser::SQRT:
      case ExpressParser::TAN:
      case ExpressParser::TYPEOF:
      case ExpressParser::USEDIN:
      case ExpressParser::VALUE_:
      case ExpressParser::VALUE_IN:
      case ExpressParser::VALUE_UNIQUE:
      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 2);
        setState(1108);
        qualifiableFactor();
        setState(1112);
        _errHandler->sync(this);
        _la = _input->LA(1);
        while ((((_la & ~ 0x3fULL) == 0) &&
          ((1ULL << _la) & ((1ULL << ExpressParser::T__6)
          | (1ULL << ExpressParser::T__10)
          | (1ULL << ExpressParser::T__13))) != 0)) {
          setState(1109);
          qualifier();
          setState(1114);
          _errHandler->sync(this);
          _la = _input->LA(1);
        }
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureCallStmtContext ------------------------------------------------------------------

ExpressParser::ProcedureCallStmtContext::ProcedureCallStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::BuiltInProcedureContext* ExpressParser::ProcedureCallStmtContext::builtInProcedure() {
  return getRuleContext<ExpressParser::BuiltInProcedureContext>(0);
}

ExpressParser::ProcedureRefContext* ExpressParser::ProcedureCallStmtContext::procedureRef() {
  return getRuleContext<ExpressParser::ProcedureRefContext>(0);
}

ExpressParser::ActualParameterListContext* ExpressParser::ProcedureCallStmtContext::actualParameterList() {
  return getRuleContext<ExpressParser::ActualParameterListContext>(0);
}


size_t ExpressParser::ProcedureCallStmtContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureCallStmt;
}

void ExpressParser::ProcedureCallStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureCallStmt(this);
}

void ExpressParser::ProcedureCallStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureCallStmt(this);
}


antlrcpp::Any ExpressParser::ProcedureCallStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureCallStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureCallStmtContext* ExpressParser::procedureCallStmt() {
  ProcedureCallStmtContext *_localctx = _tracker.createInstance<ProcedureCallStmtContext>(_ctx, getState());
  enterRule(_localctx, 248, ExpressParser::RuleProcedureCallStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1119);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::INSERT:
      case ExpressParser::REMOVE: {
        setState(1117);
        builtInProcedure();
        break;
      }

      case ExpressParser::SimpleId: {
        setState(1118);
        procedureRef();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
    setState(1122);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1121);
      actualParameterList();
    }
    setState(1124);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureDeclContext ------------------------------------------------------------------

ExpressParser::ProcedureDeclContext::ProcedureDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ProcedureHeadContext* ExpressParser::ProcedureDeclContext::procedureHead() {
  return getRuleContext<ExpressParser::ProcedureHeadContext>(0);
}

ExpressParser::AlgorithmHeadContext* ExpressParser::ProcedureDeclContext::algorithmHead() {
  return getRuleContext<ExpressParser::AlgorithmHeadContext>(0);
}

tree::TerminalNode* ExpressParser::ProcedureDeclContext::END_PROCEDURE() {
  return getToken(ExpressParser::END_PROCEDURE, 0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::ProcedureDeclContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::ProcedureDeclContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}


size_t ExpressParser::ProcedureDeclContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureDecl;
}

void ExpressParser::ProcedureDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureDecl(this);
}

void ExpressParser::ProcedureDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureDecl(this);
}


antlrcpp::Any ExpressParser::ProcedureDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureDeclContext* ExpressParser::procedureDecl() {
  ProcedureDeclContext *_localctx = _tracker.createInstance<ProcedureDeclContext>(_ctx, getState());
  enterRule(_localctx, 250, ExpressParser::RuleProcedureDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1126);
    procedureHead();
    setState(1127);
    algorithmHead();
    setState(1131);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(1128);
      stmt();
      setState(1133);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1134);
    match(ExpressParser::END_PROCEDURE);
    setState(1135);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureHeadContext ------------------------------------------------------------------

ExpressParser::ProcedureHeadContext::ProcedureHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ProcedureHeadContext::PROCEDURE() {
  return getToken(ExpressParser::PROCEDURE, 0);
}

ExpressParser::ProcedureIdContext* ExpressParser::ProcedureHeadContext::procedureId() {
  return getRuleContext<ExpressParser::ProcedureIdContext>(0);
}

std::vector<ExpressParser::ProcedureHeadParameterContext *> ExpressParser::ProcedureHeadContext::procedureHeadParameter() {
  return getRuleContexts<ExpressParser::ProcedureHeadParameterContext>();
}

ExpressParser::ProcedureHeadParameterContext* ExpressParser::ProcedureHeadContext::procedureHeadParameter(size_t i) {
  return getRuleContext<ExpressParser::ProcedureHeadParameterContext>(i);
}


size_t ExpressParser::ProcedureHeadContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureHead;
}

void ExpressParser::ProcedureHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureHead(this);
}

void ExpressParser::ProcedureHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureHead(this);
}


antlrcpp::Any ExpressParser::ProcedureHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureHeadContext* ExpressParser::procedureHead() {
  ProcedureHeadContext *_localctx = _tracker.createInstance<ProcedureHeadContext>(_ctx, getState());
  enterRule(_localctx, 252, ExpressParser::RuleProcedureHead);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1137);
    match(ExpressParser::PROCEDURE);
    setState(1138);
    procedureId();
    setState(1150);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1139);
      match(ExpressParser::T__1);
      setState(1140);
      procedureHeadParameter();
      setState(1145);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__0) {
        setState(1141);
        match(ExpressParser::T__0);
        setState(1142);
        procedureHeadParameter();
        setState(1147);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(1148);
      match(ExpressParser::T__3);
    }
    setState(1152);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureHeadParameterContext ------------------------------------------------------------------

ExpressParser::ProcedureHeadParameterContext::ProcedureHeadParameterContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::FormalParameterContext* ExpressParser::ProcedureHeadParameterContext::formalParameter() {
  return getRuleContext<ExpressParser::FormalParameterContext>(0);
}

tree::TerminalNode* ExpressParser::ProcedureHeadParameterContext::VAR() {
  return getToken(ExpressParser::VAR, 0);
}


size_t ExpressParser::ProcedureHeadParameterContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureHeadParameter;
}

void ExpressParser::ProcedureHeadParameterContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureHeadParameter(this);
}

void ExpressParser::ProcedureHeadParameterContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureHeadParameter(this);
}


antlrcpp::Any ExpressParser::ProcedureHeadParameterContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureHeadParameter(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureHeadParameterContext* ExpressParser::procedureHeadParameter() {
  ProcedureHeadParameterContext *_localctx = _tracker.createInstance<ProcedureHeadParameterContext>(_ctx, getState());
  enterRule(_localctx, 254, ExpressParser::RuleProcedureHeadParameter);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1155);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::VAR) {
      setState(1154);
      match(ExpressParser::VAR);
    }
    setState(1157);
    formalParameter();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ProcedureIdContext ------------------------------------------------------------------

ExpressParser::ProcedureIdContext::ProcedureIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ProcedureIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::ProcedureIdContext::getRuleIndex() const {
  return ExpressParser::RuleProcedureId;
}

void ExpressParser::ProcedureIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterProcedureId(this);
}

void ExpressParser::ProcedureIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitProcedureId(this);
}


antlrcpp::Any ExpressParser::ProcedureIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitProcedureId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ProcedureIdContext* ExpressParser::procedureId() {
  ProcedureIdContext *_localctx = _tracker.createInstance<ProcedureIdContext>(_ctx, getState());
  enterRule(_localctx, 256, ExpressParser::RuleProcedureId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1159);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- QualifiableFactorContext ------------------------------------------------------------------

ExpressParser::QualifiableFactorContext::QualifiableFactorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeRefContext* ExpressParser::QualifiableFactorContext::attributeRef() {
  return getRuleContext<ExpressParser::AttributeRefContext>(0);
}

ExpressParser::ConstantFactorContext* ExpressParser::QualifiableFactorContext::constantFactor() {
  return getRuleContext<ExpressParser::ConstantFactorContext>(0);
}

ExpressParser::FunctionCallContext* ExpressParser::QualifiableFactorContext::functionCall() {
  return getRuleContext<ExpressParser::FunctionCallContext>(0);
}

ExpressParser::GeneralRefContext* ExpressParser::QualifiableFactorContext::generalRef() {
  return getRuleContext<ExpressParser::GeneralRefContext>(0);
}

ExpressParser::PopulationContext* ExpressParser::QualifiableFactorContext::population() {
  return getRuleContext<ExpressParser::PopulationContext>(0);
}


size_t ExpressParser::QualifiableFactorContext::getRuleIndex() const {
  return ExpressParser::RuleQualifiableFactor;
}

void ExpressParser::QualifiableFactorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterQualifiableFactor(this);
}

void ExpressParser::QualifiableFactorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitQualifiableFactor(this);
}


antlrcpp::Any ExpressParser::QualifiableFactorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitQualifiableFactor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::QualifiableFactorContext* ExpressParser::qualifiableFactor() {
  QualifiableFactorContext *_localctx = _tracker.createInstance<QualifiableFactorContext>(_ctx, getState());
  enterRule(_localctx, 258, ExpressParser::RuleQualifiableFactor);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1166);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 93, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1161);
      attributeRef();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1162);
      constantFactor();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1163);
      functionCall();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(1164);
      generalRef();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(1165);
      population();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- QualifiedAttributeContext ------------------------------------------------------------------

ExpressParser::QualifiedAttributeContext::QualifiedAttributeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::QualifiedAttributeContext::SELF() {
  return getToken(ExpressParser::SELF, 0);
}

ExpressParser::GroupQualifierContext* ExpressParser::QualifiedAttributeContext::groupQualifier() {
  return getRuleContext<ExpressParser::GroupQualifierContext>(0);
}

ExpressParser::AttributeQualifierContext* ExpressParser::QualifiedAttributeContext::attributeQualifier() {
  return getRuleContext<ExpressParser::AttributeQualifierContext>(0);
}


size_t ExpressParser::QualifiedAttributeContext::getRuleIndex() const {
  return ExpressParser::RuleQualifiedAttribute;
}

void ExpressParser::QualifiedAttributeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterQualifiedAttribute(this);
}

void ExpressParser::QualifiedAttributeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitQualifiedAttribute(this);
}


antlrcpp::Any ExpressParser::QualifiedAttributeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitQualifiedAttribute(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::QualifiedAttributeContext* ExpressParser::qualifiedAttribute() {
  QualifiedAttributeContext *_localctx = _tracker.createInstance<QualifiedAttributeContext>(_ctx, getState());
  enterRule(_localctx, 260, ExpressParser::RuleQualifiedAttribute);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1168);
    match(ExpressParser::SELF);
    setState(1169);
    groupQualifier();
    setState(1170);
    attributeQualifier();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- QualifierContext ------------------------------------------------------------------

ExpressParser::QualifierContext::QualifierContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeQualifierContext* ExpressParser::QualifierContext::attributeQualifier() {
  return getRuleContext<ExpressParser::AttributeQualifierContext>(0);
}

ExpressParser::GroupQualifierContext* ExpressParser::QualifierContext::groupQualifier() {
  return getRuleContext<ExpressParser::GroupQualifierContext>(0);
}

ExpressParser::IndexQualifierContext* ExpressParser::QualifierContext::indexQualifier() {
  return getRuleContext<ExpressParser::IndexQualifierContext>(0);
}


size_t ExpressParser::QualifierContext::getRuleIndex() const {
  return ExpressParser::RuleQualifier;
}

void ExpressParser::QualifierContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterQualifier(this);
}

void ExpressParser::QualifierContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitQualifier(this);
}


antlrcpp::Any ExpressParser::QualifierContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitQualifier(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::QualifierContext* ExpressParser::qualifier() {
  QualifierContext *_localctx = _tracker.createInstance<QualifierContext>(_ctx, getState());
  enterRule(_localctx, 262, ExpressParser::RuleQualifier);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1175);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::T__10: {
        enterOuterAlt(_localctx, 1);
        setState(1172);
        attributeQualifier();
        break;
      }

      case ExpressParser::T__13: {
        enterOuterAlt(_localctx, 2);
        setState(1173);
        groupQualifier();
        break;
      }

      case ExpressParser::T__6: {
        enterOuterAlt(_localctx, 3);
        setState(1174);
        indexQualifier();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- QueryExpressionContext ------------------------------------------------------------------

ExpressParser::QueryExpressionContext::QueryExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::QueryExpressionContext::QUERY() {
  return getToken(ExpressParser::QUERY, 0);
}

ExpressParser::VariableIdContext* ExpressParser::QueryExpressionContext::variableId() {
  return getRuleContext<ExpressParser::VariableIdContext>(0);
}

ExpressParser::AggregateSourceContext* ExpressParser::QueryExpressionContext::aggregateSource() {
  return getRuleContext<ExpressParser::AggregateSourceContext>(0);
}

ExpressParser::LogicalExpressionContext* ExpressParser::QueryExpressionContext::logicalExpression() {
  return getRuleContext<ExpressParser::LogicalExpressionContext>(0);
}


size_t ExpressParser::QueryExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleQueryExpression;
}

void ExpressParser::QueryExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterQueryExpression(this);
}

void ExpressParser::QueryExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitQueryExpression(this);
}


antlrcpp::Any ExpressParser::QueryExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitQueryExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::QueryExpressionContext* ExpressParser::queryExpression() {
  QueryExpressionContext *_localctx = _tracker.createInstance<QueryExpressionContext>(_ctx, getState());
  enterRule(_localctx, 264, ExpressParser::RuleQueryExpression);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1177);
    match(ExpressParser::QUERY);
    setState(1178);
    match(ExpressParser::T__1);
    setState(1179);
    variableId();
    setState(1180);
    match(ExpressParser::T__21);
    setState(1181);
    aggregateSource();
    setState(1182);
    match(ExpressParser::T__22);
    setState(1183);
    logicalExpression();
    setState(1184);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RealTypeContext ------------------------------------------------------------------

ExpressParser::RealTypeContext::RealTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::RealTypeContext::REAL() {
  return getToken(ExpressParser::REAL, 0);
}

ExpressParser::PrecisionSpecContext* ExpressParser::RealTypeContext::precisionSpec() {
  return getRuleContext<ExpressParser::PrecisionSpecContext>(0);
}


size_t ExpressParser::RealTypeContext::getRuleIndex() const {
  return ExpressParser::RuleRealType;
}

void ExpressParser::RealTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRealType(this);
}

void ExpressParser::RealTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRealType(this);
}


antlrcpp::Any ExpressParser::RealTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRealType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RealTypeContext* ExpressParser::realType() {
  RealTypeContext *_localctx = _tracker.createInstance<RealTypeContext>(_ctx, getState());
  enterRule(_localctx, 266, ExpressParser::RuleRealType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1186);
    match(ExpressParser::REAL);
    setState(1191);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1187);
      match(ExpressParser::T__1);
      setState(1188);
      precisionSpec();
      setState(1189);
      match(ExpressParser::T__3);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RedeclaredAttributeContext ------------------------------------------------------------------

ExpressParser::RedeclaredAttributeContext::RedeclaredAttributeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::QualifiedAttributeContext* ExpressParser::RedeclaredAttributeContext::qualifiedAttribute() {
  return getRuleContext<ExpressParser::QualifiedAttributeContext>(0);
}

tree::TerminalNode* ExpressParser::RedeclaredAttributeContext::RENAMED() {
  return getToken(ExpressParser::RENAMED, 0);
}

ExpressParser::AttributeIdContext* ExpressParser::RedeclaredAttributeContext::attributeId() {
  return getRuleContext<ExpressParser::AttributeIdContext>(0);
}


size_t ExpressParser::RedeclaredAttributeContext::getRuleIndex() const {
  return ExpressParser::RuleRedeclaredAttribute;
}

void ExpressParser::RedeclaredAttributeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRedeclaredAttribute(this);
}

void ExpressParser::RedeclaredAttributeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRedeclaredAttribute(this);
}


antlrcpp::Any ExpressParser::RedeclaredAttributeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRedeclaredAttribute(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RedeclaredAttributeContext* ExpressParser::redeclaredAttribute() {
  RedeclaredAttributeContext *_localctx = _tracker.createInstance<RedeclaredAttributeContext>(_ctx, getState());
  enterRule(_localctx, 268, ExpressParser::RuleRedeclaredAttribute);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1193);
    qualifiedAttribute();
    setState(1196);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::RENAMED) {
      setState(1194);
      match(ExpressParser::RENAMED);
      setState(1195);
      attributeId();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ReferencedAttributeContext ------------------------------------------------------------------

ExpressParser::ReferencedAttributeContext::ReferencedAttributeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AttributeRefContext* ExpressParser::ReferencedAttributeContext::attributeRef() {
  return getRuleContext<ExpressParser::AttributeRefContext>(0);
}

ExpressParser::QualifiedAttributeContext* ExpressParser::ReferencedAttributeContext::qualifiedAttribute() {
  return getRuleContext<ExpressParser::QualifiedAttributeContext>(0);
}


size_t ExpressParser::ReferencedAttributeContext::getRuleIndex() const {
  return ExpressParser::RuleReferencedAttribute;
}

void ExpressParser::ReferencedAttributeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterReferencedAttribute(this);
}

void ExpressParser::ReferencedAttributeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitReferencedAttribute(this);
}


antlrcpp::Any ExpressParser::ReferencedAttributeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitReferencedAttribute(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ReferencedAttributeContext* ExpressParser::referencedAttribute() {
  ReferencedAttributeContext *_localctx = _tracker.createInstance<ReferencedAttributeContext>(_ctx, getState());
  enterRule(_localctx, 270, ExpressParser::RuleReferencedAttribute);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1200);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 1);
        setState(1198);
        attributeRef();
        break;
      }

      case ExpressParser::SELF: {
        enterOuterAlt(_localctx, 2);
        setState(1199);
        qualifiedAttribute();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ReferenceClauseContext ------------------------------------------------------------------

ExpressParser::ReferenceClauseContext::ReferenceClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ReferenceClauseContext::REFERENCE() {
  return getToken(ExpressParser::REFERENCE, 0);
}

tree::TerminalNode* ExpressParser::ReferenceClauseContext::FROM() {
  return getToken(ExpressParser::FROM, 0);
}

ExpressParser::SchemaRefContext* ExpressParser::ReferenceClauseContext::schemaRef() {
  return getRuleContext<ExpressParser::SchemaRefContext>(0);
}

std::vector<ExpressParser::ResourceOrRenameContext *> ExpressParser::ReferenceClauseContext::resourceOrRename() {
  return getRuleContexts<ExpressParser::ResourceOrRenameContext>();
}

ExpressParser::ResourceOrRenameContext* ExpressParser::ReferenceClauseContext::resourceOrRename(size_t i) {
  return getRuleContext<ExpressParser::ResourceOrRenameContext>(i);
}


size_t ExpressParser::ReferenceClauseContext::getRuleIndex() const {
  return ExpressParser::RuleReferenceClause;
}

void ExpressParser::ReferenceClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterReferenceClause(this);
}

void ExpressParser::ReferenceClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitReferenceClause(this);
}


antlrcpp::Any ExpressParser::ReferenceClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitReferenceClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ReferenceClauseContext* ExpressParser::referenceClause() {
  ReferenceClauseContext *_localctx = _tracker.createInstance<ReferenceClauseContext>(_ctx, getState());
  enterRule(_localctx, 272, ExpressParser::RuleReferenceClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1202);
    match(ExpressParser::REFERENCE);
    setState(1203);
    match(ExpressParser::FROM);
    setState(1204);
    schemaRef();
    setState(1216);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1205);
      match(ExpressParser::T__1);
      setState(1206);
      resourceOrRename();
      setState(1211);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__2) {
        setState(1207);
        match(ExpressParser::T__2);
        setState(1208);
        resourceOrRename();
        setState(1213);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(1214);
      match(ExpressParser::T__3);
    }
    setState(1218);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RelOpContext ------------------------------------------------------------------

ExpressParser::RelOpContext::RelOpContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t ExpressParser::RelOpContext::getRuleIndex() const {
  return ExpressParser::RuleRelOp;
}

void ExpressParser::RelOpContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRelOp(this);
}

void ExpressParser::RelOpContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRelOp(this);
}


antlrcpp::Any ExpressParser::RelOpContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRelOp(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RelOpContext* ExpressParser::relOp() {
  RelOpContext *_localctx = _tracker.createInstance<RelOpContext>(_ctx, getState());
  enterRule(_localctx, 274, ExpressParser::RuleRelOp);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1220);
    _la = _input->LA(1);
    if (!((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__16)
      | (1ULL << ExpressParser::T__17)
      | (1ULL << ExpressParser::T__23)
      | (1ULL << ExpressParser::T__24)
      | (1ULL << ExpressParser::T__25)
      | (1ULL << ExpressParser::T__26)
      | (1ULL << ExpressParser::T__27)
      | (1ULL << ExpressParser::T__28))) != 0))) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RelOpExtendedContext ------------------------------------------------------------------

ExpressParser::RelOpExtendedContext::RelOpExtendedContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::RelOpContext* ExpressParser::RelOpExtendedContext::relOp() {
  return getRuleContext<ExpressParser::RelOpContext>(0);
}

tree::TerminalNode* ExpressParser::RelOpExtendedContext::IN() {
  return getToken(ExpressParser::IN, 0);
}

tree::TerminalNode* ExpressParser::RelOpExtendedContext::LIKE() {
  return getToken(ExpressParser::LIKE, 0);
}


size_t ExpressParser::RelOpExtendedContext::getRuleIndex() const {
  return ExpressParser::RuleRelOpExtended;
}

void ExpressParser::RelOpExtendedContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRelOpExtended(this);
}

void ExpressParser::RelOpExtendedContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRelOpExtended(this);
}


antlrcpp::Any ExpressParser::RelOpExtendedContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRelOpExtended(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RelOpExtendedContext* ExpressParser::relOpExtended() {
  RelOpExtendedContext *_localctx = _tracker.createInstance<RelOpExtendedContext>(_ctx, getState());
  enterRule(_localctx, 276, ExpressParser::RuleRelOpExtended);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1225);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::T__16:
      case ExpressParser::T__17:
      case ExpressParser::T__23:
      case ExpressParser::T__24:
      case ExpressParser::T__25:
      case ExpressParser::T__26:
      case ExpressParser::T__27:
      case ExpressParser::T__28: {
        enterOuterAlt(_localctx, 1);
        setState(1222);
        relOp();
        break;
      }

      case ExpressParser::IN: {
        enterOuterAlt(_localctx, 2);
        setState(1223);
        match(ExpressParser::IN);
        break;
      }

      case ExpressParser::LIKE: {
        enterOuterAlt(_localctx, 3);
        setState(1224);
        match(ExpressParser::LIKE);
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RenameIdContext ------------------------------------------------------------------

ExpressParser::RenameIdContext::RenameIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConstantIdContext* ExpressParser::RenameIdContext::constantId() {
  return getRuleContext<ExpressParser::ConstantIdContext>(0);
}

ExpressParser::EntityIdContext* ExpressParser::RenameIdContext::entityId() {
  return getRuleContext<ExpressParser::EntityIdContext>(0);
}

ExpressParser::FunctionIdContext* ExpressParser::RenameIdContext::functionId() {
  return getRuleContext<ExpressParser::FunctionIdContext>(0);
}

ExpressParser::ProcedureIdContext* ExpressParser::RenameIdContext::procedureId() {
  return getRuleContext<ExpressParser::ProcedureIdContext>(0);
}

ExpressParser::TypeIdContext* ExpressParser::RenameIdContext::typeId() {
  return getRuleContext<ExpressParser::TypeIdContext>(0);
}


size_t ExpressParser::RenameIdContext::getRuleIndex() const {
  return ExpressParser::RuleRenameId;
}

void ExpressParser::RenameIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRenameId(this);
}

void ExpressParser::RenameIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRenameId(this);
}


antlrcpp::Any ExpressParser::RenameIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRenameId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RenameIdContext* ExpressParser::renameId() {
  RenameIdContext *_localctx = _tracker.createInstance<RenameIdContext>(_ctx, getState());
  enterRule(_localctx, 278, ExpressParser::RuleRenameId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1232);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 101, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1227);
      constantId();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1228);
      entityId();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1229);
      functionId();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(1230);
      procedureId();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(1231);
      typeId();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RepeatControlContext ------------------------------------------------------------------

ExpressParser::RepeatControlContext::RepeatControlContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::IncrementControlContext* ExpressParser::RepeatControlContext::incrementControl() {
  return getRuleContext<ExpressParser::IncrementControlContext>(0);
}

ExpressParser::WhileControlContext* ExpressParser::RepeatControlContext::whileControl() {
  return getRuleContext<ExpressParser::WhileControlContext>(0);
}

ExpressParser::UntilControlContext* ExpressParser::RepeatControlContext::untilControl() {
  return getRuleContext<ExpressParser::UntilControlContext>(0);
}


size_t ExpressParser::RepeatControlContext::getRuleIndex() const {
  return ExpressParser::RuleRepeatControl;
}

void ExpressParser::RepeatControlContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRepeatControl(this);
}

void ExpressParser::RepeatControlContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRepeatControl(this);
}


antlrcpp::Any ExpressParser::RepeatControlContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRepeatControl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RepeatControlContext* ExpressParser::repeatControl() {
  RepeatControlContext *_localctx = _tracker.createInstance<RepeatControlContext>(_ctx, getState());
  enterRule(_localctx, 280, ExpressParser::RuleRepeatControl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1235);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::SimpleId) {
      setState(1234);
      incrementControl();
    }
    setState(1238);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::WHILE) {
      setState(1237);
      whileControl();
    }
    setState(1241);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::UNTIL) {
      setState(1240);
      untilControl();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RepeatStmtContext ------------------------------------------------------------------

ExpressParser::RepeatStmtContext::RepeatStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::RepeatStmtContext::REPEAT() {
  return getToken(ExpressParser::REPEAT, 0);
}

ExpressParser::RepeatControlContext* ExpressParser::RepeatStmtContext::repeatControl() {
  return getRuleContext<ExpressParser::RepeatControlContext>(0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::RepeatStmtContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::RepeatStmtContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}

tree::TerminalNode* ExpressParser::RepeatStmtContext::END_REPEAT() {
  return getToken(ExpressParser::END_REPEAT, 0);
}


size_t ExpressParser::RepeatStmtContext::getRuleIndex() const {
  return ExpressParser::RuleRepeatStmt;
}

void ExpressParser::RepeatStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRepeatStmt(this);
}

void ExpressParser::RepeatStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRepeatStmt(this);
}


antlrcpp::Any ExpressParser::RepeatStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRepeatStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RepeatStmtContext* ExpressParser::repeatStmt() {
  RepeatStmtContext *_localctx = _tracker.createInstance<RepeatStmtContext>(_ctx, getState());
  enterRule(_localctx, 282, ExpressParser::RuleRepeatStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1243);
    match(ExpressParser::REPEAT);
    setState(1244);
    repeatControl();
    setState(1245);
    match(ExpressParser::T__0);
    setState(1246);
    stmt();
    setState(1250);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(1247);
      stmt();
      setState(1252);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1253);
    match(ExpressParser::END_REPEAT);
    setState(1254);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RepetitionContext ------------------------------------------------------------------

ExpressParser::RepetitionContext::RepetitionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::RepetitionContext::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::RepetitionContext::getRuleIndex() const {
  return ExpressParser::RuleRepetition;
}

void ExpressParser::RepetitionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRepetition(this);
}

void ExpressParser::RepetitionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRepetition(this);
}


antlrcpp::Any ExpressParser::RepetitionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRepetition(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RepetitionContext* ExpressParser::repetition() {
  RepetitionContext *_localctx = _tracker.createInstance<RepetitionContext>(_ctx, getState());
  enterRule(_localctx, 284, ExpressParser::RuleRepetition);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1256);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ResourceOrRenameContext ------------------------------------------------------------------

ExpressParser::ResourceOrRenameContext::ResourceOrRenameContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ResourceRefContext* ExpressParser::ResourceOrRenameContext::resourceRef() {
  return getRuleContext<ExpressParser::ResourceRefContext>(0);
}

tree::TerminalNode* ExpressParser::ResourceOrRenameContext::AS() {
  return getToken(ExpressParser::AS, 0);
}

ExpressParser::RenameIdContext* ExpressParser::ResourceOrRenameContext::renameId() {
  return getRuleContext<ExpressParser::RenameIdContext>(0);
}


size_t ExpressParser::ResourceOrRenameContext::getRuleIndex() const {
  return ExpressParser::RuleResourceOrRename;
}

void ExpressParser::ResourceOrRenameContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterResourceOrRename(this);
}

void ExpressParser::ResourceOrRenameContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitResourceOrRename(this);
}


antlrcpp::Any ExpressParser::ResourceOrRenameContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitResourceOrRename(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ResourceOrRenameContext* ExpressParser::resourceOrRename() {
  ResourceOrRenameContext *_localctx = _tracker.createInstance<ResourceOrRenameContext>(_ctx, getState());
  enterRule(_localctx, 286, ExpressParser::RuleResourceOrRename);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1258);
    resourceRef();
    setState(1261);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::AS) {
      setState(1259);
      match(ExpressParser::AS);
      setState(1260);
      renameId();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ResourceRefContext ------------------------------------------------------------------

ExpressParser::ResourceRefContext::ResourceRefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConstantRefContext* ExpressParser::ResourceRefContext::constantRef() {
  return getRuleContext<ExpressParser::ConstantRefContext>(0);
}

ExpressParser::EntityRefContext* ExpressParser::ResourceRefContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}

ExpressParser::FunctionRefContext* ExpressParser::ResourceRefContext::functionRef() {
  return getRuleContext<ExpressParser::FunctionRefContext>(0);
}

ExpressParser::ProcedureRefContext* ExpressParser::ResourceRefContext::procedureRef() {
  return getRuleContext<ExpressParser::ProcedureRefContext>(0);
}

ExpressParser::TypeRefContext* ExpressParser::ResourceRefContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}


size_t ExpressParser::ResourceRefContext::getRuleIndex() const {
  return ExpressParser::RuleResourceRef;
}

void ExpressParser::ResourceRefContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterResourceRef(this);
}

void ExpressParser::ResourceRefContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitResourceRef(this);
}


antlrcpp::Any ExpressParser::ResourceRefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitResourceRef(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ResourceRefContext* ExpressParser::resourceRef() {
  ResourceRefContext *_localctx = _tracker.createInstance<ResourceRefContext>(_ctx, getState());
  enterRule(_localctx, 288, ExpressParser::RuleResourceRef);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1268);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 107, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1263);
      constantRef();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1264);
      entityRef();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1265);
      functionRef();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(1266);
      procedureRef();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(1267);
      typeRef();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ReturnStmtContext ------------------------------------------------------------------

ExpressParser::ReturnStmtContext::ReturnStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::ReturnStmtContext::RETURN() {
  return getToken(ExpressParser::RETURN, 0);
}

ExpressParser::ExpressionContext* ExpressParser::ReturnStmtContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::ReturnStmtContext::getRuleIndex() const {
  return ExpressParser::RuleReturnStmt;
}

void ExpressParser::ReturnStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterReturnStmt(this);
}

void ExpressParser::ReturnStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitReturnStmt(this);
}


antlrcpp::Any ExpressParser::ReturnStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitReturnStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::ReturnStmtContext* ExpressParser::returnStmt() {
  ReturnStmtContext *_localctx = _tracker.createInstance<ReturnStmtContext>(_ctx, getState());
  enterRule(_localctx, 290, ExpressParser::RuleReturnStmt);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1270);
    match(ExpressParser::RETURN);
    setState(1275);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1271);
      match(ExpressParser::T__1);
      setState(1272);
      expression();
      setState(1273);
      match(ExpressParser::T__3);
    }
    setState(1277);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleDeclContext ------------------------------------------------------------------

ExpressParser::RuleDeclContext::RuleDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::RuleHeadContext* ExpressParser::RuleDeclContext::ruleHead() {
  return getRuleContext<ExpressParser::RuleHeadContext>(0);
}

ExpressParser::AlgorithmHeadContext* ExpressParser::RuleDeclContext::algorithmHead() {
  return getRuleContext<ExpressParser::AlgorithmHeadContext>(0);
}

ExpressParser::WhereClauseContext* ExpressParser::RuleDeclContext::whereClause() {
  return getRuleContext<ExpressParser::WhereClauseContext>(0);
}

tree::TerminalNode* ExpressParser::RuleDeclContext::END_RULE() {
  return getToken(ExpressParser::END_RULE, 0);
}

std::vector<ExpressParser::StmtContext *> ExpressParser::RuleDeclContext::stmt() {
  return getRuleContexts<ExpressParser::StmtContext>();
}

ExpressParser::StmtContext* ExpressParser::RuleDeclContext::stmt(size_t i) {
  return getRuleContext<ExpressParser::StmtContext>(i);
}


size_t ExpressParser::RuleDeclContext::getRuleIndex() const {
  return ExpressParser::RuleRuleDecl;
}

void ExpressParser::RuleDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleDecl(this);
}

void ExpressParser::RuleDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleDecl(this);
}


antlrcpp::Any ExpressParser::RuleDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleDeclContext* ExpressParser::ruleDecl() {
  RuleDeclContext *_localctx = _tracker.createInstance<RuleDeclContext>(_ctx, getState());
  enterRule(_localctx, 292, ExpressParser::RuleRuleDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1279);
    ruleHead();
    setState(1280);
    algorithmHead();
    setState(1284);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__0)
      | (1ULL << ExpressParser::ALIAS)
      | (1ULL << ExpressParser::BEGIN_)
      | (1ULL << ExpressParser::CASE))) != 0) || ((((_la - 71) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 71)) & ((1ULL << (ExpressParser::ESCAPE - 71))
      | (1ULL << (ExpressParser::IF - 71))
      | (1ULL << (ExpressParser::INSERT - 71))
      | (1ULL << (ExpressParser::REMOVE - 71))
      | (1ULL << (ExpressParser::REPEAT - 71))
      | (1ULL << (ExpressParser::RETURN - 71))
      | (1ULL << (ExpressParser::SKIP_ - 71)))) != 0) || _la == ExpressParser::SimpleId) {
      setState(1281);
      stmt();
      setState(1286);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1287);
    whereClause();
    setState(1288);
    match(ExpressParser::END_RULE);
    setState(1289);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleHeadContext ------------------------------------------------------------------

ExpressParser::RuleHeadContext::RuleHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::RuleHeadContext::RULE() {
  return getToken(ExpressParser::RULE, 0);
}

ExpressParser::RuleIdContext* ExpressParser::RuleHeadContext::ruleId() {
  return getRuleContext<ExpressParser::RuleIdContext>(0);
}

tree::TerminalNode* ExpressParser::RuleHeadContext::FOR() {
  return getToken(ExpressParser::FOR, 0);
}

std::vector<ExpressParser::EntityRefContext *> ExpressParser::RuleHeadContext::entityRef() {
  return getRuleContexts<ExpressParser::EntityRefContext>();
}

ExpressParser::EntityRefContext* ExpressParser::RuleHeadContext::entityRef(size_t i) {
  return getRuleContext<ExpressParser::EntityRefContext>(i);
}


size_t ExpressParser::RuleHeadContext::getRuleIndex() const {
  return ExpressParser::RuleRuleHead;
}

void ExpressParser::RuleHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleHead(this);
}

void ExpressParser::RuleHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleHead(this);
}


antlrcpp::Any ExpressParser::RuleHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleHeadContext* ExpressParser::ruleHead() {
  RuleHeadContext *_localctx = _tracker.createInstance<RuleHeadContext>(_ctx, getState());
  enterRule(_localctx, 294, ExpressParser::RuleRuleHead);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1291);
    match(ExpressParser::RULE);
    setState(1292);
    ruleId();
    setState(1293);
    match(ExpressParser::FOR);
    setState(1294);
    match(ExpressParser::T__1);
    setState(1295);
    entityRef();
    setState(1300);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1296);
      match(ExpressParser::T__2);
      setState(1297);
      entityRef();
      setState(1302);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1303);
    match(ExpressParser::T__3);
    setState(1304);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleIdContext ------------------------------------------------------------------

ExpressParser::RuleIdContext::RuleIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::RuleIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::RuleIdContext::getRuleIndex() const {
  return ExpressParser::RuleRuleId;
}

void ExpressParser::RuleIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleId(this);
}

void ExpressParser::RuleIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleId(this);
}


antlrcpp::Any ExpressParser::RuleIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleIdContext* ExpressParser::ruleId() {
  RuleIdContext *_localctx = _tracker.createInstance<RuleIdContext>(_ctx, getState());
  enterRule(_localctx, 296, ExpressParser::RuleRuleId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1306);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- RuleLabelIdContext ------------------------------------------------------------------

ExpressParser::RuleLabelIdContext::RuleLabelIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::RuleLabelIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::RuleLabelIdContext::getRuleIndex() const {
  return ExpressParser::RuleRuleLabelId;
}

void ExpressParser::RuleLabelIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterRuleLabelId(this);
}

void ExpressParser::RuleLabelIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitRuleLabelId(this);
}


antlrcpp::Any ExpressParser::RuleLabelIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitRuleLabelId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::RuleLabelIdContext* ExpressParser::ruleLabelId() {
  RuleLabelIdContext *_localctx = _tracker.createInstance<RuleLabelIdContext>(_ctx, getState());
  enterRule(_localctx, 298, ExpressParser::RuleRuleLabelId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1308);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaBodyContext ------------------------------------------------------------------

ExpressParser::SchemaBodyContext::SchemaBodyContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::InterfaceSpecificationContext *> ExpressParser::SchemaBodyContext::interfaceSpecification() {
  return getRuleContexts<ExpressParser::InterfaceSpecificationContext>();
}

ExpressParser::InterfaceSpecificationContext* ExpressParser::SchemaBodyContext::interfaceSpecification(size_t i) {
  return getRuleContext<ExpressParser::InterfaceSpecificationContext>(i);
}

ExpressParser::ConstantDeclContext* ExpressParser::SchemaBodyContext::constantDecl() {
  return getRuleContext<ExpressParser::ConstantDeclContext>(0);
}

std::vector<ExpressParser::SchemaBodyDeclarationContext *> ExpressParser::SchemaBodyContext::schemaBodyDeclaration() {
  return getRuleContexts<ExpressParser::SchemaBodyDeclarationContext>();
}

ExpressParser::SchemaBodyDeclarationContext* ExpressParser::SchemaBodyContext::schemaBodyDeclaration(size_t i) {
  return getRuleContext<ExpressParser::SchemaBodyDeclarationContext>(i);
}


size_t ExpressParser::SchemaBodyContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaBody;
}

void ExpressParser::SchemaBodyContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaBody(this);
}

void ExpressParser::SchemaBodyContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaBody(this);
}


antlrcpp::Any ExpressParser::SchemaBodyContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaBody(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaBodyContext* ExpressParser::schemaBody() {
  SchemaBodyContext *_localctx = _tracker.createInstance<SchemaBodyContext>(_ctx, getState());
  enterRule(_localctx, 300, ExpressParser::RuleSchemaBody);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1313);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::REFERENCE

    || _la == ExpressParser::USE) {
      setState(1310);
      interfaceSpecification();
      setState(1315);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1317);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::CONSTANT) {
      setState(1316);
      constantDecl();
    }
    setState(1322);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (((((_la - 69) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 69)) & ((1ULL << (ExpressParser::ENTITY - 69))
      | (1ULL << (ExpressParser::FUNCTION - 69))
      | (1ULL << (ExpressParser::PROCEDURE - 69))
      | (1ULL << (ExpressParser::RULE - 69))
      | (1ULL << (ExpressParser::SUBTYPE_CONSTRAINT - 69)))) != 0) || _la == ExpressParser::TYPE) {
      setState(1319);
      schemaBodyDeclaration();
      setState(1324);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaBodyDeclarationContext ------------------------------------------------------------------

ExpressParser::SchemaBodyDeclarationContext::SchemaBodyDeclarationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::DeclarationContext* ExpressParser::SchemaBodyDeclarationContext::declaration() {
  return getRuleContext<ExpressParser::DeclarationContext>(0);
}

ExpressParser::RuleDeclContext* ExpressParser::SchemaBodyDeclarationContext::ruleDecl() {
  return getRuleContext<ExpressParser::RuleDeclContext>(0);
}


size_t ExpressParser::SchemaBodyDeclarationContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaBodyDeclaration;
}

void ExpressParser::SchemaBodyDeclarationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaBodyDeclaration(this);
}

void ExpressParser::SchemaBodyDeclarationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaBodyDeclaration(this);
}


antlrcpp::Any ExpressParser::SchemaBodyDeclarationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaBodyDeclaration(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaBodyDeclarationContext* ExpressParser::schemaBodyDeclaration() {
  SchemaBodyDeclarationContext *_localctx = _tracker.createInstance<SchemaBodyDeclarationContext>(_ctx, getState());
  enterRule(_localctx, 302, ExpressParser::RuleSchemaBodyDeclaration);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1327);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ENTITY:
      case ExpressParser::FUNCTION:
      case ExpressParser::PROCEDURE:
      case ExpressParser::SUBTYPE_CONSTRAINT:
      case ExpressParser::TYPE: {
        enterOuterAlt(_localctx, 1);
        setState(1325);
        declaration();
        break;
      }

      case ExpressParser::RULE: {
        enterOuterAlt(_localctx, 2);
        setState(1326);
        ruleDecl();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaDeclContext ------------------------------------------------------------------

ExpressParser::SchemaDeclContext::SchemaDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SchemaDeclContext::SCHEMA() {
  return getToken(ExpressParser::SCHEMA, 0);
}

ExpressParser::SchemaIdContext* ExpressParser::SchemaDeclContext::schemaId() {
  return getRuleContext<ExpressParser::SchemaIdContext>(0);
}

ExpressParser::SchemaBodyContext* ExpressParser::SchemaDeclContext::schemaBody() {
  return getRuleContext<ExpressParser::SchemaBodyContext>(0);
}

tree::TerminalNode* ExpressParser::SchemaDeclContext::END_SCHEMA() {
  return getToken(ExpressParser::END_SCHEMA, 0);
}

ExpressParser::SchemaVersionIdContext* ExpressParser::SchemaDeclContext::schemaVersionId() {
  return getRuleContext<ExpressParser::SchemaVersionIdContext>(0);
}


size_t ExpressParser::SchemaDeclContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaDecl;
}

void ExpressParser::SchemaDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaDecl(this);
}

void ExpressParser::SchemaDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaDecl(this);
}


antlrcpp::Any ExpressParser::SchemaDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaDeclContext* ExpressParser::schemaDecl() {
  SchemaDeclContext *_localctx = _tracker.createInstance<SchemaDeclContext>(_ctx, getState());
  enterRule(_localctx, 304, ExpressParser::RuleSchemaDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1329);
    match(ExpressParser::SCHEMA);
    setState(1330);
    schemaId();
    setState(1332);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::EncodedStringLiteral

    || _la == ExpressParser::SimpleStringLiteral) {
      setState(1331);
      schemaVersionId();
    }
    setState(1334);
    match(ExpressParser::T__0);
    setState(1335);
    schemaBody();
    setState(1336);
    match(ExpressParser::END_SCHEMA);
    setState(1337);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaIdContext ------------------------------------------------------------------

ExpressParser::SchemaIdContext::SchemaIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SchemaIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::SchemaIdContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaId;
}

void ExpressParser::SchemaIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaId(this);
}

void ExpressParser::SchemaIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaId(this);
}


antlrcpp::Any ExpressParser::SchemaIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaIdContext* ExpressParser::schemaId() {
  SchemaIdContext *_localctx = _tracker.createInstance<SchemaIdContext>(_ctx, getState());
  enterRule(_localctx, 306, ExpressParser::RuleSchemaId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1339);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SchemaVersionIdContext ------------------------------------------------------------------

ExpressParser::SchemaVersionIdContext::SchemaVersionIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::StringLiteralContext* ExpressParser::SchemaVersionIdContext::stringLiteral() {
  return getRuleContext<ExpressParser::StringLiteralContext>(0);
}


size_t ExpressParser::SchemaVersionIdContext::getRuleIndex() const {
  return ExpressParser::RuleSchemaVersionId;
}

void ExpressParser::SchemaVersionIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSchemaVersionId(this);
}

void ExpressParser::SchemaVersionIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSchemaVersionId(this);
}


antlrcpp::Any ExpressParser::SchemaVersionIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSchemaVersionId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SchemaVersionIdContext* ExpressParser::schemaVersionId() {
  SchemaVersionIdContext *_localctx = _tracker.createInstance<SchemaVersionIdContext>(_ctx, getState());
  enterRule(_localctx, 308, ExpressParser::RuleSchemaVersionId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1341);
    stringLiteral();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SelectorContext ------------------------------------------------------------------

ExpressParser::SelectorContext::SelectorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::SelectorContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}


size_t ExpressParser::SelectorContext::getRuleIndex() const {
  return ExpressParser::RuleSelector;
}

void ExpressParser::SelectorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSelector(this);
}

void ExpressParser::SelectorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSelector(this);
}


antlrcpp::Any ExpressParser::SelectorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSelector(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SelectorContext* ExpressParser::selector() {
  SelectorContext *_localctx = _tracker.createInstance<SelectorContext>(_ctx, getState());
  enterRule(_localctx, 310, ExpressParser::RuleSelector);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1343);
    expression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SelectExtensionContext ------------------------------------------------------------------

ExpressParser::SelectExtensionContext::SelectExtensionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SelectExtensionContext::BASED_ON() {
  return getToken(ExpressParser::BASED_ON, 0);
}

ExpressParser::TypeRefContext* ExpressParser::SelectExtensionContext::typeRef() {
  return getRuleContext<ExpressParser::TypeRefContext>(0);
}

tree::TerminalNode* ExpressParser::SelectExtensionContext::WITH() {
  return getToken(ExpressParser::WITH, 0);
}

ExpressParser::SelectListContext* ExpressParser::SelectExtensionContext::selectList() {
  return getRuleContext<ExpressParser::SelectListContext>(0);
}


size_t ExpressParser::SelectExtensionContext::getRuleIndex() const {
  return ExpressParser::RuleSelectExtension;
}

void ExpressParser::SelectExtensionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSelectExtension(this);
}

void ExpressParser::SelectExtensionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSelectExtension(this);
}


antlrcpp::Any ExpressParser::SelectExtensionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSelectExtension(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SelectExtensionContext* ExpressParser::selectExtension() {
  SelectExtensionContext *_localctx = _tracker.createInstance<SelectExtensionContext>(_ctx, getState());
  enterRule(_localctx, 312, ExpressParser::RuleSelectExtension);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1345);
    match(ExpressParser::BASED_ON);
    setState(1346);
    typeRef();
    setState(1349);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::WITH) {
      setState(1347);
      match(ExpressParser::WITH);
      setState(1348);
      selectList();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SelectListContext ------------------------------------------------------------------

ExpressParser::SelectListContext::SelectListContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::NamedTypesContext *> ExpressParser::SelectListContext::namedTypes() {
  return getRuleContexts<ExpressParser::NamedTypesContext>();
}

ExpressParser::NamedTypesContext* ExpressParser::SelectListContext::namedTypes(size_t i) {
  return getRuleContext<ExpressParser::NamedTypesContext>(i);
}


size_t ExpressParser::SelectListContext::getRuleIndex() const {
  return ExpressParser::RuleSelectList;
}

void ExpressParser::SelectListContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSelectList(this);
}

void ExpressParser::SelectListContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSelectList(this);
}


antlrcpp::Any ExpressParser::SelectListContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSelectList(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SelectListContext* ExpressParser::selectList() {
  SelectListContext *_localctx = _tracker.createInstance<SelectListContext>(_ctx, getState());
  enterRule(_localctx, 314, ExpressParser::RuleSelectList);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1351);
    match(ExpressParser::T__1);
    setState(1352);
    namedTypes();
    setState(1357);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1353);
      match(ExpressParser::T__2);
      setState(1354);
      namedTypes();
      setState(1359);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1360);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SelectTypeContext ------------------------------------------------------------------

ExpressParser::SelectTypeContext::SelectTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SelectTypeContext::SELECT() {
  return getToken(ExpressParser::SELECT, 0);
}

tree::TerminalNode* ExpressParser::SelectTypeContext::EXTENSIBLE() {
  return getToken(ExpressParser::EXTENSIBLE, 0);
}

ExpressParser::SelectListContext* ExpressParser::SelectTypeContext::selectList() {
  return getRuleContext<ExpressParser::SelectListContext>(0);
}

ExpressParser::SelectExtensionContext* ExpressParser::SelectTypeContext::selectExtension() {
  return getRuleContext<ExpressParser::SelectExtensionContext>(0);
}

tree::TerminalNode* ExpressParser::SelectTypeContext::GENERIC_ENTITY() {
  return getToken(ExpressParser::GENERIC_ENTITY, 0);
}


size_t ExpressParser::SelectTypeContext::getRuleIndex() const {
  return ExpressParser::RuleSelectType;
}

void ExpressParser::SelectTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSelectType(this);
}

void ExpressParser::SelectTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSelectType(this);
}


antlrcpp::Any ExpressParser::SelectTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSelectType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SelectTypeContext* ExpressParser::selectType() {
  SelectTypeContext *_localctx = _tracker.createInstance<SelectTypeContext>(_ctx, getState());
  enterRule(_localctx, 316, ExpressParser::RuleSelectType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1366);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::EXTENSIBLE) {
      setState(1362);
      match(ExpressParser::EXTENSIBLE);
      setState(1364);
      _errHandler->sync(this);

      _la = _input->LA(1);
      if (_la == ExpressParser::GENERIC_ENTITY) {
        setState(1363);
        match(ExpressParser::GENERIC_ENTITY);
      }
    }
    setState(1368);
    match(ExpressParser::SELECT);
    setState(1371);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::T__1: {
        setState(1369);
        selectList();
        break;
      }

      case ExpressParser::BASED_ON: {
        setState(1370);
        selectExtension();
        break;
      }

      case ExpressParser::T__0: {
        break;
      }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SetTypeContext ------------------------------------------------------------------

ExpressParser::SetTypeContext::SetTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SetTypeContext::SET() {
  return getToken(ExpressParser::SET, 0);
}

tree::TerminalNode* ExpressParser::SetTypeContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::InstantiableTypeContext* ExpressParser::SetTypeContext::instantiableType() {
  return getRuleContext<ExpressParser::InstantiableTypeContext>(0);
}

ExpressParser::BoundSpecContext* ExpressParser::SetTypeContext::boundSpec() {
  return getRuleContext<ExpressParser::BoundSpecContext>(0);
}


size_t ExpressParser::SetTypeContext::getRuleIndex() const {
  return ExpressParser::RuleSetType;
}

void ExpressParser::SetTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSetType(this);
}

void ExpressParser::SetTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSetType(this);
}


antlrcpp::Any ExpressParser::SetTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSetType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SetTypeContext* ExpressParser::setType() {
  SetTypeContext *_localctx = _tracker.createInstance<SetTypeContext>(_ctx, getState());
  enterRule(_localctx, 318, ExpressParser::RuleSetType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1373);
    match(ExpressParser::SET);
    setState(1375);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__6) {
      setState(1374);
      boundSpec();
    }
    setState(1377);
    match(ExpressParser::OF);
    setState(1378);
    instantiableType();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SimpleExpressionContext ------------------------------------------------------------------

ExpressParser::SimpleExpressionContext::SimpleExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::TermContext *> ExpressParser::SimpleExpressionContext::term() {
  return getRuleContexts<ExpressParser::TermContext>();
}

ExpressParser::TermContext* ExpressParser::SimpleExpressionContext::term(size_t i) {
  return getRuleContext<ExpressParser::TermContext>(i);
}

std::vector<ExpressParser::AddLikeOpContext *> ExpressParser::SimpleExpressionContext::addLikeOp() {
  return getRuleContexts<ExpressParser::AddLikeOpContext>();
}

ExpressParser::AddLikeOpContext* ExpressParser::SimpleExpressionContext::addLikeOp(size_t i) {
  return getRuleContext<ExpressParser::AddLikeOpContext>(i);
}


size_t ExpressParser::SimpleExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleSimpleExpression;
}

void ExpressParser::SimpleExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSimpleExpression(this);
}

void ExpressParser::SimpleExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSimpleExpression(this);
}


antlrcpp::Any ExpressParser::SimpleExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSimpleExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SimpleExpressionContext* ExpressParser::simpleExpression() {
  SimpleExpressionContext *_localctx = _tracker.createInstance<SimpleExpressionContext>(_ctx, getState());
  enterRule(_localctx, 320, ExpressParser::RuleSimpleExpression);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1380);
    term();
    setState(1386);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__4

    || _la == ExpressParser::T__5 || _la == ExpressParser::OR

    || _la == ExpressParser::XOR) {
      setState(1381);
      addLikeOp();
      setState(1382);
      term();
      setState(1388);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SimpleFactorContext ------------------------------------------------------------------

ExpressParser::SimpleFactorContext::SimpleFactorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AggregateInitializerContext* ExpressParser::SimpleFactorContext::aggregateInitializer() {
  return getRuleContext<ExpressParser::AggregateInitializerContext>(0);
}

ExpressParser::EntityConstructorContext* ExpressParser::SimpleFactorContext::entityConstructor() {
  return getRuleContext<ExpressParser::EntityConstructorContext>(0);
}

ExpressParser::EnumerationReferenceContext* ExpressParser::SimpleFactorContext::enumerationReference() {
  return getRuleContext<ExpressParser::EnumerationReferenceContext>(0);
}

ExpressParser::IntervalContext* ExpressParser::SimpleFactorContext::interval() {
  return getRuleContext<ExpressParser::IntervalContext>(0);
}

ExpressParser::QueryExpressionContext* ExpressParser::SimpleFactorContext::queryExpression() {
  return getRuleContext<ExpressParser::QueryExpressionContext>(0);
}

ExpressParser::SimpleFactorExpressionContext* ExpressParser::SimpleFactorContext::simpleFactorExpression() {
  return getRuleContext<ExpressParser::SimpleFactorExpressionContext>(0);
}

ExpressParser::SimpleFactorUnaryExpressionContext* ExpressParser::SimpleFactorContext::simpleFactorUnaryExpression() {
  return getRuleContext<ExpressParser::SimpleFactorUnaryExpressionContext>(0);
}


size_t ExpressParser::SimpleFactorContext::getRuleIndex() const {
  return ExpressParser::RuleSimpleFactor;
}

void ExpressParser::SimpleFactorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSimpleFactor(this);
}

void ExpressParser::SimpleFactorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSimpleFactor(this);
}


antlrcpp::Any ExpressParser::SimpleFactorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSimpleFactor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SimpleFactorContext* ExpressParser::simpleFactor() {
  SimpleFactorContext *_localctx = _tracker.createInstance<SimpleFactorContext>(_ctx, getState());
  enterRule(_localctx, 322, ExpressParser::RuleSimpleFactor);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1396);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 123, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1389);
      aggregateInitializer();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1390);
      entityConstructor();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1391);
      enumerationReference();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(1392);
      interval();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(1393);
      queryExpression();
      break;
    }

    case 6: {
      enterOuterAlt(_localctx, 6);
      setState(1394);
      simpleFactorExpression();
      break;
    }

    case 7: {
      enterOuterAlt(_localctx, 7);
      setState(1395);
      simpleFactorUnaryExpression();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SimpleFactorExpressionContext ------------------------------------------------------------------

ExpressParser::SimpleFactorExpressionContext::SimpleFactorExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ExpressionContext* ExpressParser::SimpleFactorExpressionContext::expression() {
  return getRuleContext<ExpressParser::ExpressionContext>(0);
}

ExpressParser::PrimaryContext* ExpressParser::SimpleFactorExpressionContext::primary() {
  return getRuleContext<ExpressParser::PrimaryContext>(0);
}


size_t ExpressParser::SimpleFactorExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleSimpleFactorExpression;
}

void ExpressParser::SimpleFactorExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSimpleFactorExpression(this);
}

void ExpressParser::SimpleFactorExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSimpleFactorExpression(this);
}


antlrcpp::Any ExpressParser::SimpleFactorExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSimpleFactorExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SimpleFactorExpressionContext* ExpressParser::simpleFactorExpression() {
  SimpleFactorExpressionContext *_localctx = _tracker.createInstance<SimpleFactorExpressionContext>(_ctx, getState());
  enterRule(_localctx, 324, ExpressParser::RuleSimpleFactorExpression);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1403);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::T__1: {
        enterOuterAlt(_localctx, 1);
        setState(1398);
        match(ExpressParser::T__1);
        setState(1399);
        expression();
        setState(1400);
        match(ExpressParser::T__3);
        break;
      }

      case ExpressParser::T__11:
      case ExpressParser::ABS:
      case ExpressParser::ACOS:
      case ExpressParser::ASIN:
      case ExpressParser::ATAN:
      case ExpressParser::BLENGTH:
      case ExpressParser::CONST_E:
      case ExpressParser::COS:
      case ExpressParser::EXISTS:
      case ExpressParser::EXP:
      case ExpressParser::FALSE:
      case ExpressParser::FORMAT:
      case ExpressParser::HIBOUND:
      case ExpressParser::HIINDEX:
      case ExpressParser::LENGTH:
      case ExpressParser::LOBOUND:
      case ExpressParser::LOG:
      case ExpressParser::LOG10:
      case ExpressParser::LOG2:
      case ExpressParser::LOINDEX:
      case ExpressParser::NVL:
      case ExpressParser::ODD:
      case ExpressParser::PI:
      case ExpressParser::ROLESOF:
      case ExpressParser::SELF:
      case ExpressParser::SIN:
      case ExpressParser::SIZEOF:
      case ExpressParser::SQRT:
      case ExpressParser::TAN:
      case ExpressParser::TRUE:
      case ExpressParser::TYPEOF:
      case ExpressParser::UNKNOWN:
      case ExpressParser::USEDIN:
      case ExpressParser::VALUE_:
      case ExpressParser::VALUE_IN:
      case ExpressParser::VALUE_UNIQUE:
      case ExpressParser::BinaryLiteral:
      case ExpressParser::EncodedStringLiteral:
      case ExpressParser::IntegerLiteral:
      case ExpressParser::RealLiteral:
      case ExpressParser::SimpleId:
      case ExpressParser::SimpleStringLiteral: {
        enterOuterAlt(_localctx, 2);
        setState(1402);
        primary();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SimpleFactorUnaryExpressionContext ------------------------------------------------------------------

ExpressParser::SimpleFactorUnaryExpressionContext::SimpleFactorUnaryExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::UnaryOpContext* ExpressParser::SimpleFactorUnaryExpressionContext::unaryOp() {
  return getRuleContext<ExpressParser::UnaryOpContext>(0);
}

ExpressParser::SimpleFactorExpressionContext* ExpressParser::SimpleFactorUnaryExpressionContext::simpleFactorExpression() {
  return getRuleContext<ExpressParser::SimpleFactorExpressionContext>(0);
}


size_t ExpressParser::SimpleFactorUnaryExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleSimpleFactorUnaryExpression;
}

void ExpressParser::SimpleFactorUnaryExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSimpleFactorUnaryExpression(this);
}

void ExpressParser::SimpleFactorUnaryExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSimpleFactorUnaryExpression(this);
}


antlrcpp::Any ExpressParser::SimpleFactorUnaryExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSimpleFactorUnaryExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SimpleFactorUnaryExpressionContext* ExpressParser::simpleFactorUnaryExpression() {
  SimpleFactorUnaryExpressionContext *_localctx = _tracker.createInstance<SimpleFactorUnaryExpressionContext>(_ctx, getState());
  enterRule(_localctx, 326, ExpressParser::RuleSimpleFactorUnaryExpression);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1405);
    unaryOp();
    setState(1406);
    simpleFactorExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SimpleTypesContext ------------------------------------------------------------------

ExpressParser::SimpleTypesContext::SimpleTypesContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::BinaryTypeContext* ExpressParser::SimpleTypesContext::binaryType() {
  return getRuleContext<ExpressParser::BinaryTypeContext>(0);
}

ExpressParser::BooleanTypeContext* ExpressParser::SimpleTypesContext::booleanType() {
  return getRuleContext<ExpressParser::BooleanTypeContext>(0);
}

ExpressParser::IntegerTypeContext* ExpressParser::SimpleTypesContext::integerType() {
  return getRuleContext<ExpressParser::IntegerTypeContext>(0);
}

ExpressParser::LogicalTypeContext* ExpressParser::SimpleTypesContext::logicalType() {
  return getRuleContext<ExpressParser::LogicalTypeContext>(0);
}

ExpressParser::NumberTypeContext* ExpressParser::SimpleTypesContext::numberType() {
  return getRuleContext<ExpressParser::NumberTypeContext>(0);
}

ExpressParser::RealTypeContext* ExpressParser::SimpleTypesContext::realType() {
  return getRuleContext<ExpressParser::RealTypeContext>(0);
}

ExpressParser::StringTypeContext* ExpressParser::SimpleTypesContext::stringType() {
  return getRuleContext<ExpressParser::StringTypeContext>(0);
}


size_t ExpressParser::SimpleTypesContext::getRuleIndex() const {
  return ExpressParser::RuleSimpleTypes;
}

void ExpressParser::SimpleTypesContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSimpleTypes(this);
}

void ExpressParser::SimpleTypesContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSimpleTypes(this);
}


antlrcpp::Any ExpressParser::SimpleTypesContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSimpleTypes(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SimpleTypesContext* ExpressParser::simpleTypes() {
  SimpleTypesContext *_localctx = _tracker.createInstance<SimpleTypesContext>(_ctx, getState());
  enterRule(_localctx, 328, ExpressParser::RuleSimpleTypes);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1415);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::BINARY: {
        enterOuterAlt(_localctx, 1);
        setState(1408);
        binaryType();
        break;
      }

      case ExpressParser::BOOLEAN: {
        enterOuterAlt(_localctx, 2);
        setState(1409);
        booleanType();
        break;
      }

      case ExpressParser::INTEGER: {
        enterOuterAlt(_localctx, 3);
        setState(1410);
        integerType();
        break;
      }

      case ExpressParser::LOGICAL: {
        enterOuterAlt(_localctx, 4);
        setState(1411);
        logicalType();
        break;
      }

      case ExpressParser::NUMBER: {
        enterOuterAlt(_localctx, 5);
        setState(1412);
        numberType();
        break;
      }

      case ExpressParser::REAL: {
        enterOuterAlt(_localctx, 6);
        setState(1413);
        realType();
        break;
      }

      case ExpressParser::STRING: {
        enterOuterAlt(_localctx, 7);
        setState(1414);
        stringType();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SkipStmtContext ------------------------------------------------------------------

ExpressParser::SkipStmtContext::SkipStmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SkipStmtContext::SKIP_() {
  return getToken(ExpressParser::SKIP_, 0);
}


size_t ExpressParser::SkipStmtContext::getRuleIndex() const {
  return ExpressParser::RuleSkipStmt;
}

void ExpressParser::SkipStmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSkipStmt(this);
}

void ExpressParser::SkipStmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSkipStmt(this);
}


antlrcpp::Any ExpressParser::SkipStmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSkipStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SkipStmtContext* ExpressParser::skipStmt() {
  SkipStmtContext *_localctx = _tracker.createInstance<SkipStmtContext>(_ctx, getState());
  enterRule(_localctx, 330, ExpressParser::RuleSkipStmt);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1417);
    match(ExpressParser::SKIP_);
    setState(1418);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- StmtContext ------------------------------------------------------------------

ExpressParser::StmtContext::StmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AliasStmtContext* ExpressParser::StmtContext::aliasStmt() {
  return getRuleContext<ExpressParser::AliasStmtContext>(0);
}

ExpressParser::AssignmentStmtContext* ExpressParser::StmtContext::assignmentStmt() {
  return getRuleContext<ExpressParser::AssignmentStmtContext>(0);
}

ExpressParser::CaseStmtContext* ExpressParser::StmtContext::caseStmt() {
  return getRuleContext<ExpressParser::CaseStmtContext>(0);
}

ExpressParser::CompoundStmtContext* ExpressParser::StmtContext::compoundStmt() {
  return getRuleContext<ExpressParser::CompoundStmtContext>(0);
}

ExpressParser::EscapeStmtContext* ExpressParser::StmtContext::escapeStmt() {
  return getRuleContext<ExpressParser::EscapeStmtContext>(0);
}

ExpressParser::IfStmtContext* ExpressParser::StmtContext::ifStmt() {
  return getRuleContext<ExpressParser::IfStmtContext>(0);
}

ExpressParser::NullStmtContext* ExpressParser::StmtContext::nullStmt() {
  return getRuleContext<ExpressParser::NullStmtContext>(0);
}

ExpressParser::ProcedureCallStmtContext* ExpressParser::StmtContext::procedureCallStmt() {
  return getRuleContext<ExpressParser::ProcedureCallStmtContext>(0);
}

ExpressParser::RepeatStmtContext* ExpressParser::StmtContext::repeatStmt() {
  return getRuleContext<ExpressParser::RepeatStmtContext>(0);
}

ExpressParser::ReturnStmtContext* ExpressParser::StmtContext::returnStmt() {
  return getRuleContext<ExpressParser::ReturnStmtContext>(0);
}

ExpressParser::SkipStmtContext* ExpressParser::StmtContext::skipStmt() {
  return getRuleContext<ExpressParser::SkipStmtContext>(0);
}


size_t ExpressParser::StmtContext::getRuleIndex() const {
  return ExpressParser::RuleStmt;
}

void ExpressParser::StmtContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterStmt(this);
}

void ExpressParser::StmtContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitStmt(this);
}


antlrcpp::Any ExpressParser::StmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitStmt(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::StmtContext* ExpressParser::stmt() {
  StmtContext *_localctx = _tracker.createInstance<StmtContext>(_ctx, getState());
  enterRule(_localctx, 332, ExpressParser::RuleStmt);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1431);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 126, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1420);
      aliasStmt();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1421);
      assignmentStmt();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1422);
      caseStmt();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(1423);
      compoundStmt();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(1424);
      escapeStmt();
      break;
    }

    case 6: {
      enterOuterAlt(_localctx, 6);
      setState(1425);
      ifStmt();
      break;
    }

    case 7: {
      enterOuterAlt(_localctx, 7);
      setState(1426);
      nullStmt();
      break;
    }

    case 8: {
      enterOuterAlt(_localctx, 8);
      setState(1427);
      procedureCallStmt();
      break;
    }

    case 9: {
      enterOuterAlt(_localctx, 9);
      setState(1428);
      repeatStmt();
      break;
    }

    case 10: {
      enterOuterAlt(_localctx, 10);
      setState(1429);
      returnStmt();
      break;
    }

    case 11: {
      enterOuterAlt(_localctx, 11);
      setState(1430);
      skipStmt();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- StringLiteralContext ------------------------------------------------------------------

ExpressParser::StringLiteralContext::StringLiteralContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::StringLiteralContext::SimpleStringLiteral() {
  return getToken(ExpressParser::SimpleStringLiteral, 0);
}

tree::TerminalNode* ExpressParser::StringLiteralContext::EncodedStringLiteral() {
  return getToken(ExpressParser::EncodedStringLiteral, 0);
}


size_t ExpressParser::StringLiteralContext::getRuleIndex() const {
  return ExpressParser::RuleStringLiteral;
}

void ExpressParser::StringLiteralContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterStringLiteral(this);
}

void ExpressParser::StringLiteralContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitStringLiteral(this);
}


antlrcpp::Any ExpressParser::StringLiteralContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitStringLiteral(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::StringLiteralContext* ExpressParser::stringLiteral() {
  StringLiteralContext *_localctx = _tracker.createInstance<StringLiteralContext>(_ctx, getState());
  enterRule(_localctx, 334, ExpressParser::RuleStringLiteral);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1433);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::EncodedStringLiteral

    || _la == ExpressParser::SimpleStringLiteral)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- StringTypeContext ------------------------------------------------------------------

ExpressParser::StringTypeContext::StringTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::StringTypeContext::STRING() {
  return getToken(ExpressParser::STRING, 0);
}

ExpressParser::WidthSpecContext* ExpressParser::StringTypeContext::widthSpec() {
  return getRuleContext<ExpressParser::WidthSpecContext>(0);
}


size_t ExpressParser::StringTypeContext::getRuleIndex() const {
  return ExpressParser::RuleStringType;
}

void ExpressParser::StringTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterStringType(this);
}

void ExpressParser::StringTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitStringType(this);
}


antlrcpp::Any ExpressParser::StringTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitStringType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::StringTypeContext* ExpressParser::stringType() {
  StringTypeContext *_localctx = _tracker.createInstance<StringTypeContext>(_ctx, getState());
  enterRule(_localctx, 336, ExpressParser::RuleStringType);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1435);
    match(ExpressParser::STRING);
    setState(1437);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1436);
      widthSpec();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubsuperContext ------------------------------------------------------------------

ExpressParser::SubsuperContext::SubsuperContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SupertypeConstraintContext* ExpressParser::SubsuperContext::supertypeConstraint() {
  return getRuleContext<ExpressParser::SupertypeConstraintContext>(0);
}

ExpressParser::SubtypeDeclarationContext* ExpressParser::SubsuperContext::subtypeDeclaration() {
  return getRuleContext<ExpressParser::SubtypeDeclarationContext>(0);
}


size_t ExpressParser::SubsuperContext::getRuleIndex() const {
  return ExpressParser::RuleSubsuper;
}

void ExpressParser::SubsuperContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubsuper(this);
}

void ExpressParser::SubsuperContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubsuper(this);
}


antlrcpp::Any ExpressParser::SubsuperContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubsuper(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubsuperContext* ExpressParser::subsuper() {
  SubsuperContext *_localctx = _tracker.createInstance<SubsuperContext>(_ctx, getState());
  enterRule(_localctx, 338, ExpressParser::RuleSubsuper);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1440);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::ABSTRACT || _la == ExpressParser::SUPERTYPE) {
      setState(1439);
      supertypeConstraint();
    }
    setState(1443);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::SUBTYPE) {
      setState(1442);
      subtypeDeclaration();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintContext::SubtypeConstraintContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SubtypeConstraintContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

ExpressParser::SupertypeExpressionContext* ExpressParser::SubtypeConstraintContext::supertypeExpression() {
  return getRuleContext<ExpressParser::SupertypeExpressionContext>(0);
}


size_t ExpressParser::SubtypeConstraintContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraint;
}

void ExpressParser::SubtypeConstraintContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraint(this);
}

void ExpressParser::SubtypeConstraintContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraint(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraint(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintContext* ExpressParser::subtypeConstraint() {
  SubtypeConstraintContext *_localctx = _tracker.createInstance<SubtypeConstraintContext>(_ctx, getState());
  enterRule(_localctx, 340, ExpressParser::RuleSubtypeConstraint);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1445);
    match(ExpressParser::OF);
    setState(1446);
    match(ExpressParser::T__1);
    setState(1447);
    supertypeExpression();
    setState(1448);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintBodyContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintBodyContext::SubtypeConstraintBodyContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AbstractSupertypeContext* ExpressParser::SubtypeConstraintBodyContext::abstractSupertype() {
  return getRuleContext<ExpressParser::AbstractSupertypeContext>(0);
}

ExpressParser::TotalOverContext* ExpressParser::SubtypeConstraintBodyContext::totalOver() {
  return getRuleContext<ExpressParser::TotalOverContext>(0);
}

ExpressParser::SupertypeExpressionContext* ExpressParser::SubtypeConstraintBodyContext::supertypeExpression() {
  return getRuleContext<ExpressParser::SupertypeExpressionContext>(0);
}


size_t ExpressParser::SubtypeConstraintBodyContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraintBody;
}

void ExpressParser::SubtypeConstraintBodyContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraintBody(this);
}

void ExpressParser::SubtypeConstraintBodyContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraintBody(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintBodyContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraintBody(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintBodyContext* ExpressParser::subtypeConstraintBody() {
  SubtypeConstraintBodyContext *_localctx = _tracker.createInstance<SubtypeConstraintBodyContext>(_ctx, getState());
  enterRule(_localctx, 342, ExpressParser::RuleSubtypeConstraintBody);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1451);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::ABSTRACT) {
      setState(1450);
      abstractSupertype();
    }
    setState(1454);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::TOTAL_OVER) {
      setState(1453);
      totalOver();
    }
    setState(1459);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1 || _la == ExpressParser::ONEOF

    || _la == ExpressParser::SimpleId) {
      setState(1456);
      supertypeExpression();
      setState(1457);
      match(ExpressParser::T__0);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintDeclContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintDeclContext::SubtypeConstraintDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::SubtypeConstraintHeadContext* ExpressParser::SubtypeConstraintDeclContext::subtypeConstraintHead() {
  return getRuleContext<ExpressParser::SubtypeConstraintHeadContext>(0);
}

ExpressParser::SubtypeConstraintBodyContext* ExpressParser::SubtypeConstraintDeclContext::subtypeConstraintBody() {
  return getRuleContext<ExpressParser::SubtypeConstraintBodyContext>(0);
}

tree::TerminalNode* ExpressParser::SubtypeConstraintDeclContext::END_SUBTYPE_CONSTRAINT() {
  return getToken(ExpressParser::END_SUBTYPE_CONSTRAINT, 0);
}


size_t ExpressParser::SubtypeConstraintDeclContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraintDecl;
}

void ExpressParser::SubtypeConstraintDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraintDecl(this);
}

void ExpressParser::SubtypeConstraintDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraintDecl(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraintDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintDeclContext* ExpressParser::subtypeConstraintDecl() {
  SubtypeConstraintDeclContext *_localctx = _tracker.createInstance<SubtypeConstraintDeclContext>(_ctx, getState());
  enterRule(_localctx, 344, ExpressParser::RuleSubtypeConstraintDecl);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1461);
    subtypeConstraintHead();
    setState(1462);
    subtypeConstraintBody();
    setState(1463);
    match(ExpressParser::END_SUBTYPE_CONSTRAINT);
    setState(1464);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintHeadContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintHeadContext::SubtypeConstraintHeadContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SubtypeConstraintHeadContext::SUBTYPE_CONSTRAINT() {
  return getToken(ExpressParser::SUBTYPE_CONSTRAINT, 0);
}

ExpressParser::SubtypeConstraintIdContext* ExpressParser::SubtypeConstraintHeadContext::subtypeConstraintId() {
  return getRuleContext<ExpressParser::SubtypeConstraintIdContext>(0);
}

tree::TerminalNode* ExpressParser::SubtypeConstraintHeadContext::FOR() {
  return getToken(ExpressParser::FOR, 0);
}

ExpressParser::EntityRefContext* ExpressParser::SubtypeConstraintHeadContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}


size_t ExpressParser::SubtypeConstraintHeadContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraintHead;
}

void ExpressParser::SubtypeConstraintHeadContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraintHead(this);
}

void ExpressParser::SubtypeConstraintHeadContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraintHead(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintHeadContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraintHead(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintHeadContext* ExpressParser::subtypeConstraintHead() {
  SubtypeConstraintHeadContext *_localctx = _tracker.createInstance<SubtypeConstraintHeadContext>(_ctx, getState());
  enterRule(_localctx, 346, ExpressParser::RuleSubtypeConstraintHead);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1466);
    match(ExpressParser::SUBTYPE_CONSTRAINT);
    setState(1467);
    subtypeConstraintId();
    setState(1468);
    match(ExpressParser::FOR);
    setState(1469);
    entityRef();
    setState(1470);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeConstraintIdContext ------------------------------------------------------------------

ExpressParser::SubtypeConstraintIdContext::SubtypeConstraintIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SubtypeConstraintIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::SubtypeConstraintIdContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeConstraintId;
}

void ExpressParser::SubtypeConstraintIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeConstraintId(this);
}

void ExpressParser::SubtypeConstraintIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeConstraintId(this);
}


antlrcpp::Any ExpressParser::SubtypeConstraintIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeConstraintId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeConstraintIdContext* ExpressParser::subtypeConstraintId() {
  SubtypeConstraintIdContext *_localctx = _tracker.createInstance<SubtypeConstraintIdContext>(_ctx, getState());
  enterRule(_localctx, 348, ExpressParser::RuleSubtypeConstraintId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1472);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SubtypeDeclarationContext ------------------------------------------------------------------

ExpressParser::SubtypeDeclarationContext::SubtypeDeclarationContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SubtypeDeclarationContext::SUBTYPE() {
  return getToken(ExpressParser::SUBTYPE, 0);
}

tree::TerminalNode* ExpressParser::SubtypeDeclarationContext::OF() {
  return getToken(ExpressParser::OF, 0);
}

std::vector<ExpressParser::EntityRefContext *> ExpressParser::SubtypeDeclarationContext::entityRef() {
  return getRuleContexts<ExpressParser::EntityRefContext>();
}

ExpressParser::EntityRefContext* ExpressParser::SubtypeDeclarationContext::entityRef(size_t i) {
  return getRuleContext<ExpressParser::EntityRefContext>(i);
}


size_t ExpressParser::SubtypeDeclarationContext::getRuleIndex() const {
  return ExpressParser::RuleSubtypeDeclaration;
}

void ExpressParser::SubtypeDeclarationContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSubtypeDeclaration(this);
}

void ExpressParser::SubtypeDeclarationContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSubtypeDeclaration(this);
}


antlrcpp::Any ExpressParser::SubtypeDeclarationContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSubtypeDeclaration(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SubtypeDeclarationContext* ExpressParser::subtypeDeclaration() {
  SubtypeDeclarationContext *_localctx = _tracker.createInstance<SubtypeDeclarationContext>(_ctx, getState());
  enterRule(_localctx, 350, ExpressParser::RuleSubtypeDeclaration);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1474);
    match(ExpressParser::SUBTYPE);
    setState(1475);
    match(ExpressParser::OF);
    setState(1476);
    match(ExpressParser::T__1);
    setState(1477);
    entityRef();
    setState(1482);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1478);
      match(ExpressParser::T__2);
      setState(1479);
      entityRef();
      setState(1484);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1485);
    match(ExpressParser::T__3);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SupertypeConstraintContext ------------------------------------------------------------------

ExpressParser::SupertypeConstraintContext::SupertypeConstraintContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::AbstractEntityDeclarationContext* ExpressParser::SupertypeConstraintContext::abstractEntityDeclaration() {
  return getRuleContext<ExpressParser::AbstractEntityDeclarationContext>(0);
}

ExpressParser::AbstractSupertypeDeclarationContext* ExpressParser::SupertypeConstraintContext::abstractSupertypeDeclaration() {
  return getRuleContext<ExpressParser::AbstractSupertypeDeclarationContext>(0);
}

ExpressParser::SupertypeRuleContext* ExpressParser::SupertypeConstraintContext::supertypeRule() {
  return getRuleContext<ExpressParser::SupertypeRuleContext>(0);
}


size_t ExpressParser::SupertypeConstraintContext::getRuleIndex() const {
  return ExpressParser::RuleSupertypeConstraint;
}

void ExpressParser::SupertypeConstraintContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSupertypeConstraint(this);
}

void ExpressParser::SupertypeConstraintContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSupertypeConstraint(this);
}


antlrcpp::Any ExpressParser::SupertypeConstraintContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSupertypeConstraint(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SupertypeConstraintContext* ExpressParser::supertypeConstraint() {
  SupertypeConstraintContext *_localctx = _tracker.createInstance<SupertypeConstraintContext>(_ctx, getState());
  enterRule(_localctx, 352, ExpressParser::RuleSupertypeConstraint);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1490);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 134, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1487);
      abstractEntityDeclaration();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1488);
      abstractSupertypeDeclaration();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(1489);
      supertypeRule();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SupertypeExpressionContext ------------------------------------------------------------------

ExpressParser::SupertypeExpressionContext::SupertypeExpressionContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::SupertypeFactorContext *> ExpressParser::SupertypeExpressionContext::supertypeFactor() {
  return getRuleContexts<ExpressParser::SupertypeFactorContext>();
}

ExpressParser::SupertypeFactorContext* ExpressParser::SupertypeExpressionContext::supertypeFactor(size_t i) {
  return getRuleContext<ExpressParser::SupertypeFactorContext>(i);
}

std::vector<tree::TerminalNode *> ExpressParser::SupertypeExpressionContext::ANDOR() {
  return getTokens(ExpressParser::ANDOR);
}

tree::TerminalNode* ExpressParser::SupertypeExpressionContext::ANDOR(size_t i) {
  return getToken(ExpressParser::ANDOR, i);
}


size_t ExpressParser::SupertypeExpressionContext::getRuleIndex() const {
  return ExpressParser::RuleSupertypeExpression;
}

void ExpressParser::SupertypeExpressionContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSupertypeExpression(this);
}

void ExpressParser::SupertypeExpressionContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSupertypeExpression(this);
}


antlrcpp::Any ExpressParser::SupertypeExpressionContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSupertypeExpression(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SupertypeExpressionContext* ExpressParser::supertypeExpression() {
  SupertypeExpressionContext *_localctx = _tracker.createInstance<SupertypeExpressionContext>(_ctx, getState());
  enterRule(_localctx, 354, ExpressParser::RuleSupertypeExpression);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1492);
    supertypeFactor();
    setState(1497);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::ANDOR) {
      setState(1493);
      match(ExpressParser::ANDOR);
      setState(1494);
      supertypeFactor();
      setState(1499);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SupertypeFactorContext ------------------------------------------------------------------

ExpressParser::SupertypeFactorContext::SupertypeFactorContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::SupertypeTermContext *> ExpressParser::SupertypeFactorContext::supertypeTerm() {
  return getRuleContexts<ExpressParser::SupertypeTermContext>();
}

ExpressParser::SupertypeTermContext* ExpressParser::SupertypeFactorContext::supertypeTerm(size_t i) {
  return getRuleContext<ExpressParser::SupertypeTermContext>(i);
}

std::vector<tree::TerminalNode *> ExpressParser::SupertypeFactorContext::AND() {
  return getTokens(ExpressParser::AND);
}

tree::TerminalNode* ExpressParser::SupertypeFactorContext::AND(size_t i) {
  return getToken(ExpressParser::AND, i);
}


size_t ExpressParser::SupertypeFactorContext::getRuleIndex() const {
  return ExpressParser::RuleSupertypeFactor;
}

void ExpressParser::SupertypeFactorContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSupertypeFactor(this);
}

void ExpressParser::SupertypeFactorContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSupertypeFactor(this);
}


antlrcpp::Any ExpressParser::SupertypeFactorContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSupertypeFactor(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SupertypeFactorContext* ExpressParser::supertypeFactor() {
  SupertypeFactorContext *_localctx = _tracker.createInstance<SupertypeFactorContext>(_ctx, getState());
  enterRule(_localctx, 356, ExpressParser::RuleSupertypeFactor);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1500);
    supertypeTerm();
    setState(1505);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::AND) {
      setState(1501);
      match(ExpressParser::AND);
      setState(1502);
      supertypeTerm();
      setState(1507);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SupertypeRuleContext ------------------------------------------------------------------

ExpressParser::SupertypeRuleContext::SupertypeRuleContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SupertypeRuleContext::SUPERTYPE() {
  return getToken(ExpressParser::SUPERTYPE, 0);
}

ExpressParser::SubtypeConstraintContext* ExpressParser::SupertypeRuleContext::subtypeConstraint() {
  return getRuleContext<ExpressParser::SubtypeConstraintContext>(0);
}


size_t ExpressParser::SupertypeRuleContext::getRuleIndex() const {
  return ExpressParser::RuleSupertypeRule;
}

void ExpressParser::SupertypeRuleContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSupertypeRule(this);
}

void ExpressParser::SupertypeRuleContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSupertypeRule(this);
}


antlrcpp::Any ExpressParser::SupertypeRuleContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSupertypeRule(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SupertypeRuleContext* ExpressParser::supertypeRule() {
  SupertypeRuleContext *_localctx = _tracker.createInstance<SupertypeRuleContext>(_ctx, getState());
  enterRule(_localctx, 358, ExpressParser::RuleSupertypeRule);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1508);
    match(ExpressParser::SUPERTYPE);
    setState(1509);
    subtypeConstraint();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SupertypeTermContext ------------------------------------------------------------------

ExpressParser::SupertypeTermContext::SupertypeTermContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::EntityRefContext* ExpressParser::SupertypeTermContext::entityRef() {
  return getRuleContext<ExpressParser::EntityRefContext>(0);
}

ExpressParser::OneOfContext* ExpressParser::SupertypeTermContext::oneOf() {
  return getRuleContext<ExpressParser::OneOfContext>(0);
}

ExpressParser::SupertypeExpressionContext* ExpressParser::SupertypeTermContext::supertypeExpression() {
  return getRuleContext<ExpressParser::SupertypeExpressionContext>(0);
}


size_t ExpressParser::SupertypeTermContext::getRuleIndex() const {
  return ExpressParser::RuleSupertypeTerm;
}

void ExpressParser::SupertypeTermContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSupertypeTerm(this);
}

void ExpressParser::SupertypeTermContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSupertypeTerm(this);
}


antlrcpp::Any ExpressParser::SupertypeTermContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSupertypeTerm(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SupertypeTermContext* ExpressParser::supertypeTerm() {
  SupertypeTermContext *_localctx = _tracker.createInstance<SupertypeTermContext>(_ctx, getState());
  enterRule(_localctx, 360, ExpressParser::RuleSupertypeTerm);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1517);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 1);
        setState(1511);
        entityRef();
        break;
      }

      case ExpressParser::ONEOF: {
        enterOuterAlt(_localctx, 2);
        setState(1512);
        oneOf();
        break;
      }

      case ExpressParser::T__1: {
        enterOuterAlt(_localctx, 3);
        setState(1513);
        match(ExpressParser::T__1);
        setState(1514);
        supertypeExpression();
        setState(1515);
        match(ExpressParser::T__3);
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- SyntaxContext ------------------------------------------------------------------

ExpressParser::SyntaxContext::SyntaxContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::SyntaxContext::EOF() {
  return getToken(ExpressParser::EOF, 0);
}

std::vector<ExpressParser::SchemaDeclContext *> ExpressParser::SyntaxContext::schemaDecl() {
  return getRuleContexts<ExpressParser::SchemaDeclContext>();
}

ExpressParser::SchemaDeclContext* ExpressParser::SyntaxContext::schemaDecl(size_t i) {
  return getRuleContext<ExpressParser::SchemaDeclContext>(i);
}


size_t ExpressParser::SyntaxContext::getRuleIndex() const {
  return ExpressParser::RuleSyntax;
}

void ExpressParser::SyntaxContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterSyntax(this);
}

void ExpressParser::SyntaxContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitSyntax(this);
}


antlrcpp::Any ExpressParser::SyntaxContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitSyntax(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::SyntaxContext* ExpressParser::syntax() {
  SyntaxContext *_localctx = _tracker.createInstance<SyntaxContext>(_ctx, getState());
  enterRule(_localctx, 362, ExpressParser::RuleSyntax);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1520); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(1519);
      schemaDecl();
      setState(1522); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == ExpressParser::SCHEMA);
    setState(1524);
    match(ExpressParser::EOF);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TermContext ------------------------------------------------------------------

ExpressParser::TermContext::TermContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::FactorContext *> ExpressParser::TermContext::factor() {
  return getRuleContexts<ExpressParser::FactorContext>();
}

ExpressParser::FactorContext* ExpressParser::TermContext::factor(size_t i) {
  return getRuleContext<ExpressParser::FactorContext>(i);
}

std::vector<ExpressParser::MultiplicationLikeOpContext *> ExpressParser::TermContext::multiplicationLikeOp() {
  return getRuleContexts<ExpressParser::MultiplicationLikeOpContext>();
}

ExpressParser::MultiplicationLikeOpContext* ExpressParser::TermContext::multiplicationLikeOp(size_t i) {
  return getRuleContext<ExpressParser::MultiplicationLikeOpContext>(i);
}


size_t ExpressParser::TermContext::getRuleIndex() const {
  return ExpressParser::RuleTerm;
}

void ExpressParser::TermContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTerm(this);
}

void ExpressParser::TermContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTerm(this);
}


antlrcpp::Any ExpressParser::TermContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTerm(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TermContext* ExpressParser::term() {
  TermContext *_localctx = _tracker.createInstance<TermContext>(_ctx, getState());
  enterRule(_localctx, 364, ExpressParser::RuleTerm);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1526);
    factor();
    setState(1532);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__18)
      | (1ULL << ExpressParser::T__19)
      | (1ULL << ExpressParser::T__20)
      | (1ULL << ExpressParser::AND)
      | (1ULL << ExpressParser::DIV))) != 0) || _la == ExpressParser::MOD) {
      setState(1527);
      multiplicationLikeOp();
      setState(1528);
      factor();
      setState(1534);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TotalOverContext ------------------------------------------------------------------

ExpressParser::TotalOverContext::TotalOverContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::TotalOverContext::TOTAL_OVER() {
  return getToken(ExpressParser::TOTAL_OVER, 0);
}

std::vector<ExpressParser::EntityRefContext *> ExpressParser::TotalOverContext::entityRef() {
  return getRuleContexts<ExpressParser::EntityRefContext>();
}

ExpressParser::EntityRefContext* ExpressParser::TotalOverContext::entityRef(size_t i) {
  return getRuleContext<ExpressParser::EntityRefContext>(i);
}


size_t ExpressParser::TotalOverContext::getRuleIndex() const {
  return ExpressParser::RuleTotalOver;
}

void ExpressParser::TotalOverContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTotalOver(this);
}

void ExpressParser::TotalOverContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTotalOver(this);
}


antlrcpp::Any ExpressParser::TotalOverContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTotalOver(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TotalOverContext* ExpressParser::totalOver() {
  TotalOverContext *_localctx = _tracker.createInstance<TotalOverContext>(_ctx, getState());
  enterRule(_localctx, 366, ExpressParser::RuleTotalOver);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1535);
    match(ExpressParser::TOTAL_OVER);
    setState(1536);
    match(ExpressParser::T__1);
    setState(1537);
    entityRef();
    setState(1542);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1538);
      match(ExpressParser::T__2);
      setState(1539);
      entityRef();
      setState(1544);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(1545);
    match(ExpressParser::T__3);
    setState(1546);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeDeclContext ------------------------------------------------------------------

ExpressParser::TypeDeclContext::TypeDeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::TypeDeclContext::TYPE() {
  return getToken(ExpressParser::TYPE, 0);
}

ExpressParser::TypeIdContext* ExpressParser::TypeDeclContext::typeId() {
  return getRuleContext<ExpressParser::TypeIdContext>(0);
}

ExpressParser::UnderlyingTypeContext* ExpressParser::TypeDeclContext::underlyingType() {
  return getRuleContext<ExpressParser::UnderlyingTypeContext>(0);
}

tree::TerminalNode* ExpressParser::TypeDeclContext::END_TYPE() {
  return getToken(ExpressParser::END_TYPE, 0);
}

ExpressParser::WhereClauseContext* ExpressParser::TypeDeclContext::whereClause() {
  return getRuleContext<ExpressParser::WhereClauseContext>(0);
}


size_t ExpressParser::TypeDeclContext::getRuleIndex() const {
  return ExpressParser::RuleTypeDecl;
}

void ExpressParser::TypeDeclContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeDecl(this);
}

void ExpressParser::TypeDeclContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeDecl(this);
}


antlrcpp::Any ExpressParser::TypeDeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeDecl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeDeclContext* ExpressParser::typeDecl() {
  TypeDeclContext *_localctx = _tracker.createInstance<TypeDeclContext>(_ctx, getState());
  enterRule(_localctx, 368, ExpressParser::RuleTypeDecl);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1548);
    match(ExpressParser::TYPE);
    setState(1549);
    typeId();
    setState(1550);
    match(ExpressParser::T__26);
    setState(1551);
    underlyingType();
    setState(1552);
    match(ExpressParser::T__0);
    setState(1554);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::WHERE) {
      setState(1553);
      whereClause();
    }
    setState(1556);
    match(ExpressParser::END_TYPE);
    setState(1557);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeIdContext ------------------------------------------------------------------

ExpressParser::TypeIdContext::TypeIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::TypeIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::TypeIdContext::getRuleIndex() const {
  return ExpressParser::RuleTypeId;
}

void ExpressParser::TypeIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeId(this);
}

void ExpressParser::TypeIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeId(this);
}


antlrcpp::Any ExpressParser::TypeIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeIdContext* ExpressParser::typeId() {
  TypeIdContext *_localctx = _tracker.createInstance<TypeIdContext>(_ctx, getState());
  enterRule(_localctx, 370, ExpressParser::RuleTypeId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1559);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeLabelContext ------------------------------------------------------------------

ExpressParser::TypeLabelContext::TypeLabelContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::TypeLabelIdContext* ExpressParser::TypeLabelContext::typeLabelId() {
  return getRuleContext<ExpressParser::TypeLabelIdContext>(0);
}

ExpressParser::TypeLabelRefContext* ExpressParser::TypeLabelContext::typeLabelRef() {
  return getRuleContext<ExpressParser::TypeLabelRefContext>(0);
}


size_t ExpressParser::TypeLabelContext::getRuleIndex() const {
  return ExpressParser::RuleTypeLabel;
}

void ExpressParser::TypeLabelContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeLabel(this);
}

void ExpressParser::TypeLabelContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeLabel(this);
}


antlrcpp::Any ExpressParser::TypeLabelContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeLabel(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeLabelContext* ExpressParser::typeLabel() {
  TypeLabelContext *_localctx = _tracker.createInstance<TypeLabelContext>(_ctx, getState());
  enterRule(_localctx, 372, ExpressParser::RuleTypeLabel);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1563);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 142, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(1561);
      typeLabelId();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(1562);
      typeLabelRef();
      break;
    }

    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeLabelIdContext ------------------------------------------------------------------

ExpressParser::TypeLabelIdContext::TypeLabelIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::TypeLabelIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::TypeLabelIdContext::getRuleIndex() const {
  return ExpressParser::RuleTypeLabelId;
}

void ExpressParser::TypeLabelIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterTypeLabelId(this);
}

void ExpressParser::TypeLabelIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitTypeLabelId(this);
}


antlrcpp::Any ExpressParser::TypeLabelIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitTypeLabelId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::TypeLabelIdContext* ExpressParser::typeLabelId() {
  TypeLabelIdContext *_localctx = _tracker.createInstance<TypeLabelIdContext>(_ctx, getState());
  enterRule(_localctx, 374, ExpressParser::RuleTypeLabelId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1565);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UnaryOpContext ------------------------------------------------------------------

ExpressParser::UnaryOpContext::UnaryOpContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::UnaryOpContext::NOT() {
  return getToken(ExpressParser::NOT, 0);
}


size_t ExpressParser::UnaryOpContext::getRuleIndex() const {
  return ExpressParser::RuleUnaryOp;
}

void ExpressParser::UnaryOpContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUnaryOp(this);
}

void ExpressParser::UnaryOpContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUnaryOp(this);
}


antlrcpp::Any ExpressParser::UnaryOpContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUnaryOp(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UnaryOpContext* ExpressParser::unaryOp() {
  UnaryOpContext *_localctx = _tracker.createInstance<UnaryOpContext>(_ctx, getState());
  enterRule(_localctx, 376, ExpressParser::RuleUnaryOp);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1567);
    _la = _input->LA(1);
    if (!(_la == ExpressParser::T__4

    || _la == ExpressParser::T__5 || _la == ExpressParser::NOT)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UnderlyingTypeContext ------------------------------------------------------------------

ExpressParser::UnderlyingTypeContext::UnderlyingTypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::ConcreteTypesContext* ExpressParser::UnderlyingTypeContext::concreteTypes() {
  return getRuleContext<ExpressParser::ConcreteTypesContext>(0);
}

ExpressParser::ConstructedTypesContext* ExpressParser::UnderlyingTypeContext::constructedTypes() {
  return getRuleContext<ExpressParser::ConstructedTypesContext>(0);
}


size_t ExpressParser::UnderlyingTypeContext::getRuleIndex() const {
  return ExpressParser::RuleUnderlyingType;
}

void ExpressParser::UnderlyingTypeContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUnderlyingType(this);
}

void ExpressParser::UnderlyingTypeContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUnderlyingType(this);
}


antlrcpp::Any ExpressParser::UnderlyingTypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUnderlyingType(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UnderlyingTypeContext* ExpressParser::underlyingType() {
  UnderlyingTypeContext *_localctx = _tracker.createInstance<UnderlyingTypeContext>(_ctx, getState());
  enterRule(_localctx, 378, ExpressParser::RuleUnderlyingType);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    setState(1571);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case ExpressParser::ARRAY:
      case ExpressParser::BAG:
      case ExpressParser::BINARY:
      case ExpressParser::BOOLEAN:
      case ExpressParser::INTEGER:
      case ExpressParser::LIST:
      case ExpressParser::LOGICAL:
      case ExpressParser::NUMBER:
      case ExpressParser::REAL:
      case ExpressParser::SET:
      case ExpressParser::STRING:
      case ExpressParser::SimpleId: {
        enterOuterAlt(_localctx, 1);
        setState(1569);
        concreteTypes();
        break;
      }

      case ExpressParser::ENUMERATION:
      case ExpressParser::EXTENSIBLE:
      case ExpressParser::SELECT: {
        enterOuterAlt(_localctx, 2);
        setState(1570);
        constructedTypes();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UniqueClauseContext ------------------------------------------------------------------

ExpressParser::UniqueClauseContext::UniqueClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::UniqueClauseContext::UNIQUE() {
  return getToken(ExpressParser::UNIQUE, 0);
}

std::vector<ExpressParser::UniqueRuleContext *> ExpressParser::UniqueClauseContext::uniqueRule() {
  return getRuleContexts<ExpressParser::UniqueRuleContext>();
}

ExpressParser::UniqueRuleContext* ExpressParser::UniqueClauseContext::uniqueRule(size_t i) {
  return getRuleContext<ExpressParser::UniqueRuleContext>(i);
}


size_t ExpressParser::UniqueClauseContext::getRuleIndex() const {
  return ExpressParser::RuleUniqueClause;
}

void ExpressParser::UniqueClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUniqueClause(this);
}

void ExpressParser::UniqueClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUniqueClause(this);
}


antlrcpp::Any ExpressParser::UniqueClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUniqueClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UniqueClauseContext* ExpressParser::uniqueClause() {
  UniqueClauseContext *_localctx = _tracker.createInstance<UniqueClauseContext>(_ctx, getState());
  enterRule(_localctx, 380, ExpressParser::RuleUniqueClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1573);
    match(ExpressParser::UNIQUE);
    setState(1574);
    uniqueRule();
    setState(1575);
    match(ExpressParser::T__0);
    setState(1581);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::SELF

    || _la == ExpressParser::SimpleId) {
      setState(1576);
      uniqueRule();
      setState(1577);
      match(ExpressParser::T__0);
      setState(1583);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UniqueRuleContext ------------------------------------------------------------------

ExpressParser::UniqueRuleContext::UniqueRuleContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<ExpressParser::ReferencedAttributeContext *> ExpressParser::UniqueRuleContext::referencedAttribute() {
  return getRuleContexts<ExpressParser::ReferencedAttributeContext>();
}

ExpressParser::ReferencedAttributeContext* ExpressParser::UniqueRuleContext::referencedAttribute(size_t i) {
  return getRuleContext<ExpressParser::ReferencedAttributeContext>(i);
}

ExpressParser::RuleLabelIdContext* ExpressParser::UniqueRuleContext::ruleLabelId() {
  return getRuleContext<ExpressParser::RuleLabelIdContext>(0);
}


size_t ExpressParser::UniqueRuleContext::getRuleIndex() const {
  return ExpressParser::RuleUniqueRule;
}

void ExpressParser::UniqueRuleContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUniqueRule(this);
}

void ExpressParser::UniqueRuleContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUniqueRule(this);
}


antlrcpp::Any ExpressParser::UniqueRuleContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUniqueRule(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UniqueRuleContext* ExpressParser::uniqueRule() {
  UniqueRuleContext *_localctx = _tracker.createInstance<UniqueRuleContext>(_ctx, getState());
  enterRule(_localctx, 382, ExpressParser::RuleUniqueRule);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1587);
    _errHandler->sync(this);

    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 145, _ctx)) {
    case 1: {
      setState(1584);
      ruleLabelId();
      setState(1585);
      match(ExpressParser::T__8);
      break;
    }

    }
    setState(1589);
    referencedAttribute();
    setState(1594);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == ExpressParser::T__2) {
      setState(1590);
      match(ExpressParser::T__2);
      setState(1591);
      referencedAttribute();
      setState(1596);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UntilControlContext ------------------------------------------------------------------

ExpressParser::UntilControlContext::UntilControlContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::UntilControlContext::UNTIL() {
  return getToken(ExpressParser::UNTIL, 0);
}

ExpressParser::LogicalExpressionContext* ExpressParser::UntilControlContext::logicalExpression() {
  return getRuleContext<ExpressParser::LogicalExpressionContext>(0);
}


size_t ExpressParser::UntilControlContext::getRuleIndex() const {
  return ExpressParser::RuleUntilControl;
}

void ExpressParser::UntilControlContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUntilControl(this);
}

void ExpressParser::UntilControlContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUntilControl(this);
}


antlrcpp::Any ExpressParser::UntilControlContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUntilControl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UntilControlContext* ExpressParser::untilControl() {
  UntilControlContext *_localctx = _tracker.createInstance<UntilControlContext>(_ctx, getState());
  enterRule(_localctx, 384, ExpressParser::RuleUntilControl);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1597);
    match(ExpressParser::UNTIL);
    setState(1598);
    logicalExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- UseClauseContext ------------------------------------------------------------------

ExpressParser::UseClauseContext::UseClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::UseClauseContext::USE() {
  return getToken(ExpressParser::USE, 0);
}

tree::TerminalNode* ExpressParser::UseClauseContext::FROM() {
  return getToken(ExpressParser::FROM, 0);
}

ExpressParser::SchemaRefContext* ExpressParser::UseClauseContext::schemaRef() {
  return getRuleContext<ExpressParser::SchemaRefContext>(0);
}

std::vector<ExpressParser::NamedTypeOrRenameContext *> ExpressParser::UseClauseContext::namedTypeOrRename() {
  return getRuleContexts<ExpressParser::NamedTypeOrRenameContext>();
}

ExpressParser::NamedTypeOrRenameContext* ExpressParser::UseClauseContext::namedTypeOrRename(size_t i) {
  return getRuleContext<ExpressParser::NamedTypeOrRenameContext>(i);
}


size_t ExpressParser::UseClauseContext::getRuleIndex() const {
  return ExpressParser::RuleUseClause;
}

void ExpressParser::UseClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterUseClause(this);
}

void ExpressParser::UseClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitUseClause(this);
}


antlrcpp::Any ExpressParser::UseClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitUseClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::UseClauseContext* ExpressParser::useClause() {
  UseClauseContext *_localctx = _tracker.createInstance<UseClauseContext>(_ctx, getState());
  enterRule(_localctx, 386, ExpressParser::RuleUseClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1600);
    match(ExpressParser::USE);
    setState(1601);
    match(ExpressParser::FROM);
    setState(1602);
    schemaRef();
    setState(1614);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::T__1) {
      setState(1603);
      match(ExpressParser::T__1);
      setState(1604);
      namedTypeOrRename();
      setState(1609);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == ExpressParser::T__2) {
        setState(1605);
        match(ExpressParser::T__2);
        setState(1606);
        namedTypeOrRename();
        setState(1611);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(1612);
      match(ExpressParser::T__3);
    }
    setState(1616);
    match(ExpressParser::T__0);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- VariableIdContext ------------------------------------------------------------------

ExpressParser::VariableIdContext::VariableIdContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::VariableIdContext::SimpleId() {
  return getToken(ExpressParser::SimpleId, 0);
}


size_t ExpressParser::VariableIdContext::getRuleIndex() const {
  return ExpressParser::RuleVariableId;
}

void ExpressParser::VariableIdContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterVariableId(this);
}

void ExpressParser::VariableIdContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitVariableId(this);
}


antlrcpp::Any ExpressParser::VariableIdContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitVariableId(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::VariableIdContext* ExpressParser::variableId() {
  VariableIdContext *_localctx = _tracker.createInstance<VariableIdContext>(_ctx, getState());
  enterRule(_localctx, 388, ExpressParser::RuleVariableId);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1618);
    match(ExpressParser::SimpleId);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- WhereClauseContext ------------------------------------------------------------------

ExpressParser::WhereClauseContext::WhereClauseContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::WhereClauseContext::WHERE() {
  return getToken(ExpressParser::WHERE, 0);
}

std::vector<ExpressParser::DomainRuleContext *> ExpressParser::WhereClauseContext::domainRule() {
  return getRuleContexts<ExpressParser::DomainRuleContext>();
}

ExpressParser::DomainRuleContext* ExpressParser::WhereClauseContext::domainRule(size_t i) {
  return getRuleContext<ExpressParser::DomainRuleContext>(i);
}


size_t ExpressParser::WhereClauseContext::getRuleIndex() const {
  return ExpressParser::RuleWhereClause;
}

void ExpressParser::WhereClauseContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterWhereClause(this);
}

void ExpressParser::WhereClauseContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitWhereClause(this);
}


antlrcpp::Any ExpressParser::WhereClauseContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitWhereClause(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::WhereClauseContext* ExpressParser::whereClause() {
  WhereClauseContext *_localctx = _tracker.createInstance<WhereClauseContext>(_ctx, getState());
  enterRule(_localctx, 390, ExpressParser::RuleWhereClause);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1620);
    match(ExpressParser::WHERE);
    setState(1621);
    domainRule();
    setState(1622);
    match(ExpressParser::T__0);
    setState(1628);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & ((1ULL << ExpressParser::T__1)
      | (1ULL << ExpressParser::T__4)
      | (1ULL << ExpressParser::T__5)
      | (1ULL << ExpressParser::T__6)
      | (1ULL << ExpressParser::T__11)
      | (1ULL << ExpressParser::T__14)
      | (1ULL << ExpressParser::ABS)
      | (1ULL << ExpressParser::ACOS)
      | (1ULL << ExpressParser::ASIN)
      | (1ULL << ExpressParser::ATAN)
      | (1ULL << ExpressParser::BLENGTH)
      | (1ULL << ExpressParser::CONST_E)
      | (1ULL << ExpressParser::COS))) != 0) || ((((_la - 72) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 72)) & ((1ULL << (ExpressParser::EXISTS - 72))
      | (1ULL << (ExpressParser::EXP - 72))
      | (1ULL << (ExpressParser::FALSE - 72))
      | (1ULL << (ExpressParser::FORMAT - 72))
      | (1ULL << (ExpressParser::HIBOUND - 72))
      | (1ULL << (ExpressParser::HIINDEX - 72))
      | (1ULL << (ExpressParser::LENGTH - 72))
      | (1ULL << (ExpressParser::LOBOUND - 72))
      | (1ULL << (ExpressParser::LOG - 72))
      | (1ULL << (ExpressParser::LOG10 - 72))
      | (1ULL << (ExpressParser::LOG2 - 72))
      | (1ULL << (ExpressParser::LOINDEX - 72))
      | (1ULL << (ExpressParser::NOT - 72))
      | (1ULL << (ExpressParser::NVL - 72))
      | (1ULL << (ExpressParser::ODD - 72))
      | (1ULL << (ExpressParser::PI - 72))
      | (1ULL << (ExpressParser::QUERY - 72))
      | (1ULL << (ExpressParser::ROLESOF - 72))
      | (1ULL << (ExpressParser::SELF - 72))
      | (1ULL << (ExpressParser::SIN - 72))
      | (1ULL << (ExpressParser::SIZEOF - 72))
      | (1ULL << (ExpressParser::SQRT - 72))
      | (1ULL << (ExpressParser::TAN - 72)))) != 0) || ((((_la - 136) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 136)) & ((1ULL << (ExpressParser::TRUE - 136))
      | (1ULL << (ExpressParser::TYPEOF - 136))
      | (1ULL << (ExpressParser::UNKNOWN - 136))
      | (1ULL << (ExpressParser::USEDIN - 136))
      | (1ULL << (ExpressParser::VALUE_ - 136))
      | (1ULL << (ExpressParser::VALUE_IN - 136))
      | (1ULL << (ExpressParser::VALUE_UNIQUE - 136))
      | (1ULL << (ExpressParser::BinaryLiteral - 136))
      | (1ULL << (ExpressParser::EncodedStringLiteral - 136))
      | (1ULL << (ExpressParser::IntegerLiteral - 136))
      | (1ULL << (ExpressParser::RealLiteral - 136))
      | (1ULL << (ExpressParser::SimpleId - 136))
      | (1ULL << (ExpressParser::SimpleStringLiteral - 136)))) != 0)) {
      setState(1623);
      domainRule();
      setState(1624);
      match(ExpressParser::T__0);
      setState(1630);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- WhileControlContext ------------------------------------------------------------------

ExpressParser::WhileControlContext::WhileControlContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* ExpressParser::WhileControlContext::WHILE() {
  return getToken(ExpressParser::WHILE, 0);
}

ExpressParser::LogicalExpressionContext* ExpressParser::WhileControlContext::logicalExpression() {
  return getRuleContext<ExpressParser::LogicalExpressionContext>(0);
}


size_t ExpressParser::WhileControlContext::getRuleIndex() const {
  return ExpressParser::RuleWhileControl;
}

void ExpressParser::WhileControlContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterWhileControl(this);
}

void ExpressParser::WhileControlContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitWhileControl(this);
}


antlrcpp::Any ExpressParser::WhileControlContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitWhileControl(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::WhileControlContext* ExpressParser::whileControl() {
  WhileControlContext *_localctx = _tracker.createInstance<WhileControlContext>(_ctx, getState());
  enterRule(_localctx, 392, ExpressParser::RuleWhileControl);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1631);
    match(ExpressParser::WHILE);
    setState(1632);
    logicalExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- WidthContext ------------------------------------------------------------------

ExpressParser::WidthContext::WidthContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::NumericExpressionContext* ExpressParser::WidthContext::numericExpression() {
  return getRuleContext<ExpressParser::NumericExpressionContext>(0);
}


size_t ExpressParser::WidthContext::getRuleIndex() const {
  return ExpressParser::RuleWidth;
}

void ExpressParser::WidthContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterWidth(this);
}

void ExpressParser::WidthContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitWidth(this);
}


antlrcpp::Any ExpressParser::WidthContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitWidth(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::WidthContext* ExpressParser::width() {
  WidthContext *_localctx = _tracker.createInstance<WidthContext>(_ctx, getState());
  enterRule(_localctx, 394, ExpressParser::RuleWidth);

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1634);
    numericExpression();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- WidthSpecContext ------------------------------------------------------------------

ExpressParser::WidthSpecContext::WidthSpecContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

ExpressParser::WidthContext* ExpressParser::WidthSpecContext::width() {
  return getRuleContext<ExpressParser::WidthContext>(0);
}

tree::TerminalNode* ExpressParser::WidthSpecContext::FIXED() {
  return getToken(ExpressParser::FIXED, 0);
}


size_t ExpressParser::WidthSpecContext::getRuleIndex() const {
  return ExpressParser::RuleWidthSpec;
}

void ExpressParser::WidthSpecContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterWidthSpec(this);
}

void ExpressParser::WidthSpecContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<ExpressListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitWidthSpec(this);
}


antlrcpp::Any ExpressParser::WidthSpecContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<ExpressVisitor*>(visitor))
    return parserVisitor->visitWidthSpec(this);
  else
    return visitor->visitChildren(this);
}

ExpressParser::WidthSpecContext* ExpressParser::widthSpec() {
  WidthSpecContext *_localctx = _tracker.createInstance<WidthSpecContext>(_ctx, getState());
  enterRule(_localctx, 396, ExpressParser::RuleWidthSpec);
  size_t _la = 0;

  auto onExit = finally([=] {
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(1636);
    match(ExpressParser::T__1);
    setState(1637);
    width();
    setState(1638);
    match(ExpressParser::T__3);
    setState(1640);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == ExpressParser::FIXED) {
      setState(1639);
      match(ExpressParser::FIXED);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

// Static vars and initialization.
std::vector<dfa::DFA> ExpressParser::_decisionToDFA;
atn::PredictionContextCache ExpressParser::_sharedContextCache;

// We own the ATN which in turn owns the ATN states.
atn::ATN ExpressParser::_atn;
std::vector<uint16_t> ExpressParser::_serializedATN;

std::vector<std::string> ExpressParser::_ruleNames = {
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
  "enumerationItem", "enumerationReference", "enumerationType", "escapeStmt", 
  "explicitAttr", "expression", "factor", "formalParameter", "functionCall", 
  "functionDecl", "functionHead", "functionId", "generalizedTypes", "generalAggregationTypes", 
  "generalArrayType", "generalBagType", "generalListType", "generalRef", 
  "generalSetType", "genericEntityType", "genericType", "groupQualifier", 
  "ifStmt", "ifStmtStatements", "ifStmtElseStatements", "increment", "incrementControl", 
  "index", "index1", "index2", "indexQualifier", "instantiableType", "integerType", 
  "interfaceSpecification", "interval", "intervalHigh", "intervalItem", 
  "intervalLow", "intervalOp", "inverseAttr", "inverseAttrType", "inverseClause", 
  "listType", "literal", "localDecl", "localVariable", "logicalExpression", 
  "logicalLiteral", "logicalType", "multiplicationLikeOp", "namedTypes", 
  "namedTypeOrRename", "nullStmt", "numberType", "numericExpression", "oneOf", 
  "parameter", "parameterId", "parameterType", "population", "precisionSpec", 
  "primary", "procedureCallStmt", "procedureDecl", "procedureHead", "procedureHeadParameter", 
  "procedureId", "qualifiableFactor", "qualifiedAttribute", "qualifier", 
  "queryExpression", "realType", "redeclaredAttribute", "referencedAttribute", 
  "referenceClause", "relOp", "relOpExtended", "renameId", "repeatControl", 
  "repeatStmt", "repetition", "resourceOrRename", "resourceRef", "returnStmt", 
  "ruleDecl", "ruleHead", "ruleId", "ruleLabelId", "schemaBody", "schemaBodyDeclaration", 
  "schemaDecl", "schemaId", "schemaVersionId", "selector", "selectExtension", 
  "selectList", "selectType", "setType", "simpleExpression", "simpleFactor", 
  "simpleFactorExpression", "simpleFactorUnaryExpression", "simpleTypes", 
  "skipStmt", "stmt", "stringLiteral", "stringType", "subsuper", "subtypeConstraint", 
  "subtypeConstraintBody", "subtypeConstraintDecl", "subtypeConstraintHead", 
  "subtypeConstraintId", "subtypeDeclaration", "supertypeConstraint", "supertypeExpression", 
  "supertypeFactor", "supertypeRule", "supertypeTerm", "syntax", "term", 
  "totalOver", "typeDecl", "typeId", "typeLabel", "typeLabelId", "unaryOp", 
  "underlyingType", "uniqueClause", "uniqueRule", "untilControl", "useClause", 
  "variableId", "whereClause", "whileControl", "width", "widthSpec"
};

std::vector<std::string> ExpressParser::_literalNames = {
  "", "';'", "'('", "','", "')'", "'+'", "'-'", "'['", "']'", "':'", "':='", 
  "'.'", "'?'", "'**'", "'\\'", "'{'", "'}'", "'<'", "'<='", "'*'", "'/'", 
  "'||'", "'<*'", "'|'", "'>'", "'>='", "'<>'", "'='", "':<>:'", "':=:'"
};

std::vector<std::string> ExpressParser::_symbolicNames = {
  "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
  "", "", "", "", "", "", "", "", "", "", "", "", "ABS", "ABSTRACT", "ACOS", 
  "AGGREGATE", "ALIAS", "AND", "ANDOR", "ARRAY", "AS", "ASIN", "ATAN", "BAG", 
  "BASED_ON", "BEGIN_", "BINARY", "BLENGTH", "BOOLEAN", "BY", "CASE", "CONSTANT", 
  "CONST_E", "COS", "DERIVE", "DIV", "ELSE", "END_", "END_ALIAS", "END_CASE", 
  "END_CONSTANT", "END_ENTITY", "END_FUNCTION", "END_IF", "END_LOCAL", "END_PROCEDURE", 
  "END_REPEAT", "END_RULE", "END_SCHEMA", "END_SUBTYPE_CONSTRAINT", "END_TYPE", 
  "ENTITY", "ENUMERATION", "ESCAPE", "EXISTS", "EXP", "EXTENSIBLE", "FALSE", 
  "FIXED", "FOR", "FORMAT", "FROM", "FUNCTION", "GENERIC", "GENERIC_ENTITY", 
  "HIBOUND", "HIINDEX", "IF", "IN", "INSERT", "INTEGER", "INVERSE", "LENGTH", 
  "LIKE", "LIST", "LOBOUND", "LOCAL", "LOG", "LOG10", "LOG2", "LOGICAL", 
  "LOINDEX", "MOD", "NOT", "NUMBER", "NVL", "ODD", "OF", "ONEOF", "OPTIONAL", 
  "OR", "OTHERWISE", "PI", "PROCEDURE", "QUERY", "REAL", "REFERENCE", "REMOVE", 
  "RENAMED", "REPEAT", "RETURN", "ROLESOF", "RULE", "SCHEMA", "SELECT", 
  "SELF", "SET", "SIN", "SIZEOF", "SKIP_", "SQRT", "STRING", "SUBTYPE", 
  "SUBTYPE_CONSTRAINT", "SUPERTYPE", "TAN", "THEN", "TO", "TRUE", "TYPE", 
  "TYPEOF", "TOTAL_OVER", "UNIQUE", "UNKNOWN", "UNTIL", "USE", "USEDIN", 
  "VALUE_", "VALUE_IN", "VALUE_UNIQUE", "VAR", "WITH", "WHERE", "WHILE", 
  "XOR", "BinaryLiteral", "EncodedStringLiteral", "IntegerLiteral", "RealLiteral", 
  "SimpleId", "SimpleStringLiteral", "EmbeddedRemark", "TailRemark", "Whitespace"
};

dfa::Vocabulary ExpressParser::_vocabulary(_literalNames, _symbolicNames);

std::vector<std::string> ExpressParser::_tokenNames;

ExpressParser::Initializer::Initializer() {
	for (size_t i = 0; i < _symbolicNames.size(); ++i) {
		std::string name = _vocabulary.getLiteralName(i);
		if (name.empty()) {
			name = _vocabulary.getSymbolicName(i);
		}

		if (name.empty()) {
			_tokenNames.push_back("<INVALID>");
		} else {
      _tokenNames.push_back(name);
    }
	}

  _serializedATN = {
    0x3, 0x608b, 0xa72a, 0x8133, 0xb9ed, 0x417c, 0x3be7, 0x7786, 0x5964, 
    0x3, 0xa3, 0x66d, 0x4, 0x2, 0x9, 0x2, 0x4, 0x3, 0x9, 0x3, 0x4, 0x4, 
    0x9, 0x4, 0x4, 0x5, 0x9, 0x5, 0x4, 0x6, 0x9, 0x6, 0x4, 0x7, 0x9, 0x7, 
    0x4, 0x8, 0x9, 0x8, 0x4, 0x9, 0x9, 0x9, 0x4, 0xa, 0x9, 0xa, 0x4, 0xb, 
    0x9, 0xb, 0x4, 0xc, 0x9, 0xc, 0x4, 0xd, 0x9, 0xd, 0x4, 0xe, 0x9, 0xe, 
    0x4, 0xf, 0x9, 0xf, 0x4, 0x10, 0x9, 0x10, 0x4, 0x11, 0x9, 0x11, 0x4, 
    0x12, 0x9, 0x12, 0x4, 0x13, 0x9, 0x13, 0x4, 0x14, 0x9, 0x14, 0x4, 0x15, 
    0x9, 0x15, 0x4, 0x16, 0x9, 0x16, 0x4, 0x17, 0x9, 0x17, 0x4, 0x18, 0x9, 
    0x18, 0x4, 0x19, 0x9, 0x19, 0x4, 0x1a, 0x9, 0x1a, 0x4, 0x1b, 0x9, 0x1b, 
    0x4, 0x1c, 0x9, 0x1c, 0x4, 0x1d, 0x9, 0x1d, 0x4, 0x1e, 0x9, 0x1e, 0x4, 
    0x1f, 0x9, 0x1f, 0x4, 0x20, 0x9, 0x20, 0x4, 0x21, 0x9, 0x21, 0x4, 0x22, 
    0x9, 0x22, 0x4, 0x23, 0x9, 0x23, 0x4, 0x24, 0x9, 0x24, 0x4, 0x25, 0x9, 
    0x25, 0x4, 0x26, 0x9, 0x26, 0x4, 0x27, 0x9, 0x27, 0x4, 0x28, 0x9, 0x28, 
    0x4, 0x29, 0x9, 0x29, 0x4, 0x2a, 0x9, 0x2a, 0x4, 0x2b, 0x9, 0x2b, 0x4, 
    0x2c, 0x9, 0x2c, 0x4, 0x2d, 0x9, 0x2d, 0x4, 0x2e, 0x9, 0x2e, 0x4, 0x2f, 
    0x9, 0x2f, 0x4, 0x30, 0x9, 0x30, 0x4, 0x31, 0x9, 0x31, 0x4, 0x32, 0x9, 
    0x32, 0x4, 0x33, 0x9, 0x33, 0x4, 0x34, 0x9, 0x34, 0x4, 0x35, 0x9, 0x35, 
    0x4, 0x36, 0x9, 0x36, 0x4, 0x37, 0x9, 0x37, 0x4, 0x38, 0x9, 0x38, 0x4, 
    0x39, 0x9, 0x39, 0x4, 0x3a, 0x9, 0x3a, 0x4, 0x3b, 0x9, 0x3b, 0x4, 0x3c, 
    0x9, 0x3c, 0x4, 0x3d, 0x9, 0x3d, 0x4, 0x3e, 0x9, 0x3e, 0x4, 0x3f, 0x9, 
    0x3f, 0x4, 0x40, 0x9, 0x40, 0x4, 0x41, 0x9, 0x41, 0x4, 0x42, 0x9, 0x42, 
    0x4, 0x43, 0x9, 0x43, 0x4, 0x44, 0x9, 0x44, 0x4, 0x45, 0x9, 0x45, 0x4, 
    0x46, 0x9, 0x46, 0x4, 0x47, 0x9, 0x47, 0x4, 0x48, 0x9, 0x48, 0x4, 0x49, 
    0x9, 0x49, 0x4, 0x4a, 0x9, 0x4a, 0x4, 0x4b, 0x9, 0x4b, 0x4, 0x4c, 0x9, 
    0x4c, 0x4, 0x4d, 0x9, 0x4d, 0x4, 0x4e, 0x9, 0x4e, 0x4, 0x4f, 0x9, 0x4f, 
    0x4, 0x50, 0x9, 0x50, 0x4, 0x51, 0x9, 0x51, 0x4, 0x52, 0x9, 0x52, 0x4, 
    0x53, 0x9, 0x53, 0x4, 0x54, 0x9, 0x54, 0x4, 0x55, 0x9, 0x55, 0x4, 0x56, 
    0x9, 0x56, 0x4, 0x57, 0x9, 0x57, 0x4, 0x58, 0x9, 0x58, 0x4, 0x59, 0x9, 
    0x59, 0x4, 0x5a, 0x9, 0x5a, 0x4, 0x5b, 0x9, 0x5b, 0x4, 0x5c, 0x9, 0x5c, 
    0x4, 0x5d, 0x9, 0x5d, 0x4, 0x5e, 0x9, 0x5e, 0x4, 0x5f, 0x9, 0x5f, 0x4, 
    0x60, 0x9, 0x60, 0x4, 0x61, 0x9, 0x61, 0x4, 0x62, 0x9, 0x62, 0x4, 0x63, 
    0x9, 0x63, 0x4, 0x64, 0x9, 0x64, 0x4, 0x65, 0x9, 0x65, 0x4, 0x66, 0x9, 
    0x66, 0x4, 0x67, 0x9, 0x67, 0x4, 0x68, 0x9, 0x68, 0x4, 0x69, 0x9, 0x69, 
    0x4, 0x6a, 0x9, 0x6a, 0x4, 0x6b, 0x9, 0x6b, 0x4, 0x6c, 0x9, 0x6c, 0x4, 
    0x6d, 0x9, 0x6d, 0x4, 0x6e, 0x9, 0x6e, 0x4, 0x6f, 0x9, 0x6f, 0x4, 0x70, 
    0x9, 0x70, 0x4, 0x71, 0x9, 0x71, 0x4, 0x72, 0x9, 0x72, 0x4, 0x73, 0x9, 
    0x73, 0x4, 0x74, 0x9, 0x74, 0x4, 0x75, 0x9, 0x75, 0x4, 0x76, 0x9, 0x76, 
    0x4, 0x77, 0x9, 0x77, 0x4, 0x78, 0x9, 0x78, 0x4, 0x79, 0x9, 0x79, 0x4, 
    0x7a, 0x9, 0x7a, 0x4, 0x7b, 0x9, 0x7b, 0x4, 0x7c, 0x9, 0x7c, 0x4, 0x7d, 
    0x9, 0x7d, 0x4, 0x7e, 0x9, 0x7e, 0x4, 0x7f, 0x9, 0x7f, 0x4, 0x80, 0x9, 
    0x80, 0x4, 0x81, 0x9, 0x81, 0x4, 0x82, 0x9, 0x82, 0x4, 0x83, 0x9, 0x83, 
    0x4, 0x84, 0x9, 0x84, 0x4, 0x85, 0x9, 0x85, 0x4, 0x86, 0x9, 0x86, 0x4, 
    0x87, 0x9, 0x87, 0x4, 0x88, 0x9, 0x88, 0x4, 0x89, 0x9, 0x89, 0x4, 0x8a, 
    0x9, 0x8a, 0x4, 0x8b, 0x9, 0x8b, 0x4, 0x8c, 0x9, 0x8c, 0x4, 0x8d, 0x9, 
    0x8d, 0x4, 0x8e, 0x9, 0x8e, 0x4, 0x8f, 0x9, 0x8f, 0x4, 0x90, 0x9, 0x90, 
    0x4, 0x91, 0x9, 0x91, 0x4, 0x92, 0x9, 0x92, 0x4, 0x93, 0x9, 0x93, 0x4, 
    0x94, 0x9, 0x94, 0x4, 0x95, 0x9, 0x95, 0x4, 0x96, 0x9, 0x96, 0x4, 0x97, 
    0x9, 0x97, 0x4, 0x98, 0x9, 0x98, 0x4, 0x99, 0x9, 0x99, 0x4, 0x9a, 0x9, 
    0x9a, 0x4, 0x9b, 0x9, 0x9b, 0x4, 0x9c, 0x9, 0x9c, 0x4, 0x9d, 0x9, 0x9d, 
    0x4, 0x9e, 0x9, 0x9e, 0x4, 0x9f, 0x9, 0x9f, 0x4, 0xa0, 0x9, 0xa0, 0x4, 
    0xa1, 0x9, 0xa1, 0x4, 0xa2, 0x9, 0xa2, 0x4, 0xa3, 0x9, 0xa3, 0x4, 0xa4, 
    0x9, 0xa4, 0x4, 0xa5, 0x9, 0xa5, 0x4, 0xa6, 0x9, 0xa6, 0x4, 0xa7, 0x9, 
    0xa7, 0x4, 0xa8, 0x9, 0xa8, 0x4, 0xa9, 0x9, 0xa9, 0x4, 0xaa, 0x9, 0xaa, 
    0x4, 0xab, 0x9, 0xab, 0x4, 0xac, 0x9, 0xac, 0x4, 0xad, 0x9, 0xad, 0x4, 
    0xae, 0x9, 0xae, 0x4, 0xaf, 0x9, 0xaf, 0x4, 0xb0, 0x9, 0xb0, 0x4, 0xb1, 
    0x9, 0xb1, 0x4, 0xb2, 0x9, 0xb2, 0x4, 0xb3, 0x9, 0xb3, 0x4, 0xb4, 0x9, 
    0xb4, 0x4, 0xb5, 0x9, 0xb5, 0x4, 0xb6, 0x9, 0xb6, 0x4, 0xb7, 0x9, 0xb7, 
    0x4, 0xb8, 0x9, 0xb8, 0x4, 0xb9, 0x9, 0xb9, 0x4, 0xba, 0x9, 0xba, 0x4, 
    0xbb, 0x9, 0xbb, 0x4, 0xbc, 0x9, 0xbc, 0x4, 0xbd, 0x9, 0xbd, 0x4, 0xbe, 
    0x9, 0xbe, 0x4, 0xbf, 0x9, 0xbf, 0x4, 0xc0, 0x9, 0xc0, 0x4, 0xc1, 0x9, 
    0xc1, 0x4, 0xc2, 0x9, 0xc2, 0x4, 0xc3, 0x9, 0xc3, 0x4, 0xc4, 0x9, 0xc4, 
    0x4, 0xc5, 0x9, 0xc5, 0x4, 0xc6, 0x9, 0xc6, 0x4, 0xc7, 0x9, 0xc7, 0x4, 
    0xc8, 0x9, 0xc8, 0x3, 0x2, 0x3, 0x2, 0x3, 0x3, 0x3, 0x3, 0x3, 0x4, 0x3, 
    0x4, 0x3, 0x5, 0x3, 0x5, 0x3, 0x6, 0x3, 0x6, 0x3, 0x7, 0x3, 0x7, 0x3, 
    0x8, 0x3, 0x8, 0x3, 0x9, 0x3, 0x9, 0x3, 0xa, 0x3, 0xa, 0x3, 0xb, 0x3, 
    0xb, 0x3, 0xc, 0x3, 0xc, 0x3, 0xd, 0x3, 0xd, 0x3, 0xe, 0x3, 0xe, 0x3, 
    0xf, 0x3, 0xf, 0x3, 0x10, 0x3, 0x10, 0x3, 0x11, 0x3, 0x11, 0x3, 0x11, 
    0x3, 0x11, 0x3, 0x12, 0x3, 0x12, 0x3, 0x12, 0x5, 0x12, 0x1b6, 0xa, 0x12, 
    0x3, 0x13, 0x3, 0x13, 0x3, 0x13, 0x3, 0x13, 0x7, 0x13, 0x1bc, 0xa, 0x13, 
    0xc, 0x13, 0xe, 0x13, 0x1bf, 0xb, 0x13, 0x3, 0x13, 0x3, 0x13, 0x3, 0x14, 
    0x3, 0x14, 0x3, 0x15, 0x3, 0x15, 0x3, 0x15, 0x3, 0x15, 0x7, 0x15, 0x1c9, 
    0xa, 0x15, 0xc, 0x15, 0xe, 0x15, 0x1cc, 0xb, 0x15, 0x5, 0x15, 0x1ce, 
    0xa, 0x15, 0x3, 0x15, 0x3, 0x15, 0x3, 0x16, 0x3, 0x16, 0x3, 0x17, 0x3, 
    0x17, 0x3, 0x17, 0x5, 0x17, 0x1d7, 0xa, 0x17, 0x3, 0x17, 0x3, 0x17, 
    0x3, 0x17, 0x3, 0x18, 0x3, 0x18, 0x3, 0x18, 0x3, 0x18, 0x5, 0x18, 0x1e0, 
    0xa, 0x18, 0x3, 0x19, 0x7, 0x19, 0x1e3, 0xa, 0x19, 0xc, 0x19, 0xe, 0x19, 
    0x1e6, 0xb, 0x19, 0x3, 0x19, 0x5, 0x19, 0x1e9, 0xa, 0x19, 0x3, 0x19, 
    0x5, 0x19, 0x1ec, 0xa, 0x19, 0x3, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 
    0x3, 0x1a, 0x7, 0x1a, 0x1f3, 0xa, 0x1a, 0xc, 0x1a, 0xe, 0x1a, 0x1f6, 
    0xb, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 0x7, 0x1a, 0x1fb, 0xa, 0x1a, 
    0xc, 0x1a, 0xe, 0x1a, 0x1fe, 0xb, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 0x3, 0x1a, 
    0x3, 0x1b, 0x3, 0x1b, 0x3, 0x1b, 0x3, 0x1b, 0x5, 0x1b, 0x207, 0xa, 0x1b, 
    0x3, 0x1b, 0x5, 0x1b, 0x20a, 0xa, 0x1b, 0x3, 0x1b, 0x3, 0x1b, 0x3, 0x1c, 
    0x3, 0x1c, 0x7, 0x1c, 0x210, 0xa, 0x1c, 0xc, 0x1c, 0xe, 0x1c, 0x213, 
    0xb, 0x1c, 0x3, 0x1c, 0x3, 0x1c, 0x3, 0x1c, 0x3, 0x1c, 0x3, 0x1d, 0x3, 
    0x1d, 0x5, 0x1d, 0x21b, 0xa, 0x1d, 0x3, 0x1e, 0x3, 0x1e, 0x3, 0x1f, 
    0x3, 0x1f, 0x3, 0x1f, 0x3, 0x20, 0x3, 0x20, 0x5, 0x20, 0x224, 0xa, 0x20, 
    0x3, 0x20, 0x3, 0x20, 0x3, 0x20, 0x3, 0x21, 0x3, 0x21, 0x5, 0x21, 0x22b, 
    0xa, 0x21, 0x3, 0x22, 0x3, 0x22, 0x3, 0x23, 0x3, 0x23, 0x3, 0x24, 0x3, 
    0x24, 0x3, 0x25, 0x3, 0x25, 0x3, 0x25, 0x3, 0x25, 0x3, 0x25, 0x3, 0x25, 
    0x3, 0x26, 0x3, 0x26, 0x3, 0x27, 0x3, 0x27, 0x3, 0x28, 0x3, 0x28, 0x3, 
    0x29, 0x3, 0x29, 0x3, 0x29, 0x7, 0x29, 0x242, 0xa, 0x29, 0xc, 0x29, 
    0xe, 0x29, 0x245, 0xb, 0x29, 0x3, 0x29, 0x3, 0x29, 0x3, 0x29, 0x3, 0x2a, 
    0x3, 0x2a, 0x3, 0x2b, 0x3, 0x2b, 0x3, 0x2b, 0x3, 0x2b, 0x7, 0x2b, 0x250, 
    0xa, 0x2b, 0xc, 0x2b, 0xe, 0x2b, 0x253, 0xb, 0x2b, 0x3, 0x2b, 0x3, 0x2b, 
    0x3, 0x2b, 0x5, 0x2b, 0x258, 0xa, 0x2b, 0x3, 0x2b, 0x3, 0x2b, 0x3, 0x2b, 
    0x3, 0x2c, 0x3, 0x2c, 0x3, 0x2c, 0x7, 0x2c, 0x260, 0xa, 0x2c, 0xc, 0x2c, 
    0xe, 0x2c, 0x263, 0xb, 0x2c, 0x3, 0x2c, 0x3, 0x2c, 0x3, 0x2c, 0x3, 0x2d, 
    0x3, 0x2d, 0x3, 0x2d, 0x5, 0x2d, 0x26b, 0xa, 0x2d, 0x3, 0x2e, 0x3, 0x2e, 
    0x3, 0x2e, 0x3, 0x2e, 0x3, 0x2e, 0x3, 0x2e, 0x3, 0x2e, 0x3, 0x2f, 0x3, 
    0x2f, 0x3, 0x2f, 0x7, 0x2f, 0x277, 0xa, 0x2f, 0xc, 0x2f, 0xe, 0x2f, 
    0x27a, 0xb, 0x2f, 0x3, 0x2f, 0x3, 0x2f, 0x3, 0x2f, 0x3, 0x30, 0x3, 0x30, 
    0x5, 0x30, 0x281, 0xa, 0x30, 0x3, 0x31, 0x3, 0x31, 0x3, 0x32, 0x3, 0x32, 
    0x5, 0x32, 0x287, 0xa, 0x32, 0x3, 0x33, 0x3, 0x33, 0x3, 0x33, 0x3, 0x33, 
    0x3, 0x33, 0x5, 0x33, 0x28e, 0xa, 0x33, 0x3, 0x34, 0x3, 0x34, 0x3, 0x34, 
    0x3, 0x34, 0x3, 0x34, 0x3, 0x34, 0x3, 0x34, 0x3, 0x35, 0x3, 0x35, 0x3, 
    0x35, 0x7, 0x35, 0x29a, 0xa, 0x35, 0xc, 0x35, 0xe, 0x35, 0x29d, 0xb, 
    0x35, 0x3, 0x36, 0x3, 0x36, 0x3, 0x36, 0x5, 0x36, 0x2a2, 0xa, 0x36, 
    0x3, 0x36, 0x3, 0x36, 0x3, 0x37, 0x3, 0x37, 0x3, 0x37, 0x5, 0x37, 0x2a9, 
    0xa, 0x37, 0x3, 0x38, 0x7, 0x38, 0x2ac, 0xa, 0x38, 0xc, 0x38, 0xe, 0x38, 
    0x2af, 0xb, 0x38, 0x3, 0x38, 0x5, 0x38, 0x2b2, 0xa, 0x38, 0x3, 0x38, 
    0x5, 0x38, 0x2b5, 0xa, 0x38, 0x3, 0x38, 0x5, 0x38, 0x2b8, 0xa, 0x38, 
    0x3, 0x38, 0x5, 0x38, 0x2bb, 0xa, 0x38, 0x3, 0x39, 0x3, 0x39, 0x3, 0x39, 
    0x3, 0x39, 0x3, 0x39, 0x7, 0x39, 0x2c2, 0xa, 0x39, 0xc, 0x39, 0xe, 0x39, 
    0x2c5, 0xb, 0x39, 0x5, 0x39, 0x2c7, 0xa, 0x39, 0x3, 0x39, 0x3, 0x39, 
    0x3, 0x3a, 0x3, 0x3a, 0x3, 0x3a, 0x3, 0x3a, 0x3, 0x3a, 0x3, 0x3b, 0x3, 
    0x3b, 0x3, 0x3b, 0x3, 0x3b, 0x3, 0x3b, 0x3, 0x3c, 0x3, 0x3c, 0x3, 0x3d, 
    0x3, 0x3d, 0x3, 0x3d, 0x3, 0x3d, 0x5, 0x3d, 0x2db, 0xa, 0x3d, 0x3, 0x3e, 
    0x3, 0x3e, 0x3, 0x3f, 0x3, 0x3f, 0x3, 0x3f, 0x3, 0x3f, 0x7, 0x3f, 0x2e3, 
    0xa, 0x3f, 0xc, 0x3f, 0xe, 0x3f, 0x2e6, 0xb, 0x3f, 0x3, 0x3f, 0x3, 0x3f, 
    0x3, 0x40, 0x3, 0x40, 0x3, 0x41, 0x3, 0x41, 0x3, 0x41, 0x5, 0x41, 0x2ef, 
    0xa, 0x41, 0x3, 0x41, 0x3, 0x41, 0x3, 0x42, 0x5, 0x42, 0x2f4, 0xa, 0x42, 
    0x3, 0x42, 0x3, 0x42, 0x3, 0x42, 0x3, 0x42, 0x5, 0x42, 0x2fa, 0xa, 0x42, 
    0x3, 0x43, 0x3, 0x43, 0x3, 0x43, 0x3, 0x44, 0x3, 0x44, 0x3, 0x44, 0x7, 
    0x44, 0x302, 0xa, 0x44, 0xc, 0x44, 0xe, 0x44, 0x305, 0xb, 0x44, 0x3, 
    0x44, 0x3, 0x44, 0x5, 0x44, 0x309, 0xa, 0x44, 0x3, 0x44, 0x3, 0x44, 
    0x3, 0x44, 0x3, 0x45, 0x3, 0x45, 0x3, 0x45, 0x3, 0x45, 0x5, 0x45, 0x312, 
    0xa, 0x45, 0x3, 0x46, 0x3, 0x46, 0x3, 0x46, 0x5, 0x46, 0x317, 0xa, 0x46, 
    0x3, 0x47, 0x3, 0x47, 0x3, 0x47, 0x7, 0x47, 0x31c, 0xa, 0x47, 0xc, 0x47, 
    0xe, 0x47, 0x31f, 0xb, 0x47, 0x3, 0x47, 0x3, 0x47, 0x3, 0x47, 0x3, 0x48, 
    0x3, 0x48, 0x5, 0x48, 0x326, 0xa, 0x48, 0x3, 0x48, 0x5, 0x48, 0x329, 
    0xa, 0x48, 0x3, 0x49, 0x3, 0x49, 0x3, 0x49, 0x3, 0x49, 0x7, 0x49, 0x32f, 
    0xa, 0x49, 0xc, 0x49, 0xe, 0x49, 0x332, 0xb, 0x49, 0x3, 0x49, 0x3, 0x49, 
    0x3, 0x49, 0x3, 0x4a, 0x3, 0x4a, 0x3, 0x4a, 0x3, 0x4a, 0x3, 0x4a, 0x3, 
    0x4a, 0x7, 0x4a, 0x33d, 0xa, 0x4a, 0xc, 0x4a, 0xe, 0x4a, 0x340, 0xb, 
    0x4a, 0x3, 0x4a, 0x3, 0x4a, 0x5, 0x4a, 0x344, 0xa, 0x4a, 0x3, 0x4a, 
    0x3, 0x4a, 0x3, 0x4a, 0x3, 0x4a, 0x3, 0x4b, 0x3, 0x4b, 0x3, 0x4c, 0x3, 
    0x4c, 0x3, 0x4c, 0x3, 0x4c, 0x5, 0x4c, 0x350, 0xa, 0x4c, 0x3, 0x4d, 
    0x3, 0x4d, 0x3, 0x4d, 0x3, 0x4d, 0x5, 0x4d, 0x356, 0xa, 0x4d, 0x3, 0x4e, 
    0x3, 0x4e, 0x5, 0x4e, 0x35a, 0xa, 0x4e, 0x3, 0x4e, 0x3, 0x4e, 0x5, 0x4e, 
    0x35e, 0xa, 0x4e, 0x3, 0x4e, 0x5, 0x4e, 0x361, 0xa, 0x4e, 0x3, 0x4e, 
    0x3, 0x4e, 0x3, 0x4f, 0x3, 0x4f, 0x5, 0x4f, 0x367, 0xa, 0x4f, 0x3, 0x4f, 
    0x3, 0x4f, 0x3, 0x4f, 0x3, 0x50, 0x3, 0x50, 0x5, 0x50, 0x36e, 0xa, 0x50, 
    0x3, 0x50, 0x3, 0x50, 0x5, 0x50, 0x372, 0xa, 0x50, 0x3, 0x50, 0x3, 0x50, 
    0x3, 0x51, 0x3, 0x51, 0x5, 0x51, 0x378, 0xa, 0x51, 0x3, 0x52, 0x3, 0x52, 
    0x5, 0x52, 0x37c, 0xa, 0x52, 0x3, 0x52, 0x3, 0x52, 0x3, 0x52, 0x3, 0x53, 
    0x3, 0x53, 0x3, 0x53, 0x5, 0x53, 0x384, 0xa, 0x53, 0x3, 0x54, 0x3, 0x54, 
    0x3, 0x54, 0x5, 0x54, 0x389, 0xa, 0x54, 0x3, 0x55, 0x3, 0x55, 0x3, 0x55, 
    0x3, 0x56, 0x3, 0x56, 0x3, 0x56, 0x3, 0x56, 0x3, 0x56, 0x3, 0x56, 0x5, 
    0x56, 0x394, 0xa, 0x56, 0x3, 0x56, 0x3, 0x56, 0x3, 0x56, 0x3, 0x57, 
    0x3, 0x57, 0x7, 0x57, 0x39b, 0xa, 0x57, 0xc, 0x57, 0xe, 0x57, 0x39e, 
    0xb, 0x57, 0x3, 0x58, 0x3, 0x58, 0x7, 0x58, 0x3a2, 0xa, 0x58, 0xc, 0x58, 
    0xe, 0x58, 0x3a5, 0xb, 0x58, 0x3, 0x59, 0x3, 0x59, 0x3, 0x5a, 0x3, 0x5a, 
    0x3, 0x5a, 0x3, 0x5a, 0x3, 0x5a, 0x3, 0x5a, 0x3, 0x5a, 0x5, 0x5a, 0x3b0, 
    0xa, 0x5a, 0x3, 0x5b, 0x3, 0x5b, 0x3, 0x5c, 0x3, 0x5c, 0x3, 0x5d, 0x3, 
    0x5d, 0x3, 0x5e, 0x3, 0x5e, 0x3, 0x5e, 0x3, 0x5e, 0x5, 0x5e, 0x3bc, 
    0xa, 0x5e, 0x3, 0x5e, 0x3, 0x5e, 0x3, 0x5f, 0x3, 0x5f, 0x5, 0x5f, 0x3c2, 
    0xa, 0x5f, 0x3, 0x60, 0x3, 0x60, 0x3, 0x61, 0x3, 0x61, 0x5, 0x61, 0x3c8, 
    0xa, 0x61, 0x3, 0x62, 0x3, 0x62, 0x3, 0x62, 0x3, 0x62, 0x3, 0x62, 0x3, 
    0x62, 0x3, 0x62, 0x3, 0x62, 0x3, 0x63, 0x3, 0x63, 0x3, 0x64, 0x3, 0x64, 
    0x3, 0x65, 0x3, 0x65, 0x3, 0x66, 0x3, 0x66, 0x3, 0x67, 0x3, 0x67, 0x3, 
    0x67, 0x3, 0x67, 0x3, 0x67, 0x3, 0x67, 0x3, 0x67, 0x5, 0x67, 0x3e1, 
    0xa, 0x67, 0x3, 0x67, 0x3, 0x67, 0x3, 0x67, 0x3, 0x68, 0x3, 0x68, 0x5, 
    0x68, 0x3e8, 0xa, 0x68, 0x3, 0x68, 0x5, 0x68, 0x3eb, 0xa, 0x68, 0x3, 
    0x68, 0x3, 0x68, 0x3, 0x69, 0x3, 0x69, 0x3, 0x69, 0x7, 0x69, 0x3f2, 
    0xa, 0x69, 0xc, 0x69, 0xe, 0x69, 0x3f5, 0xb, 0x69, 0x3, 0x6a, 0x3, 0x6a, 
    0x5, 0x6a, 0x3f9, 0xa, 0x6a, 0x3, 0x6a, 0x3, 0x6a, 0x5, 0x6a, 0x3fd, 
    0xa, 0x6a, 0x3, 0x6a, 0x3, 0x6a, 0x3, 0x6b, 0x3, 0x6b, 0x3, 0x6b, 0x3, 
    0x6b, 0x3, 0x6b, 0x5, 0x6b, 0x406, 0xa, 0x6b, 0x3, 0x6c, 0x3, 0x6c, 
    0x3, 0x6c, 0x7, 0x6c, 0x40b, 0xa, 0x6c, 0xc, 0x6c, 0xe, 0x6c, 0x40e, 
    0xb, 0x6c, 0x3, 0x6c, 0x3, 0x6c, 0x3, 0x6c, 0x3, 0x6d, 0x3, 0x6d, 0x3, 
    0x6d, 0x7, 0x6d, 0x416, 0xa, 0x6d, 0xc, 0x6d, 0xe, 0x6d, 0x419, 0xb, 
    0x6d, 0x3, 0x6d, 0x3, 0x6d, 0x3, 0x6d, 0x3, 0x6d, 0x5, 0x6d, 0x41f, 
    0xa, 0x6d, 0x3, 0x6d, 0x3, 0x6d, 0x3, 0x6e, 0x3, 0x6e, 0x3, 0x6f, 0x3, 
    0x6f, 0x3, 0x70, 0x3, 0x70, 0x3, 0x71, 0x3, 0x71, 0x3, 0x72, 0x3, 0x72, 
    0x5, 0x72, 0x42d, 0xa, 0x72, 0x3, 0x73, 0x3, 0x73, 0x3, 0x73, 0x3, 0x73, 
    0x5, 0x73, 0x433, 0xa, 0x73, 0x5, 0x73, 0x435, 0xa, 0x73, 0x3, 0x74, 
    0x3, 0x74, 0x3, 0x75, 0x3, 0x75, 0x3, 0x76, 0x3, 0x76, 0x3, 0x77, 0x3, 
    0x77, 0x3, 0x77, 0x3, 0x77, 0x3, 0x77, 0x7, 0x77, 0x442, 0xa, 0x77, 
    0xc, 0x77, 0xe, 0x77, 0x445, 0xb, 0x77, 0x3, 0x77, 0x3, 0x77, 0x3, 0x78, 
    0x3, 0x78, 0x3, 0x79, 0x3, 0x79, 0x3, 0x7a, 0x3, 0x7a, 0x3, 0x7a, 0x5, 
    0x7a, 0x450, 0xa, 0x7a, 0x3, 0x7b, 0x3, 0x7b, 0x3, 0x7c, 0x3, 0x7c, 
    0x3, 0x7d, 0x3, 0x7d, 0x3, 0x7d, 0x7, 0x7d, 0x459, 0xa, 0x7d, 0xc, 0x7d, 
    0xe, 0x7d, 0x45c, 0xb, 0x7d, 0x5, 0x7d, 0x45e, 0xa, 0x7d, 0x3, 0x7e, 
    0x3, 0x7e, 0x5, 0x7e, 0x462, 0xa, 0x7e, 0x3, 0x7e, 0x5, 0x7e, 0x465, 
    0xa, 0x7e, 0x3, 0x7e, 0x3, 0x7e, 0x3, 0x7f, 0x3, 0x7f, 0x3, 0x7f, 0x7, 
    0x7f, 0x46c, 0xa, 0x7f, 0xc, 0x7f, 0xe, 0x7f, 0x46f, 0xb, 0x7f, 0x3, 
    0x7f, 0x3, 0x7f, 0x3, 0x7f, 0x3, 0x80, 0x3, 0x80, 0x3, 0x80, 0x3, 0x80, 
    0x3, 0x80, 0x3, 0x80, 0x7, 0x80, 0x47a, 0xa, 0x80, 0xc, 0x80, 0xe, 0x80, 
    0x47d, 0xb, 0x80, 0x3, 0x80, 0x3, 0x80, 0x5, 0x80, 0x481, 0xa, 0x80, 
    0x3, 0x80, 0x3, 0x80, 0x3, 0x81, 0x5, 0x81, 0x486, 0xa, 0x81, 0x3, 0x81, 
    0x3, 0x81, 0x3, 0x82, 0x3, 0x82, 0x3, 0x83, 0x3, 0x83, 0x3, 0x83, 0x3, 
    0x83, 0x3, 0x83, 0x5, 0x83, 0x491, 0xa, 0x83, 0x3, 0x84, 0x3, 0x84, 
    0x3, 0x84, 0x3, 0x84, 0x3, 0x85, 0x3, 0x85, 0x3, 0x85, 0x5, 0x85, 0x49a, 
    0xa, 0x85, 0x3, 0x86, 0x3, 0x86, 0x3, 0x86, 0x3, 0x86, 0x3, 0x86, 0x3, 
    0x86, 0x3, 0x86, 0x3, 0x86, 0x3, 0x86, 0x3, 0x87, 0x3, 0x87, 0x3, 0x87, 
    0x3, 0x87, 0x3, 0x87, 0x5, 0x87, 0x4aa, 0xa, 0x87, 0x3, 0x88, 0x3, 0x88, 
    0x3, 0x88, 0x5, 0x88, 0x4af, 0xa, 0x88, 0x3, 0x89, 0x3, 0x89, 0x5, 0x89, 
    0x4b3, 0xa, 0x89, 0x3, 0x8a, 0x3, 0x8a, 0x3, 0x8a, 0x3, 0x8a, 0x3, 0x8a, 
    0x3, 0x8a, 0x3, 0x8a, 0x7, 0x8a, 0x4bc, 0xa, 0x8a, 0xc, 0x8a, 0xe, 0x8a, 
    0x4bf, 0xb, 0x8a, 0x3, 0x8a, 0x3, 0x8a, 0x5, 0x8a, 0x4c3, 0xa, 0x8a, 
    0x3, 0x8a, 0x3, 0x8a, 0x3, 0x8b, 0x3, 0x8b, 0x3, 0x8c, 0x3, 0x8c, 0x3, 
    0x8c, 0x5, 0x8c, 0x4cc, 0xa, 0x8c, 0x3, 0x8d, 0x3, 0x8d, 0x3, 0x8d, 
    0x3, 0x8d, 0x3, 0x8d, 0x5, 0x8d, 0x4d3, 0xa, 0x8d, 0x3, 0x8e, 0x5, 0x8e, 
    0x4d6, 0xa, 0x8e, 0x3, 0x8e, 0x5, 0x8e, 0x4d9, 0xa, 0x8e, 0x3, 0x8e, 
    0x5, 0x8e, 0x4dc, 0xa, 0x8e, 0x3, 0x8f, 0x3, 0x8f, 0x3, 0x8f, 0x3, 0x8f, 
    0x3, 0x8f, 0x7, 0x8f, 0x4e3, 0xa, 0x8f, 0xc, 0x8f, 0xe, 0x8f, 0x4e6, 
    0xb, 0x8f, 0x3, 0x8f, 0x3, 0x8f, 0x3, 0x8f, 0x3, 0x90, 0x3, 0x90, 0x3, 
    0x91, 0x3, 0x91, 0x3, 0x91, 0x5, 0x91, 0x4f0, 0xa, 0x91, 0x3, 0x92, 
    0x3, 0x92, 0x3, 0x92, 0x3, 0x92, 0x3, 0x92, 0x5, 0x92, 0x4f7, 0xa, 0x92, 
    0x3, 0x93, 0x3, 0x93, 0x3, 0x93, 0x3, 0x93, 0x3, 0x93, 0x5, 0x93, 0x4fe, 
    0xa, 0x93, 0x3, 0x93, 0x3, 0x93, 0x3, 0x94, 0x3, 0x94, 0x3, 0x94, 0x7, 
    0x94, 0x505, 0xa, 0x94, 0xc, 0x94, 0xe, 0x94, 0x508, 0xb, 0x94, 0x3, 
    0x94, 0x3, 0x94, 0x3, 0x94, 0x3, 0x94, 0x3, 0x95, 0x3, 0x95, 0x3, 0x95, 
    0x3, 0x95, 0x3, 0x95, 0x3, 0x95, 0x3, 0x95, 0x7, 0x95, 0x515, 0xa, 0x95, 
    0xc, 0x95, 0xe, 0x95, 0x518, 0xb, 0x95, 0x3, 0x95, 0x3, 0x95, 0x3, 0x95, 
    0x3, 0x96, 0x3, 0x96, 0x3, 0x97, 0x3, 0x97, 0x3, 0x98, 0x7, 0x98, 0x522, 
    0xa, 0x98, 0xc, 0x98, 0xe, 0x98, 0x525, 0xb, 0x98, 0x3, 0x98, 0x5, 0x98, 
    0x528, 0xa, 0x98, 0x3, 0x98, 0x7, 0x98, 0x52b, 0xa, 0x98, 0xc, 0x98, 
    0xe, 0x98, 0x52e, 0xb, 0x98, 0x3, 0x99, 0x3, 0x99, 0x5, 0x99, 0x532, 
    0xa, 0x99, 0x3, 0x9a, 0x3, 0x9a, 0x3, 0x9a, 0x5, 0x9a, 0x537, 0xa, 0x9a, 
    0x3, 0x9a, 0x3, 0x9a, 0x3, 0x9a, 0x3, 0x9a, 0x3, 0x9a, 0x3, 0x9b, 0x3, 
    0x9b, 0x3, 0x9c, 0x3, 0x9c, 0x3, 0x9d, 0x3, 0x9d, 0x3, 0x9e, 0x3, 0x9e, 
    0x3, 0x9e, 0x3, 0x9e, 0x5, 0x9e, 0x548, 0xa, 0x9e, 0x3, 0x9f, 0x3, 0x9f, 
    0x3, 0x9f, 0x3, 0x9f, 0x7, 0x9f, 0x54e, 0xa, 0x9f, 0xc, 0x9f, 0xe, 0x9f, 
    0x551, 0xb, 0x9f, 0x3, 0x9f, 0x3, 0x9f, 0x3, 0xa0, 0x3, 0xa0, 0x5, 0xa0, 
    0x557, 0xa, 0xa0, 0x5, 0xa0, 0x559, 0xa, 0xa0, 0x3, 0xa0, 0x3, 0xa0, 
    0x3, 0xa0, 0x5, 0xa0, 0x55e, 0xa, 0xa0, 0x3, 0xa1, 0x3, 0xa1, 0x5, 0xa1, 
    0x562, 0xa, 0xa1, 0x3, 0xa1, 0x3, 0xa1, 0x3, 0xa1, 0x3, 0xa2, 0x3, 0xa2, 
    0x3, 0xa2, 0x3, 0xa2, 0x7, 0xa2, 0x56b, 0xa, 0xa2, 0xc, 0xa2, 0xe, 0xa2, 
    0x56e, 0xb, 0xa2, 0x3, 0xa3, 0x3, 0xa3, 0x3, 0xa3, 0x3, 0xa3, 0x3, 0xa3, 
    0x3, 0xa3, 0x3, 0xa3, 0x5, 0xa3, 0x577, 0xa, 0xa3, 0x3, 0xa4, 0x3, 0xa4, 
    0x3, 0xa4, 0x3, 0xa4, 0x3, 0xa4, 0x5, 0xa4, 0x57e, 0xa, 0xa4, 0x3, 0xa5, 
    0x3, 0xa5, 0x3, 0xa5, 0x3, 0xa6, 0x3, 0xa6, 0x3, 0xa6, 0x3, 0xa6, 0x3, 
    0xa6, 0x3, 0xa6, 0x3, 0xa6, 0x5, 0xa6, 0x58a, 0xa, 0xa6, 0x3, 0xa7, 
    0x3, 0xa7, 0x3, 0xa7, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 
    0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 0x3, 0xa8, 
    0x5, 0xa8, 0x59a, 0xa, 0xa8, 0x3, 0xa9, 0x3, 0xa9, 0x3, 0xaa, 0x3, 0xaa, 
    0x5, 0xaa, 0x5a0, 0xa, 0xaa, 0x3, 0xab, 0x5, 0xab, 0x5a3, 0xa, 0xab, 
    0x3, 0xab, 0x5, 0xab, 0x5a6, 0xa, 0xab, 0x3, 0xac, 0x3, 0xac, 0x3, 0xac, 
    0x3, 0xac, 0x3, 0xac, 0x3, 0xad, 0x5, 0xad, 0x5ae, 0xa, 0xad, 0x3, 0xad, 
    0x5, 0xad, 0x5b1, 0xa, 0xad, 0x3, 0xad, 0x3, 0xad, 0x3, 0xad, 0x5, 0xad, 
    0x5b6, 0xa, 0xad, 0x3, 0xae, 0x3, 0xae, 0x3, 0xae, 0x3, 0xae, 0x3, 0xae, 
    0x3, 0xaf, 0x3, 0xaf, 0x3, 0xaf, 0x3, 0xaf, 0x3, 0xaf, 0x3, 0xaf, 0x3, 
    0xb0, 0x3, 0xb0, 0x3, 0xb1, 0x3, 0xb1, 0x3, 0xb1, 0x3, 0xb1, 0x3, 0xb1, 
    0x3, 0xb1, 0x7, 0xb1, 0x5cb, 0xa, 0xb1, 0xc, 0xb1, 0xe, 0xb1, 0x5ce, 
    0xb, 0xb1, 0x3, 0xb1, 0x3, 0xb1, 0x3, 0xb2, 0x3, 0xb2, 0x3, 0xb2, 0x5, 
    0xb2, 0x5d5, 0xa, 0xb2, 0x3, 0xb3, 0x3, 0xb3, 0x3, 0xb3, 0x7, 0xb3, 
    0x5da, 0xa, 0xb3, 0xc, 0xb3, 0xe, 0xb3, 0x5dd, 0xb, 0xb3, 0x3, 0xb4, 
    0x3, 0xb4, 0x3, 0xb4, 0x7, 0xb4, 0x5e2, 0xa, 0xb4, 0xc, 0xb4, 0xe, 0xb4, 
    0x5e5, 0xb, 0xb4, 0x3, 0xb5, 0x3, 0xb5, 0x3, 0xb5, 0x3, 0xb6, 0x3, 0xb6, 
    0x3, 0xb6, 0x3, 0xb6, 0x3, 0xb6, 0x3, 0xb6, 0x5, 0xb6, 0x5f0, 0xa, 0xb6, 
    0x3, 0xb7, 0x6, 0xb7, 0x5f3, 0xa, 0xb7, 0xd, 0xb7, 0xe, 0xb7, 0x5f4, 
    0x3, 0xb7, 0x3, 0xb7, 0x3, 0xb8, 0x3, 0xb8, 0x3, 0xb8, 0x3, 0xb8, 0x7, 
    0xb8, 0x5fd, 0xa, 0xb8, 0xc, 0xb8, 0xe, 0xb8, 0x600, 0xb, 0xb8, 0x3, 
    0xb9, 0x3, 0xb9, 0x3, 0xb9, 0x3, 0xb9, 0x3, 0xb9, 0x7, 0xb9, 0x607, 
    0xa, 0xb9, 0xc, 0xb9, 0xe, 0xb9, 0x60a, 0xb, 0xb9, 0x3, 0xb9, 0x3, 0xb9, 
    0x3, 0xb9, 0x3, 0xba, 0x3, 0xba, 0x3, 0xba, 0x3, 0xba, 0x3, 0xba, 0x3, 
    0xba, 0x5, 0xba, 0x615, 0xa, 0xba, 0x3, 0xba, 0x3, 0xba, 0x3, 0xba, 
    0x3, 0xbb, 0x3, 0xbb, 0x3, 0xbc, 0x3, 0xbc, 0x5, 0xbc, 0x61e, 0xa, 0xbc, 
    0x3, 0xbd, 0x3, 0xbd, 0x3, 0xbe, 0x3, 0xbe, 0x3, 0xbf, 0x3, 0xbf, 0x5, 
    0xbf, 0x626, 0xa, 0xbf, 0x3, 0xc0, 0x3, 0xc0, 0x3, 0xc0, 0x3, 0xc0, 
    0x3, 0xc0, 0x3, 0xc0, 0x7, 0xc0, 0x62e, 0xa, 0xc0, 0xc, 0xc0, 0xe, 0xc0, 
    0x631, 0xb, 0xc0, 0x3, 0xc1, 0x3, 0xc1, 0x3, 0xc1, 0x5, 0xc1, 0x636, 
    0xa, 0xc1, 0x3, 0xc1, 0x3, 0xc1, 0x3, 0xc1, 0x7, 0xc1, 0x63b, 0xa, 0xc1, 
    0xc, 0xc1, 0xe, 0xc1, 0x63e, 0xb, 0xc1, 0x3, 0xc2, 0x3, 0xc2, 0x3, 0xc2, 
    0x3, 0xc3, 0x3, 0xc3, 0x3, 0xc3, 0x3, 0xc3, 0x3, 0xc3, 0x3, 0xc3, 0x3, 
    0xc3, 0x7, 0xc3, 0x64a, 0xa, 0xc3, 0xc, 0xc3, 0xe, 0xc3, 0x64d, 0xb, 
    0xc3, 0x3, 0xc3, 0x3, 0xc3, 0x5, 0xc3, 0x651, 0xa, 0xc3, 0x3, 0xc3, 
    0x3, 0xc3, 0x3, 0xc4, 0x3, 0xc4, 0x3, 0xc5, 0x3, 0xc5, 0x3, 0xc5, 0x3, 
    0xc5, 0x3, 0xc5, 0x3, 0xc5, 0x7, 0xc5, 0x65d, 0xa, 0xc5, 0xc, 0xc5, 
    0xe, 0xc5, 0x660, 0xb, 0xc5, 0x3, 0xc6, 0x3, 0xc6, 0x3, 0xc6, 0x3, 0xc7, 
    0x3, 0xc7, 0x3, 0xc8, 0x3, 0xc8, 0x3, 0xc8, 0x3, 0xc8, 0x5, 0xc8, 0x66b, 
    0xa, 0xc8, 0x3, 0xc8, 0x2, 0x2, 0xc9, 0x2, 0x4, 0x6, 0x8, 0xa, 0xc, 
    0xe, 0x10, 0x12, 0x14, 0x16, 0x18, 0x1a, 0x1c, 0x1e, 0x20, 0x22, 0x24, 
    0x26, 0x28, 0x2a, 0x2c, 0x2e, 0x30, 0x32, 0x34, 0x36, 0x38, 0x3a, 0x3c, 
    0x3e, 0x40, 0x42, 0x44, 0x46, 0x48, 0x4a, 0x4c, 0x4e, 0x50, 0x52, 0x54, 
    0x56, 0x58, 0x5a, 0x5c, 0x5e, 0x60, 0x62, 0x64, 0x66, 0x68, 0x6a, 0x6c, 
    0x6e, 0x70, 0x72, 0x74, 0x76, 0x78, 0x7a, 0x7c, 0x7e, 0x80, 0x82, 0x84, 
    0x86, 0x88, 0x8a, 0x8c, 0x8e, 0x90, 0x92, 0x94, 0x96, 0x98, 0x9a, 0x9c, 
    0x9e, 0xa0, 0xa2, 0xa4, 0xa6, 0xa8, 0xaa, 0xac, 0xae, 0xb0, 0xb2, 0xb4, 
    0xb6, 0xb8, 0xba, 0xbc, 0xbe, 0xc0, 0xc2, 0xc4, 0xc6, 0xc8, 0xca, 0xcc, 
    0xce, 0xd0, 0xd2, 0xd4, 0xd6, 0xd8, 0xda, 0xdc, 0xde, 0xe0, 0xe2, 0xe4, 
    0xe6, 0xe8, 0xea, 0xec, 0xee, 0xf0, 0xf2, 0xf4, 0xf6, 0xf8, 0xfa, 0xfc, 
    0xfe, 0x100, 0x102, 0x104, 0x106, 0x108, 0x10a, 0x10c, 0x10e, 0x110, 
    0x112, 0x114, 0x116, 0x118, 0x11a, 0x11c, 0x11e, 0x120, 0x122, 0x124, 
    0x126, 0x128, 0x12a, 0x12c, 0x12e, 0x130, 0x132, 0x134, 0x136, 0x138, 
    0x13a, 0x13c, 0x13e, 0x140, 0x142, 0x144, 0x146, 0x148, 0x14a, 0x14c, 
    0x14e, 0x150, 0x152, 0x154, 0x156, 0x158, 0x15a, 0x15c, 0x15e, 0x160, 
    0x162, 0x164, 0x166, 0x168, 0x16a, 0x16c, 0x16e, 0x170, 0x172, 0x174, 
    0x176, 0x178, 0x17a, 0x17c, 0x17e, 0x180, 0x182, 0x184, 0x186, 0x188, 
    0x18a, 0x18c, 0x18e, 0x2, 0xd, 0x5, 0x2, 0x7, 0x8, 0x6e, 0x6e, 0x9a, 
    0x9a, 0x6, 0x2, 0xe, 0xe, 0x34, 0x34, 0x70, 0x70, 0x7d, 0x7d, 0x15, 
    0x2, 0x20, 0x20, 0x22, 0x22, 0x29, 0x2a, 0x2f, 0x2f, 0x35, 0x35, 0x4a, 
    0x4b, 0x50, 0x50, 0x55, 0x56, 0x5c, 0x5c, 0x5f, 0x5f, 0x61, 0x63, 0x65, 
    0x65, 0x69, 0x6a, 0x79, 0x79, 0x7f, 0x80, 0x82, 0x82, 0x87, 0x87, 0x8c, 
    0x8c, 0x92, 0x95, 0x4, 0x2, 0x59, 0x59, 0x75, 0x75, 0x3, 0x2, 0x13, 
    0x14, 0x4, 0x2, 0x2b, 0x2b, 0x7e, 0x7e, 0x5, 0x2, 0x4d, 0x4d, 0x8a, 
    0x8a, 0x8f, 0x8f, 0x6, 0x2, 0x15, 0x17, 0x25, 0x25, 0x37, 0x37, 0x66, 
    0x66, 0x4, 0x2, 0x13, 0x14, 0x1a, 0x1f, 0x4, 0x2, 0x9c, 0x9c, 0xa0, 
    0xa0, 0x4, 0x2, 0x7, 0x8, 0x67, 0x67, 0x2, 0x66c, 0x2, 0x190, 0x3, 0x2, 
    0x2, 0x2, 0x4, 0x192, 0x3, 0x2, 0x2, 0x2, 0x6, 0x194, 0x3, 0x2, 0x2, 
    0x2, 0x8, 0x196, 0x3, 0x2, 0x2, 0x2, 0xa, 0x198, 0x3, 0x2, 0x2, 0x2, 
    0xc, 0x19a, 0x3, 0x2, 0x2, 0x2, 0xe, 0x19c, 0x3, 0x2, 0x2, 0x2, 0x10, 
    0x19e, 0x3, 0x2, 0x2, 0x2, 0x12, 0x1a0, 0x3, 0x2, 0x2, 0x2, 0x14, 0x1a2, 
    0x3, 0x2, 0x2, 0x2, 0x16, 0x1a4, 0x3, 0x2, 0x2, 0x2, 0x18, 0x1a6, 0x3, 
    0x2, 0x2, 0x2, 0x1a, 0x1a8, 0x3, 0x2, 0x2, 0x2, 0x1c, 0x1aa, 0x3, 0x2, 
    0x2, 0x2, 0x1e, 0x1ac, 0x3, 0x2, 0x2, 0x2, 0x20, 0x1ae, 0x3, 0x2, 0x2, 
    0x2, 0x22, 0x1b2, 0x3, 0x2, 0x2, 0x2, 0x24, 0x1b7, 0x3, 0x2, 0x2, 0x2, 
    0x26, 0x1c2, 0x3, 0x2, 0x2, 0x2, 0x28, 0x1c4, 0x3, 0x2, 0x2, 0x2, 0x2a, 
    0x1d1, 0x3, 0x2, 0x2, 0x2, 0x2c, 0x1d3, 0x3, 0x2, 0x2, 0x2, 0x2e, 0x1df, 
    0x3, 0x2, 0x2, 0x2, 0x30, 0x1e4, 0x3, 0x2, 0x2, 0x2, 0x32, 0x1ed, 0x3, 
    0x2, 0x2, 0x2, 0x34, 0x202, 0x3, 0x2, 0x2, 0x2, 0x36, 0x20d, 0x3, 0x2, 
    0x2, 0x2, 0x38, 0x21a, 0x3, 0x2, 0x2, 0x2, 0x3a, 0x21c, 0x3, 0x2, 0x2, 
    0x2, 0x3c, 0x21e, 0x3, 0x2, 0x2, 0x2, 0x3e, 0x221, 0x3, 0x2, 0x2, 0x2, 
    0x40, 0x228, 0x3, 0x2, 0x2, 0x2, 0x42, 0x22c, 0x3, 0x2, 0x2, 0x2, 0x44, 
    0x22e, 0x3, 0x2, 0x2, 0x2, 0x46, 0x230, 0x3, 0x2, 0x2, 0x2, 0x48, 0x232, 
    0x3, 0x2, 0x2, 0x2, 0x4a, 0x238, 0x3, 0x2, 0x2, 0x2, 0x4c, 0x23a, 0x3, 
    0x2, 0x2, 0x2, 0x4e, 0x23c, 0x3, 0x2, 0x2, 0x2, 0x50, 0x23e, 0x3, 0x2, 
    0x2, 0x2, 0x52, 0x249, 0x3, 0x2, 0x2, 0x2, 0x54, 0x24b, 0x3, 0x2, 0x2, 
    0x2, 0x56, 0x25c, 0x3, 0x2, 0x2, 0x2, 0x58, 0x26a, 0x3, 0x2, 0x2, 0x2, 
    0x5a, 0x26c, 0x3, 0x2, 0x2, 0x2, 0x5c, 0x273, 0x3, 0x2, 0x2, 0x2, 0x5e, 
    0x280, 0x3, 0x2, 0x2, 0x2, 0x60, 0x282, 0x3, 0x2, 0x2, 0x2, 0x62, 0x286, 
    0x3, 0x2, 0x2, 0x2, 0x64, 0x28d, 0x3, 0x2, 0x2, 0x2, 0x66, 0x28f, 0x3, 
    0x2, 0x2, 0x2, 0x68, 0x296, 0x3, 0x2, 0x2, 0x2, 0x6a, 0x2a1, 0x3, 0x2, 
    0x2, 0x2, 0x6c, 0x2a5, 0x3, 0x2, 0x2, 0x2, 0x6e, 0x2ad, 0x3, 0x2, 0x2, 
    0x2, 0x70, 0x2bc, 0x3, 0x2, 0x2, 0x2, 0x72, 0x2ca, 0x3, 0x2, 0x2, 0x2, 
    0x74, 0x2cf, 0x3, 0x2, 0x2, 0x2, 0x76, 0x2d4, 0x3, 0x2, 0x2, 0x2, 0x78, 
    0x2d6, 0x3, 0x2, 0x2, 0x2, 0x7a, 0x2dc, 0x3, 0x2, 0x2, 0x2, 0x7c, 0x2de, 
    0x3, 0x2, 0x2, 0x2, 0x7e, 0x2e9, 0x3, 0x2, 0x2, 0x2, 0x80, 0x2ee, 0x3, 
    0x2, 0x2, 0x2, 0x82, 0x2f3, 0x3, 0x2, 0x2, 0x2, 0x84, 0x2fb, 0x3, 0x2, 
    0x2, 0x2, 0x86, 0x2fe, 0x3, 0x2, 0x2, 0x2, 0x88, 0x30d, 0x3, 0x2, 0x2, 
    0x2, 0x8a, 0x313, 0x3, 0x2, 0x2, 0x2, 0x8c, 0x318, 0x3, 0x2, 0x2, 0x2, 
    0x8e, 0x325, 0x3, 0x2, 0x2, 0x2, 0x90, 0x32a, 0x3, 0x2, 0x2, 0x2, 0x92, 
    0x336, 0x3, 0x2, 0x2, 0x2, 0x94, 0x349, 0x3, 0x2, 0x2, 0x2, 0x96, 0x34f, 
    0x3, 0x2, 0x2, 0x2, 0x98, 0x355, 0x3, 0x2, 0x2, 0x2, 0x9a, 0x357, 0x3, 
    0x2, 0x2, 0x2, 0x9c, 0x364, 0x3, 0x2, 0x2, 0x2, 0x9e, 0x36b, 0x3, 0x2, 
    0x2, 0x2, 0xa0, 0x377, 0x3, 0x2, 0x2, 0x2, 0xa2, 0x379, 0x3, 0x2, 0x2, 
    0x2, 0xa4, 0x380, 0x3, 0x2, 0x2, 0x2, 0xa6, 0x385, 0x3, 0x2, 0x2, 0x2, 
    0xa8, 0x38a, 0x3, 0x2, 0x2, 0x2, 0xaa, 0x38d, 0x3, 0x2, 0x2, 0x2, 0xac, 
    0x398, 0x3, 0x2, 0x2, 0x2, 0xae, 0x39f, 0x3, 0x2, 0x2, 0x2, 0xb0, 0x3a6, 
    0x3, 0x2, 0x2, 0x2, 0xb2, 0x3a8, 0x3, 0x2, 0x2, 0x2, 0xb4, 0x3b1, 0x3, 
    0x2, 0x2, 0x2, 0xb6, 0x3b3, 0x3, 0x2, 0x2, 0x2, 0xb8, 0x3b5, 0x3, 0x2, 
    0x2, 0x2, 0xba, 0x3b7, 0x3, 0x2, 0x2, 0x2, 0xbc, 0x3c1, 0x3, 0x2, 0x2, 
    0x2, 0xbe, 0x3c3, 0x3, 0x2, 0x2, 0x2, 0xc0, 0x3c7, 0x3, 0x2, 0x2, 0x2, 
    0xc2, 0x3c9, 0x3, 0x2, 0x2, 0x2, 0xc4, 0x3d1, 0x3, 0x2, 0x2, 0x2, 0xc6, 
    0x3d3, 0x3, 0x2, 0x2, 0x2, 0xc8, 0x3d5, 0x3, 0x2, 0x2, 0x2, 0xca, 0x3d7, 
    0x3, 0x2, 0x2, 0x2, 0xcc, 0x3d9, 0x3, 0x2, 0x2, 0x2, 0xce, 0x3ea, 0x3, 
    0x2, 0x2, 0x2, 0xd0, 0x3ee, 0x3, 0x2, 0x2, 0x2, 0xd2, 0x3f6, 0x3, 0x2, 
    0x2, 0x2, 0xd4, 0x405, 0x3, 0x2, 0x2, 0x2, 0xd6, 0x407, 0x3, 0x2, 0x2, 
    0x2, 0xd8, 0x412, 0x3, 0x2, 0x2, 0x2, 0xda, 0x422, 0x3, 0x2, 0x2, 0x2, 
    0xdc, 0x424, 0x3, 0x2, 0x2, 0x2, 0xde, 0x426, 0x3, 0x2, 0x2, 0x2, 0xe0, 
    0x428, 0x3, 0x2, 0x2, 0x2, 0xe2, 0x42c, 0x3, 0x2, 0x2, 0x2, 0xe4, 0x42e, 
    0x3, 0x2, 0x2, 0x2, 0xe6, 0x436, 0x3, 0x2, 0x2, 0x2, 0xe8, 0x438, 0x3, 
    0x2, 0x2, 0x2, 0xea, 0x43a, 0x3, 0x2, 0x2, 0x2, 0xec, 0x43c, 0x3, 0x2, 
    0x2, 0x2, 0xee, 0x448, 0x3, 0x2, 0x2, 0x2, 0xf0, 0x44a, 0x3, 0x2, 0x2, 
    0x2, 0xf2, 0x44f, 0x3, 0x2, 0x2, 0x2, 0xf4, 0x451, 0x3, 0x2, 0x2, 0x2, 
    0xf6, 0x453, 0x3, 0x2, 0x2, 0x2, 0xf8, 0x45d, 0x3, 0x2, 0x2, 0x2, 0xfa, 
    0x461, 0x3, 0x2, 0x2, 0x2, 0xfc, 0x468, 0x3, 0x2, 0x2, 0x2, 0xfe, 0x473, 
    0x3, 0x2, 0x2, 0x2, 0x100, 0x485, 0x3, 0x2, 0x2, 0x2, 0x102, 0x489, 
    0x3, 0x2, 0x2, 0x2, 0x104, 0x490, 0x3, 0x2, 0x2, 0x2, 0x106, 0x492, 
    0x3, 0x2, 0x2, 0x2, 0x108, 0x499, 0x3, 0x2, 0x2, 0x2, 0x10a, 0x49b, 
    0x3, 0x2, 0x2, 0x2, 0x10c, 0x4a4, 0x3, 0x2, 0x2, 0x2, 0x10e, 0x4ab, 
    0x3, 0x2, 0x2, 0x2, 0x110, 0x4b2, 0x3, 0x2, 0x2, 0x2, 0x112, 0x4b4, 
    0x3, 0x2, 0x2, 0x2, 0x114, 0x4c6, 0x3, 0x2, 0x2, 0x2, 0x116, 0x4cb, 
    0x3, 0x2, 0x2, 0x2, 0x118, 0x4d2, 0x3, 0x2, 0x2, 0x2, 0x11a, 0x4d5, 
    0x3, 0x2, 0x2, 0x2, 0x11c, 0x4dd, 0x3, 0x2, 0x2, 0x2, 0x11e, 0x4ea, 
    0x3, 0x2, 0x2, 0x2, 0x120, 0x4ec, 0x3, 0x2, 0x2, 0x2, 0x122, 0x4f6, 
    0x3, 0x2, 0x2, 0x2, 0x124, 0x4f8, 0x3, 0x2, 0x2, 0x2, 0x126, 0x501, 
    0x3, 0x2, 0x2, 0x2, 0x128, 0x50d, 0x3, 0x2, 0x2, 0x2, 0x12a, 0x51c, 
    0x3, 0x2, 0x2, 0x2, 0x12c, 0x51e, 0x3, 0x2, 0x2, 0x2, 0x12e, 0x523, 
    0x3, 0x2, 0x2, 0x2, 0x130, 0x531, 0x3, 0x2, 0x2, 0x2, 0x132, 0x533, 
    0x3, 0x2, 0x2, 0x2, 0x134, 0x53d, 0x3, 0x2, 0x2, 0x2, 0x136, 0x53f, 
    0x3, 0x2, 0x2, 0x2, 0x138, 0x541, 0x3, 0x2, 0x2, 0x2, 0x13a, 0x543, 
    0x3, 0x2, 0x2, 0x2, 0x13c, 0x549, 0x3, 0x2, 0x2, 0x2, 0x13e, 0x558, 
    0x3, 0x2, 0x2, 0x2, 0x140, 0x55f, 0x3, 0x2, 0x2, 0x2, 0x142, 0x566, 
    0x3, 0x2, 0x2, 0x2, 0x144, 0x576, 0x3, 0x2, 0x2, 0x2, 0x146, 0x57d, 
    0x3, 0x2, 0x2, 0x2, 0x148, 0x57f, 0x3, 0x2, 0x2, 0x2, 0x14a, 0x589, 
    0x3, 0x2, 0x2, 0x2, 0x14c, 0x58b, 0x3, 0x2, 0x2, 0x2, 0x14e, 0x599, 
    0x3, 0x2, 0x2, 0x2, 0x150, 0x59b, 0x3, 0x2, 0x2, 0x2, 0x152, 0x59d, 
    0x3, 0x2, 0x2, 0x2, 0x154, 0x5a2, 0x3, 0x2, 0x2, 0x2, 0x156, 0x5a7, 
    0x3, 0x2, 0x2, 0x2, 0x158, 0x5ad, 0x3, 0x2, 0x2, 0x2, 0x15a, 0x5b7, 
    0x3, 0x2, 0x2, 0x2, 0x15c, 0x5bc, 0x3, 0x2, 0x2, 0x2, 0x15e, 0x5c2, 
    0x3, 0x2, 0x2, 0x2, 0x160, 0x5c4, 0x3, 0x2, 0x2, 0x2, 0x162, 0x5d4, 
    0x3, 0x2, 0x2, 0x2, 0x164, 0x5d6, 0x3, 0x2, 0x2, 0x2, 0x166, 0x5de, 
    0x3, 0x2, 0x2, 0x2, 0x168, 0x5e6, 0x3, 0x2, 0x2, 0x2, 0x16a, 0x5ef, 
    0x3, 0x2, 0x2, 0x2, 0x16c, 0x5f2, 0x3, 0x2, 0x2, 0x2, 0x16e, 0x5f8, 
    0x3, 0x2, 0x2, 0x2, 0x170, 0x601, 0x3, 0x2, 0x2, 0x2, 0x172, 0x60e, 
    0x3, 0x2, 0x2, 0x2, 0x174, 0x619, 0x3, 0x2, 0x2, 0x2, 0x176, 0x61d, 
    0x3, 0x2, 0x2, 0x2, 0x178, 0x61f, 0x3, 0x2, 0x2, 0x2, 0x17a, 0x621, 
    0x3, 0x2, 0x2, 0x2, 0x17c, 0x625, 0x3, 0x2, 0x2, 0x2, 0x17e, 0x627, 
    0x3, 0x2, 0x2, 0x2, 0x180, 0x635, 0x3, 0x2, 0x2, 0x2, 0x182, 0x63f, 
    0x3, 0x2, 0x2, 0x2, 0x184, 0x642, 0x3, 0x2, 0x2, 0x2, 0x186, 0x654, 
    0x3, 0x2, 0x2, 0x2, 0x188, 0x656, 0x3, 0x2, 0x2, 0x2, 0x18a, 0x661, 
    0x3, 0x2, 0x2, 0x2, 0x18c, 0x664, 0x3, 0x2, 0x2, 0x2, 0x18e, 0x666, 
    0x3, 0x2, 0x2, 0x2, 0x190, 0x191, 0x5, 0x3a, 0x1e, 0x2, 0x191, 0x3, 
    0x3, 0x2, 0x2, 0x2, 0x192, 0x193, 0x5, 0x60, 0x31, 0x2, 0x193, 0x5, 
    0x3, 0x2, 0x2, 0x2, 0x194, 0x195, 0x5, 0x76, 0x3c, 0x2, 0x195, 0x7, 
    0x3, 0x2, 0x2, 0x2, 0x196, 0x197, 0x5, 0x7a, 0x3e, 0x2, 0x197, 0x9, 
    0x3, 0x2, 0x2, 0x2, 0x198, 0x199, 0x5, 0x94, 0x4b, 0x2, 0x199, 0xb, 
    0x3, 0x2, 0x2, 0x2, 0x19a, 0x19b, 0x5, 0xf0, 0x79, 0x2, 0x19b, 0xd, 
    0x3, 0x2, 0x2, 0x2, 0x19c, 0x19d, 0x5, 0x102, 0x82, 0x2, 0x19d, 0xf, 
    0x3, 0x2, 0x2, 0x2, 0x19e, 0x19f, 0x5, 0x12c, 0x97, 0x2, 0x19f, 0x11, 
    0x3, 0x2, 0x2, 0x2, 0x1a0, 0x1a1, 0x5, 0x12a, 0x96, 0x2, 0x1a1, 0x13, 
    0x3, 0x2, 0x2, 0x2, 0x1a2, 0x1a3, 0x5, 0x134, 0x9b, 0x2, 0x1a3, 0x15, 
    0x3, 0x2, 0x2, 0x2, 0x1a4, 0x1a5, 0x5, 0x15e, 0xb0, 0x2, 0x1a5, 0x17, 
    0x3, 0x2, 0x2, 0x2, 0x1a6, 0x1a7, 0x5, 0x178, 0xbd, 0x2, 0x1a7, 0x19, 
    0x3, 0x2, 0x2, 0x2, 0x1a8, 0x1a9, 0x5, 0x174, 0xbb, 0x2, 0x1a9, 0x1b, 
    0x3, 0x2, 0x2, 0x2, 0x1aa, 0x1ab, 0x5, 0x186, 0xc4, 0x2, 0x1ab, 0x1d, 
    0x3, 0x2, 0x2, 0x2, 0x1ac, 0x1ad, 0x7, 0x21, 0x2, 0x2, 0x1ad, 0x1f, 
    0x3, 0x2, 0x2, 0x2, 0x1ae, 0x1af, 0x7, 0x21, 0x2, 0x2, 0x1af, 0x1b0, 
    0x7, 0x86, 0x2, 0x2, 0x1b0, 0x1b1, 0x7, 0x3, 0x2, 0x2, 0x1b1, 0x21, 
    0x3, 0x2, 0x2, 0x2, 0x1b2, 0x1b3, 0x7, 0x21, 0x2, 0x2, 0x1b3, 0x1b5, 
    0x7, 0x86, 0x2, 0x2, 0x1b4, 0x1b6, 0x5, 0x156, 0xac, 0x2, 0x1b5, 0x1b4, 
    0x3, 0x2, 0x2, 0x2, 0x1b5, 0x1b6, 0x3, 0x2, 0x2, 0x2, 0x1b6, 0x23, 0x3, 
    0x2, 0x2, 0x2, 0x1b7, 0x1b8, 0x7, 0x4, 0x2, 0x2, 0x1b8, 0x1bd, 0x5, 
    0xee, 0x78, 0x2, 0x1b9, 0x1ba, 0x7, 0x5, 0x2, 0x2, 0x1ba, 0x1bc, 0x5, 
    0xee, 0x78, 0x2, 0x1bb, 0x1b9, 0x3, 0x2, 0x2, 0x2, 0x1bc, 0x1bf, 0x3, 
    0x2, 0x2, 0x2, 0x1bd, 0x1bb, 0x3, 0x2, 0x2, 0x2, 0x1bd, 0x1be, 0x3, 
    0x2, 0x2, 0x2, 0x1be, 0x1c0, 0x3, 0x2, 0x2, 0x2, 0x1bf, 0x1bd, 0x3, 
    0x2, 0x2, 0x2, 0x1c0, 0x1c1, 0x7, 0x6, 0x2, 0x2, 0x1c1, 0x25, 0x3, 0x2, 
    0x2, 0x2, 0x1c2, 0x1c3, 0x9, 0x2, 0x2, 0x2, 0x1c3, 0x27, 0x3, 0x2, 0x2, 
    0x2, 0x1c4, 0x1cd, 0x7, 0x9, 0x2, 0x2, 0x1c5, 0x1ca, 0x5, 0x6c, 0x37, 
    0x2, 0x1c6, 0x1c7, 0x7, 0x5, 0x2, 0x2, 0x1c7, 0x1c9, 0x5, 0x6c, 0x37, 
    0x2, 0x1c8, 0x1c6, 0x3, 0x2, 0x2, 0x2, 0x1c9, 0x1cc, 0x3, 0x2, 0x2, 
    0x2, 0x1ca, 0x1c8, 0x3, 0x2, 0x2, 0x2, 0x1ca, 0x1cb, 0x3, 0x2, 0x2, 
    0x2, 0x1cb, 0x1ce, 0x3, 0x2, 0x2, 0x2, 0x1cc, 0x1ca, 0x3, 0x2, 0x2, 
    0x2, 0x1cd, 0x1c5, 0x3, 0x2, 0x2, 0x2, 0x1cd, 0x1ce, 0x3, 0x2, 0x2, 
    0x2, 0x1ce, 0x1cf, 0x3, 0x2, 0x2, 0x2, 0x1cf, 0x1d0, 0x7, 0xa, 0x2, 
    0x2, 0x1d0, 0x29, 0x3, 0x2, 0x2, 0x2, 0x1d1, 0x1d2, 0x5, 0x142, 0xa2, 
    0x2, 0x1d2, 0x2b, 0x3, 0x2, 0x2, 0x2, 0x1d3, 0x1d6, 0x7, 0x23, 0x2, 
    0x2, 0x1d4, 0x1d5, 0x7, 0xb, 0x2, 0x2, 0x1d5, 0x1d7, 0x5, 0x176, 0xbc, 
    0x2, 0x1d6, 0x1d4, 0x3, 0x2, 0x2, 0x2, 0x1d6, 0x1d7, 0x3, 0x2, 0x2, 
    0x2, 0x1d7, 0x1d8, 0x3, 0x2, 0x2, 0x2, 0x1d8, 0x1d9, 0x7, 0x6b, 0x2, 
    0x2, 0x1d9, 0x1da, 0x5, 0xf2, 0x7a, 0x2, 0x1da, 0x2d, 0x3, 0x2, 0x2, 
    0x2, 0x1db, 0x1e0, 0x5, 0x34, 0x1b, 0x2, 0x1dc, 0x1e0, 0x5, 0x3e, 0x20, 
    0x2, 0x1dd, 0x1e0, 0x5, 0xd2, 0x6a, 0x2, 0x1de, 0x1e0, 0x5, 0x140, 0xa1, 
    0x2, 0x1df, 0x1db, 0x3, 0x2, 0x2, 0x2, 0x1df, 0x1dc, 0x3, 0x2, 0x2, 
    0x2, 0x1df, 0x1dd, 0x3, 0x2, 0x2, 0x2, 0x1df, 0x1de, 0x3, 0x2, 0x2, 
    0x2, 0x1e0, 0x2f, 0x3, 0x2, 0x2, 0x2, 0x1e1, 0x1e3, 0x5, 0x64, 0x33, 
    0x2, 0x1e2, 0x1e1, 0x3, 0x2, 0x2, 0x2, 0x1e3, 0x1e6, 0x3, 0x2, 0x2, 
    0x2, 0x1e4, 0x1e2, 0x3, 0x2, 0x2, 0x2, 0x1e4, 0x1e5, 0x3, 0x2, 0x2, 
    0x2, 0x1e5, 0x1e8, 0x3, 0x2, 0x2, 0x2, 0x1e6, 0x1e4, 0x3, 0x2, 0x2, 
    0x2, 0x1e7, 0x1e9, 0x5, 0x5c, 0x2f, 0x2, 0x1e8, 0x1e7, 0x3, 0x2, 0x2, 
    0x2, 0x1e8, 0x1e9, 0x3, 0x2, 0x2, 0x2, 0x1e9, 0x1eb, 0x3, 0x2, 0x2, 
    0x2, 0x1ea, 0x1ec, 0x5, 0xd6, 0x6c, 0x2, 0x1eb, 0x1ea, 0x3, 0x2, 0x2, 
    0x2, 0x1eb, 0x1ec, 0x3, 0x2, 0x2, 0x2, 0x1ec, 0x31, 0x3, 0x2, 0x2, 0x2, 
    0x1ed, 0x1ee, 0x7, 0x24, 0x2, 0x2, 0x1ee, 0x1ef, 0x5, 0x186, 0xc4, 0x2, 
    0x1ef, 0x1f0, 0x7, 0x4f, 0x2, 0x2, 0x1f0, 0x1f4, 0x5, 0xa0, 0x51, 0x2, 
    0x1f1, 0x1f3, 0x5, 0x108, 0x85, 0x2, 0x1f2, 0x1f1, 0x3, 0x2, 0x2, 0x2, 
    0x1f3, 0x1f6, 0x3, 0x2, 0x2, 0x2, 0x1f4, 0x1f2, 0x3, 0x2, 0x2, 0x2, 
    0x1f4, 0x1f5, 0x3, 0x2, 0x2, 0x2, 0x1f5, 0x1f7, 0x3, 0x2, 0x2, 0x2, 
    0x1f6, 0x1f4, 0x3, 0x2, 0x2, 0x2, 0x1f7, 0x1f8, 0x7, 0x3, 0x2, 0x2, 
    0x1f8, 0x1fc, 0x5, 0x14e, 0xa8, 0x2, 0x1f9, 0x1fb, 0x5, 0x14e, 0xa8, 
    0x2, 0x1fa, 0x1f9, 0x3, 0x2, 0x2, 0x2, 0x1fb, 0x1fe, 0x3, 0x2, 0x2, 
    0x2, 0x1fc, 0x1fa, 0x3, 0x2, 0x2, 0x2, 0x1fc, 0x1fd, 0x3, 0x2, 0x2, 
    0x2, 0x1fd, 0x1ff, 0x3, 0x2, 0x2, 0x2, 0x1fe, 0x1fc, 0x3, 0x2, 0x2, 
    0x2, 0x1ff, 0x200, 0x7, 0x3a, 0x2, 0x2, 0x200, 0x201, 0x7, 0x3, 0x2, 
    0x2, 0x201, 0x33, 0x3, 0x2, 0x2, 0x2, 0x202, 0x203, 0x7, 0x27, 0x2, 
    0x2, 0x203, 0x204, 0x5, 0x48, 0x25, 0x2, 0x204, 0x206, 0x7, 0x6b, 0x2, 
    0x2, 0x205, 0x207, 0x7, 0x6d, 0x2, 0x2, 0x206, 0x205, 0x3, 0x2, 0x2, 
    0x2, 0x206, 0x207, 0x3, 0x2, 0x2, 0x2, 0x207, 0x209, 0x3, 0x2, 0x2, 
    0x2, 0x208, 0x20a, 0x7, 0x8e, 0x2, 0x2, 0x209, 0x208, 0x3, 0x2, 0x2, 
    0x2, 0x209, 0x20a, 0x3, 0x2, 0x2, 0x2, 0x20a, 0x20b, 0x3, 0x2, 0x2, 
    0x2, 0x20b, 0x20c, 0x5, 0xbc, 0x5f, 0x2, 0x20c, 0x35, 0x3, 0x2, 0x2, 
    0x2, 0x20d, 0x211, 0x5, 0xa0, 0x51, 0x2, 0x20e, 0x210, 0x5, 0x108, 0x85, 
    0x2, 0x20f, 0x20e, 0x3, 0x2, 0x2, 0x2, 0x210, 0x213, 0x3, 0x2, 0x2, 
    0x2, 0x211, 0x20f, 0x3, 0x2, 0x2, 0x2, 0x211, 0x212, 0x3, 0x2, 0x2, 
    0x2, 0x212, 0x214, 0x3, 0x2, 0x2, 0x2, 0x213, 0x211, 0x3, 0x2, 0x2, 
    0x2, 0x214, 0x215, 0x7, 0xc, 0x2, 0x2, 0x215, 0x216, 0x5, 0x88, 0x45, 
    0x2, 0x216, 0x217, 0x7, 0x3, 0x2, 0x2, 0x217, 0x37, 0x3, 0x2, 0x2, 0x2, 
    0x218, 0x21b, 0x5, 0x3a, 0x1e, 0x2, 0x219, 0x21b, 0x5, 0x10e, 0x88, 
    0x2, 0x21a, 0x218, 0x3, 0x2, 0x2, 0x2, 0x21a, 0x219, 0x3, 0x2, 0x2, 
    0x2, 0x21b, 0x39, 0x3, 0x2, 0x2, 0x2, 0x21c, 0x21d, 0x7, 0x9f, 0x2, 
    0x2, 0x21d, 0x3b, 0x3, 0x2, 0x2, 0x2, 0x21e, 0x21f, 0x7, 0xd, 0x2, 0x2, 
    0x21f, 0x220, 0x5, 0x2, 0x2, 0x2, 0x220, 0x3d, 0x3, 0x2, 0x2, 0x2, 0x221, 
    0x223, 0x7, 0x2b, 0x2, 0x2, 0x222, 0x224, 0x5, 0x48, 0x25, 0x2, 0x223, 
    0x222, 0x3, 0x2, 0x2, 0x2, 0x223, 0x224, 0x3, 0x2, 0x2, 0x2, 0x224, 
    0x225, 0x3, 0x2, 0x2, 0x2, 0x225, 0x226, 0x7, 0x6b, 0x2, 0x2, 0x226, 
    0x227, 0x5, 0xbc, 0x5f, 0x2, 0x227, 0x3f, 0x3, 0x2, 0x2, 0x2, 0x228, 
    0x22a, 0x7, 0x2e, 0x2, 0x2, 0x229, 0x22b, 0x5, 0x18e, 0xc8, 0x2, 0x22a, 
    0x229, 0x3, 0x2, 0x2, 0x2, 0x22a, 0x22b, 0x3, 0x2, 0x2, 0x2, 0x22b, 
    0x41, 0x3, 0x2, 0x2, 0x2, 0x22c, 0x22d, 0x7, 0x30, 0x2, 0x2, 0x22d, 
    0x43, 0x3, 0x2, 0x2, 0x2, 0x22e, 0x22f, 0x5, 0xea, 0x76, 0x2, 0x22f, 
    0x45, 0x3, 0x2, 0x2, 0x2, 0x230, 0x231, 0x5, 0xea, 0x76, 0x2, 0x231, 
    0x47, 0x3, 0x2, 0x2, 0x2, 0x232, 0x233, 0x7, 0x9, 0x2, 0x2, 0x233, 0x234, 
    0x5, 0x44, 0x23, 0x2, 0x234, 0x235, 0x7, 0xb, 0x2, 0x2, 0x235, 0x236, 
    0x5, 0x46, 0x24, 0x2, 0x236, 0x237, 0x7, 0xa, 0x2, 0x2, 0x237, 0x49, 
    0x3, 0x2, 0x2, 0x2, 0x238, 0x239, 0x9, 0x3, 0x2, 0x2, 0x239, 0x4b, 0x3, 
    0x2, 0x2, 0x2, 0x23a, 0x23b, 0x9, 0x4, 0x2, 0x2, 0x23b, 0x4d, 0x3, 0x2, 
    0x2, 0x2, 0x23c, 0x23d, 0x9, 0x5, 0x2, 0x2, 0x23d, 0x4f, 0x3, 0x2, 0x2, 
    0x2, 0x23e, 0x243, 0x5, 0x52, 0x2a, 0x2, 0x23f, 0x240, 0x7, 0x5, 0x2, 
    0x2, 0x240, 0x242, 0x5, 0x52, 0x2a, 0x2, 0x241, 0x23f, 0x3, 0x2, 0x2, 
    0x2, 0x242, 0x245, 0x3, 0x2, 0x2, 0x2, 0x243, 0x241, 0x3, 0x2, 0x2, 
    0x2, 0x243, 0x244, 0x3, 0x2, 0x2, 0x2, 0x244, 0x246, 0x3, 0x2, 0x2, 
    0x2, 0x245, 0x243, 0x3, 0x2, 0x2, 0x2, 0x246, 0x247, 0x7, 0xb, 0x2, 
    0x2, 0x247, 0x248, 0x5, 0x14e, 0xa8, 0x2, 0x248, 0x51, 0x3, 0x2, 0x2, 
    0x2, 0x249, 0x24a, 0x5, 0x88, 0x45, 0x2, 0x24a, 0x53, 0x3, 0x2, 0x2, 
    0x2, 0x24b, 0x24c, 0x7, 0x32, 0x2, 0x2, 0x24c, 0x24d, 0x5, 0x138, 0x9d, 
    0x2, 0x24d, 0x251, 0x7, 0x6b, 0x2, 0x2, 0x24e, 0x250, 0x5, 0x50, 0x29, 
    0x2, 0x24f, 0x24e, 0x3, 0x2, 0x2, 0x2, 0x250, 0x253, 0x3, 0x2, 0x2, 
    0x2, 0x251, 0x24f, 0x3, 0x2, 0x2, 0x2, 0x251, 0x252, 0x3, 0x2, 0x2, 
    0x2, 0x252, 0x257, 0x3, 0x2, 0x2, 0x2, 0x253, 0x251, 0x3, 0x2, 0x2, 
    0x2, 0x254, 0x255, 0x7, 0x6f, 0x2, 0x2, 0x255, 0x256, 0x7, 0xb, 0x2, 
    0x2, 0x256, 0x258, 0x5, 0x14e, 0xa8, 0x2, 0x257, 0x254, 0x3, 0x2, 0x2, 
    0x2, 0x257, 0x258, 0x3, 0x2, 0x2, 0x2, 0x258, 0x259, 0x3, 0x2, 0x2, 
    0x2, 0x259, 0x25a, 0x7, 0x3b, 0x2, 0x2, 0x25a, 0x25b, 0x7, 0x3, 0x2, 
    0x2, 0x25b, 0x55, 0x3, 0x2, 0x2, 0x2, 0x25c, 0x25d, 0x7, 0x2d, 0x2, 
    0x2, 0x25d, 0x261, 0x5, 0x14e, 0xa8, 0x2, 0x25e, 0x260, 0x5, 0x14e, 
    0xa8, 0x2, 0x25f, 0x25e, 0x3, 0x2, 0x2, 0x2, 0x260, 0x263, 0x3, 0x2, 
    0x2, 0x2, 0x261, 0x25f, 0x3, 0x2, 0x2, 0x2, 0x261, 0x262, 0x3, 0x2, 
    0x2, 0x2, 0x262, 0x264, 0x3, 0x2, 0x2, 0x2, 0x263, 0x261, 0x3, 0x2, 
    0x2, 0x2, 0x264, 0x265, 0x7, 0x39, 0x2, 0x2, 0x265, 0x266, 0x7, 0x3, 
    0x2, 0x2, 0x266, 0x57, 0x3, 0x2, 0x2, 0x2, 0x267, 0x26b, 0x5, 0x2e, 
    0x18, 0x2, 0x268, 0x26b, 0x5, 0x14a, 0xa6, 0x2, 0x269, 0x26b, 0x5, 0x1a, 
    0xe, 0x2, 0x26a, 0x267, 0x3, 0x2, 0x2, 0x2, 0x26a, 0x268, 0x3, 0x2, 
    0x2, 0x2, 0x26a, 0x269, 0x3, 0x2, 0x2, 0x2, 0x26b, 0x59, 0x3, 0x2, 0x2, 
    0x2, 0x26c, 0x26d, 0x5, 0x60, 0x31, 0x2, 0x26d, 0x26e, 0x7, 0xb, 0x2, 
    0x2, 0x26e, 0x26f, 0x5, 0xbc, 0x5f, 0x2, 0x26f, 0x270, 0x7, 0xc, 0x2, 
    0x2, 0x270, 0x271, 0x5, 0x88, 0x45, 0x2, 0x271, 0x272, 0x7, 0x3, 0x2, 
    0x2, 0x272, 0x5b, 0x3, 0x2, 0x2, 0x2, 0x273, 0x274, 0x7, 0x33, 0x2, 
    0x2, 0x274, 0x278, 0x5, 0x5a, 0x2e, 0x2, 0x275, 0x277, 0x5, 0x5a, 0x2e, 
    0x2, 0x276, 0x275, 0x3, 0x2, 0x2, 0x2, 0x277, 0x27a, 0x3, 0x2, 0x2, 
    0x2, 0x278, 0x276, 0x3, 0x2, 0x2, 0x2, 0x278, 0x279, 0x3, 0x2, 0x2, 
    0x2, 0x279, 0x27b, 0x3, 0x2, 0x2, 0x2, 0x27a, 0x278, 0x3, 0x2, 0x2, 
    0x2, 0x27b, 0x27c, 0x7, 0x3c, 0x2, 0x2, 0x27c, 0x27d, 0x7, 0x3, 0x2, 
    0x2, 0x27d, 0x5d, 0x3, 0x2, 0x2, 0x2, 0x27e, 0x281, 0x5, 0x4a, 0x26, 
    0x2, 0x27f, 0x281, 0x5, 0x4, 0x3, 0x2, 0x280, 0x27e, 0x3, 0x2, 0x2, 
    0x2, 0x280, 0x27f, 0x3, 0x2, 0x2, 0x2, 0x281, 0x5f, 0x3, 0x2, 0x2, 0x2, 
    0x282, 0x283, 0x7, 0x9f, 0x2, 0x2, 0x283, 0x61, 0x3, 0x2, 0x2, 0x2, 
    0x284, 0x287, 0x5, 0x82, 0x42, 0x2, 0x285, 0x287, 0x5, 0x13e, 0xa0, 
    0x2, 0x286, 0x284, 0x3, 0x2, 0x2, 0x2, 0x286, 0x285, 0x3, 0x2, 0x2, 
    0x2, 0x287, 0x63, 0x3, 0x2, 0x2, 0x2, 0x288, 0x28e, 0x5, 0x72, 0x3a, 
    0x2, 0x289, 0x28e, 0x5, 0x90, 0x49, 0x2, 0x28a, 0x28e, 0x5, 0xfc, 0x7f, 
    0x2, 0x28b, 0x28e, 0x5, 0x15a, 0xae, 0x2, 0x28c, 0x28e, 0x5, 0x172, 
    0xba, 0x2, 0x28d, 0x288, 0x3, 0x2, 0x2, 0x2, 0x28d, 0x289, 0x3, 0x2, 
    0x2, 0x2, 0x28d, 0x28a, 0x3, 0x2, 0x2, 0x2, 0x28d, 0x28b, 0x3, 0x2, 
    0x2, 0x2, 0x28d, 0x28c, 0x3, 0x2, 0x2, 0x2, 0x28e, 0x65, 0x3, 0x2, 0x2, 
    0x2, 0x28f, 0x290, 0x5, 0x38, 0x1d, 0x2, 0x290, 0x291, 0x7, 0xb, 0x2, 
    0x2, 0x291, 0x292, 0x5, 0xf2, 0x7a, 0x2, 0x292, 0x293, 0x7, 0xc, 0x2, 
    0x2, 0x293, 0x294, 0x5, 0x88, 0x45, 0x2, 0x294, 0x295, 0x7, 0x3, 0x2, 
    0x2, 0x295, 0x67, 0x3, 0x2, 0x2, 0x2, 0x296, 0x297, 0x7, 0x36, 0x2, 
    0x2, 0x297, 0x29b, 0x5, 0x66, 0x34, 0x2, 0x298, 0x29a, 0x5, 0x66, 0x34, 
    0x2, 0x299, 0x298, 0x3, 0x2, 0x2, 0x2, 0x29a, 0x29d, 0x3, 0x2, 0x2, 
    0x2, 0x29b, 0x299, 0x3, 0x2, 0x2, 0x2, 0x29b, 0x29c, 0x3, 0x2, 0x2, 
    0x2, 0x29c, 0x69, 0x3, 0x2, 0x2, 0x2, 0x29d, 0x29b, 0x3, 0x2, 0x2, 0x2, 
    0x29e, 0x29f, 0x5, 0x12c, 0x97, 0x2, 0x29f, 0x2a0, 0x7, 0xb, 0x2, 0x2, 
    0x2a0, 0x2a2, 0x3, 0x2, 0x2, 0x2, 0x2a1, 0x29e, 0x3, 0x2, 0x2, 0x2, 
    0x2a1, 0x2a2, 0x3, 0x2, 0x2, 0x2, 0x2a2, 0x2a3, 0x3, 0x2, 0x2, 0x2, 
    0x2a3, 0x2a4, 0x5, 0x88, 0x45, 0x2, 0x2a4, 0x6b, 0x3, 0x2, 0x2, 0x2, 
    0x2a5, 0x2a8, 0x5, 0x88, 0x45, 0x2, 0x2a6, 0x2a7, 0x7, 0xb, 0x2, 0x2, 
    0x2a7, 0x2a9, 0x5, 0x11e, 0x90, 0x2, 0x2a8, 0x2a6, 0x3, 0x2, 0x2, 0x2, 
    0x2a8, 0x2a9, 0x3, 0x2, 0x2, 0x2, 0x2a9, 0x6d, 0x3, 0x2, 0x2, 0x2, 0x2aa, 
    0x2ac, 0x5, 0x86, 0x44, 0x2, 0x2ab, 0x2aa, 0x3, 0x2, 0x2, 0x2, 0x2ac, 
    0x2af, 0x3, 0x2, 0x2, 0x2, 0x2ad, 0x2ab, 0x3, 0x2, 0x2, 0x2, 0x2ad, 
    0x2ae, 0x3, 0x2, 0x2, 0x2, 0x2ae, 0x2b1, 0x3, 0x2, 0x2, 0x2, 0x2af, 
    0x2ad, 0x3, 0x2, 0x2, 0x2, 0x2b0, 0x2b2, 0x5, 0x68, 0x35, 0x2, 0x2b1, 
    0x2b0, 0x3, 0x2, 0x2, 0x2, 0x2b1, 0x2b2, 0x3, 0x2, 0x2, 0x2, 0x2b2, 
    0x2b4, 0x3, 0x2, 0x2, 0x2, 0x2b3, 0x2b5, 0x5, 0xd0, 0x69, 0x2, 0x2b4, 
    0x2b3, 0x3, 0x2, 0x2, 0x2, 0x2b4, 0x2b5, 0x3, 0x2, 0x2, 0x2, 0x2b5, 
    0x2b7, 0x3, 0x2, 0x2, 0x2, 0x2b6, 0x2b8, 0x5, 0x17e, 0xc0, 0x2, 0x2b7, 
    0x2b6, 0x3, 0x2, 0x2, 0x2, 0x2b7, 0x2b8, 0x3, 0x2, 0x2, 0x2, 0x2b8, 
    0x2ba, 0x3, 0x2, 0x2, 0x2, 0x2b9, 0x2bb, 0x5, 0x188, 0xc5, 0x2, 0x2ba, 
    0x2b9, 0x3, 0x2, 0x2, 0x2, 0x2ba, 0x2bb, 0x3, 0x2, 0x2, 0x2, 0x2bb, 
    0x6f, 0x3, 0x2, 0x2, 0x2, 0x2bc, 0x2bd, 0x5, 0x6, 0x4, 0x2, 0x2bd, 0x2c6, 
    0x7, 0x4, 0x2, 0x2, 0x2be, 0x2c3, 0x5, 0x88, 0x45, 0x2, 0x2bf, 0x2c0, 
    0x7, 0x5, 0x2, 0x2, 0x2c0, 0x2c2, 0x5, 0x88, 0x45, 0x2, 0x2c1, 0x2bf, 
    0x3, 0x2, 0x2, 0x2, 0x2c2, 0x2c5, 0x3, 0x2, 0x2, 0x2, 0x2c3, 0x2c1, 
    0x3, 0x2, 0x2, 0x2, 0x2c3, 0x2c4, 0x3, 0x2, 0x2, 0x2, 0x2c4, 0x2c7, 
    0x3, 0x2, 0x2, 0x2, 0x2c5, 0x2c3, 0x3, 0x2, 0x2, 0x2, 0x2c6, 0x2be, 
    0x3, 0x2, 0x2, 0x2, 0x2c6, 0x2c7, 0x3, 0x2, 0x2, 0x2, 0x2c7, 0x2c8, 
    0x3, 0x2, 0x2, 0x2, 0x2c8, 0x2c9, 0x7, 0x6, 0x2, 0x2, 0x2c9, 0x71, 0x3, 
    0x2, 0x2, 0x2, 0x2ca, 0x2cb, 0x5, 0x74, 0x3b, 0x2, 0x2cb, 0x2cc, 0x5, 
    0x6e, 0x38, 0x2, 0x2cc, 0x2cd, 0x7, 0x3d, 0x2, 0x2, 0x2cd, 0x2ce, 0x7, 
    0x3, 0x2, 0x2, 0x2ce, 0x73, 0x3, 0x2, 0x2, 0x2, 0x2cf, 0x2d0, 0x7, 0x47, 
    0x2, 0x2, 0x2d0, 0x2d1, 0x5, 0x76, 0x3c, 0x2, 0x2d1, 0x2d2, 0x5, 0x154, 
    0xab, 0x2, 0x2d2, 0x2d3, 0x7, 0x3, 0x2, 0x2, 0x2d3, 0x75, 0x3, 0x2, 
    0x2, 0x2, 0x2d4, 0x2d5, 0x7, 0x9f, 0x2, 0x2, 0x2d5, 0x77, 0x3, 0x2, 
    0x2, 0x2, 0x2d6, 0x2d7, 0x7, 0x2c, 0x2, 0x2, 0x2d7, 0x2da, 0x5, 0x1a, 
    0xe, 0x2, 0x2d8, 0x2d9, 0x7, 0x97, 0x2, 0x2, 0x2d9, 0x2db, 0x5, 0x7c, 
    0x3f, 0x2, 0x2da, 0x2d8, 0x3, 0x2, 0x2, 0x2, 0x2da, 0x2db, 0x3, 0x2, 
    0x2, 0x2, 0x2db, 0x79, 0x3, 0x2, 0x2, 0x2, 0x2dc, 0x2dd, 0x7, 0x9f, 
    0x2, 0x2, 0x2dd, 0x7b, 0x3, 0x2, 0x2, 0x2, 0x2de, 0x2df, 0x7, 0x4, 0x2, 
    0x2, 0x2df, 0x2e4, 0x5, 0x7e, 0x40, 0x2, 0x2e0, 0x2e1, 0x7, 0x5, 0x2, 
    0x2, 0x2e1, 0x2e3, 0x5, 0x7e, 0x40, 0x2, 0x2e2, 0x2e0, 0x3, 0x2, 0x2, 
    0x2, 0x2e3, 0x2e6, 0x3, 0x2, 0x2, 0x2, 0x2e4, 0x2e2, 0x3, 0x2, 0x2, 
    0x2, 0x2e4, 0x2e5, 0x3, 0x2, 0x2, 0x2, 0x2e5, 0x2e7, 0x3, 0x2, 0x2, 
    0x2, 0x2e6, 0x2e4, 0x3, 0x2, 0x2, 0x2, 0x2e7, 0x2e8, 0x7, 0x6, 0x2, 
    0x2, 0x2e8, 0x7d, 0x3, 0x2, 0x2, 0x2, 0x2e9, 0x2ea, 0x5, 0x7a, 0x3e, 
    0x2, 0x2ea, 0x7f, 0x3, 0x2, 0x2, 0x2, 0x2eb, 0x2ec, 0x5, 0x1a, 0xe, 
    0x2, 0x2ec, 0x2ed, 0x7, 0xd, 0x2, 0x2, 0x2ed, 0x2ef, 0x3, 0x2, 0x2, 
    0x2, 0x2ee, 0x2eb, 0x3, 0x2, 0x2, 0x2, 0x2ee, 0x2ef, 0x3, 0x2, 0x2, 
    0x2, 0x2ef, 0x2f0, 0x3, 0x2, 0x2, 0x2, 0x2f0, 0x2f1, 0x5, 0x8, 0x5, 
    0x2, 0x2f1, 0x81, 0x3, 0x2, 0x2, 0x2, 0x2f2, 0x2f4, 0x7, 0x4c, 0x2, 
    0x2, 0x2f3, 0x2f2, 0x3, 0x2, 0x2, 0x2, 0x2f3, 0x2f4, 0x3, 0x2, 0x2, 
    0x2, 0x2f4, 0x2f5, 0x3, 0x2, 0x2, 0x2, 0x2f5, 0x2f9, 0x7, 0x48, 0x2, 
    0x2, 0x2f6, 0x2f7, 0x7, 0x6b, 0x2, 0x2, 0x2f7, 0x2fa, 0x5, 0x7c, 0x3f, 
    0x2, 0x2f8, 0x2fa, 0x5, 0x78, 0x3d, 0x2, 0x2f9, 0x2f6, 0x3, 0x2, 0x2, 
    0x2, 0x2f9, 0x2f8, 0x3, 0x2, 0x2, 0x2, 0x2f9, 0x2fa, 0x3, 0x2, 0x2, 
    0x2, 0x2fa, 0x83, 0x3, 0x2, 0x2, 0x2, 0x2fb, 0x2fc, 0x7, 0x49, 0x2, 
    0x2, 0x2fc, 0x2fd, 0x7, 0x3, 0x2, 0x2, 0x2fd, 0x85, 0x3, 0x2, 0x2, 0x2, 
    0x2fe, 0x303, 0x5, 0x38, 0x1d, 0x2, 0x2ff, 0x300, 0x7, 0x5, 0x2, 0x2, 
    0x300, 0x302, 0x5, 0x38, 0x1d, 0x2, 0x301, 0x2ff, 0x3, 0x2, 0x2, 0x2, 
    0x302, 0x305, 0x3, 0x2, 0x2, 0x2, 0x303, 0x301, 0x3, 0x2, 0x2, 0x2, 
    0x303, 0x304, 0x3, 0x2, 0x2, 0x2, 0x304, 0x306, 0x3, 0x2, 0x2, 0x2, 
    0x305, 0x303, 0x3, 0x2, 0x2, 0x2, 0x306, 0x308, 0x7, 0xb, 0x2, 0x2, 
    0x307, 0x309, 0x7, 0x6d, 0x2, 0x2, 0x308, 0x307, 0x3, 0x2, 0x2, 0x2, 
    0x308, 0x309, 0x3, 0x2, 0x2, 0x2, 0x309, 0x30a, 0x3, 0x2, 0x2, 0x2, 
    0x30a, 0x30b, 0x5, 0xf2, 0x7a, 0x2, 0x30b, 0x30c, 0x7, 0x3, 0x2, 0x2, 
    0x30c, 0x87, 0x3, 0x2, 0x2, 0x2, 0x30d, 0x311, 0x5, 0x142, 0xa2, 0x2, 
    0x30e, 0x30f, 0x5, 0x116, 0x8c, 0x2, 0x30f, 0x310, 0x5, 0x142, 0xa2, 
    0x2, 0x310, 0x312, 0x3, 0x2, 0x2, 0x2, 0x311, 0x30e, 0x3, 0x2, 0x2, 
    0x2, 0x311, 0x312, 0x3, 0x2, 0x2, 0x2, 0x312, 0x89, 0x3, 0x2, 0x2, 0x2, 
    0x313, 0x316, 0x5, 0x144, 0xa3, 0x2, 0x314, 0x315, 0x7, 0xf, 0x2, 0x2, 
    0x315, 0x317, 0x5, 0x144, 0xa3, 0x2, 0x316, 0x314, 0x3, 0x2, 0x2, 0x2, 
    0x316, 0x317, 0x3, 0x2, 0x2, 0x2, 0x317, 0x8b, 0x3, 0x2, 0x2, 0x2, 0x318, 
    0x31d, 0x5, 0xf0, 0x79, 0x2, 0x319, 0x31a, 0x7, 0x5, 0x2, 0x2, 0x31a, 
    0x31c, 0x5, 0xf0, 0x79, 0x2, 0x31b, 0x319, 0x3, 0x2, 0x2, 0x2, 0x31c, 
    0x31f, 0x3, 0x2, 0x2, 0x2, 0x31d, 0x31b, 0x3, 0x2, 0x2, 0x2, 0x31d, 
    0x31e, 0x3, 0x2, 0x2, 0x2, 0x31e, 0x320, 0x3, 0x2, 0x2, 0x2, 0x31f, 
    0x31d, 0x3, 0x2, 0x2, 0x2, 0x320, 0x321, 0x7, 0xb, 0x2, 0x2, 0x321, 
    0x322, 0x5, 0xf2, 0x7a, 0x2, 0x322, 0x8d, 0x3, 0x2, 0x2, 0x2, 0x323, 
    0x326, 0x5, 0x4c, 0x27, 0x2, 0x324, 0x326, 0x5, 0xa, 0x6, 0x2, 0x325, 
    0x323, 0x3, 0x2, 0x2, 0x2, 0x325, 0x324, 0x3, 0x2, 0x2, 0x2, 0x326, 
    0x328, 0x3, 0x2, 0x2, 0x2, 0x327, 0x329, 0x5, 0x24, 0x13, 0x2, 0x328, 
    0x327, 0x3, 0x2, 0x2, 0x2, 0x328, 0x329, 0x3, 0x2, 0x2, 0x2, 0x329, 
    0x8f, 0x3, 0x2, 0x2, 0x2, 0x32a, 0x32b, 0x5, 0x92, 0x4a, 0x2, 0x32b, 
    0x32c, 0x5, 0x30, 0x19, 0x2, 0x32c, 0x330, 0x5, 0x14e, 0xa8, 0x2, 0x32d, 
    0x32f, 0x5, 0x14e, 0xa8, 0x2, 0x32e, 0x32d, 0x3, 0x2, 0x2, 0x2, 0x32f, 
    0x332, 0x3, 0x2, 0x2, 0x2, 0x330, 0x32e, 0x3, 0x2, 0x2, 0x2, 0x330, 
    0x331, 0x3, 0x2, 0x2, 0x2, 0x331, 0x333, 0x3, 0x2, 0x2, 0x2, 0x332, 
    0x330, 0x3, 0x2, 0x2, 0x2, 0x333, 0x334, 0x7, 0x3e, 0x2, 0x2, 0x334, 
    0x335, 0x7, 0x3, 0x2, 0x2, 0x335, 0x91, 0x3, 0x2, 0x2, 0x2, 0x336, 0x337, 
    0x7, 0x52, 0x2, 0x2, 0x337, 0x343, 0x5, 0x94, 0x4b, 0x2, 0x338, 0x339, 
    0x7, 0x4, 0x2, 0x2, 0x339, 0x33e, 0x5, 0x8c, 0x47, 0x2, 0x33a, 0x33b, 
    0x7, 0x3, 0x2, 0x2, 0x33b, 0x33d, 0x5, 0x8c, 0x47, 0x2, 0x33c, 0x33a, 
    0x3, 0x2, 0x2, 0x2, 0x33d, 0x340, 0x3, 0x2, 0x2, 0x2, 0x33e, 0x33c, 
    0x3, 0x2, 0x2, 0x2, 0x33e, 0x33f, 0x3, 0x2, 0x2, 0x2, 0x33f, 0x341, 
    0x3, 0x2, 0x2, 0x2, 0x340, 0x33e, 0x3, 0x2, 0x2, 0x2, 0x341, 0x342, 
    0x7, 0x6, 0x2, 0x2, 0x342, 0x344, 0x3, 0x2, 0x2, 0x2, 0x343, 0x338, 
    0x3, 0x2, 0x2, 0x2, 0x343, 0x344, 0x3, 0x2, 0x2, 0x2, 0x344, 0x345, 
    0x3, 0x2, 0x2, 0x2, 0x345, 0x346, 0x7, 0xb, 0x2, 0x2, 0x346, 0x347, 
    0x5, 0xf2, 0x7a, 0x2, 0x347, 0x348, 0x7, 0x3, 0x2, 0x2, 0x348, 0x93, 
    0x3, 0x2, 0x2, 0x2, 0x349, 0x34a, 0x7, 0x9f, 0x2, 0x2, 0x34a, 0x95, 
    0x3, 0x2, 0x2, 0x2, 0x34b, 0x350, 0x5, 0x2c, 0x17, 0x2, 0x34c, 0x350, 
    0x5, 0x98, 0x4d, 0x2, 0x34d, 0x350, 0x5, 0xa4, 0x53, 0x2, 0x34e, 0x350, 
    0x5, 0xa6, 0x54, 0x2, 0x34f, 0x34b, 0x3, 0x2, 0x2, 0x2, 0x34f, 0x34c, 
    0x3, 0x2, 0x2, 0x2, 0x34f, 0x34d, 0x3, 0x2, 0x2, 0x2, 0x34f, 0x34e, 
    0x3, 0x2, 0x2, 0x2, 0x350, 0x97, 0x3, 0x2, 0x2, 0x2, 0x351, 0x356, 0x5, 
    0x9a, 0x4e, 0x2, 0x352, 0x356, 0x5, 0x9c, 0x4f, 0x2, 0x353, 0x356, 0x5, 
    0x9e, 0x50, 0x2, 0x354, 0x356, 0x5, 0xa2, 0x52, 0x2, 0x355, 0x351, 0x3, 
    0x2, 0x2, 0x2, 0x355, 0x352, 0x3, 0x2, 0x2, 0x2, 0x355, 0x353, 0x3, 
    0x2, 0x2, 0x2, 0x355, 0x354, 0x3, 0x2, 0x2, 0x2, 0x356, 0x99, 0x3, 0x2, 
    0x2, 0x2, 0x357, 0x359, 0x7, 0x27, 0x2, 0x2, 0x358, 0x35a, 0x5, 0x48, 
    0x25, 0x2, 0x359, 0x358, 0x3, 0x2, 0x2, 0x2, 0x359, 0x35a, 0x3, 0x2, 
    0x2, 0x2, 0x35a, 0x35b, 0x3, 0x2, 0x2, 0x2, 0x35b, 0x35d, 0x7, 0x6b, 
    0x2, 0x2, 0x35c, 0x35e, 0x7, 0x6d, 0x2, 0x2, 0x35d, 0x35c, 0x3, 0x2, 
    0x2, 0x2, 0x35d, 0x35e, 0x3, 0x2, 0x2, 0x2, 0x35e, 0x360, 0x3, 0x2, 
    0x2, 0x2, 0x35f, 0x361, 0x7, 0x8e, 0x2, 0x2, 0x360, 0x35f, 0x3, 0x2, 
    0x2, 0x2, 0x360, 0x361, 0x3, 0x2, 0x2, 0x2, 0x361, 0x362, 0x3, 0x2, 
    0x2, 0x2, 0x362, 0x363, 0x5, 0xf2, 0x7a, 0x2, 0x363, 0x9b, 0x3, 0x2, 
    0x2, 0x2, 0x364, 0x366, 0x7, 0x2b, 0x2, 0x2, 0x365, 0x367, 0x5, 0x48, 
    0x25, 0x2, 0x366, 0x365, 0x3, 0x2, 0x2, 0x2, 0x366, 0x367, 0x3, 0x2, 
    0x2, 0x2, 0x367, 0x368, 0x3, 0x2, 0x2, 0x2, 0x368, 0x369, 0x7, 0x6b, 
    0x2, 0x2, 0x369, 0x36a, 0x5, 0xf2, 0x7a, 0x2, 0x36a, 0x9d, 0x3, 0x2, 
    0x2, 0x2, 0x36b, 0x36d, 0x7, 0x5e, 0x2, 0x2, 0x36c, 0x36e, 0x5, 0x48, 
    0x25, 0x2, 0x36d, 0x36c, 0x3, 0x2, 0x2, 0x2, 0x36d, 0x36e, 0x3, 0x2, 
    0x2, 0x2, 0x36e, 0x36f, 0x3, 0x2, 0x2, 0x2, 0x36f, 0x371, 0x7, 0x6b, 
    0x2, 0x2, 0x370, 0x372, 0x7, 0x8e, 0x2, 0x2, 0x371, 0x370, 0x3, 0x2, 
    0x2, 0x2, 0x371, 0x372, 0x3, 0x2, 0x2, 0x2, 0x372, 0x373, 0x3, 0x2, 
    0x2, 0x2, 0x373, 0x374, 0x5, 0xf2, 0x7a, 0x2, 0x374, 0x9f, 0x3, 0x2, 
    0x2, 0x2, 0x375, 0x378, 0x5, 0xc, 0x7, 0x2, 0x376, 0x378, 0x5, 0x186, 
    0xc4, 0x2, 0x377, 0x375, 0x3, 0x2, 0x2, 0x2, 0x377, 0x376, 0x3, 0x2, 
    0x2, 0x2, 0x378, 0xa1, 0x3, 0x2, 0x2, 0x2, 0x379, 0x37b, 0x7, 0x7e, 
    0x2, 0x2, 0x37a, 0x37c, 0x5, 0x48, 0x25, 0x2, 0x37b, 0x37a, 0x3, 0x2, 
    0x2, 0x2, 0x37b, 0x37c, 0x3, 0x2, 0x2, 0x2, 0x37c, 0x37d, 0x3, 0x2, 
    0x2, 0x2, 0x37d, 0x37e, 0x7, 0x6b, 0x2, 0x2, 0x37e, 0x37f, 0x5, 0xf2, 
    0x7a, 0x2, 0x37f, 0xa3, 0x3, 0x2, 0x2, 0x2, 0x380, 0x383, 0x7, 0x54, 
    0x2, 0x2, 0x381, 0x382, 0x7, 0xb, 0x2, 0x2, 0x382, 0x384, 0x5, 0x176, 
    0xbc, 0x2, 0x383, 0x381, 0x3, 0x2, 0x2, 0x2, 0x383, 0x384, 0x3, 0x2, 
    0x2, 0x2, 0x384, 0xa5, 0x3, 0x2, 0x2, 0x2, 0x385, 0x388, 0x7, 0x53, 
    0x2, 0x2, 0x386, 0x387, 0x7, 0xb, 0x2, 0x2, 0x387, 0x389, 0x5, 0x176, 
    0xbc, 0x2, 0x388, 0x386, 0x3, 0x2, 0x2, 0x2, 0x388, 0x389, 0x3, 0x2, 
    0x2, 0x2, 0x389, 0xa7, 0x3, 0x2, 0x2, 0x2, 0x38a, 0x38b, 0x7, 0x10, 
    0x2, 0x2, 0x38b, 0x38c, 0x5, 0x6, 0x4, 0x2, 0x38c, 0xa9, 0x3, 0x2, 0x2, 
    0x2, 0x38d, 0x38e, 0x7, 0x57, 0x2, 0x2, 0x38e, 0x38f, 0x5, 0xda, 0x6e, 
    0x2, 0x38f, 0x390, 0x7, 0x88, 0x2, 0x2, 0x390, 0x393, 0x5, 0xac, 0x57, 
    0x2, 0x391, 0x392, 0x7, 0x38, 0x2, 0x2, 0x392, 0x394, 0x5, 0xae, 0x58, 
    0x2, 0x393, 0x391, 0x3, 0x2, 0x2, 0x2, 0x393, 0x394, 0x3, 0x2, 0x2, 
    0x2, 0x394, 0x395, 0x3, 0x2, 0x2, 0x2, 0x395, 0x396, 0x7, 0x3f, 0x2, 
    0x2, 0x396, 0x397, 0x7, 0x3, 0x2, 0x2, 0x397, 0xab, 0x3, 0x2, 0x2, 0x2, 
    0x398, 0x39c, 0x5, 0x14e, 0xa8, 0x2, 0x399, 0x39b, 0x5, 0x14e, 0xa8, 
    0x2, 0x39a, 0x399, 0x3, 0x2, 0x2, 0x2, 0x39b, 0x39e, 0x3, 0x2, 0x2, 
    0x2, 0x39c, 0x39a, 0x3, 0x2, 0x2, 0x2, 0x39c, 0x39d, 0x3, 0x2, 0x2, 
    0x2, 0x39d, 0xad, 0x3, 0x2, 0x2, 0x2, 0x39e, 0x39c, 0x3, 0x2, 0x2, 0x2, 
    0x39f, 0x3a3, 0x5, 0x14e, 0xa8, 0x2, 0x3a0, 0x3a2, 0x5, 0x14e, 0xa8, 
    0x2, 0x3a1, 0x3a0, 0x3, 0x2, 0x2, 0x2, 0x3a2, 0x3a5, 0x3, 0x2, 0x2, 
    0x2, 0x3a3, 0x3a1, 0x3, 0x2, 0x2, 0x2, 0x3a3, 0x3a4, 0x3, 0x2, 0x2, 
    0x2, 0x3a4, 0xaf, 0x3, 0x2, 0x2, 0x2, 0x3a5, 0x3a3, 0x3, 0x2, 0x2, 0x2, 
    0x3a6, 0x3a7, 0x5, 0xea, 0x76, 0x2, 0x3a7, 0xb1, 0x3, 0x2, 0x2, 0x2, 
    0x3a8, 0x3a9, 0x5, 0x186, 0xc4, 0x2, 0x3a9, 0x3aa, 0x7, 0xc, 0x2, 0x2, 
    0x3aa, 0x3ab, 0x5, 0x44, 0x23, 0x2, 0x3ab, 0x3ac, 0x7, 0x89, 0x2, 0x2, 
    0x3ac, 0x3af, 0x5, 0x46, 0x24, 0x2, 0x3ad, 0x3ae, 0x7, 0x31, 0x2, 0x2, 
    0x3ae, 0x3b0, 0x5, 0xb0, 0x59, 0x2, 0x3af, 0x3ad, 0x3, 0x2, 0x2, 0x2, 
    0x3af, 0x3b0, 0x3, 0x2, 0x2, 0x2, 0x3b0, 0xb3, 0x3, 0x2, 0x2, 0x2, 0x3b1, 
    0x3b2, 0x5, 0xea, 0x76, 0x2, 0x3b2, 0xb5, 0x3, 0x2, 0x2, 0x2, 0x3b3, 
    0x3b4, 0x5, 0xb4, 0x5b, 0x2, 0x3b4, 0xb7, 0x3, 0x2, 0x2, 0x2, 0x3b5, 
    0x3b6, 0x5, 0xb4, 0x5b, 0x2, 0x3b6, 0xb9, 0x3, 0x2, 0x2, 0x2, 0x3b7, 
    0x3b8, 0x7, 0x9, 0x2, 0x2, 0x3b8, 0x3bb, 0x5, 0xb6, 0x5c, 0x2, 0x3b9, 
    0x3ba, 0x7, 0xb, 0x2, 0x2, 0x3ba, 0x3bc, 0x5, 0xb8, 0x5d, 0x2, 0x3bb, 
    0x3b9, 0x3, 0x2, 0x2, 0x2, 0x3bb, 0x3bc, 0x3, 0x2, 0x2, 0x2, 0x3bc, 
    0x3bd, 0x3, 0x2, 0x2, 0x2, 0x3bd, 0x3be, 0x7, 0xa, 0x2, 0x2, 0x3be, 
    0xbb, 0x3, 0x2, 0x2, 0x2, 0x3bf, 0x3c2, 0x5, 0x58, 0x2d, 0x2, 0x3c0, 
    0x3c2, 0x5, 0x6, 0x4, 0x2, 0x3c1, 0x3bf, 0x3, 0x2, 0x2, 0x2, 0x3c1, 
    0x3c0, 0x3, 0x2, 0x2, 0x2, 0x3c2, 0xbd, 0x3, 0x2, 0x2, 0x2, 0x3c3, 0x3c4, 
    0x7, 0x5a, 0x2, 0x2, 0x3c4, 0xbf, 0x3, 0x2, 0x2, 0x2, 0x3c5, 0x3c8, 
    0x5, 0x112, 0x8a, 0x2, 0x3c6, 0x3c8, 0x5, 0x184, 0xc3, 0x2, 0x3c7, 0x3c5, 
    0x3, 0x2, 0x2, 0x2, 0x3c7, 0x3c6, 0x3, 0x2, 0x2, 0x2, 0x3c8, 0xc1, 0x3, 
    0x2, 0x2, 0x2, 0x3c9, 0x3ca, 0x7, 0x11, 0x2, 0x2, 0x3ca, 0x3cb, 0x5, 
    0xc8, 0x65, 0x2, 0x3cb, 0x3cc, 0x5, 0xca, 0x66, 0x2, 0x3cc, 0x3cd, 0x5, 
    0xc6, 0x64, 0x2, 0x3cd, 0x3ce, 0x5, 0xca, 0x66, 0x2, 0x3ce, 0x3cf, 0x5, 
    0xc4, 0x63, 0x2, 0x3cf, 0x3d0, 0x7, 0x12, 0x2, 0x2, 0x3d0, 0xc3, 0x3, 
    0x2, 0x2, 0x2, 0x3d1, 0x3d2, 0x5, 0x142, 0xa2, 0x2, 0x3d2, 0xc5, 0x3, 
    0x2, 0x2, 0x2, 0x3d3, 0x3d4, 0x5, 0x142, 0xa2, 0x2, 0x3d4, 0xc7, 0x3, 
    0x2, 0x2, 0x2, 0x3d5, 0x3d6, 0x5, 0x142, 0xa2, 0x2, 0x3d6, 0xc9, 0x3, 
    0x2, 0x2, 0x2, 0x3d7, 0x3d8, 0x9, 0x6, 0x2, 0x2, 0x3d8, 0xcb, 0x3, 0x2, 
    0x2, 0x2, 0x3d9, 0x3da, 0x5, 0x38, 0x1d, 0x2, 0x3da, 0x3db, 0x7, 0xb, 
    0x2, 0x2, 0x3db, 0x3dc, 0x5, 0xce, 0x68, 0x2, 0x3dc, 0x3e0, 0x7, 0x4f, 
    0x2, 0x2, 0x3dd, 0x3de, 0x5, 0x6, 0x4, 0x2, 0x3de, 0x3df, 0x7, 0xd, 
    0x2, 0x2, 0x3df, 0x3e1, 0x3, 0x2, 0x2, 0x2, 0x3e0, 0x3dd, 0x3, 0x2, 
    0x2, 0x2, 0x3e0, 0x3e1, 0x3, 0x2, 0x2, 0x2, 0x3e1, 0x3e2, 0x3, 0x2, 
    0x2, 0x2, 0x3e2, 0x3e3, 0x5, 0x2, 0x2, 0x2, 0x3e3, 0x3e4, 0x7, 0x3, 
    0x2, 0x2, 0x3e4, 0xcd, 0x3, 0x2, 0x2, 0x2, 0x3e5, 0x3e7, 0x9, 0x7, 0x2, 
    0x2, 0x3e6, 0x3e8, 0x5, 0x48, 0x25, 0x2, 0x3e7, 0x3e6, 0x3, 0x2, 0x2, 
    0x2, 0x3e7, 0x3e8, 0x3, 0x2, 0x2, 0x2, 0x3e8, 0x3e9, 0x3, 0x2, 0x2, 
    0x2, 0x3e9, 0x3eb, 0x7, 0x6b, 0x2, 0x2, 0x3ea, 0x3e5, 0x3, 0x2, 0x2, 
    0x2, 0x3ea, 0x3eb, 0x3, 0x2, 0x2, 0x2, 0x3eb, 0x3ec, 0x3, 0x2, 0x2, 
    0x2, 0x3ec, 0x3ed, 0x5, 0x6, 0x4, 0x2, 0x3ed, 0xcf, 0x3, 0x2, 0x2, 0x2, 
    0x3ee, 0x3ef, 0x7, 0x5b, 0x2, 0x2, 0x3ef, 0x3f3, 0x5, 0xcc, 0x67, 0x2, 
    0x3f0, 0x3f2, 0x5, 0xcc, 0x67, 0x2, 0x3f1, 0x3f0, 0x3, 0x2, 0x2, 0x2, 
    0x3f2, 0x3f5, 0x3, 0x2, 0x2, 0x2, 0x3f3, 0x3f1, 0x3, 0x2, 0x2, 0x2, 
    0x3f3, 0x3f4, 0x3, 0x2, 0x2, 0x2, 0x3f4, 0xd1, 0x3, 0x2, 0x2, 0x2, 0x3f5, 
    0x3f3, 0x3, 0x2, 0x2, 0x2, 0x3f6, 0x3f8, 0x7, 0x5e, 0x2, 0x2, 0x3f7, 
    0x3f9, 0x5, 0x48, 0x25, 0x2, 0x3f8, 0x3f7, 0x3, 0x2, 0x2, 0x2, 0x3f8, 
    0x3f9, 0x3, 0x2, 0x2, 0x2, 0x3f9, 0x3fa, 0x3, 0x2, 0x2, 0x2, 0x3fa, 
    0x3fc, 0x7, 0x6b, 0x2, 0x2, 0x3fb, 0x3fd, 0x7, 0x8e, 0x2, 0x2, 0x3fc, 
    0x3fb, 0x3, 0x2, 0x2, 0x2, 0x3fc, 0x3fd, 0x3, 0x2, 0x2, 0x2, 0x3fd, 
    0x3fe, 0x3, 0x2, 0x2, 0x2, 0x3fe, 0x3ff, 0x5, 0xbc, 0x5f, 0x2, 0x3ff, 
    0xd3, 0x3, 0x2, 0x2, 0x2, 0x400, 0x406, 0x7, 0x9b, 0x2, 0x2, 0x401, 
    0x406, 0x7, 0x9d, 0x2, 0x2, 0x402, 0x406, 0x5, 0xdc, 0x6f, 0x2, 0x403, 
    0x406, 0x7, 0x9e, 0x2, 0x2, 0x404, 0x406, 0x5, 0x150, 0xa9, 0x2, 0x405, 
    0x400, 0x3, 0x2, 0x2, 0x2, 0x405, 0x401, 0x3, 0x2, 0x2, 0x2, 0x405, 
    0x402, 0x3, 0x2, 0x2, 0x2, 0x405, 0x403, 0x3, 0x2, 0x2, 0x2, 0x405, 
    0x404, 0x3, 0x2, 0x2, 0x2, 0x406, 0xd5, 0x3, 0x2, 0x2, 0x2, 0x407, 0x408, 
    0x7, 0x60, 0x2, 0x2, 0x408, 0x40c, 0x5, 0xd8, 0x6d, 0x2, 0x409, 0x40b, 
    0x5, 0xd8, 0x6d, 0x2, 0x40a, 0x409, 0x3, 0x2, 0x2, 0x2, 0x40b, 0x40e, 
    0x3, 0x2, 0x2, 0x2, 0x40c, 0x40a, 0x3, 0x2, 0x2, 0x2, 0x40c, 0x40d, 
    0x3, 0x2, 0x2, 0x2, 0x40d, 0x40f, 0x3, 0x2, 0x2, 0x2, 0x40e, 0x40c, 
    0x3, 0x2, 0x2, 0x2, 0x40f, 0x410, 0x7, 0x40, 0x2, 0x2, 0x410, 0x411, 
    0x7, 0x3, 0x2, 0x2, 0x411, 0xd7, 0x3, 0x2, 0x2, 0x2, 0x412, 0x417, 0x5, 
    0x186, 0xc4, 0x2, 0x413, 0x414, 0x7, 0x5, 0x2, 0x2, 0x414, 0x416, 0x5, 
    0x186, 0xc4, 0x2, 0x415, 0x413, 0x3, 0x2, 0x2, 0x2, 0x416, 0x419, 0x3, 
    0x2, 0x2, 0x2, 0x417, 0x415, 0x3, 0x2, 0x2, 0x2, 0x417, 0x418, 0x3, 
    0x2, 0x2, 0x2, 0x418, 0x41a, 0x3, 0x2, 0x2, 0x2, 0x419, 0x417, 0x3, 
    0x2, 0x2, 0x2, 0x41a, 0x41b, 0x7, 0xb, 0x2, 0x2, 0x41b, 0x41e, 0x5, 
    0xf2, 0x7a, 0x2, 0x41c, 0x41d, 0x7, 0xc, 0x2, 0x2, 0x41d, 0x41f, 0x5, 
    0x88, 0x45, 0x2, 0x41e, 0x41c, 0x3, 0x2, 0x2, 0x2, 0x41e, 0x41f, 0x3, 
    0x2, 0x2, 0x2, 0x41f, 0x420, 0x3, 0x2, 0x2, 0x2, 0x420, 0x421, 0x7, 
    0x3, 0x2, 0x2, 0x421, 0xd9, 0x3, 0x2, 0x2, 0x2, 0x422, 0x423, 0x5, 0x88, 
    0x45, 0x2, 0x423, 0xdb, 0x3, 0x2, 0x2, 0x2, 0x424, 0x425, 0x9, 0x8, 
    0x2, 0x2, 0x425, 0xdd, 0x3, 0x2, 0x2, 0x2, 0x426, 0x427, 0x7, 0x64, 
    0x2, 0x2, 0x427, 0xdf, 0x3, 0x2, 0x2, 0x2, 0x428, 0x429, 0x9, 0x9, 0x2, 
    0x2, 0x429, 0xe1, 0x3, 0x2, 0x2, 0x2, 0x42a, 0x42d, 0x5, 0x6, 0x4, 0x2, 
    0x42b, 0x42d, 0x5, 0x1a, 0xe, 0x2, 0x42c, 0x42a, 0x3, 0x2, 0x2, 0x2, 
    0x42c, 0x42b, 0x3, 0x2, 0x2, 0x2, 0x42d, 0xe3, 0x3, 0x2, 0x2, 0x2, 0x42e, 
    0x434, 0x5, 0xe2, 0x72, 0x2, 0x42f, 0x432, 0x7, 0x28, 0x2, 0x2, 0x430, 
    0x433, 0x5, 0x76, 0x3c, 0x2, 0x431, 0x433, 0x5, 0x174, 0xbb, 0x2, 0x432, 
    0x430, 0x3, 0x2, 0x2, 0x2, 0x432, 0x431, 0x3, 0x2, 0x2, 0x2, 0x433, 
    0x435, 0x3, 0x2, 0x2, 0x2, 0x434, 0x42f, 0x3, 0x2, 0x2, 0x2, 0x434, 
    0x435, 0x3, 0x2, 0x2, 0x2, 0x435, 0xe5, 0x3, 0x2, 0x2, 0x2, 0x436, 0x437, 
    0x7, 0x3, 0x2, 0x2, 0x437, 0xe7, 0x3, 0x2, 0x2, 0x2, 0x438, 0x439, 0x7, 
    0x68, 0x2, 0x2, 0x439, 0xe9, 0x3, 0x2, 0x2, 0x2, 0x43a, 0x43b, 0x5, 
    0x142, 0xa2, 0x2, 0x43b, 0xeb, 0x3, 0x2, 0x2, 0x2, 0x43c, 0x43d, 0x7, 
    0x6c, 0x2, 0x2, 0x43d, 0x43e, 0x7, 0x4, 0x2, 0x2, 0x43e, 0x443, 0x5, 
    0x164, 0xb3, 0x2, 0x43f, 0x440, 0x7, 0x5, 0x2, 0x2, 0x440, 0x442, 0x5, 
    0x164, 0xb3, 0x2, 0x441, 0x43f, 0x3, 0x2, 0x2, 0x2, 0x442, 0x445, 0x3, 
    0x2, 0x2, 0x2, 0x443, 0x441, 0x3, 0x2, 0x2, 0x2, 0x443, 0x444, 0x3, 
    0x2, 0x2, 0x2, 0x444, 0x446, 0x3, 0x2, 0x2, 0x2, 0x445, 0x443, 0x3, 
    0x2, 0x2, 0x2, 0x446, 0x447, 0x7, 0x6, 0x2, 0x2, 0x447, 0xed, 0x3, 0x2, 
    0x2, 0x2, 0x448, 0x449, 0x5, 0x88, 0x45, 0x2, 0x449, 0xef, 0x3, 0x2, 
    0x2, 0x2, 0x44a, 0x44b, 0x7, 0x9f, 0x2, 0x2, 0x44b, 0xf1, 0x3, 0x2, 
    0x2, 0x2, 0x44c, 0x450, 0x5, 0x96, 0x4c, 0x2, 0x44d, 0x450, 0x5, 0xe2, 
    0x72, 0x2, 0x44e, 0x450, 0x5, 0x14a, 0xa6, 0x2, 0x44f, 0x44c, 0x3, 0x2, 
    0x2, 0x2, 0x44f, 0x44d, 0x3, 0x2, 0x2, 0x2, 0x44f, 0x44e, 0x3, 0x2, 
    0x2, 0x2, 0x450, 0xf3, 0x3, 0x2, 0x2, 0x2, 0x451, 0x452, 0x5, 0x6, 0x4, 
    0x2, 0x452, 0xf5, 0x3, 0x2, 0x2, 0x2, 0x453, 0x454, 0x5, 0xea, 0x76, 
    0x2, 0x454, 0xf7, 0x3, 0x2, 0x2, 0x2, 0x455, 0x45e, 0x5, 0xd4, 0x6b, 
    0x2, 0x456, 0x45a, 0x5, 0x104, 0x83, 0x2, 0x457, 0x459, 0x5, 0x108, 
    0x85, 0x2, 0x458, 0x457, 0x3, 0x2, 0x2, 0x2, 0x459, 0x45c, 0x3, 0x2, 
    0x2, 0x2, 0x45a, 0x458, 0x3, 0x2, 0x2, 0x2, 0x45a, 0x45b, 0x3, 0x2, 
    0x2, 0x2, 0x45b, 0x45e, 0x3, 0x2, 0x2, 0x2, 0x45c, 0x45a, 0x3, 0x2, 
    0x2, 0x2, 0x45d, 0x455, 0x3, 0x2, 0x2, 0x2, 0x45d, 0x456, 0x3, 0x2, 
    0x2, 0x2, 0x45e, 0xf9, 0x3, 0x2, 0x2, 0x2, 0x45f, 0x462, 0x5, 0x4e, 
    0x28, 0x2, 0x460, 0x462, 0x5, 0xe, 0x8, 0x2, 0x461, 0x45f, 0x3, 0x2, 
    0x2, 0x2, 0x461, 0x460, 0x3, 0x2, 0x2, 0x2, 0x462, 0x464, 0x3, 0x2, 
    0x2, 0x2, 0x463, 0x465, 0x5, 0x24, 0x13, 0x2, 0x464, 0x463, 0x3, 0x2, 
    0x2, 0x2, 0x464, 0x465, 0x3, 0x2, 0x2, 0x2, 0x465, 0x466, 0x3, 0x2, 
    0x2, 0x2, 0x466, 0x467, 0x7, 0x3, 0x2, 0x2, 0x467, 0xfb, 0x3, 0x2, 0x2, 
    0x2, 0x468, 0x469, 0x5, 0xfe, 0x80, 0x2, 0x469, 0x46d, 0x5, 0x30, 0x19, 
    0x2, 0x46a, 0x46c, 0x5, 0x14e, 0xa8, 0x2, 0x46b, 0x46a, 0x3, 0x2, 0x2, 
    0x2, 0x46c, 0x46f, 0x3, 0x2, 0x2, 0x2, 0x46d, 0x46b, 0x3, 0x2, 0x2, 
    0x2, 0x46d, 0x46e, 0x3, 0x2, 0x2, 0x2, 0x46e, 0x470, 0x3, 0x2, 0x2, 
    0x2, 0x46f, 0x46d, 0x3, 0x2, 0x2, 0x2, 0x470, 0x471, 0x7, 0x41, 0x2, 
    0x2, 0x471, 0x472, 0x7, 0x3, 0x2, 0x2, 0x472, 0xfd, 0x3, 0x2, 0x2, 0x2, 
    0x473, 0x474, 0x7, 0x71, 0x2, 0x2, 0x474, 0x480, 0x5, 0x102, 0x82, 0x2, 
    0x475, 0x476, 0x7, 0x4, 0x2, 0x2, 0x476, 0x47b, 0x5, 0x100, 0x81, 0x2, 
    0x477, 0x478, 0x7, 0x3, 0x2, 0x2, 0x478, 0x47a, 0x5, 0x100, 0x81, 0x2, 
    0x479, 0x477, 0x3, 0x2, 0x2, 0x2, 0x47a, 0x47d, 0x3, 0x2, 0x2, 0x2, 
    0x47b, 0x479, 0x3, 0x2, 0x2, 0x2, 0x47b, 0x47c, 0x3, 0x2, 0x2, 0x2, 
    0x47c, 0x47e, 0x3, 0x2, 0x2, 0x2, 0x47d, 0x47b, 0x3, 0x2, 0x2, 0x2, 
    0x47e, 0x47f, 0x7, 0x6, 0x2, 0x2, 0x47f, 0x481, 0x3, 0x2, 0x2, 0x2, 
    0x480, 0x475, 0x3, 0x2, 0x2, 0x2, 0x480, 0x481, 0x3, 0x2, 0x2, 0x2, 
    0x481, 0x482, 0x3, 0x2, 0x2, 0x2, 0x482, 0x483, 0x7, 0x3, 0x2, 0x2, 
    0x483, 0xff, 0x3, 0x2, 0x2, 0x2, 0x484, 0x486, 0x7, 0x96, 0x2, 0x2, 
    0x485, 0x484, 0x3, 0x2, 0x2, 0x2, 0x485, 0x486, 0x3, 0x2, 0x2, 0x2, 
    0x486, 0x487, 0x3, 0x2, 0x2, 0x2, 0x487, 0x488, 0x5, 0x8c, 0x47, 0x2, 
    0x488, 0x101, 0x3, 0x2, 0x2, 0x2, 0x489, 0x48a, 0x7, 0x9f, 0x2, 0x2, 
    0x48a, 0x103, 0x3, 0x2, 0x2, 0x2, 0x48b, 0x491, 0x5, 0x2, 0x2, 0x2, 
    0x48c, 0x491, 0x5, 0x5e, 0x30, 0x2, 0x48d, 0x491, 0x5, 0x8e, 0x48, 0x2, 
    0x48e, 0x491, 0x5, 0xa0, 0x51, 0x2, 0x48f, 0x491, 0x5, 0xf4, 0x7b, 0x2, 
    0x490, 0x48b, 0x3, 0x2, 0x2, 0x2, 0x490, 0x48c, 0x3, 0x2, 0x2, 0x2, 
    0x490, 0x48d, 0x3, 0x2, 0x2, 0x2, 0x490, 0x48e, 0x3, 0x2, 0x2, 0x2, 
    0x490, 0x48f, 0x3, 0x2, 0x2, 0x2, 0x491, 0x105, 0x3, 0x2, 0x2, 0x2, 
    0x492, 0x493, 0x7, 0x7d, 0x2, 0x2, 0x493, 0x494, 0x5, 0xa8, 0x55, 0x2, 
    0x494, 0x495, 0x5, 0x3c, 0x1f, 0x2, 0x495, 0x107, 0x3, 0x2, 0x2, 0x2, 
    0x496, 0x49a, 0x5, 0x3c, 0x1f, 0x2, 0x497, 0x49a, 0x5, 0xa8, 0x55, 0x2, 
    0x498, 0x49a, 0x5, 0xba, 0x5e, 0x2, 0x499, 0x496, 0x3, 0x2, 0x2, 0x2, 
    0x499, 0x497, 0x3, 0x2, 0x2, 0x2, 0x499, 0x498, 0x3, 0x2, 0x2, 0x2, 
    0x49a, 0x109, 0x3, 0x2, 0x2, 0x2, 0x49b, 0x49c, 0x7, 0x72, 0x2, 0x2, 
    0x49c, 0x49d, 0x7, 0x4, 0x2, 0x2, 0x49d, 0x49e, 0x5, 0x186, 0xc4, 0x2, 
    0x49e, 0x49f, 0x7, 0x18, 0x2, 0x2, 0x49f, 0x4a0, 0x5, 0x2a, 0x16, 0x2, 
    0x4a0, 0x4a1, 0x7, 0x19, 0x2, 0x2, 0x4a1, 0x4a2, 0x5, 0xda, 0x6e, 0x2, 
    0x4a2, 0x4a3, 0x7, 0x6, 0x2, 0x2, 0x4a3, 0x10b, 0x3, 0x2, 0x2, 0x2, 
    0x4a4, 0x4a9, 0x7, 0x73, 0x2, 0x2, 0x4a5, 0x4a6, 0x7, 0x4, 0x2, 0x2, 
    0x4a6, 0x4a7, 0x5, 0xf6, 0x7c, 0x2, 0x4a7, 0x4a8, 0x7, 0x6, 0x2, 0x2, 
    0x4a8, 0x4aa, 0x3, 0x2, 0x2, 0x2, 0x4a9, 0x4a5, 0x3, 0x2, 0x2, 0x2, 
    0x4a9, 0x4aa, 0x3, 0x2, 0x2, 0x2, 0x4aa, 0x10d, 0x3, 0x2, 0x2, 0x2, 
    0x4ab, 0x4ae, 0x5, 0x106, 0x84, 0x2, 0x4ac, 0x4ad, 0x7, 0x76, 0x2, 0x2, 
    0x4ad, 0x4af, 0x5, 0x3a, 0x1e, 0x2, 0x4ae, 0x4ac, 0x3, 0x2, 0x2, 0x2, 
    0x4ae, 0x4af, 0x3, 0x2, 0x2, 0x2, 0x4af, 0x10f, 0x3, 0x2, 0x2, 0x2, 
    0x4b0, 0x4b3, 0x5, 0x2, 0x2, 0x2, 0x4b1, 0x4b3, 0x5, 0x106, 0x84, 0x2, 
    0x4b2, 0x4b0, 0x3, 0x2, 0x2, 0x2, 0x4b2, 0x4b1, 0x3, 0x2, 0x2, 0x2, 
    0x4b3, 0x111, 0x3, 0x2, 0x2, 0x2, 0x4b4, 0x4b5, 0x7, 0x74, 0x2, 0x2, 
    0x4b5, 0x4b6, 0x7, 0x51, 0x2, 0x2, 0x4b6, 0x4c2, 0x5, 0x14, 0xb, 0x2, 
    0x4b7, 0x4b8, 0x7, 0x4, 0x2, 0x2, 0x4b8, 0x4bd, 0x5, 0x120, 0x91, 0x2, 
    0x4b9, 0x4ba, 0x7, 0x5, 0x2, 0x2, 0x4ba, 0x4bc, 0x5, 0x120, 0x91, 0x2, 
    0x4bb, 0x4b9, 0x3, 0x2, 0x2, 0x2, 0x4bc, 0x4bf, 0x3, 0x2, 0x2, 0x2, 
    0x4bd, 0x4bb, 0x3, 0x2, 0x2, 0x2, 0x4bd, 0x4be, 0x3, 0x2, 0x2, 0x2, 
    0x4be, 0x4c0, 0x3, 0x2, 0x2, 0x2, 0x4bf, 0x4bd, 0x3, 0x2, 0x2, 0x2, 
    0x4c0, 0x4c1, 0x7, 0x6, 0x2, 0x2, 0x4c1, 0x4c3, 0x3, 0x2, 0x2, 0x2, 
    0x4c2, 0x4b7, 0x3, 0x2, 0x2, 0x2, 0x4c2, 0x4c3, 0x3, 0x2, 0x2, 0x2, 
    0x4c3, 0x4c4, 0x3, 0x2, 0x2, 0x2, 0x4c4, 0x4c5, 0x7, 0x3, 0x2, 0x2, 
    0x4c5, 0x113, 0x3, 0x2, 0x2, 0x2, 0x4c6, 0x4c7, 0x9, 0xa, 0x2, 0x2, 
    0x4c7, 0x115, 0x3, 0x2, 0x2, 0x2, 0x4c8, 0x4cc, 0x5, 0x114, 0x8b, 0x2, 
    0x4c9, 0x4cc, 0x7, 0x58, 0x2, 0x2, 0x4ca, 0x4cc, 0x7, 0x5d, 0x2, 0x2, 
    0x4cb, 0x4c8, 0x3, 0x2, 0x2, 0x2, 0x4cb, 0x4c9, 0x3, 0x2, 0x2, 0x2, 
    0x4cb, 0x4ca, 0x3, 0x2, 0x2, 0x2, 0x4cc, 0x117, 0x3, 0x2, 0x2, 0x2, 
    0x4cd, 0x4d3, 0x5, 0x60, 0x31, 0x2, 0x4ce, 0x4d3, 0x5, 0x76, 0x3c, 0x2, 
    0x4cf, 0x4d3, 0x5, 0x94, 0x4b, 0x2, 0x4d0, 0x4d3, 0x5, 0x102, 0x82, 
    0x2, 0x4d1, 0x4d3, 0x5, 0x174, 0xbb, 0x2, 0x4d2, 0x4cd, 0x3, 0x2, 0x2, 
    0x2, 0x4d2, 0x4ce, 0x3, 0x2, 0x2, 0x2, 0x4d2, 0x4cf, 0x3, 0x2, 0x2, 
    0x2, 0x4d2, 0x4d0, 0x3, 0x2, 0x2, 0x2, 0x4d2, 0x4d1, 0x3, 0x2, 0x2, 
    0x2, 0x4d3, 0x119, 0x3, 0x2, 0x2, 0x2, 0x4d4, 0x4d6, 0x5, 0xb2, 0x5a, 
    0x2, 0x4d5, 0x4d4, 0x3, 0x2, 0x2, 0x2, 0x4d5, 0x4d6, 0x3, 0x2, 0x2, 
    0x2, 0x4d6, 0x4d8, 0x3, 0x2, 0x2, 0x2, 0x4d7, 0x4d9, 0x5, 0x18a, 0xc6, 
    0x2, 0x4d8, 0x4d7, 0x3, 0x2, 0x2, 0x2, 0x4d8, 0x4d9, 0x3, 0x2, 0x2, 
    0x2, 0x4d9, 0x4db, 0x3, 0x2, 0x2, 0x2, 0x4da, 0x4dc, 0x5, 0x182, 0xc2, 
    0x2, 0x4db, 0x4da, 0x3, 0x2, 0x2, 0x2, 0x4db, 0x4dc, 0x3, 0x2, 0x2, 
    0x2, 0x4dc, 0x11b, 0x3, 0x2, 0x2, 0x2, 0x4dd, 0x4de, 0x7, 0x77, 0x2, 
    0x2, 0x4de, 0x4df, 0x5, 0x11a, 0x8e, 0x2, 0x4df, 0x4e0, 0x7, 0x3, 0x2, 
    0x2, 0x4e0, 0x4e4, 0x5, 0x14e, 0xa8, 0x2, 0x4e1, 0x4e3, 0x5, 0x14e, 
    0xa8, 0x2, 0x4e2, 0x4e1, 0x3, 0x2, 0x2, 0x2, 0x4e3, 0x4e6, 0x3, 0x2, 
    0x2, 0x2, 0x4e4, 0x4e2, 0x3, 0x2, 0x2, 0x2, 0x4e4, 0x4e5, 0x3, 0x2, 
    0x2, 0x2, 0x4e5, 0x4e7, 0x3, 0x2, 0x2, 0x2, 0x4e6, 0x4e4, 0x3, 0x2, 
    0x2, 0x2, 0x4e7, 0x4e8, 0x7, 0x42, 0x2, 0x2, 0x4e8, 0x4e9, 0x7, 0x3, 
    0x2, 0x2, 0x4e9, 0x11d, 0x3, 0x2, 0x2, 0x2, 0x4ea, 0x4eb, 0x5, 0xea, 
    0x76, 0x2, 0x4eb, 0x11f, 0x3, 0x2, 0x2, 0x2, 0x4ec, 0x4ef, 0x5, 0x122, 
    0x92, 0x2, 0x4ed, 0x4ee, 0x7, 0x28, 0x2, 0x2, 0x4ee, 0x4f0, 0x5, 0x118, 
    0x8d, 0x2, 0x4ef, 0x4ed, 0x3, 0x2, 0x2, 0x2, 0x4ef, 0x4f0, 0x3, 0x2, 
    0x2, 0x2, 0x4f0, 0x121, 0x3, 0x2, 0x2, 0x2, 0x4f1, 0x4f7, 0x5, 0x4, 
    0x3, 0x2, 0x4f2, 0x4f7, 0x5, 0x6, 0x4, 0x2, 0x4f3, 0x4f7, 0x5, 0xa, 
    0x6, 0x2, 0x4f4, 0x4f7, 0x5, 0xe, 0x8, 0x2, 0x4f5, 0x4f7, 0x5, 0x1a, 
    0xe, 0x2, 0x4f6, 0x4f1, 0x3, 0x2, 0x2, 0x2, 0x4f6, 0x4f2, 0x3, 0x2, 
    0x2, 0x2, 0x4f6, 0x4f3, 0x3, 0x2, 0x2, 0x2, 0x4f6, 0x4f4, 0x3, 0x2, 
    0x2, 0x2, 0x4f6, 0x4f5, 0x3, 0x2, 0x2, 0x2, 0x4f7, 0x123, 0x3, 0x2, 
    0x2, 0x2, 0x4f8, 0x4fd, 0x7, 0x78, 0x2, 0x2, 0x4f9, 0x4fa, 0x7, 0x4, 
    0x2, 0x2, 0x4fa, 0x4fb, 0x5, 0x88, 0x45, 0x2, 0x4fb, 0x4fc, 0x7, 0x6, 
    0x2, 0x2, 0x4fc, 0x4fe, 0x3, 0x2, 0x2, 0x2, 0x4fd, 0x4f9, 0x3, 0x2, 
    0x2, 0x2, 0x4fd, 0x4fe, 0x3, 0x2, 0x2, 0x2, 0x4fe, 0x4ff, 0x3, 0x2, 
    0x2, 0x2, 0x4ff, 0x500, 0x7, 0x3, 0x2, 0x2, 0x500, 0x125, 0x3, 0x2, 
    0x2, 0x2, 0x501, 0x502, 0x5, 0x128, 0x95, 0x2, 0x502, 0x506, 0x5, 0x30, 
    0x19, 0x2, 0x503, 0x505, 0x5, 0x14e, 0xa8, 0x2, 0x504, 0x503, 0x3, 0x2, 
    0x2, 0x2, 0x505, 0x508, 0x3, 0x2, 0x2, 0x2, 0x506, 0x504, 0x3, 0x2, 
    0x2, 0x2, 0x506, 0x507, 0x3, 0x2, 0x2, 0x2, 0x507, 0x509, 0x3, 0x2, 
    0x2, 0x2, 0x508, 0x506, 0x3, 0x2, 0x2, 0x2, 0x509, 0x50a, 0x5, 0x188, 
    0xc5, 0x2, 0x50a, 0x50b, 0x7, 0x43, 0x2, 0x2, 0x50b, 0x50c, 0x7, 0x3, 
    0x2, 0x2, 0x50c, 0x127, 0x3, 0x2, 0x2, 0x2, 0x50d, 0x50e, 0x7, 0x7a, 
    0x2, 0x2, 0x50e, 0x50f, 0x5, 0x12a, 0x96, 0x2, 0x50f, 0x510, 0x7, 0x4f, 
    0x2, 0x2, 0x510, 0x511, 0x7, 0x4, 0x2, 0x2, 0x511, 0x516, 0x5, 0x6, 
    0x4, 0x2, 0x512, 0x513, 0x7, 0x5, 0x2, 0x2, 0x513, 0x515, 0x5, 0x6, 
    0x4, 0x2, 0x514, 0x512, 0x3, 0x2, 0x2, 0x2, 0x515, 0x518, 0x3, 0x2, 
    0x2, 0x2, 0x516, 0x514, 0x3, 0x2, 0x2, 0x2, 0x516, 0x517, 0x3, 0x2, 
    0x2, 0x2, 0x517, 0x519, 0x3, 0x2, 0x2, 0x2, 0x518, 0x516, 0x3, 0x2, 
    0x2, 0x2, 0x519, 0x51a, 0x7, 0x6, 0x2, 0x2, 0x51a, 0x51b, 0x7, 0x3, 
    0x2, 0x2, 0x51b, 0x129, 0x3, 0x2, 0x2, 0x2, 0x51c, 0x51d, 0x7, 0x9f, 
    0x2, 0x2, 0x51d, 0x12b, 0x3, 0x2, 0x2, 0x2, 0x51e, 0x51f, 0x7, 0x9f, 
    0x2, 0x2, 0x51f, 0x12d, 0x3, 0x2, 0x2, 0x2, 0x520, 0x522, 0x5, 0xc0, 
    0x61, 0x2, 0x521, 0x520, 0x3, 0x2, 0x2, 0x2, 0x522, 0x525, 0x3, 0x2, 
    0x2, 0x2, 0x523, 0x521, 0x3, 0x2, 0x2, 0x2, 0x523, 0x524, 0x3, 0x2, 
    0x2, 0x2, 0x524, 0x527, 0x3, 0x2, 0x2, 0x2, 0x525, 0x523, 0x3, 0x2, 
    0x2, 0x2, 0x526, 0x528, 0x5, 0x5c, 0x2f, 0x2, 0x527, 0x526, 0x3, 0x2, 
    0x2, 0x2, 0x527, 0x528, 0x3, 0x2, 0x2, 0x2, 0x528, 0x52c, 0x3, 0x2, 
    0x2, 0x2, 0x529, 0x52b, 0x5, 0x130, 0x99, 0x2, 0x52a, 0x529, 0x3, 0x2, 
    0x2, 0x2, 0x52b, 0x52e, 0x3, 0x2, 0x2, 0x2, 0x52c, 0x52a, 0x3, 0x2, 
    0x2, 0x2, 0x52c, 0x52d, 0x3, 0x2, 0x2, 0x2, 0x52d, 0x12f, 0x3, 0x2, 
    0x2, 0x2, 0x52e, 0x52c, 0x3, 0x2, 0x2, 0x2, 0x52f, 0x532, 0x5, 0x64, 
    0x33, 0x2, 0x530, 0x532, 0x5, 0x126, 0x94, 0x2, 0x531, 0x52f, 0x3, 0x2, 
    0x2, 0x2, 0x531, 0x530, 0x3, 0x2, 0x2, 0x2, 0x532, 0x131, 0x3, 0x2, 
    0x2, 0x2, 0x533, 0x534, 0x7, 0x7b, 0x2, 0x2, 0x534, 0x536, 0x5, 0x134, 
    0x9b, 0x2, 0x535, 0x537, 0x5, 0x136, 0x9c, 0x2, 0x536, 0x535, 0x3, 0x2, 
    0x2, 0x2, 0x536, 0x537, 0x3, 0x2, 0x2, 0x2, 0x537, 0x538, 0x3, 0x2, 
    0x2, 0x2, 0x538, 0x539, 0x7, 0x3, 0x2, 0x2, 0x539, 0x53a, 0x5, 0x12e, 
    0x98, 0x2, 0x53a, 0x53b, 0x7, 0x44, 0x2, 0x2, 0x53b, 0x53c, 0x7, 0x3, 
    0x2, 0x2, 0x53c, 0x133, 0x3, 0x2, 0x2, 0x2, 0x53d, 0x53e, 0x7, 0x9f, 
    0x2, 0x2, 0x53e, 0x135, 0x3, 0x2, 0x2, 0x2, 0x53f, 0x540, 0x5, 0x150, 
    0xa9, 0x2, 0x540, 0x137, 0x3, 0x2, 0x2, 0x2, 0x541, 0x542, 0x5, 0x88, 
    0x45, 0x2, 0x542, 0x139, 0x3, 0x2, 0x2, 0x2, 0x543, 0x544, 0x7, 0x2c, 
    0x2, 0x2, 0x544, 0x547, 0x5, 0x1a, 0xe, 0x2, 0x545, 0x546, 0x7, 0x97, 
    0x2, 0x2, 0x546, 0x548, 0x5, 0x13c, 0x9f, 0x2, 0x547, 0x545, 0x3, 0x2, 
    0x2, 0x2, 0x547, 0x548, 0x3, 0x2, 0x2, 0x2, 0x548, 0x13b, 0x3, 0x2, 
    0x2, 0x2, 0x549, 0x54a, 0x7, 0x4, 0x2, 0x2, 0x54a, 0x54f, 0x5, 0xe2, 
    0x72, 0x2, 0x54b, 0x54c, 0x7, 0x5, 0x2, 0x2, 0x54c, 0x54e, 0x5, 0xe2, 
    0x72, 0x2, 0x54d, 0x54b, 0x3, 0x2, 0x2, 0x2, 0x54e, 0x551, 0x3, 0x2, 
    0x2, 0x2, 0x54f, 0x54d, 0x3, 0x2, 0x2, 0x2, 0x54f, 0x550, 0x3, 0x2, 
    0x2, 0x2, 0x550, 0x552, 0x3, 0x2, 0x2, 0x2, 0x551, 0x54f, 0x3, 0x2, 
    0x2, 0x2, 0x552, 0x553, 0x7, 0x6, 0x2, 0x2, 0x553, 0x13d, 0x3, 0x2, 
    0x2, 0x2, 0x554, 0x556, 0x7, 0x4c, 0x2, 0x2, 0x555, 0x557, 0x7, 0x54, 
    0x2, 0x2, 0x556, 0x555, 0x3, 0x2, 0x2, 0x2, 0x556, 0x557, 0x3, 0x2, 
    0x2, 0x2, 0x557, 0x559, 0x3, 0x2, 0x2, 0x2, 0x558, 0x554, 0x3, 0x2, 
    0x2, 0x2, 0x558, 0x559, 0x3, 0x2, 0x2, 0x2, 0x559, 0x55a, 0x3, 0x2, 
    0x2, 0x2, 0x55a, 0x55d, 0x7, 0x7c, 0x2, 0x2, 0x55b, 0x55e, 0x5, 0x13c, 
    0x9f, 0x2, 0x55c, 0x55e, 0x5, 0x13a, 0x9e, 0x2, 0x55d, 0x55b, 0x3, 0x2, 
    0x2, 0x2, 0x55d, 0x55c, 0x3, 0x2, 0x2, 0x2, 0x55d, 0x55e, 0x3, 0x2, 
    0x2, 0x2, 0x55e, 0x13f, 0x3, 0x2, 0x2, 0x2, 0x55f, 0x561, 0x7, 0x7e, 
    0x2, 0x2, 0x560, 0x562, 0x5, 0x48, 0x25, 0x2, 0x561, 0x560, 0x3, 0x2, 
    0x2, 0x2, 0x561, 0x562, 0x3, 0x2, 0x2, 0x2, 0x562, 0x563, 0x3, 0x2, 
    0x2, 0x2, 0x563, 0x564, 0x7, 0x6b, 0x2, 0x2, 0x564, 0x565, 0x5, 0xbc, 
    0x5f, 0x2, 0x565, 0x141, 0x3, 0x2, 0x2, 0x2, 0x566, 0x56c, 0x5, 0x16e, 
    0xb8, 0x2, 0x567, 0x568, 0x5, 0x26, 0x14, 0x2, 0x568, 0x569, 0x5, 0x16e, 
    0xb8, 0x2, 0x569, 0x56b, 0x3, 0x2, 0x2, 0x2, 0x56a, 0x567, 0x3, 0x2, 
    0x2, 0x2, 0x56b, 0x56e, 0x3, 0x2, 0x2, 0x2, 0x56c, 0x56a, 0x3, 0x2, 
    0x2, 0x2, 0x56c, 0x56d, 0x3, 0x2, 0x2, 0x2, 0x56d, 0x143, 0x3, 0x2, 
    0x2, 0x2, 0x56e, 0x56c, 0x3, 0x2, 0x2, 0x2, 0x56f, 0x577, 0x5, 0x28, 
    0x15, 0x2, 0x570, 0x577, 0x5, 0x70, 0x39, 0x2, 0x571, 0x577, 0x5, 0x80, 
    0x41, 0x2, 0x572, 0x577, 0x5, 0xc2, 0x62, 0x2, 0x573, 0x577, 0x5, 0x10a, 
    0x86, 0x2, 0x574, 0x577, 0x5, 0x146, 0xa4, 0x2, 0x575, 0x577, 0x5, 0x148, 
    0xa5, 0x2, 0x576, 0x56f, 0x3, 0x2, 0x2, 0x2, 0x576, 0x570, 0x3, 0x2, 
    0x2, 0x2, 0x576, 0x571, 0x3, 0x2, 0x2, 0x2, 0x576, 0x572, 0x3, 0x2, 
    0x2, 0x2, 0x576, 0x573, 0x3, 0x2, 0x2, 0x2, 0x576, 0x574, 0x3, 0x2, 
    0x2, 0x2, 0x576, 0x575, 0x3, 0x2, 0x2, 0x2, 0x577, 0x145, 0x3, 0x2, 
    0x2, 0x2, 0x578, 0x579, 0x7, 0x4, 0x2, 0x2, 0x579, 0x57a, 0x5, 0x88, 
    0x45, 0x2, 0x57a, 0x57b, 0x7, 0x6, 0x2, 0x2, 0x57b, 0x57e, 0x3, 0x2, 
    0x2, 0x2, 0x57c, 0x57e, 0x5, 0xf8, 0x7d, 0x2, 0x57d, 0x578, 0x3, 0x2, 
    0x2, 0x2, 0x57d, 0x57c, 0x3, 0x2, 0x2, 0x2, 0x57e, 0x147, 0x3, 0x2, 
    0x2, 0x2, 0x57f, 0x580, 0x5, 0x17a, 0xbe, 0x2, 0x580, 0x581, 0x5, 0x146, 
    0xa4, 0x2, 0x581, 0x149, 0x3, 0x2, 0x2, 0x2, 0x582, 0x58a, 0x5, 0x40, 
    0x21, 0x2, 0x583, 0x58a, 0x5, 0x42, 0x22, 0x2, 0x584, 0x58a, 0x5, 0xbe, 
    0x60, 0x2, 0x585, 0x58a, 0x5, 0xde, 0x70, 0x2, 0x586, 0x58a, 0x5, 0xe8, 
    0x75, 0x2, 0x587, 0x58a, 0x5, 0x10c, 0x87, 0x2, 0x588, 0x58a, 0x5, 0x152, 
    0xaa, 0x2, 0x589, 0x582, 0x3, 0x2, 0x2, 0x2, 0x589, 0x583, 0x3, 0x2, 
    0x2, 0x2, 0x589, 0x584, 0x3, 0x2, 0x2, 0x2, 0x589, 0x585, 0x3, 0x2, 
    0x2, 0x2, 0x589, 0x586, 0x3, 0x2, 0x2, 0x2, 0x589, 0x587, 0x3, 0x2, 
    0x2, 0x2, 0x589, 0x588, 0x3, 0x2, 0x2, 0x2, 0x58a, 0x14b, 0x3, 0x2, 
    0x2, 0x2, 0x58b, 0x58c, 0x7, 0x81, 0x2, 0x2, 0x58c, 0x58d, 0x7, 0x3, 
    0x2, 0x2, 0x58d, 0x14d, 0x3, 0x2, 0x2, 0x2, 0x58e, 0x59a, 0x5, 0x32, 
    0x1a, 0x2, 0x58f, 0x59a, 0x5, 0x36, 0x1c, 0x2, 0x590, 0x59a, 0x5, 0x54, 
    0x2b, 0x2, 0x591, 0x59a, 0x5, 0x56, 0x2c, 0x2, 0x592, 0x59a, 0x5, 0x84, 
    0x43, 0x2, 0x593, 0x59a, 0x5, 0xaa, 0x56, 0x2, 0x594, 0x59a, 0x5, 0xe6, 
    0x74, 0x2, 0x595, 0x59a, 0x5, 0xfa, 0x7e, 0x2, 0x596, 0x59a, 0x5, 0x11c, 
    0x8f, 0x2, 0x597, 0x59a, 0x5, 0x124, 0x93, 0x2, 0x598, 0x59a, 0x5, 0x14c, 
    0xa7, 0x2, 0x599, 0x58e, 0x3, 0x2, 0x2, 0x2, 0x599, 0x58f, 0x3, 0x2, 
    0x2, 0x2, 0x599, 0x590, 0x3, 0x2, 0x2, 0x2, 0x599, 0x591, 0x3, 0x2, 
    0x2, 0x2, 0x599, 0x592, 0x3, 0x2, 0x2, 0x2, 0x599, 0x593, 0x3, 0x2, 
    0x2, 0x2, 0x599, 0x594, 0x3, 0x2, 0x2, 0x2, 0x599, 0x595, 0x3, 0x2, 
    0x2, 0x2, 0x599, 0x596, 0x3, 0x2, 0x2, 0x2, 0x599, 0x597, 0x3, 0x2, 
    0x2, 0x2, 0x599, 0x598, 0x3, 0x2, 0x2, 0x2, 0x59a, 0x14f, 0x3, 0x2, 
    0x2, 0x2, 0x59b, 0x59c, 0x9, 0xb, 0x2, 0x2, 0x59c, 0x151, 0x3, 0x2, 
    0x2, 0x2, 0x59d, 0x59f, 0x7, 0x83, 0x2, 0x2, 0x59e, 0x5a0, 0x5, 0x18e, 
    0xc8, 0x2, 0x59f, 0x59e, 0x3, 0x2, 0x2, 0x2, 0x59f, 0x5a0, 0x3, 0x2, 
    0x2, 0x2, 0x5a0, 0x153, 0x3, 0x2, 0x2, 0x2, 0x5a1, 0x5a3, 0x5, 0x162, 
    0xb2, 0x2, 0x5a2, 0x5a1, 0x3, 0x2, 0x2, 0x2, 0x5a2, 0x5a3, 0x3, 0x2, 
    0x2, 0x2, 0x5a3, 0x5a5, 0x3, 0x2, 0x2, 0x2, 0x5a4, 0x5a6, 0x5, 0x160, 
    0xb1, 0x2, 0x5a5, 0x5a4, 0x3, 0x2, 0x2, 0x2, 0x5a5, 0x5a6, 0x3, 0x2, 
    0x2, 0x2, 0x5a6, 0x155, 0x3, 0x2, 0x2, 0x2, 0x5a7, 0x5a8, 0x7, 0x6b, 
    0x2, 0x2, 0x5a8, 0x5a9, 0x7, 0x4, 0x2, 0x2, 0x5a9, 0x5aa, 0x5, 0x164, 
    0xb3, 0x2, 0x5aa, 0x5ab, 0x7, 0x6, 0x2, 0x2, 0x5ab, 0x157, 0x3, 0x2, 
    0x2, 0x2, 0x5ac, 0x5ae, 0x5, 0x20, 0x11, 0x2, 0x5ad, 0x5ac, 0x3, 0x2, 
    0x2, 0x2, 0x5ad, 0x5ae, 0x3, 0x2, 0x2, 0x2, 0x5ae, 0x5b0, 0x3, 0x2, 
    0x2, 0x2, 0x5af, 0x5b1, 0x5, 0x170, 0xb9, 0x2, 0x5b0, 0x5af, 0x3, 0x2, 
    0x2, 0x2, 0x5b0, 0x5b1, 0x3, 0x2, 0x2, 0x2, 0x5b1, 0x5b5, 0x3, 0x2, 
    0x2, 0x2, 0x5b2, 0x5b3, 0x5, 0x164, 0xb3, 0x2, 0x5b3, 0x5b4, 0x7, 0x3, 
    0x2, 0x2, 0x5b4, 0x5b6, 0x3, 0x2, 0x2, 0x2, 0x5b5, 0x5b2, 0x3, 0x2, 
    0x2, 0x2, 0x5b5, 0x5b6, 0x3, 0x2, 0x2, 0x2, 0x5b6, 0x159, 0x3, 0x2, 
    0x2, 0x2, 0x5b7, 0x5b8, 0x5, 0x15c, 0xaf, 0x2, 0x5b8, 0x5b9, 0x5, 0x158, 
    0xad, 0x2, 0x5b9, 0x5ba, 0x7, 0x45, 0x2, 0x2, 0x5ba, 0x5bb, 0x7, 0x3, 
    0x2, 0x2, 0x5bb, 0x15b, 0x3, 0x2, 0x2, 0x2, 0x5bc, 0x5bd, 0x7, 0x85, 
    0x2, 0x2, 0x5bd, 0x5be, 0x5, 0x15e, 0xb0, 0x2, 0x5be, 0x5bf, 0x7, 0x4f, 
    0x2, 0x2, 0x5bf, 0x5c0, 0x5, 0x6, 0x4, 0x2, 0x5c0, 0x5c1, 0x7, 0x3, 
    0x2, 0x2, 0x5c1, 0x15d, 0x3, 0x2, 0x2, 0x2, 0x5c2, 0x5c3, 0x7, 0x9f, 
    0x2, 0x2, 0x5c3, 0x15f, 0x3, 0x2, 0x2, 0x2, 0x5c4, 0x5c5, 0x7, 0x84, 
    0x2, 0x2, 0x5c5, 0x5c6, 0x7, 0x6b, 0x2, 0x2, 0x5c6, 0x5c7, 0x7, 0x4, 
    0x2, 0x2, 0x5c7, 0x5cc, 0x5, 0x6, 0x4, 0x2, 0x5c8, 0x5c9, 0x7, 0x5, 
    0x2, 0x2, 0x5c9, 0x5cb, 0x5, 0x6, 0x4, 0x2, 0x5ca, 0x5c8, 0x3, 0x2, 
    0x2, 0x2, 0x5cb, 0x5ce, 0x3, 0x2, 0x2, 0x2, 0x5cc, 0x5ca, 0x3, 0x2, 
    0x2, 0x2, 0x5cc, 0x5cd, 0x3, 0x2, 0x2, 0x2, 0x5cd, 0x5cf, 0x3, 0x2, 
    0x2, 0x2, 0x5ce, 0x5cc, 0x3, 0x2, 0x2, 0x2, 0x5cf, 0x5d0, 0x7, 0x6, 
    0x2, 0x2, 0x5d0, 0x161, 0x3, 0x2, 0x2, 0x2, 0x5d1, 0x5d5, 0x5, 0x1e, 
    0x10, 0x2, 0x5d2, 0x5d5, 0x5, 0x22, 0x12, 0x2, 0x5d3, 0x5d5, 0x5, 0x168, 
    0xb5, 0x2, 0x5d4, 0x5d1, 0x3, 0x2, 0x2, 0x2, 0x5d4, 0x5d2, 0x3, 0x2, 
    0x2, 0x2, 0x5d4, 0x5d3, 0x3, 0x2, 0x2, 0x2, 0x5d5, 0x163, 0x3, 0x2, 
    0x2, 0x2, 0x5d6, 0x5db, 0x5, 0x166, 0xb4, 0x2, 0x5d7, 0x5d8, 0x7, 0x26, 
    0x2, 0x2, 0x5d8, 0x5da, 0x5, 0x166, 0xb4, 0x2, 0x5d9, 0x5d7, 0x3, 0x2, 
    0x2, 0x2, 0x5da, 0x5dd, 0x3, 0x2, 0x2, 0x2, 0x5db, 0x5d9, 0x3, 0x2, 
    0x2, 0x2, 0x5db, 0x5dc, 0x3, 0x2, 0x2, 0x2, 0x5dc, 0x165, 0x3, 0x2, 
    0x2, 0x2, 0x5dd, 0x5db, 0x3, 0x2, 0x2, 0x2, 0x5de, 0x5e3, 0x5, 0x16a, 
    0xb6, 0x2, 0x5df, 0x5e0, 0x7, 0x25, 0x2, 0x2, 0x5e0, 0x5e2, 0x5, 0x16a, 
    0xb6, 0x2, 0x5e1, 0x5df, 0x3, 0x2, 0x2, 0x2, 0x5e2, 0x5e5, 0x3, 0x2, 
    0x2, 0x2, 0x5e3, 0x5e1, 0x3, 0x2, 0x2, 0x2, 0x5e3, 0x5e4, 0x3, 0x2, 
    0x2, 0x2, 0x5e4, 0x167, 0x3, 0x2, 0x2, 0x2, 0x5e5, 0x5e3, 0x3, 0x2, 
    0x2, 0x2, 0x5e6, 0x5e7, 0x7, 0x86, 0x2, 0x2, 0x5e7, 0x5e8, 0x5, 0x156, 
    0xac, 0x2, 0x5e8, 0x169, 0x3, 0x2, 0x2, 0x2, 0x5e9, 0x5f0, 0x5, 0x6, 
    0x4, 0x2, 0x5ea, 0x5f0, 0x5, 0xec, 0x77, 0x2, 0x5eb, 0x5ec, 0x7, 0x4, 
    0x2, 0x2, 0x5ec, 0x5ed, 0x5, 0x164, 0xb3, 0x2, 0x5ed, 0x5ee, 0x7, 0x6, 
    0x2, 0x2, 0x5ee, 0x5f0, 0x3, 0x2, 0x2, 0x2, 0x5ef, 0x5e9, 0x3, 0x2, 
    0x2, 0x2, 0x5ef, 0x5ea, 0x3, 0x2, 0x2, 0x2, 0x5ef, 0x5eb, 0x3, 0x2, 
    0x2, 0x2, 0x5f0, 0x16b, 0x3, 0x2, 0x2, 0x2, 0x5f1, 0x5f3, 0x5, 0x132, 
    0x9a, 0x2, 0x5f2, 0x5f1, 0x3, 0x2, 0x2, 0x2, 0x5f3, 0x5f4, 0x3, 0x2, 
    0x2, 0x2, 0x5f4, 0x5f2, 0x3, 0x2, 0x2, 0x2, 0x5f4, 0x5f5, 0x3, 0x2, 
    0x2, 0x2, 0x5f5, 0x5f6, 0x3, 0x2, 0x2, 0x2, 0x5f6, 0x5f7, 0x7, 0x2, 
    0x2, 0x3, 0x5f7, 0x16d, 0x3, 0x2, 0x2, 0x2, 0x5f8, 0x5fe, 0x5, 0x8a, 
    0x46, 0x2, 0x5f9, 0x5fa, 0x5, 0xe0, 0x71, 0x2, 0x5fa, 0x5fb, 0x5, 0x8a, 
    0x46, 0x2, 0x5fb, 0x5fd, 0x3, 0x2, 0x2, 0x2, 0x5fc, 0x5f9, 0x3, 0x2, 
    0x2, 0x2, 0x5fd, 0x600, 0x3, 0x2, 0x2, 0x2, 0x5fe, 0x5fc, 0x3, 0x2, 
    0x2, 0x2, 0x5fe, 0x5ff, 0x3, 0x2, 0x2, 0x2, 0x5ff, 0x16f, 0x3, 0x2, 
    0x2, 0x2, 0x600, 0x5fe, 0x3, 0x2, 0x2, 0x2, 0x601, 0x602, 0x7, 0x8d, 
    0x2, 0x2, 0x602, 0x603, 0x7, 0x4, 0x2, 0x2, 0x603, 0x608, 0x5, 0x6, 
    0x4, 0x2, 0x604, 0x605, 0x7, 0x5, 0x2, 0x2, 0x605, 0x607, 0x5, 0x6, 
    0x4, 0x2, 0x606, 0x604, 0x3, 0x2, 0x2, 0x2, 0x607, 0x60a, 0x3, 0x2, 
    0x2, 0x2, 0x608, 0x606, 0x3, 0x2, 0x2, 0x2, 0x608, 0x609, 0x3, 0x2, 
    0x2, 0x2, 0x609, 0x60b, 0x3, 0x2, 0x2, 0x2, 0x60a, 0x608, 0x3, 0x2, 
    0x2, 0x2, 0x60b, 0x60c, 0x7, 0x6, 0x2, 0x2, 0x60c, 0x60d, 0x7, 0x3, 
    0x2, 0x2, 0x60d, 0x171, 0x3, 0x2, 0x2, 0x2, 0x60e, 0x60f, 0x7, 0x8b, 
    0x2, 0x2, 0x60f, 0x610, 0x5, 0x174, 0xbb, 0x2, 0x610, 0x611, 0x7, 0x1d, 
    0x2, 0x2, 0x611, 0x612, 0x5, 0x17c, 0xbf, 0x2, 0x612, 0x614, 0x7, 0x3, 
    0x2, 0x2, 0x613, 0x615, 0x5, 0x188, 0xc5, 0x2, 0x614, 0x613, 0x3, 0x2, 
    0x2, 0x2, 0x614, 0x615, 0x3, 0x2, 0x2, 0x2, 0x615, 0x616, 0x3, 0x2, 
    0x2, 0x2, 0x616, 0x617, 0x7, 0x46, 0x2, 0x2, 0x617, 0x618, 0x7, 0x3, 
    0x2, 0x2, 0x618, 0x173, 0x3, 0x2, 0x2, 0x2, 0x619, 0x61a, 0x7, 0x9f, 
    0x2, 0x2, 0x61a, 0x175, 0x3, 0x2, 0x2, 0x2, 0x61b, 0x61e, 0x5, 0x178, 
    0xbd, 0x2, 0x61c, 0x61e, 0x5, 0x18, 0xd, 0x2, 0x61d, 0x61b, 0x3, 0x2, 
    0x2, 0x2, 0x61d, 0x61c, 0x3, 0x2, 0x2, 0x2, 0x61e, 0x177, 0x3, 0x2, 
    0x2, 0x2, 0x61f, 0x620, 0x7, 0x9f, 0x2, 0x2, 0x620, 0x179, 0x3, 0x2, 
    0x2, 0x2, 0x621, 0x622, 0x9, 0xc, 0x2, 0x2, 0x622, 0x17b, 0x3, 0x2, 
    0x2, 0x2, 0x623, 0x626, 0x5, 0x58, 0x2d, 0x2, 0x624, 0x626, 0x5, 0x62, 
    0x32, 0x2, 0x625, 0x623, 0x3, 0x2, 0x2, 0x2, 0x625, 0x624, 0x3, 0x2, 
    0x2, 0x2, 0x626, 0x17d, 0x3, 0x2, 0x2, 0x2, 0x627, 0x628, 0x7, 0x8e, 
    0x2, 0x2, 0x628, 0x629, 0x5, 0x180, 0xc1, 0x2, 0x629, 0x62f, 0x7, 0x3, 
    0x2, 0x2, 0x62a, 0x62b, 0x5, 0x180, 0xc1, 0x2, 0x62b, 0x62c, 0x7, 0x3, 
    0x2, 0x2, 0x62c, 0x62e, 0x3, 0x2, 0x2, 0x2, 0x62d, 0x62a, 0x3, 0x2, 
    0x2, 0x2, 0x62e, 0x631, 0x3, 0x2, 0x2, 0x2, 0x62f, 0x62d, 0x3, 0x2, 
    0x2, 0x2, 0x62f, 0x630, 0x3, 0x2, 0x2, 0x2, 0x630, 0x17f, 0x3, 0x2, 
    0x2, 0x2, 0x631, 0x62f, 0x3, 0x2, 0x2, 0x2, 0x632, 0x633, 0x5, 0x12c, 
    0x97, 0x2, 0x633, 0x634, 0x7, 0xb, 0x2, 0x2, 0x634, 0x636, 0x3, 0x2, 
    0x2, 0x2, 0x635, 0x632, 0x3, 0x2, 0x2, 0x2, 0x635, 0x636, 0x3, 0x2, 
    0x2, 0x2, 0x636, 0x637, 0x3, 0x2, 0x2, 0x2, 0x637, 0x63c, 0x5, 0x110, 
    0x89, 0x2, 0x638, 0x639, 0x7, 0x5, 0x2, 0x2, 0x639, 0x63b, 0x5, 0x110, 
    0x89, 0x2, 0x63a, 0x638, 0x3, 0x2, 0x2, 0x2, 0x63b, 0x63e, 0x3, 0x2, 
    0x2, 0x2, 0x63c, 0x63a, 0x3, 0x2, 0x2, 0x2, 0x63c, 0x63d, 0x3, 0x2, 
    0x2, 0x2, 0x63d, 0x181, 0x3, 0x2, 0x2, 0x2, 0x63e, 0x63c, 0x3, 0x2, 
    0x2, 0x2, 0x63f, 0x640, 0x7, 0x90, 0x2, 0x2, 0x640, 0x641, 0x5, 0xda, 
    0x6e, 0x2, 0x641, 0x183, 0x3, 0x2, 0x2, 0x2, 0x642, 0x643, 0x7, 0x91, 
    0x2, 0x2, 0x643, 0x644, 0x7, 0x51, 0x2, 0x2, 0x644, 0x650, 0x5, 0x14, 
    0xb, 0x2, 0x645, 0x646, 0x7, 0x4, 0x2, 0x2, 0x646, 0x64b, 0x5, 0xe4, 
    0x73, 0x2, 0x647, 0x648, 0x7, 0x5, 0x2, 0x2, 0x648, 0x64a, 0x5, 0xe4, 
    0x73, 0x2, 0x649, 0x647, 0x3, 0x2, 0x2, 0x2, 0x64a, 0x64d, 0x3, 0x2, 
    0x2, 0x2, 0x64b, 0x649, 0x3, 0x2, 0x2, 0x2, 0x64b, 0x64c, 0x3, 0x2, 
    0x2, 0x2, 0x64c, 0x64e, 0x3, 0x2, 0x2, 0x2, 0x64d, 0x64b, 0x3, 0x2, 
    0x2, 0x2, 0x64e, 0x64f, 0x7, 0x6, 0x2, 0x2, 0x64f, 0x651, 0x3, 0x2, 
    0x2, 0x2, 0x650, 0x645, 0x3, 0x2, 0x2, 0x2, 0x650, 0x651, 0x3, 0x2, 
    0x2, 0x2, 0x651, 0x652, 0x3, 0x2, 0x2, 0x2, 0x652, 0x653, 0x7, 0x3, 
    0x2, 0x2, 0x653, 0x185, 0x3, 0x2, 0x2, 0x2, 0x654, 0x655, 0x7, 0x9f, 
    0x2, 0x2, 0x655, 0x187, 0x3, 0x2, 0x2, 0x2, 0x656, 0x657, 0x7, 0x98, 
    0x2, 0x2, 0x657, 0x658, 0x5, 0x6a, 0x36, 0x2, 0x658, 0x65e, 0x7, 0x3, 
    0x2, 0x2, 0x659, 0x65a, 0x5, 0x6a, 0x36, 0x2, 0x65a, 0x65b, 0x7, 0x3, 
    0x2, 0x2, 0x65b, 0x65d, 0x3, 0x2, 0x2, 0x2, 0x65c, 0x659, 0x3, 0x2, 
    0x2, 0x2, 0x65d, 0x660, 0x3, 0x2, 0x2, 0x2, 0x65e, 0x65c, 0x3, 0x2, 
    0x2, 0x2, 0x65e, 0x65f, 0x3, 0x2, 0x2, 0x2, 0x65f, 0x189, 0x3, 0x2, 
    0x2, 0x2, 0x660, 0x65e, 0x3, 0x2, 0x2, 0x2, 0x661, 0x662, 0x7, 0x99, 
    0x2, 0x2, 0x662, 0x663, 0x5, 0xda, 0x6e, 0x2, 0x663, 0x18b, 0x3, 0x2, 
    0x2, 0x2, 0x664, 0x665, 0x5, 0xea, 0x76, 0x2, 0x665, 0x18d, 0x3, 0x2, 
    0x2, 0x2, 0x666, 0x667, 0x7, 0x4, 0x2, 0x2, 0x667, 0x668, 0x5, 0x18c, 
    0xc7, 0x2, 0x668, 0x66a, 0x7, 0x6, 0x2, 0x2, 0x669, 0x66b, 0x7, 0x4e, 
    0x2, 0x2, 0x66a, 0x669, 0x3, 0x2, 0x2, 0x2, 0x66a, 0x66b, 0x3, 0x2, 
    0x2, 0x2, 0x66b, 0x18f, 0x3, 0x2, 0x2, 0x2, 0x99, 0x1b5, 0x1bd, 0x1ca, 
    0x1cd, 0x1d6, 0x1df, 0x1e4, 0x1e8, 0x1eb, 0x1f4, 0x1fc, 0x206, 0x209, 
    0x211, 0x21a, 0x223, 0x22a, 0x243, 0x251, 0x257, 0x261, 0x26a, 0x278, 
    0x280, 0x286, 0x28d, 0x29b, 0x2a1, 0x2a8, 0x2ad, 0x2b1, 0x2b4, 0x2b7, 
    0x2ba, 0x2c3, 0x2c6, 0x2da, 0x2e4, 0x2ee, 0x2f3, 0x2f9, 0x303, 0x308, 
    0x311, 0x316, 0x31d, 0x325, 0x328, 0x330, 0x33e, 0x343, 0x34f, 0x355, 
    0x359, 0x35d, 0x360, 0x366, 0x36d, 0x371, 0x377, 0x37b, 0x383, 0x388, 
    0x393, 0x39c, 0x3a3, 0x3af, 0x3bb, 0x3c1, 0x3c7, 0x3e0, 0x3e7, 0x3ea, 
    0x3f3, 0x3f8, 0x3fc, 0x405, 0x40c, 0x417, 0x41e, 0x42c, 0x432, 0x434, 
    0x443, 0x44f, 0x45a, 0x45d, 0x461, 0x464, 0x46d, 0x47b, 0x480, 0x485, 
    0x490, 0x499, 0x4a9, 0x4ae, 0x4b2, 0x4bd, 0x4c2, 0x4cb, 0x4d2, 0x4d5, 
    0x4d8, 0x4db, 0x4e4, 0x4ef, 0x4f6, 0x4fd, 0x506, 0x516, 0x523, 0x527, 
    0x52c, 0x531, 0x536, 0x547, 0x54f, 0x556, 0x558, 0x55d, 0x561, 0x56c, 
    0x576, 0x57d, 0x589, 0x599, 0x59f, 0x5a2, 0x5a5, 0x5ad, 0x5b0, 0x5b5, 
    0x5cc, 0x5d4, 0x5db, 0x5e3, 0x5ef, 0x5f4, 0x5fe, 0x608, 0x614, 0x61d, 
    0x625, 0x62f, 0x635, 0x63c, 0x64b, 0x650, 0x65e, 0x66a, 
  };

  atn::ATNDeserializer deserializer;
  _atn = deserializer.deserialize(_serializedATN);

  size_t count = _atn.getNumberOfDecisions();
  _decisionToDFA.reserve(count);
  for (size_t i = 0; i < count; i++) { 
    _decisionToDFA.emplace_back(_atn.getDecisionState(i), i);
  }
}

ExpressParser::Initializer ExpressParser::_init;
