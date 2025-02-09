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

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ../common/utils.sh
. ../common/config.sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"
TEMPLATE_DIR="$3"
THEME_NAME="$(basename $INPUT_DIR)"

merge_files() {
    template_file="$1"
    theme_variables_file="$2"
    theme_file="$3"
    
    # Apply substitution to the common file using the theme variables
    ./modules/substitute.sh "$theme_variables_file" "$template_file" "$template_file"
    if [ -f "$theme_file" ]; then
        echo -e "\n" >> "$template_file"
        cat "$theme_file" >> "$template_file"
    fi
}

generate_config_from_template() {

    title_msg "Generating configuration files from templates..."

    theme_variables_file="$1"

    # Loop through all files in the output directory to apply substitution and merge
    find "$OUTPUT_DIR" -type f -name ".*" -o -type f | while read -r template_file; do
        if [ -f "$template_file" ]; then
            file_name=$(basename "$template_file")
            theme_file=$(find "$INPUT_DIR" -name "$file_name")
            info_msg "Merging $template_file"
            merge_files "$template_file" "$theme_variables_file" "$theme_file"
        fi
    done
}

copy_remaining_theme_files() {
    title_msg "Copying remaining configuration files..."

    # Copy without replacing existing files
    execute cp -rn $INPUT_DIR/* "$OUTPUT_DIR"
}

search_and_merge() {

    if [ ! -d "$INPUT_DIR" ]; then
        error_msg "Theme folder does not exist: $INPUT_DIR"
    fi

    theme_variables_file=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "variables.json")

    if [ -z "$theme_variables_file" ]; then
        error_msg "No theme-specific variables file found for theme: $THEME_NAME"
    fi

    rm -rf "$OUTPUT_DIR"/*
    cp -r "$TEMPLATE_DIR"/* "$OUTPUT_DIR"

    generate_config_from_template "$theme_variables_file"
    copy_remaining_theme_files
}

# Start processing
search_and_merge "$INPUT_FILE"

cd $CURR_DIR