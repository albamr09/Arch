#!/bin/bash

# Function to merge files
merge_files() {
  input_file="$1"

  # Get the directory and file name of the input file
  input_dir=$(dirname "$input_file")
  input_file_name=$(basename "$input_file")

  # Define the common folder path
  common_folder="$input_dir/common"

  # Check if the common folder exists
  if [ ! -d "$common_folder" ]; then
    echo "The 'common' folder does not exist in: $input_dir"
    exit 1
  fi

  # Construct the path to the common file
  common_file="$common_folder/$input_file_name"

  # Check if the common file exists
  if [ ! -f "$common_file" ]; then
    echo "No common file found with the name: $input_file_name"
    exit 1
  fi

  # Define the output file path
  output_file="$input_dir/merged_$input_file_name"

  # Merge the common file and input file content into the output file
  cat "$common_file" "$input_file" > "$output_file"

  echo "Merged file created successfully: $output_file"
}

# Check if an argument is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file_path>"
  exit 1
fi

# Call the function with the input file path
merge_files "$1"
