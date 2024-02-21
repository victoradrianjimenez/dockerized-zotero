#!/bin/bash

git clone https://github.com/zotero/dataserver.git ./dataserver/dataserver
git clone https://github.com/zotero/stream-server.git ./stream-server/stream-server
git clone https://github.com/zotero/tinymce-clean-server.git ./tinymce-clean-server/tinymce-clean-server
git clone https://github.com/zendframework/zf1.git ./dataserver/zf1
mv -f ./dataserver/zf1/library/Zend/* ./dataserver/dataserver/include/Zend
rm -r -f ./dataserver/zf1
wget https://dl.min.io/server/minio/release/linux-amd64/minio -O ./minio/minio
