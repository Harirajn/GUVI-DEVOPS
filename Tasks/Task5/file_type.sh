#!/bin/bash

echo "This script checks the type of a given file"
echo "Enter a file path:"
read file_path

if [ -f "$file_path" ]; then
    echo "$file_path is a regular file."
elif [ -d "$file_path" ]; then
    echo "$file_path is a directory."
elif [ -L "$file_path" ]; then
    echo "$file_path is a symbolic link."
else
    echo "$file_path is not a regular file, directory, or symbolic link."
fi
