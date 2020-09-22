#!/bin/bash

set -eu

GRAMMAR_FILE="$1"
PARSER_DIR="lib/expressir/express_exp/generated"

# Ruby parser
# compile ANTLR4 JAR from https://github.com/twalmsley/antlr4/tree/ruby_dev
# see https://github.com/MODLanguage/antlr4-ruby-runtime
java -jar ~/.m2/repository/org/antlr/antlr4/4.7.3-SNAPSHOT/antlr4-4.7.3-SNAPSHOT-complete.jar \
  -no-listener \
  -visitor \
  -Dlanguage=Ruby \
  -package Dummy \
  -Xexact-output-dir \
  -o "$PARSER_DIR" \
  "$GRAMMAR_FILE"

# replace Dummy module with nested modules
for FILE in $PARSER_DIR/*.rb; do
  TMP_FILE="$(mktemp)"
  cat "$FILE" | awk '
    /^module Dummy$/ { print "module Expressir\nmodule ExpressExp\nmodule Generated"; next }
    { print $0 }
    END { print "end\nend" }
  ' > "$TMP_FILE"
  mv "$TMP_FILE" "$FILE"
done
