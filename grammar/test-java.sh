#!/bin/bash

set -eu

INPUT="$1"

OUTPUT="$(cat "$INPUT" | java -cp .:$HOME/.m2/repository/org/antlr/antlr4/4.7.3-SNAPSHOT/antlr4-4.7.3-SNAPSHOT-complete.jar org.antlr.v4.gui.TestRig Express syntax 2>&1)"

# ignore invalid STEPmod lines
# see https://github.com/lutaml/expressir/issues/7
IGNORE_LINES="$(cat ./test-ignore.txt | grep -v '^#' | grep "^${INPUT/.*iso-10303-stepmod\//} " | sed "s~.*${INPUT/.*iso-10303-stepmod\//} ~~" | tr ',' ' ' | tr '\n' ' ')"
for LINE in $IGNORE_LINES; do
    OUTPUT="$(echo "$OUTPUT" | sed "s/^\(line $LINE\)/IGNORE \1/" || true)"
done

OUTPUT2="$(echo "$OUTPUT" | grep -v ^IGNORE || true)"
if [ ! -z "$OUTPUT2" ]; then
    echo "FAIL $INPUT"
else
    echo "PASS $INPUT"
fi

if [ ! -z "$OUTPUT" ]; then
    echo "$OUTPUT"
fi