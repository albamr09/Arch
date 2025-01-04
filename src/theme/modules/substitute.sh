#!/bin/bash

# Ensure the script is passed a JSON file and a template file
if [ $# -ne 2 ]; then
  echo "Usage: $0 <json-file> <template-file>"
  echo "Example: $0 variables.json template.txt"
  exit 1
fi

JSON_FILE=$1
TEMPLATE_FILE=$2

gomplate --missing-key default -f "$TEMPLATE_FILE" -d variables="$JSON_FILE"

# Example of usage
# ./scripts/modules/substitute.sh variables.json plugins.vim