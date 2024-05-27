#!/bin/bash

# path to XML report files
xml_directory=reports

for file in "$xml_directory"/*.xml; do
  if [ -e "$file" ]; then
    echo "Processing file: $file"

    # create a temporary file
    temp_file=$(mktemp)

    # this remove the "file://" prefix from the "value" attribute
    sed 's/value="file:\/\//value="/g' "$file" > "$temp_file"
    # this remove the "file://" prefix from the "file" attribute
    sed 's/file="file:\/\//file="/g' "$temp_file" > "$file"

    rm "$temp_file"

    echo "Removed 'file://' prefix from $file"
  fi
done