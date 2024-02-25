FROM node:20.11-alpine

RUN \
apk update && \
apk upgrade --no-cache && \
apk add --no-cache bash git git-lfs python3 rsync openssl perl zip curl p7zip binutils && \
apk add --no-cache --upgrade grep

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]

# More info: https://www.zotero.org/support/dev/client_coding/building_the_desktop_app