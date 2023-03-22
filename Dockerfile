FROM golang:1.19-alpine AS builder
ENV CGO_ENABLED=0
WORKDIR /backend
COPY backend/go.* .
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download
COPY backend/. .
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go build -trimpath -ldflags="-s -w" -o bin/service

FROM --platform=$BUILDPLATFORM node:18.12-alpine3.16 AS client-builder
WORKDIR /ui
# cache packages in layer
COPY ui/package.json /ui/package.json
COPY ui/package-lock.json /ui/package-lock.json
RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci
# install
COPY ui /ui
RUN npm run build

FROM alpine
LABEL org.opencontainers.image.title="Memgraph" \
    org.opencontainers.image.description="Memgraph Extension for Docker Desktop" \
    org.opencontainers.image.vendor="Ajeet Singh Raina" \
    com.docker.desktop.extension.api.version="0.3.0" \
    com.docker.extension.screenshots="[ \
    {\"url\": \"https://raw.githubusercontent.com/collabnix/memgraph-docker-extension/main/memgraph.png\", \"alt\": \"Screenshot\"} \
    ]" \
    com.docker.extension.categories="Databases" \
    com.docker.desktop.extension.icon="https://raw.githubusercontent.com/collabnix/memgraph-docker-extension/main/memgraph.svg" \
    com.docker.extension.detailed-description="Memgraph is a high-performance, in-memory graph database that provides fast and scalable data storage and querying capabilities for graph data. Memgraph is a streaming graph application platform that helps you wrangle your streaming data, build sophisticated models you can query in real-time, and develop applications you never thought possible within a couple of days, not months. With Memgraph Docker Extension, now you can setup Memgraph platform in no seconds." \
    com.docker.extension.publisher-url='[{"title":"GitHub", "url":"https://github.com/collabnix/memgraph-docker-extension/"}]' \
    com.docker.extension.additional-urls='[{"title":"GitHub","url":"https://https://github.com/collabnix/memgraph-docker-extension/"}]' \
    com.docker.extension.changelog=""



COPY --from=builder /backend/bin/service /
COPY docker-compose.yaml .
COPY metadata.json .
COPY docker.svg .
COPY memgraph.svg .
COPY --from=client-builder /ui/build ui
CMD /service -socket /run/guest-services/backend.sock
