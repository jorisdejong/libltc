#!/bin/bash
set -e
set -x

# Build configuration: Debug or Release
CONFIGURATION="${1:-Release}"

# Project-relative path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBLTC_BUILD="${SCRIPT_DIR}/../../builds"
LIBLTC_DYLIB="${LIBLTC_BUILD}/${CONFIGURATION}/liblibltc.dylib"

# Name of your .app (change if different!)
APP_NAME="HeadsUp"
APP_BUNDLE="${SCRIPT_DIR}/../../../../build/binaries/${CONFIGURATION}/${APP_NAME}.app"
FRAMEWORKS_DIR="${APP_BUNDLE}/Contents/Frameworks"

# Check for dylib
if [ ! -f "$LIBLTC_DYLIB" ]; then
    echo "Error: liblibltc.dylib not found at $LIBLTC_DYLIB"
    exit 1
fi

# Check app bundle exists
if [ ! -d "$APP_BUNDLE" ]; then
    echo "Error: App bundle not found at $APP_BUNDLE"
    exit 1
fi

# Create Frameworks dir if needed
mkdir -p "$FRAMEWORKS_DIR"

# Copy the dylib into Frameworks
cp -f "$LIBLTC_DYLIB" "$FRAMEWORKS_DIR"

# Optional: Code sign it
# codesign --force --sign - "$FRAMEWORKS_DIR/liblibltc.dylib"

echo "✅ Copied liblibltc.dylib to $FRAMEWORKS_DIR"
