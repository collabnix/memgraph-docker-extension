FROM alpine
LABEL org.opencontainers.image.title="Memgraph" \
    org.opencontainers.image.description="Memgraph Extension for Docker Desktop" \
    org.opencontainers.image.vendor="Memgraph" \
    com.docker.desktop.extension.api.version="0.3.0" \
    com.docker.extension.screenshots="[ \
    {\"url\": \"https://raw.githubusercontent.com/memgraph/memgraph-docker-extension/main/memgraph-extension-screenshot-1.png\", \"alt\": \"Memgraph Platform\"}, \
    {\"url\": \"https://raw.githubusercontent.com/memgraph/memgraph-docker-extension/main/memgraph-extension-screenshot-2.png\", \"alt\": \"Memgraph Platform\"}, \
    {\"url\": \"https://raw.githubusercontent.com/memgraph/memgraph-docker-extension/main/memgraph-extension-screenshot-3.png\", \"alt\": \"Memgraph Platform\"} \
    ]" \
    com.docker.extension.categories="database" \
    com.docker.desktop.extension.icon="https://raw.githubusercontent.com/memgraph/memgraph-docker-extension/main/memgraph.svg" \
    com.docker.extension.detailed-description="Memgraph is a high-performance, in-memory graph database that provides fast and scalable data storage and querying capabilities for graph data. Memgraph is a streaming graph application platform that helps you wrangle your streaming data, build sophisticated models you can query in real-time, and develop applications you never thought possible within a couple of days, not months. With Memgraph Docker Extension, now you can setup Memgraph platform in no seconds." \
    com.docker.extension.publisher-url='[{"title":"GitHub", "url":"https://github.com/memgraph/memgraph-docker-extension/"}]' \
    com.docker.extension.additional-urls='[{"title":"GitHub","url":"https://github.com/memgraph/memgraph-docker-extension/"}]' \
    com.docker.extension.changelog="Updated Memgraph platform to version that uses Memgraph 2.8"

COPY docker-compose.yaml .
COPY metadata.json .
COPY docker.svg .
COPY memgraph.svg .
COPY ui ui
