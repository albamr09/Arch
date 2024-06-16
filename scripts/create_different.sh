#!/bin/bash

input_filename=$1
theme=$2
common_file=$(find themes/common/ -iname $input_filename)
theme_file=$(find themes/$theme/ -iname $input_filename)

echo $common_file
echo $theme_file

diff --unchanged-line-format='%L' --old-line-format='' --new-line-format='%L' $common_file $theme_file > $input_filename
    
# Replace '\n' with actual newline characters
# sed -i 's/---n/\n/g' $input_filename

# Example of usage
# ./create_different.sh dunstrc Cottagecore