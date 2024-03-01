#!/bin/sh

# Env vars
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOG_DIR=/var/log/apache2

ROOT_DIR=/var/www/zotero
URI=$DATA_SERVER_PROTOCOL://$DATA_SERVER_HOST:$DATA_SERVER_PORT/

cp -r -f /zotero/* "$ROOT_DIR/"
chmod 777 "$ROOT_DIR/tmp"
cd "$ROOT_DIR"

sed -i "s#\$BASE_URI = ''#\$BASE_URI = '$URI'#g" ./include/config/config.inc.php
sed -i "s#\$API_BASE_URI = ''#\$API_BASE_URI = '$URI'#g" ./include/config/config.inc.php
sed -i "s#\$WWW_BASE_URI = ''#\$WWW_BASE_URI = '$URI'#g" ./include/config/config.inc.php

sed -i "s#\$AUTH_SALT = ''#\$AUTH_SALT = '$ZOTERO_AUTH_SALT'#g" ./include/config/config.inc.php
sed -i "s#\$API_SUPER_USERNAME = ''#\$API_SUPER_USERNAME = '$ZOTERO_API_SUPER_USERNAME'#g" ./include/config/config.inc.php
sed -i "s#\$API_SUPER_PASSWORD = ''#\$API_SUPER_PASSWORD = '$ZOTERO_API_SUPER_PASSWORD'#g" ./include/config/config.inc.php

sed -i "s#\$AWS_REGION = ''#\$AWS_REGION = '$AWS_DEFAULT_REGION'#g" ./include/config/config.inc.php
sed -i "s#\$AWS_ACCESS_KEY = ''#\$AWS_ACCESS_KEY = '$AWS_ACCESS_KEY_ID'#g" ./include/config/config.inc.php
sed -i "s#\$AWS_SECRET_KEY = ''#\$AWS_SECRET_KEY = '$AWS_SECRET_ACCESS_KEY'#g" ./include/config/config.inc.php

aws --endpoint-url "http://minio:9000" s3 mb s3://zotero
aws --endpoint-url "http://minio:9000" s3 mb s3://zotero-fulltext
aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero

# Start Apache2
exec apache2 -DNO_DETACH -k start
