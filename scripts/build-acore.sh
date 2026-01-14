#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACORE_BASE_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$ACORE_BASE_DIR/build"

mkdir -p "$BUILD_DIR"

cmake -S "$ACORE_BASE_DIR" -B "$BUILD_DIR" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$ACORE_BASE_DIR/env/dist" \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DWITH_WARNINGS=1 \
  -DTOOLS_BUILD=all \
  -DSCRIPTS=static \
  -DMODULES=static

cmake --build "$BUILD_DIR" -j"$(nproc --all)"
cmake --install "$BUILD_DIR"

