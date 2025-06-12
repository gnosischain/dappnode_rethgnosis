ARG UPSTREAM_VERSION

FROM ghcr.io/gnosischain/reth_gnosis:${UPSTREAM_VERSION}

RUN apt update && apt install curl -y

COPY /security /security
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && apt install curl wget zstd -y

RUN chmod +rx /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]