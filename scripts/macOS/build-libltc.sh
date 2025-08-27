#!/bin/bash
set -e  # exit on any error
set -x  # print commands as they run

CONFIGURATION="${1:-Release}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBLTC_BUILD="${SCRIPT_DIR}/../../builds"
LIBLTC_DYLIB="${LIBLTC_BUILD}/${CONFIGURATION}/liblibltc.dylib"

echo "CONFIGURATION: $CONFIGURATION"
echo "SCRIPT_DIR: $SCRIPT_DIR"
echo "LIBLTC_BUILD: $LIBLTC_BUILD"

if [ ! -f "$LIBLTC_DYLIB" ]; then
    echo "Building libltc..."
    mkdir -p "$LIBLTC_BUILD"
    pushd "$LIBLTC_BUILD"

    /opt/homebrew/bin/cmake .. -G Xcode || exit 1
    /opt/homebrew/bin/cmake --build . --config "$CONFIGURATION" || exit 1

    popd
else
    echo "liblibltc.dylib already exists. Skipping."
fi

