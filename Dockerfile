FROM alpine
LABEL org.opencontainers.image.title="Memgraph" \
    org.opencontainers.image.description="Docker Extension for Memgraph" \
    org.opencontainers.image.vendor="Docker" \
    com.docker.desktop.extension.api.version="0.3.0" \
    com.docker.extension.screenshots="" \
    com.docker.extension.detailed-description="" \
    com.docker.extension.publisher-url="" \
    com.docker.extension.additional-urls="" \
    com.docker.extension.changelog=""

COPY docker-compose.yaml .
COPY metadata.json .
COPY docker.svg .
COPY ui ui
