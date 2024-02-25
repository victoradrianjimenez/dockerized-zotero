#!/bin/bash

ROOT_DIR="/zotero"

cp -r -f /app/{.,}* "$ROOT_DIR/"
cd $ROOT_DIR

# build
PARAMS=""
if [ $DEBUGGER -eq 1 ]; then
	PARAMS="-t"
fi

# run build watch # TEMP: --openssl-legacy-provider avoids a build error in pdf.js
NODE_OPTIONS=--openssl-legacy-provider npm run build

"$ROOT_DIR/app/scripts/dir_build" -q $PARAMS -p $PLATFORM

if [ "`uname`" = "Darwin" ]; then
	# Sign the Word dylib so it works on Apple Silicon
	"$ROOT_DIR/app/scripts/codesign_local" "$ROOT_DIR/app/staging/Zotero.app"
fi
