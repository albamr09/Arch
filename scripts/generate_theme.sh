#!/bin/bash

# This script merges template files from a common directory with theme-specific variables and files.
# It searches for matching files in a specified theme folder, applies substitutions using a theme's variable file,
# and combines the common template files with any theme-specific files, saving the results in a specified output directory.

# The script performs the following steps:
# 1. It sets up the working directory and the directory where the script is located.
# 2. It calculates the path to the 'themes' directory by going up one level from the script's directory.
# 3. It verifies that the script is executed with the required arguments: theme name and output directory.
# 4. It checks if the output directory exists.
# 5. It defines a function (`merge_files`) that:
#    - Applies substitutions to a template file using the theme's variable file.
#    - Optionally appends the content of a theme-specific file if it exists.
# 6. It defines a function (`search_and_merge`) that:
#    - Finds the theme-specific variables file (`variables.json`) in the theme folder.
#    - Copies the `common` folder to the output directory.
#    - For each template file in the output directory (including hidden files), it finds the corresponding theme file.
#    - Calls `merge_files` to process and merge the template file with the theme-specific content.
# 7. It begins processing by calling `search_and_merge`.

# Directory of the currently running script
WORKDIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

THEMES_DIR="$(dirname "$SCRIPT_DIR")/themes"
COMMON_FOLDER="$THEMES_DIR/common"

# Check if at least two arguments are provided (theme name and output directory)
if [ $# -lt 2 ]; then
  echo "Usage: $0 <theme_name> <output_directory>"
  exit 1
fi

THEME_NAME="$1"
OUTPUT_DIR="$2"

# Validate the output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
  echo "Output directory does not exist: $OUTPUT_DIR"
  exit 1
fi

# Function to merge files
merge_files() {
    template_file="$1"
    theme_variables_file="$2"
    theme_file="$3"
    
    # Apply substitution to the common file using the theme variables
    template_filled=$(./modules/substitute.sh "$theme_variables_file" "$template_file")

    echo -e "$template_filled \n" > "$template_file"
    if [ -f "$theme_file" ]; then
        cat "$theme_file" >> "$template_file"
    fi

    echo "Merged file created successfully: $template_file"
}

# Main function to search for the input file and call merge_files
search_and_merge() {
    # Find the theme-specific variables file
    theme_folder="$THEMES_DIR/$THEME_NAME"
    if [ ! -d "$theme_folder" ]; then
        echo "Theme folder does not exist: $theme_folder"
        exit 1
    fi

    theme_variables_file=$(find "$theme_folder" -maxdepth 1 -type f -name "variables.json")

    if [ -z "$theme_variables_file" ]; then
        echo "No theme-specific variables file found for theme: $THEME_NAME"
        exit 1
    fi

    cp -r "$COMMON_FOLDER" "$OUTPUT_DIR"

    find "$OUTPUT_DIR" -type f -name ".*" -o -type f | while read -r template_file; do
        if [ -f "$template_file" ]; then
            file_name=$(basename "$template_file")
            theme_file=$(find "$theme_folder" -name "$file_name")
            merge_files "$template_file" "$theme_variables_file" "$theme_file"
        fi
    done

    find "$theme_folder" -type f -name ".*" -o -type f | while read -r theme_file; do
        if [ -f "$template_file" ]; then
            # echo
            # file_name=$(basename "$template_file")
            # theme_file=$(find "$theme_folder" -name "$file_name")
            # merge_files "$template_file" "$theme_variables_file" "$theme_file"
        fi
    done
}

# Start processing
search_and_merge "$INPUT_FILE"

cd $WORKDIR

# Example of usage
# ./scripts/generate_theme.sh QuantumQuartz  "/home/alba/Documentos/GitRepos/Arch/Arch/theme_test"