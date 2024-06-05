#!/bin/bash
set -e
set -o pipefail

echo "hello"
test | false | true
echo "This will not be printed"
