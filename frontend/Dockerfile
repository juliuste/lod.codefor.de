FROM ghcr.io/zazuko/trifid:v5.0.6@sha256:a2f80a09696dba27b4b21fe581c9593ebf5f723ec091e3d3b237dc431b5a66ca

COPY --chown=1000:1000 labelLoader.js /app/packages/entity-renderer/renderer/labels/labelLoader.js

ENV TRIFID_CONFIG="/app/custom/config/config.yaml"
ENV SPARQL_ENDPOINT_URL="http://host.docker.internal:3000/dataset/sparql"
ENV SPARQL_PROXY_CACHE_PREFIX="default"
ENV SPARQL_PROXY_CACHE_CLEAR_AT_STARTUP="false"
ENV DATASET_BASE_URL="https://lod.codefor.de/"

COPY --chown=1000:1000 config /app/custom/config
COPY --chown=1000:1000 config/favicon.ico /app/packages/core/static/favicon.ico
