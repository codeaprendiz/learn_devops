#!/bin/bash

## npm install markdown-table-formatter -g
## find . -name ReadMe.md | markdown-table-formatter
total_tasks=$(find . -type d -name "task_*" | wc -l)

php generate-readme.php
# Add tasks to second line of ReadMe.md
sed -i '' "2s/.*/\n> Total Number of Tasks : $total_tasks\n/" ReadMe.md
find . -name ReadMe.md | markdown-table-formatter
# # Loop over all directories that match the regex
# for olddir in $(find . -type d -name "task*"); do
#   # Construct the new directory name by replacing '-' with '_'
#   newdir=$(echo "$olddir" | tr '-' '_')
#   # Rename the directory
#   if [ "$olddir" != "$newdir" ]; then
#     mv "$olddir" "$newdir"
#   fi
# done
