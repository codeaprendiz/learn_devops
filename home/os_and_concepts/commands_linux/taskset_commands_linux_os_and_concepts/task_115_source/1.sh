#!/bin/bash

echo "begin 1.sh........."

# bash 2.sh
source 2.sh

echo "VAR_FROM_2 : $VAR_FROM_2"

echo "end 1.sh............"
