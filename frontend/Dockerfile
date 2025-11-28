FROM ghcr.io/zazuko/trifid:v5.2.0@sha256:671049552af2d14818e9c34f4ab1b03ac1797ee3dc5706db906c36223c6c16de

COPY --chown=1000:1000 labelLoader.js /app/packages/entity-renderer/renderer/labels/labelLoader.js

ENV TRIFID_CONFIG="/app/custom/config/config.yaml"
ENV SPARQL_ENDPOINT_URL="http://host.docker.internal:3000/dataset/sparql"
ENV SPARQL_PROXY_CACHE_PREFIX="default"
ENV SPARQL_PROXY_CACHE_CLEAR_AT_STARTUP="false"
ENV DATASET_BASE_URL="https://lod.codefor.de/"

COPY --chown=1000:1000 config /app/custom/config
COPY --chown=1000:1000 config/favicon.ico /app/packages/core/static/favicon.ico
