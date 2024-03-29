
// Generated from Express.g4 by ANTLR 4.10.1

#pragma once


#include "antlr4-runtime.h"




class  ExpressLexer : public antlr4::Lexer {
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

  explicit ExpressLexer(antlr4::CharStream *input);

  ~ExpressLexer() override;


  std::string getGrammarFileName() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const std::vector<std::string>& getChannelNames() const override;

  const std::vector<std::string>& getModeNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;

  const antlr4::atn::ATN& getATN() const override;

  // By default the static state used to implement the lexer is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:

  // Individual action functions triggered by action() above.

  // Individual semantic predicate functions triggered by sempred() above.

};

