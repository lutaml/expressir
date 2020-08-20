#!/bin/bash

set -eu

# Ruby parser
# compile ANTLR4 JAR from https://github.com/twalmsley/antlr4/tree/ruby_dev
# see https://github.com/MODLanguage/antlr4-ruby-runtime
java -jar ~/.m2/repository/org/antlr/antlr4/4.7.3-SNAPSHOT/antlr4-4.7.3-SNAPSHOT-complete.jar \
    -listener \
    -visitor \
    -Dlanguage=Ruby \
    -package Express \
    Express.g4

# Java parser
# use with grun
java -jar ~/.m2/repository/org/antlr/antlr4/4.7.3-SNAPSHOT/antlr4-4.7.3-SNAPSHOT-complete.jar \
    -listener \
    -visitor \
    -Dlanguage=Java \
    Express.g4

javac -cp .:$HOME/.m2/repository/org/antlr/antlr4/4.7.3-SNAPSHOT/antlr4-4.7.3-SNAPSHOT-complete.jar \
    *.java
