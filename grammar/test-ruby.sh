#!/bin/bash

set -eu

INPUT="$1"

OUTPUT="$(cat "$INPUT" | bundle exec ruby ./parse.rb)"

if [ ! -z "$OUTPUT" ]; then
    echo "FAIL $INPUT"
else
    echo "PASS $INPUT"
fi

if [ ! -z "$OUTPUT" ]; then
    echo "$OUTPUT"
fi