#!/bin/bash

## npm install markdown-table-formatter -g
## find . -name ReadMe.md | markdown-table-formatter

# Loop over all directories that match the regex
for olddir in $(find . -type d -name "task*"); do
  # Construct the new directory name by replacing '-' with '_'
  newdir=$(echo "$olddir" | tr '-' '_')
  # Rename the directory
  if [ "$olddir" != "$newdir" ]; then
    mv "$olddir" "$newdir"
  fi
done
