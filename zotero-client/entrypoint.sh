#!/bin/bash -e

ROOT_DIR="/zotero"
APP_ROOT_DIR="$ROOT_DIR/app"
SCRIPT_DIR="$APP_ROOT_DIR/scripts"
ZOTERO_CONFIG_FILE="$ROOT_DIR/resource/config.js"

# get source code (last version)
git config --global --add safe.directory $ROOT_DIR
git config --global http.postBuffer 1073741824
if [ -d "$ROOT_DIR/.git" ]; then
	cd $ROOT_DIR
	git reset --hard origin/main
	git pull origin main
	git submodule update --init --recursive
else
	# Get code from repositories
	rm -r -f "$ROOT_DIR/*"
	git clone --recursive https://github.com/zotero/zotero
	cd $ROOT_DIR
fi

# Configure
sed -i 's#https://api.zotero.org/#http://localhost:8080/#g' $ZOTERO_CONFIG_FILE
sed -i 's#wss://stream.zotero.org/#ws://localhost:8081/#g' $ZOTERO_CONFIG_FILE
sed -i 's#https://www.zotero.org/#http://localhost:8080/#g' $ZOTERO_CONFIG_FILE
sed -i 's#https://zoteroproxycheck.s3.amazonaws.com/test##g' $ZOTERO_CONFIG_FILE

# Install NodeJS Modules
npm install

# build
PARAMS=""
if [ $DEBUGGER -eq 1 ]; then
	PARAMS="-t"
fi

# Check if build watch is running
# If not, run now
if ! ps u | grep js-build/build.js | grep -v grep > /dev/null; then
	echo "Running JS build process"
	echo
	cd $ROOT_DIR
	# TEMP: --openssl-legacy-provider avoids a build error in pdf.js
	NODE_OPTIONS=--openssl-legacy-provider npm run build
	echo
fi

"$SCRIPT_DIR/dir_build" -q $PARAMS -p $PLATFORM

if [ "`uname`" = "Darwin" ]; then
	# Sign the Word dylib so it works on Apple Silicon
	"$SCRIPT_DIR/codesign_local" "$APP_ROOT_DIR/staging/Zotero.app"
fi
