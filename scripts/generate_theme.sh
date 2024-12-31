#!/bin/bash

# This script merges template files from a common directory with theme-specific variables and files.
# It searches for matching files in a specified theme folder, applies substitutions using a theme's variable file,
# and combines the common template files with any theme-specific files, saving the results in a specified output directory.

# The script performs the following steps:
# 1. It sets up the working directory and the directory where the script is located.
# 2. It calculates the path to the 'themes' directory by going up one level from the script's directory.
# 3. It verifies that the script is executed with the required arguments: theme name and output directory.
# 4. It checks if the output directory exists. If not, it exits with an error.
# 5. It defines a function (`merge_files`) that:
#    - Applies substitutions to a template file using the theme's variable file.
#    - Optionally appends the content of a theme-specific file if it exists.
# 6. It defines a function (`generate_config_from_template`) that:
#    - Loops through all files (including hidden files) in the output directory.
#    - For each template file in the output directory, it searches for the corresponding theme file.
#    - Calls `merge_files` to apply substitutions and merge the theme-specific content with the template.
# 7. It defines a function (`copy_remaining_theme_files`) that:
#    - Copies any remaining theme-specific files (that were not already merged) from the theme folder to the output directory.
#    - It ensures that the correct directory structure is maintained.
# 8. It defines the `search_and_merge` function, which:
#    - Verifies that the theme folder exists and contains the required variables file (`variables.json`).
#    - Clears the output directory and copies the contents of the `common` folder to it.
#    - Calls `generate_config_from_template` to process the template files.
#    - Calls `copy_remaining_theme_files` to copy the remaining theme files.
# 9. It starts the processing by calling `search_and_merge` with the theme name and output directory as arguments.
#
# Example of usage:
# ./scripts/generate_theme.sh QuantumQuartz "/home/alba/Documentos/GitRepos/Arch/Arch/theme_test"
#
# Arguments:
# - The theme name (e.g., "QuantumQuartz").
# - The output directory where the merged files will be stored.

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

generate_config_from_template() {
    theme_folder="$1"
    theme_variables_file="$2"
    output_dir="$3"

    # Loop through all files in the output directory to apply substitution and merge
    find "$output_dir" -type f -name ".*" -o -type f | while read -r template_file; do
        if [ -f "$template_file" ]; then
            file_name=$(basename "$template_file")
            theme_file=$(find "$theme_folder" -name "$file_name")
            merge_files "$template_file" "$theme_variables_file" "$theme_file"
        fi
    done
}

copy_remaining_theme_files() {
    theme_folder="$1"
    output_dir="$2"

    echo "Copying remaining configuration files for $THEME_NAME ..."

    # Loop through all theme files in the theme folder and copy them to the output directory (ignore the docs directory)
    find "$theme_folder" -mindepth 2 -type f -name ".*" -o -type f | grep -v "^$theme_folder/docs" | while read -r theme_file; do
        if [ -f "$theme_file" ]; then
            file_name=$(basename "$theme_file")
            folder_name=$(basename $(dirname "$theme_file"))
            found_file=$(find "$output_dir" -type f -iwholename "*$folder_name/$file_name")
            
            if [ -z "$found_file" ]; then
                # Create necessary directories and copy the theme file
                extracted_path=$(echo "$theme_file" | sed "s|$theme_folder||")
                output_path="$output_dir$extracted_path"
                mkdir -p $(dirname "$output_path")
                cp "$theme_file" "$output_path"
            fi
        fi
    done
}

search_and_merge() {
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

    rm -rf "$OUTPUT_DIR"/*
    cp -r "$COMMON_FOLDER"/* "$OUTPUT_DIR"

    generate_config_from_template "$theme_folder" "$theme_variables_file" "$OUTPUT_DIR"
    copy_remaining_theme_files "$theme_folder" "$OUTPUT_DIR"
}

# Start processing
search_and_merge "$INPUT_FILE"

cd $WORKDIR