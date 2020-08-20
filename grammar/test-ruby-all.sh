#!/bin/bash

set -eu

./test-files.sh | tr '\n' '\0' | \
    xargs -0 -n1 -P2 ./test-ruby.sh