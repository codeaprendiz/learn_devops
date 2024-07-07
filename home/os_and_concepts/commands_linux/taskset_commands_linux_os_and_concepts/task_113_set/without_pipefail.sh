#!/bin/bash
set -e

echo "hello"
test | false | true
echo "This will still be printed"
