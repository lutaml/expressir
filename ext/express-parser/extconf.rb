require 'rubygems'
require 'mkmf'

extension_name = 'express_parser'
cross_build = enable_config("cross-build")

antlr4_src = 'antlr4-upstream/runtime/Cpp/runtime/src'
src_paths = [
  ".",
  "antlrgen",
  "#{antlr4_src}",
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
  rice_src = File.join(rice_root, "rice")
  rice_embed = File.join(__dir__, rice_subdir)
  unless File.exists?(rice_embed)
    FileUtils.mkdir_p(rice_embed)
    FileUtils.cp_r(Dir.glob(rice_src), rice_embed)
    File.delete(*Dir.glob("#{rice_embed}/**/*.o"))
    File.delete(*Dir.glob("#{rice_embed}/**/Makefile"))
  end

  src_paths.push("#{rice_subdir}/rice", "#{rice_subdir}/rice/detail")

  $INCFLAGS << " -I#{__dir__}/#{rice_subdir}"

  if RbConfig::CONFIG['target_os'] =~ /mingw32|mswin/
    # workaround for 'w64-mingw32-as: express_parser.o: too many sections'
    $CXXFLAGS << " -O3 -Wa,-mbig-obj"
    # workaround for LoadError: 127: The specified procedure could not be found.
    $DLDFLAGS << " -static -static-libgcc -static-libstdc++"
  end
else
  require 'mkmf-rice'

  dir_config(extension_name)
end

$CPPFLAGS << " -std=c++14 -DANTLR4CPP_STATIC -DHAVE_CXX11"
$INCFLAGS << " -I#{__dir__}/#{antlr4_src}"
$srcs = []

src_paths.each do |src_path|
  abs_src_path = File.join(__dir__, src_path)
  $VPATH << abs_src_path
  $srcs.push(*Dir["#{abs_src_path}/*.cpp"])
end

create_makefile "expressir/express_exp/#{extension_name}"
