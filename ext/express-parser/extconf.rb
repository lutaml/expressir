require "rubygems"
require "mkmf"

extension_name = "express_parser"
cross_build =  enable_config("cross-build")

antlr4_src = "antlr4-upstream/runtime/Cpp/runtime/src"
src_paths = [
  ".",
  "antlrgen",
  antlr4_src.to_s,
  "#{antlr4_src}/atn",
  "#{antlr4_src}/dfa",
  "#{antlr4_src}/misc",
  "#{antlr4_src}/support",
  "#{antlr4_src}/tree",
  "#{antlr4_src}/tree/pattern",
  "#{antlr4_src}/tree/xpath",
]

if cross_build
  rice_subdir = "rice-embed"
  rice_root = Gem.loaded_specs["rice"].full_gem_path
  rice_src = File.join(rice_root, "include", "rice")
  rice_embed = File.join(__dir__, rice_subdir)
  unless File.exist?(rice_embed)
    FileUtils.mkdir_p(rice_embed)
    FileUtils.cp_r(Dir.glob(rice_src), rice_embed)
    File.delete(*Dir.glob("#{rice_embed}/**/*.o"))
    File.delete(*Dir.glob("#{rice_embed}/**/Makefile"))
  end

  src_paths.push("#{rice_subdir}/include")

  $INCFLAGS << " -I#{__dir__}/#{rice_subdir}"

  case RbConfig::CONFIG["target_os"]
  when /mingw32|mswin/
    # workaround for 'w64-mingw32-as: express_parser.o: too many sections'
    $CXXFLAGS << " -O3 -Wa,-mbig-obj"
    # workaround for LoadError: 127: The specified procedure could not be found.
    $DLDFLAGS << " -static-libgcc -static-libstdc++"
  when /darwin/
    $CXXFLAGS << " -mmacosx-version-min=10.14 -Wno-register -fno-c++-static-destructors"
    $DLDFLAGS << " -mmacosx-version-min=10.14"
  end
else
  require "mkmf-rice"
  dir_config(extension_name)
end

$CPPFLAGS << " -std=c++17 -DANTLR4CPP_STATIC -DHAVE_CXX11"
$INCFLAGS << " -I#{__dir__}/#{antlr4_src}"
$srcs = []

src_paths.each do |src_path|
  abs_src_path = File.join(__dir__, src_path)
  $VPATH << abs_src_path
  $srcs.push(*Dir["#{abs_src_path}/*.cpp"])
end

create_makefile "expressir/express/#{extension_name}"
