#!/bin/bash

set -euo pipefail

ENV_SLUG=$1

echo "Making ./why-ferrocene-${ENV_SLUG}..."
mkdir -p "./why-ferrocene-${ENV_SLUG}"
mv ./slides "./why-ferrocene-${ENV_SLUG}/slides"
mv ./book "./why-ferrocene-${ENV_SLUG}/book"
cp -r ./example-code "./why-ferrocene-${ENV_SLUG}/example-code"
cp -r ./docker "./why-ferrocene-${ENV_SLUG}/docker"
echo "Compressing ./why-ferrocene-${ENV_SLUG}.zip..."
zip -r "./why-ferrocene-${ENV_SLUG}.zip" "./why-ferrocene-${ENV_SLUG}"
