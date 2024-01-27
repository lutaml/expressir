require "fileutils"
require "antlr4-native"
require "rake"

def create_class_declarations(parser_source_lines)
  i = parser_source_lines.index { |x| x == "Class rb_cContextProxy;" }
  parser_source_lines[i] += <<~CPP.split("\n").map { |x| x == "" ? x : x.to_s }.join("\n")

    Class rb_cParserExt;
    Class rb_cTokenExt;

  CPP
end

def create_tp_class_definition(parser_source_lines)
  i = parser_source_lines.index { |x| x == "class ContextProxy {" }
  parser_source_lines[i - 2] += <<~CPP.split("\n").map { |x| x == "" ? x : x.to_s }.join("\n")


    class TokenProxy : public Object {
      public:
        TokenProxy(Token* orig) {
          this -> orig = orig;
        }

        std::string getText() {
          return orig->getText();
        }

        size_t getChannel() {
          return orig->getChannel();
        }

        size_t getTokenIndex() {
          return orig->getTokenIndex();
        }

      private:
        Token * orig = nullptr;
    };

  CPP
end

def create_pp_class_definition(parser_source_lines)
  i = parser_source_lines.index { |x| x == "extern \"C\"" }
  parser_source_lines[i - 2] += <<~CPP.split("\n").map { |x| x == "" ? x : x.to_s }.join("\n")

    class ParserProxyExt : public Object {
      public:
        ParserProxyExt(string file) {
          ifstream stream;
          stream.open(file);
          input = new ANTLRInputStream(stream);
          lexer = new ExpressLexer(input);
          tokens = new CommonTokenStream(lexer);
          parser = new ExpressParser(tokens);
          stream.close();
        };

        ~ParserProxyExt() {
          delete parser;
          delete tokens;
          delete lexer;
          delete input;
        }

        Object syntax() {
          auto ctx = parser -> syntax();

          SyntaxContextProxy proxy((ExpressParser::SyntaxContext*) ctx);
          return detail::To_Ruby<SyntaxContextProxy>().convert(proxy);
        }

        Object getTokens() {
          std::vector<TokenProxy> tk;
          for (auto token : tokens -> getTokens()) {
            tk.push_back(TokenProxy(token));
          }
          return detail::To_Ruby<std::vector<TokenProxy>>().convert(tk);
        }

        Object visit(VisitorProxy* visitor) {
          auto result = visitor -> visit(parser -> syntax());

          lexer -> reset();
          parser -> reset();

          try {
            return std::any_cast<Object>(result);
          } catch(std::bad_any_cast) {
            return Qnil;
          }
        }

      private:
        ANTLRInputStream* input;
        ExpressLexer* lexer;
        CommonTokenStream* tokens;
        ExpressParser* parser;
    };


  CPP
end

def create_class_api(parser_source_lines)
  i = parser_source_lines.index { |x| x == "    .define_method(\"visit\", &ParserProxy::visit);" }
  parser_source_lines[i] += <<~CPP.split("\n").map { |x| x == "" ? x : "  #{x}" }.join("\n")


    rb_cTokenExt = define_class_under<TokenProxy>(rb_mExpressParser, "TokenExt")
      .define_method("text", &TokenProxy::getText)
      .define_method("channel", &TokenProxy::getChannel)
      .define_method("token_index", &TokenProxy::getTokenIndex);

    rb_cParserExt = define_class_under<ParserProxyExt>(rb_mExpressParser, "ParserExt")
      .define_constructor(Constructor<ParserProxyExt, string>())
      .define_method("syntax", &ParserProxyExt::syntax)
      .define_method("tokens", &ParserProxyExt::getTokens, Return().keepAlive())
      .define_method("visit", &ParserProxyExt::visit);

    define_vector<std::vector<TokenProxy>>("TokenVector");

  CPP
end

def create_vector_definition(parser_source_lines)
  i = parser_source_lines.index { |x| x == "    .define_method(\"visit\", &ParserProxy::visit);" }
  parser_source_lines[i] += <<~CPP.split("\n").map { |x| x == "" ? x : "  #{x}" }.join("\n")

  CPP
end

def generate_extended_parser
  # Generate extended parser that provide Ruby access to token stream
  parser_source_file = File.join("ext", "express_parser", "express_parser.cpp")
  parser_source_lines = File.read(parser_source_file)
    .gsub!("bad_cast", "bad_any_cast")
    .gsub!("return detail::To_Ruby<Token*>().convert(token)", "return detail::To_Ruby<TokenProxy>().convert(TokenProxy(token))")
    .split("\n")
  create_class_declarations(parser_source_lines)
  create_tp_class_definition(parser_source_lines)
  create_pp_class_definition(parser_source_lines)
  create_class_api(parser_source_lines)
  File.write(parser_source_file, "#{parser_source_lines.join("\n")}\n")
end

desc "Generate parser  (Usage: 'rake generate <grammar_file>')"
task "generate" do
  grammar_file = ARGV[1]
  if grammar_file.nil?
    grammar_file = File.expand_path(File.join("..", "ext", "express-grammar", "Express.g4"), __dir__)
  end

  puts "Generating parser from '#{grammar_file}'"
  # ANTLR does weird things if the grammar file isn't in the current working directory
  temp_grammar_file = File.join(FileUtils.pwd, File.basename(grammar_file))
  FileUtils.cp(grammar_file, temp_grammar_file)

  # generate parser
  generator = Antlr4Native::Generator.new(
    grammar_files: [File.basename(temp_grammar_file)],
    output_dir: "ext",
    parser_root_method: "syntax",
  )
  generator.generate

  puts "Generating extended parser"
  generate_extended_parser
  # cleanup
  FileUtils.rm(temp_grammar_file)
end
