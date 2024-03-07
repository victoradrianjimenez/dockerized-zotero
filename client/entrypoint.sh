#!/bin/bash

ROOT_DIR="/zotero"
ZOTERO_CONFIG_FILE="$ROOT_DIR/resource/config.js"

cd $ROOT_DIR

# Configure
if [ $SERVER_SECURE_PROTOCOL -eq 0 ]; then
	DATA_SERVER_ADDRESS="http://$SERVER_HOST:$DATA_SERVER_PORT"
	STREAM_SERVER_ADDRESS="ws://$SERVER_HOST:$STREAM_SERVER_PORT"
else
	DATA_SERVER_ADDRESS="https://$SERVER_HOST:$DATA_SERVER_PORT"
	STREAM_SERVER_ADDRESS="wss://$SERVER_HOST:$STREAM_SERVER_PORT"
fi

sed -i "s#https://api.zotero.org/#$DATA_SERVER_ADDRESS/#g" $ZOTERO_CONFIG_FILE
sed -i "s#wss://stream.zotero.org/#$STREAM_SERVER_ADDRESS/#g" $ZOTERO_CONFIG_FILE
sed -i "s#https://zoteroproxycheck.s3.amazonaws.com/test##g" $ZOTERO_CONFIG_FILE
# sed -i "s#https://www.zotero.org/#$DATA_SERVER_ADDRESS/#g" $ZOTERO_CONFIG_FILE

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

cp -r -f $ROOT_DIR/app/staging/* /staging