#!/bin/bash

# Source directory
MODULES_DIR="modules"
# Target directory
TARGET_DIR="data/sql/custom"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Iterate over all modules
for module in "$MODULES_DIR"/*; do
    # Get the module name
    module_name=$(basename "$module")

    # Skip the mod-playerbots module
    if [ "$module_name" == "mod-playerbots" ]; then
        echo "Skipping module: $module_name"
        continue
    fi

    # Check if the module contains a data directory
    if [ -d "$module/data/sql" ]; then
        # Find all directories under data/sql
        find "$module/data/sql" -type d | while read -r dir; do
            # Extract directory name and standardize (replace hyphen with underscore)
            rel_path=$(echo "${dir#$module/data/sql/}" | sed 's/-/_/g')
            # Target directory path
            target="$TARGET_DIR/$rel_path"
            # Create target directory if it doesn't exist
            mkdir -p "$target"
            # Copy .sql files if they exist
            find "$dir" -maxdepth 1 -type f -name "*.sql" -exec cp {} "$target/" \;
        done
    fi
done

echo "SQL files copied and structured under $TARGET_DIR."

