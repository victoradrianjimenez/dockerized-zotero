#!/bin/bash

ROOT_DIR="/app"
ZOTERO_CONFIG_FILE="$ROOT_DIR/resource/config.js"

git clone --recursive https://github.com/zotero/zotero $ROOT_DIR
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
