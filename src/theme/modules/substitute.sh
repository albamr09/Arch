#!/bin/bash

# Ensure the script is passed a JSON file and a template file
if [ $# -ne 2 ]; then
  echo "Usage: $0 <json-file> <template-file>"
  echo "Example: $0 variables.json template.txt"
  exit 1
fi

JSON_FILE=$1
TEMPLATE_FILE=$2

function obtain_value_from_key() {
    local json_file="$1"
    local key="$2"

    IFS='.' read -r -a array <<< "$key"

    # Loop through each part of the array and create an environment variable
    index=1
    KEY_QUERY=""
    for part in "${array[@]}"; do
        # Remove double quotes
        part="${part//\"/}"
        # Create a unique environment variable for each part
        export "KEY_$index=$part"
        KEY_QUERY="$KEY_QUERY.[env.KEY_$index]"
        ((index++))
    done

    # Use jq to extract the value
    result=$(jq -r "$KEY_QUERY" "$json_file")

    # Return the result
    echo "$result"
}

# Parse the JSON file and export the variables as environment variables
function export_json_vars() {
    local json_file="$1"

    # Extract all keys from the JSON file
    extracted_keys=$(jq -r 'paths(scalars) | join(".")' "$json_file")

    # Loop through each extracted key and obtain its value
    for key in $extracted_keys; do
        value=$(obtain_value_from_key "$json_file" "$key")
        # Replace dots with underscores in the key
        modified_key="${key//./_}"
        # Create env variable so it can be used
        export "$modified_key=$value"
    done
}

export_json_vars "$JSON_FILE"
envsubst < "$TEMPLATE_FILE"

# Example of usage
# ./scripts/modules/substitute.sh variables.json plugins.vim