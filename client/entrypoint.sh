#!/bin/bash

ROOT_DIR="/zotero"
ZOTERO_CONFIG_FILE="$ROOT_DIR/resource/config.js"

cp -r -f /app/{.,}* "$ROOT_DIR/"
cd $ROOT_DIR

# Configure
DATASERVER_ADDRESS="$DATASERVER_PROTOCOL://$DATASERVER_HOST:$DATASERVER_PORT"
WEBSOCKET_ADDRESS="$WEBSOCKET_PROTOCOL://$WEBSOCKET_HOST:$WEBSOCKET_PORT"
sed -i "s#https://api.zotero.org/#$DATASERVER_ADDRESS/#g" $ZOTERO_CONFIG_FILE
sed -i "s#wss://stream.zotero.org/#$WEBSOCKET_ADDRESS/#g" $ZOTERO_CONFIG_FILE
sed -i "s#https://www.zotero.org/#$DATASERVER_ADDRESS/#g" $ZOTERO_CONFIG_FILE
sed -i "s#https://zoteroproxycheck.s3.amazonaws.com/test##g" $ZOTERO_CONFIG_FILE

# Install NodeJS Modules
npm install

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
