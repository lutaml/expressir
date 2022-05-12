require "fileutils"
require "antlr4-native"
require "rake"

def create_tokens_api(parser_source_lines)
  # - add ParserProxy tokens method, simple compensation for missing exposed BufferedTokenStream
  i = parser_source_lines.index { |x| x == "  Object syntax() {" }
  parser_source_lines[i + 6] += <<~CPP.split("\n").map { |x| x == "" ? x : "  #{x}" }.join("\n")

    Array getTokens() {
      Array a;

      std::vector<Token*> tokens = this -> tokens -> getTokens();

      for (auto &token : tokens) {
        a.push(token);
      }

      return a;
    }

  CPP
end

def create_tokens_method(parser_source_lines)
  i = parser_source_lines.index { |x| x == '    .define_method("syntax", &ParserProxy::syntax, Return().keepAlive())' }
  parser_source_lines[i] += <<~CPP.split("\n").map { |x| x == "" ? x : "    #{x}" }.join("\n")

    .define_method("tokens", &ParserProxy::getTokens)
  CPP
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

  # fix issues with generated parser
  parser_source_file = File.join("ext", "express-parser", "express_parser.cpp")
  parser_source_lines = File.read(parser_source_file).split("\n")
  create_tokens_api(parser_source_lines)
  create_tokens_method(parser_source_lines)
  File.write(parser_source_file, "#{parser_source_lines.join("\n")}\n")

  # cleanup
  FileUtils.rm(temp_grammar_file)
end
