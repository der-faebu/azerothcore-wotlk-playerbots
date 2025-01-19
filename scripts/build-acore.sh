#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACORE_BASE_DIR="$(dirname "$SCRIPT_DIR")"

echo "ACORE dir: $ACORE_BASE_DIR"

cmake /srv/azerothcore-wotlk-playerbots/ -DCMAKE_INSTALL_PREFIX=/srv/azerothcore-wotlk-playerbots/env/dist/ -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS_BUILD=all -DSCRIPTS=static -DMODULES=static
make -j $(nproc --all)
make install
