#!/bin/bash

set -e

echo "Caller script: before calling the called script"
# This script will call the called_script.sh script
source called_script.sh

echo "Caller script: after calling the called script"
