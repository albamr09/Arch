#!/bin/bash

# Directory of the currently running script
WORKDIR="$pwd"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

# TODO: this should be obtained from SCRIPT dir
THEMES_DIR="/home/alba/Documentos/GitRepos/Arch/Arch/themes"
COMMON_FOLDER="$THEMES_DIR/common"
INPUT_FILE="$1"
VARIABLES_FILE="$2"
INPUT_FILE_NAME=$(basename "$INPUT_FILE")

# Function to merge files
merge_files() {
    common_file="$1"

    # Define the output file path
    output_file="${INPUT_FILE%/*}/merged_$INPUT_FILE_NAME"

    input_file_filled=$(./substitute.sh $VARIABLES_FILE "$common_file")

    # Concatenate the input_file content to the end of input_file_filled
    echo -e "$input_file_filled \n" > "$output_file"
    cat "$INPUT_FILE" >> "$output_file"           

    echo "Merged file created successfully: $output_file"
}

# Main function to search for the input file and call merge_files
search_and_merge() {
    common_file=$(find "$COMMON_FOLDER" -type f -name "$INPUT_FILE_NAME")

    if [ -z "$common_file" ]; then
        echo "No input file found with the name: $INPUT_FILE_NAME"
        exit 1
    fi

    # Call the merge_files function with the found input file
    merge_files "$common_file"
}

# Check if an argument is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file_name>"
  exit 1
fi

# Call the search_and_merge function with the input file name
search_and_merge "$1"

cd $WORKDIR