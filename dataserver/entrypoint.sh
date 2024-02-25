#!/bin/sh

# Env vars
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOG_DIR=/var/log/apache2

ROOT_DIR=/var/www/zotero

cp -r -f /zotero/{.,}* "$ROOT_DIR/"

# Start log
# /etc/init.d/rsyslog start

# Start rinetd
/etc/init.d/rinetd start

# Chown
# chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/log/apache2

# Chmod
chmod 777 "$ROOT_DIR/tmp"

aws --endpoint-url "http://minio:9000" s3 mb s3://zotero && \
aws --endpoint-url "http://minio:9000" s3 mb s3://zotero-fulltext && \
aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero

# Start Apache2
exec apache2 -DNO_DETACH -k start
