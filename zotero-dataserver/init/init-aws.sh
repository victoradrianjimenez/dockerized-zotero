#!/bin/sh

aws --endpoint-url "http://minio:9000" s3 mb s3://zotero
aws --endpoint-url "http://minio:9000" s3 mb s3://zotero-fulltext
aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero
