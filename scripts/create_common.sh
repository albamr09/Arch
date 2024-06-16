#!/bin/bash

input_filename=$1
mapfile -t files < <(find . -iname $input_filename)

# Output file for common parts
output_file=$input_filename

# Check if there are at least two files
if [ "${#files[@]}" -lt 2 ]; then
  echo "Need at least two 'dunstrc' files to find common lines."
  exit 1
fi

# Initialize file count
file_count=0

# Iterate over each file in the list
for file in "${files[@]}"; do
    echo $file
  if [ ! -f "$file" ]; then
    echo "File $file does not exist."
    exit 1
  fi

  # For the first file, copy its content to the output file
  if [ "$file_count" -eq 0 ]; then
    cp "$file" "$output_file"
  else
    # Use diff to find common lines and update the output file
    diff --unchanged-line-format='%L' --old-line-format='' --new-line-format='---n' "$output_file" "$file" > temp.txt
    # Replace '\n' with actual newline characters
    sed -i 's/---n/\n/g' temp.txt
    mv temp.txt "$output_file"
  fi

  # Increment file count
  file_count=$((file_count + 1))
done

# Example of usage
# ./create_common.sh dunstrc