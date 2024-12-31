#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <file-pattern>"
    exit 1
fi

# Find files matching the pattern but exclude those inside the 'common' directory
files=$(find . -wholename "*$1" -not -path '*common/*')

if [ -z "$files" ]; then
    echo "No files found matching pattern: $1"
    exit 0
fi

# Display files in a column
echo "The following files will be removed:"
echo "$files"
echo

# Ask for confirmation
read -p "Do you want to remove these files? [y/N] " response

# Process response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "$files" | xargs rm -r -v
        echo "Files removed."
        ;;
    *)
        echo "No files were removed."
        ;;
esac

# Example of usage
# ./utils/remove_files.sh dunstrc