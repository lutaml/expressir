require './ExpressListener'
require './ExpressBaseListener'
require './ExpressVisitor'
require './ExpressLexer'
require './ExpressParser'

input = STDIN.read

def create_parser(input)
  char_stream = Antlr4::Runtime::CharStreams.from_string(input, 'String')
  lexer = Express::ExpressLexer.new(char_stream)
  token_stream = Antlr4::Runtime::CommonTokenStream.new(lexer)
  parser = Express::ExpressParser.new(token_stream)
  return parser
end

parser = create_parser(input)
parse_tree = parser.syntax()

# schemas = parse_tree.schemaDecl().map{|schemaDecl| schemaDecl.schemaDef().SimpleId().text}
# puts schemas.join(',')