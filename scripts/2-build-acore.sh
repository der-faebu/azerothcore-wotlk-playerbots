#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACORE_BASE_DIR="$(dirname "$SCRIPT_DIR")"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
BUILD_DIR="$ACORE_BASE_DIR/build"
BUILD_SCRIPT_NAME="build-acore.sh"

echo "Script name: $SCRIPT_NAME"
echo "ACORE base dir: $ACORE_BASE_DIR"
echo "Build dir: $BUILD_DIR"

if [ ! -d "$BUILD_DIR" ]; then
    echo "Creating build directory at: $BUILD_DIR"
    mkdir -p "$BUILD_DIR"
fi

if [ -f "$BUILD_DIR/$BUILD_SCRIPT_NAME" ]; then
    echo "File exists. Removing..."
    rm "$BUILD_DIR/$BUILD_SCRIPT_NAME"
fi

echo "Copying script to build directory..."
cp "$SCRIPT_DIR/$BUILD_SCRIPT_NAME" "$BUILD_DIR/"

echo "Executing script in build directory..."
bash "$BUILD_DIR/$BUILD_SCRIPT_NAME"

echo "Script execution completed."
