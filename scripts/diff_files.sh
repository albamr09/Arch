#!/bin/bash

files=$(find . -wholename "*$1*")
file_count=$(echo "$files" | wc -l)

if [ "$file_count" -ge 2 ]; then
    vimdiff $(echo "$files") -c TOhtml -c 'w! diff4.html|qa!'
else
    echo "Need at least two 'dunstrc' files for vimdiff."
fi

# Example of usage
# ./utils/diff_files.sh dunstrc