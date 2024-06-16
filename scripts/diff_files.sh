#!/bin/bash

files=$(find . -iname $1)
file_count=$(echo "$files" | wc -l)

if [ "$file_count" -ge 2 ]; then
    vimdiff $(echo "$files")
else
    echo "Need at least two 'dunstrc' files for vimdiff."
fi

# Example of usage
# ./diff_files.sh dunstrc