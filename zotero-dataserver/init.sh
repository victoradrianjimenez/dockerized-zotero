#!/bin/bash

git clone https://github.com/zotero/dataserver.git
git clone https://github.com/zotero/stream-server.git ./stream-server/stream-server
git clone https://github.com/zotero/tinymce-clean-server.git
git clone https://github.com/zendframework/zf1.git
mv -f ./zf1/library/Zend/* ./dataserver/include/Zend
rm -r -f ./zf1
wget https://dl.min.io/server/minio/release/linux-amd64/minio -O minio/minio
