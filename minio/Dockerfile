FROM minio/minio

COPY ./curl /usr/bin/
RUN \
chmod +x /usr/bin/curl && \
curl https://dl.min.io/server/minio/release/linux-amd64/minio --output /usr/bin/minio && \
chmod +x /usr/bin/minio
