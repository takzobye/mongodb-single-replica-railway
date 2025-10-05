FROM mongo:8

ENV KEYFILE_PATH=/data/keyfile

RUN mkdir -p /data && \
    openssl rand -base64 756 > $KEYFILE_PATH && \
    chown mongodb:mongodb $KEYFILE_PATH && \
    chmod 600 $KEYFILE_PATH

ENTRYPOINT ["docker-entrypoint.sh", "mongod", "--replSet", "rs0", "--auth", "--keyFile", "/data/keyfile", "--ipv6", "--bind_ip", "::,0.0.0.0", "--setParameter", "diagnosticDataCollectionEnabled=false"]
