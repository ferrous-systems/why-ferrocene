#!/bin/bash

set -euo pipefail

rm -rf ./slides || true
rm -rf ./book || true
mkdir ./slides
mkdir ./slides/images
# Check the examples are OK
mdbook test
# book goes into ./book
mdbook build
# slides go into ./slides
mdslides \
    --output-dir ./slides \
    --template ./template.html \
    --index-template ./index-template.html
cp ./src/images/*.png ./slides/images
