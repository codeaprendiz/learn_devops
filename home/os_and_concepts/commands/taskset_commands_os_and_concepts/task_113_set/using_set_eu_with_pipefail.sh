#!/bin/bash
set -e
set -u
set -o pipefail

# Sample JSON object
json_object='{"somekey": "example_value"}'

# Example pipeline
export SOMEVAR=$(echo $json_object | jq -r -e ".somekey1") && : "${SOMEVAR:?Variable SOMEVAR is empty}"

echo "Variable SOMEVAR is assigned with: $SOMEVAR"

# Rest of your script
